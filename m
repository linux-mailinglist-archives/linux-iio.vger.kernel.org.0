Return-Path: <linux-iio+bounces-8020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FEB93F498
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27C81F2064D
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C314A08E;
	Mon, 29 Jul 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu2F04bP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A782149E0E;
	Mon, 29 Jul 2024 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253916; cv=none; b=mopeskiYURh0XjxlxPAqPJkcN+Tp5n0KU6RFVr4BSVR9xTF32n5vlUnBv1Rh70C1ntBHZV9CIldRGyHVkbo9aZpK+deoaA83ttPDwkvztqZk38XmKkvWTYMWC0ur51KGS1xrZ9wPOX3oK7MmmQkI6FQzh2u1APYQUau94ol2Cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253916; c=relaxed/simple;
	bh=4HCffACfMnUeNPUu7Hcwx9FsdGsQwVRifBkP6WtEeQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBxaxAuZI7kkO6rvkXhHcU4O+vqDvYdm+CudVZFp0AgGBRP8wGclZAyj8k9usSiUzWwgHtxzNJg3yv3Wy/X3lVW0ZiwAVo3MJcFgLIECSeC/EdGLikuBVjU5t+qFLnSgCoxOOaVq3KuIxp1Bc0jo6Iuo4OABNNJh24IjFWDCMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu2F04bP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d399da0b5so2698556b3a.3;
        Mon, 29 Jul 2024 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253914; x=1722858714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ijrVq/IlpFEKBloYw5MT83j0yPX8QqiotVSowdQK84=;
        b=Tu2F04bPOWU39Z92OtQEoPFO/9H9J9WnAUcyAFo+bMP/bsxlNHr+AUizUcWh0U28an
         zsPEnr2aqUf/fz9jtKgMZnVasvYjLeXFNDXkuE50pVoIjtnyWC4yCWaHr+AvSoB9FRVi
         OkH2f0Ttrq7dZ/QbjcxgEcYOe477FwKpDPXJJVJtoZQfhiwNAB6J3acfY8Bc8llx18AW
         nRNxesVQCNaL4J7rWWM7E4YrSnFnLLA/MmcRMluKOKhaoTGijVRqsiJm2d09AuVNAybL
         dkgjsFh7ipxplpk/s0PqZWevh1yaP5FOA8susCr49LAxEKsf/3fws8jKXj+AjLJLuV1p
         IwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253914; x=1722858714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ijrVq/IlpFEKBloYw5MT83j0yPX8QqiotVSowdQK84=;
        b=K2GqeKKNoWA4BF2B3vW9zhYvwrWvCPDL3t3pbS4f1B/uAFKsE+SFUH445uDmzzlFex
         Zc5PI6mEsBI+NPgny6bL1tz9EjFZtuj+HmYgsy0Blz4ODgrmaAxSWYn7jBeip/yLSFb3
         oFLni1u1p+JCDSrHURgtJxALLJthQahqH+SCiEsmO+3TTzJvwW2buYu6C4IkbOeTASwE
         NuokukOWGU/oXcXXu3hmqIMFQcF4DihpZy1VKd3ooYSuh30OdrbLKOFH8p+22K8E/vbO
         HlNcUdWaqlCJJ4hV0NPLgtBs4wymdmKVmrfMBwrzB6C2RgHfvYBGyYNtgRf3N6q+T/fU
         0zDA==
X-Forwarded-Encrypted: i=1; AJvYcCXgNGUzlJCsRdHvph//VPp+4TacrIbf1Ww2bxMfE8U3/X+McG3ohn78xcSD/Akx7wHtwLzCF5pebbV0jD72Lk9yJDojl8/JqVoHDRHl
X-Gm-Message-State: AOJu0YwxQ3ntRpeltsbMLyHG/mn7vGZpIjpiXCzE0VTQYO4ISX/hLM+l
	kwc82P/1HKebmPSXOS685d+BzThhFjmC+i+Rlax4OHS9ZyYNYzuXFYoGYQZc038/9A==
X-Google-Smtp-Source: AGHT+IHr9vW59MWTmsjFeW74/VYGlSKKWrlM47p/n6Hr26QWUtn+RjmS4n6KrGNZrvaEz9wL6xEgzQ==
X-Received: by 2002:a05:6a20:158e:b0:1c4:2469:f893 with SMTP id adf61e73a8af0-1c4a14ded1amr10792108637.46.1722253913615;
        Mon, 29 Jul 2024 04:51:53 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cd8f7692f0sm6760987a91.1.2024.07.29.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:51:53 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 3/3] iio: light: ltr390: Calculate 'counts_per_uvi' dynamically
Date: Mon, 29 Jul 2024 17:20:55 +0530
Message-ID: <20240729115056.355466-4-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
References: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
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
index 79f5a516a..dacbe9f62 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -45,6 +45,8 @@
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
+#define LTR390_FRACTIONAL_PRECISION 100
+
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -119,6 +121,16 @@ static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
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
@@ -163,8 +175,8 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			if (ret < 0)
 				return ret;
 
-			*val = LTR390_WINDOW_FACTOR;
-			*val2 = LTR390_COUNTS_PER_UVI;
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
 			return IIO_VAL_FRACTIONAL;
 
 		case IIO_INTENSITY:
-- 
2.43.0


