Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9593A1F21
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhFIVmp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 17:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFIVmo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 17:42:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA733C061574;
        Wed,  9 Jun 2021 14:40:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v6so10392819qta.9;
        Wed, 09 Jun 2021 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=o8vwUO7Ou0SgF4Om1A9WkjLzG/3i2I3KgZqP/A+BMr4=;
        b=PsvTkPLQ5cdcBDnfUiKTgBdw87hHptYfJ6GtPhP2MX2gm8J/RvJAswXOaDwkgb9UJG
         V1yLtvXUJx8sktb6olS6FaArqtG9/s6KE4KLheHy+QXH6y4czXuZ9cpNW0CFbqKmLRhf
         EChfI37H/SttSSPVVnNpxP8B1cgXpGbO86YwwJRu7dMSJZzTqIN3PBvofRq2ikT9ScCf
         TxkU6Grgv+F6PNqKTHuGcjkUgmkx5MA17GBcPMIA3JXR2gjjM7C/qfRruq0d7ilkC4YQ
         lvsfCYrbl42x9cZC1dj618v4zkccgp/QbUNQdKYaBTGynCZOyB/l1LK+sDJYvJvSq7i+
         O7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=o8vwUO7Ou0SgF4Om1A9WkjLzG/3i2I3KgZqP/A+BMr4=;
        b=bMJiOiAamdX6PhA6SqCGzUBbUNpQQaMyvSi9BEmNBOo0+HdpElDjltD55xijjACJHa
         dYDGtFExGGAFCLEBL5/PEq0PDYYOa8lKyX8anRkELLnAYjf7codSOlt5BxnJEXRfavf5
         RXgFdERARn6TNzJCrdjLg9IMt6j2UlMuRmXTovgmAoMcVkP1kF4TUuS7A1gP2CFcdply
         8Lx71eIsGM78AHzR3VOCvhg1JlBSL0NaNRyiW1sFwu+7x7mA7Iftg33FXLMRooy0c2mK
         PAIBHi/+U9RcURSbsCeOmc1IprC5HkH5/W9o5CBnKB+DXT0+Dg6Ov17wbIxwhRrTmEvz
         D5bQ==
X-Gm-Message-State: AOAM533yu10QjXV3VgM/kqhU0e7Il+Y58SHzebJcjGx6yjxM5R2ITJbY
        UV/QWdxMV96ybrRfuNnI0Y3TyXJ/cb74dg==
X-Google-Smtp-Source: ABdhPJwHUm1XsyfAT9wCerB7Q4IQcXqz676XhNQYVAtK/LZkcYofVoeSBMrvAsbpRLSSQpETinInbg==
X-Received: by 2002:ac8:5c48:: with SMTP id j8mr2103460qtj.154.1623274848979;
        Wed, 09 Jun 2021 14:40:48 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j62sm924497qkf.125.2021.06.09.14.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:40:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 09 Jun 2021 17:40:47 -0400
Message-Id: <CBZEWQ0YIIEC.3A2WESVVMHPJM@shaak>
Cc:     <peda@axentia.se>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/8] iio: inkern: error out on unsupported offset
 type
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
 <20210607144718.1724413-4-liambeguin@gmail.com>
 <20210609212850.008d7f84@jic23-huawei>
In-Reply-To: <20210609212850.008d7f84@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Wed Jun 9, 2021 at 4:28 PM EDT, Jonathan Cameron wrote:
> On Mon, 7 Jun 2021 10:47:13 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > iio_convert_raw_to_processed_unlocked() assumes the offset is an
> > integer.
> > Make that clear to the consumer by returning an error on unsupported
> > offset types without breaking valid implicit truncations.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/inkern.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index b69027690ed5..0b5667f22b1d 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -578,13 +578,37 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
> >  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *c=
han,
> >  	int raw, int *processed, unsigned int scale)
> >  {
> > -	int scale_type, scale_val, scale_val2, offset;
> > +	int scale_type, scale_val, scale_val2;
> > +	int offset_type, offset_val, offset_val2;
> >  	s64 raw64 =3D raw;
> > -	int ret;
> > =20
> > -	ret =3D iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
> > -	if (ret >=3D 0)
> > -		raw64 +=3D offset;
> > +	offset_type =3D iio_channel_read(chan, &offset_val, &offset_val2,
> > +				       IIO_CHAN_INFO_OFFSET);
> > +	if (offset_type >=3D 0) {
> > +		switch (offset_type) {
> > +		case IIO_VAL_INT:
> > +			break;
> > +		case IIO_VAL_INT_PLUS_MICRO:
> > +			if (offset_val2 > 1000)
>
> What's the logic behind this one? > 1000000
> would be an interesting corner case, though I'm not sure we've ever
> explicitly disallowed it before.
>
> Why are we at 1000th of that for the check?
>

For these the idea was to go with one milli of precision.
I don't know if that's a good criteria but I wanted to start with
something. Do you have any suggestions?

> > +				return -EINVAL;
> > +			break;
> > +		case IIO_VAL_INT_PLUS_NANO:
> > +			if (offset_val2 > 1000000)
>
> Similar this is a bit odd.
>
> > +				return -EINVAL;
> > +		case IIO_VAL_FRACTIONAL:
> > +			if (offset_val2 !=3D 1)
> > +				return -EINVAL;
>
> We could be more flexible on this, but I don't recall any
> channels using this so far.
>
> > +			break;
> > +		case IIO_VAL_FRACTIONAL_LOG2:
> > +			if (offset_val2)
> > +				return -EINVAL;
>
> Same in this case.
>

For these two cases, I went with what Peter suggested in the previous
version, to not break on valid implicit truncations.

What would be a good precision criteria for all offset types?

> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		raw64 +=3D offset_val;
> > +	}
> > =20
> >  	scale_type =3D iio_channel_read(chan, &scale_val, &scale_val2,
> >  					IIO_CHAN_INFO_SCALE);

Thanks for looking at this,
Liam
