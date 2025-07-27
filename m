Return-Path: <linux-iio+bounces-22069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C74B131DB
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F049189429A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5DE23C4FB;
	Sun, 27 Jul 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX5nlv7y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A422AE75;
	Sun, 27 Jul 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650026; cv=none; b=MA21gF8FhD8GrRFdaqpzchj1prA3aPXGRRGSXNbMq0TrExj5HpALq04aFfqy4LGBh2iEX6JKNMWk4p53njDBdZ39UNctOtAacuv1nE83IXAJjDx8DdK8/Z6dEvczWga87doGIX7ROSXY6f5A1jSJkol2ilOyekbGxTGCnCCpFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650026; c=relaxed/simple;
	bh=m+P73JftgEr1WeCVpefHn8qdg3j6q13UNkNZ6IwSGF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCIVnwCrKMw89vu5PcOPj3fy5qnz8cOdd0RpGI5i3utaeTM/goInTYUZdnKIIseiwb3plksNDax7Zr/KKZQWyboUPiqKIKzdPj3f6VfheYB/+e4olEYt0ylS3taa7EpEQsyq/o779Qfrn4dTbU+iNq52nP9Bb+aTlOGeV/3zFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX5nlv7y; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61351378f26so764348a12.1;
        Sun, 27 Jul 2025 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753650023; x=1754254823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aquYZnqOuOuWs6cabqPxs9p2uRSIKwm1CvFd1mU/Hs=;
        b=BX5nlv7yI6TCZpBGGvkajr0VgOumXUSFLX2xQIEb29sZCGlpi+cFhPjpiAJNdS9wav
         fzDAOGgmp1KRQBHlGvdI1Kw/1UK5cjpTBSlSxakXJgfIU5poAlFXC3+dFmFfoTylOn5d
         QvYWdlaNB6UqJg4pNHFxlMlBWhpfXY1wmU/HmrrDsY9ZI2Uzz+pD+52cDxZwKcpMkRMN
         KGbLYA7O9VuOw46gSzx//DmOj6ob2BLkZKY2e69TzZKQPhGe4Uxo77sqghOsqt/ypYA/
         PtI7mGKHrebJ3SklBizEpHRLSkusOtPhM3MRihAgEG7ltmziE7uLCclhGo9Qw1n2mk4R
         BHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753650023; x=1754254823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aquYZnqOuOuWs6cabqPxs9p2uRSIKwm1CvFd1mU/Hs=;
        b=vtA3olPxF93TV9+NbN3RV/QGXnIDva6eDPZrdTZcseZZk0pxv8//9NYAiBQN4r045O
         3R75LO+yk9ntGFpwnkRUQ/cvwgyxcIgVL07Ciumhcgaz881M4+rPWqSx+0T9rgoyK8oj
         kgV2TbYi55wmHn6s9/OtZXwUSreIkb3en0l8jJHWwLZ2CSG3tWIKIFsn1nGKOastaqru
         9Tl9Eu6bu3xTxCWZgszmM2/vVxzr3lLyV+U0TbMkSOhbPkSaigaeUpoti8b9uHLaa4Vf
         nHuAX55ArN0ys+NIYeU4QYD//seYfXxqZzEA2gtBcabOUC2X+fjHO0X5GXHMyIhvXG7I
         tVKw==
X-Forwarded-Encrypted: i=1; AJvYcCUr1XpaDcmTVUCMGElnot+InJFZ70+YFSCk3XXdzNpsrXDxIZ6D9bFrXrYbyqv0kMPEq9aErGZulwLiW1sO@vger.kernel.org, AJvYcCXS0TOl0ToNKgTxHMSa0Cmp3Bk0Tf1sj1haS9YX57JpxspaDIOyI1+i101qPISAePPyiTfFPr4+N4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9GDNMQf3IfFm7SUiSkPTAwyJkQJOeRlDb38IqK171GZbc46Lp
	g4o7QgOnW0BDop21kt/h1ps9PivnD4DmJZRXTDPkLDoIv0Atrh1v++NN
X-Gm-Gg: ASbGncuLpxgXH2Oe7w/nwEl/gmQ4TgAPfDxFJQtuGgH7nlB1Ke+5/RWwQMqrl9WgSUV
	rl+FXUQIbPKsoXwiOnAylGS4spLVch3mR/PdYKtVIuxuo2JEexLqzXBYwnkDGuncCPcusbkRBSW
	cobqvNUUMFZxotkqcescQanFLu08ax5c4rLyW1/tszP544u2xKCzIwn+28eTyEZPxs1bzUkNhrZ
	Xx1GodtgRE2OA5KpJmyX9JuChIPclfUPNJuR8LZpO1f61u3cGiO1M51gFsVxPWtKm07L0VDiKXB
	pGjhiEQiibM2q5KHKSczQ74i9HHtEc41dUS2ov7W27p1QZ2h9oN84QKD+mi0qFBvIyORmUBm3l/
	+XJGAR0lNUUq9Q22EKFex3vJqEk13s3NyqRisq8VNLf1k6JSv9Ak/nLovGDP1srqM93Nf
X-Google-Smtp-Source: AGHT+IHqmNO4oMvqjL61/c7kvpEo+hxVG7yYbDs4ExYpGv8eQKU8KPIcvs0gy4C88fJcq8y09DCb4w==
X-Received: by 2002:a05:6402:354b:b0:607:eea1:1038 with SMTP id 4fb4d7f45d1cf-614f1f14daemr3303428a12.6.1753650023010;
        Sun, 27 Jul 2025 14:00:23 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500add92dsm2512774a12.52.2025.07.27.14.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 14:00:21 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v12 1/7] iio: accel: adxl345: simplify tap suppress bit
Date: Sun, 27 Jul 2025 21:00:08 +0000
Message-Id: <20250727210014.27766-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727210014.27766-1-l.rubusch@gmail.com>
References: <20250727210014.27766-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify setting the tap suppress bit by applying regmap_assign_bit(). As a
result, the defines can be reorganized for better clarity.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b7dfd0007aa0..e293fc917972 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,12 +34,10 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
-#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
-#define ADXL345_REG_TAP_SUPPRESS	BIT(3)
-
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
 #define ADXL345_TAP_X_EN		BIT(2)
+#define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 
 /* single/double tap */
 enum adxl345_tap_type {
@@ -368,9 +366,8 @@ static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
 	 * Generally suppress detection of spikes during the latency period as
 	 * double taps here, this is fully optional for double tap detection
 	 */
-	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
-				 ADXL345_REG_TAP_SUPPRESS_MSK,
-				 en ? ADXL345_REG_TAP_SUPPRESS : 0x00);
+	ret = regmap_assign_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				 ADXL345_REG_TAP_SUPPRESS, en);
 	if (ret)
 		return ret;
 
-- 
2.39.5


