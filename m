Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15000222497
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgGPOAF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgGPOAC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D974CC061755
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so7203673wrn.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkghzH4FwjGUVQFUZPoQ97cOQabOY+KdLhABNUZLqIk=;
        b=S1ggKKr4PsJt4mnmFy83hI5iE2gJWJql1bB9gOk+PK5KznVZKiv0CzTg8eyKCXNTcP
         Hb0EIspfFfeYzKpt/O41IvcFTDh7L52KazjEkdupAVnk2gJ8bPVCLzw9Ph6/P+/C67Le
         W65BHf1ymoCwyGb+rT7YXibxWdGo4P3Zg3gmUGEMdVwGeb991gHdRaFrLN+cpM6Ni59f
         87Q3djAnHrpsXS14Q5Gm0Lp+kobOspNfNsFZ5emHq5g6uEsULserGcgTBSBvFcOuNdtN
         PnClSEw4/vzH4Z0eS+TjeSTu+aH4FHY1tiBDLOjG6WSO6Gmj9B0R0OtHEK9eW5OJlD54
         fmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkghzH4FwjGUVQFUZPoQ97cOQabOY+KdLhABNUZLqIk=;
        b=jedtoqkjbwn8GCTd7W8LNb8+SF3cYW9bAF8S1pJkoak7LKQskM0rgh8AG1/zcrmkM3
         4ue/xX4Wu6GkfmjdkxYFLhAXfkkDpklAj4oQgEiGFgS4oXN2sRl0PNqJGpvlw6uGZ7gK
         lcJqAjkFR/b4Esx8/5dSjVXM0wCI7dl9RofCCgz1oiBZvPIYmbQxj1/cS3spauN6v3ov
         HKoFFmcMsZTrRLVsgKXyBqdzeBHyPn2xVOzkS5SgS7PIdvQcKc+gIr7AIQRzuiuJjSnb
         weXJq+d0WyD4QYHG73v+Kump8Br7JlRdbSFai6I8f2g1H8u1Z1UHchZ/JGqagk0p4Mor
         QKDg==
X-Gm-Message-State: AOAM530j0T5fEa2Z5Gz3QWj1lF3WoYZrPQQkv8Og72jHGnjQcV6e+pQq
        +nEhBWrTVbxJl0YS7UAhgWeNPQ==
X-Google-Smtp-Source: ABdhPJzeVMIR8thnmbqfUj0K3saB+lmylMEVfVpRaOION/gNn16Ry4C428YCMr2eRk7YrRcwvvAk/g==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr5059867wre.369.1594908000543;
        Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 23/30] iio: dac: ad5758: Move and fix-up kerneldoc header and demote unworthy kerneldoc
Date:   Thu, 16 Jul 2020 14:59:21 +0100
Message-Id: <20200716135928.1456727-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc headers need to come directly before the function/struct
that they are documenting.  Also fix some missing descriptions and
misspellings.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'reg' not described in 'ad5758_range'
 drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'min' not described in 'ad5758_range'
 drivers/iio/dac/ad5758.c:111: warning: Function parameter or member 'max' not described in 'ad5758_range'
 drivers/iio/dac/ad5758.c:122: warning: Function parameter or member 'gpio_reset' not described in 'ad5758_state'
 drivers/iio/dac/ad5758.c:122: warning: Function parameter or member 'd32' not described in 'ad5758_state'
 drivers/iio/dac/ad5758.c:137: warning: cannot understand function prototype: 'enum ad5758_output_range '

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5758.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 475646c82b40e..c34740d2c89a1 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -92,24 +92,24 @@
 
 #define AD5758_FULL_SCALE_MICRO	65535000000ULL
 
+struct ad5758_range {
+	int reg;
+	int min;
+	int max;
+};
+
 /**
  * struct ad5758_state - driver instance specific data
  * @spi:	spi_device
  * @lock:	mutex lock
+ * @gpio_reset:	gpio descriptor for the reset line
  * @out_range:	struct which stores the output range
  * @dc_dc_mode:	variable which stores the mode of operation
  * @dc_dc_ilim:	variable which stores the dc-to-dc converter current limit
  * @slew_time:	variable which stores the target slew time
  * @pwr_down:	variable which contains whether a channel is powered down or not
- * @data:	spi transfer buffers
+ * @d32:	spi transfer buffers
  */
-
-struct ad5758_range {
-	int reg;
-	int min;
-	int max;
-};
-
 struct ad5758_state {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -122,7 +122,7 @@ struct ad5758_state {
 	__be32 d32[3];
 };
 
-/**
+/*
  * Output ranges corresponding to bits [3:0] from DAC_CONFIG register
  * 0000: 0 V to 5 V voltage range
  * 0001: 0 V to 10 V voltage range
-- 
2.25.1

