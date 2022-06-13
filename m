Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935C654A2AB
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 01:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346038AbiFMXWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jun 2022 19:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344622AbiFMXWk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jun 2022 19:22:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804213CD2
        for <linux-iio@vger.kernel.org>; Mon, 13 Jun 2022 16:22:26 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o6so6367086plg.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Jun 2022 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3RxiogwxQ3efUX3+sbp3cwVCT5XzvkaPhVLnHLET4Y=;
        b=BqiMiN+lQO+8l/tGBuOxJn2dFR3aFYKX4uFwvVPTVw9Tj0NCQMlDy4L3Ic/ONqIl31
         wzplWXTVffQhgKN0pb8Qe6+UaeYgrIuAGQgjchacCAgw3eH84QGONtmqN+2GuLf5sKqy
         8neAm2iWJ61No+MZXjc82pQNWaZZjB6WB5IMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B3RxiogwxQ3efUX3+sbp3cwVCT5XzvkaPhVLnHLET4Y=;
        b=ddzLKHIWUkY35giHC2PqR1iMXXfn2+AwTAziiWKJIyri+4t3w5vbXAkOAN1EdOR/0P
         qxkKcAJ07Zzm7z1dnTzKfxA3r1u7TaZa6Z1fEJLtpYeOLwTW93wC18iNfiQK4kWjxvZd
         t0q+TlWF9vbu1QX15fxgyu1rRjSRG9XCjVg4ekYhjSlYwb9wig5Y1UEzaXbulpOendMH
         U5MSeFISNyweGWFPqCO3doU/3ERnWMwxqmOyIzoThNXFnxP31ZDa26bt7VijKWxoaFE1
         pQBbrpbgNeoL1RST4JXaN7Zj4SwuTTyr8hn8rekPb8rIqZDg9YKnOs+mot0AbvfqjLv7
         CIOw==
X-Gm-Message-State: AJIora+9dAOXTseLviBUJE6KhRr0vi/17qm8pHl8QsljoVUNWwSq+52w
        XlMlDQycRTwdCc8JxGlwl3ikGw==
X-Google-Smtp-Source: AGRyM1uhlZCnyIP4x2P9IFkCataXFtmzmEbxJHxrC4AW0Y0NWP6mb3j4cyOf8LdmLE/f++Ma2sk8Zg==
X-Received: by 2002:a17:902:d50b:b0:165:2aa0:4b22 with SMTP id b11-20020a170902d50b00b001652aa04b22mr1358214plg.131.1655162545532;
        Mon, 13 Jun 2022 16:22:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:82ae:1136:b202:95da])
        by smtp.gmail.com with ESMTPSA id s9-20020a63af49000000b003f5d7f0ad6asm6057407pgo.48.2022.06.13.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:22:25 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Aashish Sharma <shraash@google.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio:proximity:sx9324: Check ret value of device_property_read_u32_array()
Date:   Mon, 13 Jun 2022 16:22:24 -0700
Message-Id: <20220613232224.2466278-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Aashish Sharma <shraash@google.com>

0-day reports:

drivers/iio/proximity/sx9324.c:868:3: warning: Value stored
to 'ret' is never read [clang-analyzer-deadcode.DeadStores]

Put an if condition to break out of switch if ret is non-zero.

Signed-off-by: Aashish Sharma <shraash@google.com>
Fixes: a8ee3b32f5da ("iio:proximity:sx9324: Add dt_binding support")
Reported-by: kernel test robot <lkp@intel.com>
[swboyd@chromium.org: Reword commit subject, add fixes tag]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9324.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 70c37f664f6d..63fbcaa4cac8 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -885,6 +885,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 			break;
 		ret = device_property_read_u32_array(dev, prop, pin_defs,
 						     ARRAY_SIZE(pin_defs));
+		if (ret)
+			break;
+
 		for (pin = 0; pin < SX9324_NUM_PINS; pin++)
 			raw |= (pin_defs[pin] << (2 * pin)) &
 			       SX9324_REG_AFE_PH0_PIN_MASK(pin);

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
https://chromeos.dev

