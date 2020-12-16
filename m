Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924F62DC872
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 22:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgLPVmA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 16:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLPVmA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 16:42:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1249FC06179C
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id f14so2232604pju.4
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1cSEzuqKCGj+bWrSPcCXCtJInhUSBBWBc/FVwh5wvU=;
        b=NRIQ/mWL4FGjDaJEZ+poLkSq7E3nvro8ya5vv5lqlkMYxqvcKdDLn3zyQNBuzhO945
         LMk5Upw4+r0bAYpe/uFxrfCbjzZSn6akZXy2JFjT9CNynWQeJfTqyRxpX2bJKBLRLXJw
         65QEWo2/v80ENdPapMrLI9agIuvbCAzx0phbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1cSEzuqKCGj+bWrSPcCXCtJInhUSBBWBc/FVwh5wvU=;
        b=rLlwPPC9d2Pg0aNma8ieBSdAIKKo1FvufTiTtV+RIIx8jOhcogP48KeimdNddWeEZ/
         S7YGSw6qe1m8SLzyalVxpY+Nks7s67YAgLJH/getcJXU8VOE3/Xn8LHtyspfNAINnStI
         rbz0gEpLGZCl+MSAlZLdZQdNNdDvECetZTYAvpPuwAfVeqMh4tHhOWhOlCaDetIut+kP
         e41NlEUZEPCbUi9qdYausYL7RuMc9lIMX0X3ktcF5YpSXKeECYKuqaCKpgM32cuVTwXt
         nZWUb0W8Bdz1VM39lv/nDuk0BtYxwHKobxfykhYdSnJ07m45b5MJ+/dGs7ZLYlc1lohD
         ojdQ==
X-Gm-Message-State: AOAM530v3RQMHnGKhJZleYUjyoKTnWOccmywnmzt09oWcy2q5hv1BjiQ
        Kdg1Tuf1/ua1axcbtLAxrn8m8O3dVVu40Q==
X-Google-Smtp-Source: ABdhPJwLTxUpQagmWzFx2lMwLBwGXaAdXxB2A3P9lkDJcMUWOAF/F9/vfPlAO69GRWmlsfVMQCSing==
X-Received: by 2002:a17:90b:1886:: with SMTP id mn6mr4781104pjb.31.1608154879642;
        Wed, 16 Dec 2020 13:41:19 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id c199sm3910931pfb.108.2020.12.16.13.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 13:41:18 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 1/3] iio: acpi_als: Add timestamp channel
Date:   Wed, 16 Dec 2020 13:41:05 -0800
Message-Id: <20201216214107.774969-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201216214107.774969-1-gwendal@chromium.org>
References: <20201216214107.774969-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add timestamp channel in list of channel, to allow retrieving timestamps
when events are produced.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Changes in v4:
 Fix spelling.
 Changes in v5:
 Fill comment line.

 drivers/iio/light/acpi-als.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2be7180e2cbfa..6dbaeeebe2041 100644
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
2.29.2.729.g45daf8777d-goog

