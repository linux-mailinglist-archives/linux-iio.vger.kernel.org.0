Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F922D6920
	for <lists+linux-iio@lfdr.de>; Thu, 10 Dec 2020 21:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404517AbgLJUud (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Dec 2020 15:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404489AbgLJUud (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Dec 2020 15:50:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBC8C0613D3
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:49:52 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q22so5247806pfk.12
        for <linux-iio@vger.kernel.org>; Thu, 10 Dec 2020 12:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2vOZP6CMZ2x9K9kFOk9FDIVgi2cvJVuiCzrPgGneiE=;
        b=cgnF5Scn2JvHhEfRLQU+t8HynEwHxXJ1hu3VZI6EL9Mzis5GcKIki/dL5OnBFeqQHV
         4JDyzZRIt3juLt/xp2l5XwTgWSX+Rr4/AtllHINQDCQPQakW4mhnDg7KaG9N30y3VFmw
         3MipQT9bSJh6DZUgaz9LSm9UfQtO4HaE2WSEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2vOZP6CMZ2x9K9kFOk9FDIVgi2cvJVuiCzrPgGneiE=;
        b=Hmgdtc11hT3GFqlMq9pp4XdkzAq3MHOnrZtCwxJ9q9HUh4EOyAYfhjM4tMnmY9lQ8W
         DWirQR6qq5CxxhBdTpKWKbQYLoTQF/Wkwt0H6rzA9gFMN4CVIaTtD6ONzcYFVWX0fNo0
         ZK0vQf+XIRaZJDQmveQgn54gdF3TymxC7aVZMkZ7FS5wdIxyVK8FDEhAeq0ieIZMYhWP
         QvR9QOco4JpF/HddEOele1ImaFCfBoQb7IfBnhqeROnL1m23b1XtBYMTRC8MeNHN3KAq
         SNw4WSE+fs9joleE4dKsyw4MbLWEqzmbiSKdYDdzhif988UBj++x2d/IkPjTCoAFX4bQ
         XHWA==
X-Gm-Message-State: AOAM530gwCL9uD2tkIV9tIORwUwwgc8PNCdF/CdFf9XFsHQenuIDjjCv
        ccxecaYVi5NrO21ZgnWNYRSCDw==
X-Google-Smtp-Source: ABdhPJxUtVECZ+QzWYqLH1qzEo1PY0UTIBmn8xICyuOSz7CULtpA/R8jkNaBUWdwIV+p8xLaJFebRw==
X-Received: by 2002:a65:5cc6:: with SMTP id b6mr8189348pgt.417.1607633392273;
        Thu, 10 Dec 2020 12:49:52 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id b1sm7521691pjh.54.2020.12.10.12.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 12:49:51 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/2] iio: acpi_als: Add timestamp channel
Date:   Thu, 10 Dec 2020 12:49:42 -0800
Message-Id: <20201210204944.968290-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210204944.968290-1-gwendal@chromium.org>
References: <20201210204944.968290-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add timestamp channel in list of channel, to allow retrieving timestamps
when events are produced.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
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

