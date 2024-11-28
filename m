Return-Path: <linux-iio+bounces-12766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC209DB471
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3AE280ED5
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCC31534FB;
	Thu, 28 Nov 2024 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0A1PnIh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F714E2DA;
	Thu, 28 Nov 2024 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784520; cv=none; b=InMra2o4aueXzRcfTlv51i3CklznX39zr4QuBM4ymewFIJzL5zN/kiVAnvtu2/67H2XFv0OLsB+RhYaoc4qjOmcikThLyS+cqZtK93hBTzm2/BwuTA0RUaiDwB7Gug/1bG8YJNdCcjODAaZ3v6RiVopG/mEgPZgkXgTz07lrmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784520; c=relaxed/simple;
	bh=9iAKaGh/DbLk003XwnkBukVNgkdYG557ngzrsYJV5+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gv6fIxVhOJdtP7+LK9K8aPJgmvcgGSme3CG3a3v0DRer2IZCQyJYYhsawxx+bxJY9SjeMEbY7PEEBQliKzWSffIhcU2bpfke+VXdE7/5Z12rw/iR2S9DHzKQVOoYRsRbqZSZUXSpLUWWbfzzshoJJcW5V5vc/o/q9/8hAtTcp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0A1PnIh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd668c5easo647442e87.1;
        Thu, 28 Nov 2024 01:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784517; x=1733389317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LbQqOlzyfbKc10JjBshjc/RutnEOn1xDG4DaodXmXpI=;
        b=l0A1PnIhj5I4iz/zNvrsAju4dbx6VFZ1Pz2QvHS3BvBo7F14A1JB3gpOp65h8pBHZC
         7YnffSSwOCmcyGcWsuFyMTI/I6l3jxYUjtIjRF5A6I30ZHG1cWGlsDHIImj5eGHGS55A
         e7JbbFBMPhupGKoXZQrv0hBA6Nyk6eXbY49TITRKWPx1kp8wIVR8/gXFaa1EqbBxSN+D
         SChAku8QJu3OIEepp1Gr57xeVJX0uSoVro5B0MJP6PfoP4L+zDImBi0Q8EdDKZ/0Ft8s
         2EBKO0kpSJFiGKT/X16Vmmwnius2eDTy4JO90C3Hal8wIexqPfXM1oZz1lGd7/A5HtYa
         O2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784517; x=1733389317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbQqOlzyfbKc10JjBshjc/RutnEOn1xDG4DaodXmXpI=;
        b=fumYOD+AZEEfacR+gqPSw5qFhenIick388JvKMGRKe7UbcawfSpWHb5c3GvLbl8WTr
         3yTEEhPvM6KBR3Z90BmA4/5h/BYtrBVINbwArWi8BpTs8HeQvHs7BPaX8NN2ZM7DXY3b
         Fbb1zumFkPbEA4J/xW+a+32SAOFt/SbJeccZeT7ZHFHnufFptIFC01tyMzb7sjc5XFVE
         6yzpxfP4+MWfuNRMf1y4a2eguaORmIEUtDEeZXWvYdrqh15WK4xReUw8gmCcmCPbnKBJ
         l5b7ATBug2GA0TL9sdJrTLtERnxkowZNuEd/SxpPAPtoF11g5nARDGinGPCgBEH6X0G5
         sYMw==
X-Forwarded-Encrypted: i=1; AJvYcCViuFGWDJbXvnPOQDBmCPwmsdHIM7jx+oIPddYLQFAzEmtpctlIiIlf/gV9IwDVDJGQDInbP/1GcoEtq1YX@vger.kernel.org, AJvYcCWILNDHekI6JnDRpii7sbQKPbrWJV1qurbwHy6lx7IfYNxZKxNyWqTaXxeCIKx/NV2MVx0BBgDoSSEq@vger.kernel.org, AJvYcCXmAZO2dWE9EXcIA/LHzeGSfr3SThnWl9ZARNbtNQaC4BORRsmt7YZI8BJnUDWmZcjTzHDCrZ2aL7ru@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnrJ1fY9CHfFbn/RTas6PZ9vj2LJCUY5MFgPLs1Nc88AVs+ej
	AK0ERRi5v+aHYI5Gj2hgv2weotLKIjM9kwyhICw5pqO4Vqnv/St6
X-Gm-Gg: ASbGncsOEZzWkgwFK2tgHO2y55VuVpoUBvcgJbrMsM11gWCKX9V9maLQXpUqZRVf3nX
	0aweId8Hy8SjqaDjn+C1sjCJUpG3DAMFKpRFD/JBefFU4uoZrSudgpQH7M92D0DaMxaIsjbDS+/
	ST77vTbZAs6AU0xKHbGP67l86UH0bo24notHvZdWcn6CaeEwgZWvwgGdC/IndwWjLcHxVq1xm9n
	BYbQwR1z5iHy7Nf3S48mojJh3tT6CBhnBkSqqwe6NohZcWnByNt
X-Google-Smtp-Source: AGHT+IH7b7LC8Gj4Da9G3lVJLBr0b5tyTNivx9nqJbSGKQjXhyr7EugaEPgGYa4XTpFLOju08KI95A==
X-Received: by 2002:a05:6512:2806:b0:53d:f7f5:bede with SMTP id 2adb3069b0e04-53df7f5bef1mr240716e87.25.1732784516450;
        Thu, 28 Nov 2024 01:01:56 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496864sm115023e87.217.2024.11.28.01.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:01:54 -0800 (PST)
Date: Thu, 28 Nov 2024 11:01:48 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] iio: accel: kx022a: Use cleanup.h helpers
Message-ID: <4785f841ad5f131356ba78b4f3c76f676d86a2e8.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1JT+wUZRDlEyDOCi"
Content-Disposition: inline
In-Reply-To: <cover.1732783834.git.mazziesaccount@gmail.com>


--1JT+wUZRDlEyDOCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A few functions in KX022A need to use mutex for protecting the
enabling/disabling of the measurement while configurations are being
made. Some of the functions can be slightly simplified by using the
__cleanup based scoped mutexes, which allows dropping the goto based
unlocking at error path.

Simplify error paths using guard(mutex).

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
  v2 =3D> v3:
  - patch number changed because patches were dropped.
  v1 =3D> v2:
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes.
---
 drivers/iio/accel/kionix-kx022a.c | 61 ++++++++++++-------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index b6664299e0d5..98953178a580 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -5,6 +5,7 @@
  * ROHM/KIONIX accelerometer driver
  */
=20
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -448,7 +449,7 @@ static void kx022a_reg2scale(unsigned int val, unsigned=
 int *val1,
 	*val2 =3D kx022a_scale_table[val][1];
 }
=20
-static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
+static int __kx022a_turn_on_off(struct kx022a_data *data, bool on)
 {
 	int ret;
=20
@@ -469,7 +470,7 @@ static int kx022a_turn_off_lock(struct kx022a_data *dat=
a)
 	int ret;
=20
 	mutex_lock(&data->mutex);
-	ret =3D kx022a_turn_on_off_unlocked(data, false);
+	ret =3D __kx022a_turn_on_off(data, false);
 	if (ret)
 		mutex_unlock(&data->mutex);
=20
@@ -480,7 +481,7 @@ static int kx022a_turn_on_unlock(struct kx022a_data *da=
ta)
 {
 	int ret;
=20
-	ret =3D kx022a_turn_on_off_unlocked(data, true);
+	ret =3D __kx022a_turn_on_off(data, true);
 	mutex_unlock(&data->mutex);
=20
 	return ret;
@@ -912,18 +913,19 @@ static int kx022a_fifo_disable(struct kx022a_data *da=
ta)
 {
 	int ret =3D 0;
=20
-	ret =3D kx022a_turn_off_lock(data);
+	guard(mutex)(&data->mutex);
+	ret =3D __kx022a_turn_on_off(data, false);
 	if (ret)
 		return ret;
=20
 	ret =3D regmap_clear_bits(data->regmap, data->ien_reg, KX022A_MASK_WMI);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	ret =3D regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
 				KX022A_MASK_BUF_EN);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	data->state &=3D ~KX022A_STATE_FIFO;
=20
@@ -931,12 +933,7 @@ static int kx022a_fifo_disable(struct kx022a_data *dat=
a)
=20
 	kfree(data->fifo_buffer);
=20
-	return kx022a_turn_on_unlock(data);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return __kx022a_turn_on_off(data, true);
 }
=20
 static int kx022a_buffer_predisable(struct iio_dev *idev)
@@ -959,33 +956,29 @@ static int kx022a_fifo_enable(struct kx022a_data *dat=
a)
 	if (!data->fifo_buffer)
 		return -ENOMEM;
=20
-	ret =3D kx022a_turn_off_lock(data);
+	guard(mutex)(&data->mutex);
+	ret =3D __kx022a_turn_on_off(data, false);
 	if (ret)
 		return ret;
=20
 	/* Update watermark to HW */
 	ret =3D kx022a_fifo_set_wmi(data);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	/* Enable buffer */
 	ret =3D regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	data->state |=3D KX022A_STATE_FIFO;
 	ret =3D regmap_set_bits(data->regmap, data->ien_reg,
 			      KX022A_MASK_WMI);
 	if (ret)
-		goto unlock_out;
-
-	return kx022a_turn_on_unlock(data);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
+		return ret;
=20
-	return ret;
+	return __kx022a_turn_on_off(data, true);
 }
=20
 static int kx022a_buffer_postenable(struct iio_dev *idev)
@@ -1053,7 +1046,7 @@ static irqreturn_t kx022a_irq_thread_handler(int irq,=
 void *private)
 	struct kx022a_data *data =3D iio_priv(idev);
 	irqreturn_t ret =3D IRQ_NONE;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
=20
 	if (data->trigger_enabled) {
 		iio_trigger_poll_nested(data->trig);
@@ -1068,8 +1061,6 @@ static irqreturn_t kx022a_irq_thread_handler(int irq,=
 void *private)
 			ret =3D IRQ_HANDLED;
 	}
=20
-	mutex_unlock(&data->mutex);
-
 	return ret;
 }
=20
@@ -1079,32 +1070,26 @@ static int kx022a_trigger_set_state(struct iio_trig=
ger *trig,
 	struct kx022a_data *data =3D iio_trigger_get_drvdata(trig);
 	int ret =3D 0;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
=20
 	if (data->trigger_enabled =3D=3D state)
-		goto unlock_out;
+		return 0;
=20
 	if (data->state & KX022A_STATE_FIFO) {
 		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
-		ret =3D -EBUSY;
-		goto unlock_out;
+		return -EBUSY;
 	}
=20
-	ret =3D kx022a_turn_on_off_unlocked(data, false);
+	ret =3D __kx022a_turn_on_off(data, false);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	data->trigger_enabled =3D state;
 	ret =3D kx022a_set_drdy_irq(data, state);
 	if (ret)
-		goto unlock_out;
-
-	ret =3D kx022a_turn_on_off_unlocked(data, true);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
+		return ret;
=20
-	return ret;
+	return __kx022a_turn_on_off(data, true);
 }
=20
 static const struct iio_trigger_ops kx022a_trigger_ops =3D {
--=20
2.47.0


--1JT+wUZRDlEyDOCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMXwACgkQeFA3/03a
ocUVHAf+Kj0/Z/hKkAjApXBj2VRNZXU5sWAoc3U9ARkMoQt+GgTfX3giOmx7EOwX
hbZKz1V961hf+pX8qSG1y0xEI83EB9I+7drBunw6s1dfWv4ogGE43ckt53lEsOTK
5aC6NlA2nj3KH+KfA7HTaeCrF2WcZdllgj583wrcQbnIIqEXkIuw72sDtGt29/yx
c6Nm+Tn8FVUoumcd56354i/wxvlHTmLzNL6awwPi7h0iZgznrWJI81dyE+aC1HRx
t3suAMDrHqdDy6+V3+7Tj2cGkoXpMfGRn3EAq5U1U9mrfzHdpnYStTKH5yXAb02q
M6yMLD7zqwyhgiGiDAbM9FV8IoZY/Q==
=xqE0
-----END PGP SIGNATURE-----

--1JT+wUZRDlEyDOCi--

