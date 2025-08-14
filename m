Return-Path: <linux-iio+bounces-22714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6505B25DE7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 09:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F3E8822CC
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E77285057;
	Thu, 14 Aug 2025 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9NXIu5I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C0283CB1;
	Thu, 14 Aug 2025 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157369; cv=none; b=KF7hSb/IQURD1L7VwcGsH/ih0LCYqnONMSegkgWUExitlV5UXciWtqioTC9MOBA256IV3l6bvdkTGj82HEklGkyZz8J/d5/sh1LrGjlUbcyV0iJpp2lFB80JTByFo37lmU9uQx4/arIZZYcdfzflQ+Wyj4rzpRbkzIr6aIGBp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157369; c=relaxed/simple;
	bh=Uwqtrzx+UUuB0BQhq3owOZCLu0Y/35xISKpqX33xCKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nWykAAPzWd/ACjvFBM2c20y8DVrZ7Gr+bP2OrcN2KHHN0LjNyVzy2wqLXGlYgV/neZw+UJ3eFogaiuJ1LtZgyrgrWp2eJF5tX+oUIlp3GL9Niv7GyWl5R26KE8ykc0uvhsr4GrHcKyvZxm4NjhSDpTmGAYrpUNCsPsH+Aq6GWoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9NXIu5I; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so307500f8f.0;
        Thu, 14 Aug 2025 00:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755157366; x=1755762166; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oLWbO+xBNXkP105ZcY5S3bhNXjYh6gYoTsjI5p+KmbQ=;
        b=B9NXIu5ICe7TtofNXobv7UouYDDzv4UX+j6vsUfGUJ1I9rclmBNSUfmHg+M5Gyt2gV
         lux+P+DbF8f1QnQC0EVkDb6D7ItMrDsHE5bgYpcBHJTfMxhwKnmjhT0qvzl4T8EKsIsx
         +i09N0/xMZYvpLQeGy1ZDM36xu3hY07U+2Tz4Udgbwbobb/o/6kaOjRzF1rKB7m0dNyb
         g6tszgTHo9LrSalrkUlYAuOba9gtA178q6l8dOn3rVvHZoRcy2JRYj+irvonW25ruanV
         eEcfhH+F3ZdLQ4KB8DnpkZB+PFjRuIRS1TvfsDCsGz22dpZ5b7BJQUTyLMdudHZM1g4t
         DqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755157366; x=1755762166;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLWbO+xBNXkP105ZcY5S3bhNXjYh6gYoTsjI5p+KmbQ=;
        b=FmBx4flbPxUpaKccl6W7+tcwvKuaCGxi7hF2jgSrH06U6mwkMYLb8ZkvGsGUF2A9SC
         zAUILqiLMYlXnr74loDCgy7UbC1woB8sqqymqcNRIDtTPp2zoEOWu2aWH1kVqNMkE1qc
         GXw1wIKg8wMozq3i6Tyr/Mrx2xZ5hy++eQg7IXNU0gDCKc7DbF1DPc9KqFS3KlRBMVWy
         HBaz29io234qkaTCrU9Cmwu/cZ054G34/paCm1Nn0yDWnNXCE14Pbg4iZH8IyiZknO/u
         epghP8lbglL3r4dGxap2uHUGO1duyUpT3xAJCnFn1GRUbVrura2NFSsRnFozYlx86/g0
         xPJA==
X-Forwarded-Encrypted: i=1; AJvYcCVlVoZPGQZveRormVapw8E7OOR5yarxntCjDW2yg3ctOmuVk2HUECy4+YwJXGa5Loy/rl8bIvbrruAG@vger.kernel.org, AJvYcCW6rm7XJrUCVER1InuvCNV8yREI9n4l6cVkPz4HGLAvgaTZWrGvu+dCQh/BUabJzxy1CMKtEi7xtccy@vger.kernel.org, AJvYcCX4SAK+j/b2siaC6IEUolWmwUwhz+58q1fUENnstgRlBj5yeNmQbzzLe2BFcxHDKvoxA/LnJJnLQ9ozL+og@vger.kernel.org
X-Gm-Message-State: AOJu0YxHX30dwlf05PQYEabhaa3YauItNGbL85DuarulbTXHu6pgtbEq
	NbqFKJyzGrQtHink3TRHfjM2ix7BbTyVsWfth5O80ra1iTTgpOmm+1Nu
X-Gm-Gg: ASbGnctJXf3qwf9nG/DM3AKudpARtdir1uaQAatDz+MTGWTp1Up4YOWQBUWBE7gjSOO
	wYhhaDEkT9U4yQY41rcYNCO2Fu/umzTyoHHA3vW0AMX4yx07W2RZ5S5UmSmFbKwO4E8t81cM8Rm
	thLo1N2Es/4lJMX9gYUTGbaHb5/YVExgerQRJK3LQP1Eb94uwYUnynqNNiG1fZpmQKua0zs5MbS
	Hjr0m+mODq4svssrhYGv0U4ew38HOfKW8mi2imDPsBIrNvrW9GJuBRT/eH9XpJrQazhELvag2ZU
	VW+WCprm/S/QmRqJ7que4vNKws3IjVWk/thFZ6elFzvszp39D7UQODYj87H7vvwOPCDqNhH6Erv
	5HXxtMNZjpRe6nKFJC1UxAl/dR+XZdwHVt1eVNkO0xQzkdH1Fpgr08k5N7O3SxArotlJR40c8
X-Google-Smtp-Source: AGHT+IGakX2uHkpNRmlH4b7v/ZXonDe6gD8NvihdOrQfLJXuk+1UdSuVl/Tr9LrkZwja7mioFTxx9g==
X-Received: by 2002:a05:6000:40c8:b0:3b7:94c3:2786 with SMTP id ffacd0b85a97d-3ba50d5191emr1182475f8f.34.1755157366347;
        Thu, 14 Aug 2025 00:42:46 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9eddsm50076861f8f.22.2025.08.14.00.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:42:46 -0700 (PDT)
Message-ID: <b22b7be907de831926eb275f71c5b6f1c184ec14.camel@gmail.com>
Subject: Re: [PATCH 3/4] iio: adc: ad7768-1: use
 devm_regulator_get_enable_read_voltage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jonath4nns@gmail.com
Date: Thu, 14 Aug 2025 07:43:30 +0100
In-Reply-To: <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
	 <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-12 at 23:49 -0300, Jonathan Santos wrote:
> Use devm_regulator_get_enable_read_voltage function as a standard and
> concise way of reading the voltage from the regulator and keep the
> regulator enabled. Replace the regulator descriptor with the direct
> voltage value in the device struct.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

With David's comment fixed:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7768-1.c | 29 +++++++----------------------
> =C2=A01 file changed, 7 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 36ba208fc119..d0b9764a8f92 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -225,7 +225,7 @@ struct ad7768_state {
> =C2=A0	struct spi_device *spi;
> =C2=A0	struct regmap *regmap;
> =C2=A0	struct regmap *regmap24;
> -	struct regulator *vref;
> +	int vref_uv;
> =C2=A0	struct regulator_dev *vcm_rdev;
> =C2=A0	unsigned int vcm_output_sel;
> =C2=A0	struct clk *mclk;
> @@ -809,7 +809,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
> =C2=A0		return IIO_VAL_INT;
> =C2=A0
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> -		scale_uv =3D regulator_get_voltage(st->vref);
> +		scale_uv =3D st->vref_uv;
> =C2=A0		if (scale_uv < 0)
> =C2=A0			return scale_uv;
> =C2=A0
> @@ -1146,13 +1146,6 @@ static const struct iio_trigger_ops ad7768_trigger=
_ops =3D {
> =C2=A0	.validate_device =3D iio_trigger_validate_own_device,
> =C2=A0};
> =C2=A0
> -static void ad7768_regulator_disable(void *data)
> -{
> -	struct ad7768_state *st =3D data;
> -
> -	regulator_disable(st->vref);
> -}
> -
> =C2=A0static int ad7768_set_channel_label(struct iio_dev *indio_dev,
> =C2=A0						int num_channels)
> =C2=A0{
> @@ -1396,19 +1389,11 @@ static int ad7768_probe(struct spi_device *spi)
> =C2=A0		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap24),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap24");
> =C2=A0
> -	st->vref =3D devm_regulator_get(&spi->dev, "vref");
> -	if (IS_ERR(st->vref))
> -		return PTR_ERR(st->vref);
> -
> -	ret =3D regulator_enable(st->vref);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified vref supply\n");
> -		return ret;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7768_regulator_disable, s=
t);
> -	if (ret)
> -		return ret;
> +	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get VREF voltage\n");
> +	st->vref_uv =3D ret;
> =C2=A0
> =C2=A0	st->mclk =3D devm_clk_get_enabled(&spi->dev, "mclk");
> =C2=A0	if (IS_ERR(st->mclk))


