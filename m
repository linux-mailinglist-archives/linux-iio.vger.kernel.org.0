Return-Path: <linux-iio+bounces-19517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBDAB72E3
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 19:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB4D1B66A1D
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02327B4E7;
	Wed, 14 May 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9sLiJZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8218B1FBC90
	for <linux-iio@vger.kernel.org>; Wed, 14 May 2025 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244137; cv=none; b=KsS39bWrseOfm/+OXDVpVfHjigbX22bCXw+QxML353tklrZBS/DuSL8lUneo5B2kTD6KvTo//he1EL6TWX8T2He1zoffTEhgudeebcRZYur7jdO8FEmIgjY/b6shMA4DU8Hsg9iWIi48WYDeGtHpv54yOVeztnjWIUsZmZsPleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244137; c=relaxed/simple;
	bh=EyH887FyIkjfdlaBlYHVZB4u2OxCoUrzPccypAbPf0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gwoHGmfDKP+Ova7zKEy9r/+k2fV3NJ1doD8FzhfXBSz0mt8PnGtk/QHxJUg5LOidtM1Uonm8mBwl5S/I8bZ7zrxb+YkGPH1yqEoxvQfzw/Ots7kJCLtDQyZ8ORjfu7Z3502TzOvnkCQ6GH0QQl55IsXAUinzCx6lIyLiTR0oiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9sLiJZj; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52c85c0d473so1254298e0c.2
        for <linux-iio@vger.kernel.org>; Wed, 14 May 2025 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747244134; x=1747848934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kPAxEwhugIYtlKiMTJRbGSYbcWigPkRu/XosQLLUCRA=;
        b=Z9sLiJZjPZ2bfkIMg/STfFk7VRV0aR4M5vqQ21f5N+bBz59rRA/qlLWewW/4wYacrL
         3cdYf3pUpvNQf91DJCrOXbg6EWDtVjVLDBY7zcPdfyLVEXwxrvJ7DWWnVs5TtAwa9J2d
         Eo65wGRrkMlMvSBhRyz8IlFN27Cg2fe+f97fNk0inPVQhh5NhU7JRC5LyFaU43bOzJOx
         oWLXcs+RzuAcIh2BiaBYHqgNszI1HnwRaHLl0WQBRwDt9EtlIsTUFfPXVd8f3smpPK6Y
         GxBvcAvwi4IQrflBiVypFv19q2s6gZRf/2sYGTWmFFsqCktv716YmY8/eSiDk0D4Yv4W
         azGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244134; x=1747848934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPAxEwhugIYtlKiMTJRbGSYbcWigPkRu/XosQLLUCRA=;
        b=FK71Q2RfvU9PuCqpFs2qhkrCOZ2eMvH5VJWQ77cg8Xn71QtiS5fnEIXTdiy3doQHHz
         KWFti/QHW8f7dzFztuhxTvq1ax7Eb5gRi3utudZ9sma1+XrpI36N+wmen4YdwsyM5oax
         dkSjh1YfCOG49Eff7SyxnUE15bZOhbWvPYsF8ZmtPVzD8N8LjDSHWOYsCnnZUe4ZpncH
         MN2/NmnfklfwfIbnDhdhG5N6k6MkekDSVrsBvWu0bfpst4qQx/3/lkdXQzF4cmgGeMTw
         BM2zz/4HumRTUFHiH1c0oa5Nxqx6CqMsqeaa793Va0Bto3Ta+DIC0UqpvtY37E4g6MnL
         2DPA==
X-Forwarded-Encrypted: i=1; AJvYcCXNe0aSRHv99D/AGIt3n9RYL0jbTBYYeB18PjFIkG1ekMjcQnwaWjuBkAA+U9cBiwmXN5V7Z61/66c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLQRtegz6i6+q3NWDImAsnmXnHs95owy1fSOeIoYvGlDbIaX3
	kK2xgwIRsY5bMbekeDfOpF+CilzB4W7mZBaHnDdn87u2YdhK7xRL
X-Gm-Gg: ASbGncstumGUuCDcWUAA6cppXxQTQGtkI6CDR4uHE2OvpVOkCsmYbimFantWHD52qVp
	bWRJALAidMRNbZczS3WbB99oSbaAVJ2Tp1RDE3gbegMIkMmHCLf1zU4zS91y7kD3/p1Zmad5ceR
	hO3t9q+Z7z13UZzAqcorCrT2FWhj+EWe/QBKRFYckeee1IH5t1Ih6Bm5f3lO4DfFS27kLiXkmaD
	nTI90pYjcaCwaWs/+09Q5WKKNuOY49hqvUg+fjgPMDrjcm6nAz/tRH98faHFdRf2DdbohZu7fMp
	W2Egt4j8WhsWQGgIlTmb7DApgHcWRNr4lf3ksxIRkhgJx3Yd1Q0t1+hvvR96DCEjhQ==
X-Google-Smtp-Source: AGHT+IFmxdDPGiP3oo54067YrhNHuqyXktlaXFPO5qfEBEJqXU0vHToIbPnmmk5PaI9wVV7igDN9jQ==
X-Received: by 2002:a05:6122:3c83:b0:525:bf40:e628 with SMTP id 71dfb90a1353d-52d9c6cce01mr4218019e0c.6.1747244134130;
        Wed, 14 May 2025 10:35:34 -0700 (PDT)
Received: from octavuiPC.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c7ff62bbesm5204256e0c.29.2025.05.14.10.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 10:35:33 -0700 (PDT)
From: =?UTF-8?q?Oct=C3=A1vio=20Carneiro?= <ocarneiro1@gmail.com>
To: jic23@kernel.orgl,
	linux-iio@vger.kernel.org
Cc: ocarneiro1@gmail.com,
	fernandolimabusiness@gmail.com,
	eijiuchiyama@usp.br
Subject: [PATCH] iio: adc: ti-ads131e08: Add iio_device_claim_direct() to protect buffered captures
Date: Wed, 14 May 2025 14:35:29 -0300
Message-Id: <20250514173529.5852-1-ocarneiro1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add iio_device_claim_direct() to protect buffered captures. In
ads131e08_debugfs_reg_access and ads131e08_trigger_handler, data
reads are protected by the function call to avoid possible errors
caused by concurrent access.

Signed-off-by: Octávio Carneiro <ocarneiro1@gmail.com>
Co-developed-by: Fernando Lima <fernandolimabusiness@gmail.com>
Signed-off-by: Fernando Lima <fernandolimabusiness@gmail.com>
Co-developed-by: Lucas Eiji <eijiuchiyama@usp.br>
Signed-off-by: Lucas Eiji <eijiuchiyama@usp.br>
---
 drivers/iio/adc/ti-ads131e08.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index c6096b646..00a7e6494 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -578,12 +578,16 @@ static int ads131e08_debugfs_reg_access(struct iio_dev *indio_dev,
 {
 	struct ads131e08_state *st = iio_priv(indio_dev);
 
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	if (readval) {
 		int ret = ads131e08_read_reg(st, reg);
 		*readval = ret;
 		return ret;
 	}
 
+	iio_device_release_direct(indio_dev);
 	return ads131e08_write_reg(st, reg, writeval);
 }
 
@@ -627,9 +631,11 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 	unsigned int num_bytes = ADS131E08_NUM_DATA_BYTES(st->data_rate);
 	u8 tweek_offset = num_bytes == 2 ? 1 : 0;
 
-	if (iio_trigger_using_own(indio_dev))
+	if (iio_trigger_using_own(indio_dev)) {
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		ret = ads131e08_read_data(st, st->readback_len);
-	else
+	} else
 		ret = ads131e08_pool_data(st);
 
 	if (ret)
@@ -670,6 +676,7 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
+	iio_device_release_direct(indio_dev);
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1


