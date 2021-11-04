Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A852C44502C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhKDI1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhKDI1I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E4DC061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n8so6007919plf.4
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idY4qdu4LGBcB8a0Px2nHDOUUuSlRmvZ25ss85X1YpI=;
        b=ShQFTjnAKSHGiBvAKzbOKDi7ud0H3QDxCHSYUMSs+71tyyfKOt0u1e8+3q9YWBwt6R
         EqzPrFQCWnUDstK83rmExSpxNx+SPjhxF2X9Zw/8zF2F3tN1MjXiFPLvC7rF34VLCoA/
         292i8gDxc/f4G/Kwnbs4FpOnEdKSuaabAUBsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idY4qdu4LGBcB8a0Px2nHDOUUuSlRmvZ25ss85X1YpI=;
        b=fDHgB0fG9Hoor7pz4pdHcNN+KsdZXtcDNoY87r9HgXJcJVBpqzReGiT4WBE/9w74D1
         l0Uu0O2PgyLhp274KQjecaqppZDt/BzOapl8A4DQi53oLcelgIq2m6x0kEv8+sYqlXga
         hPgkUsKincFe4S4Tj7QDajlajQ9y9Qp2QDm+3tiMCY1zr7BJZ/QTYZsPOqrKIGtCyB0k
         YEf22lBOPReaSHZOk7/iObBMoBqUWMVDtxMrtW2wbsuNDIt1WeEZnS8CAcXAx1RMgeM7
         lwOC6qP/dyAyAoYRqxpvRdlq4UWwPNJMWZ874mOcBFAHT3CikJfmghN9FxDoZ4aWJlbq
         lt2w==
X-Gm-Message-State: AOAM531ycE9TCMa4JJ8WWK9ROWUlY8U1F72EJVw3rn7u6cwmluMbHp2d
        im5TNSeViqK92wQ60/niOKym1g==
X-Google-Smtp-Source: ABdhPJwqXnGdBfDO9rD3t1ekzzZU6bTD7aoL50wj/yf1+y13SVU7jE6FBGggzw/OhuTfmZ30bPqPaA==
X-Received: by 2002:a17:90a:408f:: with SMTP id l15mr20534011pjg.34.1636014270802;
        Thu, 04 Nov 2021 01:24:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id g37sm3450693pgg.89.2021.11.04.01.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:30 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 07/13] iio: ad7266: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:07 -0700
Message-Id: <20211104082413.3681212-8-gwendal@chromium.org>
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
 drivers/iio/adc/ad7266.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index a8ec3efd659ed..1d345d66742d8 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -159,7 +159,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
-			*val = sign_extend32(*val, 11);
+			*val = sign_extend32(*val,
+					     chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.33.1.1089.g2158813163f-goog

