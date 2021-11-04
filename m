Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B658445030
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhKDI1O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKDI1M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F53EC06127A
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r5so6034329pls.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=050XYfAs5h9fYsKsLiHkYANnHJbrZ8oMXRf8QMjyzYM=;
        b=LEfQc7z7K4yFPsKkZw43TyrMwkqIgIAb8cVbRgknoflBNByrctsR1ctmR5ZmiS1WO3
         zMm/TLOWgp/fhINi5jVJriHNYvaXSITzEaWjSrb0mv1iAzgEY0UOT767B2cZaQX3rfkz
         dZheU6vOHmw0ZqW5hQ9LoXQQD4/hileC5/wG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=050XYfAs5h9fYsKsLiHkYANnHJbrZ8oMXRf8QMjyzYM=;
        b=qoQifI+dTrXj5+cPZAw2yWmPMGVUcEt+3FYJN2dK9jzxOso1InD5kCL1lBK8sQ7+et
         ZBkWL3vrgke8161SMXfzYf1fvAB6Vc4oSLR+or3PzDgH5kw6INtEIO07yGPj4WrY4X13
         S1uT/pD5iIsO4G64xkhipPeLhbRrRyob7JkLaPm2Y+Vbwl7IGVI+C0mZ5BeTsHA/IB7v
         hj4iTKiEkQTRND9cOloMnhZa6pQM99TeBt4MuXy7nkqTbmj9d7R/d7is0jyp+esgp/G4
         0IBH6EHBZYTl6wmIzEGq4num/XAV+R4R3V56g6+CAFa2yIyvg6M6xswsJevoitaRclIC
         MQqw==
X-Gm-Message-State: AOAM532CekEo43Bjsj8Sgqcv8QGqIG+kpkCmK6b1LyjY3DOnlptsvvqu
        Lv1jEoPLY0UBfQRnPmfomw1Kkg==
X-Google-Smtp-Source: ABdhPJwwDoy+8Sc0CKgnI0sbrwp8CBOOEsk5Jcd/LJes84xXHsxABGm784YFv0e6siH7EWlGO9AXAQ==
X-Received: by 2002:a17:902:8605:b0:13f:7c1d:56d1 with SMTP id f5-20020a170902860500b0013f7c1d56d1mr43445764plo.57.1636014274872;
        Thu, 04 Nov 2021 01:24:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id bf19sm6839973pjb.6.2021.11.04.01.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:34 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 10/13] iio: mag3110: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:10 -0700
Message-Id: <20211104082413.3681212-11-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use channel definition as root of trust and replace constant
when reading elements directly using the raw sysfs attributes.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/magnetometer/mag3110.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index c96415a1aeadd..17c62d806218d 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -291,7 +291,8 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				goto release;
 			*val = sign_extend32(
-				be16_to_cpu(buffer[chan->scan_index]), 15);
+				be16_to_cpu(buffer[chan->scan_index]),
+					    chan->scan_type.realbits - 1);
 			ret = IIO_VAL_INT;
 			break;
 		case IIO_TEMP: /* in 1 C / LSB */
@@ -306,7 +307,8 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			if (ret < 0)
 				goto release;
-			*val = sign_extend32(ret, 7);
+			*val = sign_extend32(ret,
+					     chan->scan_type.realbits - 1);
 			ret = IIO_VAL_INT;
 			break;
 		default:
-- 
2.33.1.1089.g2158813163f-goog

