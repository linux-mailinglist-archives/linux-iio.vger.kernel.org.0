Return-Path: <linux-iio+bounces-12772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE19DB486
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B190280F44
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771011547E4;
	Thu, 28 Nov 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fascyJ+A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD8143C5D;
	Thu, 28 Nov 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784632; cv=none; b=mJnfa9TP64TcpwOZz4xkf1KHkfRoZNAvTd7xl0AorxFZFxb/I9GUMAMbx3slz0FNFAXQe1qPeSS1EeXPyFr8RIEWApvNbhjQ/iAWrhbzFhi2lR3znVRLO9qnmWb0DsyxbN7Dpbk0TOrhJDOfSBlIPtd4x5LgDAw23O6xlROoZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784632; c=relaxed/simple;
	bh=IaKwCAviFT17kCDoPb1NhuAN6iU0GIhtG2w1ksZ6gnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVS7Eqoa4oMyh0lVCnRPVzft8maOVQERmDm7ApOHOX/PHslX9d1smzeIvIYDIbS5ZEkj+bE+L2piyaDDfjMRPpWhih5a5xMkDZ9OBknSuHu4eEtgfxGqIwLkQ6t2kRg2D92b5tEU+nX95hddDEBiyVFAx780RdLzUn2uyOheIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fascyJ+A; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffa974b2b0so6001541fa.3;
        Thu, 28 Nov 2024 01:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732784628; x=1733389428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfeu9TZePGwuuY0/7mH2oC/puuOE3ENCwSxH44663Nk=;
        b=fascyJ+AeG9/iFeXcAl46evg0kuBPJertPR7MNR3FneGMKKlsXpUB8S6Mw8GLsPwvh
         R390U2w8BLdq67bmrL46ISvoQlPZHtrEgj/rhWKd2ujO4FRY4TUGDDzUFReyhpLiJRLT
         Q/kc7c5xryzFsdJ417Pynj7UhxEpK7YjjVyQ9txhP7TTdHmdjN5ip34deHtEOfztKhZS
         z9QoeD+Rvxt8xGKm/Qc28x/tzz1wUXCTs+/dYMILZyxu7LWwnsSKjY63EwFT8a872cqh
         B5zDaDOOpZWRxQDiyJXwUt7/LnPbkBbOTPq7Z0RPon7DNTwOAT40XzH+BgrQVe5pEhYt
         dOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784628; x=1733389428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xfeu9TZePGwuuY0/7mH2oC/puuOE3ENCwSxH44663Nk=;
        b=qBgXU7St82RJWjAZEgMNPkMnx46R7vj/C4Lf/yyhtvYk19XSxmNuKwfWXU/G4Oanq1
         tF8UW/hPU+qW6HUd6ynSP5HJF5d4vmzs1N08K9r/PJjGdrDT9L2RF7AoQArVnWCap+j4
         UOJIXb+pQCy6BGsdhyqfxn4lfMt3WvzPcRMiW4NcgmEoRLpEpzI/jNJhiFyzsP9B6ON7
         39LLV9Eygu1swCWfEakOnYm1kh4/bpvGyor9wJkY+ua0LXytUrxBjgBnBgDJzlu8k1iD
         kriQoSSyIalPqD0YxakxFbm4quDoZw2o6oLsqNXUy24QvN1JGftZvV/F03GXfGtxn/EM
         gnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpfuJvspSk26R/YKSFCxlR6HK1soa1amW2kUcWrppwoXb8mEbNcTI3cCSe1WVmHdlA/gpODX9/aify+S+F@vger.kernel.org, AJvYcCVSjAgJJujrnxXVH8CpPgSx7mh3A9EShkN2WwIOJrlcD/Fb0Ua+CTDYs/VPLuA1AWH5ecLnCRRcnE56@vger.kernel.org, AJvYcCX4oJKtZ4P+SIWOnxQlz8D8mDo+4kG/hf0zt3wXdiBzjo1OLABjID6nSOIYw/qPBBtJz6vxwOYI2Rzi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00OUWz6tdIL4V48nsl5OOkQbWzJkhhFAIIL/mVlue3uEaYVG9
	luu8G3PPvULOTasTVxI/qoNpGU0T6bCgKMpv59ldMuw/Llal33NE
X-Gm-Gg: ASbGncu27h2+HT52vPfH13AvGKiV1gdm+mMQQWvsHZNgnwI3G/+fCWIdIGsKBHKVhkL
	eLy0fO7rdXVU9V/y37Io76uIymu4ppmuH1w8M69LHKPpZ0bgpYuzjVNsA1fTey/Rp50g3d9yy7H
	X/N7MlX+7ONoO0f2Sakq7YVj+CXWtBDYCs+0IDiz/XaYntrmetUWW241XgHqFLDF4O7j3jFUllq
	QlIAzOfqOQxbTfZKbFbJ8YVZfhSrMJsSEV6aAC/tA/PdrU7PslF
X-Google-Smtp-Source: AGHT+IHCL14oIGUcWNrPBgY/h8Q75ld14hsP3N5seAHgRcLOoorWjcaDTqttv4CePWd0hEPyyQ7Cig==
X-Received: by 2002:a2e:bccd:0:b0:2ff:c69c:db0f with SMTP id 38308e7fff4ca-2ffd6130ae4mr37338731fa.34.1732784627759;
        Thu, 28 Nov 2024 01:03:47 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc747eesm1337841fa.76.2024.11.28.01.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:03:45 -0800 (PST)
Date: Thu, 28 Nov 2024 11:03:40 +0200
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
Subject: [PATCH v3 7/7] iio: accel: kx022a: align with subsystem way
Message-ID: <9b63813ecf10b1cd0126cb950bc09514c4287b9a.1732783834.git.mazziesaccount@gmail.com>
References: <cover.1732783834.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xbeDSoFrdAaX43cA"
Content-Disposition: inline
In-Reply-To: <cover.1732783834.git.mazziesaccount@gmail.com>


--xbeDSoFrdAaX43cA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Many of the Kionix/ROHM accelerometers have a "PC1 - bit" which enables
the accelerometer. While a sensor configuration like ODR, g-range, FIFO
status etc. are changed, the PC1 bit must be cleared (sensor must be
disabled). (See the description for different CNTL registers [1])

In order to ensure this the kx022a driver uses a mutex, which is locked
when the PC1 bit is cleared, and held for the duration of the
configuration, and released after PC1 bit is set again (enabling the
sensor).

The locking and PC1 bit toggling was implemented using functions:
kx022a_turn_off_lock() and kx022a_turn_on_unlock().

Based on a discussions [2], the IIO subsystem prefers open-coding the
locking with scoped_guard() over these functions.

Drop the kx022a_turn_off_lock() and kx022a_turn_on_unlock() and use
scoped_guard() instead.

[1]: https://fscdn.rohm.com/kionix/en/datasheet/kx022acr-z-e.pdf
[2]: https://lore.kernel.org/all/20241126175550.4a8bedf3@jic23-huawei/

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v2 =3D> v3:
 - New patch

NOTE: This patch uses the if_not_cond_guard() which is currently missing
the iio_testing.
https://lore.kernel.org/all/20241001-cleanup-if_not_cond_guard-v1-1-7753810=
b0f7a@baylibre.com/T/#m69982b23da9f71e72d84855b34e9b142cb3a1920
---
 drivers/iio/accel/kionix-kx022a.c | 121 ++++++++++++------------------
 1 file changed, 48 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index e3986dd65337..a34cf8da2860 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -458,7 +458,7 @@ static void kx022a_reg2scale(struct kx022a_data *data, =
unsigned int val,
 	*val2 =3D data->chip_info->scale_table[val][1];
 }
=20
-static int __kx022a_turn_on_off(struct kx022a_data *data, bool on)
+static int kx022a_turn_on_off(struct kx022a_data *data, bool on)
 {
 	int ret;
=20
@@ -474,28 +474,6 @@ static int __kx022a_turn_on_off(struct kx022a_data *da=
ta, bool on)
 	return ret;
 }
=20
-static int kx022a_turn_off_lock(struct kx022a_data *data)
-{
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret =3D __kx022a_turn_on_off(data, false);
-	if (ret)
-		mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static int kx022a_turn_on_unlock(struct kx022a_data *data)
-{
-	int ret;
-
-	ret =3D __kx022a_turn_on_off(data, true);
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
 static int kx022a_write_raw_get_fmt(struct iio_dev *idev,
 				    struct iio_chan_spec const *chan,
 				    long mask)
@@ -526,9 +504,8 @@ static int kx022a_write_raw(struct iio_dev *idev,
 	 * issues if users trust the watermark to be reached within known
 	 * time-limit).
 	 */
-	ret =3D iio_device_claim_direct_mode(idev);
-	if (ret)
-		return ret;
+	if_not_cond_guard(iio_claim_direct_try, idev)
+		return -EBUSY;
=20
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -538,20 +515,20 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			if (val =3D=3D kx022a_accel_samp_freq_table[n][0] &&
 			    val2 =3D=3D kx022a_accel_samp_freq_table[n][1])
 				break;
-		if (n < 0) {
-			ret =3D -EINVAL;
-			goto unlock_out;
-		}
-		ret =3D kx022a_turn_off_lock(data);
-		if (ret)
-			break;
+		if (n < 0)
+			return -EINVAL;
=20
-		ret =3D regmap_update_bits(data->regmap,
-					 data->chip_info->odcntl,
-					 KX022A_MASK_ODR, n);
-		data->odr_ns =3D kx022a_odrs[n];
-		kx022a_turn_on_unlock(data);
-		break;
+		scoped_guard(mutex, &data->mutex) {
+			ret =3D kx022a_turn_on_off(data, false);
+			if (ret)
+				return ret;
+
+			ret =3D regmap_update_bits(data->regmap,
+						 data->chip_info->odcntl,
+						 KX022A_MASK_ODR, n);
+			data->odr_ns =3D kx022a_odrs[n];
+			return kx022a_turn_on_off(data, true);
+		}
 	case IIO_CHAN_INFO_SCALE:
 		n =3D data->chip_info->scale_table_size / 2;
=20
@@ -559,29 +536,27 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			if (val =3D=3D data->chip_info->scale_table[n][0] &&
 			    val2 =3D=3D data->chip_info->scale_table[n][1])
 				break;
-		if (n < 0) {
-			ret =3D -EINVAL;
-			goto unlock_out;
-		}
+		if (n < 0)
+			return -EINVAL;
=20
-		ret =3D kx022a_turn_off_lock(data);
-		if (ret)
-			break;
+		scoped_guard(mutex, &data->mutex) {
+			ret =3D kx022a_turn_on_off(data, false);
+			if (ret)
+				return ret;
=20
-		ret =3D regmap_update_bits(data->regmap, data->chip_info->cntl,
-					 KX022A_MASK_GSEL,
-					 n << KX022A_GSEL_SHIFT);
-		kx022a_turn_on_unlock(data);
-		break;
+			ret =3D regmap_update_bits(data->regmap,
+						 data->chip_info->cntl,
+						 KX022A_MASK_GSEL,
+						 n << KX022A_GSEL_SHIFT);
+			kx022a_turn_on_off(data, true);
+
+			return ret;
+		}
 	default:
-		ret =3D -EINVAL;
 		break;
 	}
=20
-unlock_out:
-	iio_device_release_direct_mode(idev);
-
-	return ret;
+	return -EINVAL;
 }
=20
 static int kx022a_fifo_set_wmi(struct kx022a_data *data)
@@ -923,7 +898,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
 	int ret =3D 0;
=20
 	guard(mutex)(&data->mutex);
-	ret =3D __kx022a_turn_on_off(data, false);
+	ret =3D kx022a_turn_on_off(data, false);
 	if (ret)
 		return ret;
=20
@@ -942,7 +917,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
=20
 	kfree(data->fifo_buffer);
=20
-	return __kx022a_turn_on_off(data, true);
+	return kx022a_turn_on_off(data, true);
 }
=20
 static int kx022a_buffer_predisable(struct iio_dev *idev)
@@ -966,7 +941,7 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 		return -ENOMEM;
=20
 	guard(mutex)(&data->mutex);
-	ret =3D __kx022a_turn_on_off(data, false);
+	ret =3D kx022a_turn_on_off(data, false);
 	if (ret)
 		return ret;
=20
@@ -987,7 +962,7 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 	if (ret)
 		return ret;
=20
-	return __kx022a_turn_on_off(data, true);
+	return kx022a_turn_on_off(data, true);
 }
=20
 static int kx022a_buffer_postenable(struct iio_dev *idev)
@@ -1089,7 +1064,7 @@ static int kx022a_trigger_set_state(struct iio_trigge=
r *trig,
 		return -EBUSY;
 	}
=20
-	ret =3D __kx022a_turn_on_off(data, false);
+	ret =3D kx022a_turn_on_off(data, false);
 	if (ret)
 		return ret;
=20
@@ -1098,7 +1073,7 @@ static int kx022a_trigger_set_state(struct iio_trigge=
r *trig,
 	if (ret)
 		return ret;
=20
-	return __kx022a_turn_on_off(data, true);
+	return kx022a_turn_on_off(data, true);
 }
=20
 static const struct iio_trigger_ops kx022a_trigger_ops =3D {
@@ -1379,19 +1354,19 @@ int kx022a_probe_internal(struct device *dev, const=
 struct kx022a_chip_info *chi
 		return ret;
=20
 	/* The sensor must be turned off for configuration */
-	ret =3D kx022a_turn_off_lock(data);
-	if (ret)
-		return ret;
+	scoped_guard(mutex, &data->mutex) {
+		ret =3D kx022a_turn_on_off(data, false);
+		if (ret)
+			return ret;
=20
-	ret =3D kx022a_chip_init(data);
-	if (ret) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+		ret =3D kx022a_chip_init(data);
+		if (ret)
+			return ret;
=20
-	ret =3D kx022a_turn_on_unlock(data);
-	if (ret)
-		return ret;
+		ret =3D kx022a_turn_on_off(data, true);
+		if (ret)
+			return ret;
+	}
=20
 	ret =3D devm_iio_triggered_buffer_setup_ext(dev, idev,
 						  &iio_pollfunc_store_time,
--=20
2.47.0


--xbeDSoFrdAaX43cA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIMesACgkQeFA3/03a
ocUXnggAj7Q9qgd5UwQSHMRq+2/JMu7XchuEp1RKTly1DPTYI4tzvtYXSISAYmeL
I/A0HVWrDifR25o22Ep6FWZWJ5T/yPZnWQWec3hmeaB85GvL/7mAaKs5mqDI3HCJ
0vHhgn6yXGrZbrj6czgB9tRj8dIRqWs5oggJhcnuNceSl+23GeBtqEE59hnUck+Z
R88EzapfKuHMfwW52rKPPJ+jnS6k1lH7YzJnp79hbeIcnacLHMu+nGCCNO+MJjAQ
LDQPMn3U2GjQCk1PiMdPj1OiuWACm2tEdYMJYEryA7acuuYPStcrms1dDdrsJXXq
OAfLrqYSVryCJ24gmo/PXt4aB98QHQ==
=sGq3
-----END PGP SIGNATURE-----

--xbeDSoFrdAaX43cA--

