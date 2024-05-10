Return-Path: <linux-iio+bounces-4934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059068C2949
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2823F1C22222
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDE1BDEF;
	Fri, 10 May 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RvQf66/r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046318C1A
	for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362223; cv=none; b=iDnpAtXxA9s+MyJuzWjTjhYZoDUdoYPik1hq+N4lS1csyXhEcALDUIP1j3KOPgyqRdT6X7QMEQkAgyk/Vf0KPBhaCGtSFkLD4K9cq+DRjTdcnfZpPTZp8e2slW18WctCrMkgePJHKhCLIDKNKjYVJUPMeL5e+S+P0zRAovIsYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362223; c=relaxed/simple;
	bh=heSWzS+o8NClxY1FdqKnrf7kbzin+Ql9QklLY3gInb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sz2qEwGwif3y+gDwt2YhLQYHiA3eSMKNLjlyMVmHdXGpWCRG7KQKN3kAjw7RMGq2INeX2CVy+htGKI/trz9K+/ARf46UPRyn4Eau7l22TAfNtatawOTpDQA2NV+5ykMIJ2a9A5w+Avc04K3S2MxJaS0ST+fCfeOX/FnLezWOyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RvQf66/r; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so28805971fa.2
        for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715362218; x=1715967018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+03zz8HjiN5VHZWYDrrWM+RLAFllIuALHSF1BCtFUs=;
        b=RvQf66/rECm/OQet909xJrfgNHmG7UEK0e55VnBKpFElKFxRcCWDdXDOmF6KqN3ODZ
         na3NRJbqkNX0AiRco8L0G3wZ9mvpIjLtjSiK7TCB0QquF+W9xTPdwW2lbGF0er8VkuHO
         Gb29XaAzRnkN6gr61u02GW5ff6dbVvRZdf2VamgScQCFp8IfbMo9Qjc05LQjM7VB9qaK
         zXKN5HYQM5sl2f1ZBbRb+3Y+L+OYa8SDYS8qgU0hYx3zj9n3LIl8Opebw9ZimAt6AgtR
         952sycbG93Mxi+0uewsasMAQVtZsn4scY4yPgj/4PlKXN5upWr2VvBgeQbIF7VHx6Aht
         /Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715362218; x=1715967018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+03zz8HjiN5VHZWYDrrWM+RLAFllIuALHSF1BCtFUs=;
        b=lDPCrcmEaD4LH6ORVSOuhrREXeUdAWnuFBEaUHo++WCdZF6PnaeleCkaQo+U5RynBF
         4HRrlNfwFLKWsB9ooY60gvTMF1borfsKrVPg1g4ayJKtlpKa0e+SBG7hlUx8YrkcLDtD
         D+ZOz+zmoBV1Jyrtnr+MN76/PJwZs4EWrHYpRuza9mpanACFz4YcsN6nVCwRuHRJ4Zbu
         BLjR78Rl3SWBwDTXtYiR9cTGsQ5W0Hss6fXZTXTtmoSo8cnXjnN9oKEUTelZIIeGcnaJ
         ituDyieBfKdXu/5wqf+ebZKbPixi5pyZtaOoyPkiVSCXZzgQKJnOZGDsoeKrODGwBLz9
         ruTw==
X-Gm-Message-State: AOJu0YxIlUp4fLfm4hd5XHxJQEhTkvci6idqyUbh+5P0oztEYAbAl+/t
	fa0x/m2YRKsltCNduEblkN1a1rJ9mOjDGRhtiWY3Gj9A2SHCUlc1nnd34HtlnF4caNij5/jC6N7
	NgzxPbMlCt9yesgN8WqJ7Zp5sRfr409Xu2p/RuA==
X-Google-Smtp-Source: AGHT+IHbuZCYm+alJWfr2oUuelVX+K6UtqjijR4P7ItR32LVaLn0vhXb95wpNS62v6spW2KUf2F6hzkSWuvA83ETMmI=
X-Received: by 2002:a2e:90c7:0:b0:2d4:3d86:54e2 with SMTP id
 38308e7fff4ca-2e51ff5e37fmr20105591fa.27.1715362218189; Fri, 10 May 2024
 10:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com> <20240510064053.278257-3-Mariel.Tinaco@analog.com>
In-Reply-To: <20240510064053.278257-3-Mariel.Tinaco@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 May 2024 12:30:06 -0500
Message-ID: <CAMknhBFMrY7LSTUK+PxCkekEha7T_OyVyjcT8sKTQc+9zP7gHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 1:42=E2=80=AFAM Mariel Tinaco <Mariel.Tinaco@analog=
.com> wrote:
>
> The AD8460 is a =E2=80=9Cbits in, power out=E2=80=9D high voltage, high-p=
ower,
> highspeed driver optimized for large output current (up to =C2=B11 A)

high-speed

> and high slew rate (up to =C2=B11800 V/=CE=BCs) at high voltage (up to =
=C2=B140 V)
> into capacitive loads.
>
> A digital engine implements user-configurable features: modes for
> digital input, programmable supply current, and fault monitoring
> and programmable protection settings for output current,
> output voltage, and junction temperature. The AD8460 operates on
> high voltage dual supplies up to =C2=B155 V and a single low voltage
> supply of 5 V.
>
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> ---

...

> diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
> new file mode 100644
> index 000000000..4049be0f5
> --- /dev/null
> +++ b/drivers/iio/dac/ad8460.c

...

> +static int ad8460_probe(struct spi_device *spi)
> +{
> +       struct ad8460_state *state;
> +       struct iio_dev *indio_dev;
> +       struct regulator *vrefio;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*state));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       state =3D iio_priv(indio_dev);
> +       mutex_init(&state->lock);
> +
> +       state->spi =3D spi;
> +
> +       state->regmap =3D devm_regmap_init_spi(spi, &ad8460_regmap_config=
);
> +       if (IS_ERR(state->regmap))
> +               return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> +                                    "Failed to initialize regmap");
> +
> +       ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev,=
 "tx",
> +                                                 IIO_BUFFER_DIRECTION_OU=
T);
> +       if (ret)
> +               return dev_err_probe(&spi->dev, ret,
> +                                    "Failed to get DMA buffer\n");

It looks like the dmas property is missing in the DT bindings.
However, as I suggested in my comments on that patch, it might make
more sense to implement the parallel data part as an IIO backend. I
assume this is using one of ADI's FPGA IP blocks to get the data?

> +
> +       state->sync_clk =3D devm_clk_get_enabled(&spi->dev, "sync_clk");

The DT bindings don't specify clock-names, which is perfectly fine and
perhaps even preferred since there is only one clock. But that means
the ID here should be NULL instead of "sync_clk".

> +       if (IS_ERR(state->sync_clk))
> +               return dev_err_probe(&spi->dev, PTR_ERR(state->sync_clk),
> +                                    "Failed to get sync clk\n");
> +


> +       vrefio =3D devm_regulator_get_optional(&spi->dev, "vrefio");
> +       if (IS_ERR(vrefio)) {
> +               if (PTR_ERR(vrefio) !=3D -ENODEV)
> +                       return dev_err_probe(&spi->dev, PTR_ERR(vrefio),
> +                                            "Failed to get vref regulato=
r\n");
> +
> +               state->vref_mv =3D 1200;
> +
> +       } else {
> +               ret =3D regulator_enable(vrefio);
> +               if (ret)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Failed to enable vrefio reg=
ulator\n");
> +
> +               ret =3D devm_add_action_or_reset(&spi->dev,
> +                                              ad8460_regulator_disable,
> +                                              vrefio);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D regulator_get_voltage(vrefio);
> +               if (ret < 0)
> +                       return dev_err_probe(&spi->dev, ret,
> +                                            "Failed to get ref voltage\n=
");
> +
> +               if (!in_range(ret, AD8460_MIN_VREFIO_UV, AD8460_MAX_VREFI=
O_UV))
> +                       return dev_err_probe(&spi->dev, -EINVAL,
> +                                            "Invalid ref voltage range(%=
u) [%u, %u]\n",
> +                                            ret, AD8460_MIN_VREFIO_UV,
> +                                            AD8460_MAX_VREFIO_UV);
> +
> +               state->vref_mv =3D ret / 1000;
> +       }

FYI, if all goes well, starting with kernel 6.10-rc1 (we'll have to
wait a few weeks for this), this regulator section can be simplified
to:

ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vrefio");
if (ret =3D=3D -ENODEV) {
    /* no supply, using internal 1.2V reference */
    state->vref_mv =3D 1200;
} else if (ret < 0) {
    return  dev_err_probe(&spi->dev, ret, "Failed to get reference voltage\=
n");
} else {
    /* external reference */
    state->vref_mv =3D ret / 1000;
}

if (!in_range(...

We can always fix it up later though if you don't want to wait. :-)

> +
> +       ret =3D device_property_read_u32(&spi->dev, "adi,rset-ohms",
> +                                      &state->rset_ohms);

Since 0 isn't an allowable value for R_SET, it seems like we need to
return on error here or assign a default value if the property is
missing. If we do a default value, the DT bindings need to be updated
to reflect that as well.

> +       if (!ret) {
> +               if (!in_range(state->rset_ohms, AD8460_MIN_RSET_OHMS,
> +                             AD8460_MAX_RSET_OHMS))
> +                       return dev_err_probe(&spi->dev, -EINVAL,
> +                                            "Invalid resistor set range(=
%u) [%u, %u]\n",
> +                                            state->rset_ohms,
> +                                            AD8460_MIN_RSET_OHMS,
> +                                            AD8460_MAX_RSET_OHMS);
> +       }
> +
> +       ret =3D ad8460_reset(state);
> +       if (ret)
> +               return ret;
> +
> +       /* Enables DAC by default */
> +       ret =3D regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),

I was going to suggest giving names to the registers instead of using
the number, but the datasheet doesn't do that! :-(

Oh well, I guess this is the best we can do.

> +                                AD8460_HVDAC_SLEEP_MSK,
> +                                FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, 0));
> +       if (ret)
> +               return ret;
> +
> +       indio_dev->name =3D "ad8460";
> +       indio_dev->info =3D &ad8460_info;
> +       indio_dev->channels =3D ad8460_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(ad8460_channels);
> +       indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_HARDWARE;

devm_iio_dmaengine_buffer_setup_ext() already sets the
INDIO_BUFFER_HARDWARE flag so this is redundant. Also,
devm_iio_dmaengine_buffer_setup_ext() is usually called here rather
than early in probe because it needs a few things in indio_dev
populated, IIRC.

> +       indio_dev->setup_ops =3D &ad8460_buffer_setup_ops;
> +
> +       ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ad8460_debugfs_init(indio_dev);
> +
> +       return 0;
> +}
> +

...

