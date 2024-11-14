Return-Path: <linux-iio+bounces-12273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5B9C95D7
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653BD2830B3
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439CA1B654E;
	Thu, 14 Nov 2024 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvPiZnAX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F3A1B3949;
	Thu, 14 Nov 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625823; cv=none; b=a/HPJmHGUVTisNOgCFnBWjM8xFo7GT6MyZu3RcEUaBsrUxnm3MJ8M8n2DGQLU94ogOtcMHHmCR6KgiLg3x61y3YH1SCBuVznG1q1dR9wBdLGkKFfLo0v2sf3+q100R08kQT3a7ZQCZ0uXbEJIh90RXNHLizH6Za6hQ+wczGBuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625823; c=relaxed/simple;
	bh=3+8TGTdnmuRDOCovADWFx3rULEh3tRTgXMyrKonxBas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D8hvib6DSfYOcVIkByPn+ulPYhhTJjdulkYtkHl1m0Q1zhSxaM5o/gOFRfygG02VzVIdhATy+YCCSfeL0yvvFZ4r14qJTkc3mjS7kUdkTCKcygqbXuqKTyrjdCS+UlXu7ZQefdQhIXEMg+LmtCwoAZL6DwYgMEL+u2cI38Ypsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvPiZnAX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso1069975e9.1;
        Thu, 14 Nov 2024 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625820; x=1732230620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpq3lBbChwHQ1yWypFmrljsNCSzIVAAQbPGcSyQvPoU=;
        b=mvPiZnAXQ75EdQFywFG6SOq6aU92XdJPql4ZOTiiwDzWaW5BLxJexN8HqNHZJgcYW1
         FjGmIvmo+6sIoSln+z98iRFR4ddV2lahWSpnfVCQo1LL9c/bEZd/7T3Wihd3yvCFI8Fu
         51ty2JYbIS6xqVEkl8M8/13jvtuYN+ls27dDYEDCH5qBidTgZ4R5pgvxuvGisgQhuLTS
         yiTguUWMyIo68uunYOaSXcKFoLBlKYofnn80Rz8GIBs9u1c4Q8P1Zy96UCF/pf9mDhe5
         JksPOmBAJybuimrI0vWgP2kdyaGyq8HXHQIbeguud9cYJAhYRn8ONeLjPcnbeMTvoprG
         6+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625820; x=1732230620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpq3lBbChwHQ1yWypFmrljsNCSzIVAAQbPGcSyQvPoU=;
        b=Wu8g5xoOB/7i58PgV3EVzdKYUhl74Yc+1qd2K9qJTAIHlgB7qGfal5b96iOOGN8CkL
         LzkSKQ8PvyAFC18bYynTbJ4qiF5ZdwPnCNOVNKbVr45A9A+K+GJNml/+i343habBT40a
         XQSETHS3E3xcOVuUfLxpNxPTYq0wL0w5a3RVqrI/mQNGsP2lSIehYt1qXvDWPkxK9fuR
         A+EkYOcP+sbiJ4JArjORT25AZs8BKQB6CJnlucuATiq4c6pSnk6psdn1I88IVrk+MQxY
         dNtVLKMVv9s1gGkbxekAKI2goaqfgRCaNcs1EA+nSY+hLYNkFRO35HKV7y5h081n1vhk
         0L6w==
X-Forwarded-Encrypted: i=1; AJvYcCVIa8Fkrh6dRVH4lazVfLm1hgUQOxnU/YS4daK7Ue2AARU3XDxktGVQP7FhkjbFycFVXCV8Le/iEZXzJcj7@vger.kernel.org, AJvYcCXNncABkz9TKjsGrRklsCd7qju6CFikXyW/JSefrj0+E+TalNuOSU5ux1AIpMWqmCYMQhxCsu3toGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+xaQl1JA4JAObP9jDNI1kFgyV+Sfi0EO3iw2TtDH7JeutQpT
	A4qxq2t5ldd40zYtR7wbNtYJp2sQ7ezb+mPQzyC5CD3x8RvXXYnK/EIQidIu
X-Gm-Gg: ASbGncvz/8Xk/5CPidKuJlfazqKhoBNR3q2DeJ1BHX9a7hjkl1e141zEF7DBI3pa6Lf
	AUlI198f22Y7kbDnicbyM90jhdfLgcmGURxgnQZHut8lXlkrZ3w3xKEkcwR/azNxU6F8Qbd0BKJ
	1k4dyhAnVDxlwzgdat8xyK5DCdueyffwJUI6iMEVST/eO9FhfrdbogquHtIAkbifnpiBQnBkcom
	xKoNWxJ0dVQyiZD7gn++ZoLLKQ41opbUZL9Y1Ri6j+PnLFTnxu1WHnBz7cqikkCfqXlGHkl4Oh/
	LHfPwtWvfI4998oJeAUqd3Un+xPm
X-Google-Smtp-Source: AGHT+IGU97K/j+iu3cMhre3pgJnmMA40jSRhp1AgIVMrXApFSHlnBSTVg1hBlprgYeqz/uT0rQfz6Q==
X-Received: by 2002:a05:600c:354b:b0:42c:aeee:80b with SMTP id 5b1f17b1804b1-432df797e02mr1636225e9.8.1731625819388;
        Thu, 14 Nov 2024 15:10:19 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:19 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 05/22] iio: accel: adxl345: measure right-justified
Date: Thu, 14 Nov 2024 23:09:45 +0000
Message-Id: <20241114231002.98595-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make measurements right-justified, since it is the default for the
driver and sensor. By not setting the ADXL345_DATA_FORMAT_JUSTIFY bit,
the data becomes right-judstified. This was the original setting, there
is no reason to change it to left-justified, where right-justified
simplifies working on the registers.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 2b62e79248..926e397678 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -184,8 +184,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	struct adxl34x_state *st;
 	struct iio_dev *indio_dev;
 	u32 regval;
+
+	/* NB: ADXL345_DATA_FORMAT_JUSTIFY or 0:
+	 * do right-justified: 0, then adjust resolution according to 10-bit
+	 * through 13-bit in channel - this is the default behavior, and can
+	 * be modified here by oring ADXL345_DATA_FORMAT_JUSTIFY
+	 */
 	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
-					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
-- 
2.39.2


