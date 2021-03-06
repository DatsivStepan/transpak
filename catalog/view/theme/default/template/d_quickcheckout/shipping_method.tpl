<!-- 
	Ajax Quick Checkout 
	v6.0.0
	Dreamvention.com 
	d_quickcheckout/shipping_method.tpl 
-->

<script type="text/html" id="shipping_method_template">
<form id="shipping_method_form" <%= parseInt(model.config.display) && model.show_shipping_method ? '' : 'class="hidden"' %>>
	<% if (model.shipping_methods) { %>
		<div class="panel panel-default qc_image32">
			<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 no-padding pad_pay_metod">
			<div class="panel-body no_pad_opl" style="padding-top: 0; padding-bottom: 0%">
				<% if(model.error){ %>
					<div class="alert alert-danger">
						<i class="fa fa-exclamation-circle"></i> <%= model.error %>
					</div>
				<% } %>
				<% if (model.config.description) { %> 
					<p class="description text1"><%= model.config.description %></p>
				<% } %>
				<div id="shipping_method_list">
					

						<% if(model.config.input_style == 'select') { %>
							<div class="select-input form-group">
								<select name="shipping_method" class="form-control shipping-method-select" data-refresh="5" >
								<% _.each(model.shipping_methods, function(shipping_method) { %>
									<% if (parseInt(model.config.display_title)) { %> 
										<optgroup label="<%= shipping_method.title %>">
									<% } %>
									<% _.each(shipping_method.quote, function(quote) { %>
										<% if (quote.code == model.shipping_method.code) { %>
											<option  value="<%= quote.code %>" id="<%= quote.code %>" selected="selected" ><%= quote.title %> <span class="price"><%= quote.text %></span></option>
										<% } else { %>
											<option  value="<%= quote.code %>" id="<%= quote.code %>" ><%= quote.title %> <span class="price"><%= quote.text %></span></option>
										<% } %>
									<% }) %>
									<% if (parseInt(model.config.display_title)) { %> 
										</optgroup>
									<% } %>
								<% }) %>
								</select>
							</div>


						<% }else{ %>
							<% _.each(model.shipping_methods, function(shipping_method) { %>
								<% if (parseInt(model.config.display_title)) { %> 
									<strong class="title"><%= shipping_method.title %></strong>
								<% } %>

								<% if (!shipping_method.error) { %>
									<% _.each(shipping_method.quote, function(quote) { %>
									  <div class="radio-input radio">
									    <label for="<%= quote.code %>">
									    <% if (quote.code == model.shipping_method.code) { %>
									      <input type="radio" name="shipping_method" value="<%= quote.code %>" id="<%= quote.code %>" checked="checked" data-refresh="5" class="styled"/> 
									    <% } else { %>
									      <input type="radio" name="shipping_method" value="<%= quote.code %>" id="<%= quote.code %>" data-refresh="5" class="styled"/> 
									    <% } %>
									    <span class="text"><%= quote.title %></span><span class="price"><%= quote.text %></span></label>
									  </div>
									<% }) %>
								<% } else { %>
									<div class="error alert alert-error"><%= shipping_method.error %></div>
								<% } %>
							<% }) %>
						<% } %>
					
				</div>
			</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-3">
			</div>
		</div>
	<% } %>
</form>
</script>
<script>
$(function() {
	qc.shippingMethod = $.extend(true, {}, new qc.ShippingMethod(<?php echo $json; ?>));
	qc.shippingMethodView = $.extend(true, {}, new qc.ShippingMethodView({
		el:$("#shipping_method"), 
		model: qc.shippingMethod, 
		template: _.template($("#shipping_method_template").html())
	}));
});
</script>