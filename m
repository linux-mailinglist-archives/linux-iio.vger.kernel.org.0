Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0ED2315F8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 01:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgG1XFp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 19:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgG1XFn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 19:05:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F9C0619D5
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:43 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so22598225ion.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zrnzrCoKEWeE81dCToZoirYnah7fEgy4EeGaV1goVo=;
        b=DydXMiSrRsEIeUU7miQpFxxAjAhV7X+y3RskPpI3JZmndgPZPIdWf7BCTgEI6q3lFt
         Bpy+FSqb9bO5fOKtU/pA2yKz4dqJzjR8B913BA/9DzP3wTazmT28Wn6CNVmC95HiQPmg
         70z+S9Xc0UcLL0BkhBfp8ABEELu7YQQkGX4iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zrnzrCoKEWeE81dCToZoirYnah7fEgy4EeGaV1goVo=;
        b=FBGMFNkgyJc+c+HBBFJ9McRlTffxoDuTWLiIHayG/aN7WS5EoXi8tmTtWjWRHP0zQy
         YBHdXDjICRw5/apFSukgf7qkYgC6LAXQM9eZNE4Hb1l/60U09Vkunziftn1wMwXmttME
         giSK+19YONgJNFAgbY+8hnBut+oa5zxLcamGL6cFna8y1+phKCiu0Vhcdqcixw2m2pt8
         mYh+Jwf17VlFpQcrH3/AS5YH+wjgnFP+jkKJXqSstU/8Qkb99wVupHGdhn3vw+I0VZIy
         Y3JkqHNwmG9l20HwA7WS5tluSm3IWzA9mnQ/rwfOeDF3s+fvR9gDd+0RJ99Ax/3op1cB
         iKcg==
X-Gm-Message-State: AOAM533PlOejeLnn3+IIDMJOTinm1pfNCWUngEFoF+TStKyTh99fsac4
        R2V2ftjFFemkwy8Illw5G3TN1w==
X-Google-Smtp-Source: ABdhPJyDvvNtb/jr2igDgSMFVbx6LJsI+vkgKiFAJh+OY/eCw9W1sc3ojZq633se1q8uIBVpYwjIaQ==
X-Received: by 2002:a02:ca1a:: with SMTP id i26mr31673302jak.20.1595977543089;
        Tue, 28 Jul 2020 16:05:43 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:42 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 09/14] iio: sx9310: Update copyright
Date:   Tue, 28 Jul 2020 17:05:15 -0600
Message-Id: <20200728170317.v2.9.If88afce92bbc1e97a532874cca35e642a9566172@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes wrong copyright year.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v2: None

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index f7f44fd9198499..964fae90fefc25 100644
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

