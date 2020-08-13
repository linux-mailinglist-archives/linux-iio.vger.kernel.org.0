Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23798243580
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHMHx3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 03:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHMHx2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 03:53:28 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354F8C061383
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 00:53:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so5131064ejx.12
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3SRzmR77BhVenou1yvCnpNBppbK1FtB0xdOMAqxSE8=;
        b=qwW6bn2TiHt4FsYBMX23jSvyyN8awZ36xC7SYf0U0c8+eWMd7beq5KONEbDQnN46eG
         c0UFQMTq9kKlR+0uemeS9v2Hx4aq72VCiI0+gwoXHwDYE2OETkb6EzZapz03w0TqV/Mu
         e0AwbiDyW1uPFWQkruDjpNNXTGpVcrDqhgBwt6rn6ePEGjFGdtNsKVufXtOOw8VSo8tO
         SUp9e4hOTckJKLpO1hcOX0WgdhverW6D8W3UYN5I4UDQvrfAQ0In6wKW8LPM/DFB1BR0
         SurQaA5Svt88U/tl0juJSYKhYvwr0v2i2SGu2AkOJgyc0j7Z0vOfHnHMdbQEropRHusE
         gsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3SRzmR77BhVenou1yvCnpNBppbK1FtB0xdOMAqxSE8=;
        b=GCANQsWGoyWGQS9Z+AtlTLvcj0RijdyJnaIC+fxN27pIzWlIqNL6UiktxDdNJ6NDG4
         mmxgC09Rl/ApmnVq0tN6zW6m8CNc/d9cHLwyLfWnKo+tuvgycvizTPi3/gOPScPkaEJ/
         KeLs203AcgbiiajxGC6e/Kcahprqn1CkA+qcZW2O2DybM6yxX6j9UuYepwmUxZK8yio4
         CZ9rMfjhTnlBMseLfxQJssYC5qqw+cGYXus1z5eq4+XT/vVgFuMS+NmwLQUsqcmRqadK
         u5x+zwn7yL/YbB8g513fdROPUAn6W+897u6N+//CnxPQ9nh9Pdr4RgyyQZVrlJlBcxNM
         +UZQ==
X-Gm-Message-State: AOAM533UfjhFUyBiqgPHlxUeAFGtBvIJDmG8pmwCsv7drLYWOwlgMrD0
        HHF+UaVAmyJamJpYmHfxXfjXKg==
X-Google-Smtp-Source: ABdhPJw8LM/IpHM0qmcOGio9AVXPGq0fsKQtQGvTSBavvy88/Lcmw1BJ/eTh/vgEVzcTH1ObrnMgIw==
X-Received: by 2002:a17:906:b5a:: with SMTP id v26mr3752056ejg.515.1597305206858;
        Thu, 13 Aug 2020 00:53:26 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyw9mz6ybkfgzn4.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:8d0a:592c:7d6d:8770])
        by smtp.gmail.com with ESMTPSA id br25sm3363449ejb.25.2020.08.13.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:53:26 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 2/5] iio:temperature:mlx90632: Add kerneldoc to the internal struct
Date:   Thu, 13 Aug 2020 09:51:22 +0200
Message-Id: <20200813075125.4949-3-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813075125.4949-1-cmo@melexis.com>
References: <20200813075125.4949-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document internal/private struct for mlx90632 device.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index c3de10ba5b1e..ce75f5a3486b 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -89,9 +89,16 @@
 #define MLX90632_MAX_MEAS_NUM	31 /**< Maximum measurements in list */
 #define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
 
+/**
+ * struct mlx90632_data - private data for the MLX90632 device
+ * @client: I2C client of the device
+ * @lock: Internal mutex for multiple reads for single measurement
+ * @regmap: Regmap of the device
+ * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
+ */
 struct mlx90632_data {
 	struct i2c_client *client;
-	struct mutex lock; /* Multiple reads for single measurement */
+	struct mutex lock;
 	struct regmap *regmap;
 	u16 emissivity;
 };
-- 
2.25.1

