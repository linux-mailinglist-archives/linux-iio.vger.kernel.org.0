Return-Path: <linux-iio+bounces-18604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88CA9BAC1
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39931BA4FE9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E962820A7;
	Thu, 24 Apr 2025 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT76fwMM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CF21FF5D;
	Thu, 24 Apr 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533565; cv=none; b=mUAMcD5Vtj2uThXYc7jiVHbFTUJznMA3FWdQGoILexjVytDtzDpaBwfIvD2+g4NZNQGGjKU/eV2iWCjlBF1E5EAyZc3MGGa4kMUhSLlekX64ingTU6OHM4bieSsfPHTbyr3X7l8PKw2Panhpc3wDVFbuTN0Poml8FU9JwXHMr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533565; c=relaxed/simple;
	bh=x1JeXYDycyPhhRDzf9nOC3JYpKenBeAbMMf4ArIJVw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssPKGEdFT4wdwWF+T6I4gfnZBGODv54wMc0bDGqv3Y96IB9lPONkSIRvi3wZY2w5yUuJQIJZOJwiXMny/gQM1ZIjs5u8xVgJ8TZMBQUSS11lBsqZ5kN+0MY1iWfwFswbSrRJ25OEZqGwtB4shLFQpmQYrNYAhgt4wx0DNkke/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT76fwMM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476a304a8edso19118091cf.3;
        Thu, 24 Apr 2025 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745533563; x=1746138363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hskQ1ynJFkhkNXvLvezLv/sYveihSvby6bDVtKjx3Vg=;
        b=ZT76fwMMLoHBte6fGCzZesYooFPEvvd7YC7b00UpG4ifrAhitKQpkWkgsbCLl4SCtz
         lMjUuhgXUu8RzzOnvuAObgHhYi9YkNjrdNF/5Bi7uAwF+8lu2K/DQM2mIBxTdefFoBdk
         gD6wbMNQchxMCxNEYnVP8EzM4fjF7Z1BKyVoj/EiawkcDkeEKnH7A4hTjEaAW1grJFRV
         /my3/1ajbKpYTbO7Pdfasl+iPhlRA2Xk1R3bmPuM/MLAkr2fAxGttz+11DW17Xpk3Rtw
         ejQ8S1DpOsQIhDg5GC9X3gm5bXQfaSL5GNn3hNXY/wQNESdn/9rMs160WaIrWmU+L6BF
         eflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745533563; x=1746138363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hskQ1ynJFkhkNXvLvezLv/sYveihSvby6bDVtKjx3Vg=;
        b=WJmgxN3nUbKbIJO/+TfjWAP7dr5gKd0DnzS4tmInwMXYbpucQpyMYHHMOmhqK3rNYx
         SK3n4ZFnQ9K7L71XyLf5pf0p3S3R1bdG1hX55iZm5XcghJ/sOKMrK6ZYELSCcZEU2q/9
         cuKzXSV/rUqwID2425HWInuuJcOiD4pZUpK33Cm12meUqOIhFcw8mbMAxz5D/D/b2B/Q
         n+PGJBglNvOcpDayZhN6ulGeSfVnr0UOZunALZIAFyYlf2GtHF9OVI73sZFuzCN6ERQn
         tu8mFbVS+ccFuHvuhz94/lbsxnJOGImHl6yH8NwM9sF7NXwgC4Wp1A3Vt6lpFZQIefin
         XLCg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/3Scxv7xqoes2n19bMVzzBOpPCmi/ZLZfJPQ1pClWKBXk5Q6BgkwFJC1/qqGK0nSgsdNtiWlR6fUYEor@vger.kernel.org, AJvYcCXjUQIB9eAMGlY2dmVJlo+367Xt4sF08V1vZ8oBsHhPV9b+VJcvsMYYsj1yYbvAL6AltNWuqtYnOn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbXxc5K+vVbJ7jpb/6+cS9Qni8du+5PUyJOJv8x27xAoXj0va
	ABvHa9B6/ogXUcSDYmNQdjgAvq7fyj/4n8Vc3kFA6gfx3b+tUZMqvOnTUHX33X4kNyKh6Uj2Jnc
	ggP82d0okv1x3tSbxflZWS4veLe8=
X-Gm-Gg: ASbGncu6dgV60qSAx2O5K9yyRQjKP1zA2iFJpCvaFOB2VtpjXDMkd/fVY7TJm/ZFXjE
	NJmb8c8DwM7yr30dBnO8QL30dCYTsOppAAtY5aqbRgNi52lHjkJsFt8yhchufRgOUliSFHpXZcP
	qkoyzt0+8UWsS3pd7369yrwGXHqhP+MbITAMQCbGr7bEXQP0Nm61jXcQ==
X-Google-Smtp-Source: AGHT+IFjSFl/xi4ItiZrw0T45ArRRtekfyoiPWNkdF1dxtevOLykqT+7muP77ZbSHM73ktdY/vnuknex42pfIFNB9Lg=
X-Received: by 2002:a05:622a:203:b0:477:64dd:575b with SMTP id
 d75a77b69052e-4801eada7b1mr1841381cf.45.1745533562732; Thu, 24 Apr 2025
 15:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420175419.889544-1-gshahrouzi@gmail.com> <20250420175419.889544-3-gshahrouzi@gmail.com>
 <20250421123728.1564039d@jic23-huawei>
In-Reply-To: <20250421123728.1564039d@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Thu, 24 Apr 2025 18:25:51 -0400
X-Gm-Features: ATxdqUFwcTzPdHn9XuiewQEmXMXyqrRqiIsLo1lnCsCOfLX_uZgjCo5No3ZV5uc
Message-ID: <CAKUZ0zKXg4KLpHPLtpkywPLp8+xxwAMSpNAgUmP34pfVZDv7Aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] staging: iio: ad9832: Refactor powerdown control
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:37=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 20 Apr 2025 13:54:18 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > Replace custom implementation with out_altvoltage_powerdown ABI. The
> > attribute's logic is inverted (1 now enables powerdown) to match the
> > standard. Modernize driver by using the standard IIO interface.
> >
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 44 ++++++++++++++++++--------
> >  1 file changed, 30 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/i=
io/frequency/ad9832.c
> > index 0872ff4ec4896..a8fc20379efed 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -167,6 +167,34 @@ static int ad9832_write_phase(struct ad9832_state =
*st,
> >       return spi_sync(st->spi, &st->phase_msg);
> >  }
> >
> > +static ssize_t ad9832_write_powerdown(struct device *dev, struct devic=
e_attribute *attr,
> > +                                   const char *buf, size_t len)
> > +{
> > +     struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > +     struct ad9832_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +     unsigned long val;
> > +
> > +     ret =3D kstrtoul(buf, 10, &val);
> > +     if (ret)
> > +             goto error_ret;
> > +
> > +     mutex_lock(&st->lock);
>
> Look at how guard(mutex)(&st->lock);
> can be used in this driver to simplify things considerably.
Noted, added into new version.
> May make sense to do that before introducing this new code.
Not sure whether to have made it its own patch or not. I grouped it
together with the new code since it also uses locking.
>
> > +     if (val)
> > +             st->ctrl_src |=3D AD9832_SLEEP;
> > +     else
> > +             st->ctrl_src &=3D ~(AD9832_RESET | AD9832_SLEEP |
> > +                              AD9832_CLR);
> > +
> > +     st->data =3D cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> > +                             st->ctrl_src);
> > +     ret =3D spi_sync(st->spi, &st->msg);
> > +     mutex_unlock(&st->lock);
> > +
> > +error_ret:
> > +     return ret ? ret : len;
> > +}
> > +
> >  static ssize_t ad9832_write(struct device *dev, struct device_attribut=
e *attr,
> >                           const char *buf, size_t len)
> >  {
> > @@ -227,17 +255,6 @@ static ssize_t ad9832_write(struct device *dev, st=
ruct device_attribute *attr,
> >                                       st->ctrl_fp);
> >               ret =3D spi_sync(st->spi, &st->msg);
> >               break;
> > -     case AD9832_OUTPUT_EN:
> > -             if (val)
> > -                     st->ctrl_src &=3D ~(AD9832_RESET | AD9832_SLEEP |
> > -                                     AD9832_CLR);
> > -             else
> > -                     st->ctrl_src |=3D AD9832_SLEEP;
> > -
> > -             st->data =3D cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_S=
HIFT) |
> > -                                     st->ctrl_src);
> > -             ret =3D spi_sync(st->spi, &st->msg);
> > -             break;
> >       default:
> >               ret =3D -ENODEV;
> >       }
> > @@ -266,8 +283,7 @@ static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"=
); /* 2PI/2^12 rad*/
> >
> >  static IIO_DEV_ATTR_PINCONTROL_EN(0, 0200, NULL,
> >                               ad9832_write, AD9832_PINCTRL_EN);
> > -static IIO_DEV_ATTR_OUT_ENABLE(0, 0200, NULL,
> > -                             ad9832_write, AD9832_OUTPUT_EN);
> > +static IIO_DEVICE_ATTR(out_altvoltage_powerdown, 0200, NULL, ad9832_wr=
ite_powerdown, 0);
>
> Take a look at the use of extended attributes used for this like we see
> in ad5064.c
> That will need an actual channel though so is a more significant rework.
Got it.
>
> >
> >  static struct attribute *ad9832_attributes[] =3D {
> >       &iio_dev_attr_out_altvoltage0_frequency0.dev_attr.attr,
> > @@ -281,7 +297,7 @@ static struct attribute *ad9832_attributes[] =3D {
> >       &iio_dev_attr_out_altvoltage0_pincontrol_en.dev_attr.attr,
> >       &iio_dev_attr_out_altvoltage0_frequencysymbol.dev_attr.attr,
> >       &iio_dev_attr_out_altvoltage0_phasesymbol.dev_attr.attr,
> > -     &iio_dev_attr_out_altvoltage0_out_enable.dev_attr.attr,
> > +     &iio_dev_attr_out_altvoltage_powerdown.dev_attr.attr,
> >       NULL,
> >  };
> >
>

