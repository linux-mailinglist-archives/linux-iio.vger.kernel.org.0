Return-Path: <linux-iio+bounces-18207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CACAA9231B
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D469A16818D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C0255E4C;
	Thu, 17 Apr 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T/vU+/rP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5B2550AF
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908826; cv=none; b=mVP8lNSHzJ24zLIymoQz+EyaIl9/e7tmuAvS85nl/sB1V/Rdtd9vlLj9HFS892GAAnU0bXEk2eUm+zKQLiAAPRGPBlfw3ij+GPy3p7rTCTn/t9O1wygs9WrXndZWBW2Zh/xUDmKuVCgb+Q0onz+p+RRJqQnxR5jOb0NCWYZG1J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908826; c=relaxed/simple;
	bh=Be+VG80oZRFA77m6Gt8gOSL/Nfe6cNHnZZZ4OXulHq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGRzvkerrlpY2Hflns3HpYf17dm92ZpiDumHBuH/RGts4cSOXWCgDuCUQhoS9TVVv/2WFnyjoFUtLShzw10s8rRQK07xW5VLmiWYZDeaHdHJwZNDFU9DwvU41DFfB4lV5U3yMVrIe2bW0vL6FgSJi8w3W3/4XS2O4NwgS7yf+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T/vU+/rP; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6040465b9e2so455235eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908823; x=1745513623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1F+vlOB53N+GaZN9iKzvcz7MEqEzLVUIiy6PF/59Ng=;
        b=T/vU+/rPH8XHxF3GX/xRxqTCd8a0nEJLLayTYp7JfLAluFPRsI9iL2kJDV1keOTVvN
         44lXM4usvEeY5NfJCRXcS8+kG22Nlqxeo8iJiQQxcTvDOkYqhlybUwHyt6zNJ0VQfdpi
         Ec2TN4e8CyR0191cyF7yohDKuzwe6oa+UQ1Hj3jSaU7prdEJzVaFRabUfjuwadub3jTX
         O/esYORO3wH6+KcoRqKTmHRypEiQEO3vP5vfAwzOtnaTMqYKZX5oMWKzwBluMtFfhX5g
         o6eYDZneNAceAnzPWRLBze6yEyhUAPGpHhmsi7BGNuAl2i+FK7y36uXQZ/eRFNZodpUz
         zk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908824; x=1745513624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1F+vlOB53N+GaZN9iKzvcz7MEqEzLVUIiy6PF/59Ng=;
        b=u3UqFMj40kI7HamGxorS1g80TURewRY0zBHSpYjd77UmFZcU2volbAMS5z2udJ7tik
         bv3S7HexMPE9d4Fpyf5gbAKGNKtiFQt/BKh6iobAC9te/VDg8uSmkWV3P9txyfS2p+DZ
         vsXc/xZtn8cGYb9RzulPV7oZAlpRxCc32rYHEuvWUDyYbJSPZb8GX2kNT02mxibRqZVn
         CKle1yfZ+10Xlnd4q8JDaa24x1tdzcjUCZh9zhE0UGXlmUcxlORkf/9gXVoRLj2T2l33
         ypwf3+Jc/CDHQNwHkArxfHyyLXqVjl7GAKrcMWqZ9zckW+V+jsTOvXM4r3kDdvtkf3+F
         SvjA==
X-Gm-Message-State: AOJu0Yw5NkRN4zlUR5Kh60oVqrSFrkpPDEgtA6ck4Y54JOIUHVVHtL21
	m3a6XR44oZou/Mos3WK6sVuPScEkzoly+Yo2upVtAbBbVKeXkk3oORLvAbPmtN+WchccHDY43f0
	bi84=
X-Gm-Gg: ASbGncuOPSNvRl4ZBYr8IhREodpUx3YO18hGLPy/SfNDGzc8mn5nHFQDLskVK9i+48D
	ffeUT7E8F/DBBf5rjgC2guHRR3ospO2UzuGEtFSctq1j259svrko8YEw3TQJEkHrSaFG2PWsPjK
	B7LG1H9sUJwOSSooPVIk47mm0qySS5YW+3QiSeYMvpuRBp5k10af0X01K6iYxGl3eyNdzbnm7eb
	nmp9CXMmEM12LWydNMd/1PHSLMIvCiBL0Mxxqa9p0G4ZREiA9vt/SFwbCYo1R04+MyunxwAwgxO
	lpJR7LrwdHWsVgIqlB8GPTp7XEqRKaZq03kJcZOkKnQUeu8=
X-Google-Smtp-Source: AGHT+IEKFwTdIVXn18X0mqQJTNwR4Yk4UGM3aZEZT7fmXlltGNReQaAJ+kElPt73dhfKHrVg0VWtdA==
X-Received: by 2002:a05:6870:1708:b0:2bc:7d6f:fa86 with SMTP id 586e51a60fabf-2d4d2d58f98mr4604470fac.35.1744908823626;
        Thu, 17 Apr 2025 09:53:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:36 -0500
Subject: [PATCH 4/8] iio: chemical: pms7003: use aligned_s64 for timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Tomasz Duszynski <tduszyns@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Be+VG80oZRFA77m6Gt8gOSL/Nfe6cNHnZZZ4OXulHq0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATHtmXXnfyB5zOEBfzyoHuG/ltoONKqIKZ4Di
 d4P0WmcMFyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEx7QAKCRDCzCAB/wGP
 wIxICACdc/mCCcb81hretoFsihU80lPcVXFy8V1MRYpADv7qyT8rw2ZaOKBT6PmnabUtyxkC1WX
 zmjyOWxpfiX4jLkNDrcLJE9x52qUTJDYy5RcyB5fq9a2ekDQ+2C28Kgb+XiqJlK9SvIwOMQJgQf
 S3Ov6qj1Q/QvrRrsEg6LQFwlifspnOVIYXWmhzlrKb5LmITB7lRM2RxdN/VFeP2rjr4nRjJU8CT
 nKXM8npO+jClZzs9AsMAl6dn/iYQSr0+toMwTe0sz0fX4riLCS9LGqRasAudxP7QROpdFLpFSlW
 aABPICumbovD+w351IASkkwdw+h7FJ7nMElFz8CN30NLd0Fh
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure that the timestamp is correctly aligned on
all architectures.

Also move the unaligned.h header while touching this since it was the
only one not in alphabetical order.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/chemical/pms7003.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index d0bd94912e0a3492641acd955adbc2184f4a11b3..e05ce1f12065c65d14b66ab86e291fab47805dec 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -5,7 +5,6 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
-#include <linux/unaligned.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -19,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/serdev.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
 
 #define PMS7003_DRIVER_NAME "pms7003"
 
@@ -76,7 +77,7 @@ struct pms7003_state {
 	/* Used to construct scan to push to the IIO buffer */
 	struct {
 		u16 data[3]; /* PM1, PM2P5, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 };
 

-- 
2.43.0


