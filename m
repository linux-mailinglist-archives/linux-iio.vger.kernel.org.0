Return-Path: <linux-iio+bounces-12446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F361D9D48AD
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5895DB22EE2
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369611CB303;
	Thu, 21 Nov 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/09NQYZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570B1C9DFE;
	Thu, 21 Nov 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177235; cv=none; b=HVGao6COO9KfeWNzknSPECC47Hs3FSv3AomSnsbHmaDx5o3OxbGQiP0EFErzmtEwCvhhbOzzqUMhnk8AcNt+ohV0lHLyvptzjBBSF/2hEx4Z8Eq9y6uh2nhE/JWYdOQAPMnWf/w2jjAePjljgh5F7AVp3T6zloMVArXUXWk31tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177235; c=relaxed/simple;
	bh=l3uIrlJwPeaICVlO2YsPWovLE+v5JJmIMSKJ/S8b7Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsTUCF7mIOVlk8DGpDLLMBlirsFszFyaqhAAQnS8cAroQrGzj4ASvTolo5uWwLABr/mk198GI5afSHjBaLU2M5VwE+BPAj1zHTJRxVKBI7fwYD5jMz7Nw77ziDH0X1ZNYr3BqCGHe3jUkHSOVht1ZWe7UCJhuguroMh2qq3zpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/09NQYZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so10757271fa.0;
        Thu, 21 Nov 2024 00:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732177231; x=1732782031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz0Yhn/+UnMGTflEuTVJTUtrlxk/nxP7mdwTw0nLivE=;
        b=V/09NQYZrDwYvunyLe044w4wk2pZxIr4N5cruRviUvz7bssxkfw7VcRWpvTKcrdyzY
         08WZFNPsenTCGfYxr6mANN7oVenNUgfvsVEF3r3OMUXnfnQvgnHACdV2JDM+gkKvmxXC
         X7agF/rfdOqKVfEvM2PBDEB3U+y55veKlwh4yrRpqrzu3EgQqeoKvsqa/Sj7Hr6xLAkW
         VIQZSt8sWSw7kTq/+WGmrk5YGZhyI+i9PZiEXW+xKSpMl0HCyyD778qd/lYujgvo3ZbJ
         xlSzTfPfTkaiGBT6mzk+9LFswiSoqYqTBFdxBdvWT1awBUv/GgvL3X+7YOTURiva+iGG
         tqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177231; x=1732782031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz0Yhn/+UnMGTflEuTVJTUtrlxk/nxP7mdwTw0nLivE=;
        b=b46MEi3WOrNwD7uRj8MTzBiaQSz2wU+OLDhEUYzE/j55byx/KoS4thDzRkRThHCwI+
         Zdenwl0ZFUwUh+2rOcQJwvpZBDbRZ9uIbOuxJtbmYA0EJWt1LvQeM6o+0pTsOvrTLmZP
         iaYQl77cdRhwm5JLFrv5upRYAfm6m6jsqQGK113Jv8fO6gsMS+4AK+PYyecTwSJ2g7xE
         /jUcbUfwI4Yvss2wWn0VqgToXkT69CNTy2yZq3Kq5eFwyLK/oS1vA1hX+5BWxMq82ppJ
         DqzSfdhiQivN+x8/aqksDy/1GVc33ZQY1U0fhAATyAuTRu7GbJM9E9aT43HA/dbj4wA6
         NjZg==
X-Forwarded-Encrypted: i=1; AJvYcCU0vwQUflKWaI9n8J6arSc38/qF67aBY7+jkt//T7eMCfhR/wUz6q0rpzkD34/61qk4C2FNCuebA+/JugvY@vger.kernel.org, AJvYcCWX2IDJwZQtn0fXMZmgAtkXsKe0xSKrQKLvcgMudzz0G/9W0E5iVw7P0vHS8a0RA0HvVJ+Z6/g4IqlQ@vger.kernel.org, AJvYcCXmgmGhDEZrRohhrgOs7jr1f09wBKSqSwRQ/1ICJkN6UnT71km0zpEDZO5Ngr/XXG6RcJ+bCFQCmTro@vger.kernel.org
X-Gm-Message-State: AOJu0YwRarilAPsqJpWqra+gYKu44/IJ4fwlwzR26h4r4TYK769yI4fB
	D04+VQ2fCmcywSgU/GI0/laWL0IV6kybel3ioTFWL8sPC11CVyaR
X-Google-Smtp-Source: AGHT+IFpaR7sDe0yFaLb1WGuLhgutz8aqP7RUJtn6zo7QdZbydR9Xl+6qUK6bxp1bl6BkJNClln2pA==
X-Received: by 2002:a2e:bc03:0:b0:2fa:c0c2:d311 with SMTP id 38308e7fff4ca-2ff8db1659bmr44182111fa.5.1732177230827;
        Thu, 21 Nov 2024 00:20:30 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69ae805dsm17951641fa.72.2024.11.21.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:20:28 -0800 (PST)
Date: Thu, 21 Nov 2024 10:20:23 +0200
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
Subject: [PATCH v2 3/8] iio: accel: kx022a: Use cleanup.h helpers
Message-ID: <037985fe50fe79c79b9df95fa7b4e577378f9a60.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ETmBcMDtxDnnN0fd"
Content-Disposition: inline
In-Reply-To: <cover.1732105157.git.mazziesaccount@gmail.com>


--ETmBcMDtxDnnN0fd
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
  v1 =3D> v2:
  - patch number changed because a change was added to the series.
  - rebased on iio/testing to avoid conflicts with queued fixes
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


--ETmBcMDtxDnnN0fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc+7UcACgkQeFA3/03a
ocXJdggAlxyTVzBb3OdGoK9ALyIYhq9ZYjZREXgC6X7gbmIvNWj11mwfywf21aa4
MDZ4jguukTMt8gGaiqLjIAuc3A1mdTaBUw/78izMTx+3PX0MnY1UYzdkXW5LTDeZ
duXteS/oOfzLUg5AKYm5uJg8wQZn4uDLm8RWSxeJkaqJFrCdP6WwXZHGx++dy3gO
pZ1ncu4StKqnU4cl/u77DSgoe+kOMbXMTxcLV4a1nfTiItrMehaNqyDI7L9f+pWR
BtaiQ+D+LCVJzaJQ4sBoQ+NJQwAvKOkTa9LzYcQtTHTVek7Ol4q5LvpPtjLVZelV
dyU1BNjTGXq975JZoHrhEbiqwFomzw==
=NfMh
-----END PGP SIGNATURE-----

--ETmBcMDtxDnnN0fd--

