Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400D8C3177
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2019 12:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfJAKcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Oct 2019 06:32:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38768 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJAKcO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2019 06:32:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 03D8C28E304
Subject: Re: [PATCH 04/13] platform: chrome: cros-ec: record event timestamp
 in the hard irq
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, bleung@chromium.org, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20190922175021.53449-1-gwendal@chromium.org>
 <20190922175021.53449-5-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <0956b6a6-44ea-8e91-b047-68a021b45c39@collabora.com>
Date:   Tue, 1 Oct 2019 12:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190922175021.53449-5-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Some comments below.

On 22/9/19 19:50, Gwendal Grignou wrote:
> To improve sensor timestamp precision, given EC and AP are in
> different time domains, the AP needs to try to record the exact
> moment an event was signalled to the AP by the EC as soon as
> possible after it happens.
> 
> First thing in the hard irq is the best place for this.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
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

That's a simple wrapper only to make sure all cros_ec drivers use the same code
path, right? So maybe instead of doing this we can just add an inline function
in the header like this

/**
 * cros_ec_get_time_ns - Get time since boot including time spend in suspend
 *
 * Return: ktime_t format since boot.
 */
static inline ktime_t cros_ec_get_time_ns(void)
{
	return ktime_get_boottime_ns();
}

I'd use ktime_t instead of s64 also.

Thanks,
 Enric

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
> 
