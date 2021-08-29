Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558093FA83B
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 04:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhH2CeW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Aug 2021 22:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhH2CeV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Aug 2021 22:34:21 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E5BC061756;
        Sat, 28 Aug 2021 19:33:30 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b4so3031343qtx.0;
        Sat, 28 Aug 2021 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qyyw88XUoVSPXUSIJPLbWlKHnsd2Pz+wgMDoo6t0tsE=;
        b=oSFf4Anr9+dpcNVMfxqVPktR38wBMnQJwfdEznhZStCq9viDUD7g7IYsaYxm6TjC76
         aPHuKHbbNWgPzkY0TcyLEKcimKxL2sSIwzuLo3cV4sC7IRRO2VeqycZeKVbZFqFDKpjs
         MaY0U5YJWeANpI+13egdVlHLV8H2QeJp6zzaO3LIuuFDt4/mpClZSScih0I17iv05hIW
         WjS0IjAQi19ahctWIqnoBY9XQFpBJkbO69Diz4STJmN5hM4DUF735gj0hoV0LAemEMsL
         y1KfRjEm8slBsyWLc3E18ZxZ2pabJxDrurlLlWw/KkhvN0Z4yGP6zf47eRrouAFwKqqI
         +yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyyw88XUoVSPXUSIJPLbWlKHnsd2Pz+wgMDoo6t0tsE=;
        b=lrmxn86hdHnwq0RQsx9JNwsui1R5aBbe0PkXUvfD7kyT5F/dMK84tvonbaQ5sKiWdJ
         5o3fnHWU7P7MhpSEDEvg+nG9I1Ntlb0OFvgEG/4kVyolOZ23lO5Q1uFDuys4gSjVNdx4
         gXX9mnkQePobol7uBJ215OHUn6gmBrxnla4FD/1MZJLXNQKAc7N1W+q4THFEx36PLqSt
         +mCwO76jqTW1/C2lrXuxpuvM0ERR/ZoHMM3xd0jXwtSjerm32THtFhaprM/1Z6BicHez
         7exEcDzdWR7gd61RZV7f7iVik8FaO7eIplTUIWienxJsQli7bsMnc4G/OKcY2i6PSy1B
         CpzQ==
X-Gm-Message-State: AOAM530Rd5FQw39lfzaHfn7DGr9K1d5+Xx4+PB37HLwSTEGzz9+fKEtN
        eMTWUzPYl5zetmRGVuFreGs=
X-Google-Smtp-Source: ABdhPJwuZe3JqEyYnyuJdrDAGGBvo9ZtETvYrKFyNsQaK00skNSb/e3vszPkSTcG741SQQs5f8w8MQ==
X-Received: by 2002:ac8:570e:: with SMTP id 14mr15041507qtw.302.1630204408075;
        Sat, 28 Aug 2021 19:33:28 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id d13sm2955406qtm.32.2021.08.28.19.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 19:33:27 -0700 (PDT)
Date:   Sat, 28 Aug 2021 22:33:25 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v8 12/14] iio: afe: rescale: add temperature transducers
Message-ID: <YSrx9WvzhBkrb7pq@shaak>
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-13-liambeguin@gmail.com>
 <e6815e85-2b0e-cb24-e677-c3324a299b3a@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6815e85-2b0e-cb24-e677-c3324a299b3a@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 26, 2021 at 10:56:11AM +0200, Peter Rosin wrote:
> On 2021-08-20 21:17, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> > 
> > A temperature transducer is a device that converts a thermal quantity
> > into any other physical quantity. This patch add support for temperature
> > to voltage (like the LTC2997) and temperature to current (like the
> > AD590) linear transducers.
> > In both cases these are assumed to be connected to a voltage ADC.
> > 
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > index 8cdcb6ffb563..12de44058bea 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -427,11 +427,38 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static int rescale_temp_transducer_props(struct device *dev,
> > +					 struct rescale *rescale)
> > +{
> > +	s32 offset = 0;
> > +	s32 sense = 1;
> > +	s32 alpha;
> > +	s64 tmp;
> > +	int ret;
> > +
> > +	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
> > +	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
> > +	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
> > +	if (ret) {
> > +		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	rescale->numerator = 1000000;
> > +	rescale->denominator = alpha * sense;
> > +
> > +	tmp = (s64)offset * (s64)alpha * (s64)sense;
> > +	rescale->offset = div_s64(tmp, (s32)1000000);
> 
> Error: Too many casts :-)

Oof! You're right, that doesn't look too good...

I guess I haven't looked at this part of the series for a few
revisions, my bad.

> 
> I think it would make sense to lose tmp, and just spell it out in one
> statement?
> 
> 	rescale->offset = div_s64((s64)offset * rescale->denominator,
> 				  rescale->numerator);
> 
> Because you are prepping the offset so that it will survive a later rescaler
> multiplication, and all the "random" multiplications and divisions don't
> make that very clear.
> 

Yeah, I agree! The way I had it spelled out wasn't much more readable.
I'll use your suggestion instead.

Thanks,
Liam

> Cheers,
> Peter
> 
> > +
> > +	return 0;
> > +}
> > +
> >  enum rescale_variant {
> >  	CURRENT_SENSE_AMPLIFIER,
> >  	CURRENT_SENSE_SHUNT,
> >  	VOLTAGE_DIVIDER,
> >  	TEMP_SENSE_RTD,
> > +	TEMP_TRANSDUCER,
> >  };
> >  
> >  static const struct rescale_cfg rescale_cfg[] = {
> > @@ -451,6 +478,10 @@ static const struct rescale_cfg rescale_cfg[] = {
> >  		.type = IIO_TEMP,
> >  		.props = rescale_temp_sense_rtd_props,
> >  	},
> > +	[TEMP_TRANSDUCER] = {
> > +		.type = IIO_TEMP,
> > +		.props = rescale_temp_transducer_props,
> > +	},
> >  };
> >  
> >  static const struct of_device_id rescale_match[] = {
> > @@ -462,6 +493,8 @@ static const struct of_device_id rescale_match[] = {
> >  	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
> >  	{ .compatible = "temperature-sense-rtd",
> >  	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
> > +	{ .compatible = "temperature-transducer",
> > +	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, rescale_match);
> > 
