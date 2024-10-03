Return-Path: <linux-iio+bounces-10080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4C98F559
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E52F1F22996
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D84D1ACDF2;
	Thu,  3 Oct 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTCh9CmM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074B1AC885;
	Thu,  3 Oct 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976895; cv=none; b=n2g81vSD5LN2xm2xruLayos76kr37PzwE5DmCj3gdgfDEj6IiSuw264utYitIhTWHnYkYvhaAP7Uf0XPGoaydOI8od8Ev0Xv3dKXWcrqWFOcbXBvjVRyLghHQ0AUJ4Pzny1/Z9QM0U6GUvl7Jdclmam9mzkkrg+3gUFX/p5MsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976895; c=relaxed/simple;
	bh=58F1FuUmxNDA0vLWh1R6mPGi8+44AWjAUzE2ru9NTEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mC6cCWV9tivAJB3uxPxPkWNws8HEEEPk2B7o5Uxcc2NZ5+YfEyfd8P9Dmuv+sYaWclRHcVy170/cLyJCNnzhrCG+S8+rkVG2pVFmi0ryeldytjEL/Wj9KAkGL+JI3HBIvKUKpg8D/BQQXqQmkAI5+hrOJ1KQ//1DJTwz4fmY7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTCh9CmM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so12347535e9.3;
        Thu, 03 Oct 2024 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976892; x=1728581692; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0wZJpbdLI8pbhpRpC30fTnveQVaUWJzRu/TLRmsvgA=;
        b=GTCh9CmMrZJHGKTEeL2z5Kou2VUBidRX/UaICe7U0E22hgCDEYqTAbUHWdA9DeSb/E
         XMujMAHdQWnAeNdcBgTsmTOL9/ntUzF6ilNEliOky6VidXAwFi9stHmDJBmsJGpvzCYP
         WKBXO8IRMNy0YXtk7kt/AvAkWc43shNeO6Z+IMEzPJIniD9tC/2IuU77Oe1KHIwRTB/T
         lhvWQk4ejYiRhED3eM1HOJDdPLFmFB6BRpJxfi6a3yr0WDDP9B9/IyZtBLhqbuPIW3rq
         iab5fs7gbCAdPHs75TvjnOlxAErfrebShVGBJgEHwbCZv3KGd7bkyNuymdEqaqK/VDhD
         0FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976892; x=1728581692;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0wZJpbdLI8pbhpRpC30fTnveQVaUWJzRu/TLRmsvgA=;
        b=ansAIGjDWhR8cPM7jW0HQXGidHgClorwIlrU5TS61eOjT0ZN/AoOQ1Eswv3VemawuY
         DTmmRFYN8qvEDmpdu4pQpT9xuTx2AXxnRh6CFStQks750dh01FWA/nCZX3OL/E4vVTuU
         eunwAzdYbd1ye//xovZpDighYUhhcT5mBZc4a06M1+cf3ttxW9TtlLQN6qp9R7gR96NT
         GKUTGoQb8ABEcr64KAQHGr0nUjrxb4Pou5CjmyVm4WyFM1ay6pV6C3eRTJJGgT4hMBkM
         cxTv5WWqn/POygKAHR9HNN7ddxSCPUxrRLRTn7pNPPVx7AuRrZUusjR8Xg5nSuo695GC
         2m1A==
X-Forwarded-Encrypted: i=1; AJvYcCUgrgK3NuB2KTymO4qWa4FeFj04pIsR/v98mex1mgqFDRpO8NAMvi3CoUufRSqf7N4sgyM4Or2upGMesdE=@vger.kernel.org, AJvYcCUxAD/dk1rWOI4zkH0QziSKqBSvQCNexWM09ybdMzAnqAxSiWA/jPo1cknpt2GInsmc4tlCbjlTGIiRFA==@vger.kernel.org, AJvYcCXWBnS2EjzkGgpDG68LPg+3/0gVHc3ZuPpzu6ND3ooznjbP6JRFye7VKwK1wltVyosMGf08+eEwlNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQMhh5y+FVOkLXPN8JcHB7VLBihfuGXyBgNlSjFJNDxcA9+KF
	YfZyhIh9OMHPPfeiwOf1lAKB6kK9wUhgC0FdZzjBTDXvwBdpCA1/
X-Google-Smtp-Source: AGHT+IEAM0vwSFq50GSJ3eNFzY5HI4Y9topN38B5pNnWozwRsePt2tQX9c839MYYWXekBQnwEFA3sg==
X-Received: by 2002:adf:ff8d:0:b0:37c:cf72:f248 with SMTP id ffacd0b85a97d-37d0e8f553bmr84990f8f.50.1727976891737;
        Thu, 03 Oct 2024 10:34:51 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f802643e2sm20606315e9.21.2024.10.03.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:50 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 03 Oct 2024 19:34:11 +0200
Subject: [PATCH 6/7] iio: consumers: release available info buffer copied
 from producer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-read-avail-release-v1-6-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
In-Reply-To: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

The iio_read_avail_channel_raw() inkern interface now allocates a copy
of the available info buffer that must be freed after use. To do so,
free the buffer in the consumers read_avail_relese_resource callback.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/afe/iio-rescale.c     | 8 ++++++++
 drivers/iio/dac/dpot-dac.c        | 8 ++++++++
 drivers/iio/multiplexer/iio-mux.c | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 56e5913ab82d1c045c9ca27012008a4495502cbf..78bb86c291706748b4072a484532ad20c415ff9f 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -249,9 +249,17 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static void rescale_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static const struct iio_info rescale_info = {
 	.read_raw = rescale_read_raw,
 	.read_avail = rescale_read_avail,
+	.read_avail_release_resource = rescale_read_avail_release_res,
 };
 
 static ssize_t rescale_read_ext_info(struct iio_dev *indio_dev,
diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index 7332064d0852d979620f90066fb027f6f68f8c95..beec76247acb5170b81058d28a71ed17c831c905 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -108,6 +108,13 @@ static int dpot_dac_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
+					    struct iio_chan_spec const *chan,
+					    const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static int dpot_dac_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long mask)
@@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info dpot_dac_info = {
 	.read_raw = dpot_dac_read_raw,
 	.read_avail = dpot_dac_read_avail,
+	.read_avail_release_resource = dpot_dac_read_avail_release_res,
 	.write_raw = dpot_dac_write_raw,
 };
 
diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 2953403bef53bbe47a97a8ab1c475ed88d7f86d2..31345437784b01c5d6f8ea70263f4c2574388e7a 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -142,6 +142,13 @@ static int mux_read_avail(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static void mux_read_avail_release_res(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       const int *vals, long mask)
+{
+	kfree(vals);
+}
+
 static int mux_write_raw(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 int val, int val2, long mask)
@@ -171,6 +178,7 @@ static int mux_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info mux_info = {
 	.read_raw = mux_read_raw,
 	.read_avail = mux_read_avail,
+	.read_avail_release_resource = mux_read_avail_release_res,
 	.write_raw = mux_write_raw,
 };
 

-- 
2.46.2


