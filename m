Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EB0550BD8
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiFSPXR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiFSPXQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 11:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106EBB7D8;
        Sun, 19 Jun 2022 08:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84FE0611DF;
        Sun, 19 Jun 2022 15:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B77C34114;
        Sun, 19 Jun 2022 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655652193;
        bh=1llk4BjqNQGmo0gKKOn38yqFhGDIYth7C09jZn/dIOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XDg5Ooj7fKpp9Cg6vMfdDa5rBen8o78Tt2JbCY7Nb+ri8AizRWZjV33efhnSuAluQ
         3FyQQVSJY2JpVGG48ppPNKMF243N1rAAJUQ49rbFCY4NTqprkJ1pfcb73yThxXW55Z
         BaVHBK+ahVdKv78tUsn9OruNheHDVAIQopDU59ILS1e+hkSeGk6WXf1+N9pSzKw0w8
         0qdyLzSqnKE0Jpc3CjyenUYl+LXIZE0aKMAvbij3XxIOPAET6FVEdFqEjg73ihnWRz
         qncr8t5u4w06RiXxOKPzk/qmyxkZ4/Sj3BRAraGdyeshBs/U1YfWc9c6KXNA9tbx6+
         spknI6o+qW4dg==
Date:   Sun, 19 Jun 2022 16:32:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <20220619163230.3130be79@jic23-huawei>
In-Reply-To: <cdb956639e9550b287db31b762f7b764@artur-rojek.eu>
References: <20220613192353.696-1-macroalpha82@gmail.com>
        <20220613192353.696-3-macroalpha82@gmail.com>
        <ec496fcf808d73fe356d1961d89bf1ff@artur-rojek.eu>
        <SN6PR06MB5342762DE16AFC607CA9D5F9A5AD9@SN6PR06MB5342.namprd06.prod.outlook.com>
        <cdb956639e9550b287db31b762f7b764@artur-rojek.eu>
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

On Sat, 18 Jun 2022 15:08:29 +0200
Artur Rojek <contact@artur-rojek.eu> wrote:

> On 2022-06-15 17:12, Chris Morgan wrote:
> > On Wed, Jun 15, 2022 at 03:43:07AM +0200, Artur Rojek wrote:  
> >> On 2022-06-13 21:23, Chris Morgan wrote:  
> >> > From: Chris Morgan <macromorgan@hotmail.com>
> >> >
> >> > Add polled input device support to the adc-joystick driver. This is
> >> > useful for devices which do not have hardware capable triggers on
> >> > their SARADC. Code modified from adc-joystick.c changes made by Maya
> >> > Matuszczyk.
> >> >
> >> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> >> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> >> 
> >> Hi Chris,
> >> 
> >> Comments inline. I also Cc'd Paul and Jonathan, who were attached in 
> >> v2.
+CC linux-iio

> >>   
> >> > ---
> >> >  drivers/input/joystick/adc-joystick.c | 52 +++++++++++++++++++++------
> >> >  1 file changed, 41 insertions(+), 11 deletions(-)
> >> >
> >> > diff --git a/drivers/input/joystick/adc-joystick.c
> >> > b/drivers/input/joystick/adc-joystick.c
> >> > index 78ebca7d400a..dc01cd0214d2 100644
> >> > --- a/drivers/input/joystick/adc-joystick.c
> >> > +++ b/drivers/input/joystick/adc-joystick.c
> >> > @@ -13,6 +13,10 @@
> >> >
> >> >  #include <asm/unaligned.h>
> >> >
> >> > +#define ADC_JSK_POLL_INTERVAL	16
> >> > +#define ADC_JSK_POLL_MIN	8
> >> > +#define ADC_JSK_POLL_MAX	32
> >> > +
> >> >  struct adc_joystick_axis {
> >> >  	u32 code;
> >> >  	s32 range[2];
> >> > @@ -26,8 +30,21 @@ struct adc_joystick {
> >> >  	struct adc_joystick_axis *axes;
> >> >  	struct iio_channel *chans;
> >> >  	int num_chans;
> >> > +	bool polled;
> >> >  };
> >> >
> >> > +static void adc_joystick_poll(struct input_dev *input)
> >> > +{
> >> > +	struct adc_joystick *joy = input_get_drvdata(input);
> >> > +	int i, val;
> >> > +
> >> > +	for (i = 0; i < joy->num_chans; i++) {
> >> > +		iio_read_channel_raw(&joy->chans[i], &val);
> >> > +		input_report_abs(input, joy->axes[i].code, val);
> >> > +	}
> >> > +	input_sync(input);
> >> > +}
> >> > +
> >> >  static int adc_joystick_handle(const void *data, void *private)
> >> >  {
> >> >  	struct adc_joystick *joy = private;
> >> > @@ -215,8 +232,19 @@ static int adc_joystick_probe(struct
> >> > platform_device *pdev)
> >> >  	joy->input = input;
> >> >  	input->name = pdev->name;
> >> >  	input->id.bustype = BUS_HOST;
> >> > -	input->open = adc_joystick_open;
> >> > -	input->close = adc_joystick_close;
> >> > +
> >> > +	if (device_property_read_bool(dev,
> >> > "adc-joystick,no-hardware-trigger"))
> >> > +		joy->polled = 1;  
> >> As mentioned in v2, I don't think a DT property is required here. 
> >> Assuming
> >> the polled mode is a fallback for devices with no buffers, just do:
> >> ```
> >> 	joy->polled = !(joy->chans[0].indio_dev->modes &
> >> 			INDIO_ALL_BUFFER_MODES);
> >> ```  
> > 
> > Understood. I attempted this and noticed that it was showing I have
> > INDIO_BUFFER_TRIGGERED in addition to INDIO_DIRECT_MODE (the
> > INDIO_DIRECT_MODE is the only one specified at the hardware level
> > though). Should I just check for INDIO_BUFFER_SOFTWARE &
> > INDIO_BUFFER_HARDWARE instead? I think it's possible that the inclusion
> > of the industrialio_triggered_buffer module in my kernel is adding
> > this to the channel somehow?  
> Having INDIO_BUFFER_TRIGGERED means that your saradc is capable of using 
> the existing flow. You should be able to register a software trigger and 
> use the adc-joystick driver without further issues.
> That said, this is where it gets problematic - there is no way to create 
> an IIO trigger via Device Tree, since triggers don't describe any piece 
> of hardware, and you shouldn't need to register it at runtime 
> (configfs/sysfs) for communication between two kernel drivers either. At 
> the same time, it's not adc-joystick's job to register an external 
> trigger.
> 
> Jonathan,
> I don't know what the proper approach to this should be, perhaps you 
> could assist?

You are correct in your description above. Device tree folk take the view
that sysfs / hrtimer etc triggers are a policy decision so don't belong
in device tree.  In general you need some userspace code to stitch up
the trigger anyway (even ADCs that provide triggers of their own often
have several). 

An alternative that may make sense here would be for the adc-joystick
driver to provide a trigger of it's own. That's easy enough to do,
but as things stand we don't provide a way to control the attached
trigger from other kernel drivers (i.e. you can't do the equivalent
of writing current_trigger for another device).

It's probably not implausible to add that though.  Is it worth it for
a joystick (vs doing what is done here), maybe not.

It would be worth doing if we cared about high performance (for some ADCs
anyway) but here we don't really so the polled read functions are fine.

Note many ADC drivers only support running in either polled or buffered
mode in IIO because polling random channels when doing highly optimised
accesses tends to make the drivers complex.  Hence you might find this
doesn't work for all setups...

Thanks,

Jonathan



> 
> Cheers,
> Artur
> > 
> > Thank you.
> >   
> >> > +
> >> > +	if (joy->polled) {
> >> > +		input_setup_polling(input, adc_joystick_poll);
> >> > +		input_set_poll_interval(input, ADC_JSK_POLL_INTERVAL);
> >> > +		input_set_min_poll_interval(input, ADC_JSK_POLL_MIN);
> >> > +		input_set_max_poll_interval(input, ADC_JSK_POLL_MAX);
> >> > +	} else {
> >> > +		input->open = adc_joystick_open;
> >> > +		input->close = adc_joystick_close;
> >> > +	}
> >> >
> >> >  	error = adc_joystick_set_axes(dev, joy);
> >> >  	if (error)
> >> > @@ -229,16 +257,18 @@ static int adc_joystick_probe(struct
> >> > platform_device *pdev)
> >> >  		return error;
> >> >  	}
> >> >
> >> > -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> >> > -	if (IS_ERR(joy->buffer)) {
> >> > -		dev_err(dev, "Unable to allocate callback buffer\n");
> >> > -		return PTR_ERR(joy->buffer);
> >> > -	}
> >> > +	if (!joy->polled) {
> >> > +		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);  
> >> Please maintain line discipline of 80 chars to stay consistent with 
> >> the rest
> >> of this driver.  
> > 
> > Understood, sorry about that.
> >   
> >> > +		if (IS_ERR(joy->buffer)) {
> >> > +			dev_err(dev, "Unable to allocate callback buffer\n");
> >> > +			return PTR_ERR(joy->buffer);
> >> > +		}
> >> >
> >> > -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> >> > joy->buffer);
> >> > -	if (error)  {
> >> > -		dev_err(dev, "Unable to add action\n");
> >> > -		return error;
> >> > +		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> >> > joy->buffer);  
> >> Same here.  
> > 
> > Ditto.
> >   
> >> 
> >> Cheers,
> >> Artur  
> >> > +		if (error)  {
> >> > +			dev_err(dev, "Unable to add action\n");
> >> > +			return error;
> >> > +		}
> >> >  	}
> >> >
> >> >  	return 0;  

