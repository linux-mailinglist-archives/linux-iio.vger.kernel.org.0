Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5352E6D1E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 02:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL2Bxv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Dec 2020 20:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2Bxv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Dec 2020 20:53:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0684AC061796
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:11 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n25so8387931pgb.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Dec 2020 17:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wvb8Xy2SHchoCsPEpm92rrDJ+Eajer+vmen2sR0Pqng=;
        b=gaoe0DsFbuOwGLBPwnGNMq9ByJXDU/qBfWRD7nP68s/qsJtvcXgHfyamJT1Li7dIDq
         yz5MF8uvyhvhaXvy0PpGKZbRVzdVHEfsd2GAqYsZd5eHCWlzpItNaTCxyBPkmzeblBhj
         8YAx8tso7KEd5wRIjPgzSWO2Lo0Z+WVeQfhYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wvb8Xy2SHchoCsPEpm92rrDJ+Eajer+vmen2sR0Pqng=;
        b=s+Tl/AxKrHnn5vbqID++Ipp0M9C0VflmNeiCW9VN8p8Yt1WIBc5R19tgcaGQj1+msT
         46apeugCVRyC2x+ke1g8+ORnctKlslgFmTQurNhiZqddKCSIaJNh/nqxhPDXChwjTEX1
         QHXhJhb5q1UDL2cbo1pUIZEy2HBw4S9RxE/fEfdkPib9Sz+ALRPPbKiUWvywaZTVQKvN
         tQgIfrUJPLGmCwAtSa+2s/JAmpEO3gykq5iJyJcgOfBSSeeG5XCiYUB/wX8fJpR7zau+
         3SiE4wbcKdgGt/hpxQnTy5kY4tgtRzNw0rYuE+APm2o5Z0VrhOlJKFIS8rGL+TjUMXc3
         Ag2Q==
X-Gm-Message-State: AOAM530uGk0/4PRzqUKKZXK0vdEjTo3F1T4CzttErFpqKW+kPb5NFk9D
        H87QbyZPV2IOEh16lEFEcxddsEw7F9TiRQ==
X-Google-Smtp-Source: ABdhPJwaxsRkql5+GoA8+6UJX2goUSZO5TJ7zMNK1T6o2li+8hCsXUvtmp7pwE1LWbg44XSxCWDAog==
X-Received: by 2002:a05:6a00:134d:b029:1ad:b17:dbc4 with SMTP id k13-20020a056a00134db02901ad0b17dbc4mr36064470pfu.53.1609206790507;
        Mon, 28 Dec 2020 17:53:10 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id fv22sm749066pjb.14.2020.12.28.17.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 17:53:10 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     gabriele.mzt@gmail.com, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 2/3] iio: acpi_als: Add local variable dev in probe
Date:   Mon, 28 Dec 2020 17:52:59 -0800
Message-Id: <20201229015300.3037816-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201229015300.3037816-1-gwendal@chromium.org>
References: <20201229015300.3037816-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use dev = &device->dev in probe routine for clarity.
Remove setting parent of iio device, already done in iio_device_alloc().

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 No changes in v6.
 Changes in v5:
 Follow inverted xmas tree declaration convention.
 Added in v4.

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

