Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4766C445033
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhKDI1R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhKDI1R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C9C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m14so5110317pfc.9
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/IAh9b2ZtQRqOn+VVVEM3bR790w8gUv8rHS+EEtkRk=;
        b=FRKDxcn6u2HMiNmkTw3d1yfcfjE9s9IuJJH+BQ5TRIW8sOF42nPwOZ//AxHyaao2cF
         J50C1jv/QDoHsZjm7gYLJXnfLgmlE6fykyBxWAZ0OJl6MB8H2JrCvZl6SYJFHypV1MnJ
         cNo0BOEqHo1imPRSWGto8EpWY/wzu4u4emZdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/IAh9b2ZtQRqOn+VVVEM3bR790w8gUv8rHS+EEtkRk=;
        b=tuZPabmllMikOxFIPXcqv3FXXzicp03N904T5O5kmWvxljvONy1Yzi1sO/nUeb8WWI
         jNv9jpov7IOfXkEkhCQArdwIJZTKzbog18llYgGR2PzUh0DI2535avEZd75RnKz1Ze3C
         icKxsvt2G6+Hn+2xDOzNpkmIbyBBkl+B/lf0dnMtCs09liEYWiQ4hsG2LeGUQ/O1rc16
         Ga5c9qlREwHipUoO8r/3nPyxFffFHnV3yYdeUTPvFN7D5MvFZBgb8Ka+OF4KZXc9f771
         5U2gZShqvBmkK/NsRJ6JUVhXPka4CZ1sZsqK76Qve8LTcuWrHOyqR4pO18IRoShjRV63
         Pfxg==
X-Gm-Message-State: AOAM5305eNIiTSWBZ7cuf7cnGtEhV1d8V6Y+Ja3ANRUk3ktlO4JHrp2H
        e/0Qc5jQV/zVC8LiRktgOHGgzQ==
X-Google-Smtp-Source: ABdhPJz4S40ExTYGvv4nURgPQ36sXl8N5PwwEBRejEAp+Fyi7AWtEcsoKV8kx80kKxSMSVrnAs0MuQ==
X-Received: by 2002:a63:954a:: with SMTP id t10mr37752082pgn.89.1636014279244;
        Thu, 04 Nov 2021 01:24:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id t4sm4611565pfj.13.2021.11.04.01.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:38 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 13/13] iio: mpl3115: Use scan_type.shift and realbit in mpl3115_read_raw
Date:   Thu,  4 Nov 2021 01:24:13 -0700
Message-Id: <20211104082413.3681212-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When processing raw data using channel scan_type.shift as source of
trust to shift data appropriately.
When processing the temperature channel, use a 16bit big endian variable
as buffer to increase conversion readability.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/pressure/mpl3115.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 1eb9e7b29e050..e95b9a5475b4e 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -74,7 +74,6 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	__be32 tmp = 0;
 	int ret;
 
 	switch (mask) {
@@ -84,7 +83,9 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		switch (chan->type) {
-		case IIO_PRESSURE: /* in 0.25 pascal / LSB */
+		case IIO_PRESSURE: { /* in 0.25 pascal / LSB */
+			__be32 tmp = 0;
+
 			mutex_lock(&data->lock);
 			ret = mpl3115_request(data);
 			if (ret < 0) {
@@ -96,10 +97,13 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			if (ret < 0)
 				break;
-			*val = be32_to_cpu(tmp) >> 12;
+			*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
 			ret = IIO_VAL_INT;
 			break;
-		case IIO_TEMP: /* in 0.0625 celsius / LSB */
+		}
+		case IIO_TEMP: { /* in 0.0625 celsius / LSB */
+			__be16 tmp;
+
 			mutex_lock(&data->lock);
 			ret = mpl3115_request(data);
 			if (ret < 0) {
@@ -111,9 +115,11 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			if (ret < 0)
 				break;
-			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
+			*val = sign_extend32(be16_to_cpu(tmp) >> chan->scan_type.shift,
+					     chan->scan_type.realbits - 1);
 			ret = IIO_VAL_INT;
 			break;
+		}
 		default:
 			ret = -EINVAL;
 			break;
-- 
2.33.1.1089.g2158813163f-goog

