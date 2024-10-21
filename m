Return-Path: <linux-iio+bounces-10840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6F29A5E3B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CAB22BE0
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556F1E0E11;
	Mon, 21 Oct 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaoSj5s/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE14C70
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498267; cv=none; b=jOaJX6XSPwXybSLdkiKhMCsTxeaHKRd+r8p+qzPe+9Eu8QxFWG02tMiKyLxWiynXPlgSEegNj8PR8hKtIAX3J0mhVJGjvEJYTQi8TSajXFsONoehu4tavd4yV3LzMo9KkPHgUGHmxS0nf/IB7Gk1pkmCpycDJCAoNiRLS0ykiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498267; c=relaxed/simple;
	bh=kBJxiIULoFjaJX3RmSIy+5m4x/N9OPokwgYpQRR4dQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gClHNPbphpc/2x6ctj1W0JoTYFhZ7jxZqEJDcvgDgZZNqS9Ogdy4N87PJCKpAS2RvS9pAoSn51NW6ipcC5Qn0AjA25BGbicJZZPM9leRZj+j93SW1zt08430rSYl+FRRtb5yoTYQdru1ccmmqz08TdfV8mA+DJoE61DUugR/pUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaoSj5s/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so27908315e9.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729498263; x=1730103063; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=63rePoWtKIxPd2SjyIPJSJEuDLj1WduP4urIlMbb+P4=;
        b=aaoSj5s/o5bkC1S/fqb+OhRUao8S03QXedrT2unBCivFhL66q7mZmS+vW1FnWJC/8N
         B0Pv3tYRo72X2PDDi/GWtmWzJDG/1Qyu0zFjK+p1J5IoSaVYq0HV/6MGyZXRHK+4wDaT
         uzVly+77kqR5rxORyHQD29BRUWnORQ8ghFfZofoZEasmAPxN5nk7Zy4W3ojBE2CGHHbX
         UwmD7Cn8xwDRGIJtvyefItGb2/evXoPL8s7NsYp+3f1WdfmM+kCzJAvozvymLgD10WFl
         m9/3fGgpwsnyXXXbf2tTL4uQJWIKDJ1Atitd9mp4y+wBwB3VrOY/eLnY+mDQYwn8ZnN8
         DOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498263; x=1730103063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63rePoWtKIxPd2SjyIPJSJEuDLj1WduP4urIlMbb+P4=;
        b=YFIJDk0R+m4iV2tUIXm/WnRAJ8COSmXqtjSCNka/zLt/KUQDc3tILiaAL/X0AqFkAg
         ANc31wHaqvA4GY1nF/pBQl5p31OTOLtGm303nP+ZYJvlAPIwJDgn3BZzMKlPE8QR6jSI
         Tqnclse7/ChKj2pXpFzTry9DYFNpOlDaW8d2inrgLznkSZ71cy+ZECIisS4tH+7UiwhD
         EwLMw5p7R7rQYd32Hvr6r4hpzqKed6ANW/kxRlJkVcjRr1fBi/pQ7X01Urb2ybTozXOw
         8JpeJJy07I3fNRhvMDziRkZq8ka8ZmZAGI4czGXgABNQGTSdA/NcHWyZgtBDsYityk2o
         YYDA==
X-Forwarded-Encrypted: i=1; AJvYcCUrZ+CZm1/IKcA23ii629V5GrkHmVWN6wn0ugEhxpEdPsGUJIvKK/WbJEof/ImNwNX7xyCvAo+CteY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3Fb0ntKWoKqWJlh4ObGGAf5DvHAS6yRRLPS2rGrASAjCOfGW
	iMaHpwCAaOuxras6C5ShLNehuxQA++/UV5XHqJCDNfqE7L8fhn57
X-Google-Smtp-Source: AGHT+IEhm+4VREeSbN6prFWVcdPLIs+0UHM2WWwNuZzcoZxIxeG04kARbBWfoZzSuo3ykbMH0ZTB4Q==
X-Received: by 2002:a05:6000:1cd:b0:374:c059:f2c5 with SMTP id ffacd0b85a97d-37eab6e38cfmr7049525f8f.22.1729498263024;
        Mon, 21 Oct 2024 01:11:03 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93d53sm3693558f8f.70.2024.10.21.01.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:11:02 -0700 (PDT)
Message-ID: <7922db0bddfe828ec3783161b6bae25090d1e5f8.camel@gmail.com>
Subject: Re: [PATCH] iio: accel: replace s64 __aligned(8) with aligned_s64
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Date: Mon, 21 Oct 2024 10:15:19 +0200
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

LGTM,

Reviewed-by; Nuno Sa <nuno.sa@analog.com>

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


