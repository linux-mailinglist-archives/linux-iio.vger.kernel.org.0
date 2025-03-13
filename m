Return-Path: <linux-iio+bounces-16804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D987A601A5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 20:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A2B880622
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9942D1F3D53;
	Thu, 13 Mar 2025 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2F24wbF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31191F3FD0;
	Thu, 13 Mar 2025 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741895695; cv=none; b=FyL5ZhekO0oAcQMSZUiBUkLvlbyfZxSJSMhzTSDiwZkYFTzkVmye5mztIRa1od9zIojjSzyj8+jY3XH/XaRO630VqnIGdFOlMdSIZAZ7rKYN4kj26RDyOUCjqyxVlS9DdL6CbFiEMsyhNngF/LU6l0YLikOP4/FTzrF/8OxYauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741895695; c=relaxed/simple;
	bh=OD+/u621mwUN73ktY519JVVMPBtMQmjjQicMrkJACVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrKvPjAcgYNFuv7CDXc4BVebJ/ozZqvt8vkVQ4VcwuUw3Oow14LuQmO6VsoOLB7EyC49gRb7GeJfdrcdmdgvL5VDi4TV9sJdLx3tEYx8Zt8M2sEFahBm2DhDtLMiTWfZkJxwM8+pwHoRmYbscAQJJ9N5JvmlQw6OgQxwHnHgSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2F24wbF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22355618fd9so29224285ad.3;
        Thu, 13 Mar 2025 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741895693; x=1742500493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wHH4myFoiuxDS6apQJvZG9O0Yk3Qnm1cC4Wjl8gE+b0=;
        b=T2F24wbFln/ZBk7Qfe+faMRbJFEkNXKNeqvinnooj8eHrXTVpi1ZY0rjfgFU/iHIDv
         7n1CovnE5qsq0QvTBt9dxpuLcn83oyHPmP6L34qwoadER7sVzlAZOMjcz7Mp9n14zDug
         aYwIuq6EDQc8M616a/IGbFXMZKT0XaU4AoVaROaA4txP823DXAqx9PyPLK9+ZecTiIDg
         8pyLU06CtI1uIXhCWzO4VeGC+XIDQpNpNdIWJDXnMQ9sy8LIxv2LxyW00YvPaQc0SB2g
         h5/+j7VqfbWPN8HgHgKoexgUlxa5x2sDbpMEY6wafAFbJGVI2c0YhtUpknIZIU2xDtbo
         DKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741895693; x=1742500493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHH4myFoiuxDS6apQJvZG9O0Yk3Qnm1cC4Wjl8gE+b0=;
        b=EzcyEe1YZbYvq6k5Q84apybrCt1l4vvA2WA4+PaWpieMRfrgWGpCxQG8KS9w6h0wlX
         VuJBs8IWpy1C/DKgVlFt+3bUWMuf1DINb7R8tq5RTbVhFHr0/+GORYRWPZaRHfGdFSSU
         aY5mhF+f2RhYyVkGXq+pBVxNRJkA7XtalI32dq0k2JVaOliwEP5o2ZuoPR4+TQyH+lHO
         Kd+5WXqDCKx2y2sIpHOEYtVmXg5tOB58HBceZLxwfYRcYRZParHdtQiBOWY4c66xUNZZ
         wd2DE0Hej0Y/30xuYjTTPArG11+8oxUbFO7cml0owyF5f91I6uANtCjOZUiPcJWI0Jn8
         ivTg==
X-Gm-Message-State: AOJu0YxYeRpcWSM8t73koGW9jC34h/5wtV+65+a8rg4xEdOmE+nabngK
	f0yjuwARH8pWCPIOBEJ355/07IyGDl1fxkEfqStZsOuYJnFSgFQWrN3teanU1xQ=
X-Gm-Gg: ASbGnctB2DxCh1AFT8Y7MxHwBZX/Ya2yC4R+nnfiwFYHDk6L32UE+SoIIp9tJk2Wc4y
	bJwDprC/QKNoHKz8xkIOcqAqzP3mUXwjJaphMio/Do6izKerNH1d6i/Xg3iyDWzRVGEtzFa/ZdI
	Zncqo8NU72fwZPzOvTXZ57pW6WfI2VnAhndJuW8OM1N4y+2YtlfR1Zf3p7HUJAtpY7wFHRAhp/6
	CUQHL8A+1xbPYup99WSTYBN+iJKoDkBME98TxZZ54gnQc12C85BIu6wDyHLgcl9bzVuSeYv1Y1S
	eRf+jC5xE55BJ3CxQfaGGHQF1bNKnlGV9HqbHJ9PaQ==
X-Google-Smtp-Source: AGHT+IGYW/k2YlFAjqkFNaFWxXE5BZL1uTyV8DQEqt8Utpg9j1U75c1XYijGakd2K6eWuDEhHRwpRg==
X-Received: by 2002:a17:903:1b03:b0:215:4a4e:9262 with SMTP id d9443c01a7336-225df2d700emr3225495ad.8.1741895693013;
        Thu, 13 Mar 2025 12:54:53 -0700 (PDT)
Received: from fedora.. ([2409:40f2:357:8702:7d06:7e16:a88a:f1b5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6c76sm17397275ad.148.2025.03.13.12.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:54:52 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Siddharth Menon <simeddon@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH] iio: frequency: ad9832: Use FIELD_PREP macro to set bit fields
Date: Fri, 14 Mar 2025 01:24:17 +0530
Message-ID: <20250313195442.30264-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor code to use the FIELD_PREP macro for setting bit fields
instead of manual bit manipulation.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 39 ++++++++++++++------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 140ee4f9c137..bbde1f0e84ff 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -70,6 +70,9 @@
 #define AD9832_FREQ_BITS	32
 #define AD9832_PHASE_BITS	12
 #define RES_MASK(bits)		((1 << (bits)) - 1)
+#define DATA_MASK       0xFF
+#define CMD_MASK        (0xF << CMD_SHIFT)
+#define ADD_MASK        (0xF << ADD_SHIFT)
 
 /**
  * struct ad9832_state - driver instance specific data
@@ -139,18 +142,18 @@ static int ad9832_write_frequency(struct ad9832_state *st,
 
 	regval = ad9832_calc_freqreg(clk_freq, fout);
 
-	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
-					(addr << ADD_SHIFT) |
-					((regval >> 24) & 0xFF));
-	st->freq_data[1] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
-					((addr - 1) << ADD_SHIFT) |
-					((regval >> 16) & 0xFF));
-	st->freq_data[2] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
-					((addr - 2) << ADD_SHIFT) |
-					((regval >> 8) & 0xFF));
-	st->freq_data[3] = cpu_to_be16((AD9832_CMD_FRE16BITSW << CMD_SHIFT) |
-					((addr - 3) << ADD_SHIFT) |
-					((regval >> 0) & 0xFF));
+	st->freq_data[0] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
+					FIELD_PREP(ADD_MASK, addr) |
+					FIELD_PREP(DATA_MASK, (regval >> 24) & 0xFF));
+	st->freq_data[1] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE16BITSW) |
+					FIELD_PREP(ADD_MASK, (addr - 1)) |
+					FIELD_PREP(DATA_MASK, (regval >> 16) & 0xFF));
+	st->freq_data[2] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE8BITSW) |
+					FIELD_PREP(ADD_MASK, (addr - 2)) |
+					FIELD_PREP(DATA_MASK, (regval >> 8) & 0xFF));
+	st->freq_data[3] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_FRE16BITSW) |
+					FIELD_PREP(ADD_MASK, (addr - 3)) |
+					FIELD_PREP(DATA_MASK, (regval >> 0) & 0xFF));
 
 	return spi_sync(st->spi, &st->freq_msg);
 }
@@ -161,12 +164,12 @@ static int ad9832_write_phase(struct ad9832_state *st,
 	if (phase >= BIT(AD9832_PHASE_BITS))
 		return -EINVAL;
 
-	st->phase_data[0] = cpu_to_be16((AD9832_CMD_PHA8BITSW << CMD_SHIFT) |
-					(addr << ADD_SHIFT) |
-					((phase >> 8) & 0xFF));
-	st->phase_data[1] = cpu_to_be16((AD9832_CMD_PHA16BITSW << CMD_SHIFT) |
-					((addr - 1) << ADD_SHIFT) |
-					(phase & 0xFF));
+	st->phase_data[0] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_PHA8BITSW) |
+					FIELD_PREP(ADD_MASK, addr) |
+					FIELD_PREP(DATA_MASK, (phase >> 8) & 0xFF));
+	st->phase_data[1] = cpu_to_be16(FIELD_PREP(CMD_MASK, AD9832_CMD_PHA16BITSW) |
+					FIELD_PREP(ADD_MASK, (addr - 1)) |
+					FIELD_PREP(DATA_MASK, phase & 0xFF));
 
 	return spi_sync(st->spi, &st->phase_msg);
 }
-- 
2.48.1


