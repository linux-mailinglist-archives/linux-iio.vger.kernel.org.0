Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448082DBAF6
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 07:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgLPGDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 01:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLPGDU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 01:03:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6762C061794
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 22:02:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lj6so916192pjb.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2020 22:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvbQ9zuHWaYlHbOGm/uPKSOpodNkKA9DlZ6AZo27xeQ=;
        b=b78MCG8kS+1+DonslS8cIWVQESsxEOcTi8wA4lmDsKligdo1kK290Iv/uHrRoUgm4m
         zTWKLAhMHH8Tov+b6PSqoA1V41F2lVWxpW7fhb9nB9fDmcQssgO9Glc1Ua5MfSxNOEZc
         EFRYGZwxBongbH5HFbEeDVtRn2Obq172r5b+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvbQ9zuHWaYlHbOGm/uPKSOpodNkKA9DlZ6AZo27xeQ=;
        b=L7O4DbD2s68Q+OMjwHgAFuYkeqeLCGMCnicr7ymfjMJdHBSNsKZV0u9xzzzVoTfQsd
         kF8pWYhjg83/4x2ou57WeevA3WP1UKNoeUd6U0EHKMC3vQuGn8E84DEJZvvsbzBLNQQq
         RpANeqSqMF/+lihtYJ18VxinY2gQU3rHvrAo49A0QklBb940uYqjv3D8Xw2IXS+vLTpu
         iuONmaVa13pGhOoMMlE1DeZJuojzca+wbAeenWGTKEv097ql1+sDGIVpknbsq90CXuD2
         s/kZvb6+nT8JVovPP80CNUong+g1SbeAtt5cJ0mqJTpKFqSYE7rWNQWYV9AoLG0JkaKw
         9dpg==
X-Gm-Message-State: AOAM5308UrnRzORWrIepaAlLx7/YrnEIFA8YYz+lzmznPoE45pi+2SiL
        Kwh7Qfc3Tds+MNOMrM0vuP+vcQ==
X-Google-Smtp-Source: ABdhPJwRXF6TXaosv6qAtN7YqtLQGLaZMsbYhmzdyh/5ZceUBZOsLpm4UkYTgGiQLExt0sjwUSzo2g==
X-Received: by 2002:a17:902:ea89:b029:da:539e:9bb with SMTP id x9-20020a170902ea89b02900da539e09bbmr30989980plb.52.1608098560347;
        Tue, 15 Dec 2020 22:02:40 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id r67sm913781pfc.82.2020.12.15.22.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 22:02:39 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 2/3] iio: acpi_als: Add local variable dev in probe
Date:   Tue, 15 Dec 2020 22:02:32 -0800
Message-Id: <20201216060233.597689-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201216060233.597689-1-gwendal@chromium.org>
References: <20201216060233.597689-1-gwendal@chromium.org>
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

 drivers/iio/light/acpi-als.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 57512ac74eba1..32cd0f8438c33 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -165,8 +165,9 @@ static int acpi_als_add(struct acpi_device *device)
 	struct acpi_als *als;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
+	struct device *dev = &device->dev;
 
-	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -182,13 +183,13 @@ static int acpi_als_add(struct acpi_device *device)
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
2.29.2.684.gfbc64c5ab5-goog

