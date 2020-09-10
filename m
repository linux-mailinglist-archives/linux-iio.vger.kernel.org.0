Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F0264C3D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIJSHM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgIJSF7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 14:05:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E14DC0613ED;
        Thu, 10 Sep 2020 11:05:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so4643809pgb.8;
        Thu, 10 Sep 2020 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zosGERDH1CFvyq304LgFyQ88QlOJKzUmNYvnZLuiMG8=;
        b=CH6PGgp3FSZ4qxodNPZ+nSskkygJJKKwLoJvqVniOEdi19tjDcntzdPZrGsN55HZnh
         nD5HK0osrtlErQmXrv8SJPuQ5qxhusfvT+Wxwi/vyIYnOkgj7lEzHhvFXVqslrVMn0Yc
         jFxrG1jhPRmNvcHl83Pak8EAHXbSelAeXCw7keaRLR/6Ca9/K1bNRK3gj9bmmBCDEYXD
         4Q/WeF5uRWQO4i/zArgDcqf9BGiDSB14YqjHWf9fjnahIxkoUVMvXlgGOjyXTjkYiIUW
         YFFjegD82vq5KZvBGn7n/DUlL1UXxtV/MyJrwzCcAHsJbg7t0P6WJTfEfE4uKkqvrGxS
         IWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zosGERDH1CFvyq304LgFyQ88QlOJKzUmNYvnZLuiMG8=;
        b=sxhqhlYy/IXYoo8PtS2RMBAa3crBvXeI3YD9PesOTLMp76hbf0kNWnmKBMHncAJ00W
         5YvTospuDjnz26VTpVHjnVXM+qRE89/mjxVFX14mJo0T6jWV2zJWmGE5Bi4bab6U0Vk+
         8Tz/4BWROZEjhkapGWUwKmuMaufx8ao83mY8Dvx7Q4aTKn9Ve87Bq5YVRgPz1VSlgQYB
         sEvSWymlC/NRhYaJacRObU0XiPmFUaj9kcq9ig1CSoXgZJlJQdbFW0Lozzjj5Q55zv6E
         ujuOWbSPyRrHaQGsOE9w40G2r5gctljuWwnlY7nWKT71mWSxowNIYjwoLx3secBytrtk
         tcjg==
X-Gm-Message-State: AOAM531ZBCLfbL4pq1VBEqH2qSDh31XuAo0v8+GYxRD8FM4hmekChHJT
        sXjK79/vMdw4QTuu4IVS3p0=
X-Google-Smtp-Source: ABdhPJxG9TWQJkNAZIED4Ou2mwJSB4vVmMpq06OclCcEhQb42xioXYD1oDdA06kF9HBMjA9cMMrCbQ==
X-Received: by 2002:a63:c608:: with SMTP id w8mr3103345pgg.252.1599761158935;
        Thu, 10 Sep 2020 11:05:58 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id 64sm6679090pfz.204.2020.09.10.11.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:05:58 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [RESEND PATCH v3 3/3] iio: gyro: adxrs290: Add debugfs register access support
Date:   Thu, 10 Sep 2020 23:34:50 +0530
Message-Id: <20200910180450.29696-4-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910180450.29696-1-nish.malpani25@gmail.com>
References: <20200910180450.29696-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extend support to read/write byte data from/to the device using
debugfs iio interface.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

