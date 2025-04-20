Return-Path: <linux-iio+bounces-18393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814DAA949E2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 00:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B123AC8A9
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 22:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3F61A5B9C;
	Sun, 20 Apr 2025 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKRKBns7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A051C5D62
	for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745187955; cv=none; b=C2BQyt8L5exffX/Lu58rA1Ktb1KkCligGQ96YiP3dimz2xpUcccFEbkpuwrH7NFqw+KHSjjjvEt56wFJlfi2LJJJQxu7YFHqieLI4RcaxHx49BHjvi5CAeLYur9D2Fl2xLZTmHCQ3ct68QgQ8ZFnjXsoS1ahdLjcaEgChpxX4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745187955; c=relaxed/simple;
	bh=Bkw7yhtoSl4ScK7JCPUMDDkbI9mSn6HrQGUi0qLyJsU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cBHLSKMXJIukECKmWASQQoeQ0W82s3e3JZqWI3U/cn7Ka2vKnLWyx96++kmjpPMvqXu53R2tJpfShLT9J1JlTz03Yy/ypB+PTK+D1rRfYHF1QF8Fu7D5z3ATR4GmrWxUJXQSfJdQO6hHsQobVo66dUrneFuKpGAqgXeCrYjXI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKRKBns7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22622ddcc35so50953885ad.2
        for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745187952; x=1745792752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/liOFjsH33+oYhswIVwxiHLCuQp5HYMUy0/Jw0RzCU=;
        b=mKRKBns74eJ1/Dh9Z8IZS27cheYSLLrxR3Co6kJ/NPJU14688imJf6/i8IDhHQyWNt
         W9mILdh/jWgIT2g69u5lw69LLy9QhXUFDfKESBwlVSbVVRi4WMKgUEv90k0JNI2LPCB2
         nfNI3l6NQ+j7uw7xCmfWs0cBBgzatE/WwyX0ijcgiFKfgYbr2NbP8UyzylYgC6J0S0co
         USNwgBu4fq0DS47y/hNcfhI3zbbmt19xSklDN8pN+jyjX4oAaCf8nysw3XWzyOlzhlUe
         xJpV3xzQcygZW17//6HIC11PAwt7PdvdQTt0AQYWTnTOHmutYGBQktmJnBjaVO/RrsUI
         jPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745187952; x=1745792752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/liOFjsH33+oYhswIVwxiHLCuQp5HYMUy0/Jw0RzCU=;
        b=ramxEDYw4YnHf7xsUTrCbESsa0adDwDUQvwBY8M1XXNFuYZ24VQ09/28xlV0Ii7oGX
         kCMLPqHsSHl1F6l/fin7fG4PRudDMNsfu4q9odc9KZEqdBtNKS65LavO+c6s2oNBjV+0
         ctjnwgUzp+xZE0C+QeT3vivvbHOYEXdQkrwt/5T1HjXtkT5ovH9W2EkyZeCao0UMjW4h
         k8JhhkJP9m7BvIvnzcsNRwLqevlNM+U1zhFyqapKl8YzuArDZoxseBp7BHLHhFoO0Ssy
         SZPn5k5YFIxsSI5yeDzbeqmflpu/r0LMQ+za2oRB1JM9uhTujHQB30vyI0madTNatTf8
         0EKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsBNO+FjtsrC3D4zr+qyRhSZzctf6Bza3nA8kpiUphdt0cwtZ16VYyjYBifHLjQeecECCRFmhq0Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8TFtDlF59OUo5hIMZam3Jzuctrl7rfQD9SoJIeU1NyVKX4+U
	ZsOvQud+Iiyr0MlGyFI3NZ9wsL20GhueWeN6F5lv7pLd3Lq48x3X
X-Gm-Gg: ASbGnctjTfTPIya8fPN1adrQ4SRPJxRFtuuHP42RRjeqlg/yhE+w+PD0BD+JpkQuBfI
	pzLI6UrvHHqrjDW6mgG6969ZDndgQCgHPmk+AJmi5+LMiB8x9D7BF8ERchaa+a/Ke+/UM+Uqzuh
	jERgoVWiek+3LPjDGiuY00llqHMXOKBWI4Mphv0f+JqDW8oId2A2X0u/Lq9ma/fpP3k9GrxQ2qV
	m098E/UmPTW4SPvRPANkwRiuXJKE2jSUyCXWYnCR/m4HVmsomh8+WQD16NRg4sFlTmXwYiRpA0d
	gKatAA8NAVhHYMrWV+PZ0AG/7zMFCNyBCydDKWPsEK3Zb493LiUycg==
X-Google-Smtp-Source: AGHT+IH+Sm9nBzM3qXD8G/B3+TKNNMRVt/Zl25HxYk3t79J8ar5mJiWjUkUEazFBrvRqe/lvTJX6uw==
X-Received: by 2002:a17:903:1a24:b0:220:f795:5f14 with SMTP id d9443c01a7336-22c535ca1dbmr147300595ad.27.1745187951824;
        Sun, 20 Apr 2025 15:25:51 -0700 (PDT)
Received: from localhost.localdomain ([189.29.180.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed0f7asm52596175ad.169.2025.04.20.15.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 15:25:51 -0700 (PDT)
From: Arthur Pilone <art.pilone@gmail.com>
X-Google-Original-From: Arthur Pilone <arthurpilone@usp.br>
To: jic23@kernel.org
Cc: marcelo.schmitt@analog.com,
	linux-iio@vger.kernel.org,
	bruno.stephan@usp.br,
	aschwarz@usp.br
Subject: [PATCH v2] iio: adc: ad7091r-base: Move reg volatility check to new macro
Date: Sun, 20 Apr 2025 19:25:12 -0300
Message-Id: <20250420222512.173029-1-arthurpilone@usp.br>
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

We chose to implement the test as the AD7091R_IS_READ_ONLY_REG
macro to remove the duplicate code without introducing new
function calls, which would be the case if we chose to fix the
duplicate code with one of the two following alternatives:

 A) Extracting a new function out of the test

 B) Rewriting ad7091r_writeable_reg to call
    ad7091r_volatile_reg or vice-versa.

Co-developed-by: Bruno Stephan <bruno.stephan@usp.br>
Signed-off-by: Bruno Stephan <bruno.stephan@usp.br>
Co-developed-by: Andre de Lima <aschwarz@usp.br>
Signed-off-by: Andre de Lima <aschwarz@usp.br>
Signed-off-by: Arthur Pilone <art.pilone@gmail.com>
---
V1->V2: Renamed macro and added clarifying comment

 drivers/iio/adc/ad7091r-base.c | 20 ++++++--------------
 drivers/iio/adc/ad7091r-base.h |  2 ++
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 931ff71b2888..e07614b70d12 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -375,25 +375,17 @@ EXPORT_SYMBOL_NS_GPL(ad7091r_probe, "IIO_AD7091R");
 
 bool ad7091r_writeable_reg(struct device *dev, unsigned int reg)
 {
-	switch (reg) {
-	case AD7091R_REG_RESULT:
-	case AD7091R_REG_ALERT:
-		return false;
-	default:
-		return true;
-	}
+	return !AD7091R_IS_READ_ONLY_REG(reg);
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
+	/*
+	 * The volatile ad7091r registers happen to be precisely the
+	 * two read-only registers.
+	 */
+	return AD7091R_IS_READ_ONLY_REG(reg);
 }
 EXPORT_SYMBOL_NS_GPL(ad7091r_volatile_reg, "IIO_AD7091R");
 
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 092ddea0f395..498923801ce1 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -17,6 +17,8 @@
 #define AD7091R_REG_CH_LOW_LIMIT(ch) ((ch) * 3 + 4)
 #define AD7091R_REG_CH_HIGH_LIMIT(ch) ((ch) * 3 + 5)
 #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
+#define AD7091R_IS_READ_ONLY_REG(reg)                              \
+		((reg) == AD7091R_REG_RESULT || (reg) == AD7091R_REG_ALERT)
 
 /* AD7091R_REG_RESULT */
 #define AD7091R5_REG_RESULT_CH_ID(x)	    (((x) >> 13) & 0x3)
-- 
2.25.1


