Return-Path: <linux-iio+bounces-18172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30142A9064F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 16:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B42E188E47C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA46E1D89FA;
	Wed, 16 Apr 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6ubCROK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BA1C5D67;
	Wed, 16 Apr 2025 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813361; cv=none; b=uVgavE4ScMLjuiiK7KYaiKhsnZ7ZMT5LsGy6mGv5aY5NME1u+j8WHGO2wJNbHmG/k2vBz/eD2cauE7bO1dlp83XgU4yXrJOlBIbSfeIUZLiCTAmrQGY1vISHNAQkshn1det5S/Hkk8RGrQKYBOXeQaFpZrcaSlLBzqL3tzt2olI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813361; c=relaxed/simple;
	bh=XZsuHRStzxgMBNJSgZNeSiXFlRaHY2fp/H0igW2RWPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ4bKz862rIRtf7+Z8dBZxBu59j7verGGnP1slZwuoJ5d6PBtUziYvULCOoQ6xXnPK79rO7p1ItOyC12ThXOjqLFhmJqYu2KXOQ1mPmvlxcrH3F9ftFBh/EIL1iCzK3AAT4I9jQ/BnVCg70Ip1pbWCe+h8+kwueM4fd7vadiwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6ubCROK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4769f3e19a9so42883121cf.0;
        Wed, 16 Apr 2025 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744813359; x=1745418159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvGQzRQZa4QQ8HT7sQpSMDihfEbd4TOYSrjVJqZvxUo=;
        b=R6ubCROK3G/0Wt0/HXMZHC7uA6m6Vi/GB6MclK9pQn33WgpxLojGIpukIRe3du8Xcc
         yIdVA+VazsT9PPJu/sCkkcxXa573qSidBPtt7GK9ifE7G42lXXShwsUF9YZVVxZb51jL
         dIf4ZynXPPpY4HBVhTrC6x5FPOfJRP5lmczmZ3BQwo1fo05EcNJr6I+ohvSf1IueVOdo
         VNSjIhrHgUiUP/HdiyzTKDOTjUCG6qY+c+7dy6j6XNwQk+C0FILig0CN8HySr2d1WLX3
         K0lMzRUk/ybX9lGeLCvazhJSJuMaCFagXjm8x4YMVU2lJr+Y8JmMFfXn1tloeUHfOFWS
         3jOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744813359; x=1745418159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvGQzRQZa4QQ8HT7sQpSMDihfEbd4TOYSrjVJqZvxUo=;
        b=ptcCW9jFjEKH3Cq+I2tlRUExk7JCxGtxiwO9fNPHFCiBIfJN5G0ZWa7ZqewpzgrRwi
         Zf9Wug3nbomxUTib++S8Htm++2Zw/MxtPRz5jAdHgiCohWeXVS8gePEqZ6Bwlir8d4XH
         VbmC73RapWrtSrP+q9Umxoaaqn55Xiau4yPTwsNwns8eUNHnHfVxLml/j16SeMhGesZo
         loHMXxMwRkyuxB/l8pZTRRcI0CQRlQCAgyzdvC0V6qBwOpS6v3yhu5cSkSE8aQz+d5Os
         r+1+0Wt+ote9D/DA5jMd7tLwT4i05hdr4KP3ujbY22ZPynoKzq00v3PetBf5GeQ5PTve
         offA==
X-Forwarded-Encrypted: i=1; AJvYcCUR+08nV6JZVlNsaleOH+GNGQcG1cPJNBncBZuIK8RkNioiOKWM7FhsTeRzlWBTlh2wXwjmCRZHUJeGbGZV@vger.kernel.org, AJvYcCWZ+o3K0sKuvO6UgVikwivaYtqC/Y12i/jI5kj0T0B+L19+OzTxtKVGviZpJOaXTMvmRe6lUheQ/TQ=@vger.kernel.org, AJvYcCWh+1/+s7jzfiBA7JmxVf/nF5gWRapOUfhcjc2mrHWP30iTg8xcRtohOJUO237oPzwVHwDlijnz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg41NKv8VP9LiTUrfIm1hwREOiUle5mnXf//Sz6o6OEtiFEFCf
	vP7seHb3uWuLvEICjHcYWNp8fREGKKJ+/M3j8Dbyx+T/b/Rk9Zzb
X-Gm-Gg: ASbGncvBVFl1IyRBkplVEks5AggN1F4EnAGxGAX/OQQNq+dXQUF8NjkEE3sxua83Bi/
	PwrjXsiSgs+0qn6jwshb57TXtnrEWpVR+CLyUfSTKFQkLPLT/V0Kl2ze9miYf5c1JbTmhllcvId
	Z8fPcCBlmlGg3EeY9xzAZTXjxkhL0GSKTb3uBVHw0529fkdyJA/nnzm2qt2ZJhWMYqlPhQm7kj+
	fw9u7/Uc061lDjY389WQelIhMYRmEVgB9URMxl8PMEkGXwGA3CI+sVMqqMrFn4t8S0q05Q+QSgw
	0RTeiOJ/UgaRwNWkORhd6PiLExbZcgnrEGhE7vACcn82K3ulSbpTqlOZYDvYnCsUGlqCAa3Zu6d
	KdP8OsYVSWEduRlj1FGw=
X-Google-Smtp-Source: AGHT+IEcAZ9IgLpYeEER0BEL2UCmb2z3SLd7boWdJice9lo1bjTqV2QSQw7nCpJwiFqqE8SK51WOGA==
X-Received: by 2002:ac8:59c6:0:b0:477:704a:a580 with SMTP id d75a77b69052e-47ad80b41b5mr34553521cf.13.1744813358827;
        Wed, 16 Apr 2025 07:22:38 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796edc20aesm108741971cf.78.2025.04.16.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:22:38 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	kernelmentees@lists.linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: ad5933: Correct settling cycles encoding per datasheet
Date: Wed, 16 Apr 2025 10:22:19 -0400
Message-ID: <20250416142219.554938-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the settling cycles encoding as specified in the AD5933
datasheet, Table 13 ("Number of Settling Times Cycles Register"). The
previous logic did not correctly translate the user-requested effective
cycle count into the required 9-bit base + 2-bit multiplier format
(D10..D0) for values exceeding 511.

Clamp the user input for out_altvoltage0_settling_cycles to the
maximum effective value of 2044 cycles (511 * 4x multiplier).

Fixes: f94aa354d676 ("iio: impedance-analyzer: New driver for AD5933/4 Impedance Converter, Network Analyzer")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d5544fc2fe989..5a8c5039bb159 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -28,7 +28,7 @@
 #define AD5933_REG_FREQ_START		0x82	/* R/W, 3 bytes */
 #define AD5933_REG_FREQ_INC		0x85	/* R/W, 3 bytes */
 #define AD5933_REG_INC_NUM		0x88	/* R/W, 2 bytes, 9 bit */
-#define AD5933_REG_SETTLING_CYCLES	0x8A	/* R/W, 2 bytes */
+#define AD5933_REG_SETTLING_CYCLES	0x8A	/* R/W, 2 bytes, 11+2 bit */
 #define AD5933_REG_STATUS		0x8F	/* R, 1 byte */
 #define AD5933_REG_TEMP_DATA		0x92	/* R, 2 bytes*/
 #define AD5933_REG_REAL_DATA		0x94	/* R, 2 bytes*/
@@ -71,6 +71,8 @@
 #define AD5933_INT_OSC_FREQ_Hz		16776000
 #define AD5933_MAX_OUTPUT_FREQ_Hz	100000
 #define AD5933_MAX_RETRIES		100
+#define AD5933_MAX_FREQ_POINTS		511
+#define AD5933_MAX_SETTLING_CYCLES	2044 /* 511 * 4 */
 
 #define AD5933_OUT_RANGE		1
 #define AD5933_OUT_RANGE_AVAIL		2
@@ -82,6 +84,10 @@
 #define AD5933_POLL_TIME_ms		10
 #define AD5933_INIT_EXCITATION_TIME_ms	100
 
+/* Settling cycles multiplier bits D10, D9 */
+#define AD5933_SETTLE_MUL_2X		BIT(9)
+#define AD5933_SETTLE_MUL_4X		(BIT(9) | BIT(10))
+
 struct ad5933_state {
 	struct i2c_client		*client;
 	struct clk			*mclk;
@@ -411,14 +417,15 @@ static ssize_t ad5933_store(struct device *dev,
 		ret = ad5933_cmd(st, 0);
 		break;
 	case AD5933_OUT_SETTLING_CYCLES:
-		val = clamp(val, (u16)0, (u16)0x7FF);
+		val = clamp(val, (u16)0, (u16)AD5933_MAX_SETTLING_CYCLES);
 		st->settling_cycles = val;
 
-		/* 2x, 4x handling, see datasheet */
+		/* Encode value for register: D10..D0 */
+		/* Datasheet Table 13: If cycles > 1022 -> val/4, set bits D10=1, D9=1 */
 		if (val > 1022)
-			val = (val >> 2) | (3 << 9);
-		else if (val > 511)
-			val = (val >> 1) | BIT(9);
+			val = (val >> 2) | AD5933_SETTLE_MUL_4X;
+		else if (val > 511) /* Datasheet: If cycles > 511 -> val/2, set bit D9=1 */
+			val = (val >> 1) | AD5933_SETTLE_MUL_2X;
 
 		dat = cpu_to_be16(val);
 		ret = ad5933_i2c_write(st->client,
@@ -426,7 +433,7 @@ static ssize_t ad5933_store(struct device *dev,
 				       2, (u8 *)&dat);
 		break;
 	case AD5933_FREQ_POINTS:
-		val = clamp(val, (u16)0, (u16)511);
+		val = clamp(val, (u16)0, (u16)AD5933_MAX_FREQ_POINTS);
 		st->freq_points = val;
 
 		dat = cpu_to_be16(val);
-- 
2.43.0


