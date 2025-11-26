Return-Path: <linux-iio+bounces-26476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6FC87ECD
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 04:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB74EB370
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 03:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42330DD22;
	Wed, 26 Nov 2025 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX1oGGX/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138B1A9F9F
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127102; cv=none; b=dpzkTtYHTLMj9B/jTx5J+Q6iRt5z+6eZvts7eE9nUXfdk85Oap0eyZ1YLQyRlu2TyFLFYDWb1qSjXs5v8fDWA5PHBQZRbcXRKbxVK7CGjrv4Rwc4x22modRFUOTTDBhxvcmj0yCEKi0/SIaJfmKa1NsOpL2Ep2LZNm8h6+qO64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127102; c=relaxed/simple;
	bh=p2a1vXXc69O/px1tJS9PHGGSu+bfndAnOjwnw4vFX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfWySZ4M6byH6k6vhTGqzGoLXFN+cKvyOhq2LY7qDhaRi6car3YO8czp2x5eFdKVfPo9EVr+LvvQNozltAhrVkkdM035XDF2iFDoJOflJe09aBMKDYhIgJDVGSYH/PzhAgOGf04jENrP4iKoCINwBq/MP34Ei7dOonL3jZD+vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HX1oGGX/; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so6222327b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 19:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764127100; x=1764731900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7ozaCRL273ETHkhhjpKcicKScA37yYy2L/hbCujZyo=;
        b=HX1oGGX/ZtNtbAv3xlF6N5t6A1d5G+/Z/KYXUDau0GaMYNz1LQmKXLOIWBUbFo7t0X
         TFpUaUh1mc0qQdGyQTgvjMaDaXstmcWtImi+OIFehj138Fb5zUg7l1yiF9LMTZxKJqLJ
         oyRkwznxCWnEsugjDrgN/s+AQYjA7L6c3UP6VewlEMH14mIUJrG8yOmbsCbXWY8qHaof
         VCkBRhnqRy0vrSnrPZvob4p69OL9ugYSv4OM+0T5aofDl4+zMMAP2eWiR/k9VGK/1xcU
         cvi8xAm105GyeBioo3imS64lPguRY+pajT4hFEiC+OoTgZkxGn4r+Br1LaUuyMpoU0j/
         Jhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127100; x=1764731900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7ozaCRL273ETHkhhjpKcicKScA37yYy2L/hbCujZyo=;
        b=nIZcno/IijEd3eq2cYbqYAo0leX3DM8VcxSg9zpuPweGhqYPJWgGKRuKAMEFLlkEVC
         NLdYnDZt9BGBXASRoMKabkq22SKUU6KnFX3d0NF0DgmxAEyWm/mfK0VKnrTgdLltQzTc
         hX64KKP/yKpm7X/YZx2VNty5aP2aGqMN4JH3r7mNL/3UgHDHDvL5/f+nENaSKc0VgfdL
         z0Ix2j7mx8eNcZZzH4QlxvxYoV5xGbLB7InT5ILVGUH8T3E5iNdC2/JHkc79DHnAyk6C
         1al5u8t958e+SbVASrOc5AkvLCvy4Hy8z/V51e+XdUUCw+pOu5NLESDbLtpZiNRqwjlV
         eFPA==
X-Forwarded-Encrypted: i=1; AJvYcCXXAIMJHMBzcVWXKMOMyj6OOWtdKLh7U7EQ/9A0J26vyqy751XAqn8f6lkeyTpZ+wqTl5iSxukJEb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFwKc6SjPISoSTwjl7rvHJJ3Ku0F5aeJIkxxQwiaTr0/Jq8sT
	SZ/Hyr9bG7v+BaSmdTmtpbkXzjZZqtwUsnGA80U8gL5el87UoFPZOnls
X-Gm-Gg: ASbGncsaRFw72OvmHHYpHLRAGlcynGnR/sjPRMeL8LgGiY6dI+t1+BOcPMeetW13Ymg
	abWhswMAGLu1V16Pq4IsrSx05EiYMxIPBPfN4j3fRPf9/tRs1y6bI8kP2JkkzNQGgMBesBAM3k1
	zKFSxZv1ENoqCZV9oghlGsz7WrQ7JMRuj4BXzDAllE0xm3aD/0hug7sc9Sg6gzqlyOB2fwQztrb
	mNnDBIRjVWvY6ff3i3YsFjhaY2K3wqCTC3q9fa6zAZg9AjVruML+sEx2TGoLbdcpwoGoruE/xie
	qEnn2wiQ6vbGrSXtmv7XOIb30Fxycpa+RBK9B7o80YCQ1buVYJfNqyf+qC8Bqlr3pMdSn+PS18E
	O3Nm76E7iPYZC83k1sfe4ZFzJUQH4QL3HIAoqsS+HGU/rgiTSSyHsAghABnw68Ao/g51+2Jleph
	SfhA2cWA7Yx1NuSg==
X-Google-Smtp-Source: AGHT+IG4qlNiEEoXWutLGwHJ0G+8UC4lSWmbuW3HpUhf3gSmsfXJsXmVg9/UlI5YsquppzK7NKIpsw==
X-Received: by 2002:a05:6a21:3384:b0:35f:aa1b:bc09 with SMTP id adf61e73a8af0-36150e6cff9mr20254369637.17.1764127100409;
        Tue, 25 Nov 2025 19:18:20 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac62ecsm17935713a12.26.2025.11.25.19.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:18:20 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 2/3] iio: proximity: rfd77402: Add Device Tree support
Date: Wed, 26 Nov 2025 08:44:39 +0530
Message-ID: <20251126031440.30065-3-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126031440.30065-1-raskar.shree97@gmail.com>
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables seamless integration of the RFD77402 ToF sensor
on platforms that use Device Tree for hardware description

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index aff60a3c1a6f..3262af6f6882 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -313,10 +313,17 @@ static const struct i2c_device_id rfd77402_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rfd77402_id);
 
+static const struct of_device_id rfd77402_of_match[] = {
+	{ .compatible = "rfdigital,rfd77402" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rfd77402_of_match);
+
 static struct i2c_driver rfd77402_driver = {
 	.driver = {
 		.name   = RFD77402_DRV_NAME,
 		.pm     = pm_sleep_ptr(&rfd77402_pm_ops),
+		.of_match_table = rfd77402_of_match,
 	},
 	.probe = rfd77402_probe,
 	.id_table = rfd77402_id,
-- 
2.43.0


