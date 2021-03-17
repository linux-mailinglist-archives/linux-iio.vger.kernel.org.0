Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5475B33EAAA
	for <lists+linux-iio@lfdr.de>; Wed, 17 Mar 2021 08:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhCQHka (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Mar 2021 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhCQHkW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Mar 2021 03:40:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8249C06174A
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j25so525868pfe.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Mar 2021 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9XltDF7+T4WZ/nMImUrKTMbpGKBG0fZHmhETi35m2h8=;
        b=dHf2BUOZ1i11kp1dxwSkwKv6uRI4GMK1fhMwD87J17rsZ3KNySssqWBlidD+J6Rlln
         U724Wgi234KZE4TD7/YK6NSOxLHv9Cjsz/MhevpoIIJL/Vn4fO9JGqQ1Bxr/35vLD7aq
         Ik0BV8HYcstUHi4PW/c4ruAlCmVI6Q1a7oLTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9XltDF7+T4WZ/nMImUrKTMbpGKBG0fZHmhETi35m2h8=;
        b=QRER2yVM5P9KJhkNKue9s0aGKafYHqO0HlsVbPPgYpCtKmdtO1zYvCxmC90Wr5IJFG
         oYFgSWXHiZFllA5m0vRNctVWnoJyUCsaueQFn9UNzBMGpqfcLRwB0gxspwUbBjE65LW5
         6JZH67noEAlfvQjOTxvLYrWCnT/IFv3w//VOFJFn2T+G45YsPtnrp9xoRz6LAmeGoHC4
         uRZ9W3bIZxWA7UOleQwnmiAJvwXviMhTWR77f9MUz/wz/JsnSo7vG6YEElKPZ5KvRt2O
         8GLb6CNbSl46hRpD5zuFvUkK36xb2p35GF++BzF2Edn0Ls+Wh7zJnNsr2BdHiG/B9TeC
         t4pQ==
X-Gm-Message-State: AOAM532RXsDLKROQgiXxXoTX24OsbEjrsK/mXKrsS8BuXg3k9jmO/WQd
        +vu8EO0A666e3eipYVAr88dyiA==
X-Google-Smtp-Source: ABdhPJyfkzsBaCb+diIxKx/TyWgpPENckQPVuwatoLQPzcuFVzkB94Zvhqn0fAanhrBXd1dzJUGVpA==
X-Received: by 2002:a63:a50f:: with SMTP id n15mr1532139pgf.348.1615966821566;
        Wed, 17 Mar 2021 00:40:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:bdd3:3391:be74:f7be])
        by smtp.gmail.com with UTF8SMTPSA id e21sm16808458pgv.74.2021.03.17.00.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 00:40:20 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 2/3] iio: acpi_als: Add local variable dev in probe
Date:   Wed, 17 Mar 2021 00:40:11 -0700
Message-Id: <20210317074012.2336454-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317074012.2336454-1-gwendal@chromium.org>
References: <20210317074012.2336454-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use dev = &device->dev in probe routine for clarity.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 Changes in v7:
 Rebased, replace &device->dev at new locations.
 No changes in v6.
 Changes in v5:
 Follow inverted xmas tree declaration convention.
 Added in v4.

 drivers/iio/light/acpi-als.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 784868aa8fbf7..a2107945cff93 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -161,11 +161,12 @@ static const struct iio_info acpi_als_info = {
 
 static int acpi_als_add(struct acpi_device *device)
 {
-	struct acpi_als *als;
+	struct device *dev = &device->dev;
 	struct iio_dev *indio_dev;
+	struct acpi_als *als;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -180,12 +181,12 @@ static int acpi_als_add(struct acpi_device *device)
 	indio_dev->channels = acpi_als_channels;
 	indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
 
-	ret = devm_iio_kfifo_buffer_setup(&device->dev, indio_dev,
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 					  INDIO_BUFFER_SOFTWARE, NULL);
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(&device->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct acpi_device_id acpi_als_device_ids[] = {
-- 
2.31.0.rc2.261.g7f71774620-goog

