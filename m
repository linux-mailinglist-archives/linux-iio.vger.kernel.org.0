Return-Path: <linux-iio+bounces-12467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF59D4D73
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 14:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E68B28CC5
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FD1D88D0;
	Thu, 21 Nov 2024 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHhqxPvX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A41D5CE0;
	Thu, 21 Nov 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194329; cv=none; b=fVyGGFTKvk9q7Ynw8S4ZrUDH6tHRwni1NGR5DLxHWpRoRGc8uX0JEzR5v7xeld2Xx99rImh4dAmN/PBHRai3Pzlku7/0pSbgOpy9+N9VfBMMTuBCM6e+ud6uJtNEmFN7AhzQJd0DIIOozMZPbFvQXfnU6IZ9B6zsAv+j87y0KmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194329; c=relaxed/simple;
	bh=eYbCCKYh66osXyNgE2HPw/2SQUZRpEzOFNSlCOyYtvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELvHbVJ6ACFWSRQZQZa/N38+EZ1eQkIqp+00RYkZF6xHWhcxW/8dhgIzrOQfvwCbu5aRekuADRhtAVBBdYFsVbvURziRUkVBVJEihACPrvYEyQPmSbjsfw2xUeUMpVB/4BHRoHsQILcLt4gNPgAjZcSELyavYxM8nTA/ikeS3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHhqxPvX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ff57619835so18095021fa.0;
        Thu, 21 Nov 2024 05:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732194325; x=1732799125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jANKLpJlY3GMOQ9x6c0D0dqa4Rq3jdtrzX/uM5HU2oQ=;
        b=CHhqxPvXoxlt4YX0mKvYRzDdFu8tV9EWCqK2cE95KDZcUVv0Xu3BsYgZqNxST3JBeo
         fy+6UOPG8rpuYujvV6dAMEegRFKuoSeWfrSRnMwGyCbusPy9Vd3+teER3l9reUCvlvLh
         AYd+0jwCY4eWHFMqRu/UpVTZfvE6XREbk/d6bTINHrz9aBIwCi51bZfHbogbtocUIf09
         Ij/+mfe09Se1s0+gSjcENrhX3DPJmHZAKt5S2cLnXhmFQSU7yr6BwFIUsAceCtaAajq/
         499TprW1U9mT/AI6jEBYV67PPvSH4UV0aqUKSK2hZFwV7NnvwBWpD4VB7gNAtlinb7Aj
         EI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732194325; x=1732799125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jANKLpJlY3GMOQ9x6c0D0dqa4Rq3jdtrzX/uM5HU2oQ=;
        b=wIeIa8PhX7w/m+17q4LN0wshNRviSKTq35Sku7U3n3gXNS/nkGSnxyeSMMXDY+uw1b
         5O3ZtslD32FkfAStwhx1yTwSePqT88H1rdxcetGlApDgot568lYELDM1ETmhao0u4Xfn
         bcNvbcG/iKLuRYcDeE53d/eTgizWaS8lxg1uWgqCpX/yRSzyhj87PplH+93aYDLhWmOo
         CkYINucS080O/a8AlKQhNbPvHNajXdnd7CxGqNU0tOmForXcL0XWQNFRIbbYyHzdZAcH
         gIRbYU8p8DQs4SpuhpW5h+kOo2eXfRTSDB0VCAD3Tho4t2KlnKbG/ytqt/hzzt1E9f0Z
         QfWw==
X-Forwarded-Encrypted: i=1; AJvYcCU04oKdGFLJMy686pkVsjl8KgQPMnOSrmp0Wna5qyFvxUHJiMVU4gt4n+jIb2wWmw1JPVslTZwXaD8=@vger.kernel.org, AJvYcCWHZJ5717YzhRx8sev/V1iOSzn1a2d7Am/SJ9wRAQICZgEskUfvum6G8yxvbIPATR0qe3o4yYIH2qdvYOJC@vger.kernel.org
X-Gm-Message-State: AOJu0YypL++OqUZ8YyocsK1eXNdcHbNjlBnrLW4Na5q1bMTESnXoc76N
	bP0FxOYg/OcQG8OC88Y3vlNkWcHCG3b2VgZBGt0B6Ngmpi4ah5qo
X-Gm-Gg: ASbGncuLivbFjfN76kqDtAPxmnH887zCy2myjkPsU54s3OjWSL7433o6wPVJ0oMrYd6
	zHqPzBejCAMBJtcq8FORmp/H70QfqukZpbShXQhIR22/73AINStZ3tEPV3Xd1cxxZa7XMQH+XLm
	JnlsxMRlRE1+K6NWfrKKzQLEu2Su5zU+BDg+ITNP42BGLojBBCOZOlQNXVMDynWfJhB9Cr3ieBQ
	zUv5yRstNrzr8/S5Rt/LXWZU9cb7kSxqQ43m2RZAQRrW8Q8GZfb
X-Google-Smtp-Source: AGHT+IGZiAUkl4yO3pIx19+eJUM3dcBKbvU9yGNh2kLVVy/5YEDbYpECuzbn2LrhBkA9QV393Szetg==
X-Received: by 2002:a05:651c:1582:b0:2ef:28ed:1ff5 with SMTP id 38308e7fff4ca-2ff96a24fdcmr8791591fa.15.1732194325078;
        Thu, 21 Nov 2024 05:05:25 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff698515d0sm19104451fa.19.2024.11.21.05.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 05:05:24 -0800 (PST)
Date: Thu, 21 Nov 2024 15:05:19 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: bu27034: simplify using guard(mutex)
Message-ID: <4e65a4725c211b166906f70fdb5ba90f2af0f570.1732193263.git.mazziesaccount@gmail.com>
References: <cover.1732193263.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ptxAvMg++OCoXv6s"
Content-Disposition: inline
In-Reply-To: <cover.1732193263.git.mazziesaccount@gmail.com>


--ptxAvMg++OCoXv6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The BU27034 uses mutex for protecting the gain / time / scale changes.
The clean-up for a few of the functions can be slightly simplified by
removing the goto-based error handling/unlocking and by utilizing the
guard(mutex) scoped mutex handling instead.

Simplify driver by using the scoped mutexes.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/light/rohm-bu27034.c | 73 +++++++++++---------------------
 1 file changed, 25 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 76711c3cdf7c..d2ed92d5ec92 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -7,6 +7,7 @@
=20
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
@@ -395,30 +396,26 @@ static int bu27034_try_set_int_time(struct bu27034_da=
ta *data, int time_us)
 	int numg =3D ARRAY_SIZE(gains);
 	int ret, int_time_old, i;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret =3D bu27034_get_int_time(data);
 	if (ret < 0)
-		goto unlock_out;
+		return ret;
=20
 	int_time_old =3D ret;
=20
 	if (!iio_gts_valid_time(&data->gts, time_us)) {
 		dev_err(data->dev, "Unsupported integration time %u\n",
 			time_us);
-		ret =3D -EINVAL;
-
-		goto unlock_out;
+		return -EINVAL;
 	}
=20
-	if (time_us =3D=3D int_time_old) {
-		ret =3D 0;
-		goto unlock_out;
-	}
+	if (time_us =3D=3D int_time_old)
+		return 0;
=20
 	for (i =3D 0; i < numg; i++) {
 		ret =3D bu27034_get_gain(data, gains[i].chan, &gains[i].old_gain);
 		if (ret)
-			goto unlock_out;
+			return 0;
=20
 		ret =3D iio_gts_find_new_gain_by_old_gain_time(&data->gts,
 							     gains[i].old_gain,
@@ -434,7 +431,7 @@ static int bu27034_try_set_int_time(struct bu27034_data=
 *data, int time_us)
 				gains[i].chan, time_us, scale1, scale2);
=20
 			if (gains[i].new_gain < 0)
-				goto unlock_out;
+				return ret;
=20
 			/*
 			 * If caller requests for integration time change and we
@@ -455,7 +452,7 @@ static int bu27034_try_set_int_time(struct bu27034_data=
 *data, int time_us)
 					 "Total gain increase. Risk of saturation");
 				ret =3D iio_gts_get_min_gain(&data->gts);
 				if (ret < 0)
-					goto unlock_out;
+					return ret;
 			}
 			dev_dbg(data->dev, "chan %u scale changed\n",
 				 gains[i].chan);
@@ -468,15 +465,10 @@ static int bu27034_try_set_int_time(struct bu27034_da=
ta *data, int time_us)
 	for (i =3D 0; i < numg; i++) {
 		ret =3D bu27034_set_gain(data, gains[i].chan, gains[i].new_gain);
 		if (ret)
-			goto unlock_out;
+			return ret;
 	}
=20
-	ret =3D bu27034_set_int_time(data, time_us);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return bu27034_set_int_time(data, time_us);
 }
=20
 static int bu27034_set_scale(struct bu27034_data *data, int chan,
@@ -492,10 +484,10 @@ static int bu27034_set_scale(struct bu27034_data *dat=
a, int chan,
 		return -EINVAL;
 	}
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL1, &time_sel);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
 						val, val2, &gain_sel);
@@ -518,7 +510,7 @@ static int bu27034_set_scale(struct bu27034_data *data,=
 int chan,
=20
 		ret =3D bu27034_get_gain(data, gain.chan, &gain.old_gain);
 		if (ret)
-			goto unlock_out;
+			return ret;
=20
 		/*
 		 * Iterate through all the times to see if we find one which
@@ -551,26 +543,20 @@ static int bu27034_set_scale(struct bu27034_data *dat=
a, int chan,
 		if (!found) {
 			dev_dbg(data->dev,
 				"Can't set scale maintaining other channel\n");
-			ret =3D -EINVAL;
-
-			goto unlock_out;
+			return -EINVAL;
 		}
=20
 		ret =3D bu27034_set_gain(data, gain.chan, gain.new_gain);
 		if (ret)
-			goto unlock_out;
+			return ret;
=20
 		ret =3D regmap_update_bits(data->regmap, BU27034_REG_MODE_CONTROL1,
 				  BU27034_MASK_MEAS_MODE, new_time_sel);
 		if (ret)
-			goto unlock_out;
+			return ret;
 	}
=20
-	ret =3D bu27034_write_gain_sel(data, chan, gain_sel);
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return bu27034_write_gain_sel(data, chan, gain_sel);
 }
=20
 /*
@@ -1221,42 +1207,33 @@ static int bu27034_buffer_enable(struct iio_dev *id=
ev)
 	struct task_struct *task;
 	int ret;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret =3D bu27034_meas_set(data, true);
 	if (ret)
-		goto unlock_out;
+		return ret;
=20
 	task =3D kthread_run(bu27034_buffer_thread, idev,
 				 "bu27034-buffering-%u",
 				 iio_device_id(idev));
-	if (IS_ERR(task)) {
-		ret =3D PTR_ERR(task);
-		goto unlock_out;
-	}
+	if (IS_ERR(task))
+		return PTR_ERR(task);
=20
 	data->task =3D task;
=20
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return 0;
 }
=20
 static int bu27034_buffer_disable(struct iio_dev *idev)
 {
 	struct bu27034_data *data =3D iio_priv(idev);
-	int ret;
=20
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	if (data->task) {
 		kthread_stop(data->task);
 		data->task =3D NULL;
 	}
=20
-	ret =3D bu27034_meas_set(data, false);
-	mutex_unlock(&data->mutex);
-
-	return ret;
+	return bu27034_meas_set(data, false);
 }
=20
 static const struct iio_buffer_setup_ops bu27034_buffer_ops =3D {
--=20
2.47.0


--ptxAvMg++OCoXv6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc/MA8ACgkQeFA3/03a
ocUkXQf+OkMvpzSaDdegLQ6EZwuJ68qRT8JnDjEv9LcWYMaEl9uRbosRIyTr4XzF
HLDJUhOV32U6eN0EDDbI9XiF3/oJtEnQUWnYPg4kGhPH4gjwnSzwJszheRroXWnc
Qenhv+cSl1p1dxCdfyp8gFu5ejH/TolPkAK0n7xL4YOYxbNFV7kq3OT4vrUdGRWm
hz4XX+VqfqxsnMqUNlu/DnOypceCXB3ouCGaARQo9ETPKHVEhT27VbfwCDUcRSY8
ETguGadKRfudFngoHYyJqSD2L17pgmcUbgInB4ekRROrgtcCf1PlqQihctx/4nhK
eF7nvairXRoh50CUpQCW8EPk6weRpw==
=CN4P
-----END PGP SIGNATURE-----

--ptxAvMg++OCoXv6s--

