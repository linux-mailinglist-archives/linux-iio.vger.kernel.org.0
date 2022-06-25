Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3355AAE3
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jun 2022 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiFYORE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiFYORE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 10:17:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84511166;
        Sat, 25 Jun 2022 07:17:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFFF3B80B6F;
        Sat, 25 Jun 2022 14:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF55C3411C;
        Sat, 25 Jun 2022 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656166619;
        bh=DPdph+BPnWRw4GV1RBw9IJIXu7QRVxKcJtV/fs6dT8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FPoFpK3mxtX4Rgu/8uPhdmD1dW4zg4iNdkw/IUTQWs4/P/u6Hh92T2QGf8I/TNPTK
         XK8OrbtCNtA4Kjs9tLlz9C4aQsEuKAfVeyID6KUYivMRX841z9HFskBzIJ/8UYupqK
         /tulztVTe+d2qqhWBtCH8JVxyk+FQDfGgD5ja41b+2vTkDaNQb2qzAX7eDhdfOA7d1
         rutSpcJdgmtViv6GwFl7SqPec9IRxs67Ce2E2SfD9QmXJvzRCMKnm/UZgnH7m1Sn0o
         nmPzVkRAoUb0EMUaX+JxHPk6/i1o5E/SKiOs2w+yC/VMEo57rzH/nicD4bagCfY8C4
         K8jm0DxcLnTqA==
Date:   Sat, 25 Jun 2022 15:26:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        maccraft123mc@gmail.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] Input: adc-joystick - Add polled input device
 support
Message-ID: <20220625152626.39b26d2e@jic23-huawei>
In-Reply-To: <SN6PR06MB5342A21E55CF37B348D6F48FA5B39@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220613192353.696-1-macroalpha82@gmail.com>
        <20220613192353.696-3-macroalpha82@gmail.com>
        <ec496fcf808d73fe356d1961d89bf1ff@artur-rojek.eu>
        <SN6PR06MB5342762DE16AFC607CA9D5F9A5AD9@SN6PR06MB5342.namprd06.prod.outlook.com>
        <cdb956639e9550b287db31b762f7b764@artur-rojek.eu>
        <20220619163230.3130be79@jic23-huawei>
        <8225d239df59501b51fa71bac625827e@artur-rojek.eu>
        <SN6PR06MB5342A21E55CF37B348D6F48FA5B39@SN6PR06MB5342.namprd06.prod.outlook.com>
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

On Tue, 21 Jun 2022 16:41:01 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Sun, Jun 19, 2022 at 06:31:17PM +0200, Artur Rojek wrote:
> > On 2022-06-19 17:32, Jonathan Cameron wrote:  
> > > On Sat, 18 Jun 2022 15:08:29 +0200
> > > Artur Rojek <contact@artur-rojek.eu> wrote:
> > >   
> > > > On 2022-06-15 17:12, Chris Morgan wrote:  
> > > > > On Wed, Jun 15, 2022 at 03:43:07AM +0200, Artur Rojek wrote:  
> > > > >> On 2022-06-13 21:23, Chris Morgan wrote:  
> > > > >> > From: Chris Morgan <macromorgan@hotmail.com>
> > > > >> >
> > > > >> > Add polled input device support to the adc-joystick driver. This is
> > > > >> > useful for devices which do not have hardware capable triggers on
> > > > >> > their SARADC. Code modified from adc-joystick.c changes made by Maya
> > > > >> > Matuszczyk.
> > > > >> >
> > > > >> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > > > >> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > > > >>
> > > > >> Hi Chris,
> > > > >>
> > > > >> Comments inline. I also Cc'd Paul and Jonathan, who were attached in
> > > > >> v2.  
> > > +CC linux-iio
> > >   
> > > > >>  
> > > > >> > ---
> > > > >> >  drivers/input/joystick/adc-joystick.c | 52 +++++++++++++++++++++------
> > > > >> >  1 file changed, 41 insertions(+), 11 deletions(-)
> > > > >> >
> > > > >> > diff --git a/drivers/input/joystick/adc-joystick.c
> > > > >> > b/drivers/input/joystick/adc-joystick.c
> > > > >> > index 78ebca7d400a..dc01cd0214d2 100644
> > > > >> > --- a/drivers/input/joystick/adc-joystick.c
> > > > >> > +++ b/drivers/input/joystick/adc-joystick.c
> > > > >> > @@ -13,6 +13,10 @@
> > > > >> >
> > > > >> >  #include <asm/unaligned.h>
> > > > >> >
> > > > >> > +#define ADC_JSK_POLL_INTERVAL	16
> > > > >> > +#define ADC_JSK_POLL_MIN	8
> > > > >> > +#define ADC_JSK_POLL_MAX	32
> > > > >> > +
> > > > >> >  struct adc_joystick_axis {
> > > > >> >  	u32 code;
> > > > >> >  	s32 range[2];
> > > > >> > @@ -26,8 +30,21 @@ struct adc_joystick {
> > > > >> >  	struct adc_joystick_axis *axes;
> > > > >> >  	struct iio_channel *chans;
> > > > >> >  	int num_chans;
> > > > >> > +	bool polled;
> > > > >> >  };
> > > > >> >
> > > > >> > +static void adc_joystick_poll(struct input_dev *input)
> > > > >> > +{
> > > > >> > +	struct adc_joystick *joy = input_get_drvdata(input);
> > > > >> > +	int i, val;
> > > > >> > +
> > > > >> > +	for (i = 0; i < joy->num_chans; i++) {
> > > > >> > +		iio_read_channel_raw(&joy->chans[i], &val);  
> > Perhaps check the return value and leave early on error.  
> 
> Okay, I'll do that.
> 
> > > > >> > +		input_report_abs(input, joy->axes[i].code, val);
> > > > >> > +	}
> > > > >> > +	input_sync(input);
> > > > >> > +}
> > > > >> > +
> > > > >> >  static int adc_joystick_handle(const void *data, void *private)
> > > > >> >  {
> > > > >> >  	struct adc_joystick *joy = private;
> > > > >> > @@ -215,8 +232,19 @@ static int adc_joystick_probe(struct
> > > > >> > platform_device *pdev)
> > > > >> >  	joy->input = input;
> > > > >> >  	input->name = pdev->name;
> > > > >> >  	input->id.bustype = BUS_HOST;
> > > > >> > -	input->open = adc_joystick_open;
> > > > >> > -	input->close = adc_joystick_close;
> > > > >> > +
> > > > >> > +	if (device_property_read_bool(dev,
> > > > >> > "adc-joystick,no-hardware-trigger"))
> > > > >> > +		joy->polled = 1;  
> > > > >> As mentioned in v2, I don't think a DT property is required here.
> > > > >> Assuming
> > > > >> the polled mode is a fallback for devices with no buffers, just do:
> > > > >> ```
> > > > >> 	joy->polled = !(joy->chans[0].indio_dev->modes &
> > > > >> 			INDIO_ALL_BUFFER_MODES);
> > > > >> ```  
> > > > >
> > > > > Understood. I attempted this and noticed that it was showing I have
> > > > > INDIO_BUFFER_TRIGGERED in addition to INDIO_DIRECT_MODE (the
> > > > > INDIO_DIRECT_MODE is the only one specified at the hardware level
> > > > > though). Should I just check for INDIO_BUFFER_SOFTWARE &
> > > > > INDIO_BUFFER_HARDWARE instead? I think it's possible that the inclusion
> > > > > of the industrialio_triggered_buffer module in my kernel is adding
> > > > > this to the channel somehow?  
> > > > Having INDIO_BUFFER_TRIGGERED means that your saradc is capable of
> > > > using
> > > > the existing flow. You should be able to register a software trigger
> > > > and
> > > > use the adc-joystick driver without further issues.
> > > > That said, this is where it gets problematic - there is no way to
> > > > create
> > > > an IIO trigger via Device Tree, since triggers don't describe any
> > > > piece
> > > > of hardware, and you shouldn't need to register it at runtime
> > > > (configfs/sysfs) for communication between two kernel drivers
> > > > either. At
> > > > the same time, it's not adc-joystick's job to register an external
> > > > trigger.
> > > > 
> > > > Jonathan,
> > > > I don't know what the proper approach to this should be, perhaps you
> > > > could assist?  
> > > 
> > > You are correct in your description above. Device tree folk take the
> > > view
> > > that sysfs / hrtimer etc triggers are a policy decision so don't belong
> > > in device tree.  In general you need some userspace code to stitch up
> > > the trigger anyway (even ADCs that provide triggers of their own often
> > > have several).
> > > 
> > > An alternative that may make sense here would be for the adc-joystick
> > > driver to provide a trigger of it's own. That's easy enough to do,
> > > but as things stand we don't provide a way to control the attached
> > > trigger from other kernel drivers (i.e. you can't do the equivalent
> > > of writing current_trigger for another device).
> > > 
> > > It's probably not implausible to add that though.  Is it worth it for
> > > a joystick (vs doing what is done here), maybe not.
> > > 
> > > It would be worth doing if we cared about high performance (for some
> > > ADCs
> > > anyway) but here we don't really so the polled read functions are fine.
> > > 
> > > Note many ADC drivers only support running in either polled or buffered
> > > mode in IIO because polling random channels when doing highly optimised
> > > accesses tends to make the drivers complex.  Hence you might find this
> > > doesn't work for all setups...
> > > 
> > > Thanks,
> > > 
> > > Jonathan  
> > 
> > Jonathan,
> > thanks for the detailed answer.
> > 
> > Chris,
> > In light of the above, I think the best course of action should be to keep
> > your polling code. It looks like your saradc has introduced [1]
> > `INDIO_BUFFER_TRIGGERED` support exclusively for this very (adc-joystick)
> > case. This means we can't use `indio_dev->modes` to determine whether the
> > joystick can be polled, otherwise we might break behavior of existing
> > hardware. I suggest that we get back to passing this intention via optional
> > `poll-interval` DT property, that enables the polling path if present
> > (indiscriminately of the IIO mode). Let's see what the Device Tree folk say
> > about that :)
> >   
> 
> Thanks. While I know there is a very strict policy of "don't break userspace"
> I'm not aware of any consumers of the rockchip sardac using the adc-joystick
> in production. I mean, it's in the tree for this one device but to this day
> no one is shipping a distro with it to my knowledge, especially since the
> driver has a major known issue I'm not able to fix at current time (has to do
> with channels 1 and 2 being used instead of 0 and 1 for this specific SARADC).
> What I'm getting at is if the current situation is wrong by adding the 
> INDIO_BUFFER_TRIGGERED I don't think it's too late to change it right now.

No, better to leave that alone as it's correct, just not helpful to what you
want to do here.

> 
> Would the current poll code be best given the circumstances then? If you think
> so, I'll go ahead and make all requested changes and resubmit it. I think I'm
> understanding that what you want is for us to check for the existence of the
> property of "poll-interval" which is the polling time in milliseconds. If this
> value is present, use the polling code and if this value is not present, use
> the existing code (regardless of what the hardware supports or doesn't).

Sounds good to me.  We might get push back on dt binding though as
that doesn't sound very much like something that is about hardware rather
than policy.  It could be argued that a joystick works best at a particular
rate though so maybe we'll be fine.  We'll see when you send out the binding docs.

Jonathan

> 
> Thank you once again for all your help and guidance.
> -Chris
> 
> > Cheers,
> > Artur
> > 
> > [1] https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fid%3D4e130dc7b41348b13684f0758c26cc6cf72a3449&amp;data=05%7C01%7C%7C43ade3c4216a47079d5208da52112487%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637912530824693621%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Gorf7r9PJr1CDBbRKVNXnRyBJBw2cy%2FLv9tPP24Q5B0%3D&amp;reserved=0  
> > > 
> > > 
> > >   
> > > > 
> > > > Cheers,
> > > > Artur  
> > > > >
> > > > > Thank you.
> > > > >  
> > > > >> > +
> > > > >> > +	if (joy->polled) {
> > > > >> > +		input_setup_polling(input, adc_joystick_poll);
> > > > >> > +		input_set_poll_interval(input, ADC_JSK_POLL_INTERVAL);
> > > > >> > +		input_set_min_poll_interval(input, ADC_JSK_POLL_MIN);
> > > > >> > +		input_set_max_poll_interval(input, ADC_JSK_POLL_MAX);
> > > > >> > +	} else {
> > > > >> > +		input->open = adc_joystick_open;
> > > > >> > +		input->close = adc_joystick_close;
> > > > >> > +	}
> > > > >> >
> > > > >> >  	error = adc_joystick_set_axes(dev, joy);
> > > > >> >  	if (error)
> > > > >> > @@ -229,16 +257,18 @@ static int adc_joystick_probe(struct
> > > > >> > platform_device *pdev)
> > > > >> >  		return error;
> > > > >> >  	}
> > > > >> >
> > > > >> > -	joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);
> > > > >> > -	if (IS_ERR(joy->buffer)) {
> > > > >> > -		dev_err(dev, "Unable to allocate callback buffer\n");
> > > > >> > -		return PTR_ERR(joy->buffer);
> > > > >> > -	}
> > > > >> > +	if (!joy->polled) {
> > > > >> > +		joy->buffer = iio_channel_get_all_cb(dev, adc_joystick_handle, joy);  
> > > > >> Please maintain line discipline of 80 chars to stay consistent with
> > > > >> the rest
> > > > >> of this driver.  
> > > > >
> > > > > Understood, sorry about that.
> > > > >  
> > > > >> > +		if (IS_ERR(joy->buffer)) {
> > > > >> > +			dev_err(dev, "Unable to allocate callback buffer\n");
> > > > >> > +			return PTR_ERR(joy->buffer);
> > > > >> > +		}
> > > > >> >
> > > > >> > -	error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > > >> > joy->buffer);
> > > > >> > -	if (error)  {
> > > > >> > -		dev_err(dev, "Unable to add action\n");
> > > > >> > -		return error;
> > > > >> > +		error = devm_add_action_or_reset(dev, adc_joystick_cleanup,
> > > > >> > joy->buffer);  
> > > > >> Same here.  
> > > > >
> > > > > Ditto.
> > > > >  
> > > > >>
> > > > >> Cheers,
> > > > >> Artur  
> > > > >> > +		if (error)  {
> > > > >> > +			dev_err(dev, "Unable to add action\n");
> > > > >> > +			return error;
> > > > >> > +		}
> > > > >> >  	}
> > > > >> >
> > > > >> >  	return 0;  

