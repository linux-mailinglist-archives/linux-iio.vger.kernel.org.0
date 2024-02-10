Return-Path: <linux-iio+bounces-2393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4628506DF
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 23:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF8B22D69
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E738DD8;
	Sat, 10 Feb 2024 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEwMTQAD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E6273FE
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707604378; cv=none; b=QXQedVkVAuvktQTjIT8T1GtTYdXooK13njqwdFB/3NL2IcuiEOhY0UHEtz3+i0Qv7EMkjLyte79T+SvDnO6N26zSyVPg/u2uIV55v99E77UZsFQsU1gW8QUkJZunTuXVu0v+AkGgg1EKMoa6m8DFsm7xxqZp0ZZ+wDOudZBeq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707604378; c=relaxed/simple;
	bh=XCMMUtEP0qoZGQNm+tmc/Yrk1tBwlxICwBuBRaX8lAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez5/OTDrN+X9aPD2gi58p5jXGJwxThND769/Ckau+7YrrCQcMQTlv+10LPd2VsqBzX1YSqaA+pAihTnDQJrLlL0gdlHADvnHZUHtLU74pqQWjYw4ShmqrLi2VhsyLOtQ8tLy+qf7jH5V5rZvqoCUQHZd3fx1Ad6SQ+TtzOihWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEwMTQAD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1555118a12.2
        for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 14:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707604376; x=1708209176; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4cSOW6Z6FCwu7XYfNpNmZ11NEw6PaBdEMHvX/eigx4=;
        b=SEwMTQADwKLHPJX8th4Eg25osGd/WiWnIBX+hwnBr0AhjJ2eqDjbia2yFjMwWWRg6c
         XTiIzgzrGK2QI8e+yVG7OsqIQ7WGd64mFcVMjyilUQDRpa9jH5As0zNplgb0HfSRq0t8
         t0wpJlIfYpv2HKwzDK1i+g60K2FhbYSjmi4z1j6/k+dqrYnoLQu2uf4H2H1n+Uqf+5Jb
         RdRufYRDXYkKrGw3OHhCDgv4JOjlE6MitftYjsjR5KcKDjtFzsd9VzqmmB6M7b1AZdg3
         cEJ/PyX93OazxFGW0nbvy5iQ15tgVCaoIrhwb9dpk5+0EfYk2x4lg+izQO7iv2AGc2Pn
         ULWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707604376; x=1708209176;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4cSOW6Z6FCwu7XYfNpNmZ11NEw6PaBdEMHvX/eigx4=;
        b=bFO4fDgJDbuSeE16+IyjYhegcLaFJnpAOvEHM8AhqGvij3DkhO8EfKDDMOyMH3GL81
         ArqS0tiMNJ7V+HZa7ynSLhFA8BuY5oAGzPxBzRDMLNoK5NqvWJQLRZ/81hDbv9oMihnu
         EtJMBcBX8hRA3R5po0i4U/GC1n9SXfcfrVtgFzSrHr/VyNxo4I5lxDpbLPYjsTNTllyq
         IREmYqrw18MZj4n1M6kKFMZPqxNk8syUi0AnIxceudEo6p/qq2oetW/6oYkEoK3mrX1y
         7CkQnJiMwJyN5dA8f3CcaNYJNhN06Bg8p+SoSSAJwoO+guN0/N0EV+LzZkJ8cCWUA4HY
         Oxvw==
X-Gm-Message-State: AOJu0YwilXOMHz0dO3kcAwT/oBGnABJ3bp6cnljman0LAuNA+LfaBpZc
	IpDUCPZTa5gbyqLw8rF2yIpbhUcgdQEKtt/0e2yUS3cPIv5TNUhc
X-Google-Smtp-Source: AGHT+IH4rPGGCQj61wTtJ2ilvCFmuVySM7tYZBYyVSkFzqOruqBjuFQf2Bv8At4JVJVqi9nrrMG4Cw==
X-Received: by 2002:a05:6a21:1743:b0:19e:ca72:9420 with SMTP id nw3-20020a056a21174300b0019eca729420mr830841pzb.57.1707604376161;
        Sat, 10 Feb 2024 14:32:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6ph78zalhYgl0CO5WNcqXUzQp82FFf1UtGYSyG/EFnObnrMquMz7OwWvDJOKipW6EBx2MABYk44cNYbEj1YwZbbV1eA4HLkvmM+amLwGpiJBk+PVm1tsxmszE3b56xffuPeTGhAtGjA7d396/VaZKgzOyyZTkuoPvw1wUa5QZTBBj+jMmscuUSi4+MBnZ1Dk+FzIs7uIlELclI4Dl7hH8ww==
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id r18-20020a62e412000000b006e0503f467bsm2805302pfh.39.2024.02.10.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 14:32:55 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 lkml@antheas.dev
Subject: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading
Date: Sat, 10 Feb 2024 14:32:54 -0800
Message-ID: <12437546.O9o76ZdvQC@nobara-ally-pc>
In-Reply-To: <4923946.31r3eYUQgx@nobara-ally-pc>
References:
 <5769241.DvuYhMxLoT@nobara-ally-pc> <20240210164956.3d29e3ee@jic23-huawei>
 <4923946.31r3eYUQgx@nobara-ally-pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5813111.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5813111.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading
Date: Sat, 10 Feb 2024 14:32:54 -0800
Message-ID: <12437546.O9o76ZdvQC@nobara-ally-pc>
In-Reply-To: <4923946.31r3eYUQgx@nobara-ally-pc>
MIME-Version: 1.0

From 0aed4d398be185d43b92db63693bb1c5c6a8a78b Mon Sep 17 00:00:00 2001
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Sat, 10 Feb 2024 12:28:35 -0800
Subject: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading

This portion of the patch series aborts the loading of the bmc150 driver
upon DMI board match for ASUS ROG ALLY and Ayaneo Air Plus (requested by
ChimeraOS dev).

Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/iio/accel/bmc150-accel-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 110591804b4c..576da9def8eb 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/of_irq.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
@@ -1670,6 +1671,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	struct iio_dev *indio_dev;
 	int ret;
 
+	if (dmi_match(DMI_BOARD_NAME, "RC71L") || (dmi_match(DMI_BOARD_NAME, "AB05-AMD") && dmi_match(DMI_PRODUCT_NAME, "AIR Plus")))
+		return -ENODEV; // Abort loading bmc150 for ASUS ROG ALLY, Ayaneo Air Plus
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.43.0

--nextPart5813111.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXH+ZYACgkQ4obKiQwb
1x0pGAf9FcOZg+eIGYPRgCMXS9kIgJEMAE3G4gpEd+mvoDKxbQoF6bVrZauXd6gB
/7I3TNfftI6CnWPIrO76QHhJemHju0vr+KO0LXmBllvAneGIB1FJyc7j7NgeEml3
K29jmEP6yXUyJPkYCNR16BndE+U0UiN/SE8kDcSYzPDKO9Pni/XK5nbIXt5onRH8
2CldtK/jvQT1hjy7Sl6a473OCUzB41DLveDgPp9ET+5rpmVhsfbrgupY0c2WwVzp
hfNeYyEcEnHmRZCbbSNnptYFk/z8Tun9eBm27WAopvCj35wXMIKRmTl0BvGtNDyp
aBD/eCEdz5UUH30+VTzdQEYUbU7JcQ==
=4Hrk
-----END PGP SIGNATURE-----

--nextPart5813111.DvuYhMxLoT--




