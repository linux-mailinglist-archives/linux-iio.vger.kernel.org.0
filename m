Return-Path: <linux-iio+bounces-20832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED8AE2B4E
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 20:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2115618958E9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D17126A0F2;
	Sat, 21 Jun 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8OYNlCR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2B2036ED;
	Sat, 21 Jun 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750532078; cv=none; b=jIE33rU96arSnJOCQ0wk81pRcXPD5aTeFAAlmeQp9k1iugyrPUsr4sDWrlnGYgqbXPEFAldEBSHUkaex4DoClP7DoL2x3EmHKljUQs2Y0cyPGM3Zuu3UIWNchoB5D3OE2fRpb/yaCDNTfoPQ4Nxyt4VIDpXbOH2HPLuOOtyLa3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750532078; c=relaxed/simple;
	bh=I7SHUy6DKxGY4qxGAYqD8q8Jtc1LLybDSKRrQonjoKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/38gCBKjV34z6zuFh0DDLE6QvjhBAFGpVPEZsuu/VR1Ovfe5J3N2v+Fc8n1Molyz7mmgg9+QdRSu4+dXCI/P3GhLyvv7oC0zG1SdvcKTn3f7jmBvBf4BFDft377mlHYeg+TphxSFooM137VaKj62LXv4VwcOhqYp6+NLIYeLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8OYNlCR; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e83199d55a0so350984276.3;
        Sat, 21 Jun 2025 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750532074; x=1751136874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2qckyOsqB8VW6uHaBqylbBJUmynOcUW3ziq8cxMk9s=;
        b=i8OYNlCRCMZwVgLQ9HwaP1LU+1NXDF3YNcEwXQU5izUOZHdVmYRx6er42YsQDa1rCE
         kp01Q5QBfSXso0ptR+PvkGgGKgbGvsDKlqpVmJfIJJx0kbtF3zx6ZY2tmp4x5lYNjGhY
         VR4Htgpiux05gHgmHvPvsmhT/xFiTD6UICBEJCISpJyloFka/HxoXRjKZbBvwav0JKll
         k7SgeFXOZcMWxS+kBlcng5Vjl90NrZq2Y21FNBPBBTAYB0y9Zb2bwtHa4yTTlrI2m0WT
         jWFT32fDq5V80bisCaD9QyNCMODSQ5uDVappPXU5oMDEMvKCxzQQPVtokJgdNuuH4Pq7
         TwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750532074; x=1751136874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2qckyOsqB8VW6uHaBqylbBJUmynOcUW3ziq8cxMk9s=;
        b=RdK9aqXGCxfP3VY7MLWeOAvaOSKpBxLjklapK0zrCxcbsmo6c14105jgqrkq0BjRhJ
         iS16zwifdhn1MsfUug7ustliK+2wlX//IoGrVreDZ1TAkX6Zr9WNBOfpf5T3RVMbvxGc
         xnXhHzP4ZDRucckdR0UUJLqDcXDnPWNFXbuTlybC2ihDPZnFWykVWYCRFnUA8wK+LSG+
         WvBb1OxNcbYd9lcedyPyLD7kO3Vh5BA9NrrjpgV9+PCoj8AuTRYXnanpONs2glG7Um2z
         WywUJN0kADNXex9nkX4KLhL41WbrTrPYPtTTLCq74Nd+TqR0y0BDkOWPge6zBwh8RhFf
         s7bA==
X-Forwarded-Encrypted: i=1; AJvYcCVdhukmpV2VQMxJGyfoWCJTmT0J8U3ASSA6GLgPCEKvzc50wgaZgBztHpJCMU9AZvVc2xhEfnlhsW0=@vger.kernel.org, AJvYcCWHjuMsTnisQIDPXPYEUDbTIEvP/QdxkhvbeQAPMM6fkb9iWcOqdWtW2WY4lCihwhtT6KFGMO5EX5l3qKzG@vger.kernel.org, AJvYcCXHlK9lsRMyH/JtCxvsJp83zP+s2G9B0EKrCcKjCxYlYtJQ3MooL9S2+kuXZBqG9/E1ea6RijxlaUTL@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgmrv4yFahcqp/j0r2hEHIW376rnjAyJFw7SbD3mDGp6jcAjf
	51c08b9gyylIV/FWDRRjS40AEJYIxm9QQb8Bjq+9dsUFvw4mbjO1Z+lTIW4uhvTpwPoriDgcoPo
	iosxuMI37faEn9I/sZ75JkxoZcN2KhNs=
X-Gm-Gg: ASbGncv2HQLuqNtx9cd5jGAzrsrU/ABj6Sa7ZBqEUvIOE0G4Gi5lb88WHoJE6jw+2aV
	THHStbh6Q1mHTXTVGbNCoW1NTbFeQKxBbkFFO9cvVxlIrcFHbjGuyZm2wrB8ANRILRvv8MdIB3s
	gmmFVmp44CcFtM7PxKQw+ZIVD8qW3WwUXAT+Jz7fHT3F8=
X-Google-Smtp-Source: AGHT+IFoNdlG6OGyptEDgyQ7J7Y2noHRDxWhWFL0nKAdcsTluhnP2tRcD7MA8Pp6OUa21m6VsanQyquKtk9dxIdzuBQ=
X-Received: by 2002:a05:690c:6f0b:b0:70e:4cdc:6e7a with SMTP id
 00721157ae682-712c64f673dmr48997567b3.6.1750532074339; Sat, 21 Jun 2025
 11:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-9-l.rubusch@gmail.com>
 <aErE0xmlm4qBHg03@smile.fi.intel.com>
In-Reply-To: <aErE0xmlm4qBHg03@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 21 Jun 2025 20:53:58 +0200
X-Gm-Features: AX0GCFuAJvsyydfuvEoWB_tms_BjlTAFOx2hhW_6tF87VW6WKx8Xilr2jgOX7ms
Message-ID: <CAFXKEHao9xKsizGLMQxikcLbG5Him9n9i3btLtqK2Orj_39a9Q@mail.gmail.com>
Subject: Re: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:15=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Jun 10, 2025 at 09:59:30PM +0000, Lothar Rubusch wrote:
> > Add the inactivity feature of the sensor to the driver. When activity
> > and inactivity are enabled, a link bit will be set linking activity and
> > inactivity handling. Additionally, the auto-sleep mode will be enabled.
> > Due to the link bit the sensor is going to auto-sleep when inactivity
> > was detected.
> >
> > Inactivity detection needs a threshold to be configured and a period of
> > time in seconds. After, it will transition to inactivity state, if
> > measurements stay below inactivity threshold.
> >
> > When a ODR is configured the period for inactivity is adjusted with a
> > corresponding reasonable default value, in order to have higher
> > frequencies, lower inactivity times, and lower sample frequency but
> > give more time until inactivity. Both with reasonable upper and lower
> > boundaries, since many of the sensor's features (e.g. auto-sleep) will
> > need to operate between 12.5 Hz and 400 Hz. This is a default setting
> > when actively changing sample frequency, explicitly setting the time
> > until inactivity will overwrite the default.
> >
> > Similarly, setting the g-range will provide a default value for the
> > activity and inactivity thresholds. Both are implicit defaults, but
> > equally can be overwritten to be explicitly configured.
>
> ...
>
> > +static const struct iio_event_spec adxl345_fake_chan_events[] =3D {
> > +     {
> > +             /* inactivity */
> > +             .type =3D IIO_EV_TYPE_MAG,
> > +             .dir =3D IIO_EV_DIR_FALLING,
> > +             .mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE) |
> > +                     BIT(IIO_EV_INFO_PERIOD),
>
> Slightly better
>
>                 .mask_shared_by_type =3D
>                         BIT(IIO_EV_INFO_VALUE) |
>                         BIT(IIO_EV_INFO_PERIOD),
>
> > +     },
> > +};
>
> And the same for other similar cases.
>
> ...
>
> > +/**
> > + * adxl345_set_inact_time - Configure inactivity time explicitly or by=
 ODR.
> > + * @st: The sensor state instance.
> > + * @val_s: A desired time value, between 0 and 255.
> > + *
> > + * Inactivity time can be configured between 1 and 255 sec. If a val_s=
 of 0
> > + * is configured by a user, then a default inactivity time will be com=
puted.
> > + *
> > + * In such case, it should take power consumption into consideration. =
Thus it
> > + * shall be shorter for higher frequencies and longer for lower freque=
ncies.
> > + * Hence, frequencies above 255 Hz shall default to 10 s and frequenci=
es below
> > + * 10 Hz shall result in 255 s to detect inactivity.
> > + *
> > + * The approach simply subtracts the pre-decimal figure of the configu=
red
> > + * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz =
are thus
> > + * ignored in this estimation. The recommended ODRs for various featur=
es
> > + * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.=
5 Hz and
> > + * 400 Hz, thus higher or lower frequencies will result in the boundar=
y
> > + * defaults or need to be explicitly specified via val_s.
> > + *
> > + * Return: 0 or error value.
> > + */
> > +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> > +{
> > +     unsigned int max_boundary =3D 255;
> > +     unsigned int min_boundary =3D 10;
> > +     unsigned int val =3D min(val_s, max_boundary);
> > +     enum adxl345_odr odr;
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     if (val =3D=3D 0) {
> > +             ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE, &reg=
val);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
>
> > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > +                     ? min_boundary : max_boundary - adxl345_odr_tbl[o=
dr][0];
>
> clamp() ?
>

Isn't clamp() dealing with signed ints? Also, I'll take the diff from
max_boundary here. So, I'll try staying with the current line and hope
it's fine.

Best,
L

> > +     }
> > +
> > +     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > +}
>
> ...
>
> >       if (type =3D=3D ADXL345_ACTIVITY) {
> >               axis_ctrl =3D ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> >                               ADXL345_ACT_Z_EN;
> >       } else {
> > -             axis_ctrl =3D 0x00;
> > +             axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> > +                             ADXL345_INACT_Z_EN;
> >       }
>
> Now this can be as simple as
>
>         axis_ctrl =3D ADXL345_ACT_X_EN;
>         if (type =3D=3D ADXL345_ACTIVITY)
>                 axis_ctrl |=3D ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
>         else
>                 axis_ctrl |=3D ADXL345_INACT_Y_EN | ADXL345_INACT_Z_EN;
>
> Yeah, I don't know how to make the diff better (it gets worse), but the e=
nd
> result is better.
>
> One way, which I don't like much is to previously have this conditional w=
ritten as:
>
>         axis_ctrl =3D ADXL345_ACT_X_EN;
>         if (type =3D=3D ADXL345_ACTIVITY)
>                 axis_ctrl |=3D ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
>         else
>                 axis_ctrl =3D 0;
>
> ...
>
> > +     ret =3D regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
> > +                              (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_=
POWER_CTL_LINK),
>
> Unneeded parentheses.
>
> > +                              en);
> >       if (ret)
> >               return ret;
>
> ...
>
> >  static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr =
odr)
> >  {
> > -     return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> > +     int ret;
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
> >                                ADXL345_BW_RATE_MSK,
> >                                FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* update inactivity time by ODR */
> > +     return adxl345_set_inact_time(st, 0);
>
> Okay, in this case the initial form of
>
>         int ret;
>
>         ret =3D ...
>         if (ret)
>                 return ret;
>
>         return 0;
>
>
> will be better with the respectful comment (as Jonathan suggested) in tha=
t
> change that this is not optimal as standalone change, but it will help re=
duce
> churn in the next change(s).
>
> >  }
>
> ...
>
> >  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_ra=
nge range)
> >  {
> > -     return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
>
> Same here.
>
> > +     unsigned int act_threshold, inact_threshold;
> > +     unsigned int range_old;
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     ret =3D regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval)=
;
> > +     if (ret)
> > +             return ret;
> > +     range_old =3D FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
> > +
> > +     ret =3D regmap_read(st->regmap,
> > +                       adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> > +                       &act_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_read(st->regmap,
> > +                       adxl345_act_thresh_reg[ADXL345_INACTIVITY],
> > +                       &inact_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> >                                ADXL345_DATA_FORMAT_RANGE,
> >                                FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, ra=
nge));
> > +     if (ret)
> > +             return ret;
> > +
> > +     act_threshold =3D act_threshold * adxl345_range_factor_tbl[range_=
old]
> > +             / adxl345_range_factor_tbl[range];
> > +     act_threshold =3D min(U8_MAX, max(1, act_threshold));
> > +
> > +     inact_threshold =3D inact_threshold * adxl345_range_factor_tbl[ra=
nge_old]
> > +             / adxl345_range_factor_tbl[range];
> > +     inact_threshold =3D min(U8_MAX, max(1, inact_threshold));
> > +
> > +     ret =3D regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_A=
CTIVITY],
> > +                        act_threshold);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_IN=
ACTIVITY],
> > +                        inact_threshold);
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

