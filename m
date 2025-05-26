Return-Path: <linux-iio+bounces-19940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C4AC3F09
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292E87A9B59
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261021FBEB3;
	Mon, 26 May 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXCatmv9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521A17CA1B
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748261095; cv=none; b=U1DEYeSrn+Tmfnfko6cDpUJkZfVupIwNShuhnQN5Rpo4wBSgu7kAz+ce2+vQvdSOVx6SADyevaVCxQ1T3gLOyfcsZeO/Vei9lamNM3wFvPKb0SAg+1Nx7nr8ttWaKQ11MdSlHpQFQa5ae//hqqpD9cRT7UcOphdEGao9diP/IFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748261095; c=relaxed/simple;
	bh=VjJO6SQpeyw+pyH1FXTbjhh98/koOqkeGtW+RTSUTmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UQkRFXBnbFfOfBjYGt258S25JpXNvy1spsaUqFJxxZ9kiidk+fMolHOwGGpDdX2AAzisNsEwi956+QbNzFjX+WWWjYdbeoKBy9neU93UrHEvBThY0mXKnpkVcxu/ruGJ8AeZ2uCSq/6EYnqt8DNz0i8BazKt57tb0n0rjMmXwZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXCatmv9; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-877d7fa49e0so1370258241.2
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748261093; x=1748865893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9ZQ8kVde9XqUB74n7bH8F4cibBjuup/aJuo/qRB6zI=;
        b=dXCatmv9B8KjaThoG7L9fAm3JocMLOdR2kl5Wu3q4qZf6f0EmxgZjKE9Pln38QNihO
         Z+71i7j2PVFhBL1zi1TnLBTZBkMzfKGx1+BR8CGcxfdENg5maF2yScCqNkLmiY39IMP4
         yBsT/Tyi9lph9Q6WHuqfdt08J3IsAcGuReYri0mN4z6ZtWDnbbHOZ6FQrQfIoeiK7NYN
         NyTHJexLEpFTx6yG2Gya00L/6/UhlBHS3rFCmP5yoJwBHqBT6jI3g1HYt8IxQKMWd86W
         BiEm8wpsXGlQDFMRvN+FhnH6HGGv9FsHnSP7jADjmJx2KkypDu5DFxc92LDyftzorGAV
         JvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748261093; x=1748865893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9ZQ8kVde9XqUB74n7bH8F4cibBjuup/aJuo/qRB6zI=;
        b=MGSIsilySl7M2ohvczG1ubUDLeONHLeMi7vSd8D7jTKJIXUh1k1OH6RDjqRtpk0QNg
         bYA24zbM8+QItlLpeuNlo+4NOYS7U6i/KdZ+5XeKmWo2N2c+ZNDMLUPm4pJx6HPhiJu+
         R3NsNGzmUhOl34ZyyX+e/Ee+GGgR0NdIb/Pw+fVqSFF9z/ik7qB+PeTlW52ZKUaUkcrX
         5Rf7UiFwZ5OzElJVvz5EtivA+FRjitx/y0jcHmcdV5S8ue+i5EEmQU0sk2EpsRi9mjy7
         JYf9zpPmAzFqajxi87gBtpB12+77sEChDzQ3W7yREmgjedKIFd0AeV07cFzaf9/i52ld
         +4/A==
X-Forwarded-Encrypted: i=1; AJvYcCV4Tnu/TDL8+92LdpYtB0WCzy2s7pdf/7gxOcMXOfa8oPtjZqtPSy2TtTTwLjR4IUwEfQ/+SYlAo4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOAgo5U7WNXkhU86yD9B89W1Y6kSVkKCswVqvAujDF503NGaj
	lcGTdZXwsR2pm8fbiDFMThOl0wG60pl2/IMsw31cvmEfRxLQhFYkLrcw
X-Gm-Gg: ASbGncvOfhMp76JuGJk5bnTMZl769zodg3v9VZ0kI0tzj3P3ZvoUKAY0f7KetUe+4/a
	pFCFowaQDbxb7qh1O8i30qcXUg/zWABFBZxbC6/VMqWlPcV9l5S168PJdMdqGylX8FrIZPct5dW
	Z8tur3VcG4ELPinvwty8jJu5EHZUKacT5cmaAMWPQQylN+CpsronvZAnI8ko+4tGwWtn07Ncuvh
	R1lrmYBpwniwMteNN0v3wHG1v2Q0nYNUZ9G8G9h1Vdch0S6G6yg3bXKKrCBjsYpcLBOyChfECWo
	G/CgR/8seWm5m9l4w6g8Ngt2D1iiMgcGQ/SBV1PlashRoQ==
X-Google-Smtp-Source: AGHT+IFvi+3Y7xUHSFZwrgtd4Kwwux1y7HFnaF7DAAZsck+3R2qDBZckeqFse/TL9mjwK2Y9yuD9JQ==
X-Received: by 2002:a05:6122:2207:b0:52a:863f:78dd with SMTP id 71dfb90a1353d-52f2c57fc1cmr6493401e0c.6.1748261092928;
        Mon, 26 May 2025 05:04:52 -0700 (PDT)
Received: from BMO.. ([2804:1b3:a780:dcf9:96bf:ac40:fe1:13a8])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba91072dsm17625682e0c.8.2025.05.26.05.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 05:04:52 -0700 (PDT)
From: Bianca <biancalvao@gmail.com>
To: jic23@kernel.org
Cc: juliacalixtorosa@usp.br,
	=?UTF-8?q?Bianca=20Costa=20Galv=C3=A3o?= <biancalvao@gmail.com>,
	=?UTF-8?q?Bianca=20Costa=20Galv=C3=A3o?= <biancagalvao@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: magnetometer: mmc35240: unify reg-access predicates
Date: Mon, 26 May 2025 09:03:30 -0300
Message-ID: <20250526120340.16880-1-biancalvao@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bianca Costa Galvão <biancalvao@gmail.com>

Refactor the two complementary helper functions
`mmc35240_is_volatile_reg()` and
`mmc35240_is_writeable_reg()` by implementing the volatile predicate
as the logical negation of the writeable predicate. This removes the
duplicate bit-mask checks and makes the intent clearer.

Changes since v1:
- Removed the obsolete mmc35240_reg_check() helper.
- Wrapped commit message and body to 75 columns.
- Fixed indentation in mmc35240_is_writeable_reg() to use tabs.

Signed-off-by: Bianca Costa Galvão <biancagalvao@usp.br>
Co-developed-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
Signed-off-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
---
 drivers/iio/magnetometer/mmc35240.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 07f58567e521..6cfb89295802 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -418,14 +418,16 @@ static const struct iio_info mmc35240_info = {
 	.attrs		= &mmc35240_attribute_group,
 };
 
-static bool mmc35240_reg_check(unsigned int reg)
-{
-	return reg == MMC35240_REG_CTRL0 || reg == MMC35240_REG_CTRL1;
-}
 
 static bool mmc35240_is_writeable_reg(struct device *dev, unsigned int reg)
 {
-	return mmc35240_reg_check(reg);
+	switch (reg) {
+	case MMC35240_REG_CTRL0:
+	case MMC35240_REG_CTRL1:
+		return true;
+	default:
+    	return false;
+	}
 }
 
 static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
@@ -447,7 +449,7 @@ static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
 
 static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
 {
-	return !mmc35240_reg_check(reg);
+	return !mmc35240_is_writeable_reg(dev, reg);
 }
 
 static const struct reg_default mmc35240_reg_defaults[] = {
-- 
2.43.0


