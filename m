Return-Path: <linux-iio+bounces-10841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55919A5E5D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 10:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B0D1F21BE9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE841E1C03;
	Mon, 21 Oct 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS02tnQU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235A1E0E11
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498444; cv=none; b=CYPi4V65Cxqoe5sblRmSz8RO26nI1ltIeXC1LToaEU6CBRKIc3hW0siPMT/74JUKF7g2XpM1QwhdTOLnulse5kQb7vVhWsAGUoZTN4FqFRR1/RPvzHcFiqNEz2SRoqDjYa6FjfFklxNyKHvkUY6RBzGcIF3rpsEYoS5rBhixAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498444; c=relaxed/simple;
	bh=Xt/COndcGDwtm3ARGtbssbrr1M6QQGPt6FKHYlHleIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THjoity9RdckK2aLS9fHZ9zC+gOSQPMXiDI0cljhcnuVleCABaJLuN0OljfEopDtBgBIo1/KY+rjTr8kqAGTRFofnu1qoMEmjj557g9tu3/VEqZzyP+QOEMoWPo2ohwPih/bpUc+rXfiP85i9yYd6djazFOg1SPjQIF57rrYDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS02tnQU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so40436345e9.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 01:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729498441; x=1730103241; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3v+jRxNcW9H8DHO6jNzgd8XK2Wv9ImbHFhNjB76Hrxc=;
        b=TS02tnQUgnQ454V6DFxjOIPUPKU78ZUPU5k45UdLivxgTG6x2b/aTcASZZstxHN30F
         w+7Hp2FYv2c1bRQcooJMqPaGB2kQfSZfNPaVoD0OcWY/1EKtAwuMN7Dwl+KEjCZ5WyFl
         pQDUsUskL0kT7T56fHBSj1z/iHJ6oyZLQkATQd0KYsfX0GyUxPTBQGpxaDxCEsXKlHqd
         JiZ+9BY//Q19vL9ozK4yNjARvoRklztdzjP16W/5Az5PXEHNTIfgQzgHVCPgs7aKSHvM
         g9XbdB5tZlEzXASrep5v/pff8YxO0qOTkdD1bSRoLGp8E31ryLRA8pQBgbGi4u6g9r0x
         4vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498441; x=1730103241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3v+jRxNcW9H8DHO6jNzgd8XK2Wv9ImbHFhNjB76Hrxc=;
        b=aXPxmuRLCZOLjgCxdeREYr6gdk/cHwebiplZJUHIMKGpKUMNyJknBFmmP/HhCLg8IE
         T39oBzsDjRhc8e14tY3yyjAIQjqez6stj05lCbtqMiFuDG92S0iCFbYzxBEwREil2Hsm
         O9sKcTds5kZPMBNJXVegoyX9s3pYHdg3l5/quUN3cow24shjmRJw5mwlr31PsHcV/FU9
         Z0m/3TwCgT5whrlj907WbJkN2bw9mUtrpCX6M+RpP5XNH+Nv0u1WYVyCwQ2tWUObqCtZ
         XdQKzejnFq4/xGbTP7mA82JWaqdUVRWl81uJsz22x+0X/wQzeITvYJYUyVnCG1VlfFZX
         o6vg==
X-Forwarded-Encrypted: i=1; AJvYcCUig+QuL3SKdzY/iU0vH+cq53uBbw43kh1NRbsR1064aCCwgQWwvCekn2asqqk90SHqZ8fPll22vJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT1lRQfEMvkRmOBvtJyazjL6RyuL7I3j/E3M00+tTQ6pbCCbQA
	tUr/4mvIiwirQEvbOIujSdsePsrhz+d4QCFtEnRwgfu2ebRedjmB
X-Google-Smtp-Source: AGHT+IHib2wb+tkBOiEcbByOf8s7l40ZL6yDsYmhp+h8TOMelJ0RsEVcYtdQ3jBj0a8i6sBCWEO/Eg==
X-Received: by 2002:a05:600c:4f09:b0:431:5ce5:4864 with SMTP id 5b1f17b1804b1-431616a5a88mr63336715e9.35.1729498426126;
        Mon, 21 Oct 2024 01:13:46 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58c192sm48742125e9.25.2024.10.21.01.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:13:45 -0700 (PDT)
Message-ID: <8418771eb2cdc3fd5df02f76ffc45cb7396fb8df.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: replace s64 __aligned(8) with aligned_s64
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Mon, 21 Oct 2024 10:18:03 +0200
In-Reply-To: <20241020180720.496327-1-jic23@kernel.org>
References: <20241020180720.496327-1-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-10-20 at 19:07 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> e4ca0e59c394 ("types: Complement the aligned types with signed 64-bit one=
")
> introduced aligned_s64. Use it for all IIO accelerometer drivers.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---
>=20

Giving a proper tag this time :)

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> I debated whether to split this up by driver by the time we've done all I=
IO
> drivers that will be a very large number of trivial patches.
>=20
> The changes are minor enough that they shouldn't present much of a
> backporting challenge if needed for future fixes etc.
>=20
> I'm find splitting them up if people prefer.
> Next on my list is to look at adding runtime checks that the buffers
> containing these timestamps are big enough but I want this out of the
> way first.
>=20
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/iio/accel/bma180.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/bma220_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0drivers/iio/accel/bma400_core.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/iio/accel/bmc150-accel.h=C2=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/fxls8962af-core.c | 3 ++-
> =C2=A0drivers/iio/accel/kionix-kx022a.c=C2=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/kxcjk-1013.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++=
-
> =C2=A0drivers/iio/accel/kxsd9.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/mma7455_core.c=C2=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/mma8452.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/msa311.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/mxc4005.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/stk8312.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 3 ++-
> =C2=A0drivers/iio/accel/stk8ba50.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 3 ++-
> =C2=A014 files changed, 26 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 1fe20eb78a0b..41a517e1630f 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/string.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> =C2=A0#include <linux/iio/buffer.h>
> @@ -144,7 +145,7 @@ struct bma180_data {
> =C2=A0	/* Ensure timestamp is naturally aligned */
> =C2=A0	struct {
> =C2=A0		s16 chan[4];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
> =C2=A0	} scan;
> =C2=A0};
> =C2=A0
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_sp=
i.c
> index d33218e40c79..2d27a592a61e 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/mod_devicetable.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0
> =C2=A0#include <linux/iio/buffer.h>
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_c=
ore.c
> index d96840d135c6..eb32c963dfc8 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -115,7 +115,7 @@ struct bma400_data {
> =C2=A0	struct {
> =C2=A0		__le16 buff[3];
> =C2=A0		u8 temperature;
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} buffer __aligned(IIO_DMA_MINALIGN);
> =C2=A0	__le16 status;
> =C2=A0	__be16 duration;
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-
> accel.h
> index 7775c5edaeef..7a7baf52e595 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -6,6 +6,7 @@
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/mutex.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/workqueue.h>
> =C2=A0
> =C2=A0struct regmap;
> @@ -69,7 +70,7 @@ struct bmc150_accel_data {
> =C2=A0	 */
> =C2=A0	struct {
> =C2=A0		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} scan;
> =C2=A0	u8 bw_bits;
> =C2=A0	u32 slope_dur;
> diff --git a/drivers/iio/accel/fxls8962af-core.c
> b/drivers/iio/accel/fxls8962af-core.c
> index 37f33c29fb4b..ab427f3461db 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -22,6 +22,7 @@
> =C2=A0#include <linux/property.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/regmap.h>
> +#include <linux/types.h>
> =C2=A0
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/events.h>
> @@ -163,7 +164,7 @@ struct fxls8962af_data {
> =C2=A0	const struct fxls8962af_chip_info *chip_info;
> =C2=A0	struct {
> =C2=A0		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} scan;
> =C2=A0	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode.
> */
> =C2=A0	struct iio_mount_matrix orientation;
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix=
-
> kx022a.c
> index 53d59a04ae15..32387819995d 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -16,6 +16,7 @@
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/string_choices.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/units.h>
> =C2=A0
> =C2=A0#include <linux/iio/iio.h>
> @@ -292,7 +293,7 @@ struct kx022a_data {
> =C2=A0	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> =C2=A0	struct {
> =C2=A0		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} scan;
> =C2=A0};
> =C2=A0
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-101=
3.c
> index b76df8816323..bbf65fc97b08 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -11,6 +11,7 @@
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/string.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/acpi.h>
> =C2=A0#include <linux/pm.h>
> =C2=A0#include <linux/pm_runtime.h>
> @@ -250,7 +251,7 @@ struct kxcjk1013_data {
> =C2=A0	/* Ensure timestamp naturally aligned */
> =C2=A0	struct {
> =C2=A0		s16 chans[AXIS_MAX];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
> =C2=A0	} scan;
> =C2=A0	u8 odr_bits;
> =C2=A0	u8 range;
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 70dfd6e354db..6d2b0a22e550 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/sysfs.h>
> =C2=A0#include <linux/slab.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/bitops.h>
> @@ -215,7 +216,7 @@ static irqreturn_t kxsd9_trigger_handler(int irq, voi=
d *p)
> =C2=A0	 */
> =C2=A0	struct {
> =C2=A0		__be16 chan[4];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} hw_values;
> =C2=A0	int ret;
> =C2=A0
> diff --git a/drivers/iio/accel/mma7455_core.c
> b/drivers/iio/accel/mma7455_core.c
> index a34195b3215d..50f7ac1845c6 100644
> --- a/drivers/iio/accel/mma7455_core.c
> +++ b/drivers/iio/accel/mma7455_core.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <linux/iio/triggered_buffer.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/regmap.h>
> +#include <linux/types.h>
> =C2=A0
> =C2=A0#include "mma7455.h"
> =C2=A0
> @@ -58,7 +59,7 @@ struct mma7455_data {
> =C2=A0	 */
> =C2=A0	struct {
> =C2=A0		__le16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} scan;
> =C2=A0};
> =C2=A0
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 62e6369e2269..de4525b30edc 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -32,6 +32,7 @@
> =C2=A0#include <linux/delay.h>
> =C2=A0#include <linux/pm_runtime.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> =C2=A0
> =C2=A0#define MMA8452_STATUS				0x00
> =C2=A0#define=C2=A0 MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> @@ -115,7 +116,7 @@ struct mma8452_data {
> =C2=A0	/* Ensure correct alignment of time stamp when present */
> =C2=A0	struct {
> =C2=A0		__be16 channels[3];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} buffer;
> =C2=A0};
> =C2=A0
> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> index 57025354c7cd..e7fb860f3233 100644
> --- a/drivers/iio/accel/msa311.c
> +++ b/drivers/iio/accel/msa311.c
> @@ -34,6 +34,7 @@
> =C2=A0#include <linux/pm_runtime.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/string_choices.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/units.h>
> =C2=A0
> =C2=A0#include <linux/iio/buffer.h>
> @@ -893,7 +894,7 @@ static irqreturn_t msa311_buffer_thread(int irq, void=
 *p)
> =C2=A0	__le16 axis;
> =C2=A0	struct {
> =C2=A0		__le16 channels[MSA311_SI_Z + 1];
> -		s64 ts __aligned(8);
> +		aligned_s64 ts;
> =C2=A0	} buf;
> =C2=A0
> =C2=A0	memset(&buf, 0, sizeof(buf));
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index fc54a2a4693c..cb5c4e354fc0 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -11,6 +11,7 @@
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/mod_devicetable.h>
> =C2=A0#include <linux/regmap.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/iio/sysfs.h>
> =C2=A0#include <linux/iio/trigger.h>
> =C2=A0#include <linux/iio/buffer.h>
> @@ -69,7 +70,7 @@ struct mxc4005_data {
> =C2=A0	/* Ensure timestamp is naturally aligned */
> =C2=A0	struct {
> =C2=A0		__be16 chans[3];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
> =C2=A0	} scan;
> =C2=A0	bool trigger_enabled;
> =C2=A0	unsigned int control;
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index abead190254b..471c154c3631 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/delay.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -105,7 +106,7 @@ struct stk8312_data {
> =C2=A0	/* Ensure timestamp is naturally aligned */
> =C2=A0	struct {
> =C2=A0		s8 chans[3];
> -		s64 timestamp __aligned(8);
> +		aligned_s64 timestamp;
> =C2=A0	} scan;
> =C2=A0};
> =C2=A0
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index a32a77324e92..cab592a68622 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mod_devicetable.h>
> +#include <linux/types.h>
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -94,7 +95,7 @@ struct stk8ba50_data {
> =C2=A0	/* Ensure timestamp is naturally aligned */
> =C2=A0	struct {
> =C2=A0		s16 chans[3];
> -		s64 timetamp __aligned(8);
> +		aligned_s64 timetamp;
> =C2=A0	} scan;
> =C2=A0};
> =C2=A0


