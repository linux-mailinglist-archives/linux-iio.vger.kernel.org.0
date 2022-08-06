Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9658B5D6
	for <lists+linux-iio@lfdr.de>; Sat,  6 Aug 2022 16:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiHFOK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Aug 2022 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiHFOKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Aug 2022 10:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D216474;
        Sat,  6 Aug 2022 07:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3ED760FC9;
        Sat,  6 Aug 2022 14:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89769C433C1;
        Sat,  6 Aug 2022 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659795024;
        bh=MZQl7VdV672uwUM+vZC1SSTejz5QkY4JjdAUiiBs6gY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gzb8JJ9we0dFTrJXCjp386RFwGwXU6pdhW9uwOOi72JA3efxobgZHN3X/T7Pfzn2V
         eaFbeEEs0RvikxJ8EH6woxUvnFL8OCIdXBCuXWiwZ+rHGHt/rBGTBRNwhHjO+XiUdc
         BuRGc0Sa40DJ5nXoHH+TrTiyjDAmWw39VvkKCkfkC95dxJZTPZj3idWDHeFRhhp5fX
         79eZLacvBqQQhljq3K8B/0F9qwadfCB+D0NXrNDeYE+G2kD8MLKbkiIMXXZ7vHhghF
         M6hm79wnia6UkDdDFHIygS0ie6d66a/IYaWaW13OVv1J+j6GzF7rZ2W5toxNpZ6UrH
         bE6SnrKNDMXFw==
Date:   Sat, 6 Aug 2022 15:20:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        dmitry.torokhov@gmail.com, contact@artur-rojek.eu,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, paul@crapouillou.net,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v12 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <20220806152042.39bc5351@jic23-huawei>
In-Reply-To: <20220805171016.21217-3-macroalpha82@gmail.com>
References: <20220805171016.21217-1-macroalpha82@gmail.com>
        <20220805171016.21217-3-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  5 Aug 2022 12:10:15 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add polled input device support to the adc-joystick driver. This is
> useful for devices which do not have hardware capable triggers on
> their SARADC. Code modified from adc-joystick.c changes made by Maya
> Matuszczyk.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Hi Chris,

Trying to avoid too much indentation has lead to an odd code structure.
Still minor thing, so either way this looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/input/joystick/adc-joystick.c | 44 +++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/adc-joystick.c b/drivers/input/joystick/adc-joystick.c
> index 78ebca7d400a..77dfb7dd96eb 100644
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
> @@ -192,8 +208,21 @@ static int adc_joystick_probe(struct platform_device *pdev)
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

Whilst I can see why did this, it is a rather 'unusual' code structure
and that makes me a tiny bit uncomfortable. However if everyone else
is happy with this then fair enough (I see it was Artur's suggestion to
handle it like this).

>  		bits = joy->chans[i].channel->scan_type.storagebits;
>  		if (!bits || bits > 16) {
>  			dev_err(dev, "Unsupported channel storage size\n");
> @@ -215,8 +244,14 @@ static int adc_joystick_probe(struct platform_device *pdev)
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
> @@ -229,6 +264,9 @@ static int adc_joystick_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> +	if (joy->polled)
> +		return 0;
> +
>  	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
>  	if (IS_ERR(joy->buffer)) {
>  		dev_err(dev, "Unable to allocate callback buffer\n");

