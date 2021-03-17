Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED39733EAA4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 08:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhCQHk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhCQHkT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 03:40:19 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1533C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t18so629285pjs.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRlbJMWwDuUDN4es0UT89P59wZTiBTlsknrAonJ49yw=;
        b=TIM4v4ipqsuq/UFj9hvQ45/C+kZgjazEiF9M6ubwAR7L+IhNDCVo6BIE2MZvahz/et
         dGEd8TBi1Vq3oxsw2o5jk0g2Y4UiWY6dOEUe/bALNFB+u11aQGkdzpKREPNSfA6ZMC7e
         thasKerk4lOD6uEtND7iFbS0wvUliqCgCoYjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRlbJMWwDuUDN4es0UT89P59wZTiBTlsknrAonJ49yw=;
        b=Ezrjhd6/WjdMpIRfRBrLElMvjvJMMPQ6bq/cXDxdURlXxndzl58bpzZduT+PZbb+3K
         JKlPtUlQUSEL+wp+DVm3SnCeP6/eSViAgR7jGE+Xf4jSCIHpxRK+b2sADOdcLTmntqdC
         k4aSlAzdFD+aH049HrbuurnYENeEDeisqI+dTHNT/BH+OfkPMSAEgnGgB64AS3/L4Vwu
         VAJkrkM938npcA5PFWmGPJN7lm1X3Kwm+4pAeZu+vkQRvP9Nl7BccU9xnBgd3wY8A0Sf
         C6d/qrfpbGJmC8lAiU/qwvBz91vfUy2qj+bbMD+NTGJWRPo54FTUiAkCC0R3dMTSz4kw
         p/ew==
X-Gm-Message-State: AOAM531BA4i8GCRjrzdVmwAzBbErltmoP8TCkNR1ptvn9V3U6lFzkwxJ
        z8cwro3qc+4HxIcTpAX1Af6Q9g==
X-Google-Smtp-Source: ABdhPJwWBeL9HeOBhPJm+25EkMR6PwTCWkApMExspAKAi0TGiMtpH+dtlOE+HZanlt6dmcTG3eLI8g==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr3117651pji.172.1615966819358;
        Wed, 17 Mar 2021 00:40:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:bdd3:3391:be74:f7be])
        by smtp.gmail.com with UTF8SMTPSA id n24sm18870637pgl.27.2021.03.17.00.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 00:40:18 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 1/3] iio: acpi_als: Add timestamp channel
Date:   Wed, 17 Mar 2021 00:40:10 -0700
Message-Id: <20210317074012.2336454-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317074012.2336454-1-gwendal@chromium.org>
References: <20210317074012.2336454-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add timestamp channel in list of channel, to allow retrieving timestamps
when events are produced.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 No changes in v7
 No changes in v6
 Changes in v5:
 Fill comment line.
 Changes in v4:
 Fix spelling.

 drivers/iio/light/acpi-als.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index f8e547fd35e7a..784868aa8fbf7 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -45,24 +45,22 @@ static const struct iio_chan_spec acpi_als_channels[] = {
 		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
 					  BIT(IIO_CHAN_INFO_PROCESSED),
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
 /*
  * The event buffer contains timestamp and all the data from
  * the ACPI0008 block. There are multiple, but so far we only
- * support _ALI (illuminance). Once someone adds new channels
- * to acpi_als_channels[], the evt_buffer below will grow
- * automatically.
+ * support _ALI (illuminance): One channel, padding and timestamp.
  */
-#define ACPI_ALS_EVT_NR_SOURCES		ARRAY_SIZE(acpi_als_channels)
 #define ACPI_ALS_EVT_BUFFER_SIZE		\
-	(sizeof(s64) + (ACPI_ALS_EVT_NR_SOURCES * sizeof(s32)))
+	(sizeof(s32) + sizeof(s32) + sizeof(s64))
 
 struct acpi_als {
 	struct acpi_device	*device;
 	struct mutex		lock;
 
-	s32			evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
+	s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
 };
 
 /*
-- 
2.31.0.rc2.261.g7f71774620-goog

