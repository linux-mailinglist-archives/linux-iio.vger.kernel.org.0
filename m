Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F33A55DFDF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbiF0WqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 18:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbiF0WqG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 18:46:06 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B1C186E9;
        Mon, 27 Jun 2022 15:46:03 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id A0525C0005;
        Mon, 27 Jun 2022 22:45:59 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 28 Jun 2022 00:45:59 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net, jic23@kernel.org,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v4 2/3] Input: adc-joystick - Add polled input device
 support
In-Reply-To: <20220627221444.3638-3-macroalpha82@gmail.com>
References: <20220627221444.3638-1-macroalpha82@gmail.com>
 <20220627221444.3638-3-macroalpha82@gmail.com>
Message-ID: <c1edc707902248dde5ae6717aa9a27a0@artur-rojek.eu>
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

On 2022-06-28 00:14, Chris Morgan wrote:
> Add polled input device support to the adc-joystick driver. This is
> useful for devices which do not have hardware capable triggers on
> their SARADC. Code modified from adc-joystick.c changes made by Maya
> Matuszczyk.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
Hey Chris,

comments inline.
>  drivers/input/joystick/adc-joystick.c | 49 +++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/joystick/adc-joystick.c
> b/drivers/input/joystick/adc-joystick.c
> index 78ebca7d400a..7e3c5083ec3c 100644
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
> +	int value;
This name is not self-describing. How about `poll_interval` instead?
> 
>  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
>  	if (!joy)
> @@ -215,8 +231,15 @@ static int adc_joystick_probe(struct 
> platform_device *pdev)
>  	joy->input = input;
>  	input->name = pdev->name;
>  	input->id.bustype = BUS_HOST;
> -	input->open = adc_joystick_open;
> -	input->close = adc_joystick_close;
> +
> +	if (!device_property_read_u32(dev, "poll-interval", &value)) {
> +		joy->polled = 1;
> +		input_setup_polling(input, adc_joystick_poll);
> +		input_set_poll_interval(input, value);
> +	} else {
> +		input->open = adc_joystick_open;
> +		input->close = adc_joystick_close;
> +	}
Let's move the polling setup logic for after you establish the value of 
`joy->polled`:
```
	joy->polled = !device_property_read_u32(dev, "poll-interval",
						&poll_interval);
	if (joy->polled) {
		input_setup_polling(input, adc_joystick_poll);
		input_set_poll_interval(input, poll_interval);
	} else {
		input->open = adc_joystick_open;
		input->close = adc_joystick_close;
	}
```
This makes the intention more clear and is consistent with the `if 
(!joy->polled)` check later on.

Cheers,
Artur
> 
>  	error = adc_joystick_set_axes(dev, joy);
>  	if (error)
> @@ -229,16 +252,20 @@ static int adc_joystick_probe(struct
> platform_device *pdev)
>  		return error;
>  	}
> 
> -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> -	if (IS_ERR(joy->buffer)) {
> -		dev_err(dev, "Unable to allocate callback buffer\n");
> -		return PTR_ERR(joy->buffer);
> -	}
> +	if (!joy->polled) {
> +		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle,
> +						     joy);
> +		if (IS_ERR(joy->buffer)) {
> +			dev_err(dev, "Unable to allocate callback buffer\n");
> +			return PTR_ERR(joy->buffer);
> +		}
> 
> -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup, 
> joy->buffer);
> -	if (error)  {
> -		dev_err(dev, "Unable to add action\n");
> -		return error;
> +		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> +						 joy->buffer);
> +		if (error)  {
> +			dev_err(dev, "Unable to add action\n");
> +			return error;
> +		}
>  	}
> 
>  	return 0;
