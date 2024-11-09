Return-Path: <linux-iio+bounces-12084-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5CE9C2DE6
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2922828B9
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66FD19753F;
	Sat,  9 Nov 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/Gvg5bU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020813DB99;
	Sat,  9 Nov 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164075; cv=none; b=ZfcHD/ek9t/BTzfqccDjrVu0x3HBVXhlU9j8oxU1wi6yaBImojlahkZzMW4h16CHuw6UQufJ2FzghOT0r8Bz06ub4LCTNMwjmtLo9WDjFBUh3qvhe+2xZdu5aMtJO6c8ny9051qaKnQtXEZVp6fHPSOzhnwq8XGO7l5qQgOdiMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164075; c=relaxed/simple;
	bh=QtapQUuip7PB+oTuLA0bxtTki5RnTFJc9Ko4lVL5LfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APbFuY7YzFGSBZd/mGWPJD1vWWco1K8JL1RJwP49A0XBP+F/w45OeTS9NnM3WQF7GTyxFjLxVkRf4q1CP7vz0Tjeo+5vVOH1Stv2TB0udMSUmUY1tL3vxmFs9iQcylEdTlld2oNAhcKh4zJ10OKSqezym35HwpDdDedeDy+Jrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/Gvg5bU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720d01caa66so3022322b3a.2;
        Sat, 09 Nov 2024 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731164073; x=1731768873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=is1/mgq9c4Z9LOcMYjNs4z5dNQ5YsJhO5dlvStbNqAc=;
        b=C/Gvg5bU5lhwDeaiMlGdl/zXyRj3xzWLBH7Z1UFpTWAwuLuc5sLuzezsB3MBBnpKHc
         F+xfsJm9+T3KY9enB+f6bJ/70JXsyMPscGLsz4ipqUFOBmopJdiXD7JESyq3g9A7rHSa
         YfpoUMlAuHeGoxR+OZN0wkahX0sfhr/feo2DhrhTg56CU7n7uL9d25xIjupKuVmwL1Yk
         1gNisx7sDbPV8DdorjKDdMT8LLNh1EA1TrG5cO1Gg/SAHpLtjpIPJB53AiXG+AsOVXSv
         S8EmKcFf2GaS4fvNBnYcviCBpugLcCfclr4hgbelNOPlRzIITAJW4u20dRXmC5HCk+A6
         J4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731164073; x=1731768873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is1/mgq9c4Z9LOcMYjNs4z5dNQ5YsJhO5dlvStbNqAc=;
        b=Er7aEtVB81Hf1R+fciVJjgiOgFBQHIgRiN8AM+ysDvQd/1kpd830jRbTAtVpqD53gM
         351wFl/R5CespiT4jckfl9eQNvlxv92eYjRttX/D/inGYy1ElmFhME66rqCKPGnbWxr+
         y475HexCM56cpaEvXDmzBdq8fB2j3BGqedq5SIXpeg72f4tr1zru4eqgkJAxHcMw6jGQ
         ZVRNa6cNi6bnM/84RmXwTeNoVmKzDDe4jDQELrWv+GGNu1qti86XiNhNbSrMxlnEjDhh
         4zpgah6XxI4pEZjpGEIPlZ1CQj88E/uTBXhhJEOipIRnph5/ApHKiU0sixFcXChAD4m+
         JmTw==
X-Forwarded-Encrypted: i=1; AJvYcCUCXwdWo9UqTnnY+hx6lixPNHiwk5ng+eMT3lU+PSOfVgZ1nkVxKTPdn0gfqUHkoUa0pkBXx63160uw8Q1d@vger.kernel.org, AJvYcCUodj5C0z7AIGfOBER++Aev6EoIsS2ZHWBHvo0hK1I/5+lt4f/wU0zRprbnwDy4OzcI4qzsYnAhVHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7oU8W3resv4Pn9HDOm/csv8xPuj2re22QPZKAxJNFEZA49s1
	GCYdW91/RxBu1y+nzklJcVVUqeb+uPVNQmyA/iq0Nq+pV22lv4vk
X-Google-Smtp-Source: AGHT+IF7VlS3GuAUbU/2h9QERJwHw0ZR6DVNqan+aYi1R45giHq8T25magVRywrkPSBXUDulaT/GLA==
X-Received: by 2002:a05:6a00:b4b:b0:71e:77e7:d60 with SMTP id d2e1a72fcca58-7241338acbcmr9004377b3a.23.1731164073332;
        Sat, 09 Nov 2024 06:54:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a187e9sm5628223b3a.132.2024.11.09.06.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 06:54:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] iio: imu: lsm6dsx: Use i3cdev_to_dev to get device pointer
Date: Sat,  9 Nov 2024 06:54:30 -0800
Message-ID: <20241109145430.3702482-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I3C client drivers should not include linux/i3c/master.h. Use
i3cdev_to_dev() to get the device pointer from struct i3c_device
to be able to avoid that include.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index 3b0c8b19c448..207dcc0ad988 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -9,7 +9,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/i3c/device.h>
-#include <linux/i3c/master.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
 
@@ -30,15 +29,16 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
 	};
 	const struct i3c_device_id *id = i3c_device_match_id(i3cdev,
 							    st_lsm6dsx_i3c_ids);
+	struct device *dev = i3cdev_to_dev(i3cdev);
 	struct regmap *regmap;
 
 	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&i3cdev->dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
+		dev_err(dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
 		return PTR_ERR(regmap);
 	}
 
-	return st_lsm6dsx_probe(&i3cdev->dev, 0, (uintptr_t)id->data, regmap);
+	return st_lsm6dsx_probe(dev, 0, (uintptr_t)id->data, regmap);
 }
 
 static struct i3c_driver st_lsm6dsx_driver = {
-- 
2.45.2


