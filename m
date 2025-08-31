Return-Path: <linux-iio+bounces-23511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A47B3D159
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F75189CB0B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE8C2459D9;
	Sun, 31 Aug 2025 08:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CX2MAuUA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F920DD48;
	Sun, 31 Aug 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756627776; cv=none; b=sOApRKtv7PkAXrtZW4FkRmprc6zn4O79SH0n1rpsw0VONrH8waAGL+EkDQO8SDSONV4j/lJaKDij6hSuV6XF4BML6W3PVsBh5F1Q9+KwZOsBRxPmRajh1uMjc+5mcSksDrWnmMDHgowMb+nUjzFxTC4gq2THdBk65hXiQryfaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756627776; c=relaxed/simple;
	bh=8yfR9AM8Fq2mbKk5X95rGh4Vo/NEGjA3vGI5OZ83BUg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i1940TQZWK2XkpYadnzKnHCVKhy2UPBS/r8VlRooZt18T+4XVkCfLaWV0mdbMBGXDANEve2FuvXJvPGScddwVd2kFTR9i+8vi0QsdRTNLExeUJ5Me3b6iqvGrZFfH68zZJIGfujiFXM4En5bGLSC5KXF+TBkjkxmuBHnajVqb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CX2MAuUA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b040df389easo117059366b.3;
        Sun, 31 Aug 2025 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756627772; x=1757232572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U4tujQvyyX9fZH3DuS2TnD9F6FC4Q4d+PH1hXFgK9GU=;
        b=CX2MAuUAxKMRCqaoqWfrAWS8Cy1sNrStQUs6MgWbHO//SZS4iKiiAcKxlGJKeLKyBy
         nnmT/oboQBaXzy4Xqn5CCj/VT4nqDnzjtawHOk75uzgLC1F7qqXRIeq5GYLcamjrGMp/
         VVF3SfGiGnyhjo3+n4w3V9neVPcmNrJXCMEZo1IA3m4wsxDPf+wLDPRsRuS7xXTaBYOE
         /3DTR5wHy4ALj5Mr8Tk/ICGHb/kOSRgOt1cJziZHwTxB7M9GeYkC0y/+cTXxUiHPcco5
         PwBAVuAYdaHi4JI901WzLv0EW9xBvyBTguv+ryqYRLX8wdR7xHF1qH59NI8BlkLONuHi
         1eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756627772; x=1757232572;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4tujQvyyX9fZH3DuS2TnD9F6FC4Q4d+PH1hXFgK9GU=;
        b=lJSpgtdTzVDkJI/DWjmdTSParypCiZGAM6YphfVvXai0q96KdEDNmWVt4I39kUUB7m
         mL8lTBVVCU2AxYDy94ZfHLi+EneW/p3UGsT8BU1GWBl+ZGveWfwH8CUJe7rjYn2aNq4B
         MVbOI78uqgtEZW/wAsMtU7G/xH1Wv2oMya8LV2s4E4+f+iy0X0JFONvM2eNCpnPqbT2P
         z1VGA0SnRPn9vHk+p/LkwUi+gnIo/8Nvrwxjt0eu8Y8qHadaGgVuyUCvtjGA72PJml1Z
         7A5hVL+9bx4G3p3dk5m6niCtAlodrBOo1YJd+fiYSqOkahE1HbCkPg0k62yl0PkHRrSY
         /xFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEdK+wmbT4Gdt7WYOJy2HyIb8dZ3r/r8yoRBK31gAGorfOKPkBB/EwXcKfji3AQTxktv2JcIpR+n2y@vger.kernel.org, AJvYcCXqOnL3+B1ZEBf4jqYRwtKDKeKdnVjiEHm3MLwVKY3oBY/JNrLBoP0ZSWc/2bI9UElk/tuulokncVNq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YCaAzWzuEPMhoYzgUVdECztVu0y5BVHLc+KcjJV8MToXDJ/X
	E1qv2auxX1YT4AMLpMrAtKKqVCeru+8o/x64Q4iUd6iUvtEsev1Cccue3lIaYWMH6g9gfGXX8qt
	J92DRTyU9pcckbrmtJFzwG2uP7C6jIGY=
X-Gm-Gg: ASbGncuN02/MfmbDbxLQpLsiwVf4HlcnHcilPk6ZPsD4GmubjV2Y4KuCVv9dsG3Fsw+
	ob9I/Tully2I5v1uUpzFjn77bQBXh508ZjNYrZGl++/uz8AKxLvx89ropOw4iZFbKZ6MtVnZVOm
	8+GkK8UQcqO9ahn3okRMuzP29hw/NlCmgHuCmpDkLFfybTfYt5qJURtJZg6RuIZDiwPU8jmjohB
	07GH1Paag==
X-Google-Smtp-Source: AGHT+IFRcbgQGOhOHy8l4ya3q8YmBiFZ3kin1w0T3gbWi9zQr91LAfNSczb8s2O0ktw8k5NhKd3+Xfn3kHWXZkbG7aA=
X-Received: by 2002:a05:6402:26d2:b0:618:229d:707c with SMTP id
 4fb4d7f45d1cf-61d26ac3559mr3370160a12.2.1756627772380; Sun, 31 Aug 2025
 01:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Sun, 31 Aug 2025 13:54:20 +0545
X-Gm-Features: Ac12FXzH_tP4_mwCCvUI5CdaDBfffNKKlmwYj5fgF6rieNukRDby4j0VcrCrcZ8
Message-ID: <CAJE-K+CiQdZ9mpqom0HdGoCqrt3v7Dkj2DM5WtumoGhhtduumQ@mail.gmail.com>
Subject: [PATCH v1 2/2] Added mhz19c to compatible list in mhz19b driver.
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The pin-compatiblity and UART configuration are same. Although
documentation on mhz19c's UART commands is sparse. It can be reasonably
thought of that the commands from mhz19b will be supported in mhz19c.
The mhz19b document mentions all the different commands. Still the
uncertainity is noted.

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---
 drivers/iio/chemical/mhz19b.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index 3c64154918b1..4899aad895d5 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -297,7 +297,17 @@ static int mhz19b_probe(struct serdev_device *serdev)
 }

 static const struct of_device_id mhz19b_of_match[] = {
+       /* It should be noted that mhz19b is discontinued*/
        { .compatible = "winsen,mhz19b", },
+       /* Beware that mhz19c has same pinout, UART characteristics.But there
+        * are gaps in the official user-manual[1], specifically
+        * regarding.
+        *              Calibrate Zero Point.
+        *              Calibrate Span Point.
+        *              Detection range setting.
+        * Ref [1]:
https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19c-pins-type-co2-manual-ver1_0.pdf
+        */
+       { .compatible = "winsen,mhz19c", },
        { }
 };
 MODULE_DEVICE_TABLE(of, mhz19b_of_match);
--
2.39.5 (Apple Git-154)

