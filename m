Return-Path: <linux-iio+bounces-18589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7DEA99CB6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 02:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641F55A4D4B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 00:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4185210F9;
	Thu, 24 Apr 2025 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1pA2VCz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E4625
	for <linux-iio@vger.kernel.org>; Thu, 24 Apr 2025 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454113; cv=none; b=oDgXh++Ug3qRYlPvVubTFkWMCsPrixY5VLKFSXa1pzJXQlsDsgmnreA5bd9ktUcU593jYqJt4Edg+RPXT3vNMpVrEHdbjeJ3sLXke0tho1j0H9IU9Smqbf2DmB28ZinwcFhGwFy632Ho1BGI5dYO0cu0o5ACHlgZrRpHHfsdr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454113; c=relaxed/simple;
	bh=93ydTHyzSEJ3B9/1OTqp/eamZinHPaD9QwPcbamT9g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZoq6Zfmy46RqZOrX7LtbXn0ZcXW/wlQ23De2PBELxsFnW8L+h987ZicLtMzbMnvaP60jviwyJuAkuLt82ldAoNvbIa0rU8tGLihsbuz/c1DUgfJb+sTN+Um5EmUMINmRNjmWnk0xKGfBi2mVvxeFhk1eDJnTHsG7NvKOFCuks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1pA2VCz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736e52948ebso432577b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Apr 2025 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745454111; x=1746058911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4icbh1rmUW099CKanh6yMQrokwqUV9m1cuDSM17nlR4=;
        b=C1pA2VCzb3PyzO7lqQao7J/7hdIdzcT2WNIzyxxr3MD+WeHf7TdwGB4FOdMiy9pqFx
         5K34KXWAKWTQ8aHgTW92YvoCC7z1VX+NVlG87StI1CrbfziWsw4IZKhz2rotLMOCczZi
         0oYSIN2WKcQKqfaH9594mzQaplsotBkJuVSW0RvvySkokesqvZLsio3S4/jiqabGBfe9
         Beca3iCpdfbG5XYpNpmvIzhN+aT5LZO9AXQel6BoYZmiKR9mggx9NJQS5E+qbi/ubFdE
         /+wnKhHFqUQiLavZ0TBt1yzm2Ai28uUVJDRlOs8Tok8M2XIuYr54hM4JfJhxUDKW6lwR
         2r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745454111; x=1746058911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4icbh1rmUW099CKanh6yMQrokwqUV9m1cuDSM17nlR4=;
        b=h8lhIsKB0RR8fLFrrX3OtdNnR5hOB7kj997RSJR7B7L/FRcPPqnlruLV8bWXwnCtZC
         +0V9InZHJREAhpiLyj0WZKeafTc2S5aPL38Rq3/yzfMEBGRpzFmINhYIqW/Z7QTMEres
         llxR6Zha9CrT/8vgh5Og4yyIZsUltB247RQvEIyKkK2lnXYu2/pWji+6w8W3mXoozZ2W
         8Fpm/BPQnDQ0SHImWHdS5JesL2/V5e0/9IstsQUqZODF5pSt2HduJj6ocIZXDNYWmQuG
         kAqO2vrhTbSlwdAm7DoyGLv4RihH1/abmcJANW3OgggPbxE9DjEX6sI7cEOMvrCh0VQ+
         8Pog==
X-Forwarded-Encrypted: i=1; AJvYcCVIidMXmNx/n6j9dXV/AQgxsAVLMPAXpC6qteTAhP6GXo+TBhXHykwMHLEBYDkUlK9PPvw2B1mvziA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpk2cjq1bhXsA3y8h/eQZEqJ0dH0ZBKaggyhcjs+1acM8s0Gsz
	EQ1sYJp9T2ipWj5W/VP21I6nCVWhIFmOpbLdiLqzKxd2ss/agmA=
X-Gm-Gg: ASbGncsJuoAqta35T5gyOtXG8m2I9N7vUTMPbo9FP2QKusbehvdSHplTDGKZ8rfsHDe
	4bxDl07RBZWG7zuHe3mwkVaZ+rYjDGnVMUhIBWGUf/9VaRmcU05fnYwaSjqyUYhhSbj9E4qV2VS
	sBMseN5C7LPwIC0uJK3bYcsQ82egtneoq34AxNPFttdZU75OzqMOIxKQTfCfTmdYXWWLflqJ6LK
	LF6Ia9RJcOzuf0WCTd/K8EJ+QmFwQWsPd+fveHaIe9Fi0UcaYQ45UkqpMnhU7TorR30OCRLW5Mt
	+IZv/A3KZOPQ/b5M6N7RdOdjcw1e6pOXMedkzWbQO4t1k4UvIcpDFVribTr/msMQJr8=
X-Google-Smtp-Source: AGHT+IH/EqYJr+9iGDCJiGSjYsx1ziDrTpNhfwnW06WuucZeQbkwg89pUVp6LM0e0JJvntPjADTUhw==
X-Received: by 2002:a05:6a20:3d1e:b0:1f5:8e54:9f07 with SMTP id adf61e73a8af0-20444f0e582mr778260637.24.1745454110869;
        Wed, 23 Apr 2025 17:21:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:ad42:50ef:1925:5a6c:2254:2b71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a17csm180044b3a.111.2025.04.23.17.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 17:21:50 -0700 (PDT)
From: Beatriz Viana Costa <beatrizvianacosta16@gmail.com>
To: jic23@kernel.org
Cc: beatrizvianacosta@usp.br,
	linux-iio@vger.kernel.org,
	gabevictor333@gmail.com,
	gabevictor@usp.br
Subject: [PATCH] iio: light: zopt2201: Remove code duplication in scale write functions
Date: Wed, 23 Apr 2025 21:21:44 -0300
Message-ID: <20250424002144.23260-1-beatrizvianacosta16@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate duplicated logic from zopt2201_write_scale_als_by_idx() and
zopt2201_write_scale_uvb_by_idx() into a new generic helper function
zopt2201_write_scale_by_idx(). This function takes an additional
parameter: a pointer to a zopt2201_scale array.

To support this, the previously anonymous and duplicated struct used in
the scale arrays was promoted to a named struct: zopt2201_scale.

This change also corrects an incorrect array access that existed in
zopt2201_write_scale_uvb_by_idx().

Signed-off-by: Beatriz Viana Costa <beatrizvianacosta16@gmail.com>
Co-developed-by: Gabriela Victor <gabevictor333@gmail.com>
Signed-off-by: Gabriela Victor <gabevictor333@gmail.com>
---
 drivers/iio/light/zopt2201.c | 42 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index 604be60e9..1e5e9bf29 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -113,11 +113,13 @@ static const struct {
 	{ 13,   3125 },
 };
 
-static const struct {
+struct zopt2201_scale {
 	unsigned int scale, uscale; /* scale factor as integer + micro */
 	u8 gain; /* gain register value */
 	u8 res; /* resolution register value */
-} zopt2201_scale_als[] = {
+};
+
+static struct zopt2201_scale zopt2201_scale_als[] = {
 	{ 19, 200000, 0, 5 },
 	{  6, 400000, 1, 5 },
 	{  3, 200000, 2, 5 },
@@ -142,11 +144,7 @@ static const struct {
 	{  0,   8333, 4, 0 },
 };
 
-static const struct {
-	unsigned int scale, uscale; /* scale factor as integer + micro */
-	u8 gain; /* gain register value */
-	u8 res; /* resolution register value */
-} zopt2201_scale_uvb[] = {
+static struct zopt2201_scale zopt2201_scale_uvb[] = {
 	{ 0, 460800, 0, 5 },
 	{ 0, 153600, 1, 5 },
 	{ 0,  76800, 2, 5 },
@@ -348,16 +346,17 @@ static int zopt2201_set_gain(struct zopt2201_data *data, u8 gain)
 	return 0;
 }
 
-static int zopt2201_write_scale_als_by_idx(struct zopt2201_data *data, int idx)
+static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
+				     struct zopt2201_scale *zopt2201_scale_array)
 {
 	int ret;
 
 	mutex_lock(&data->lock);
-	ret = zopt2201_set_resolution(data, zopt2201_scale_als[idx].res);
+	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
 	if (ret < 0)
 		goto unlock;
 
-	ret = zopt2201_set_gain(data, zopt2201_scale_als[idx].gain);
+	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
 
 unlock:
 	mutex_unlock(&data->lock);
@@ -371,29 +370,12 @@ static int zopt2201_write_scale_als(struct zopt2201_data *data,
 
 	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_als); i++)
 		if (val == zopt2201_scale_als[i].scale &&
-		    val2 == zopt2201_scale_als[i].uscale) {
-			return zopt2201_write_scale_als_by_idx(data, i);
-		}
+		    val2 == zopt2201_scale_als[i].uscale)
+			return zopt2201_write_scale_by_idx(data, i, zopt2201_scale_als);
 
 	return -EINVAL;
 }
 
-static int zopt2201_write_scale_uvb_by_idx(struct zopt2201_data *data, int idx)
-{
-	int ret;
-
-	mutex_lock(&data->lock);
-	ret = zopt2201_set_resolution(data, zopt2201_scale_als[idx].res);
-	if (ret < 0)
-		goto unlock;
-
-	ret = zopt2201_set_gain(data, zopt2201_scale_als[idx].gain);
-
-unlock:
-	mutex_unlock(&data->lock);
-	return ret;
-}
-
 static int zopt2201_write_scale_uvb(struct zopt2201_data *data,
 				     int val, int val2)
 {
@@ -402,7 +384,7 @@ static int zopt2201_write_scale_uvb(struct zopt2201_data *data,
 	for (i = 0; i < ARRAY_SIZE(zopt2201_scale_uvb); i++)
 		if (val == zopt2201_scale_uvb[i].scale &&
 		    val2 == zopt2201_scale_uvb[i].uscale)
-			return zopt2201_write_scale_uvb_by_idx(data, i);
+			return zopt2201_write_scale_by_idx(data, i, zopt2201_scale_uvb);
 
 	return -EINVAL;
 }
-- 
2.49.0


