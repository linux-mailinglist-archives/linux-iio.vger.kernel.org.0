Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6204ACCAE3
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfJEPoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPoM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:44:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 035CD20862;
        Sat,  5 Oct 2019 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570290251;
        bh=MfBPE9ggoRo+pXT+Cqd2AsQZxCxS2f7fC3BRFg5lNHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KmECbQL+Bz4niLvLUr1kf/5KgHDoZ9GM38/KcddI+5smhwqvmMv5jBV/LMSxeFdh1
         hZt/LFskku2dCrzChZfSiNEGOmOSkThsvKul0JyRn06UDl3xIlZdcr9YEunH+HijfH
         NbUXhRWhZgrcNvXxZ/+hmeDJ/UgwGITl2myv7zUs=
Date:   Sat, 5 Oct 2019 16:44:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/13] platform: chrome: cros-ec: record event timestamp
 in the hard irq
Message-ID: <20191005164405.7e86362f@archlinux>
In-Reply-To: <20190922175021.53449-5-gwendal@chromium.org>
References: <20190922175021.53449-1-gwendal@chromium.org>
        <20190922175021.53449-5-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Sep 2019 10:50:12 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> To improve sensor timestamp precision, given EC and AP are in
> different time domains, the AP needs to try to record the exact
> moment an event was signalled to the AP by the EC as soon as
> possible after it happens.
> 
> First thing in the hard irq is the best place for this.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
If this is only going to be used in IIO paths, the there is a control
to set which clock is used.  This is really a legacy thing due to
me once picking a silly default, but we may be causing confusion by
having that control but it having no effect.

Otherwise looks good to me.

> ---
>  drivers/platform/chrome/cros_ec.c           | 18 +++++++++++++++++-
>  drivers/platform/chrome/cros_ec_lpc.c       |  2 ++
>  include/linux/platform_data/cros_ec_proto.h | 15 +++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index fd77e6fa74c2..f49eb1d1e3cd 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -31,6 +31,21 @@ static struct cros_ec_platform pd_p = {
>  	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
>  };
>  
> +s64 cros_ec_get_time_ns(void)
> +{
> +	return ktime_get_boottime_ns();
> +}
> +EXPORT_SYMBOL(cros_ec_get_time_ns);
> +
> +static irqreturn_t ec_irq_handler(int irq, void *data)
> +{
> +	struct cros_ec_device *ec_dev = data;
> +
> +	ec_dev->last_event_time = cros_ec_get_time_ns();
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
>  static irqreturn_t ec_irq_thread(int irq, void *data)
>  {
>  	struct cros_ec_device *ec_dev = data;
> @@ -132,7 +147,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>  	}
>  
>  	if (ec_dev->irq) {
> -		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
> +		err = devm_request_threaded_irq(
> +				dev, ec_dev->irq, ec_irq_handler,
>  				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  				"chromeos-ec", ec_dev);
>  		if (err) {
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 7d10d909435f..3c77496e164d 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -313,6 +313,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
>  {
>  	struct cros_ec_device *ec_dev = data;
>  
> +	ec_dev->last_event_time = cros_ec_get_time_ns();
> +
>  	if (ec_dev->mkbp_event_supported &&
>  	    cros_ec_get_next_event(ec_dev, NULL) > 0)
>  		blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index e91e3fcb0348..ab12e28f2107 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -121,6 +121,8 @@ struct cros_ec_command {
>   * @event_data: Raw payload transferred with the MKBP event.
>   * @event_size: Size in bytes of the event data.
>   * @host_event_wake_mask: Mask of host events that cause wake from suspend.
> + * @last_event_time: exact time from the hard irq when we got notified of
> + *     a new event.
>   * @ec: The platform_device used by the mfd driver to interface with the
>   *      main EC.
>   * @pd: The platform_device used by the mfd driver to interface with the
> @@ -161,6 +163,7 @@ struct cros_ec_device {
>  	int event_size;
>  	u32 host_event_wake_mask;
>  	u32 last_resume_result;
> +	s64 last_event_time;
>  
>  	/* The platform devices used by the mfd driver */
>  	struct platform_device *ec;
> @@ -308,4 +311,16 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
>   */
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>  
> +/**
> + * cros_ec_get_time_ns - Return time in ns.
> + *
> + * This is the function used to record the time for last_event_time in struct
> + * cros_ec_device during the hard irq.
> + *
> + * This function is probably implemented using ktime_get_boot_ns(), but it's
> + * exposed here to make sure all cros_ec drivers use the same code path to get
> + * the time.
> + */
> +s64 cros_ec_get_time_ns(void);
> +
>  #endif /* __LINUX_CROS_EC_PROTO_H */

