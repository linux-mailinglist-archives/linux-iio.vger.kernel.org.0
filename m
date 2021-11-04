Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5344502A
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhKDI1G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDI1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A0AC061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so5954034plk.10
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9SRX06i76D4HI1nkgfBuD3aMtpTGwkvvOZTDSanavI=;
        b=cEfrj58Pl0oapVNps6POcHoO4Z5DpMHypL62gbWxHtg6FMRFvcfhZtzhRU9KgOv1XF
         6H8hzieG13aauBPFsxLNvyUHgFzD3bZQRcL9iF8oNDcSqLJ0syOhvPKnEBRp8BGzF0dg
         Lf7UadaYTX8o27FrF756sxpDa+ZF/TVKM8HEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9SRX06i76D4HI1nkgfBuD3aMtpTGwkvvOZTDSanavI=;
        b=MSqLF2iO2WnSh4H9XY4PUhiUd+DDXCbbfougOlCoc0O3qvG0I2OADTDH1RTH44NWC5
         AHwG5MzQFhZR3NUiBDXmJidYDyQhf+r4V+gT2jnvb2jJVDozHVT+w3OMx1XiY3G73Pgt
         uPf6/23B8VuoXKtUekuUXRU4bSdsmBLXVOQH6DAAn6qhWTvgB/sSnkq9eBrdLRjw0JCb
         yRTC5uOR9PvsjakgbiiKlz7zHAWMRaqcBHs/ASaAkWw+u3n7JRLr2KY9+kt85hJWw51g
         617v7d4wePZ+aYnDIeLn3QPBuATHypzWYwAWxW9ke06AWlFEBBP0luy70U5fdazgfAlN
         vL6Q==
X-Gm-Message-State: AOAM531YCg5lfIPIgMJ3DA0Yghw+sX94VzMuElcmEs2OBP+YkeSj+SL9
        1DJR1c2enySXmM9xwnHy3JC/Fg==
X-Google-Smtp-Source: ABdhPJwdKSEj8gjIES/Pbf2sS2fGGEJ4Q/LzP5gzYP0tZ9VMfavgXmf3ld4bqj9lg9OG3EXrLTFEBQ==
X-Received: by 2002:a17:903:32c2:b0:141:eed4:ec0a with SMTP id i2-20020a17090332c200b00141eed4ec0amr23066123plr.74.1636014267928;
        Thu, 04 Nov 2021 01:24:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id c9sm3457251pgq.58.2021.11.04.01.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:27 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 05/13] iio: stk8312: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:05 -0700
Message-Id: <20211104082413.3681212-6-gwendal@chromium.org>
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
 drivers/iio/accel/stk8312.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 43c621d0f11e4..de0cdf8c1f94c 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -355,7 +355,7 @@ static int stk8312_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			return ret;
 		}
-		*val = sign_extend32(ret, 7);
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 		ret = stk8312_set_mode(data,
 				       data->mode & (~STK8312_MODE_ACTIVE));
 		mutex_unlock(&data->lock);
-- 
2.33.1.1089.g2158813163f-goog

