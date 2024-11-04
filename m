Return-Path: <linux-iio+bounces-11902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E52269BBE25
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 20:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC8428260A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 19:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94341CC14C;
	Mon,  4 Nov 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RntU3pAB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBB192D7D;
	Mon,  4 Nov 2024 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749264; cv=none; b=sEd1ijgQvS5ujHHI3VKJii9GYI4sa+cBh8D0Z0oYJessHynLUJ3WTq2dMOdT4IZJlq+4a66Pa8ugkQRx7COwtc5o/r9jbx8eemNP5NoFZqiTQWuyW5FWNROjfIQqgSNsIESwG1K71mILnyknlo0haNbNQj714smLE0A0q01p7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749264; c=relaxed/simple;
	bh=Y3jD3q5koG14pfycXy+7MQg4wF8GRHXqfwbn5TH/VYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M5/46oIUfi9268aG90o1wO9HpmzYMhAFCjHJyqWd3ljnN/NhbtBMjEN5kNBUPnzzEHwQKImxApTlGDZprJXv9s2fNNhIJRJo5EbbkUVUtpsu2sIFCsRsmoEJyXoT0ev/HDAnPg7eU2VXgQtq1lGkpPJOUmvsDvDxmzL9bhRTno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RntU3pAB; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7180f2f5fb0so2286611a34.1;
        Mon, 04 Nov 2024 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730749262; x=1731354062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJT5krB5XufQGhH3Tox2znwMJFwXIdl0irZoryzwyQM=;
        b=RntU3pABgvyE72+O2Wv+hmWVvu03D0apTKu//YcH4FjHErM/UUNwIaElQGwc2alyZu
         CX/nR7iJlNDmlTW1cwhE+KjWM/i4RcG2FUb3gKMkkVQT58cmvatLCyxi9qrZCVhgw4SX
         H9rgLiSFfca3k3LMmwUqHTbhmzws26/FX4f23MnxXvkywHK/r/auY3TRg5L7K1DGhOdF
         hUDf/p2jjrUsyKFHy9QAfxhQJc/vvJVxBo/lmxMScywDUK0V9G6Ol52kh4Ykndov/CAN
         vbMiVqYZkatepsYhNTrDc3yaDp9BGZ/mV043h4WS3OXO7oiTneUBIrTGHaQ/lWnVfNeK
         /2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730749262; x=1731354062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJT5krB5XufQGhH3Tox2znwMJFwXIdl0irZoryzwyQM=;
        b=L7+aNxKl4C7vfk3jqxUDnpuaHRlfqdM9t8D5Pyp/fw/7Xy3UJSc5Kgqe03NSP4PuFE
         l4n5sWEk2idtOom/H6lPeouUZr0d0oxqEPfSsFBLycqyupvR1O4Sy1FbGPLB8IJsrwEb
         W4aHQ+s4W9LrQ06bq3EgEnsT2NBmw4p/GW6LxpZfJViOinyeaGvN6pktApaOQ1Vmuysw
         KGZzn71DZQKz7raruCbNAXbeNqkYSvXG47Fio3HksKwuB4KgIAPnuEa32P64/oA4GNoo
         LkrlfFK0/oqDMBjwl33M69jn8esswdKXlD/22SVH5I8JS6ADPeVu6bw2QE5wHovX8FuZ
         jHvw==
X-Forwarded-Encrypted: i=1; AJvYcCUAt4gXUEuSo7lrPS2XniDaMJnnW3Gee4wtwvsy1hCCJEGs4Kht6nh78tGHxOBLvaDiqO3J/Mklywi05Q==@vger.kernel.org, AJvYcCWCVbEHEvJiEaXzgqNFj1EocQLEXwopbeBReFU47j1umtRwNvojx286Jk2xzZeYVe7GxIlu58Y2FTl1Llg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymLULc2lzCBOPUsZKUqOlX9vNzyUaAea/8TIYzjRSHcC4Kp/s6
	EmLM2aJ7hp9nlzY7+JP/xfAiTgtDBMZ4ZrhXlgz1a5IF8yFo+lvQ
X-Google-Smtp-Source: AGHT+IGO7H0j2BHm469+taAk9ltYjhMSzb9FLmmlZZadSeYWFTq85X8wDz3MI9lCHoSRvdvWNMbckQ==
X-Received: by 2002:a05:6358:7249:b0:1c3:7b8e:c35b with SMTP id e5c5f4694b2df-1c5ee9b88e1mr760796855d.19.1730749262114;
        Mon, 04 Nov 2024 11:41:02 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc4a33sm51649656d6.33.2024.11.04.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:41:01 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: wbg@kernel.org,
	vigneshr@ti.com,
	jpanis@baylibre.com,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v2] counter: ti-ecap-capture: Add check for clk_enable()
Date: Mon,  4 Nov 2024 19:40:59 +0000
Message-Id: <20241104194059.47924-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() in order to catch the
potential exception.

Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
Reviewed-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Add dev_err() to indicate the reason for the error code.
---
 drivers/counter/ti-ecap-capture.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index 675447315caf..b119aeede693 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -574,8 +574,13 @@ static int ecap_cnt_resume(struct device *dev)
 {
 	struct counter_device *counter_dev = dev_get_drvdata(dev);
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+	int ret;
 
-	clk_enable(ecap_dev->clk);
+	ret = clk_enable(ecap_dev->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock %d\n", ret);
+		return ret;
+	}
 
 	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
 
-- 
2.25.1


