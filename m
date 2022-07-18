Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855AF5780CB
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiGRLcd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Jul 2022 07:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiGRLcc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2022 07:32:32 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD71A802;
        Mon, 18 Jul 2022 04:32:30 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 489671BF204;
        Mon, 18 Jul 2022 11:32:27 +0000 (UTC)
MIME-Version: 1.0
Date:   Mon, 18 Jul 2022 13:32:27 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, maccraft123mc@gmail.com,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        paul@crapouillou.net, linux-iio@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v7 2/3] Input: adc-joystick - Add polled input device
 support
In-Reply-To: <20220716165808.70c54d7d@jic23-huawei>
References: <20220705190354.69263-1-macromorgan@hotmail.com>
 <20220705190354.69263-3-macromorgan@hotmail.com>
 <20220716165808.70c54d7d@jic23-huawei>
Message-ID: <bb7e12b61a56b61770def053ce42bdd9@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2022-07-16 17:58, Jonathan Cameron wrote:
> On Tue,  5 Jul 2022 14:03:53 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
>> From: Chris Morgan <macroalpha82@gmail.com>
>> 
>> Add polled input device support to the adc-joystick driver. This is
>> useful for devices which do not have hardware capable triggers on
>> their SARADC. Code modified from adc-joystick.c changes made by Maya
>> Matuszczyk.
>> 
>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> 
> Hi.
> 
> One comment inline on improving the error handling slightly.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/input/joystick/adc-joystick.c | 51 
>> +++++++++++++++++++++------
>>  1 file changed, 40 insertions(+), 11 deletions(-)
>> 
>> diff --git a/drivers/input/joystick/adc-joystick.c 
>> b/drivers/input/joystick/adc-joystick.c
>> index 78ebca7d400a..2f4bd12d6344 100644
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
>> @@ -215,8 +231,17 @@ static int adc_joystick_probe(struct 
>> platform_device *pdev)
>>  	joy->input = input;
>>  	input->name = pdev->name;
>>  	input->id.bustype = BUS_HOST;
>> -	input->open = adc_joystick_open;
>> -	input->close = adc_joystick_close;
>> +
>> +	joy->polled = !device_property_read_u32(dev, "poll-interval",
>> +						&poll_interval);
> Slight preference for an explicit check on presence of property
> 
> 	if (device_property_present(dev, "poll-interval")) {
> 		error = device_property_read_u32();
> 		if (error)
> 			return error;
> 		input_setup_polling(input, adc_joystick_poll);
> 		input_set_poll_interval(input, poll_interval);
> 	} else {
> 		input->open = adc_joystick_open;
> 		input->close = adc_joystick_close;
> 	}
> 
> That way we will return an error if there is a malformed property.
I'm fine with that, just let's keep the polling setup logic outside the 
DT parsing code, like it was in v7:
```
	if (device_property_present(dev, "poll-interval")) {
		error = device_property_read_u32(dev, "poll-interval",
						 &poll_interval);
		if (error)
			return error;
		joy->polled = true;
	}

	if (joy->polled) {
		input_setup_polling(input, adc_joystick_poll);
		input_set_poll_interval(input, poll_interval);
	} else {
		input->open = adc_joystick_open;
		input->close = adc_joystick_close;
	}

```

Cheers,
Artur
> 
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
>> @@ -229,16 +254,20 @@ static int adc_joystick_probe(struct 
>> platform_device *pdev)
>>  		return error;
>>  	}
>> 
>> -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
>> -	if (IS_ERR(joy->buffer)) {
>> -		dev_err(dev, "Unable to allocate callback buffer\n");
>> -		return PTR_ERR(joy->buffer);
>> -	}
>> +	if (!joy->polled) {
>> +		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
>> +						     joy);
>> +		if (IS_ERR(joy->buffer)) {
>> +			dev_err(dev, "Unable to allocate callback buffer\n");
>> +			return PTR_ERR(joy->buffer);
>> +		}
>> 
>> -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup, 
>> joy->buffer);
>> -	if (error)  {
>> -		dev_err(dev, "Unable to add action\n");
>> -		return error;
>> +		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
>> +						 joy->buffer);
>> +		if (error)  {
>> +			dev_err(dev, "Unable to add action\n");
>> +			return error;
>> +		}
>>  	}
>> 
>>  	return 0;
