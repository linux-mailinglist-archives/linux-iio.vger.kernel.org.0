Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFC2DBAF5
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 07:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLPGDT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 01:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLPGDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 01:03:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6846C061793
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 22:02:38 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h186so5459517pfe.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 22:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAiuD9XjlCIapOopak2nGjcyJTtN7EQoKtyOBuUMM/8=;
        b=lzoRL8jiwfeQzR3vFP+aT/FVxOstPfy+BhfXRl7IW5zK5KqaPsuLiaQ/nAZ9ZlwFvO
         mbcHsnIKMJ+qOv8SrFmGhUi8IEwZpfNwb8PxT85KJ4frHD6RzTTOzaMlFAp2wzh8Fs9w
         g9HNr75ZHk7lnPAXw54HJRhtrpb4GtTYaDr3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wAiuD9XjlCIapOopak2nGjcyJTtN7EQoKtyOBuUMM/8=;
        b=d1hTP4wo14b/0++72Xx5T1lGurb/awYqgGbAwq9Neq9rCCntNQ2ID9tlGan/NG5yms
         ghz4Np1/xb/9JMcYyg3RHUDcKXuPn+QmxTyLxRUDszit+Qx+D65fK7eXnVdGMhVzPhzn
         KRzOF2B/RYSvL0S+a4RMSF/0kUnCAtriJu609HhUuiWm4iQ4vW8vdtq9S8ilD1WeBn1o
         Sc8qE8NePgaZnujsDZTohmNT6SPQWeXQNW/vnn9MZ1Bv/AhYp2QTBoIKv84QH4sBuuD4
         PxVutEy3nBkDgm3bchQ2hoO9rJIYDfzLLsZsZdF0nwYv8EhunJjJ8Kej2k/LihL5ys/F
         5MBg==
X-Gm-Message-State: AOAM531qiawqeetke+5orWjQGpK6wj6muEuplmBWLYAEe5+5vUdzLsA1
        FCQUTnMvc+phZ3pCLpEVN2EpcA==
X-Google-Smtp-Source: ABdhPJy8dnPbEB1gtrYK5L+BD+O80AggiNyiV0KHXqaDFto85as/QBlsQuOXbATRDihYenbg+3GOCw==
X-Received: by 2002:a63:4e4c:: with SMTP id o12mr31516796pgl.348.1608098558549;
        Tue, 15 Dec 2020 22:02:38 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id t135sm926121pfc.39.2020.12.15.22.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 22:02:37 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 1/3] iio: acpi_als: Add timestamp channel
Date:   Tue, 15 Dec 2020 22:02:31 -0800
Message-Id: <20201216060233.597689-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216060233.597689-1-gwendal@chromium.org>
References: <20201216060233.597689-1-gwendal@chromium.org>
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

 drivers/iio/light/acpi-als.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 2be7180e2cbfa..57512ac74eba1 100644
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
+ * One channel, padding and timestamp.
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
2.29.2.684.gfbc64c5ab5-goog

