Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07002445031
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKDI1O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhKDI1O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7130C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f8so5945318plo.12
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuLak6n2D+xx1jRMo02bIST3H8cpHj9A6SUpEXVo4Kg=;
        b=PZA0QqsHy/TdKx42gjLZwXQyYvqkFPURwEqxKzAK1Di8uKqpBcI2rrsMm/CF0vNztK
         Es6HjIvLVt88eRodWq0Poys+P+9b18rEZfyv0h49DzvSfizgQNXj6Lwnca0NWoMYT9Sh
         C7NW/G27/cD7SB53+Tg/2g044MWssj/1VkNRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuLak6n2D+xx1jRMo02bIST3H8cpHj9A6SUpEXVo4Kg=;
        b=3rU5U5CthbymeN5vnnfqkUrT+aau54vZQwr3AtCMC0DIC8hGsKga2FUj2LvXUcX3rO
         YP5dc2ZAXUAsEHGN6QsOQ2H/u21iOXxhynHRk4PHhypaFM7wVc5o2JLoViG/kXR07gaF
         OJ21LhEkvABpLtYv3XIjqu1tzBfp7y7ztUVB4qv9ZWjKMqcAE4rM9CJzNTcfpKo6x5Hk
         83sL5hsutqs+V4/BQ+2je45Ik4XHQvXmXIHXEUDCWwCgki2/ttvN/i1xLRBIvoo8LsU9
         +FsQTnRVeVs/I4r1zo0S38mRvX54JxwHpMLN8+h4Z8KjtOJk0sHOfRlq2kCPxl7MtMt3
         Wpig==
X-Gm-Message-State: AOAM530hMwWbelfyJV2hwn4Hx4xD/rB63Df0L+sfqcL8ZsQ50aXMp6Us
        908At1qv9mzCQHXsvqBq3T/9mg==
X-Google-Smtp-Source: ABdhPJzv/w7srlBAGURkCzggPnZTqDQPlib/6JwM2CEKXd8C61woL914Ho3/11qoCwHtqA15ygvEAw==
X-Received: by 2002:a17:902:f542:b0:141:fa0e:1590 with SMTP id h2-20020a170902f54200b00141fa0e1590mr20591325plf.20.1636014276390;
        Thu, 04 Nov 2021 01:24:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id pg13sm3564132pjb.8.2021.11.04.01.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:36 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 11/13] iio: ti-ads1015: Remove shift variable ads1015_read_raw
Date:   Thu,  4 Nov 2021 01:24:11 -0700
Message-Id: <20211104082413.3681212-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By using scan_type.realbits when processing raw data,
we use scan_type.shit only once, thus we don't need to define a local
variable for it anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/adc/ti-ads1015.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index b0352e91ac165..b92d4cd1b8238 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -464,9 +464,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->lock);
 	switch (mask) {
-	case IIO_CHAN_INFO_RAW: {
-		int shift = chan->scan_type.shift;
-
+	case IIO_CHAN_INFO_RAW:
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			break;
@@ -487,7 +485,8 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 			goto release_direct;
 		}
 
-		*val = sign_extend32(*val >> shift, 15 - shift);
+		*val = sign_extend32(*val >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
 
 		ret = ads1015_set_power_state(data, false);
 		if (ret < 0)
@@ -497,7 +496,6 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 release_direct:
 		iio_device_release_direct_mode(indio_dev);
 		break;
-	}
 	case IIO_CHAN_INFO_SCALE:
 		idx = data->channel_data[chan->address].pga;
 		*val = ads1015_fullscale_range[idx];
-- 
2.33.1.1089.g2158813163f-goog

