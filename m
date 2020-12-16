Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5692DC86D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 22:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLPVmC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 16:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLPVmC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 16:42:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57575C0617A6
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id lb18so2223876pjb.5
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6sw+x1vGelhN3zr0/rCrAVkAh2yb7e09rAh3MAQCnjQ=;
        b=KZTmdL4tFJ0PeShevhbBOpNX60/Zp2m/XClZ6slBFYE/a8qTRMxNde7/3+m0cs1INK
         P+4nKRXo2FXyYFlE1tLTpkY1MKy/AxsG9nlnn308WqJRbQrQ8MtMIJk6ruhWeDGel5Nl
         shAPCfXEjIUuKfTdUTzVW1WdCvwNL3IMvNHdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sw+x1vGelhN3zr0/rCrAVkAh2yb7e09rAh3MAQCnjQ=;
        b=ntPq+Xl55KtH+m55LechVjUw1YRCohln01rxQ+/tJawbsyBb/CUxZZqY9VJ2BIHQoN
         oWV3wWwY67r6KUUvz7DAp8X55GYjWiQ1QxdBTzfTSKjvcH9rbcVl2F2stDw8T0wQwWiK
         Nxeb/REvou3zYYSqfUMww0usGE7Ecl9sOFOM5OcC5zAKwaXShobXm4yJ6LB2xIu30H9t
         7aSLLIIxhIsg565Sc1dcjaJqd34toVNCrwc1qVUQ4s1uRskhHoLRdRrMS47gMKpEjwUB
         j/dZg9n0Fla56/IPvkXi9cUUL99POWVSTEWi0bjwawAEoVMQxnxaLzXQvDxQaAsvLMHs
         KH2Q==
X-Gm-Message-State: AOAM533nWiAbqqm8Ji8pQP/KfwyNZXeH2mJ2/m+XGUbYaae41irAMTih
        IRPTvL4cyz0y4BzZ7EVT/MRHkg==
X-Google-Smtp-Source: ABdhPJytWYHdt9fITPm9aeH6R+ZnG3PeuPUAsTo5BPVm8iu4f2vKtQAbOjhD+Trgw/gQ2Sa00a/zgQ==
X-Received: by 2002:a17:902:82c7:b029:da:cb88:38f8 with SMTP id u7-20020a17090282c7b02900dacb8838f8mr26130799plz.49.1608154881922;
        Wed, 16 Dec 2020 13:41:21 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id w24sm3441478pfn.100.2020.12.16.13.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 13:41:20 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v5 2/3] iio: acpi_als: Add local variable dev in probe
Date:   Wed, 16 Dec 2020 13:41:06 -0800
Message-Id: <20201216214107.774969-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201216214107.774969-1-gwendal@chromium.org>
References: <20201216214107.774969-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use dev = &device->dev in probe routine for clarity.
Remove setting parent of iio device, already done in iio_device_alloc().

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Added in v4.
 Changes in v5:
 Follow inverted xmas tree declaration convention.

 drivers/iio/light/acpi-als.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 6dbaeeebe2041..fd20808d4a119 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -161,11 +161,12 @@ static const struct iio_info acpi_als_info = {
 
 static int acpi_als_add(struct acpi_device *device)
 {
-	struct acpi_als *als;
+	struct device *dev = &device->dev;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
+	struct acpi_als *als;
 
-	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -181,13 +182,13 @@ static int acpi_als_add(struct acpi_device *device)
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	buffer = devm_iio_kfifo_allocate(&device->dev);
+	buffer = devm_iio_kfifo_allocate(dev);
 	if (!buffer)
 		return -ENOMEM;
 
 	iio_device_attach_buffer(indio_dev, buffer);
 
-	return devm_iio_device_register(&device->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
-- 
2.29.2.729.g45daf8777d-goog

