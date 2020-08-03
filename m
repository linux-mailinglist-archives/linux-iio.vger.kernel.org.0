Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA1523B15B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgHCX6d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgHCX63 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:58:29 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88D1C0617A1
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:58:28 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so32709025ilh.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ELKF9ec+bgCGrmRBpVhFRB+v1oAdFtZBSJFoNpDtSg=;
        b=AQG8WLSUE7F0Y7lHcTLK/jOh4FqEm2TpRLngA4PjYTe8CiScStdPZmyzqkkuB4C21D
         HNLzSX4DSNToz51VKQfIA8n8wiZspry+1anoK/+DchHTMt6gEz1K8g5KZRq1E8jwd3vw
         Oaoc8w+FlMUl0QsHgB3FxzhPDsJJ4v72xaF3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ELKF9ec+bgCGrmRBpVhFRB+v1oAdFtZBSJFoNpDtSg=;
        b=in9i45losQ7dOH0ymGyoRG1s3BJRixALbQ3yAANm/LUXeMBSQ1Up4CU+G8TCGLOEQv
         kIlMyoa9xt2dghvEz7fdqdmkDn2yUftO8wKs/0tS4DzwY/JoSTuKoqr4JeG2184KzG7f
         nWu4ILYV2NXd+IO5ORu7JqEkjyth8QJ7YoIXBvWieD44/P31zztHBdJ11h6QVrSuhXeF
         XtblvYpZX2EI7V1AHTcC0c15dkfJfeUHzJl9iOapk5x2KKeAXj0MntP16pCDUUZHykVG
         bCYfwIkQVsJGM41L/fbv/4v+W4BFcfYZcbCpxV+g00VM38jlEQFsBdIE0p5ArUZHOuJA
         7y3w==
X-Gm-Message-State: AOAM533pfdNjtWW/aRrC9s9Udw1eKrrbj8ocNEUQDxzgc3oiE9Yg1WON
        3y+7cHMTVwGBAicWhEfhkv5Ngg==
X-Google-Smtp-Source: ABdhPJzM3ewapIc/I387YNT8yLabRY71+pPRS2PREUOW3neIQ0APB+WeM5kZQzDQS9hcR8lhmPjT+A==
X-Received: by 2002:a92:c811:: with SMTP id v17mr2116473iln.46.1596499108395;
        Mon, 03 Aug 2020 16:58:28 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id x185sm11075992iof.41.2020.08.03.16.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:58:28 -0700 (PDT)
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
Subject: [PATCH v5 09/15] iio: sx9310: Update copyright
Date:   Mon,  3 Aug 2020 17:58:09 -0600
Message-Id: <20200803175559.v5.9.If88afce92bbc1e97a532874cca35e642a9566172@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803235815.778997-1-campello@chromium.org>
References: <20200803235815.778997-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes wrong copyright year.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index cd7de40a55c2f6..87b2de0d7b55a3 100644
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

