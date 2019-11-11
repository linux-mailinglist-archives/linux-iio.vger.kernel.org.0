Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1CF70AA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 10:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfKKJ1N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 04:27:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKJ1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 04:27:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5EC8E283C86
Subject: Re: [PATCH v4 04/17] platform: chrome: cros-ec: record event
 timestamp in the hard irq
To:     Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-5-gwendal@chromium.org>
 <20191110121608.330bc0f7@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <de768b67-406c-9862-2550-7af8cbd7355f@collabora.com>
Date:   Mon, 11 Nov 2019 10:27:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191110121608.330bc0f7@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/11/19 13:16, Jonathan Cameron wrote:
> On Tue,  5 Nov 2019 14:26:39 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
>> To improve sensor timestamp precision, given EC and AP are in
>> different time domains, the AP needs to try to record the exact
>> moment an event was signalled to the AP by the EC as soon as
>> possible after it happens.
>>
>> First thing in the hard irq is the best place for this.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> A minor issue with kernel-doc (I think...)
> 
> Otherwise,
> Acked-by: Jonathan Cameron <Jonathan.Cameron@kernel.org>

With the Jonathan's comment solved.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

>> ---
>> Changes in v4:
>>   Check patch with --strict option
>>     Alignement
>> No changes in v3.
>> Changes in v2:
>>   Make cros_ec_get_time_ns inline.
>>   Using ktime_t instead of s64 when dealing with time.
>>   Added code in ishtp to gather timestamp.
>>
>>  drivers/platform/chrome/cros_ec.c           | 17 ++++++++++++++---
>>  drivers/platform/chrome/cros_ec_ishtp.c     | 17 +++++++++++++++--
>>  drivers/platform/chrome/cros_ec_lpc.c       |  2 ++
>>  include/linux/platform_data/cros_ec_proto.h | 16 ++++++++++++++++
>>  4 files changed, 47 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
>> index 9b2d07422e17..925f84dbf621 100644
>> --- a/drivers/platform/chrome/cros_ec.c
>> +++ b/drivers/platform/chrome/cros_ec.c
>> @@ -31,6 +31,15 @@ static struct cros_ec_platform pd_p = {
>>  	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
>>  };
>>  
>> +static irqreturn_t ec_irq_handler(int irq, void *data)
>> +{
>> +	struct cros_ec_device *ec_dev = data;
>> +
>> +	ec_dev->last_event_time = cros_ec_get_time_ns();
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>>  static irqreturn_t ec_irq_thread(int irq, void *data)
>>  {
>>  	struct cros_ec_device *ec_dev = data;
>> @@ -141,9 +150,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>  	}
>>  
>>  	if (ec_dev->irq) {
>> -		err = devm_request_threaded_irq(dev, ec_dev->irq, NULL,
>> -				ec_irq_thread, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> -				"chromeos-ec", ec_dev);
>> +		err = devm_request_threaded_irq(dev, ec_dev->irq,
>> +						ec_irq_handler,
>> +						ec_irq_thread,
>> +						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>> +						"chromeos-ec", ec_dev);
>>  		if (err) {
>>  			dev_err(dev, "Failed to request IRQ %d: %d",
>>  				ec_dev->irq, err);
>> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
>> index 25ca2c894b4d..5c848f22b44b 100644
>> --- a/drivers/platform/chrome/cros_ec_ishtp.c
>> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
>> @@ -200,13 +200,14 @@ static int ish_send(struct ishtp_cl_data *client_data,
>>   * process_recv() - Received and parse incoming packet
>>   * @cros_ish_cl: Client instance to get stats
>>   * @rb_in_proc: Host interface message buffer
>> + * @timestamp: Timestamp of when parent callback started
>>   *
>>   * Parse the incoming packet. If it is a response packet then it will
>>   * update per instance flags and wake up the caller waiting to for the
>>   * response. If it is an event packet then it will schedule event work.
>>   */
>>  static void process_recv(struct ishtp_cl *cros_ish_cl,
>> -			 struct ishtp_cl_rb *rb_in_proc)
>> +			 struct ishtp_cl_rb *rb_in_proc, ktime_t timestamp)
>>  {
>>  	size_t data_len = rb_in_proc->buf_idx;
>>  	struct ishtp_cl_data *client_data =
>> @@ -295,6 +296,11 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
>>  		break;
>>  
>>  	case CROS_MKBP_EVENT:
>> +		/*
>> +		 * Set timestamp from beginning of function since we actually
>> +		 * got an incoming MKBP event
>> +		 */
>> +		client_data->ec_dev->last_event_time = timestamp;
>>  		/* The event system doesn't send any data in buffer */
>>  		schedule_work(&client_data->work_ec_evt);
>>  
>> @@ -322,10 +328,17 @@ static void ish_event_cb(struct ishtp_cl_device *cl_device)
>>  {
>>  	struct ishtp_cl_rb *rb_in_proc;
>>  	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
>> +	ktime_t timestamp;
>> +
>> +	/*
>> +	 * Take timestamp as close to hardware interrupt as possible for sensor
>> +	 * timestamps.
>> +	 */
>> +	timestamp = cros_ec_get_time_ns();
>>  
>>  	while ((rb_in_proc = ishtp_cl_rx_get_rb(cros_ish_cl)) != NULL) {
>>  		/* Decide what to do with received data */
>> -		process_recv(cros_ish_cl, rb_in_proc);
>> +		process_recv(cros_ish_cl, rb_in_proc, timestamp);
>>  	}
>>  }
>>  
>> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
>> index 7d10d909435f..3c77496e164d 100644
>> --- a/drivers/platform/chrome/cros_ec_lpc.c
>> +++ b/drivers/platform/chrome/cros_ec_lpc.c
>> @@ -313,6 +313,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
>>  {
>>  	struct cros_ec_device *ec_dev = data;
>>  
>> +	ec_dev->last_event_time = cros_ec_get_time_ns();
>> +
>>  	if (ec_dev->mkbp_event_supported &&
>>  	    cros_ec_get_next_event(ec_dev, NULL) > 0)
>>  		blocking_notifier_call_chain(&ec_dev->event_notifier, 0,
>> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
>> index 691f9e953a96..b183024fef1f 100644
>> --- a/include/linux/platform_data/cros_ec_proto.h
>> +++ b/include/linux/platform_data/cros_ec_proto.h
>> @@ -122,6 +122,8 @@ struct cros_ec_command {
>>   * @event_data: Raw payload transferred with the MKBP event.
>>   * @event_size: Size in bytes of the event data.
>>   * @host_event_wake_mask: Mask of host events that cause wake from suspend.
>> + * @last_event_time: exact time from the hard irq when we got notified of
>> + *     a new event.
>>   * @ec: The platform_device used by the mfd driver to interface with the
>>   *      main EC.
>>   * @pd: The platform_device used by the mfd driver to interface with the
>> @@ -162,6 +164,7 @@ struct cros_ec_device {
>>  	int event_size;
>>  	u32 host_event_wake_mask;
>>  	u32 last_resume_result;
>> +	ktime_t last_event_time;
>>  
>>  	/* The platform devices used by the mfd driver */
>>  	struct platform_device *ec;
>> @@ -210,4 +213,17 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>>  
>>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>>  
>> +/**
>> + * cros_ec_get_time_ns - Return time in ns.
> 
> Fairly sure that's not correct kernel-doc.  Please run
> ../scripts/kernel-doc over the files and fix the warnings.
> 
>  * cros_ec_get_time_ns() - Return time in ns.
> 
>> + *
>> + * This is the function used to record the time for last_event_time in struct
>> + * cros_ec_device during the hard irq.
>> + *
>> + * Return: ktime_t format since boot.
>> + */
>> +static inline ktime_t cros_ec_get_time_ns(void)
>> +{
>> +	return ktime_get_boottime_ns();
>> +}
>> +
>>  #endif /* __LINUX_CROS_EC_PROTO_H */
> 
