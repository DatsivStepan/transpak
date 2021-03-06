<?php
class ControllerModuleSlideshow extends Controller {
	public function index($setting) {
		static $module = 0;

		$this->load->model('design/banner');
		$this->load->model('tool/image');

		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

        $data['home'] = $this->url->link('common/home');
        $data['is_home'] = '';
        if(!isset($this->request->get['route'])){
            $data['is_home'] = 'home';
        }elseif($this->request->get['route'] == 'common/home'){
            $data['is_home'] = 'home';

        }
        if (isset($this->request->get['route'])) {
            if(!isset($this->request->get['route'])){
                $data['is_home'] = 'home';
            }elseif($this->request->get['route'] == 'common/home'){
                $data['is_home'] = 'home';
            }
        }
		$data['banners'] = array();

		$results = $this->model_design_banner->getBanner($setting['banner_id']);

		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$data['banners'][] = array(
					'title' => $result['title'],
					'link'  => $result['link'],
					'image' => 'image/'.$result['image']
				);
			}
		}

		$data['module'] = $module++;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/slideshow.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/slideshow.tpl', $data);
		} else {
			return $this->load->view('default/template/module/slideshow.tpl', $data);
		}
	}
}
