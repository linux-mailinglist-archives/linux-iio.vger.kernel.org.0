Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C2264623
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 14:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgIJMgY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgIJMdB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 08:33:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA80C061757;
        Thu, 10 Sep 2020 05:33:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d16so831768pll.13;
        Thu, 10 Sep 2020 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mAC7AY2dom2okuDhz5TwwH+eN++c0Zg21VAJ30tmZE=;
        b=qG/rKcK2HhixjeHOwx22cnu5vsq8XLz5RXaPsgu9QDXQi0LEGNYwf6bpkI5tuOVfQT
         qL94/g9KbH0MlePhTboZv1bJUtR36YPqv+MbGfsqVXmu+Pc7gs527U0DLNOq2WYytdgI
         P3KsMw7cWHxNhbHzImQRJBSsk2vprNBqSXj/tC3ub/BKPPqhSgOxjhXzbseGFv15Jxlx
         LmmPekD31CngpQVRV1iRcLrwUXYE9y7kymgY5eNhL5o9G9grrXtPUj6862e9XZd7kBFP
         u/qtP2vXk/DHK7cOlm6L2z46IB1k2nCopfwArf4KK0oRAfF+B33VAl4wFMWfUYLcT/T9
         vtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4mAC7AY2dom2okuDhz5TwwH+eN++c0Zg21VAJ30tmZE=;
        b=IvznwsfCnS262FikdhG5KNk+Q6736DELg7yHjNIvE4zJotlmWroF6QF53JeB4qLR+h
         d1K7oxyXUfRuY/6/MuAVSJy1fzJVYj13fYYJxBK7fnG2YWJHYOWXB5Mwnzyue4u90ty1
         dABEar+eU5fKNlx16LWfrlhouCk/LmDGSxkwZtdL7JWnEjiIS5SuD8fcEPDuupaAAPEj
         5epe0uvU3YF5j3qKCC6iurzanCOZk/rU4zTwjKvHNEUwlFRACWzzT7+rmAx0NCr+yb2H
         +rXktMmw4mw8E1p0iTLjvYOXVRersRxN2TfhyeA1DceO2MA9j6DgY3YSY0wcr95A85dG
         seDA==
X-Gm-Message-State: AOAM533YJuH6/eLHFqYsFT8sTBaMRuBnl9VloKNjIcXfSIzz7C7u365g
        BcYH4P6NIVJpNBuVReDmI14=
X-Google-Smtp-Source: ABdhPJxLK5IOkPuZQSvSgkg8AkXwFKqrh/T7qtwK4UBm7gI5yfAXyN4l5FBr5fZALkKhZHOCS02vEg==
X-Received: by 2002:a17:902:74c8:: with SMTP id f8mr5383439plt.78.1599741180451;
        Thu, 10 Sep 2020 05:33:00 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id j14sm5031485pgf.76.2020.09.10.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:32:59 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v3 3/3] iio: gyro: adxrs290: Add debugfs register access support
Date:   Thu, 10 Sep 2020 18:02:49 +0530
Message-Id: <20200910123249.17204-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extend support to read/write byte data from/to the device using
debugfs iio interface.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---

Changes in v3:
  - refactor code based on Andy's suggestions

No changes in v2
---
 drivers/iio/gyro/adxrs290.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 41b1f995a143..ca6fc234076e 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -436,6 +436,31 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxrs290_reg_access_rw(struct spi_device *spi, unsigned int reg,
+				  unsigned int *readval)
+{
+	int ret;
+
+	ret = spi_w8r8(spi, ADXRS290_READ_REG(reg));
+	if (ret < 0)
+		return ret;
+
+	*readval = ret;
+
+	return 0;
+}
+
+static int adxrs290_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			       unsigned int writeval, unsigned int *readval)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return adxrs290_reg_access_rw(st->spi, reg, readval);
+	else
+		return adxrs290_spi_write_reg(st->spi, reg, writeval);
+}
+
 static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					       bool state)
 {
@@ -551,6 +576,7 @@ static const struct iio_info adxrs290_info = {
 	.read_raw = &adxrs290_read_raw,
 	.write_raw = &adxrs290_write_raw,
 	.read_avail = &adxrs290_read_avail,
+	.debugfs_reg_access = &adxrs290_reg_access,
 };
 
 static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
-- 
2.20.1

