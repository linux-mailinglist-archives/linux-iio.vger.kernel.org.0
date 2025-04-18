Return-Path: <linux-iio+bounces-18283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78EA93C94
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739C2462504
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F819221727;
	Fri, 18 Apr 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjLaz+3s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02F86328;
	Fri, 18 Apr 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999831; cv=none; b=n4YUJ+gMhxYJ1/cmVKVQoziDGeb9S9bboG/07xfsmWAn50maEGxWZkD8pxSIXn1KuuywVYriLUdCY2ZuLgG4Q/yaCe+v/bS0BY+sUJ2HRI/IPwyYp0ZTZAH3K8Xz42orkslNp9Ucs0FVspEOqm3n4QP/Pz/NJUpJUYkdITvip4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999831; c=relaxed/simple;
	bh=9ZRRBmP35YDeEvdiRaqD0aVC5eFr/liuptTJInPwCXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxbgICurxZvT3x6t+T8s6qg3yL6xlP7aqgSGu2m6tm9Kpc6rpoR7noemsVI/ep275ky2VYEkxfEZjKlzjFhM1IZ2/hZxg3KTMZ8Wl0K1sJW/LrwqxMFemd0SleFWi4JtAc1o4qClt77F99aimWezV8ALJTyWVLIktBpPSRARHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjLaz+3s; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5568355ffso164899585a.0;
        Fri, 18 Apr 2025 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744999828; x=1745604628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PK2Oi/ee+iINPgVMxjWp3y2/EKu796w7pqlWlNAZafc=;
        b=QjLaz+3s3tEUMFi1WlHxE2wTY3vCJrVp34ZzYxYEdhtJ+Bc4EUHwDjPQlR4qGN0ABv
         c8COBJcbX0q6LDwdHEkyToA7izvtxrBgk0ygvUBGVGGW+fzr7/cTWIpoDOeYznSX3eUn
         /qtgsJ5TtTXrBS+Ss5Axs8ija9Pa/Ysh2NnTbafalYnUvBF57Or6JIf8jbu/dZhTFqHa
         aDUPz9lZtm+TNGIlr8gcwLImhTEUPtdTsAvD9DD5S51m4fCmA6g42N6S/mhEk5B7kphL
         aHa0cTogzcl3NZF2ylaaXa/wM11D/ba4dae5GcgsO45K/rBDgkUDtiarDhnJGUbQQnEy
         QlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744999828; x=1745604628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PK2Oi/ee+iINPgVMxjWp3y2/EKu796w7pqlWlNAZafc=;
        b=Fd9Yi3FZtbCkocU3S+czfUFbMxNeVWCi3ECfYYuHw0COQk4ombZtQGb65tjhlVpCC7
         DaR5acUgNdG1VFg7lXdCgghu55o+Jt2xM4mGSNcujYhYKY+5vXsx8PWlFfday6nihYRF
         EiWuvM9Mbzw6FFXJ0x+rJw5i1r2OkXpzl8R23DcdALucX10idfq4KUnUnQ7/DrgKPIpI
         BTPVwXeR/CXZUbKdmwhgF59TC8jNbvPBlugn0yWPYbAd4+7bwgUGOx7DLerTRD602Sfa
         O/rpD2Hxqu5aAAwzi67vB9nC6epFhppN+SRPrtv/zTAbLSuQFG3N2cQtNfHVEFzSS4je
         wsbw==
X-Forwarded-Encrypted: i=1; AJvYcCUaTK7NFYNjdxb48XJ2WE4NrG3urKd8kH7YV5KX2Oa2PKvzeBgNml8XRF394XtKX+ctiWNC9jMC@vger.kernel.org, AJvYcCWNGxKLHd2i3mXjpqpm2UIBLO81vgPB5U4qmp1AxVX8GFyMP7zDu2LLhxbz+gICeDTrfBNDU2aHdY8=@vger.kernel.org, AJvYcCXHKGoxVbXVxQ12Dl22vVKeixo7ff2ugtvzaJmIVuo21bvS7cgz03bDTvVz5O17zgqJ1xDQbLDZWq9PSNYu@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwYrMPRhseAllRcMByuTkRn8NDrxG4wt4yigxr/2HbW1z7d7B
	6aM2me5n8N3Xd9TCxKlGX06h8CgxwaHsSMxdpa98nxvpBkEb58tm
X-Gm-Gg: ASbGncu7el2yKcsKjEdulWxYVH6yP8nDe5jUlDuKgZ8xrw/W6rspX6yaU0FiDJ+loVG
	NrCjhtWbfXBFbw4sj4TsG7pUyxrhw8+KSanTzfWazwW3V4dPt1fzkb1V3ktevS3RVMU07dGLULM
	Xu836fgIBxyix0bdQjoTE+PPEqr3lXPQaZfkK22TgHfpBLAjlZySg+W4TmwqZXHG7Bk3tRR7YO+
	B1xIrCpvWA5rS4VeH1e/WEm59QCLEhTR3zVootiCBM+CRKva6Jwyd8AabLdbWibwapkei7GUjcH
	31bfAnsO5+/LtwSEKYMRj8FZOxiedtFKjUbQyU9tBMPLttGDyYuETurMYilWR1komfswiNkI2zD
	/S5afEVAlsyVOtSSmRnc=
X-Google-Smtp-Source: AGHT+IE/sV4GWQYZQwrKke9IVMnhly37KO4yL4QVNUy4azKV9PCYCbwiFnSk8+IqQ1Wi+sNAZppQ5Q==
X-Received: by 2002:a05:620a:1a8c:b0:7c5:5206:5823 with SMTP id af79cd13be357-7c927fb506dmr495158585a.29.1744999828081;
        Fri, 18 Apr 2025 11:10:28 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9d9sm131832785a.27.2025.04.18.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:10:27 -0700 (PDT)
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
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: ad5933: Correct settling cycles encoding per datasheet
Date: Fri, 18 Apr 2025 14:10:25 -0400
Message-ID: <20250418181025.637710-1-gshahrouzi@gmail.com>
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
Changes in v2:
	- Fix spacing in comment around '+'.
	- Define mask and values for settling cycle multipliers.
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d5544fc2fe989..3c301a8ebd2ab 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -28,7 +28,7 @@
 #define AD5933_REG_FREQ_START		0x82	/* R/W, 3 bytes */
 #define AD5933_REG_FREQ_INC		0x85	/* R/W, 3 bytes */
 #define AD5933_REG_INC_NUM		0x88	/* R/W, 2 bytes, 9 bit */
-#define AD5933_REG_SETTLING_CYCLES	0x8A	/* R/W, 2 bytes */
+#define AD5933_REG_SETTLING_CYCLES	0x8A	/* R/W, 2 bytes, 11 + 2 bit */
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
@@ -82,6 +84,12 @@
 #define AD5933_POLL_TIME_ms		10
 #define AD5933_INIT_EXCITATION_TIME_ms	100
 
+/* Settling cycles multiplier bits D10, D9 */
+#define AD5933_SETTLE_MUL_MASK		(BIT(10) | BIT(9))
+#define AD5933_SETTLE_MUL_1X		0
+#define AD5933_SETTLE_MUL_2X		BIT(9)
+#define AD5933_SETTLE_MUL_4X		(BIT(10) | BIT(9))
+
 struct ad5933_state {
 	struct i2c_client		*client;
 	struct clk			*mclk;
@@ -411,14 +419,15 @@ static ssize_t ad5933_store(struct device *dev,
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
@@ -426,7 +435,7 @@ static ssize_t ad5933_store(struct device *dev,
 				       2, (u8 *)&dat);
 		break;
 	case AD5933_FREQ_POINTS:
-		val = clamp(val, (u16)0, (u16)511);
+		val = clamp(val, (u16)0, (u16)AD5933_MAX_FREQ_POINTS);
 		st->freq_points = val;
 
 		dat = cpu_to_be16(val);
-- 
2.43.0


