Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A352589202
	for <lists+linux-iio@lfdr.de>; Wed,  3 Aug 2022 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiHCSDX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Aug 2022 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHCSDW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Aug 2022 14:03:22 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121AC19011;
        Wed,  3 Aug 2022 11:03:20 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 86971100003;
        Wed,  3 Aug 2022 18:03:17 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 03 Aug 2022 20:03:17 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        jic23@kernel.org, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v10 2/3] Input: adc-joystick - Add polled input device
 support
In-Reply-To: <20220803174505.21420-3-macroalpha82@gmail.com>
References: <20220803174505.21420-1-macroalpha82@gmail.com>
 <20220803174505.21420-3-macroalpha82@gmail.com>
Message-ID: <5feecb7813f9718c3d980fe548997bff@artur-rojek.eu>
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

On 2022-08-03 19:45, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add polled input device support to the adc-joystick driver. This is
> useful for devices which do not have hardware capable triggers on
> their SARADC. Code modified from adc-joystick.c changes made by Maya
> Matuszczyk.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
Chris,
some minor details inline.
>  drivers/input/joystick/adc-joystick.c | 53 ++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/joystick/adc-joystick.c
> b/drivers/input/joystick/adc-joystick.c
> index 78ebca7d400a..a288ebfe254e 100644
> --- a/drivers/input/joystick/adc-joystick.c
> +++ b/drivers/input/joystick/adc-joystick.c
> @@ -26,8 +26,23 @@ struct adc_joystick {
>  	struct adc_joystick_axis *axes;
>  	struct iio_channel *chans;
>  	int num_chans;
> +	bool polled;
>  };
> 
> +static void adc_joystick_poll(struct input_dev *input)
> +{
> +	struct adc_joystick *joy = input_get_drvdata(input);
> +	int i, val, ret;
> +
> +	for (i = 0; i < joy->num_chans; i++) {
> +		ret = iio_read_channel_raw(&joy->chans[i], &val);
> +		if (ret < 0)
> +			return;
> +		input_report_abs(input, joy->axes[i].code, val);
> +	}
> +	input_sync(input);
> +}
> +
>  static int adc_joystick_handle(const void *data, void *private)
>  {
>  	struct adc_joystick *joy = private;
> @@ -179,6 +194,7 @@ static int adc_joystick_probe(struct 
> platform_device *pdev)
>  	int error;
>  	int bits;
>  	int i;
> +	unsigned int poll_interval;
> 
>  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
>  	if (!joy)
> @@ -192,11 +208,25 @@ static int adc_joystick_probe(struct
> platform_device *pdev)
>  		return error;
>  	}
> 
> -	/* Count how many channels we got. NULL terminated. */
> +	if (device_property_present(dev, "poll-interval")) {
> +		error = device_property_read_u32(dev, "poll-interval",
> +						 &poll_interval);
> +		if (error)
> +			return error;
> +		joy->polled = true;
> +	}
> +
> +	/*
> +	 * Count how many channels we got. NULL terminated.
> +	 * Do not check the storage size if using polling.
> +	 */
>  	for (i = 0; joy->chans[i].indio_dev; i++) {
> +		if (joy->polled)
> +			continue;
>  		bits = joy->chans[i].channel->scan_type.storagebits;
>  		if (!bits || bits > 16) {
> -			dev_err(dev, "Unsupported channel storage size\n");
> +			dev_err(dev,
> +				"Unsupported channel storage size\n");
This change is now unnecessary, as the line can fit in 80 chars again.
>  			return -EINVAL;
>  		}
>  		if (bits != joy->chans[0].channel->scan_type.storagebits) {
> @@ -215,8 +245,14 @@ static int adc_joystick_probe(struct 
> platform_device *pdev)
>  	joy->input = input;
>  	input->name = pdev->name;
>  	input->id.bustype = BUS_HOST;
> -	input->open = adc_joystick_open;
> -	input->close = adc_joystick_close;
> +
> +	if (joy->polled) {
> +		input_setup_polling(input, adc_joystick_poll);
> +		input_set_poll_interval(input, poll_interval);
> +	} else {
> +		input->open = adc_joystick_open;
> +		input->close = adc_joystick_close;
> +	}
> 
>  	error = adc_joystick_set_axes(dev, joy);
>  	if (error)
> @@ -229,13 +265,18 @@ static int adc_joystick_probe(struct
> platform_device *pdev)
>  		return error;
>  	}
> 
> -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> +	if (joy->polled)
> +		return 0;
> +
> +	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
> +					     joy);
Same here.
>  	if (IS_ERR(joy->buffer)) {
>  		dev_err(dev, "Unable to allocate callback buffer\n");
>  		return PTR_ERR(joy->buffer);
>  	}
> 
> -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup, 
> joy->buffer);
> +	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> +					 joy->buffer);
And here.
>  	if (error)  {
>  		dev_err(dev, "Unable to add action\n");
>  		return error;
