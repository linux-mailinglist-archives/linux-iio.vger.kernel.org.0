Return-Path: <linux-iio+bounces-771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080CA80AE7F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 22:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77FE281AF6
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C2B57304;
	Fri,  8 Dec 2023 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1FOuNTas"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769091734
	for <linux-iio@vger.kernel.org>; Fri,  8 Dec 2023 13:03:30 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so30819931fa.2
        for <linux-iio@vger.kernel.org>; Fri, 08 Dec 2023 13:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702069408; x=1702674208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCi2po4nRjlaziOyq9XY4t2jyFLyXekskEb5+lw8sWc=;
        b=1FOuNTasBWa0n+ZFv9ai/qECmd1LcuKQi7m7Qdv8W+/hRj38cHVrGid2zLT9Gie+yZ
         hAtOLmHFZT3sYiuF40Rojoyv/YLseE48fVk36wcktDtE8LRVtehuvBpBqKTAnmj0/qm8
         NNYChi1p5STltx0JiMMjBVIXQaTRb7ZHCFQMOG+EfjlpHmsRPvgNmqfk0C3NACMNGHSZ
         k1CYSu/sFCNC4v0x1Hc5n7f4rkfhK/GuPrHmliybF1XYqj7iKQ9NEYjLKL2vxtxYFmKP
         6fU6GOsTgppCg1Qgb3of7cyPMW4ocgo0psENWsXTteCbhps6x4bXQ4Oc5jgw7cxoP4Bf
         LOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069408; x=1702674208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCi2po4nRjlaziOyq9XY4t2jyFLyXekskEb5+lw8sWc=;
        b=H9bwggWZAz3ln/xB+7e/73uI4BWRn6z4oUT2dx1MwjaAYyw7tOfWYbF301/ZSTK0yh
         AIbbparMKZZfoDBXI3h2VTOySjeRwnw1QjQTRx5XW2571m6pddJvYQMlkxdKewgt2VL/
         YhuWx1Abfh08t5of+fg+oomGIguUnid8TMN8JTGFaRSPVOwLXda9Xz9DyTH0xZM+bo45
         Yh4Iqjx++v6m05bh0D3xdzKXrtkpxM8BTcBKlfxIGSUEyYURBYGUK9rZxhbfemXNqhfd
         V95b7zzR9srRAtFuL6d/o1M4kvE9bxx5mDFNzw90O7BGTqgJyi0UVPFEITSmbaTOFB2g
         n2pg==
X-Gm-Message-State: AOJu0YyiT31o9rcMfUvU91fSYPvft/SGyfljH/h7lxQB2Bh/s7jkdL9Y
	2AS25Etnq/OOm6hqkxM8t3ljJ+Oh1c82erakqTERRzq+UZGfVTR3DWQ=
X-Google-Smtp-Source: AGHT+IHj15CpIXY/CgfF9I+sEq3Guw0XiYVd37u32w3HFLRyzYYLSheTV91Zlsxf/OrVKjPH5Qm0mFm0WpmvcRM5Dj4=
X-Received: by 2002:a2e:9ec4:0:b0:2ca:1a1:c286 with SMTP id
 h4-20020a2e9ec4000000b002ca01a1c286mr141361ljk.74.1702069408580; Fri, 08 Dec
 2023 13:03:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com> <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
In-Reply-To: <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 8 Dec 2023 15:03:17 -0600
Message-ID: <CAMknhBGKaVmfs6rhb7RfzMEvji8G-BFBu4=QZSS0WSrfL7rrqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:52=E2=80=AFAM David Lechner <dlechner@baylibre.com=
> wrote:
>
> This adds a new driver for the AD7380 family ADCs.
>
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
>
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

...

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index bee11d442af4..e046d8004f41 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
>  obj-$(CONFIG_AD7292) +=3D ad7292.o
>  obj-$(CONFIG_AD7298) +=3D ad7298.o
>  obj-$(CONFIG_AD7923) +=3D ad7923.o
> +obj-$(CONFIG_AD7476) +=3D ad7380.o

copy/paste oops: should be CONFIG_AD7380

>  obj-$(CONFIG_AD7476) +=3D ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o

