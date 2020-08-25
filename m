Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244F62518DF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Aug 2020 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHYMsP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Aug 2020 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgHYMsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Aug 2020 08:48:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99104C061574;
        Tue, 25 Aug 2020 05:48:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so6768693pgf.0;
        Tue, 25 Aug 2020 05:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4269fKP33XlJpXg8yjCtAkVnsXDMAY6w7aJ7rv3Q3M0=;
        b=cXoZCcdhfytkmnTMsokXvLlvrp+x9/j5jLJpaflRFfXKbkLI8fNXIoVs2NJVWTXVCl
         CbygMLkkVo3e1I0wxWWbEosJkqHRLxfOR7WH+HmcWtVcLNm+6QhC+SlRMyCDuoVaO++l
         3u77s46eU8Fti9PGm4wrerGQU4lRaZ+8JgKRRc47TGwBMYMYe2WyDmQNpW08Tk48vV8J
         EWBbsR3Tj3LJu2UtGGTdCXZZSdg0csCGc+vIioXNGWlSVEokqFcnzCUcttuOnQFOFcIX
         Su3SAfZDF9FyhvdGdAKvW7D4jjLfbkVxx1BrpD/t3ItTJ1PtfXlLCEIvy2UyRhD4mfY7
         8kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4269fKP33XlJpXg8yjCtAkVnsXDMAY6w7aJ7rv3Q3M0=;
        b=kcrrted2cL65oBDx313u7t2pQVLPqhsK06eLg4/tIJV/wGK6HzNux0GXTy0UXaEfpI
         YgvXcgS6OTE/6xAhKywiJLLuWMQCaXhvDgo5bW9IWN93igM0dorwH+VpGHOQQbGv4cAh
         PTo4cmigLGALiTqfYvjBufekMWM/bMj/b2ha4Ros1zt/8R4ePPmCGbEUmFRPHOqvavfr
         cyLpQIRRC4nQYvO3yLyWximgBIFc5bYgi/tasPjsmmKBIGPlDdUk00SELbjFDdfwdPDB
         WQTYoTfyaFJ5LbfkjbRiJ6TI3I5VkE3MZ7SYjRLo26cTqQrBzEPaDK6/9r1qL6LgJfYq
         Ek+g==
X-Gm-Message-State: AOAM5309dos15yXEkcB7mRgiA8rdl6Ha/2K/70qF+4ooduzRfnEjqU99
        ydYPNJQsyLinl7rR/iUQjGM=
X-Google-Smtp-Source: ABdhPJyKqLBHjOHXcKbgxx6YQqv8L76E4HOjzEbGrQ+8+X5EMajVHExAlrgCk3/r9dhSPzwIYbVZBQ==
X-Received: by 2002:a63:161d:: with SMTP id w29mr6416171pgl.16.1598359688232;
        Tue, 25 Aug 2020 05:48:08 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:619:dc6c:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id a20sm5675597pfi.11.2020.08.25.05.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:48:07 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH 3/3] iio: gyro: adxrs290: Add debugfs register access support
Date:   Tue, 25 Aug 2020 18:17:11 +0530
Message-Id: <20200825124711.11455-4-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825124711.11455-1-nish.malpani25@gmail.com>
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
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
 drivers/iio/gyro/adxrs290.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 25046590761e..b0050cdd2b90 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -435,6 +435,24 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxrs290_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			       unsigned int writeval, unsigned int *readval)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!readval)
+		return adxrs290_spi_write_reg(st->spi, reg, writeval);
+
+	ret = spi_w8r8(st->spi, ADXRS290_READ_REG(reg));
+	if (ret < 0)
+		return ret;
+
+	*readval = ret;
+
+	return 0;
+}
+
 static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
@@ -547,6 +565,7 @@ static const struct iio_info adxrs290_info = {
 	.read_raw = &adxrs290_read_raw,
 	.write_raw = &adxrs290_write_raw,
 	.read_avail = &adxrs290_read_avail,
+	.debugfs_reg_access = &adxrs290_reg_access,
 };
 
 static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
-- 
2.20.1

