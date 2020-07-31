Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8C234992
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730924AbgGaQtl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 12:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbgGaQtH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 12:49:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3756AC06174A
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:07 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j8so19933435ioe.9
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kJxFQ5dicx/XdfMjNZsxOmoMpHKnwMI2oZ1xqNHvk7E=;
        b=YhRnLi0kUNL57DqqpZqj7QSpzSWeeRK75/1uhIBZH91Ny2l1EJFxkbrqSLgfXnFW5C
         VmN2t+phogi/sdui2npf1W399a2tUvJNs/d/E63wIMD8LJIY30S14yJBGcvkj1XR8Kyd
         JOUA6dec9CQhMz17YnM2kRyMlmb5uCCQard9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kJxFQ5dicx/XdfMjNZsxOmoMpHKnwMI2oZ1xqNHvk7E=;
        b=FqHx/3J6eISyib+F8DqrGhpmlnh9LritWwmydNf0vxwojMs5E9T40HpwpPouGI4MrV
         AwfA7R+J2NbE7VnptjvsBzWRfl9EoRT3eGUrhII31o5HWX6LAHAkpCyFP6hWVg3TG2X+
         /mJQyrtCffeqCDLfvJKjiqgJuSRsgTuU4SMHMKzLKD08P+G3m1TprE1LGLeA1mZVPiOE
         PHGFrO2wKEMfJCOefgYmW6Nqyh/8JUz2i0mi04TGa6PMtosza3H19Bd7gOAd071tcYch
         z12o45QJerW0/9BROG+73x3f0BbrGkV1jtJ0LzxbhhGwch1+o22IGov2gKEPv0gsfZfI
         K9bw==
X-Gm-Message-State: AOAM531DOX/G5bkl8UoVxYKKFgvkAKOfRQ2FpbyTL7tueRYl4BmknWYN
        7aAO4RQOH3sYrLiAGMrCbQRCTw==
X-Google-Smtp-Source: ABdhPJxphulmJ4n52qeAfu6XFsVF+xiIHnLgNMg7tfM3ebQTH0fDaz1WZm5ZuRohQLMVb4GpcVK00g==
X-Received: by 2002:a6b:b215:: with SMTP id b21mr4371808iof.43.1596214146567;
        Fri, 31 Jul 2020 09:49:06 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id e84sm5122083ill.60.2020.07.31.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 09:49:06 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v3 09/15] iio: sx9310: Update copyright
Date:   Fri, 31 Jul 2020 10:48:46 -0600
Message-Id: <20200731104555.v3.9.If88afce92bbc1e97a532874cca35e642a9566172@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731164853.3020946-1-campello@chromium.org>
References: <20200731164853.3020946-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes wrong copyright year.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 9f6292cc86146d..19253bf335437f 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2018 Google LLC.
+ * Copyright 2020 Google LLC.
  *
  * Driver for Semtech's SX9310/SX9311 capacitive proximity/button solution.
  * Based on SX9500 driver and Semtech driver using the input framework
  * <https://my.syncplicity.com/share/teouwsim8niiaud/
  *          linux-driver-SX9310_NoSmartHSensing>.
- * Reworked April 2019 by Evan Green <evgreen@chromium.org>
- * and January 2020 by Daniel Campello <campello@chromium.org>
+ * Reworked in April 2019 by Evan Green <evgreen@chromium.org>
+ * and in January 2020 by Daniel Campello <campello@chromium.org>.
  */
 
 #include <linux/acpi.h>
-- 
2.28.0.163.g6104cc2f0b6-goog

