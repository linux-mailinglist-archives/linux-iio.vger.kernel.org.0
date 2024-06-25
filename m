Return-Path: <linux-iio+bounces-6868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF42915E28
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 07:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2941C210B3
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 05:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9A145A18;
	Tue, 25 Jun 2024 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDVdHOge"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866214375C
	for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719293463; cv=none; b=HG4qFwPqP3wv6NZBzWBhuvmUjkUVl/5EcJyWkRyhqZmLgpUeYQyl4J5fsUfPtNmCXAm57spht41ddqrqzHM85EQGdFtXDfcEKzhYR4V/UAlXAkvmx7nmrZ5H4EHmfwY4P7q3euOIUHLCsVGpJ0NHdlDY5hhorVepnI/zQZam2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719293463; c=relaxed/simple;
	bh=EWg0LszmD2FWUuf5dzncr0aHObfLW2WZLpSUkktkRp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spRf2V/PkrCH4JDrzQLvrmtz1ZjeoldbcmRAEI5tINxPcWLrz6pMmL1GjUtgsCtPTWFw05N6H8P/tjYQIdf1bYxs9LEVoVdxnzwrkwSlNwdBTblV7Fsin1BOM7Qkh4DkYU8x4Ujo8v6r4sHYvJRsJ6zK/peZgpbedeTEx3E0j0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDVdHOge; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4ef7c95a041so103985e0c.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719293458; x=1719898258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH4xT6oKyRDlJ/9SAo1hScjTVdx2cvP+qkd1fBGGz6Q=;
        b=LDVdHOge/K728smVwmsifzsiRrOkTbjXd1DB6kBdx4QW5YRADu11ckkMxLN+8QEmes
         CI0FR61oRK15ab/lpi2FZoxhwHVMgVkgx+Ly6IQE2BIfipkO0vHDPMu+dAdhGo6MhA5f
         VWvWyIeUcMoMu8lZMkdgPco1DsAosm4uBHfPqYvm7nRNEHaTY4qhFOVUKOUSzePOrpEM
         sfxUxqg8pSKRk9ZDr45UMNfpBF3502UuJSq52ci87zezGuskXV3juiSt62HCgo01KClH
         YxDwGzlEJ4Pbj8mUmcyys9izuvoBHEWhkPO2/yGdX74pwYRc0C7wE/wlpuyxD1bt8gp2
         7K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719293458; x=1719898258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fH4xT6oKyRDlJ/9SAo1hScjTVdx2cvP+qkd1fBGGz6Q=;
        b=tGWetnLQLwyb3vaL99qn3tzh37TtqvhYo2ymLE5C01+5vo3ETh9Ubv9fU93s5aPWDV
         TiyzAsX8j72gu7yPqP1xhvD4l+ruvQ88ZKZz1nDDWOz28jT9sH7CMM9DyiTD4bYvJkBu
         WelFVM/WlzL2SZCCBhCswKxoKTKOLjCWRN0VIDi/GTLK+Vu4gOy997MafggdIacZR/3D
         iALZaxJGY8sIx3BEtRzG1CzQ9yDYhkKawc2YIuLoBaLc/RRIAL8gp3hWIy87bF1csNsl
         /a0jDdfsOI6IVNkn6Cpc+rn5QUmu/CG/6nk2LbSoP9XHaOHF0VXECmqRPRXDK6ygE6UR
         4a/A==
X-Forwarded-Encrypted: i=1; AJvYcCXoviOPzltF2bxipjbafDFYWUip7HpoE4bI2zfMaFt44hai5S3Bmgd9uC5wuTN2xNxz8paazpYDxfsnQfZKDrOSsYnoopBJw0CW
X-Gm-Message-State: AOJu0Yy5UoGiEcgJydrxnK1VgrRldw1JVJm5ffCkOvZ9iFRNRyGIKz9L
	hqyXGM6DAcaYlLZXgV8xkJs4srGBSEYDxltwd8lx5RZG82dq2GTKZKPDHxpjs6z/Do/C3ggT1Ug
	/QAbadJ4CJx9gdnV9WHthSSk4T3mBkDo/g4b7yA==
X-Google-Smtp-Source: AGHT+IF1mvfwo/UQmf3qvzPkzrgA++cDgEF4wvUt2ZNU0MSeSH5sybGDUJbRd4oF+QdtPNEJrw7NC382zZONIdEp1yg=
X-Received: by 2002:a05:6122:4f85:b0:4eb:2012:f5ed with SMTP id
 71dfb90a1353d-4ef612cdf88mr6901984e0c.1.1719293458411; Mon, 24 Jun 2024
 22:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624124941.113010-1-alisa.roman@analog.com> <20240624124941.113010-4-alisa.roman@analog.com>
In-Reply-To: <20240624124941.113010-4-alisa.roman@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 25 Jun 2024 08:30:47 +0300
Message-ID: <CA+GgBR9V=SqeA2fbeBDUO=Cr1s6GTbq6_779uQmiKCF2EjkHBg@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] iio: adc: ad7192: Update clock config
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:50=E2=80=AFPM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>

Hello,

A few comments inline.

> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock.
>
> Removed properties adi,int-clock-output-enable and adi,clock-xtal were
> undocumented. Use cleaner alternative of configuring external clock by
> using clock names mclk and xtal.

Should we keep the old properties for backwards compatibility?
While I like the new approach, the downside is that someone upgrades
the kernel and may run into issues with their board, because one of
these properties went away.

>
> Removed functionality of AD7192_CLK_INT_CO restored in complementary
> patch.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 56 ++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 334ab90991d4..940517df5429 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -396,25 +396,37 @@ static inline bool ad7192_valid_external_frequency(=
u32 freq)
>                 freq <=3D AD7192_EXT_FREQ_MHZ_MAX);
>  }
>
> -static int ad7192_clock_select(struct ad7192_state *st)
> +static const char *const ad7192_clock_names[] =3D {
> +       "xtal",
> +       "mclk"

Just a thought; no strong opinion.
Maybe add a short comment about these being "clock_sel" values
AD7192_CLK_EXT_MCLK1_2 & AD7192_CLK_EXT_MCLK2 ?
This is mostly due to the "st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 +
ret;" logic (which is fine)
Before, this change, it would

> +};
> +
> +static int ad7192_clock_setup(struct ad7192_state *st)
>  {
>         struct device *dev =3D &st->sd.spi->dev;
> -       unsigned int clock_sel;
> -
> -       clock_sel =3D AD7192_CLK_INT;
> +       int ret;
>
> -       /* use internal clock */
> -       if (!st->mclk) {
> -               if (device_property_read_bool(dev, "adi,int-clock-output-=
enable"))
> -                       clock_sel =3D AD7192_CLK_INT_CO;
> +       ret =3D device_property_match_property_string(dev, "clock-names",
> +                                                   ad7192_clock_names,
> +                                                   ARRAY_SIZE(ad7192_clo=
ck_names));
> +       if (ret < 0) {
> +               st->clock_sel =3D AD7192_CLK_INT;
> +               st->fclk =3D AD7192_INT_FREQ_MHZ;

Since this is a new function, an early return can be added here.
This would make the else statement redundant, and the function would
have less indentation.

So, something like:
if (ret < 0) {
         st->clock_sel =3D AD7192_CLK_INT;
         st->fclk =3D AD7192_INT_FREQ_MHZ;
         return 0;
}

st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 + ret;

st->mclk =3D devm_clk_get_enabled(dev, ad7192_clock_names[ret]);
if (IS_ERR(st->mclk))
...................


>         } else {
> -               if (device_property_read_bool(dev, "adi,clock-xtal"))
> -                       clock_sel =3D AD7192_CLK_EXT_MCLK1_2;
> -               else
> -                       clock_sel =3D AD7192_CLK_EXT_MCLK2;
> +               st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 + ret;
> +
> +               st->mclk =3D devm_clk_get_enabled(dev, ad7192_clock_names=
[ret]);
> +               if (IS_ERR(st->mclk))
> +                       return dev_err_probe(dev, PTR_ERR(st->mclk),
> +                                            "Failed to get mclk\n");
> +
> +               st->fclk =3D clk_get_rate(st->mclk);
> +               if (!ad7192_valid_external_frequency(st->fclk))
> +                       return dev_err_probe(dev, -EINVAL,
> +                                            "External clock frequency ou=
t of bounds\n");
>         }
>
> -       return clock_sel;
> +       return 0;
>  }
>
>  static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
> @@ -1275,21 +1287,9 @@ static int ad7192_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> -       st->fclk =3D AD7192_INT_FREQ_MHZ;
> -
> -       st->mclk =3D devm_clk_get_optional_enabled(dev, "mclk");
> -       if (IS_ERR(st->mclk))
> -               return PTR_ERR(st->mclk);
> -
> -       st->clock_sel =3D ad7192_clock_select(st);
> -
> -       if (st->clock_sel =3D=3D AD7192_CLK_EXT_MCLK1_2 ||
> -           st->clock_sel =3D=3D AD7192_CLK_EXT_MCLK2) {
> -               st->fclk =3D clk_get_rate(st->mclk);
> -               if (!ad7192_valid_external_frequency(st->fclk))
> -                       return dev_err_probe(dev, -EINVAL,
> -                                            "External clock frequency ou=
t of bounds\n");
> -       }
> +       ret =3D ad7192_clock_setup(st);
> +       if (ret)
> +               return ret;
>
>         ret =3D ad7192_setup(indio_dev, dev);
>         if (ret)
> --
> 2.34.1
>
>

