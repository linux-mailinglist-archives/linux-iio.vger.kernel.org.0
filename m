Return-Path: <linux-iio+bounces-2343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B684F945
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416521F268B2
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CF97691B;
	Fri,  9 Feb 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMp69HiW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E676905
	for <linux-iio@vger.kernel.org>; Fri,  9 Feb 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494720; cv=none; b=YUYH5dyU+N+gCv7tFAWnC+FZU6KT4W8nxqJLLQfxhMipR7aXA7gnUmobayCTMTw0sy/UMEry5SaAOgSeCftCM9ktLDGHV+Nl1cfNRrDnsMObuw494LRwVxYUFyogVG/fSknwuGV7rTXKoUIOHZPCGQjt5GlByM+lt05nCRdnd9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494720; c=relaxed/simple;
	bh=H8GybFc5aj6pORvVpE47Ai/Mk4aU7Jq0/uO5Si7f7nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U6R5BOb9CUO8KYDffwSfcgtFYbmNJA3LZAclqSHHxhvnU0bNSoOmfBcE4wEEoQqw6n/MlfRFmjnyxG6jGyhjU8ASf6BPRs6FLT7WAZmSdo1HiUTHInlAHis2dCPHNo/jRGuRg2x93QM2cx31EPtblhNerSEfzkjLqTWSyN7FKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMp69HiW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d98fc5ebceso6878665ad.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Feb 2024 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707494718; x=1708099518; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o9aT+FcaX/UgQJoH3ETtkDrzabWjMfD8CWwDEmWTRXY=;
        b=nMp69HiW7CIJTi6xVdreap/RNhtxyM4WYhgQkdjRTZDmH0zBt4WZuTckVUHVoCCrkF
         pX/CtidjA1Ux5Nh9rZU0IbFE2zwVjNTc6cXmDP8icic7dp0UH3jxQeDDnYUpl961ZSoh
         nud4C39Q96M4fb177LaaGIunvOYC7JSslWgCqM3kllDp6ELxMHJxxxS8e0QQcnMp4jlk
         psutZqZ9/6Jmcw890ywvLaOYe/j5vDPSF2VmBR5217swS/cpybn95l7qLVYb5jStm3uP
         9sCu4hg8rNJbwEPZUWnw3g7kR7eJW9hVn33mOrJ4yEGGslgcxnEcfkHDnWaFZUxJU85S
         sQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707494718; x=1708099518;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9aT+FcaX/UgQJoH3ETtkDrzabWjMfD8CWwDEmWTRXY=;
        b=BHsAOKfAElEU2e37bOP9t4A1NCTgH6EkqQooUsLeB/VAaOJt+RLiy7jaJpYsltInQL
         VyDJD9eaF0vNwIeT1Q0cqNwDR6gH9ifsT/GHWqVnH2JLp6eLbcGJ/tgsklLLXRtA76oI
         EBdjFciVrvxUxUMqe+XfISMu3CnQ112/KK1VueFQxViVDq4esztZyLFyRLMRH+mLp/h/
         eWuUy6mjsfXlcV2yNgvPOvEKqHiG0Lxj9vT7iGE4GH+iNgA7dSyZ3cmLKh6bKkr1/wQc
         TyaAzWm4TQzt/2bGRmJbjTOXXhwZQiu4UoCQpNU7/YE2ciD00Jf5IkxTka8G6canSwBZ
         Sf/g==
X-Gm-Message-State: AOJu0YytqIBZGbxYUVFOtBPayjTUW6A7tbXXyDeD4gHDsjsFlxOmbOEO
	i/SbW3HUy5rm0drYV1FRTE7TycAtP3ZEuxbK/YBT5j9YWxHwKjoq
X-Google-Smtp-Source: AGHT+IGydBmvuHXDDyhQWkLfY8ro+Eqka3CpwWM89GqlIOdjs+AXRoSz7ICyMWBboF1QHelRmGZVtA==
X-Received: by 2002:a17:902:fc44:b0:1d9:d162:667d with SMTP id me4-20020a170902fc4400b001d9d162667dmr2889178plb.38.1707494717891;
        Fri, 09 Feb 2024 08:05:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEtOFFjmWuIU+GaWdp16RsVah5Fqjv6ncrttAgMgzv6FqR1kPYBafrH1v7//HYRgcjr/+c3K+Q4YLFzMCINW9P2d11aptl+JTtSAAjaQnygftGkCh4FFEM3B7QIc8VUO9G2/eUoDvPzlYrdgy7VbhX0MYUewmtcXxbxmJW2TWQi8UptGMmnp4=
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id fd24-20020a056a002e9800b006e07f6aa1a6sm690358pfb.42.2024.02.09.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:05:17 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: jagathjog1996@gmail.com
Cc: jic23@cam.ac.uk, luke@ljones.dev, dbenato.denis96@gmail.com,
 lkml@antheas.dev, linux-iio@vger.kernel.org
Subject:
 [PATCH] iio: imu: bmi323: Support loading of bmi323 driver for ASUS ROG ALLY
Date: Fri, 09 Feb 2024 08:05:14 -0800
Message-ID: <5769241.DvuYhMxLoT@nobara-ally-pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6032406.lOV4Wx5bFT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart6032406.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: jagathjog1996@gmail.com
Date: Fri, 09 Feb 2024 08:05:14 -0800
Message-ID: <5769241.DvuYhMxLoT@nobara-ally-pc>
MIME-Version: 1.0

Due to an ACPI match of "BOSC0200" and existing gyro drivers, the ASUS ROG ALLY attempts to incorrectly load the bmc150 driver.
This leaves the gyro inoperable for ASUS ROG ALLY. The correct gyro driver, bmi323, has already been upstreamed as part of the 6.8 kernel changes.
In order to load the correct bmi323 driver for ASUS ROG ALLY's gyro, this patch uses a DMI match to unhook the ASUS ROG ALLY from loading the bmc150 driver.
This unhooking is also added for the Ayaneo AIR Plus device, as requested by ChimeraOS devs.

---

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

---

Now, after this unhooking from bmc150, loading the correct bmi323 driver needs to occur. In order to accomplish this, an ACPI match table is added to bmi323.

---

--- a/drivers/iio/imu/bmi323/bmi323_i2c.c
+++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -93,6 +94,12 @@ static int bmi323_i2c_probe(struct i2c_c
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
@@ -109,6 +116,7 @@ static struct i2c_driver bmi323_i2c_driv
 	.driver = {
 		.name = "bmi323",
 		.of_match_table = bmi323_of_i2c_match,
+		.acpi_match_table = ACPI_PTR(bmi323_acpi_match),
 	},
 	.probe = bmi323_i2c_probe,
 	.id_table = bmi323_i2c_ids,

---

Patching these two files in this manner successfully accomplishes unhooking the ASUS ROG ALLY from the bmc150 driver and loading of the bmi323 driver.

Best Regards,
Jon LoBue

Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Co-developed-by: Denis Benato <dbenato.denis96@gmail.com>
Signed-off-by: Denis Benato <dbenato.denis96@gmail.com>
Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

--nextPart6032406.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXGTToACgkQ4obKiQwb
1x20mgf/eXniUrc/YGPoacPCTorRSzqqD9ZkqccL5pB7UktmsE3cbrha9xDS5sfw
tl6rBwj94tCuTEElSNBT7AgJQ4UAjNjz9WC1pFi5Y1sPzTaiAMsaKxHDFGI8av3l
n7ospSiQQbgwiSxJO7NZxof38p6jpW0/naT2m3nxV98UU8Ro63bu4iqt6ytD3aG1
b/GSg5fG70lUUSCUs8FtSejOp+9KzqcOIfDqSM+fsJKfjSeMPmvFc0GRtejYEql/
rRAvyQTBVrUkeoTGrBYK+B+ISFy3MXCrGRech1uwoNzI0cNopFkFOqDV9FKiA8D+
79x/SC1RkEqR8kLO9FAxXUPtKNHmzA==
=HKvC
-----END PGP SIGNATURE-----

--nextPart6032406.lOV4Wx5bFT--




