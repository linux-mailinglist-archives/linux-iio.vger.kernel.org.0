Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25713BB655
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 06:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGEEaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 00:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhGEEaR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 00:30:17 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4CC061574;
        Sun,  4 Jul 2021 21:27:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f13so11452738qtb.6;
        Sun, 04 Jul 2021 21:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:from:to:cc
         :subject:references:in-reply-to;
        bh=qH6oMDtBj1je/5jdsbsyT8hvJt3UlO2jFFvvqcLcxqc=;
        b=pArfXf7P0C01KaK8r4duyz2sTzBDYo29YkFJ/Zph4mWS/a3LUYU9WiE8Wmbrv4Fv+1
         FcR9w6196fhzJyvFRRLCObOlurV/CtItK/OHvvoQGLWE5pThxPHjGyqenfYCzkGP20VV
         K+oIUgyVqCRVlGfcO7YohosnLV6gSxZoqJXd1jTQKefMt9CK+Czq6xoVnMPjaW2MdoZH
         tr2RuaeQ+xRnscYO2lW3WFOHdx+TgrlH5Sa3xUu6DuAeQs2+eamB32SCtPpkJ3Z7Q623
         p4xKxYqTXyt3ELz97cxsK3eN9oOBsRfpUFtqr7lvgkuQg4tUA5lRy//bXrpkNScIIM0G
         i+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:from:to:cc:subject:references:in-reply-to;
        bh=qH6oMDtBj1je/5jdsbsyT8hvJt3UlO2jFFvvqcLcxqc=;
        b=iSokzjrR7hzHGy+olnOQcLkydqJy5rVNYwHlXurF8kmfcqHpQQQGMjDxOTMfeG9f74
         8nqWu815TuR2vBF+1dl0/cXDls1oTkfkUgJJchjPGZnONebBgn0sG+fEhIGZSV/Ne76L
         h2+GLiDujxMUFxMH0ss2xZUlJ6o1NyxKU02IPNC1PyDRsy8wVVA9p3vNZWswa2FH9fMO
         7hDPWdLxQkQqQL7zWdePQzR8Me8+G8+nebnf1HKQ7QwSPXXcF3POyFMk8Lv47AzpmS2Z
         OM2JU0Jkt55MHMTALWQGJS/VWFb7ck+WID18Z6mWkkrKjyIBKL3vr2Jfkm5lzZnaId4k
         iGYw==
X-Gm-Message-State: AOAM532edj4mADZVYJH0EUWSJtn4tSvx1YREZLf6F/GN+lACd+Lsu8dL
        1bDGJcrm+jc5xQ/3FZQeeZc=
X-Google-Smtp-Source: ABdhPJzbuOlyWDLMcNv1uVNcDS1pWJqQ6PfO6mHjmG+SggOgObOoJTsGT2MlX49w80VQI11Hal6RUw==
X-Received: by 2002:ac8:44c5:: with SMTP id b5mr10964464qto.134.1625459260431;
        Sun, 04 Jul 2021 21:27:40 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n184sm392716qkb.22.2021.07.04.21.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 21:27:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 05 Jul 2021 00:27:38 -0400
Message-Id: <CCKX7UWQRUHC.14MWMP0T57BUK@shaak>
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     <peda@axentia.se>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 06/10] iio: afe: rescale: add offset support
References: <20210701010034.303088-1-liambeguin@gmail.com>
 <20210701010034.303088-7-liambeguin@gmail.com>
 <20210704175352.586c9ae8@jic23-huawei>
In-Reply-To: <20210704175352.586c9ae8@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun Jul 4, 2021 at 12:53 PM EDT, Jonathan Cameron wrote:
> On Wed, 30 Jun 2021 21:00:30 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > This is a preparatory change required for the addition of temperature
> > sensing front ends.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> Hi Liam.
>
> A few remaining things inline.
>
> Looking good in general.
>
> Jonathan
>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 63 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index 8f79c582519c..c8750286c308 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -32,6 +32,7 @@ struct rescale {
> >  	bool chan_processed;
> >  	s32 numerator;
> >  	s32 denominator;
> > +	s32 offset;
> >  };
> > =20
> >  static int rescale_read_raw(struct iio_dev *indio_dev,
> > @@ -39,6 +40,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev=
,
> >  			    int *val, int *val2, long mask)
> >  {
> >  	struct rescale *rescale =3D iio_priv(indio_dev);
> > +	int scale, scale2;
> > +	int schan_off =3D 0;
> >  	s64 tmp, tmp2;
> >  	u32 factor;
> >  	int ret;
> > @@ -99,6 +102,62 @@ static int rescale_read_raw(struct iio_dev *indio_d=
ev,
> >  			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
> >  			return -EOPNOTSUPP;
> >  		}
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		/*
> > +		 * Processed channels are scaled 1-to-1 and source offset is
> > +		 * already taken into account.
> > +		 *
> > +		 * In other cases, the final offset value is defined by:
> > +		 *	offset =3D schan_offset + rescaler_offset / schan_scale
>
> Maths is right, but perhaps useful to express how this is derived as I
> had
> to scribble it down to check.
>
> Want to express real world measurement as:
> scale * (raw + offset)
> Given we applying scale and offset recursively we have.
> rescaler_scale * (schan_scale * (raw + schan_offset) + rescaler_offset)
> which can be rearrange into the correct form at.
> rescaler_scale *schan_scale* (raw + (schan_offset +
> rescaler_offset/schan_scale))
> Thus the scale and offset we expose to userspace should be.
> scale =3D rescaler_scale * schan_scale
> offset =3D schan_offset + rescaler_offset/schan_scale;
>

Understood, I'll update the comment with more details.

>
> > +		 */
> > +		if (rescale->chan_processed) {
> > +			*val =3D rescale->offset;
> > +			return IIO_VAL_INT;
> > +		}
> > +
> > +		if (iio_channel_has_info(rescale->source->channel,
> > +					 IIO_CHAN_INFO_OFFSET)) {
> > +			ret =3D iio_read_channel_offset(rescale->source,
> > +						      &schan_off, NULL);
> > +			if (ret < 0)
> > +				return ret;
> if you've returned in the first branch of the if, no need to worry about
> the
> else for checking the second condition.
>
> if (ret !=3D IIO_VAL_INT)
> return...

Right, I'll combine both statements.

>
>
> > +			else if (ret !=3D IIO_VAL_INT)
> > +				return -EOPNOTSUPP;
> > +		}
> > +
> > +		ret =3D iio_read_channel_scale(rescale->source, &scale, &scale2);
> > +		switch (ret) {
> > +		case IIO_VAL_FRACTIONAL:
> > +			tmp =3D (s64)rescale->offset * scale2;
> > +			*val =3D div_s64(tmp, scale) + schan_off;
> > +			return IIO_VAL_INT;
> > +		case IIO_VAL_INT:
> > +			*val =3D div_s64(rescale->offset, scale) + schan_off;
> > +			return IIO_VAL_INT;
> > +		case IIO_VAL_FRACTIONAL_LOG2:
> > +			tmp =3D (s64)rescale->offset * (1 << scale2);
> > +			*val =3D div_s64(tmp, scale) + schan_off;
> > +			return IIO_VAL_INT;
> > +		case IIO_VAL_INT_PLUS_NANO:
> > +			tmp =3D (s64)rescale->offset * 1000000000UL;
> > +			tmp2 =3D ((s64)scale * 1000000000UL) + scale2;
> > +			factor =3D gcd(tmp, tmp2);
> > +			tmp /=3D factor;
> > +			tmp2 /=3D factor;
>
> What is the benefit to doing gcd division before div_s64?
>

You're right the GCD division is unnecessary here, will drop.

> > +			*val =3D div_s64(tmp, tmp2) + schan_off;
> > +			return IIO_VAL_INT;
> > +		case IIO_VAL_INT_PLUS_MICRO:
> > +			tmp =3D (s64)rescale->offset * 1000000UL;
> > +			tmp2 =3D ((s64)scale * 1000000UL) + scale2;
> > +			factor =3D gcd(tmp, tmp2);
> > +			tmp /=3D factor;
> > +			tmp2 /=3D factor;
> > +			*val =3D div_s64(tmp, tmp2) + schan_off;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
> > +			return -EOPNOTSUPP;
> > +		}
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -175,6 +234,9 @@ static int rescale_configure_channel(struct device =
*dev,
> >  	chan->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> >  		BIT(IIO_CHAN_INFO_SCALE);
> > =20
> > +	if (rescale->offset)
> > +	    chan->info_mask_separate |=3D BIT(IIO_CHAN_INFO_OFFSET);
> > +
> >  	/*
> >  	 * Using .read_avail() is fringe to begin with and makes no sense
> >  	 * whatsoever for processed channels, so we make sure that this canno=
t
> > @@ -339,6 +401,7 @@ static int rescale_probe(struct platform_device *pd=
ev)
> >  	rescale->cfg =3D of_device_get_match_data(dev);
> >  	rescale->numerator =3D 1;
> >  	rescale->denominator =3D 1;
> > +	rescale->offset =3D 0;
> > =20
> >  	ret =3D rescale->cfg->props(dev, rescale);
> >  	if (ret)

