Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF30230D38
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbgG1PNX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbgG1PNW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 11:13:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0325AC0619D8
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id t15so12176739iob.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FDqTksQ36evV6y3c+mmwks3K6Lhx7dvyjiJBLqUyvDg=;
        b=k8Iz73x9o5wh2wBk4SqmFDSosu25UGC4vA/PCOWk/qgNtUamQLHAJvXnBScg8d/Sbg
         BJic5xDK6f9/0KLBBrFu0YppuWQ//oq83P0kWACgrequ3lAGaSzkAmWLaVXQxevn0kfa
         qZUR6686Vsdxjpb6LajhgItklVeGH6lvWKaDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDqTksQ36evV6y3c+mmwks3K6Lhx7dvyjiJBLqUyvDg=;
        b=rh+sPnnIk+CD9by6m35yV1OA8CLGMiK0H3fKXht7ALNeERSIdbGF/qrcqNz/hMUrxt
         mXY9P/MFEnrPvS07fSak7fCWvreRh6ih8cBrc84LWJ0KFWKTRpjzphyPRxN1F7JHNNfV
         TcRrv0PgfebShM0bilU2fStINqJeeO7z4bp1x1Ugd/lLFDB/LxTdYwKOGkqm648/9JJn
         V85qX2QOu+r8WUHILK8mDRMcGxtCLJ73W+E3UBmAnNl87BKNBIXFJAgOtXrIM2p4NIjL
         T1PkbLalTHZOWZMJfKQSyMnKDOkRPNQnmWtL6RiW+Ql49pFYQRr1mwZ6TTOVPVqpV/P/
         7KCA==
X-Gm-Message-State: AOAM533krOlJxLmlE5dN0oS79Y9DVwkWmhxdGstqSy0bj/NPyq34Xqoj
        cqZuXXhrPLQZao6KW9ZNyeE32Q==
X-Google-Smtp-Source: ABdhPJy15gMJ7gQGSdMcz49FoSB23iVg0C4f7La2orWJtBBVztmxfQZeOsfkrvzTws1vzuKZP48UPA==
X-Received: by 2002:a02:a584:: with SMTP id b4mr22046511jam.68.1595949201432;
        Tue, 28 Jul 2020 08:13:21 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:21 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 09/15] iio: sx9310: Update copyright
Date:   Tue, 28 Jul 2020 09:12:52 -0600
Message-Id: <20200728091057.9.I3bc9c85e4b0dec9a67b4af91cd6fd451a238ec42@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes wrong copyright year.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 3956fd679c6db9..31234691a31abf 100644
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
2.28.0.rc0.142.g3c755180ce-goog

