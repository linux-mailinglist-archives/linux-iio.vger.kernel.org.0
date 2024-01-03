Return-Path: <linux-iio+bounces-1409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D5F823735
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jan 2024 22:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E901C20D9B
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jan 2024 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A051DA2C;
	Wed,  3 Jan 2024 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ldXHG8K0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC6D1DA26
	for <linux-iio@vger.kernel.org>; Wed,  3 Jan 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cd1aeb1bf3so7451681fa.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jan 2024 13:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704317981; x=1704922781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+AIF4yNGi2dja8BCgq5OeAUBgUsXRyLuw34D2kZ4yA=;
        b=ldXHG8K0oueXdIZIGD0tAejCUpL1OzVGlORfyXrpqJ3aZtzEL+nRwd4DmAE/ELzdDp
         XQajeZBHp6Hgf11Tw3HWfPSXD3VQE/OAWxZEHBp3jLoRJPEkDpT7uZbBNCBdfaAXOsAJ
         uBUE2/6hIi2vbUAWHBaRy+ubvq65Btla/n7zB2vloeGhYxvtmqJ0ivzBUr8qxXSEa8rI
         tHw8RM3rFal9rINZ2JI9Mu8edAx1wB35oyfsHy/+t0j8WG4VKUZ3+PtR4e7QIf5Bs94Y
         O6YJETTyEMvEpvts76lpoA6k+fP95ThcFe9wTXSIGq7c0OJMwg5/RKO8SmYLQkjqkmE6
         wlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704317981; x=1704922781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+AIF4yNGi2dja8BCgq5OeAUBgUsXRyLuw34D2kZ4yA=;
        b=lfBuI05nB6yomnWl1HyZgjWIStYrUsZ4Ez6ofVqEyPmgsjvF9LuAHYelJKJNTcnRd4
         P3BBXG5ezBZqTLiOdmo2Eps/r13MlpimYSzuuCUNHVQd/vTg7gS5b9v5jg4X2/Vo9DF+
         BwXEV3gJvDkyA+A5p6KCj6xVy3AvTKWtJfXuqbPdneiq1K0XcHfE158Yv5fvFEBFldD5
         +QrEMGVboMkUc+mg60MKPhXcMBgf7OJoTX/ZRKvMnpxqc3aRyObo4GimnuSp952X1LAR
         POq40cihqy9opTei69cAwVjegn1TPTHYaauvfJ0lYc+qO3Vo6Y/Pm7B6N/op8ryazeuu
         A/WA==
X-Gm-Message-State: AOJu0Yzzr+6JgXVDvTWtSsE1B7+Ak30kB1pQJzCS/gWAeQ9/gE9NALjJ
	2M1BOi33Arrc5MbVRilVYkiz/lCErgTL/NSb6Gxn8HDQhnkNqQ==
X-Google-Smtp-Source: AGHT+IGYwc0Z+OoYf9gRchldd/zsmaHTh6H9KXhOhxmqlpWrivpDtIVb/VUOzOZS102/op8wl0KG+/+jH0xvkr0nyTc=
X-Received: by 2002:a05:651c:b27:b0:2cd:171c:1f42 with SMTP id
 b39-20020a05651c0b2700b002cd171c1f42mr837495ljr.2.1704317980590; Wed, 03 Jan
 2024 13:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com> <20231220-iio-backend-v4-4-998e9148b692@analog.com>
In-Reply-To: <20231220-iio-backend-v4-4-998e9148b692@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 3 Jan 2024 15:39:29 -0600
Message-ID: <CAMknhBHqnQoEMoaFQxp5Us+X7bs7G2J2QTNZwguPmJ7XwEHe0Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] of: property: add device link support for io-backends
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 9:32=E2=80=AFAM Nuno Sa <nuno.sa@analog.com> wrote:
>
> From: Olivier Moysan <olivier.moysan@foss.st.com>
>
> Add support for creating device links out of more DT properties.
>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index afdaefbd03f6..a4835447759f 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1244,6 +1244,7 @@ DEFINE_SIMPLE_PROP(interconnects, "interconnects", =
"#interconnect-cells")
>  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
>  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
>  DEFINE_SIMPLE_PROP(io_channels, "io-channel", "#io-channel-cells")
> +DEFINE_SIMPLE_PROP(io_backends, "io-backends", NULL)

In v3 it was agreed that adding #io-backend-cells right way seemed
like a good idea. Do we need to include that here?

>  DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
>  DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
>  DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells"=
)
> @@ -1334,6 +1335,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>         { .parse_prop =3D parse_iommu_maps, .optional =3D true, },
>         { .parse_prop =3D parse_mboxes, },
>         { .parse_prop =3D parse_io_channels, },
> +       { .parse_prop =3D parse_io_backends, },
>         { .parse_prop =3D parse_interrupt_parent, },
>         { .parse_prop =3D parse_dmas, .optional =3D true, },
>         { .parse_prop =3D parse_power_domains, },
>
> --
> 2.43.0
>
>

