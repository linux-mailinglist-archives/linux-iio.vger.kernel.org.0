Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00335AF1B
	for <lists+linux-iio@lfdr.de>; Sat, 10 Apr 2021 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhDJQrr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Apr 2021 12:47:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbhDJQrq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Apr 2021 12:47:46 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lVGle-0008Kn-QB
        for linux-iio@vger.kernel.org; Sat, 10 Apr 2021 16:47:30 +0000
Received: by mail-wr1-f69.google.com with SMTP id a15so3665170wrf.19
        for <linux-iio@vger.kernel.org>; Sat, 10 Apr 2021 09:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yja8hXnSiAu+0aHoGZXireKiKWwNFLqckJS2FN9snds=;
        b=qJKH1Tcnk9c0soF9WoV9stEeeQFNLpEuRIJ5fT1IMOKrzeoWquYiKm6dSxp8kQ/bM+
         yNKu0tM9uoMI7xU9okG0qbmf3eBzlLqJE0NX0H6b+t/lADtD4JlmXlIpVWZP7xUT4RLT
         XCrQaY9QtCbGRa/B5qK1EUMhDlUC6uPi3gDLBi740RLmeQ8j5bJAnH0YcxebhPo6cTGD
         C2VLYzoXkTHGSkzl/WioXwSCv25sJTLFsMVRQkpRXRocRhx0uSbxnavZUg/7e6oJ8dj2
         TdcEe8s2iCdqxJPNxA6Nxeq+LWo+I9PW6HvO+naDHT0YI2wOQahRJ81EWxXzF9uhtomR
         sBqA==
X-Gm-Message-State: AOAM530nz97syl+EM42upgFdvGWRFsjOFw2HI92geAi7gkf5HGrzqyCp
        mYYX+R+wMyx3y3wgkN2u0uKrTeq1tQX/vldaG9T1PYdAy+3AbIOEQCHujwDxqntUswGz/I1e5H9
        8iOh9IkNhbG8e7U2qoAqyhsNNg16VDFsE09zDtg==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr2657284wrv.342.1618073250619;
        Sat, 10 Apr 2021 09:47:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH68hN25kDxZ6InU8FQmZEZIFAyVtxpAPrME+esYPR8r0CNYLqCCdxgrzUaS0vKsgog0iRDw==
X-Received: by 2002:a5d:5711:: with SMTP id a17mr2657269wrv.342.1618073250459;
        Sat, 10 Apr 2021 09:47:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o12sm10130918wrj.34.2021.04.10.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 09:47:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]  iio: adc: exynos: drop unneeded variable assignment
Date:   Sat, 10 Apr 2021 18:47:28 +0200
Message-Id: <20210410164728.8096-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The initialization of 'ret' variable in probe function is shortly after
overwritten.  This initialization is simply not used.

Addresses-Coverity: Unused value
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/iio/adc/exynos_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 784c10deeb1a..2d8e36408f0e 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -794,7 +794,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = NULL;
 	bool has_ts = false;
-	int ret = -ENODEV;
+	int ret;
 	int irq;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));
-- 
2.25.1

