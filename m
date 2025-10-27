Return-Path: <linux-iio+bounces-25464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64408C0DBBD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1421A423FEA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 12:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601F92459E1;
	Mon, 27 Oct 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmLRDG7+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728B2231858
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569459; cv=none; b=EDB46Zfjw1D5r2euhNpFf71apT6CtcKZtN02CP8MSmx98AL+NmIG3QGOrwWox0oOV6R5OU4+k1W49tzXZYFPL8oIxokjepjt4HO22apGxjUuGxzuj5+6gB+6uhF1HLC6TaJGsZyJE28SSWcoREmYF8ryw16mEqOzi/0TawH+71c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569459; c=relaxed/simple;
	bh=4O6Fak0YkFyyHEXpPlXp+5rEysQmXbAYc8epUwyT5wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juXCyCsl1HL7KI407m85Jiux6l6OCwYHYI2cgWCMPawVqDjNAwpixFDa1R6dAr2Jh49UEEkvKxwrApAQtKPbmGayV3IWtbp04RK7awCqUgMPMW6wBFcjhGny8Q5cGy9vxnbvURoYSrIrxlXcTbcieoJxmymcn+D9dlNvbf5QmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmLRDG7+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-592ee9a16adso7911856e87.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761569456; x=1762174256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=37O4qKRJBc2jvfDWrKiGmX8gYqkd2w99cpfcHZsHVNk=;
        b=DmLRDG7+dBAadk4y3T5UrL1KgFeJl9Jm+BJn9ux52dn/YoH88WWsHFkHq98ZVevNhl
         rvoM4baTFyShRb7IPxLaO6oNMOtF/mUnWrLzHbIoJe39d34v/6Yh9vG55GDGyOZKqZfH
         I2JrQoHXyiTfJd3HkBB1vL40pd6gxCfsu7YX0cquXGHFopkfnQP3UcBeZxCxUbFDt3SB
         9CvIciMCHBSzjqMpQMx1l62+Isp8rCa2uldTEhLcSCHzn2I9EuqX/w26qFgQvQOjRtDB
         mCDfxFW2LV5PFZtESzo0QDgkfyXwjqoNno852AjXcSXddgOH5lUiuvaGwHcpR2A3uO+g
         lTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569456; x=1762174256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37O4qKRJBc2jvfDWrKiGmX8gYqkd2w99cpfcHZsHVNk=;
        b=Df31WAnp0miiTxAem+d9NmWPEkWsPLdDyZ0cn/YanndoTm5ceTI3HW/rk5fLQKeFPW
         8nb0sF9ZrYd13PbiFcAPk5vKGQlzChGIMryhu919YhNW0q1qGhIwu56TCl4rGTcAQTXz
         G0kswLNZL/86XCqZnoV0m9/XiS5SQ5Ox/nFYtFQoJFLshNdd+9liHhlHVpykTmLSN9dC
         hPFGfau1l+JgmFSJdBDZM5vq0MhoTTN6HT1zKXxcipF4GiuuqG63euLuM38fV9GAXAh9
         nR6MYQwuiks6zRxPXWTzV9gjqykr3VqH6cxVvgU9jAU0em7K0uohHIr+y3GCMRpc+sEF
         6Tcw==
X-Forwarded-Encrypted: i=1; AJvYcCWVAMQNyeDOk7jizVRIISI+A30ufuxh/hOgkpCpXLrmn3NPit0NzFkL/XQbuzBmk7UNXOhXyAbgq2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEYDh15+WfQo7x9Pjxd1e1tpAAt/GWoIMadEOCBugOTcHYsIFD
	sNw7k3mKujqn1ghk3CUdUsW48mMPC1wMvHh3dtsc+V5Js9TAnu8DWl9QLhOH4qE8
X-Gm-Gg: ASbGncvNxih9VyBkQtMgdhWe6X2k3Iv2OAihOQc3ZAn3G9uve6EruVTF2vNVmCudFKr
	ZSa8ueAFBDTfhrt5PdrOPtrJgZ89Uh269y3PaOls+lOVxJurddDyqLzILLLgMfmDWamiU4n/r6s
	9rHAPWLJSTj8uqhJ6lKHMac9tvVDq/AfMO6xLtCTT+RG+s+7/lyab1pxAFi1hCKmqZLtraIwLT7
	CPoWyGBo4k35LtMAgWh8jORGfiOT2scfx9dyc+OOaxQubLmoduGZsRiztm1gIXcOkeedz5muJ5y
	v3jd19vTVOaTTvquTKOvWL8QYOSt0fWtpTvwzQM4WiaxSMuqAsj7HGYE/DnldzfyNMBgHGORXEw
	WdpGnFuB1ptSoh3a5y4F0haB3O72p0wzAvARxyhjxvLbm0gpX1cuBoQZng/OqlnI1kay0AD/iNg
	SE5tJZu7JMFi7c9upr3w==
X-Google-Smtp-Source: AGHT+IGv221R2iQIFs9R9mJVke8SKeb9zlIfzVvYe4ptw8r4RsNh+khkFd+dY8VHpRKJmHlBDQQaxA==
X-Received: by 2002:a05:6512:b01:b0:592:f855:2d15 with SMTP id 2adb3069b0e04-592f8552dd1mr5297716e87.46.1761569455430;
        Mon, 27 Oct 2025 05:50:55 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41bdasm2260394e87.16.2025.10.27.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:50:54 -0700 (PDT)
Date: Mon, 27 Oct 2025 14:50:51 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: rohm-bd79124: Use regmap_reg_range()
Message-ID: <7e5d8edca0d77ce3f4e8327501c78efe4da806e6.1761569177.git.mazziesaccount@gmail.com>
References: <cover.1761569177.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TTVG05uvdQ/2lkyW"
Content-Disposition: inline
In-Reply-To: <cover.1761569177.git.mazziesaccount@gmail.com>


--TTVG05uvdQ/2lkyW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Initializing the regmap_ranges using direct assignment to the range_min
and range_max members is slightly verbose. We can make it a tad cleaner
when using the regmap_reg_range() macro.

Clean up the code using regmap_reg_range() when initializing the
regmap_range structure.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Compile tested only.
---
 drivers/iio/adc/rohm-bd79124.c | 39 ++++++++--------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index 06c55c8da93f..fc0452749b79 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -126,13 +126,8 @@ struct bd79124_data {
 };
=20
 static const struct regmap_range bd79124_ro_ranges[] =3D {
-	{
-		.range_min =3D BD79124_REG_EVENT_FLAG,
-		.range_max =3D BD79124_REG_EVENT_FLAG,
-	}, {
-		.range_min =3D BD79124_REG_RECENT_CH0_LSB,
-		.range_max =3D BD79124_REG_RECENT_CH7_MSB,
-	},
+	regmap_reg_range(BD79124_REG_EVENT_FLAG, BD79124_REG_EVENT_FLAG),
+	regmap_reg_range(BD79124_REG_RECENT_CH0_LSB, BD79124_REG_RECENT_CH7_MSB),
 };
=20
 static const struct regmap_access_table bd79124_ro_regs =3D {
@@ -141,22 +136,11 @@ static const struct regmap_access_table bd79124_ro_re=
gs =3D {
 };
=20
 static const struct regmap_range bd79124_volatile_ranges[] =3D {
-	{
-		.range_min =3D BD79124_REG_RECENT_CH0_LSB,
-		.range_max =3D BD79124_REG_RECENT_CH7_MSB,
-	}, {
-		.range_min =3D BD79124_REG_EVENT_FLAG,
-		.range_max =3D BD79124_REG_EVENT_FLAG,
-	}, {
-		.range_min =3D BD79124_REG_EVENT_FLAG_HI,
-		.range_max =3D BD79124_REG_EVENT_FLAG_HI,
-	}, {
-		.range_min =3D BD79124_REG_EVENT_FLAG_LO,
-		.range_max =3D BD79124_REG_EVENT_FLAG_LO,
-	}, {
-		.range_min =3D BD79124_REG_SYSTEM_STATUS,
-		.range_max =3D BD79124_REG_SYSTEM_STATUS,
-	},
+	regmap_reg_range(BD79124_REG_RECENT_CH0_LSB, BD79124_REG_RECENT_CH7_MSB),
+	regmap_reg_range(BD79124_REG_EVENT_FLAG, BD79124_REG_EVENT_FLAG),
+	regmap_reg_range(BD79124_REG_EVENT_FLAG_HI, BD79124_REG_EVENT_FLAG_HI),
+	regmap_reg_range(BD79124_REG_EVENT_FLAG_LO, BD79124_REG_EVENT_FLAG_LO),
+	regmap_reg_range(BD79124_REG_SYSTEM_STATUS, BD79124_REG_SYSTEM_STATUS),
 };
=20
 static const struct regmap_access_table bd79124_volatile_regs =3D {
@@ -165,13 +149,8 @@ static const struct regmap_access_table bd79124_volati=
le_regs =3D {
 };
=20
 static const struct regmap_range bd79124_precious_ranges[] =3D {
-	{
-		.range_min =3D BD79124_REG_EVENT_FLAG_HI,
-		.range_max =3D BD79124_REG_EVENT_FLAG_HI,
-	}, {
-		.range_min =3D BD79124_REG_EVENT_FLAG_LO,
-		.range_max =3D BD79124_REG_EVENT_FLAG_LO,
-	},
+	regmap_reg_range(BD79124_REG_EVENT_FLAG_HI, BD79124_REG_EVENT_FLAG_HI),
+	regmap_reg_range(BD79124_REG_EVENT_FLAG_LO, BD79124_REG_EVENT_FLAG_LO),
 };
=20
 static const struct regmap_access_table bd79124_precious_regs =3D {
--=20
2.51.0


--TTVG05uvdQ/2lkyW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmj/aqsACgkQeFA3/03a
ocWnVwgAh8x3JHPb5/YGIWJXONYVYMYvwo9z7ZCQUv6gya+4UjMeTE7ZWxXHpIRL
LysmyXt3wWB3qVBKTz6H8jqmKgGLJ7yklUNQF+jShuBUZllgHLxt9YzTcGdubB5X
nGdnq26PicZtaqsa+YzjmmbVKsOkDFCa3mEITPWzF9rz84lgpowujERB/6DtTdiR
tkCXk3WZrtV/mbPUkAHQOf/VKvaylS/hNb2hNXh7zvhuS8x1FrHFSnztdJKUz63B
lN8yxG7qDc7vI/kE7ZSPE9oSWWtMj9nQQlQOmAyH1FZhqvWyie9Vh93B/xV8uHdi
/ELm+j8YKecqCvZA7b8RGQOB5l1cQQ==
=2Aaa
-----END PGP SIGNATURE-----

--TTVG05uvdQ/2lkyW--

