Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4663FA842
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 04:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhH2Cvt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Aug 2021 22:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhH2Cvs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Aug 2021 22:51:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683CC061756;
        Sat, 28 Aug 2021 19:50:57 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 14so11799961qkc.4;
        Sat, 28 Aug 2021 19:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bSFSnBg/LwKqVLw8WSTQhnXu1cC1HTBzcNRsDCdhXyI=;
        b=c3HwxsSoQzxR7C7XPdiJn7TnB3h6Rw+zH+o53xB6LeH+idmoMcQ5mjKM+7naWUdcz/
         IwuqKtUp47+JXfhdSbpOCZiVCtl9wTgFJJXQ+YVb7IbF+6IGqan0OvqXmP+LphfvgFJI
         Uvo3nZvSz6uvOSh2NflY+aIAZMl/QU1KVNHd4pt4uwO7uSfA6YbcIs1vGEx6IzSBP/Op
         egsndoLfw+l15zJzmeHet8iqCf9cWlFnS6Uvo0VleAKXcMlqZsB/GnRORTwDHUkS7UbJ
         8qGFsfNVQZXg2sRO9agEyWHr8SORcWGHPiVmlPOUExgqmGYDyGC/8CYhIPxhSv5L8gbU
         FqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSFSnBg/LwKqVLw8WSTQhnXu1cC1HTBzcNRsDCdhXyI=;
        b=hufaiQB0d+BWTbhGIlyXfyxIo+SBnSpTPKrz4F3vEp4b2D2//+5VgZ6sUIi+/BDAg8
         FbrBWpHpJBLw9Dl1ZMiECeNTAqUjdPoZcBNgz6mk/0xVtr1HsehOdIz7L4bSEUGKsJ21
         XvLoMIp0GhJjJcwwaQaKLfcC/b5hA+1Laim+eb3xLhELRHjLqtCkMXTb0usAhlOMnY9R
         GaRSdHJN5t3BTlJlLdQHsN0+KNFYO2PfDQ7YiAgE46l2U/IZNYyqviUjMKPwFixMCu/n
         9TprFFTIQAATpyLh8jjlYzO230spZLxAOIT8jctKrAuQdMhCLlgjhjSiygXlnu324BbU
         LAoA==
X-Gm-Message-State: AOAM531tgbifdhyj/WGRL7CqJ/3QiX8GfGE+8yOhSZ+HfEiizOGnWDYc
        Wgp9CvpP2ie2P8kpP+TmI8A=
X-Google-Smtp-Source: ABdhPJyiZN8wYO8oICNnUqI378WPKn09ZIn3CET5t1Fi6X+35hGpvFdAIGqJi3Kfye8bbYeDcvFBkg==
X-Received: by 2002:a05:620a:675:: with SMTP id a21mr16184628qkh.421.1630205456157;
        Sat, 28 Aug 2021 19:50:56 -0700 (PDT)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id d78sm8180916qkg.92.2021.08.28.19.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 19:50:55 -0700 (PDT)
Date:   Sat, 28 Aug 2021 22:50:53 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v8 05/14] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
Message-ID: <YSr2DSnyB205FnTI@shaak>
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-6-liambeguin@gmail.com>
 <9a7aa55f-0dd0-3fc7-13a4-5cb9c5d0a252@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a7aa55f-0dd0-3fc7-13a4-5cb9c5d0a252@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 26, 2021 at 10:11:18AM +0200, Peter Rosin wrote:
> On 2021-08-20 21:17, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> > 
> > Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> > Add support for these to allow using the iio-rescaler with them.
> > 
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > index d0669fd8eac5..8488f1d83527 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -22,6 +22,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> >  			  int *val, int *val2)
> >  {
> >  	unsigned long long tmp;
> > +	s32 rem;
> > +	u32 mult;
> > +	u32 neg;
> >  
> >  	switch (scale_type) {
> >  	case IIO_VAL_FRACTIONAL:
> > @@ -40,6 +43,38 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> >  		tmp *= rescale->numerator;
> >  		do_div(tmp, 1000000000LL);
> >  		*val = tmp;
> > +		return scale_type;
> > +	case IIO_VAL_INT_PLUS_NANO:
> > +	case IIO_VAL_INT_PLUS_MICRO:
> > +		if (scale_type == IIO_VAL_INT_PLUS_NANO)
> > +			mult = 1000000000LL;
> > +		else
> > +			mult = 1000000LL;
> > +		/*
> > +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
> > +		 * *val2 is negative the schan scale is negative
> 
> The last line doesn't parse for me. It doesn't end with a period either, so
> it looks like you moved on before you finished it?

I meant to warn that IIO_VAL_INT_PLUS_{MICRO,NANO} are a little odd, and
that if either one *val or *val2 is negative, the result will be
negative.

i.e. *val = 1 and *val2 = -0.5 gives -1.5 and not 0.5.

I'll give it another try and will add the period.

Thanks,
Liam

> 
> Cheers,
> Peter
> 
> > +		 */
> > +		neg = *val < 0 || *val2 < 0;
> > +
> > +		tmp = (s64)abs(*val) * abs(rescale->numerator);
> > +		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
> > +
> > +		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
> > +		tmp = div_s64(tmp, abs(rescale->denominator));
> > +
> > +		*val += div_s64_rem(tmp, mult, val2);
> > +
> > +		/*
> > +		 * If only one of the rescaler elements or the schan scale is
> > +		 * negative, the combined scale is negative.
> > +		 */
> > +		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
> > +			if (*val)
> > +				*val = -*val;
> > +			else
> > +				*val2 = -*val2;
> > +		}
> > +
> >  		return scale_type;
> >  	default:
> >  		return -EOPNOTSUPP;
> > 
