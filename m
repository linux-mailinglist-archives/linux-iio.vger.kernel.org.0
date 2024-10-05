Return-Path: <linux-iio+bounces-10219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048ED991A6A
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 22:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA474283E2F
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAA1552E0;
	Sat,  5 Oct 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8oktThA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAE130AC8;
	Sat,  5 Oct 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158706; cv=none; b=EtWGlqD0PjhEmxVS/4OwNdzEb3a/4yYJv2iXk4wXpS3Wwf4LGqka9KlruKs3+iCjd5AANujg/86C8RTgcyK8vfSE0XVfrhFNzHHIzoyhnWSalH+XtpltM0kAirTfJP1niSJB2PW3NW5lTicDeJ3Uz36WuWAYNLvLL00a0BbJeHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158706; c=relaxed/simple;
	bh=QELd5J7MAM+l4WHOYn7nPtknK5X7YZO/diJWWJSfgCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFJ4PlKOHUc2Hn/aFzZeTXlE58ZhhK3EBOC3+XW37izcuV6uMKRI0H4y6ERs+FBnjX4YhmJBCKWkNAJVv9AC7JKrzfnLgocZV2cW0JDsy+l7T0DVqdCLjHv+8kPzO1WhRcEmmzg1DLBkf4eJq24SlyAjB3qpaoY/Gxwsxy/EgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8oktThA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9f955cb97so318977a12.3;
        Sat, 05 Oct 2024 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728158703; x=1728763503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6FLiMUvaeW6ZuMgelWmXo4D9/EphSpnuON34hbmUdIU=;
        b=O8oktThAj1pI7HJPpb4ZGkgH1UfHeIesf48nQJaYxbnqUxnUlY+zoSrzoRrH0H0UER
         VgkdCoJuOGT7bn/AYzbk5zy90ganbt+1rfNsLm6AVfF5rlAZWJyq3j5qqP2cWJUshWZ7
         SGheP7tdLPVOaJuQCY6zLzdLH8t4GFB4XaH5mcMg6QVkZyRxF9eLbOjnNV/o9idfVdmp
         UC6peHHMeDYjC6r+ygfR6fekB+mhA9HGKU9GtOntMUEGKFQgA/UcE7ZRbRcAomUot/8S
         G5V8PhyOxOxMFDN6jgolj6664D/JbjgEeAN9RIN5fHUOqyh7Zz9tHj/ZKwhq8eSoN0kg
         SY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158703; x=1728763503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FLiMUvaeW6ZuMgelWmXo4D9/EphSpnuON34hbmUdIU=;
        b=EV4EL1knBuJQsXKaqrhTOfD2yArXZOIAQmDuA6iLNkDiwBZBefD0Wh6kjUjihAcPI5
         ofF3nnocw7s/KRJRBrHFbJ0PylDNIwGlM68KWsasaH3WRwru6+OXSh1TLSkRy2Vv0tv0
         fP/gyCVtmcsrrKRchXWveXolW3ScgQMVIDzzq7JPBydL0lTZFiI6iONa+MOXI4yANQwU
         WzVqJDl6TltKmYTSwek4a7A3Brinbf1gytaYF9Ct//KHww4bzrmAyaKR10BPpiq770Ws
         RAtjgypF54FTqMAJ3G6aqEtjawkZC4Td/JIa/kEqI9/p+gKCcdxPkPpqENVhUUfZoGax
         bxbg==
X-Forwarded-Encrypted: i=1; AJvYcCXrPLbGrWLHgaEPJUqA3pnMZOM09jpW4S8XSIMcmsuerhQZwrf/vIsdSe01ZQr+DJGgFnFB/zjcWCo67P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCT/cUBy2LZKEnKBNt/obLWj077B4eLkmq6wL6ITMIiZUm6yO
	HsAFe2XsRkJP81bFGo04Y5ged/on8C9U5v1Qa14DUOiTcP4azVbYfypF3ONa
X-Google-Smtp-Source: AGHT+IGFuNFwEl74E8F4On4BC0XZcznAJ/4LYW7R7vN5tLcHMV/0TFu00dzZTHz6cCGAocZu3+gGjw==
X-Received: by 2002:a17:903:244e:b0:20b:6be7:310f with SMTP id d9443c01a7336-20bfe00d188mr112908685ad.25.1728158703093;
        Sat, 05 Oct 2024 13:05:03 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f682decbsm2114825a12.45.2024.10.05.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 13:05:01 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH v3] iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config()
Date: Sun,  6 Oct 2024 01:34:35 +0530
Message-ID: <20241005200435.25061-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation of the ltc2664_channel_config() function,
a variable named span is declared and initialized to 0, intended to
capture the return value of the ltc2664_set_span() function. However,
the output of ltc2664_set_span() is directly assigned to chan->span,
leaving span unchanged. As a result, when the function later checks
if (span < 0), this condition will never trigger an error since
span remains 0, this flaw leads to ineffective error handling. Resolve
this issue by using the ret variable to get the return value and later
assign it if successful and remove unused span variable.

Fixes: 4cc2fc445d2e ("iio: dac: ltc2664: Add driver for LTC2664 and LTC2672")
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
v3
- Fixed Styling issues
---
 drivers/iio/dac/ltc2664.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
index 5be5345ac5c8..67f14046cf77 100644
--- a/drivers/iio/dac/ltc2664.c
+++ b/drivers/iio/dac/ltc2664.c
@@ -516,7 +516,7 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 	const struct ltc2664_chip_info *chip_info = st->chip_info;
 	struct device *dev = &st->spi->dev;
 	u32 reg, tmp[2], mspan;
-	int ret, span = 0;
+	int ret;
 
 	mspan = LTC2664_MSPAN_SOFTSPAN;
 	ret = device_property_read_u32(dev, "adi,manual-span-operation-config",
@@ -579,20 +579,21 @@ static int ltc2664_channel_config(struct ltc2664_state *st)
 		ret = fwnode_property_read_u32_array(child, "output-range-microvolt",
 						     tmp, ARRAY_SIZE(tmp));
 		if (!ret && mspan == LTC2664_MSPAN_SOFTSPAN) {
-			chan->span = ltc2664_set_span(st, tmp[0] / 1000,
-						      tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			ret = ltc2664_set_span(st, tmp[0] / 1000, tmp[1] / 1000, reg);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
 						     "Failed to set span\n");
+			chan->span = ret;
 		}
 
 		ret = fwnode_property_read_u32_array(child, "output-range-microamp",
 						     tmp, ARRAY_SIZE(tmp));
 		if (!ret) {
-			chan->span = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
-			if (span < 0)
-				return dev_err_probe(dev, span,
+			ret = ltc2664_set_span(st, 0, tmp[1] / 1000, reg);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
 						     "Failed to set span\n");
+			chan->span = ret;
 		}
 	}
 
-- 
2.46.0


