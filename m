Return-Path: <linux-iio+bounces-12197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE229C6DB2
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 12:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19CB71F2190A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236491FA279;
	Wed, 13 Nov 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM1JRGqO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F171200B8F;
	Wed, 13 Nov 2024 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496817; cv=none; b=qmQgkvNQYJ6te9dtSP2xiUe0YJK06kab177WqO3INj0peDq/K2UwbIKyLCh4RpdXCGzadXMMtO9qtKYCCmSOdWDMj1fHx+d9tN+VdgzKXXTOdDvx6SbtW9VUpfE9OWLKgMwaadV1Qbu0Pf1S+KY6cY/BLSxdlxFZ/S276a8Qj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496817; c=relaxed/simple;
	bh=os6NKRV3DiBYSPOB+jwd9UanJgfU0jAP2AO4Z1GIi2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhWdQBSG49ZaiF2paAPgWdbbDJ9PN3R4tO75Rh9xKSAvzDDGbiZ5mQBUiiuODWucyr5CHvjgtcFZlijMuCwwgzTtedwkn7NKUDtB4T2oJvfuTDvYXHmj18NNXpGSMgg8gvpyuHyAzZYfZDdNKl7TEf5i+9XnrubQGNIZN1I/LHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM1JRGqO; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso6709441fa.0;
        Wed, 13 Nov 2024 03:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731496814; x=1732101614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hbj9OsuVyivUpj0F9cGsgeSME0OksJ9+laGHOnSVXE=;
        b=GM1JRGqO4uKE1wmXGsOrn8O4nYnyAtHRAOAdpzCTvi5Zn9ado4u89eC5vXHl+5NVDX
         yE+UoKdcH21gfqSrNTx+Sy0Z5eLHSssSAPIScjZlpXpIIOtZljcA5lPzmyfsnOq8zBLx
         sgoFouzHi7XMgQ/Wxcjg3ZzbDhSYTtEq9C2jgXASiJRupBdfjUJ0wtV08u5qA8oPnA5M
         jfF6nlHHl9WmlKtqcQ0EyqED7IA5Z1lzg4TOFeg6KNH1CrbyvoF8RbNyatsLrZnll+Wu
         NNSerlGiIkEoim13M0kty3KCqudOeafx+wvLlh8VRZ9tsZqgQSfhV1SsX3UukHzMG9sY
         LjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496814; x=1732101614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hbj9OsuVyivUpj0F9cGsgeSME0OksJ9+laGHOnSVXE=;
        b=VhgXREUFYUAZ3LqYjAYliX4AEFBi6mt07kKEYnZJtNPnt5G7PgcaMONfEgzM/SJqx0
         JK11J7wO7opeB4623rieDx8A+3mmxFkEIRBYyw+GIG84tw40ocbxZcvg/ZTuiWcMznlA
         s0xpUH9PjWIt3MZ/3qf739vD2fNjN0jArp6rrNB/+k2EWmM7Us+L2DF3Utf1w5Vf7cFt
         AsdoQSQG/wIiSAvTd+dt7cvFk5hZmB67fHqr0xpzWg3ob5rCBVisOk3Ir1NBFooJMXeW
         WwkGSsMrmoeEtIiXEUc8rSB39MRMDXuwkQYah0an5XfrhN8vRzJvCRPP81EiJ6rAmFKr
         Rx/A==
X-Forwarded-Encrypted: i=1; AJvYcCUkhh38Wf0uc1AjVD3+/IoQzRGjXENa+CJcqE1IgM9lhkgf5vHtYIpLjKV7GLmnvfoasn9d9kezrK0l@vger.kernel.org, AJvYcCVwfpVXzxGth9f3V4VO9w074SrT6Lb5mGKTN72dFxZ5RmjSVi50AWQr6GfAndWxdQciJHrDQCjLfosl@vger.kernel.org, AJvYcCWKmxCkwgR3bCyfkur+D+BqkaKwzSiQMWiDLVXz7KhiZvlLuViHRpQRorUMS0k1xcefMo+lYhy1rFsa1pVM@vger.kernel.org
X-Gm-Message-State: AOJu0YwTsU5dVvm+EOMioiDxOzmb0CY9zGRAwKObe9A4shz1tw21jJ4w
	qah6eTbpKMwmxvpa6mnp4DKfuOZjWpRLHEK22fijN76Ocz+Dh0JR
X-Google-Smtp-Source: AGHT+IHXn4iXxA2U9pThQOnrrgVLz1QpNkFzGPtAT6wxdiOH2IWX7M5CPlQrdjoqW45JdSEFgXqZ+Q==
X-Received: by 2002:a2e:9ac7:0:b0:2fb:5bd1:c293 with SMTP id 38308e7fff4ca-2ff209f4d0amr50833241fa.21.1731496813985;
        Wed, 13 Nov 2024 03:20:13 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d4aa8sm23347541fa.97.2024.11.13.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:20:13 -0800 (PST)
Date: Wed, 13 Nov 2024 13:20:04 +0200
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
Subject: [PATCH 2/5] iio: accel: kx022a: Use cleanup.h helpers
Message-ID: <dce7c964f867dfeda8a7930c0144a10391fb1137.1731495937.git.mazziesaccount@gmail.com>
References: <cover.1731495937.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GjcGCwYhJDEM8ck9"
Content-Disposition: inline
In-Reply-To: <cover.1731495937.git.mazziesaccount@gmail.com>


--GjcGCwYhJDEM8ck9
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
 drivers/iio/accel/kionix-kx022a.c | 61 ++++++++++++-------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 32387819995d..321bb2c35578 100644
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


--GjcGCwYhJDEM8ck9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc0i2QACgkQeFA3/03a
ocWwyQf/behc86Myl17GhICK8oxGH3Fe5JrJKgxlv/mjLimNAX0vVYrGH2SInLds
nuUfr+CTR7kX9gLIPdpb5P6reSKGphrTPTdcfxK6PH7cBV499B6TW6/oq9bW1J+b
QYpYyDpRfteSifcVFL0mu/U5mLP3eGJukL2aqL89K1cg13qmCAb5zdmi9ryogivg
bnxA3Ts5uH73Ekxghvqux5zmkQXe4B4cJsWGEEuGbkDD3oNXNgTz/KBJbWwNbRpL
FlLqIEi0/VX7/dl+h8LLRRTjEQN/YWOfrUU6xcc5WHJujZ/Z4I99rriekghD6mW0
bHzM0yhdSfdVW3Z7qpxk8Lxi5x1X4Q==
=AG+k
-----END PGP SIGNATURE-----

--GjcGCwYhJDEM8ck9--

