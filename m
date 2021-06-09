Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC513A1B4D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFIQzN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 12:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhFIQzM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 12:55:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9602E613C0;
        Wed,  9 Jun 2021 16:53:12 +0000 (UTC)
Date:   Wed, 9 Jun 2021 17:55:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v11 23/33] counter: Update counter.h comments to reflect
 sysfs internalization
Message-ID: <20210609175505.5bca286d@jic23-huawei>
In-Reply-To: <ae1707aec1f9d647f88a6c5159ed83009289fcc1.1623201082.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
        <ae1707aec1f9d647f88a6c5159ed83009289fcc1.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  9 Jun 2021 10:31:26 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The Counter subsystem architecture and driver implementations have
> changed in order to handle Counter sysfs interactions in a more
> consistent way. This patch updates the Generic Counter interface
> header file comments to reflect the changes.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

I'd rather see anything in here that isn't just tidy up moved back to the
earlier patches.

> ---
>  drivers/counter/counter-core.c |  3 ++
>  include/linux/counter.h        | 72 +++++++++++++++-------------------
>  2 files changed, 35 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index e7dd6ea01c8a..407661c6feb0 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -41,6 +41,9 @@ static struct bus_type counter_bus_type = {
>   * This function registers a Counter to the system. A sysfs "counter" directory
>   * will be created and populated with sysfs attributes correlating with the
>   * Counter Signals, Synapses, and Counts respectively.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
>   */
>  int counter_register(struct counter_device *const counter)
>  {
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 567471818ec3..e7fd6d81a929 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -188,12 +188,10 @@ struct counter_comp {
>  
>  /**
>   * struct counter_signal - Counter Signal node
> - * @id:		unique ID used to identify signal
> - * @name:	device-specific Signal name; ideally, this should match the name
> - *		as it appears in the datasheet documentation
> - * @ext:	optional array of Counter Signal extensions
> - * @num_ext:	number of Counter Signal extensions specified in @ext
> - * @priv:	optional private data supplied by driver
> + * @id:		unique ID used to identify the Signal
> + * @name:	device-specific Signal name
> + * @ext:	optional array of Signal extensions
> + * @num_ext:	number of Signal extensions specified in @ext

I'm not keen on having a stage between patches where there
area things documented that don't exist. (e.g. priv)

>   */
>  struct counter_signal {
>  	int id;
> @@ -207,7 +205,7 @@ struct counter_signal {
>   * struct counter_synapse - Counter Synapse node
>   * @actions_list:	array of available action modes
>   * @num_actions:	number of action modes specified in @actions_list
> - * @signal:		pointer to associated signal
> + * @signal:		pointer to the associated Signal
>   */
>  struct counter_synapse {
>  	const enum counter_synapse_action *actions_list;
> @@ -218,17 +216,14 @@ struct counter_synapse {
>  
>  /**
>   * struct counter_count - Counter Count node
> - * @id:			unique ID used to identify Count
> - * @name:		device-specific Count name; ideally, this should match
> - *			the name as it appears in the datasheet documentation
> - * @function:		index of current function mode
> - * @functions_list:	array available function modes
> + * @id:			unique ID used to identify the Count
> + * @name:		device-specific Count name
> + * @functions_list:	array of available function modes
>   * @num_functions:	number of function modes specified in @functions_list
> - * @synapses:		array of synapses for initialization
> - * @num_synapses:	number of synapses specified in @synapses
> - * @ext:		optional array of Counter Count extensions
> - * @num_ext:		number of Counter Count extensions specified in @ext
> - * @priv:		optional private data supplied by driver
> + * @synapses:		array of Synapses for initialization
> + * @num_synapses:	number of Synapses specified in @synapses
> + * @ext:		optional array of Count extensions
> + * @num_ext:		number of Count extensions specified in @ext
>   */
>  struct counter_count {
>  	int id;
> @@ -246,29 +241,26 @@ struct counter_count {
>  
>  /**
>   * struct counter_ops - Callbacks from driver
> - * @signal_read:	optional read callback for Signal attribute. The read
> - *			level of the respective Signal should be passed back via
> - *			the level parameter.
> - * @count_read:		optional read callback for Count attribute. The read
> - *			value of the respective Count should be passed back via
> - *			the val parameter.
> - * @count_write:	optional write callback for Count attribute. The write
> - *			value for the respective Count is passed in via the val
> + * @signal_read:	read callback for Signals. The read level of the
> + *			respective Signal should be passed back via the level
> + *			parameter.
> + * @count_read:		read callback for Counts. The read value of the
> + *			respective Count should be passed back via the value
>   *			parameter.
> - * @function_get:	function to get the current count function mode. Returns
> - *			0 on success and negative error code on error. The index
> - *			of the respective Count's returned function mode should
> - *			be passed back via the function parameter.
> - * @function_set:	function to set the count function mode. function is the
> - *			index of the requested function mode from the respective
> - *			Count's functions_list array.
> - * @action_get:		function to get the current action mode. Returns 0 on
> - *			success and negative error code on error. The index of
> - *			the respective Synapse's returned action mode should be
> - *			passed back via the action parameter.
> - * @action_set:		function to set the action mode. action is the index of
> - *			the requested action mode from the respective Synapse's
> - *			actions_list array.
> + * @count_write:	write callback for Counts. The write value for the
> + *			respective Count is passed in via the value parameter.
> + * @function_read:	read callback the Count function modes. The read
> + *			function mode of the respective Count should be passed
> + *			back via the function parameter.
> + * @function_write:	write callback for Count function modes. The function
> + *			mode to write for the respective Count is passed in via
> + *			the function parameter.
> + * @action_read:	read callback the Synapse action modes. The read action
> + *			mode of the respective Synapse should be passed back via
> + *			the action parameter.
> + * @action_write:	write callback for Synapse action modes. The action mode
> + *			to write for the respective Synapse is passed in via the
> + *			action parameter.
>   */
>  struct counter_ops {
>  	int (*signal_read)(struct counter_device *counter,
> @@ -296,7 +288,7 @@ struct counter_ops {
>  
>  /**
>   * struct counter_device - Counter data structure
> - * @name:		name of the device as it appears in the datasheet
> + * @name:		name of the device
>   * @parent:		optional parent device providing the counters
>   * @ops:		callbacks from driver
>   * @signals:		array of Signals

