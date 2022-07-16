Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8D576FF8
	for <lists+linux-iio@lfdr.de>; Sat, 16 Jul 2022 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGPPsS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Jul 2022 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPPsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jul 2022 11:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F31BEBB;
        Sat, 16 Jul 2022 08:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 223CF61177;
        Sat, 16 Jul 2022 15:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5713FC34114;
        Sat, 16 Jul 2022 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657986496;
        bh=nVDEFHipPDeDlvNWrmIwvsAG2RQ+HA1vZ6GWK14g8tE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CWjW7GtefMde/9ok+CjYHtBWICqxs41/DkuSmq3geR203ag/r9PVaRP7121IVk4jx
         gSVjOExgmXZEE3SKluo3pCAoFUnLz1DmxkRaCxbmdH1Feog4k7yv9TEJ9jBkVEo1Fd
         grBUH/RKxYMp1yd3/1qRBDUPokd+sTG+yfi8n67cwLQu0cqdH/M0JIgqknSYfg7yAU
         BWGGEmCZIHs61puWhWmUw57TgU67MywQYBVjAjhv+bAD689uzKzXh6S79oG4isayjQ
         bLaTHBez2mQt4bjSYNi3kmx3FmZMNrIK+MYt2QUkre3rx/0dB42bDEiybjLDs9xiQJ
         4U/2zPqufw45Q==
Date:   Sat, 16 Jul 2022 16:58:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        contact@artur-rojek.eu, maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, paul@crapouillou.net,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v7 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <20220716165808.70c54d7d@jic23-huawei>
In-Reply-To: <20220705190354.69263-3-macromorgan@hotmail.com>
References: <20220705190354.69263-1-macromorgan@hotmail.com>
        <20220705190354.69263-3-macromorgan@hotmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  5 Jul 2022 14:03:53 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macroalpha82@gmail.com>
> 
> Add polled input device support to the adc-joystick driver. This is
> useful for devices which do not have hardware capable triggers on
> their SARADC. Code modified from adc-joystick.c changes made by Maya
> Matuszczyk.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Hi.

One comment inline on improving the error handling slightly.

Thanks,

Jonathan

> ---
>  drivers/input/joystick/adc-joystick.c | 51 +++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
> index 78ebca7d400a..2f4bd12d6344 100644
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
> @@ -179,6 +194,7 @@ static int adc_joystick_probe(struct platform_device *pdev)
>  	int error;
>  	int bits;
>  	int i;
> +	unsigned int poll_interval;
>  
>  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
>  	if (!joy)
> @@ -215,8 +231,17 @@ static int adc_joystick_probe(struct platform_device *pdev)
>  	joy->input = input;
>  	input->name = pdev->name;
>  	input->id.bustype = BUS_HOST;
> -	input->open = adc_joystick_open;
> -	input->close = adc_joystick_close;
> +
> +	joy->polled = !device_property_read_u32(dev, "poll-interval",
> +						&poll_interval);
Slight preference for an explicit check on presence of property
	
	if (device_property_present(dev, "poll-interval")) {
		error = device_property_read_u32();
		if (error)
			return error;
		input_setup_polling(input, adc_joystick_poll);
		input_set_poll_interval(input, poll_interval);
	} else {
		input->open = adc_joystick_open;
		input->close = adc_joystick_close;
	}

That way we will return an error if there is a malformed property.

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
> @@ -229,16 +254,20 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
> -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup, joy->buffer);
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

