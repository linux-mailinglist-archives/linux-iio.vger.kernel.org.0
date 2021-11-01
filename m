Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E335D441412
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 08:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKAHVO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhKAHVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 03:21:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20CC061746
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 00:18:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id r5so11013466pls.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuLak6n2D+xx1jRMo02bIST3H8cpHj9A6SUpEXVo4Kg=;
        b=XZSCUcC/6QicC38QcP0/x/qElDTIdCY6WA75RoT4CoDg+krz9F41NdNTzmz1+D7FF6
         e95pYi9u/AQJZGaUalIrPZGd9fkdlNoMQ+AcUI2cQ5TbpiFaNXZZr8pOPSKWRx3Ywy0V
         QTvotVNfsx4ttSQovh+Gzg8LvPZIsaACouzLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuLak6n2D+xx1jRMo02bIST3H8cpHj9A6SUpEXVo4Kg=;
        b=bmHBWcANWI1QLwo6KoJh05nhq6SIrGFq5wNjhScUQbAmQbUzbCe14IdkfDvh7/LQux
         8dKjpT8iMGPRTnoBDN7UouYCHSJRVHxb+GOEd4ajgg3cYUNMRkNvBUoctBJYHr6OzfGV
         G2rL2I9qR9awjFaYzQNkHHoyG5N90rZHcpJxSG49hk0/IHetXC5dBlnaCUTHj8IWJMAm
         SI8/CKi2IeLoHHM7LZfEZlx4lRTcbVO/nKx6+tP7HMP5A8hTKkG9w48FIU3/zU9hHYBD
         H+UcDlnmEuSrOyGRmSNKgo7kLzNoDtGE02vc4yBPu4u14vpYl8k2PfTAXeU+2P6ZEhJk
         IKtA==
X-Gm-Message-State: AOAM532miXEZtJFFDn3OBDy7ikwajXvtlnq46iobFzySw9Omhb+hnYe8
        wjf3YVyJ+XeGgCT57Q9E4Mv8iBF3EZhvOQ==
X-Google-Smtp-Source: ABdhPJxWIcszVXkfBKkPAfbWQApn3qgCvEAyRGUVVaVv4JugMLnAXNzuqZDrgvYYu7NagCyWAscxxg==
X-Received: by 2002:a17:903:283:b0:141:c7ae:122b with SMTP id j3-20020a170903028300b00141c7ae122bmr10757498plr.53.1635751119100;
        Mon, 01 Nov 2021 00:18:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3f65:b35d:616a:31bd])
        by smtp.gmail.com with UTF8SMTPSA id mi11sm17598776pjb.5.2021.11.01.00.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 00:18:38 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/4] iio: ti-ads1015: Remove shift variable ads1015_read_raw
Date:   Mon,  1 Nov 2021 00:18:20 -0700
Message-Id: <20211101071822.522178-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211101071822.522178-1-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
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

