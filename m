Return-Path: <linux-iio+bounces-5061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3058C6F2A
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 01:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E288D1C211BC
	for <lists+linux-iio@lfdr.de>; Wed, 15 May 2024 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AB4EB2C;
	Wed, 15 May 2024 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ijm3BpHA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87153FE55
	for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715815668; cv=none; b=YtkEweOSyZwpEUHKCXdqydy0hxy8h4+Ae3EI9kvfZ7znet4t8YOXx5B3Verf0RUy4lNMIc+3uNv3Acb5cPvI/Ktki/t8noiYrSDRlFkngQbSGq2F2M4Pa4p/sBBzrHsJymXEMKWonglqfHB7ywZyDwOnSVBWSzG8pzfnuKoY25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715815668; c=relaxed/simple;
	bh=jMCf65n6mZ9Lh1wcVdqz3IcOWbhY/JMPATbvY5TnZNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buxjxLNHLjLmcFtUlLiSEErEqrqusA/07nMh7BTwH+ZOHJ9RincgtKlLqm91GFZduUN0hNuoAXaSaKCqTww6ShEjhYAeWZEZ0Vn5zzfFGO36gIaQFPvSb6D/HT5JVw3FcQrhwor3glS0f1yrK1R8xvLQAvQ4QnHujryvGmuDLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ijm3BpHA; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso1177291fa.0
        for <linux-iio@vger.kernel.org>; Wed, 15 May 2024 16:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715815664; x=1716420464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRsDSovNQ6qr5UiueXhcNuD8AQiDxUzPcRjU5GwfeDI=;
        b=ijm3BpHAjO5ZRm8qK936yBfaORsehiXAqIXb2P0ev4jPI+ixOpffPwqdUL0aMNbPHG
         p8ft2whMHgKbbJveSWTcrIgyxIhNdTNk9HIM3gXk1EAZOi0WEdoijrHuVH6Jw4GAKDYB
         TTaaTZahOTQ3pfTiB+BNiyut1SUeNPed0JYWTY7KHEQ5CLRtQ6OykERGgA9OSMKBT7MM
         fgFx8nYAKp746BkpImgIk3i3Euxa9koYkAA5Ap64ra0K1aOeM6Zbcu6+53ZHIPFBbfFE
         ZH8yFpgbjIIL14Pao4Jg2uGBWdMGgPb7M95RaCZVWc5gedYh6DsFWpYPK9wa2b1YYcNl
         1HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715815664; x=1716420464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRsDSovNQ6qr5UiueXhcNuD8AQiDxUzPcRjU5GwfeDI=;
        b=nclGknL0+D6vb3dhK2TvNbQONfFoPg9nQkCTapfA7leF5oMXH8IVAUGnOHAt63d2kB
         Qm3BLxyhAdhnGfc0g6s9C9ZHGCIZS75EadwLBY5p2zQyhEtiVt7kt33kLNE/LR4cbZ2b
         04ZndB9SqNm78mhGTC9zT4DI6o5gEdHsn6I7w3t4q6RxKlVYljRNbFIWcoWfda/Vcn/V
         wu+Cx07xpHC/o3A4gQ+5BuazgC5J3GMORyMbV0Mp5PtPwLQy4AriZ48PLqfOnOnUWE3o
         GK/L/McsbesQ7jaj/wpgYBgNnqY8UAvEbtXUXGNTmFjHBkYYC388vRbXUPaniIpjGzL2
         +sAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaE0TaMmEqQPALpFswY0/iE3CRrt7rarmCSqff2PDphkjFSar8xs02x/tU2/6enlQeMgjydH7khapgKG3lchATMncpktgc78RC
X-Gm-Message-State: AOJu0YxABw6Fts+nAZlOPxKc766mM1VNtLSsVOSt6m8TYaaTP2/P/EvU
	n9XkAipRWTbu2DDjW6yuUksuDyS6jEuexq4kuoMRj3tT1kjl2oIOsenbquAJtbLD80/BEntD+cI
	5YLifwdizh1wHFRfijEENow3eCuWwwsu33/iukw==
X-Google-Smtp-Source: AGHT+IGRYcDzysaEwMs+dmPXujOd5i72e9GniJRiB6FMPFjIQye9F3m69svhY+htiwz29H+tbPNaQgzqko6PuocNOxE=
X-Received: by 2002:a2e:1319:0:b0:2d8:4892:bee2 with SMTP id
 38308e7fff4ca-2e51b17f931mr63457721fa.20.1715815664025; Wed, 15 May 2024
 16:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com> <20240514-ad4111-v2-5-29be6a55efb5@analog.com>
In-Reply-To: <20240514-ad4111-v2-5-29be6a55efb5@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 15 May 2024 18:27:32 -0500
Message-ID: <CAMknhBF8D3YCro4duKrBoEkdc-SiCGwvHTg4SFb17ympUsG1nA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] iio: adc: ad7173: add support for special inputs
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 2:23=E2=80=AFAM Dumitru Ceclan via B4 Relay
<devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>
>  Add support for selecting REF+ and REF- inputs on all models.
>  Add support for selecting ((AVDD1 =E2=88=92 AVSS)/5) inputs
>   on supported models.
>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---
>  drivers/iio/adc/ad7173.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index fb33534d63a9..1e9ba3070770 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -65,6 +65,10 @@
>          FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
>  #define AD7173_AIN_TEMP_POS    17
>  #define AD7173_AIN_TEMP_NEG    18
> +#define AD7173_AIN_COM_IN_POS  19
> +#define AD7173_AIN_COM_IN_NEG  20
> +#define AD7173_AIN_REF_POS     21
> +#define AD7173_AIN_REF_NEG     22
>
>  #define AD7172_2_ID                    0x00d0
>  #define AD7175_ID                      0x0cd0
> @@ -145,6 +149,8 @@ struct ad7173_device_info {
>         unsigned int id;
>         char *name;
>         bool has_temp;
> +       /* ((AVDD1 =E2=88=92 AVSS)/5) */
> +       bool has_common_input;
>         bool has_input_buf;
>         bool has_int_ref;
>         bool has_ref2;
> @@ -215,6 +221,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>                 .has_temp =3D true,
>                 .has_input_buf =3D true,
>                 .has_int_ref =3D true,
> +               .has_common_input =3D true,
>                 .clock =3D 2 * HZ_PER_MHZ,
>                 .sinc5_data_rates =3D ad7173_sinc5_data_rates,
>                 .num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_ra=
tes),
> @@ -228,6 +235,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>                 .has_temp =3D false,
>                 .has_input_buf =3D true,
>                 .has_ref2 =3D true,
> +               .has_common_input =3D true,
>                 .clock =3D 2 * HZ_PER_MHZ,
>                 .sinc5_data_rates =3D ad7173_sinc5_data_rates,
>                 .num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_ra=
tes),
> @@ -243,6 +251,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>                 .has_input_buf =3D true,
>                 .has_int_ref =3D true,
>                 .has_ref2 =3D true,
> +               .has_common_input =3D false,
>                 .clock =3D 2 * HZ_PER_MHZ,
>                 .sinc5_data_rates =3D ad7173_sinc5_data_rates,
>                 .num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_ra=
tes),
> @@ -257,6 +266,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>                 .has_temp =3D true,
>                 .has_input_buf =3D true,
>                 .has_int_ref =3D true,
> +               .has_common_input =3D true,
>                 .clock =3D 16 * HZ_PER_MHZ,
>                 .sinc5_data_rates =3D ad7175_sinc5_data_rates,
>                 .num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_ra=
tes),
> @@ -271,6 +281,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>                 .has_input_buf =3D true,
>                 .has_int_ref =3D true,
>                 .has_ref2 =3D true,
> +               .has_common_input =3D true,
>                 .clock =3D 16 * HZ_PER_MHZ,
>                 .sinc5_data_rates =3D ad7175_sinc5_data_rates,
>                 .num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_ra=
tes),
> @@ -285,6 +296,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>                 .has_temp =3D false,
>                 .has_input_buf =3D false,
>                 .has_int_ref =3D true,
> +               .has_common_input =3D false,
>                 .clock =3D 16 * HZ_PER_MHZ,
>                 .sinc5_data_rates =3D ad7175_sinc5_data_rates,
>                 .num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_ra=
tes),
> @@ -298,6 +310,7 @@ static const struct ad7173_device_info ad7173_device_=
info[] =3D {
>                 .has_temp =3D true,
>                 .has_input_buf =3D true,
>                 .has_int_ref =3D true,
> +               .has_common_input =3D true,
>                 .clock =3D 16 * HZ_PER_MHZ,
>                 .odr_start_value =3D AD7177_ODR_START_VALUE,
>                 .sinc5_data_rates =3D ad7175_sinc5_data_rates,
> @@ -920,6 +933,14 @@ static int ad7173_validate_voltage_ain_inputs(struct=
 ad7173_state *st,
>                 if (ain[i] < st->info->num_inputs)
>                         continue;
>
> +               if (ain[i] =3D=3D AD7173_AIN_REF_POS || ain[i] =3D=3D AD7=
173_AIN_REF_NEG)
> +                       continue;
> +
> +               if ((ain[i] =3D=3D AD7173_AIN_COM_IN_POS ||
> +                    ain[i] =3D=3D AD7173_AIN_COM_IN_NEG) &&
> +                   st->info->has_common_input)
> +                       continue;
> +

If there is only one valid combination, it seems like these should be
fixed channels like the temperature input rather than something coming
from the device tree.

It looks like on AD411x, it is the case that there is only one valid
option for the reference input in the channel configuration. But in
the case of AD717x since both REF+ and REF- are listed as possible
inputs for both AINPOS0 and AINNEG0, it seems like they could be mixed
and matched with other channels. The datasheet doesn't seem very clear
on this though.

If it is valid to combine, say AIN0 with REF+ though, then the
validation would need to be relaxed. But I'm guessing that is not
actually the case?

>                 return dev_err_probe(dev, -EINVAL,
>                         "Input pin number out of range for pair (%d %d).\=
n",
>                         ain[0], ain[1]);
>
> --
> 2.43.0
>
>

