Return-Path: <linux-iio+bounces-2394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBF8506E0
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 23:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B6A1C219F9
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 22:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFDB5C022;
	Sat, 10 Feb 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlg8JYr/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6AB3BB3E
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707604455; cv=none; b=kTc0sP0glr8OnSKVt/6S/gWc4DBzOhw2AE3SJmEpzXIJDrtdT3WarEnIsuOiuykV3NFLgzaX0/czVxvf8OZP9RjVKGLmrZrFoum2Z+0BylV6n2W1ODaBN2O+LRiMpexs3rVhDxdam4GJFcLEp9A7mTFo+t4mIDgM3ilQFqWHxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707604455; c=relaxed/simple;
	bh=2f8dPjBI/ZY7dCSAHUaCNnCtp7nkd9t3gmCOYWwsULk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlNxH5jpuZkpx84X7FYNc9q4HH7s+7GTZt0GOHP/Q7qP/i5QIUzd6USYNHueHvxrDgVfrCUbQPWMkl9PIfWHo4aFlT/l6SyGSmLCiP3zdwgsFWBkWbhzAESMe2cbvazjhUfPRdbxxwunFr6NrEEfGvpRadr4bb0kMIeGixmEPTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlg8JYr/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2da00185dso351045a34.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 14:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707604453; x=1708209253; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Py5o2uQ2CSbb5W6cNzyBQysajVpKL8ai4KYPGoRjhbM=;
        b=Jlg8JYr/z2BcUS3/CwaWWCx5cHQREPNrd9RqtjF4Txe7dTtoQ+rKsuy04/S+H0JEWP
         jwMLDgrPmqmTqgy9Cg/GaORlkoec7flRjCKLqMLbqYyERjlrMea0uNp5ekkPVBoLmAhC
         tfrQKqpD3Ost+DwRW6lXWDt9sJOwnP65OC3fJ2PeKRsorhniw90ZCNK7tH+YcIGZPevx
         jGPAHshZYIZvsoORCbbejoxnpZlXWOcDabBTVO+moSurikbV19AjIzhs3CkFeOB2uV/D
         SK6i7Sf88K8e0mQb8TK5lI7cMxudlcPymm4ABZaTslaCRwXKRWQpJQRl3feeRKCvTz/I
         8Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707604453; x=1708209253;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Py5o2uQ2CSbb5W6cNzyBQysajVpKL8ai4KYPGoRjhbM=;
        b=IP+FG874lZKP97MqcU6o5U2zeZILizfysueeEbmsVmaxH39ZuOJtKQwiI0o6qcQLrn
         Gie3HA0Z0jRIsRzhJ0F9qqoMwksefizPYKMwNPY9HF4+ukRwALNSgkCVuvGJu/YAZPti
         r0f3Zy98o/RNVbeoEjpYERPlo4h2bHdeqhDDxWVUbCqdCUrkPlKghR4CVktCY1dumY31
         EpEmBSUg/z1DRJTELX+lRaPqwx2TbSLMszxHWCaCv9voOS81bM9LlGO1Dz9QXE3RM+Kg
         S7GUxgUlVgL0bwYeWFzl6qb2JIU/8pf8epJavNfmVDET+JSzBJIldL/aqT5P6GDCNOgJ
         K08Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSBevm2h8ioPUGrpM2bQEtY2urOHYblaIuhJVBs6V4/JKY0goyw/c1Xwc/1RyqdFMFn8GCXenFqugkyRf/onAyQ8LcRecoHatK
X-Gm-Message-State: AOJu0Yy2Mml6j5f04X/yfmzNzPRCXn/jay918W93nN/VSAfs2JEb9cZc
	rZu57WD0b0gb7YGHWtJPXCo4z2KCvMEphTd63amfE6+QFTcklSJB
X-Google-Smtp-Source: AGHT+IGwUkbuInCa2I6zdggeaBmKSjDKKZlMNgxnbIM9cht/Djtd7shh0aCMfiKB/biQbf+Z4PYSqg==
X-Received: by 2002:a05:6358:70c2:b0:176:9e87:412c with SMTP id h2-20020a05635870c200b001769e87412cmr5427518rwh.7.1707604452545;
        Sat, 10 Feb 2024 14:34:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeBs5fP7IkQgKPdivkchdEY/SvLbOuB20pBi2yNMR39lOWfGT5K7/e/D+OekdvBdLloMYp7adaX9k+uVHbPI74YOOZqerD2YqYFPkKDl/tAZ/TjP+bJnvPbtWj5VmTMbey8QA8gnL9O/YmK7coa19RLaGzFuswwkE57RUXviul/AuhFgPFuaa+qhmLoK51YckkpWV9HhkDoL9gi9PUXWm9xw==
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id g22-20020a056a0023d600b006dddd685bbesm2768445pfc.122.2024.02.10.14.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 14:34:12 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 lkml@antheas.dev
Subject: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Sat, 10 Feb 2024 14:34:11 -0800
Message-ID: <4956451.31r3eYUQgx@nobara-ally-pc>
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
Content-Type: multipart/signed; boundary="nextPart4605103.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4605103.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Sat, 10 Feb 2024 14:34:11 -0800
Message-ID: <4956451.31r3eYUQgx@nobara-ally-pc>
In-Reply-To: <4923946.31r3eYUQgx@nobara-ally-pc>
MIME-Version: 1.0

From c65d1ef44d749958f02d2b9a50a0e788b4497854 Mon Sep 17 00:00:00 2001
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Sat, 10 Feb 2024 12:31:54 -0800
Subject: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table

This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
driver with an ACPI match of "BOSC0200".

Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/iio/imu/bmi323/bmi323_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
index 20a8001b9956..346ba2d1a169 100644
--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -93,6 +94,12 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
 	return bmi323_core_probe(dev);
 }
 
+static const struct acpi_device_id bmi323_acpi_match[] = {
+	{"BOSC0200"},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
+
 static const struct i2c_device_id bmi323_i2c_ids[] = {
 	{ "bmi323" },
 	{ }
@@ -109,6 +116,7 @@ static struct i2c_driver bmi323_i2c_driver = {
 	.driver = {
 		.name = "bmi323",
 		.of_match_table = bmi323_of_i2c_match,
+		.acpi_match_table = ACPI_PTR(bmi323_acpi_match),
 	},
 	.probe = bmi323_i2c_probe,
 	.id_table = bmi323_i2c_ids,
-- 
2.43.0

--nextPart4605103.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXH+eMACgkQ4obKiQwb
1x33Pgf/WqmDNQG23pqJNEMqgcvJPSz3aez/8z43x8zkN8JFzGsSZ3VTzU//0JOB
XrGb5Y6Nl0cdI7ujDeVr6UFb2BMmOvABA4VRitn9B0NrYKmwSIFt7yJEL218G3SY
nTaWdpFtU+1mBsuJXFlBTyEJ46L07hq2H5LiMEJ0CBo/Q/u2UiG3iwW+nfh0cdFB
LRkHnyWdRVx+/tZHAml93yhQkrc0zJEEFV/SrekM5q7zrjz3gQ2C5ThtGG7bQ7NY
Xa6dIFNfsBst7ixkEU0VpWDn/43JaV2ykn+H+kGxaZYFFXvq7nt/z2ISb5ulligT
df/Dc5lsyEdlG9RzLosyWlQbAi6L9g==
=UwU2
-----END PGP SIGNATURE-----

--nextPart4605103.LvFx2qVVIh--




