Return-Path: <linux-iio+bounces-18333-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BBA9446C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0B6178E55
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523941DF256;
	Sat, 19 Apr 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ2cEzGf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855B1DE4E5
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745079263; cv=none; b=naHPkBzDhuo6Pz0rnuuzpNUy2M+CgbugDO+9omyMnaovzjurdekil7QxUp/PykC2yMRAu7CauybRXAZMlAGGraVD+TTNDNFDMH4+gyIo8ZjvuRHeH9Mi/OAzA047UWIG48JCm2AltYjW0g/0Ef4A6QK0gAUGS50RlX28ohtlUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745079263; c=relaxed/simple;
	bh=IqiMu7YC17Lgt4E6uUr0rp6mPPD9U/CjzIV1cwhY6uU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r+4M1LyrgrRUsNlHSFqXXsiAuD1Fbk+cvB3yVNi42Vk0+Gb3LvJkREj7tWHClkJ32rvpicW2Gd4LfOx+ZfhytPY7uFiE9+EV0S5+tOmzUirWfKwjxQK+wVac4U4+IjrjIjd4knu/vJ4PZ/9GwgjwAW/4iX8BD036MWKPSg8LoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ2cEzGf; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b061a775ac3so2450951a12.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745079260; x=1745684060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgLpy7x281g1iO75zYPekM3jASoc21AtZP2QINdIb7I=;
        b=aJ2cEzGfmrjzLtTXq9pPJv3xgJBbIFJ4J9agZV5pNVzw7ZOcFzlXAHwZaTFVJIPtB8
         4QojBO2kiaCL/h3A3JGnyOgmyx/LI8DZIyAYTBSu1mhb1l2/rvmmbZWFlndUPyQDyzcP
         caiXdyAHyjD+GOTm3Cl2PyVYlD5C7jXvFhzKKF8SWxkq0f0CmfFiPdQiLbvS+YOwAHab
         fWsW373NVj2BIAZVaPNTk0BU1aMKAjMCyLNjw4Aaw+VvanXhXpGo9kR2nBNe4nn3lXPD
         9tipXrLzuUfGgjEXgtGBAa5iFUdbQnSn7kjAHytxd6qGGvXgRM24R8j3XWfOR2p7c7sG
         aBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745079260; x=1745684060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgLpy7x281g1iO75zYPekM3jASoc21AtZP2QINdIb7I=;
        b=rlWqmO7pgIOkcMcJ2asvYXMwv4jfDtHja+y4tBL27z9IG6eHQPydnF9sSyw7GEt8Rc
         IoiI0Rak4HGi/STnJJDVpV0syoXF0ADk7aFBkpT2t+Gy6lMi8L+eVttXudqmnOHF+jvz
         Hxhl3y/TTGMCjf/yScFgU5IV8hBWUi1xCwTrrOBHgTZPuHtwI9S4MdFI3R8wAOiUz+dq
         nockFt9dsW1EBArNUYBq6YHSfeMPnOr5gBPwmVU5i0qtxeMTQBLcaaOKP6iE+JfXrui4
         Vs4T5L5c6Qja8kbR498gWCLLxH/4g+lA4fB4HJdn2KpEbagekiTkeRLavLNm1IlZU9A0
         6xOA==
X-Forwarded-Encrypted: i=1; AJvYcCXdZMU5HPbPO499H1JL+nzIovkH+5wWh0xfB/an2IyiwLpkQTo4uxaKSJXaoTdYdBrbyQIEV+SrlH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/vFlbtPC6gkcKCnI+yYgmAhbjR0syy0IOnNGakKzTqHnqXC9l
	aRqex0zb1aEjkcEhDOKb4aupZ9UQBPWnheFjrjQt6QsPFf3kx2O9
X-Gm-Gg: ASbGncvrZiFfLtA4anE6aLisa8A720PYbfgIEKklUNwPs51W4jJU8M/t/jNeXs0bwZY
	Mbn2ZJHli0xeXptX4diW8mN1gdn00rOdaNXgYt+6b9vxqJyqlR6L4epyN79DHle+pWO6aC6ltVA
	F7HjeRmBWPoejFGCzT8fqBUYSBC0Bib70F+WVohwKVWlZcBtmHFZyjDMpQgfSZ5s9CUGJ1KNBvl
	CbXCASWScXYghF1Kr//8c/DElUVRgXiTQqTnirm9M4zRA43AX/uOvYVX5WffLNSQIvC0WSQnUlf
	/o/jDsGPFI8r1whzjo+66ARPhPgENZ25/pit8s2O3gTIIiYdIFyWR0IR
X-Google-Smtp-Source: AGHT+IE7By1CGYzBCsI+T4oYOpOrtWImaDt5VSkF2cmNIwFHG4a2mAxuGewbYaAA7DEHMSAnyGj/Uw==
X-Received: by 2002:a17:90b:3885:b0:2ff:6aa6:47a3 with SMTP id 98e67ed59e1d1-3087bbad709mr9120684a91.25.1745079260526;
        Sat, 19 Apr 2025 09:14:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:7840:8465:46a5:d3e1:8cc2:6823])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df097aasm3243195a91.11.2025.04.19.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 09:14:20 -0700 (PDT)
From: Arthur Pilone <art.pilone@gmail.com>
X-Google-Original-From: Arthur Pilone <arthurpilone@usp.br>
To: jic23@kernel.org
Cc: marcelo.schmitt@analog.com,
	linux-iio@vger.kernel.org,
	arthurpilone@usp.br,
	bruno.stephan@usp.br,
	aschwarz@usp.br
Subject: [PATCH v1] iio: adc: ad7091r-base: Move reg volatility check to new macro
Date: Sat, 19 Apr 2025 13:13:47 -0300
Message-Id: <20250419161347.28157-1-arthurpilone@usp.br>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arthur Pilone <art.pilone@gmail.com>

Both ad7091r_writeable_reg() and ad7091r_volatile_reg() perform the
same test, checking whether a given 'reg' code is
AD7091R_REG_RESULT or AD7091R_REG_ALERT. While ad7091r_volatile_reg
returned true, ad7091r_writeable_reg returned false for the same
condition. As such, both functions introduced duplicate code.

We chose to implement the test as the AD7091R_IS_VOLATILE_REG
macro to remove the duplicate code without introducing new
function calls, which would be the case if we chose to fix the
duplicate code with one of the two following alternatives:

 A) Extracting a new function out of the test

 B) Rewriting ad7091r_writeable_reg to call
    ad7091r_volatile_reg or vice-versa.

Signed-off-by: Arthur Pilone <art.pilone@gmail.com>
Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
Co-developed-by: Andre de Lima <aschwarz@usp.br>
Signed-off-by: Andre de Lima <aschwarz@usp.br>
---
 drivers/iio/adc/ad7091r-base.c | 16 ++--------------
 drivers/iio/adc/ad7091r-base.h |  2 ++
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 931ff71b2888..8329552f0be8 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -375,25 +375,13 @@ EXPORT_SYMBOL_NS_GPL(ad7091r_probe, "IIO_AD7091R");
 
 bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case AD7091R_REG_RESULT:
-	case AD7091R_REG_ALERT:
-		return false;
-	default:
-		return true;
-	}
+	return !AD7091R_IS_VOLATILE_REG(reg);
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, "IIO_AD7091R");
 
 bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case AD7091R_REG_RESULT:
-	case AD7091R_REG_ALERT:
-		return true;
-	default:
-		return false;
-	}
+	return AD7091R_IS_VOLATILE_REG(reg);
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, "IIO_AD7091R");
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 092ddea0f395..1b4e0ef43260 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -17,6 +17,8 @@
 #define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
 #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
 #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
+#define AD7091R_IS_VOLATILE_REG(reg) (reg == AD7091R_REG_RESULT \
+	|| reg == AD7091R_REG_ALERT)
 
 /* AD7091R_REG_RESULT */
 #define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
-- 
2.25.1


