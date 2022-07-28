Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE5584700
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jul 2022 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiG1U0P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jul 2022 16:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1U0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2022 16:26:14 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E526555;
        Thu, 28 Jul 2022 13:26:11 -0700 (PDT)
Received: (Authenticated sender: contact@artur-rojek.eu)
        by mail.gandi.net (Postfix) with ESMTPA id 06EB1100006;
        Thu, 28 Jul 2022 20:26:07 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 28 Jul 2022 22:26:07 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, jic23@kernel.org, paul@crapouillou.net,
        linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v8 2/3] Input: adc-joystick - Add polled input device
 support
In-Reply-To: <20220721164603.13534-3-macroalpha82@gmail.com>
References: <20220721164603.13534-1-macroalpha82@gmail.com>
 <20220721164603.13534-3-macroalpha82@gmail.com>
Message-ID: <8c6efe60662609a92e2a4e758e784f66@artur-rojek.eu>
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

On 2022-07-21 18:46, Chris Morgan wrote:
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
Hey Chris,

sorry for the late response. Comments in-line.

Cheers,
Artur
>  drivers/input/joystick/adc-joystick.c | 82 ++++++++++++++++++++-------
>  1 file changed, 62 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/joystick/adc-joystick.c
> b/drivers/input/joystick/adc-joystick.c
> index 78ebca7d400a..085b8e10dfb5 100644
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
> @@ -178,7 +193,9 @@ static int adc_joystick_probe(struct 
> platform_device *pdev)
>  	struct input_dev *input;
>  	int error;
>  	int bits;
> +	int chan_storage;
>  	int i;
> +	unsigned int poll_interval;
> 
>  	joy = devm_kzalloc(dev, sizeof(*joy), GFP_KERNEL);
>  	if (!joy)
> @@ -192,16 +209,31 @@ static int adc_joystick_probe(struct
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
> +	/* Count how many channels we got. NULL terminated. Do not check the
> +	 * storage size if using polling.
> +	 */
As per Linux coding style, the multi-line comment opens with a lone `/*`
line. Also, move the second sentence into a new line for readability.

> +	chan_storage = joy->chans[0].channel->scan_type.storagebits;
>  	for (i = 0; joy->chans[i].indio_dev; i++) {
> -		bits = joy->chans[i].channel->scan_type.storagebits;
> -		if (!bits || bits > 16) {
> -			dev_err(dev, "Unsupported channel storage size\n");
> -			return -EINVAL;
> -		}
> -		if (bits != joy->chans[0].channel->scan_type.storagebits) {
> -			dev_err(dev, "Channels must have equal storage size\n");
> -			return -EINVAL;
> +		if (!joy->polled) {
> +			bits = joy->chans[i].channel->scan_type.storagebits;
> +			if (!bits || bits > 16) {
> +				dev_err(dev,
> +					"Unsupported channel storage size\n");
> +				return -EINVAL;
> +			}
> +			if (bits != chan_storage) {
> +				dev_err(dev,
> +					"Channels must be equal size\n");
> +				return -EINVAL;
> +			}
Just do `for (i = 0; !joy->polled && joy->chans[i].indio_dev; i++)`, as
this will terminate early if we're polling.
Then we'll also be able to restore the loop body to its original code 
and
get rid of that `chan_storage` helper.

>  		}
>  	}
>  	joy->num_chans = i;
> @@ -215,8 +247,14 @@ static int adc_joystick_probe(struct 
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
> @@ -229,16 +267,20 @@ static int adc_joystick_probe(struct
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

