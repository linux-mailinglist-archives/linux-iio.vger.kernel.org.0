Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF8F2D6AF7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Dec 2020 00:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbgLJWbG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 17:31:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45555 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405087AbgLJWV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 17:21:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id v29so5557843pgk.12
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 14:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLtV+gnrQeHdgfIX08JWdfTRMwPLGkXn877DyEgZ+iQ=;
        b=nBnOEJd16r4Qpn2Kfctl/rjlSIGtRzWbaoQlDKqNmaosQ92IXH9/q3A120+RZ1b1X0
         rA5Yun+RiGTFf2aFuCiChuNe8OqfP+n4enFChaO0wBA4+EBSenOJl2idcRdJ3hhPib+j
         DMzL8pvSozy7iPRJWXWX8XoDSIdGrjOqLKU2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLtV+gnrQeHdgfIX08JWdfTRMwPLGkXn877DyEgZ+iQ=;
        b=nUDtumhxl4G+r+3agGyNGWT/wLMgOXZdO6/UgZ8qWKClDhzp0wvxhJbypKKUfe65pn
         GRsbWNvizJ0kFdP2wB5VER2O8ZkQllWHlW4kAmQgO5v0h3YkSe4XOJV8yeEULwi1kyYd
         ggBI+TNPLFOeYUBSDBi0+7Gn89XZOyuKZAVq2Blf8wcuG9i1lq8UsyadtELQpAh+uSJv
         JlBdWxyjK0kBvPExGAatqTfRHpMSzMw/ozwgKHyriDan2ZkN4ewetma/hC7+w4gub6Pr
         6X6HAmRca05mJHz5XSr1nHLqDx6/8Fd1n4BXi2Ijeq+ICIL/ZWKiV2gV43DIeTJckhrB
         ib8w==
X-Gm-Message-State: AOAM5327mGvFxVTHnoiqrctcrI5OUrNTpGx1SA1G94MNuo6y9hwLErBQ
        bJkqSpCv2WYPfPMXKjQW+Nxk1w==
X-Google-Smtp-Source: ABdhPJxgwDLzNnjXNgMjIjgsqsihOstFByksU5tA11FNC8ZM6CVDmx48/htSkKSuVWo8XYUsyZXLhw==
X-Received: by 2002:a63:a902:: with SMTP id u2mr8707603pge.263.1607638546321;
        Thu, 10 Dec 2020 14:15:46 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id l197sm7750119pfd.97.2020.12.10.14.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:15:45 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 1/2] iio: acpi_als: Add timestamp channel
Date:   Thu, 10 Dec 2020 14:15:40 -0800
Message-Id: <20201210221541.1180448-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210221541.1180448-1-gwendal@chromium.org>
References: <20201210221541.1180448-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add timestamp channel in list of channel, to allow retrieving timestamps
when events are produced.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Changes in v3: none.

 drivers/iio/light/acpi-als.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 1eafd0b24e182..ff0ecec65fae4 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -45,24 +45,23 @@ static const struct iio_chan_spec acpi_als_channels[] = {
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
+ * support _ALI (illuminance):
+ * One channel, paddind and timestamp.
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
2.29.2.576.ga3fc446d84-goog

