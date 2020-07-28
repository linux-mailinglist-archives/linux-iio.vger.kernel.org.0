Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8A3231435
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 22:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgG1Usa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 16:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgG1Usa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 16:48:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6684AC061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:48:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ha11so708286pjb.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlQewahdhsPckNPSzzDVJ3WH731NYXJ0lt4sgv3xG4I=;
        b=fBInYdWKn71gr4DauDTi2NW47uFu5ON9YD3mrq9aPgokNNY7ayJCa3Q/BObSkGuVtt
         0N1z7RNFWHu2JKhMGuGsifRmlT0lFLWI1CpFSxiTa0M9anAy1NkUTYbCLcjIB/7+23DI
         oYQMANt2kt8qfbmecMNbvrswv0IoiwRDkbIqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LlQewahdhsPckNPSzzDVJ3WH731NYXJ0lt4sgv3xG4I=;
        b=SzLdhVp8RKPBZgIDjgmQXFOV7UFbpndWHyq7qdHZz26sgy79WNSlAB3RvaCiN/H5uv
         RP4DF0Yhnh/dg245wYh+SuiHaPGR4iBhQiJe2kBc+23fIzwNTQBPbKNv5ARXndVpX86N
         xU3sjguVcVH19nsczQmRbTPDZWVBamp5qc0+Zn9CFTJgrWXCsCSeUe/mTv7u4r7vZd6M
         uRm/xuceFsHuCm6/sLxdb/0oMOX3/YH6pxfmaCEFT71KDKUl53cowERZ4gs8jRCF7f66
         V84i0Ri7MYpG+Vf/XiW5KR5CmInHbvj9bvjCzZZQW99Ziu4ohZeB5a4MqAyxbfDRkf5v
         PCMw==
X-Gm-Message-State: AOAM530le0Imo1jqLHJPowiyjBbbAV7HnIXjIVet+T+U7lISeQVllBvC
        dZzBr7ZLk9Q8JmFUjU92S/OTGg0Ncvk=
X-Google-Smtp-Source: ABdhPJzJD7vZxto+2gqxzjgSOs0Ph8dL/bTvV0T2N3NIIdlyn+CqDiEXK+U6xILhVqsS8ydjvNfqJQ==
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr25066159plp.67.1595969309893;
        Tue, 28 Jul 2020 13:48:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id a129sm9826038pfd.165.2020.07.28.13.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:48:29 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org, enric.balletbo@collabora.com
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] iio: cros_ec: Set Gyroscope default frequency to 25Hz
Date:   Tue, 28 Jul 2020 13:48:25 -0700
Message-Id: <20200728204825.3312921-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

BMI160 Minimium gyroscope frequency in normal mode is 25Hz.
When older EC firmware do not report their sensors frequencies,
use 25Hz as the minimum for gyroscope to be sure it works on BMI160.

Fixes: ae7b02ad2f32d ("iio: common: cros_ec_sensors: Expose cros_ec_sensors
frequency range via iio sysfs")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Change since v1: Fix spelling.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 156848d27c473..213837c2ecee2 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -85,10 +85,13 @@ static void get_default_min_max_freq(enum motionsensor_type type,
 
 	switch (type) {
 	case MOTIONSENSE_TYPE_ACCEL:
-	case MOTIONSENSE_TYPE_GYRO:
 		*min_freq = 12500;
 		*max_freq = 100000;
 		break;
+	case MOTIONSENSE_TYPE_GYRO:
+		*min_freq = 25000;
+		*max_freq = 100000;
+		break;
 	case MOTIONSENSE_TYPE_MAG:
 		*min_freq = 5000;
 		*max_freq = 25000;
-- 
2.28.0.rc0.142.g3c755180ce-goog

