Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D06403E73
	for <lists+linux-iio@lfdr.de>; Wed,  8 Sep 2021 19:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhIHRoj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 13:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhIHRog (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Sep 2021 13:44:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5B861131;
        Wed,  8 Sep 2021 17:43:22 +0000 (UTC)
Date:   Wed, 8 Sep 2021 18:46:48 +0100
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
Subject: Re: [PATCH v16 04/14] counter: Update counter.h comments to reflect
 sysfs internalization
Message-ID: <20210908184648.68aabb9d@jic23-huawei>
In-Reply-To: <19da8ae0c05381b0967c8a334b67f86b814eb880.1630031207.git.vilhelm.gray@gmail.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
        <19da8ae0c05381b0967c8a334b67f86b814eb880.1630031207.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Aug 2021 12:47:48 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The Counter subsystem architecture and driver implementations have
> changed in order to handle Counter sysfs interactions in a more
> consistent way. This patch updates the Generic Counter interface
> header file comments to reflect the changes.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>f
Applied

> ---
>  drivers/counter/counter-core.c |  3 ++
>  include/linux/counter.h        | 62 ++++++++++++++++------------------
>  2 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index c533a6ff12cf..3cda2c47bacb 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -38,6 +38,9 @@ static struct bus_type counter_bus_type = {
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
> index b69277f5c4c5..445f22d8bfe2 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -188,11 +188,10 @@ struct counter_comp {
>  
>  /**
>   * struct counter_signal - Counter Signal node
> - * @id:		unique ID used to identify signal
> - * @name:	device-specific Signal name; ideally, this should match the name
> - *		as it appears in the datasheet documentation
> - * @ext:	optional array of Counter Signal extensions
> - * @num_ext:	number of Counter Signal extensions specified in @ext
> + * @id:		unique ID used to identify the Signal
> + * @name:	device-specific Signal name
> + * @ext:	optional array of Signal extensions
> + * @num_ext:	number of Signal extensions specified in @ext
>   */
>  struct counter_signal {
>  	int id;
> @@ -206,7 +205,7 @@ struct counter_signal {
>   * struct counter_synapse - Counter Synapse node
>   * @actions_list:	array of available action modes
>   * @num_actions:	number of action modes specified in @actions_list
> - * @signal:		pointer to associated signal
> + * @signal:		pointer to the associated Signal
>   */
>  struct counter_synapse {
>  	const enum counter_synapse_action *actions_list;
> @@ -217,15 +216,14 @@ struct counter_synapse {
>  
>  /**
>   * struct counter_count - Counter Count node
> - * @id:			unique ID used to identify Count
> - * @name:		device-specific Count name; ideally, this should match
> - *			the name as it appears in the datasheet documentation
> - * @functions_list:	array available function modes
> + * @id:			unique ID used to identify the Count
> + * @name:		device-specific Count name
> + * @functions_list:	array of available function modes
>   * @num_functions:	number of function modes specified in @functions_list
> - * @synapses:		array of synapses for initialization
> - * @num_synapses:	number of synapses specified in @synapses
> - * @ext:		optional array of Counter Count extensions
> - * @num_ext:		number of Counter Count extensions specified in @ext
> + * @synapses:		array of Synapses for initialization
> + * @num_synapses:	number of Synapses specified in @synapses
> + * @ext:		optional array of Count extensions
> + * @num_ext:		number of Count extensions specified in @ext
>   */
>  struct counter_count {
>  	int id;
> @@ -243,27 +241,27 @@ struct counter_count {
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
> + * @signal_read:	optional read callback for Signals. The read level of
> + *			the respective Signal should be passed back via the
> + *			level parameter.
> + * @count_read:		read callback for Counts. The read value of the
> + *			respective Count should be passed back via the value
> + *			parameter.
> + * @count_write:	optional write callback for Counts. The write value for
> + *			the respective Count is passed in via the value
>   *			parameter.
>   * @function_read:	read callback the Count function modes. The read
>   *			function mode of the respective Count should be passed
>   *			back via the function parameter.
> - * @function_write:	write callback for Count function modes. The function
> - *			mode to write for the respective Count is passed in via
> - *			the function parameter.
> - * @action_read:	read callback the Synapse action modes. The read action
> - *			mode of the respective Synapse should be passed back via
> - *			the action parameter.
> - * @action_write:	write callback for Synapse action modes. The action mode
> - *			to write for the respective Synapse is passed in via the
> - *			action parameter.
> + * @function_write:	optional write callback for Count function modes. The
> + *			function mode to write for the respective Count is
> + *			passed in via the function parameter.
> + * @action_read:	optional read callback the Synapse action modes. The
> + *			read action mode of the respective Synapse should be
> + *			passed back via the action parameter.
> + * @action_write:	optional write callback for Synapse action modes. The
> + *			action mode to write for the respective Synapse is
> + *			passed in via the action parameter.
>   */
>  struct counter_ops {
>  	int (*signal_read)(struct counter_device *counter,
> @@ -291,7 +289,7 @@ struct counter_ops {
>  
>  /**
>   * struct counter_device - Counter data structure
> - * @name:		name of the device as it appears in the datasheet
> + * @name:		name of the device
>   * @parent:		optional parent device providing the counters
>   * @ops:		callbacks from driver
>   * @signals:		array of Signals

