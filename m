Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61153CCAEB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfJEPwh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPwh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:52:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 345002133F;
        Sat,  5 Oct 2019 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570290755;
        bh=/g8fhgJQmax4u5b7N1Sd3foyk4jTb/pa5bVe9a4L8fc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZwckkVtrM1iPrdXbXj2io0vKM+u0cucQoNdEF8R9AwvyD9eH9TgBZ6NNZqRNasKZj
         aB+/XupI6mgJfgYqtQHRGwQopioNZzD4pBfunDjbhz5GuNqyY9pYpCyQjmBssRY5sT
         DxKSSrmKuJ9rkwsl1iU53POGiXOz9SqY33gaiwok=
Date:   Sat, 5 Oct 2019 16:52:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Enrico Granata <egranata@chromium.org>
Subject: Re: [PATCH 06/13] platform: chrome: cros_ec: handle MKBP more
 events flag
Message-ID: <20191005165229.5f1cbd7e@archlinux>
In-Reply-To: <20190922175021.53449-7-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-7-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:14 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> From: Enrico Granata <egranata@chromium.org>
> 
> The ChromeOS EC has support for signaling to the host that
> a single IRQ can serve multiple MKBP events.

Be nice to those of us who don't know the system that well.
What are MKBP events?

> 
> Doing this serves an optimization purpose, as it minimizes the
> number of round-trips into the interrupt handling machinery, and
> it proves beneficial to sensor timestamping as it keeps the desired
> synchronization of event times between the two processors.
> 
> This patch adds kernel support for this EC feature, allowing the
> ec_irq to loop until all events have been served.
> 
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Minor comments inline.

> ---
>  drivers/platform/chrome/cros_ec.c           | 33 +++++++++----
>  drivers/platform/chrome/cros_ec_proto.c     | 51 ++++++++++++---------
>  include/linux/platform_data/cros_ec_proto.h |  7 ++-
>  3 files changed, 57 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 9c8dc7cdb2b7..4adc007c357c 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -46,25 +46,38 @@ static irqreturn_t ec_irq_handler(int irq, void *data)
>  	return IRQ_WAKE_THREAD;
>  }
>  
> -static irqreturn_t ec_irq_thread(int irq, void *data)
> +static bool ec_handle_event(struct cros_ec_device *ec_dev)
>  {
> -	struct cros_ec_device *ec_dev = data;
>  	bool wake_event = true;
> -	int ret;
> +	bool ec_has_more_events = false;
> +	int ret = cros_ec_get_next_event(ec_dev, &wake_event);
>  
> -	ret = cros_ec_get_next_event(ec_dev, &wake_event);

Moving definition of int to this line just added noise to the
patch.  I would leave that as it was to make reviewers life
ever so slightly simpler ;)

> +	if (ec_dev->mkbp_event_supported) {
> +		ec_has_more_events = (ret > 0) &&
> +			(ec_dev->event_data.event_type &
> +				EC_MKBP_HAS_MORE_EVENTS);
> +	}
>  
> -	/*
> -	 * Signal only if wake host events or any interrupt if
> -	 * cros_ec_get_next_event() returned an error (default value for
> -	 * wake_event is true)
> -	 */
> -	if (wake_event && device_may_wakeup(ec_dev->dev))
> +	if (device_may_wakeup(ec_dev->dev) && wake_event)
>  		pm_wakeup_event(ec_dev->dev, 0);
>  
>  	if (ret > 0)
>  		blocking_notifier_call_chain(&ec_dev->event_notifier,
>  					     0, ec_dev);
> +
> +	return ec_has_more_events;
> +

Drop this blank line.

> +}
> +
> +static irqreturn_t ec_irq_thread(int irq, void *data)
> +{
> +	struct cros_ec_device *ec_dev = data;
> +	bool ec_has_more_events;
> +
> +	do {
> +		ec_has_more_events = ec_handle_event(ec_dev);
> +	} while (ec_has_more_events);
> +
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index f659f96bda12..70e6d6c93b8d 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -425,10 +425,14 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  	ret = cros_ec_get_host_command_version_mask(ec_dev,
>  						    EC_CMD_GET_NEXT_EVENT,
>  						    &ver_mask);
> -	if (ret < 0 || ver_mask == 0)
> +	if (ret < 0 || ver_mask == 0) {
>  		ec_dev->mkbp_event_supported = 0;
> -	else
> -		ec_dev->mkbp_event_supported = 1;
> +		dev_info(ec_dev->dev, "MKBP not supported\n");
> +	} else {
> +		ec_dev->mkbp_event_supported = fls(ver_mask);
> +		dev_info(ec_dev->dev, "MKBP support version %u\n",
> +			ec_dev->mkbp_event_supported - 1);

dev_dbg perhaps?

> +	}
>  
>  	/* Probe if host sleep v1 is supported for S0ix failure detection. */
>  	ret = cros_ec_get_host_command_version_mask(ec_dev,
> @@ -519,6 +523,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
>  
>  static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>  			       struct cros_ec_command *msg,
> +			       struct ec_response_get_next_event_v1 *event,
>  			       int version, uint32_t size)
>  {
>  	int ret;
> @@ -531,7 +536,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>  	ret = cros_ec_cmd_xfer(ec_dev, msg);
>  	if (ret > 0) {
>  		ec_dev->event_size = ret - 1;
> -		memcpy(&ec_dev->event_data, msg->data, ret);
> +		ec_dev->event_data = *event;
>  	}
>  
>  	return ret;
> @@ -539,30 +544,29 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>  
>  static int get_next_event(struct cros_ec_device *ec_dev)
>  {
> -	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
> -	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
> -	static int cmd_version = 1;
> -	int ret;
> +	struct {
> +		struct cros_ec_command msg;
> +		struct ec_response_get_next_event_v1 event;
> +	} __packed buf;

Nice tidy up, but I don't think directly relevant to what this patch is doing..
I think that should be a precursor patch.

> +	struct cros_ec_command *msg = &buf.msg;
> +	struct ec_response_get_next_event_v1 *event = &buf.event;
> +	const int cmd_version = ec_dev->mkbp_event_supported - 1;
> +
> +	BUILD_BUG_ON(sizeof(union ec_response_get_next_data_v1) != 16);
> +
> +	memset(&buf, 0, sizeof(buf));
>  
>  	if (ec_dev->suspended) {
>  		dev_dbg(ec_dev->dev, "Device suspended.\n");
>  		return -EHOSTDOWN;
>  	}
>  
> -	if (cmd_version == 1) {
> -		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> -				sizeof(struct ec_response_get_next_event_v1));
> -		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
> -			return ret;
> -
> -		/* Fallback to version 0 for future send attempts */
> -		cmd_version = 0;
> -	}
> -
> -	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
> +	if (cmd_version == 0)
> +		return get_next_event_xfer(ec_dev, msg, event, 0,
>  				  sizeof(struct ec_response_get_next_event));
>  
> -	return ret;
> +	return get_next_event_xfer(ec_dev, msg, event, cmd_version,
> +				sizeof(struct ec_response_get_next_event_v1));
>  }
>  
>  static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
> @@ -606,7 +610,8 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
>  		return ret;
>  
>  	if (wake_event) {
> -		event_type = ec_dev->event_data.event_type;
> +		event_type =
> +			ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
>  		host_event = cros_ec_get_host_event(ec_dev);
>  
>  		/*
> @@ -631,10 +636,12 @@ EXPORT_SYMBOL(cros_ec_get_next_event);
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
>  {
>  	u32 host_event;
> +	const u8 event_type =
> +		ec_dev->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
>  
>  	BUG_ON(!ec_dev->mkbp_event_supported);
>  
> -	if (ec_dev->event_data.event_type != EC_MKBP_EVENT_HOST_EVENT)
> +	if (event_type != EC_MKBP_EVENT_HOST_EVENT)
>  		return 0;
>  
>  	if (ec_dev->event_size != sizeof(host_event)) {
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index ab12e28f2107..63b5597294e7 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -115,7 +115,9 @@ struct cros_ec_command {
>   *            code.
>   * @pkt_xfer: Send packet to EC and get response.
>   * @lock: One transaction at a time.
> - * @mkbp_event_supported: True if this EC supports the MKBP event protocol.
> + * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
> + *                        the maximum supported version of the MKBP host event
> + *                        command + 1.
>   * @host_sleep_v1: True if this EC supports the sleep v1 command.
>   * @event_notifier: Interrupt event notifier for transport devices.
>   * @event_data: Raw payload transferred with the MKBP event.
> @@ -155,7 +157,8 @@ struct cros_ec_device {
>  	int (*pkt_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);
>  	struct mutex lock;
> -	bool mkbp_event_supported;
> +	/* 0 == not supported, otherwise it supports version x - 1 */
> +	u8 mkbp_event_supported;
>  	bool host_sleep_v1;
>  	struct blocking_notifier_head event_notifier;
>  

