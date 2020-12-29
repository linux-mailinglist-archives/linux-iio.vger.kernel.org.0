Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1412E6D20
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 02:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgL2Bxt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 20:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2Bxt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 20:53:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2493AC061793
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id lj6so682179pjb.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q/SDjd3IqDveGOdOyKRmFp4u/wbZ0g210W66vmPxVOk=;
        b=N3AyRN3tfiCB1sC6qXbrnNWHnmxIvCiljz1mktJIZou59E5VF6MFca1dbrItx31JFX
         1n9w2vKQQXdpffEphMgbBOPNDZL/GSKSKNOG2GDz0UBmsGPPE4++hjjXt9CnGtOQQTaN
         Jcld/dNQXLMy3aKlJnyYfq2OKLxbZMtMAPies=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q/SDjd3IqDveGOdOyKRmFp4u/wbZ0g210W66vmPxVOk=;
        b=ppUPjMuFfNjhlqilN599WmbJStOmCmGnjjnP1Hp28GTcNEbAP+Fs4eFN5NFza4NH0h
         o4N5TTA6v54A5ipBtinFE4E4c/c+5rsejIAWPMRcsRv1aG/3XKC7Lpx9kTt4w52aprxf
         cDl8h3/lbpm562BGVs6XqOk1/xojFY+5o366xGiwyLFjRuuV8/EuIZvUy0wviBtQEQ+J
         HU9jyh7+q9WyfyVJ4WHSVUBaRzFgmVdlU6u5NSyhzN5GSDtn5s1LYQ8ohPJH6vRMa+0U
         P+HysXnDLADeYppkZsIWFA2hBEoM7M59ESWk1J1x+O3/Kc62iNORK8Y1PGg8YJNZblUh
         twQQ==
X-Gm-Message-State: AOAM530nVyEPIsDZl/9Sco1XGW1ugHtIhmRV2wXcUYb5c8nsz8hKHfzm
        wdKQ7/3AxxGn2B/ipkowwT91AQ==
X-Google-Smtp-Source: ABdhPJxGH4vsUeUvELLO4+oEGEmDHFGzfhYC2b/5Th379WLdDbAk9pJUc21rKnZpt3qxBm9ekDr7LA==
X-Received: by 2002:a17:90a:cc0a:: with SMTP id b10mr1656545pju.59.1609206788723;
        Mon, 28 Dec 2020 17:53:08 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id s1sm1243740pjk.1.2020.12.28.17.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 17:53:08 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 1/3] iio: acpi_als: Add timestamp channel
Date:   Mon, 28 Dec 2020 17:52:58 -0800
Message-Id: <20201229015300.3037816-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201229015300.3037816-1-gwendal@chromium.org>
References: <20201229015300.3037816-1-gwendal@chromium.org>
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
 No changes in v6
 Changes in v5:
 Fill comment line.
 Changes in v4:
 Fix spelling.

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

