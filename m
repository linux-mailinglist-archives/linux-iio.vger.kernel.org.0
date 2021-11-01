Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E64E441414
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 08:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhKAHVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhKAHVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 03:21:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD4BC061714
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 00:18:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u17so1840312plg.9
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2/IAh9b2ZtQRqOn+VVVEM3bR790w8gUv8rHS+EEtkRk=;
        b=Bke3EW2CeGaHbLSYwv9/Fok9yeJt5SJCAfoNFDh84kmgt0WrIGTmFWHCDeH6NXa6dv
         UbU7d5upMzfK8dhbo5Dr3DoyBzrlfOuB963V28F62mLGVdTatuOWml1pBxsuiC0KUHBQ
         OalWgokXlqdrzw32OFVcUIGA1GD2bRq8Tv1X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2/IAh9b2ZtQRqOn+VVVEM3bR790w8gUv8rHS+EEtkRk=;
        b=FmElrlWkyQjH9PG3/VVx8h7I6wcmqbgG48+1vIrY0rFcVhEQJ4xde5y9TaHIQ7NUO+
         hEJbxhkZtOZQ2ip+r0Q6cbJVj1tUE5fn3JkbYWEe38LzvXUvIlq4MEc+6Q1JBjJ4c++n
         HjQyPH3gunAqqagiUdeOPCXg/adOktrnMWmnS4d23iP1F4ps8/KMIXRvAZqyRiM0Re0D
         +ZW3A9+HGfjcyIChd0nGsNEfz3DIknAK93rnPfKXBXzR9OG17vl9VemGOYjmZUlK8i0z
         dA5baYv7ekfeezA8aShDTCmiWCU5R2bZUPV4g3VZisdxzOqF8R/oeFLFNU7ba++MtF0m
         ljfw==
X-Gm-Message-State: AOAM531NHcnQvOKuR+bOcRqDOGOdOv+Rbw+dLLGXSyr8ZPV7eqHj/Adx
        vFtZxtCWOYqOVHTKGsitC0VqCJ4cxeQOnA==
X-Google-Smtp-Source: ABdhPJxRPup9TlvGcXXDJFL2UNMdxn+vb1loLDxd+dpJ2usLImHMftEAkbF/uD6jN7B+pF9uUfgUfw==
X-Received: by 2002:a17:902:ce8f:b0:141:f85a:e0de with SMTP id f15-20020a170902ce8f00b00141f85ae0demr983850plg.69.1635751121744;
        Mon, 01 Nov 2021 00:18:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3f65:b35d:616a:31bd])
        by smtp.gmail.com with UTF8SMTPSA id b22sm4370464pge.2.2021.11.01.00.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 00:18:41 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 4/4] iio: mpl3115: Use scan_type.shift and realbit in mpl3115_read_raw
Date:   Mon,  1 Nov 2021 00:18:22 -0700
Message-Id: <20211101071822.522178-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211101071822.522178-1-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
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

