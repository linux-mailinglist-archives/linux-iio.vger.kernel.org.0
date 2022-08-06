Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57858B607
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiHFOT1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiHFOT0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 10:19:26 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC77E12602;
        Sat,  6 Aug 2022 07:19:24 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 13909200002;
        Sat,  6 Aug 2022 14:19:21 +0000 (UTC)
MIME-Version: 1.0
Date:   Sat, 06 Aug 2022 16:19:21 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v12 2/3] Input: adc-joystick - Add polled input device
 support
In-Reply-To: <20220806152042.39bc5351@jic23-huawei>
References: <20220805171016.21217-1-macroalpha82@gmail.com>
 <20220805171016.21217-3-macroalpha82@gmail.com>
 <20220806152042.39bc5351@jic23-huawei>
Message-ID: <9399f54366be973dba36a70cb3dcbfd9@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2022-08-06 16:20, Jonathan Cameron wrote:
> On Fri,  5 Aug 2022 12:10:15 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
>> From: Chris Morgan <macromorgan@hotmail.com>
>> 
>> Add polled input device support to the adc-joystick driver. This is
>> useful for devices which do not have hardware capable triggers on
>> their SARADC. Code modified from adc-joystick.c changes made by Maya
>> Matuszczyk.
>> 
>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Hi Chris,
> 
> Trying to avoid too much indentation has lead to an odd code structure.
> Still minor thing, so either way this looks fine to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>>  drivers/input/joystick/adc-joystick.c | 44 
>> +++++++++++++++++++++++++--
>>  1 file changed, 41 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/input/joystick/adc-joystick.c 
>> b/drivers/input/joystick/adc-joystick.c
>> index 78ebca7d400a..77dfb7dd96eb 100644
>> --- a/drivers/input/joystick/adc-joystick.c
>> +++ b/drivers/input/joystick/adc-joystick.c
>> @@ -26,8 +26,23 @@ struct adc_joystick {
>>  	struct adc_joystick_axis *axes;
>>  	struct iio_channel *chans;
>>  	int num_chans;
>> +	bool polled;
>>  };
>> 
>> +static void adc_joystick_poll(struct input_dev *input)
>> +{
>> +	struct adc_joystick *joy = input_get_drvdata(input);
>> +	int i, val, ret;
>> +
>> +	for (i = 0; i < joy->num_chans; i++) {
>> +		ret = iio_read_channel_raw(&joy->chans[i], &val);
>> +		if (ret < 0)
>> +			return;
>> +		input_report_abs(input, joy->axes[i].code, val);
>> +	}
>> +	input_sync(input);
>> +}
>> +
>>  static int adc_joystick_handle(const void *data, void *private)
>>  {
>>  	struct adc_joystick *joy = private;
>> @@ -179,6 +194,7 @@ static int adc_joystick_probe(struct 
>> platform_device *pdev)
>>  	int error;
>>  	int bits;
>>  	int i;
>> +	unsigned int poll_interval;
>> 
>>  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
>>  	if (!joy)
>> @@ -192,8 +208,21 @@ static int adc_joystick_probe(struct 
>> platform_device *pdev)
>>  		return error;
>>  	}
>> 
>> -	/* Count how many channels we got. NULL terminated. */
>> +	if (device_property_present(dev, "poll-interval")) {
>> +		error = device_property_read_u32(dev, "poll-interval",
>> +						 &poll_interval);
>> +		if (error)
>> +			return error;
>> +		joy->polled = true;
>> +	}
>> +
>> +	/*
>> +	 * Count how many channels we got. NULL terminated.
>> +	 * Do not check the storage size if using polling.
>> +	 */
>>  	for (i = 0; joy->chans[i].indio_dev; i++) {
>> +		if (joy->polled)
>> +			continue;
> 
> Whilst I can see why did this, it is a rather 'unusual' code structure
> and that makes me a tiny bit uncomfortable. However if everyone else
> is happy with this then fair enough (I see it was Artur's suggestion to
> handle it like this).
Yep, I'm fine with the way it is right now :)

Acked-by: Artur Rojek <contact@artur-rojek.eu>

> 
>>  		bits = joy->chans[i].channel->scan_type.storagebits;
>>  		if (!bits || bits > 16) {
>>  			dev_err(dev, "Unsupported channel storage size\n");
>> @@ -215,8 +244,14 @@ static int adc_joystick_probe(struct 
>> platform_device *pdev)
>>  	joy->input = input;
>>  	input->name = pdev->name;
>>  	input->id.bustype = BUS_HOST;
>> -	input->open = adc_joystick_open;
>> -	input->close = adc_joystick_close;
>> +
>> +	if (joy->polled) {
>> +		input_setup_polling(input, adc_joystick_poll);
>> +		input_set_poll_interval(input, poll_interval);
>> +	} else {
>> +		input->open = adc_joystick_open;
>> +		input->close = adc_joystick_close;
>> +	}
>> 
>>  	error = adc_joystick_set_axes(dev, joy);
>>  	if (error)
>> @@ -229,6 +264,9 @@ static int adc_joystick_probe(struct 
>> platform_device *pdev)
>>  		return error;
>>  	}
>> 
>> +	if (joy->polled)
>> +		return 0;
>> +
>>  	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
>>  	if (IS_ERR(joy->buffer)) {
>>  		dev_err(dev, "Unable to allocate callback buffer\n");
