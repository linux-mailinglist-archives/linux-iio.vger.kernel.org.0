Return-Path: <linux-iio+bounces-3763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E91088A8AC
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 17:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A14344F3E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4259145B0D;
	Mon, 25 Mar 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QFsoV7l4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88612FB36
	for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375724; cv=none; b=WfzHwC93/6vjcRbooUBm7NzPGpVlr1WPWF4RK6AK9N+GfdnuavAnHqQC3kTczvekAPg/VulxTq7Bu+99PHWwt7QoLveYGe2d3OAcC2mN1ot/97kHf1Mjtm3fYb7QOjij+EXNjhNmtLH0whTXdz+MFVJfs+6wrSUue0wBPBJzmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375724; c=relaxed/simple;
	bh=OxCqtQVpFOuTtdqfzmdtYyBMioRTbETJ+YVhNovAZhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnfDAdF9nOlAxAKvXe7MLKlclPZHjERe4uJsh5TaRTpQ9M4ZFf+KYS1rkZZCg5NUiQevSLIgigOom5KAYHqYrTwg2p9l/u3d/oJ98MQCa4OnDYG+3e/RBWEKbKeaKXHk3qkokek2Lxkn0INkiDA/Gh4X2mwLn4YI9mVWhh6swUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QFsoV7l4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6c220a377so23988441fa.2
        for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711375719; x=1711980519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFWGgnNqSnGHrWUWocmZy6YK/dw2hXbl8LIbQZaVaus=;
        b=QFsoV7l4msJ1BSv84qKYZCh1XrcfPx9SPts9lKoRoRI3tYu47Sh76Z+uHqktEH7GUJ
         U6D2b2RM/lDmQ5an92vtpg1yW9YWp6Scsb/aE51D/FzBtMreKrE+NS5zwZFe+YalO6F1
         asUMuipg7gGViE4ZEYtHkOBSqvPjCi1XLcZ1L+5LuzXBb6urN001LbwoKu3FPPnPlbVx
         txy4hehMZfTKKircHo5+nzoDtYh3lG3TeEPdpUhwtTRyGcdfItJ7PH9A9eI3W01nArLy
         y6pMmwODnUfiVK23BdoTjvr0509pA/wiUeYH2UWq+Ic9db4MkisgHGxJaB6xeK+n55I0
         zFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711375719; x=1711980519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFWGgnNqSnGHrWUWocmZy6YK/dw2hXbl8LIbQZaVaus=;
        b=HrcLpu27ED/TUzuJ8sqTyGBPLXiW/wP7DqgZWiyr321xD3lS39pkuxGnnbPidh313y
         R8AlxQzZ6XLeMxzN2+S7EM7uQVr3V3FTkrbJC3OY/GEG8hzYHZKBxuF0RJXSSp741SY+
         3as8tArQtl2Zmuyo1vGw5DrO8KyX/6AoWDn3Ln/Ru03EEOfBa0dYAqtD+NZUbmCddPkW
         cyRVciTdiSkM52M+vOQm8pbm4hdZIMKtAspqy4OTrsjbPaNJIw3GnN05oAEqNWxtueSW
         15xe9Zw29qwcB91kACPwCs3Di8FPqdkgNFB4046+9DuQuNZ0llbnscvvI42fr+PBmGSw
         kTQg==
X-Forwarded-Encrypted: i=1; AJvYcCWXA5mqsuu4ozwBgV7n0MSuqOO+bvUkf/ief1C68gVrSSDxioAyzBz9PHQ/2CXV/QKaQZULzY6sBlGXThd3YoZVBWamy/lEAVsm
X-Gm-Message-State: AOJu0YzTHFx6fQly/Oe7DzkBBvma0025qz4T7dGXeZle6THbQ44kMy9G
	PppXY2364CubTp+m1LYt2bb4dfv0kE4zK0GYyU8uiEnPKtpjkCmDynTyfgtFC0hT39lnNjBC8uM
	53e0YTrFbnWoTHRbvYbEbAqhTjVpQZDi/dujjjw==
X-Google-Smtp-Source: AGHT+IFXJTugPxOd1SjsFqmPOD0Aur7rPUGaGzR3jjwtIDR508eJqX8kU1m3OUZjS3P0PLy57Ad5InV6xaj5ZqCXKAE=
X-Received: by 2002:a2e:8806:0:b0:2d4:49d2:a3d1 with SMTP id
 x6-20020a2e8806000000b002d449d2a3d1mr5146126ljh.1.1711375718894; Mon, 25 Mar
 2024 07:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
 <20240319-adding-new-ad738x-driver-v5-4-ce7df004ceb3@baylibre.com> <20240324130135.35f4b0eb@jic23-huawei>
In-Reply-To: <20240324130135.35f4b0eb@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Mar 2024 09:08:27 -0500
Message-ID: <CAMknhBGmM7yt1JR1tW4SS5RLGpN9PtnMrf0WvZ-bhU-gSv3YUQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad7380: add support for
 pseudo-differential parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 8:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 19 Mar 2024 11:11:25 +0100
> Julien Stephan <jstephan@baylibre.com> wrote:
>
> > From: David Lechner <dlechner@baylibre.com>
> >
> > Add support for AD7383, AD7384 pseudo-differential compatible parts.
> > Pseudo differential parts require common mode voltage supplies so add
> > the support for them and add the support of IIO_CHAN_INFO_OFFSET to
> > retrieve the offset
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> Hi Julien,
>
> A few aditional comments inline.  The one about
> optional regulators may be something others disagree with.
> Mark, perhaps you have time to comment.
> Is this usage of devm_regulator_get_optional() to check a real regulator
> is supplied (as we are going to get the voltage) sensible?  Feels wrong
> given the regulator is the exact opposite of optional.
>
> Jonathan
>
> >  struct ad7380_state {
> >       const struct ad7380_chip_info *chip_info;
> >       struct spi_device *spi;
> >       struct regmap *regmap;
> >       unsigned int vref_mv;
> > +     unsigned int vcm_mv[2];
> >       /*
> >        * DMA (thus cache coherency maintenance) requires the
> >        * transfer buffers to live in their own cache lines.
> > @@ -304,6 +333,11 @@ static int ad7380_read_raw(struct iio_dev *indio_d=
ev,
> >               *val2 =3D chan->scan_type.realbits;
> >
> >               return IIO_VAL_FRACTIONAL_LOG2;
> > +     case IIO_CHAN_INFO_OFFSET:
> > +             *val =3D st->vcm_mv[chan->channel] * (1 << chan->scan_typ=
e.realbits)
> > +                     / st->vref_mv;
>
> So this maths seems to be right to me, but it took me a while to figure i=
t out.
> Perhaps a comment would help along the lines of this is transforming
>
>         (raw * scale) + vcm_mv
> to
>         (raw + vcm_mv / scale) * scale
> as IIO ABI says offset is applied before scale.
>
> > +
> > +             return IIO_VAL_INT;
> >       }
> >
> >       return -EINVAL;
> > @@ -350,7 +384,7 @@ static int ad7380_probe(struct spi_device *spi)
> >       struct iio_dev *indio_dev;
> >       struct ad7380_state *st;
> >       struct regulator *vref;
> > -     int ret;
> > +     int ret, i;
> >
> >       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >       if (!indio_dev)
> > @@ -394,6 +428,40 @@ static int ad7380_probe(struct spi_device *spi)
> >               st->vref_mv =3D AD7380_INTERNAL_REF_MV;
> >       }
> >
> > +     if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
> > +             return dev_err_probe(&spi->dev, -EINVAL,
> > +                                  "invalid number of VCM supplies\n");
> > +
> > +     /*
> > +      * pseudo-differential chips have common mode supplies for the ne=
gative
> > +      * input pin.
> > +      */
> > +     for (i =3D 0; i < st->chip_info->num_vcm_supplies; i++) {
> > +             struct regulator *vcm;
> > +
> > +             vcm =3D devm_regulator_get_optional(&spi->dev,
>
> Why optional?
>
> > +                                               st->chip_info->vcm_supp=
lies[i]);
> > +             if (IS_ERR(vcm))
>
> This will fail if it's not there, so I'm guessing you are using this to a=
void
> getting to the regulator_get_voltage?  If it's not present I'd rely on th=
at
> failing rather than the confusing handling here.
>
> When the read of voltage wasn't in probe this would have resulted in a pr=
oblem
> much later than initial setup, now it is, we are just pushing it down a f=
ew lines.
>
> Arguably we could have a devm_regulator_get_not_dummy()
> that had same implementation to as get_optional() but whilst it's called =
that
> I think it's confusing to use like this.

Despite the misleading naming, I guess I am used to
devm_regulator_get_optional() by now having used it enough times.
Since it fails either way though, technically both ways seem fine so I
can't really argue for one over the other.

But given that this is a common pattern in many IIO drivers, maybe we
make a devm_regulator_get_enable_get_voltage()? This would return the
voltage on success or an error code. (If the regulator subsystem
doesn't want this maybe we could have
devm_iio_regulator_get_enable_get_voltage()).

If the dev_err_probe() calls were included in
devm_regulator_get_enable_get_voltage(), then the 10+ lines of code
here and in many other drivers to get the regulator, enable it, add
the reset action and get the voltage could be reduced to 3 lines.

>
> > +                     return dev_err_probe(&spi->dev, PTR_ERR(vcm),
> > +                                          "Failed to get %s regulator\=
n",
> > +                                          st->chip_info->vcm_supplies[=
i]);
> > +
> > +             ret =3D regulator_enable(vcm);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D devm_add_action_or_reset(&spi->dev,
> > +                                            ad7380_regulator_disable, =
vcm);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regulator_get_voltage(vcm);
>
> I'd let this fail if we have a dummy regulator.
>
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             st->vcm_mv[i] =3D ret / 1000;
> > +     }
> > +

