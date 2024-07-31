Return-Path: <linux-iio+bounces-8079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B421942702
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 08:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A3A1F2232F
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF9216D332;
	Wed, 31 Jul 2024 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt2gr7vR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443216DC0D;
	Wed, 31 Jul 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407856; cv=none; b=doDOt+RbRxX1gBPLwsMBRe72v1aG1K+fcMZyuEmRjwLV5YBpJ/4wONDbF9J9wWg4YfoyRNTs+UEzN0+eajAtEftt8r2tr1g5tnjs3OhoOl5IY+aQUXia5dayPQWc6GxpoUVqcRuWc5IUuu3VBC9su1Z9A/5jaVPfTUu6XwgGBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407856; c=relaxed/simple;
	bh=Kp8QiP3AsDSvPPNQB3Qic+n178W89srI5plIliEBAIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGpCkpSXOwXh5UmmlpMuSXPJrseJzGlIDarQxw0cYIdKv76AiGlZUNfyIHQ9SR7CP8y33eqcFhnBtk4KXWVdTfxbD9CZSPU3a/QOGPg5Q33hYIZ6O8tX2d86R2YIqLo+DsoCrWikm5FZISi6euA3IFE8S5Qp+Uasig7n8vjdx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt2gr7vR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc5239faebso35774715ad.1;
        Tue, 30 Jul 2024 23:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722407854; x=1723012654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75fe+3PusG/jrJxGyj7LLDyUngbu9YEsT26G2HjGrpA=;
        b=Tt2gr7vRL9yP3Lx4UXFsQYwaY3h/cBtGOPOiU/8B98konMrxYrTvbofyqxTxhjOaXV
         9MPsns4KLFYeoa+VnmUlJQPZSy7iioC43zBN508SmbQ9KpROGcbsN9oKJpmMymu6dZth
         Bkjh+ghLGgJu4gF7eS3hXo7Vj3Vo/FNU1pigffhJD+WbGRFNRQsP34w8R9C26jw10E8l
         asJE30dZbcAI4vxVyoAZHuj0pfUlFsVIXPMv+zWCc0OAG0zdPCkDWae2OZpuQbuyOS/d
         4xJTNVOWBOmoKSYsbMiGQdHf3rXKYKDjQM58DsuPTEKpsWlNtqyhQB45tY7vxPMZy23u
         aLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722407854; x=1723012654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75fe+3PusG/jrJxGyj7LLDyUngbu9YEsT26G2HjGrpA=;
        b=C5QSaAAwIfpnpa0I+hUSXkmUPm8j0DcIWGYNWXwZrpnaFOMW0x5qLLIOwDv1vxNjgu
         urrodxrR/Iaj4BCjYe2vMrJ6prRqm2ed4Ks+iJNR5+HofS0wa2LPaJXLgD+uorrZig8I
         mssnUVsrdq9dUhbNCKu2fdwb/DtxLOF8aUr9S1HHcyIE79uHNuRTNizBUQJ4AV4xWPDY
         fxIBLlbtaGnVRiIa68x5NfEl1w1+E0qDBS7pUYsOx5tOUMqwO9HvQ59O4hIznSwO13zD
         gkzn2o51yZ8cTpAFl3MoUR8EzZ4ImPguwMPzQ1anulJd0EvtENqBmZ/g6Btaj62XK+T7
         xsYw==
X-Forwarded-Encrypted: i=1; AJvYcCVSr70QSGmgRqwhsoRpy8V52XT1/8CBQ4aFTQlXRO15lsEOI/vrrnhYh6tCcd0FQJipNJiNx8s/4+K+soOyt+f5BehOE0Ez6HrJydvm
X-Gm-Message-State: AOJu0YxnLtddiEwVYzjjtqDrI+OKsD/jXEraib7gFPJmLT4ywp7g0pCn
	z+Y2QyIZEW2Om/ZwvABovdRM30M5m6PGDDAsX9YqMAtHtHVTj0/JsJ6R5QiOt8AqCg==
X-Google-Smtp-Source: AGHT+IFisf95SNLgGAhhroFlwzQL74qqlI9Ws6GZQZ6aR5ic6IF1XAWgu/TXdYx7b7K+hIsRkRnnjw==
X-Received: by 2002:a17:903:950:b0:1fb:8419:8384 with SMTP id d9443c01a7336-1ff047eb00dmr120045475ad.13.1722407853875;
        Tue, 30 Jul 2024 23:37:33 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7ee4ce6sm113164905ad.157.2024.07.30.23.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:37:33 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v5 3/3] iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
Date: Wed, 31 Jul 2024 12:07:05 +0530
Message-ID: <20240731063706.25412-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

counts_per_uvi depends on the current value of gain and resolution.
Hence, we cannot use the hardcoded value 96.
The `counts_per_uvi` function gives the count based on the current gain
and resolution (integration time).

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index d3ce43f20..84c084bec 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -46,6 +46,8 @@
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
+#define LTR390_FRACTIONAL_PRECISION 100
+
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -120,6 +122,16 @@ static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
 	return 0;
 }
 
+static int ltr390_counts_per_uvi(struct ltr390_data *data)
+{
+	int orig_gain = 18;
+	int orig_int_time = 400;
+	int divisor = orig_gain * orig_int_time;
+	int gain = data->gain;
+
+	return DIV_ROUND_CLOSEST(23 * gain * data->int_time_us, 10 * divisor);
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -160,8 +172,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
-			*val = LTR390_WINDOW_FACTOR;
-			*val2 = LTR390_COUNTS_PER_UVI;
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_LIGHT:
-- 
2.43.0


