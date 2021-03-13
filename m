Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B06339FD3
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbhCMS0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 13:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233635AbhCMS0D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 13:26:03 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794B564E58;
        Sat, 13 Mar 2021 18:26:02 +0000 (UTC)
Date:   Sat, 13 Mar 2021 18:25:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2 v4] hwmon: (ntc_thermistor): try reading processed
Message-ID: <20210313182558.1120c09f@archlinux>
In-Reply-To: <20210309171501.GB172171@roeck-us.net>
References: <20210308100219.2732156-1-linus.walleij@linaro.org>
        <20210308100219.2732156-2-linus.walleij@linaro.org>
        <20210309171501.GB172171@roeck-us.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 9 Mar 2021 09:15:01 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, Mar 08, 2021 at 11:02:19AM +0100, Linus Walleij wrote:
> > Before trying the custom method of reading the sensor
> > as raw and then converting, we want to use
> > iio_read_channel_processed_scale() which first tries to
> > see if the ADC can provide a processed value directly,
> > else reads raw and applies scaling inside of IIO
> > using the scale attributes of the ADC. We need to
> > multiply the scaled value with 1000 to get to
> > microvolts from millivolts which is what processed
> > IIO channels returns.
> > 
> > Keep the code that assumes 12bit ADC around as a
> > fallback.
> > 
> > This gives correct readings on the AB8500 thermistor
> > inputs used in the Ux500 HREFP520 platform for reading
> > battery and board temperature.
> > 
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: Chris Lesiak <chris.lesiak@licor.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org
> > Link: https://lore.kernel.org/linux-iio/20201224011607.1059534-1-linus.walleij@linaro.org/
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>  
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Up to Jonathan to decide if he wants to take both patches.
It seems unlikely that it will cause trouble in either tree (as the code
in question isn't changing that often). So on basis Guenter already acked
I'll pick them up through IIO.

Applied to the togreg branch of iio.git and pushed out as testing to
see if the autobuilders notice anything we missed.
thanks,

Jonathan

> 
> Thanks,
> Guenter
> 
> > ---
> > ChangeLog v3->v4:
> > - Split out the new iio_read_channel_processed_scale()
> >   API addition to a separate patch.
> > - My suggestion is to apply both patches to the hwmon
> >   tree.
> > ChangeLog v2->v3:
> > - After discussion about v2 we concludes that
> >   iio_read_channel_processed() could loose precision
> >   so we introduce a new API to read processed and
> >   scale.
> > - Include a link to the v2 discussion for reference.
> > - For ease of applying to the hwmon tree, keep it all
> >   in one patch.
> > - This needs Jonathans ACK to be merged through hwmon.
> > ChangeLog v1->v2:
> > - Fix the patch to multiply the processed value by
> >   1000 to get to microvolts from millivolts.
> > - Fix up the confusion in the commit message.
> > - Drop pointless comments about the code, we keep the
> >   original code path around if processed reads don't
> >   work, nothing bad with that.
> > ---
> >  drivers/hwmon/ntc_thermistor.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> > index 3aad62a0e661..8587189c7f15 100644
> > --- a/drivers/hwmon/ntc_thermistor.c
> > +++ b/drivers/hwmon/ntc_thermistor.c
> > @@ -326,18 +326,27 @@ struct ntc_data {
> >  static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
> >  {
> >  	struct iio_channel *channel = pdata->chan;
> > -	int raw, uv, ret;
> > +	int uv, ret;
> >  
> > -	ret = iio_read_channel_raw(channel, &raw);
> > +	ret = iio_read_channel_processed_scale(channel, &uv, 1000);
> >  	if (ret < 0) {
> > -		pr_err("read channel() error: %d\n", ret);
> > -		return ret;
> > -	}
> > +		int raw;
> >  
> > -	ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
> > -	if (ret < 0) {
> > -		/* Assume 12 bit ADC with vref at pullup_uv */
> > -		uv = (pdata->pullup_uv * (s64)raw) >> 12;
> > +		/*
> > +		 * This fallback uses a raw read and then
> > +		 * assumes the ADC is 12 bits, scaling with
> > +		 * a factor 1000 to get to microvolts.
> > +		 */
> > +		ret = iio_read_channel_raw(channel, &raw);
> > +		if (ret < 0) {
> > +			pr_err("read channel() error: %d\n", ret);
> > +			return ret;
> > +		}
> > +		ret = iio_convert_raw_to_processed(channel, raw, &uv, 1000);
> > +		if (ret < 0) {
> > +			/* Assume 12 bit ADC with vref at pullup_uv */
> > +			uv = (pdata->pullup_uv * (s64)raw) >> 12;
> > +		}
> >  	}
> >  
> >  	return uv;
> > -- 
> > 2.29.2
> >   

