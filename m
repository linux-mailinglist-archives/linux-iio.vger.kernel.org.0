Return-Path: <linux-iio+bounces-5331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F988D04F4
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA931C21760
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575F174EFA;
	Mon, 27 May 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSRRspQ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1E173359;
	Mon, 27 May 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819992; cv=none; b=iYc4RTRzq9v9Z7khGOxG9D0mzi9OqSze0GK6JaCpgoCnQogxInqfp4beONmHe1yESYVMx8j40zvVMEAU2d6v/wvR58HWAKHiCdeb8mpAwo4nOWJ+3pG+nMJItGjSmnz6+8UyCGQQOly4foZJ3LWm4KJxcB2G2qZdrwRC9X8cggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819992; c=relaxed/simple;
	bh=ZHKWRbyO0u3fo/zl7IQIsbBN+w8JSGzIA/CdJqdKDUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuZERGEP8RYh+KCOdnJSCsP5DjPHR1aB9tZ7tga/aNGgZyjMi+op/W7CUSW5VG0RfI8n3q5IfXoWHUk3jdc+UXZVIkHQLC9teS+8CVeOAeBOFF4psFVhWmBALpRbDhYrNn5L/DHj9+sISnksZP6/UMhA7oi7aT84h/mU3V0DIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSRRspQ8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-351d309bbecso8400831f8f.2;
        Mon, 27 May 2024 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819989; x=1717424789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLBPCtGNQH5vxOhd0p8t0N68VsqXEcl2qo1StfzuSGE=;
        b=fSRRspQ8crTTUfsnVEGplHzZsZlHzDRqdbT8CSTK+XdC0KKRekYJhFTIMi8enyUOnT
         Hy4FSw2rgF++Z4x2kmEIaqHEmtuMWLxr1GoRiJxo05MeL5KNqdW9LP51hw4ertouGTd/
         tG8daYsbF8k3tZMGta2sEMqJov+ZKrSMhGUMnGNzQDMkgPjI4WNDW+xNVlqZkxWF+F9o
         dNHWe9SHuuYFyDv05IuO7bq+eXR9S5KLG6h+nzQza93agQohht4w0xqF2JUp8Dqae9P2
         nP4ET9x2XxhObJ04GSzi46WNQkfiogPCupx7Hax6JS3iQg2dNW/LywtYXpHZ3QEkDQJq
         DtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819989; x=1717424789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLBPCtGNQH5vxOhd0p8t0N68VsqXEcl2qo1StfzuSGE=;
        b=tJYTCLsoY+O696YsrUglI4JsoYtLWeTGxK2sCCzOw3WC1u5fExCF1DULzPmHpxHCUn
         BF7cmUXSm0HqByVrJUAGp+sw2zBFIBpzd6HDOBqgb5zrCno9xPQ5aflcfJSym3UnbgeE
         JJKFgHIV1TCtKoM8zclrk2pYfbWaEpMfyNLi0um6LWyP/sNL6Cmvs1xYfncytoLNqFeT
         FptMDEaeheK52v3uQFr3G434ASLbfdtlIqXLJkUzKyVf5YY+a/7JFMBg5UhLrtzPSxIF
         lR6TpK2VcwOIU7j0dIzWN9pFgl+ssAXIGTxm0nvHuXpe9eYFBIzgotroB1jJD/twsEBe
         /C6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXc451avLXQoEGawVcYTmhhUY772vplQ2C+MshS46v79rpONf3gKB+QM8vw3bna9jXMzjiGAqvTZt/t6MtkIobdwhDor5nwac2yesSqTj/QtOjlKuZq6ST1N5F55FYvxym31X2XKg==
X-Gm-Message-State: AOJu0Yzh+mydsDqoJPCBQNLqZ3ykAYAZFcg1X/+a84IE3q2oszIO3V8w
	RLe0Km/IKhtqWFA2CgDPpmiYiF3gu5v/izHyNeu7B+ZvX1jVzbsNUxY5LJKhN3Y=
X-Google-Smtp-Source: AGHT+IEQqZ1TkM1HvXpXq1x9PiH4qz0i5h6TZKDveYqE0gktv4btKw84LPHmRiNDKbQpoMH6cyWs5A==
X-Received: by 2002:a5d:4fc6:0:b0:351:b2ff:63a8 with SMTP id ffacd0b85a97d-3552f4fe4bdmr8224920f8f.16.1716819988964;
        Mon, 27 May 2024 07:26:28 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:28 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v5 4/9] iio: imu: adis16475: Create push single sample API
Date: Mon, 27 May 2024 17:26:13 +0300
Message-Id: <20240527142618.275897-5-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create push single sample API reposnsible for pushing a single
sample into the buffer.
This is a preparation patch for FIFO support where more than
one sample has to be pushed in the trigger handler.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v5
 drivers/iio/imu/adis16475.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 53872b716f4a..64c8bdaba4c5 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -1207,9 +1207,8 @@ static void adis16475_burst32_check(struct adis16475 *st)
 	}
 }

-static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+static int adis16475_push_single_sample(struct iio_poll_func *pf)
 {
-	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
@@ -1298,6 +1297,15 @@ static irqreturn_t adis16475_trigger_handler(int irq, void *p)
 	 * array.
 	 */
 	adis16475_burst32_check(st);
+	return ret;
+}
+
+static irqreturn_t adis16475_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	adis16475_push_single_sample(pf);
 	iio_trigger_notify_done(indio_dev->trig);

 	return IRQ_HANDLED;
--
2.34.1


