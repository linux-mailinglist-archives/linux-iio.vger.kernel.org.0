Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9232944502D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKDI1K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhKDI1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:10 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863C0C06127A
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s136so4813447pgs.4
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ji6JqzNTrcD6aFrkDMF+a46Vd/1TQkWuUyVLT3OJmZ0=;
        b=h4bMu91NVku/k8RN9sOVqCcGi+SCr5N5sxM7Gfcaag4dkHSdp+SdkEP0UAPg5ZCjw2
         XtE1WQpd9BDa1Yza2IVFREi3jTOwEwMzHYPZ9UxkloU2aRNRXbCOOKgisNKqi0SsUeyt
         yvMAFSXV/Okf8AsJJoBOnNGwel8J0twbARV8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ji6JqzNTrcD6aFrkDMF+a46Vd/1TQkWuUyVLT3OJmZ0=;
        b=L8tGOuYaEduycM7sUeVcae3R/Si9K5N4QH3iWgyMJRKRB8f/4AvZfpgABVNIJdcnFn
         diLaj3YHvQ0sfJqZ0cKuCafDqIADRlCy43CQqB7gn1N8yq1Na+aGjm++HmVcZwRQbI39
         iMoTBHthepJKP61XRF1co1eZDW13iFeDT+gJXT5dAdztrXhloNpkOBO084kz48wg/J2w
         g2tpyESugcKKZCzNqiCrs9ro3Wsmso/90pjlPoDWfURirQsUQE6Gb3y5N7OJTQ70bO7g
         q+fFhr34CPWE9uKl/yD+7TGiKrbSa9k1QGOIaqEWVKWRvzRI0ECuEn/6coJoKPf4RSd+
         eknQ==
X-Gm-Message-State: AOAM533GTieH14xHkuTtdCUSrOODHv4yvwoL41Wj7RJUTF1p9xe6cUZX
        6+d0xxzyxXvKNhR/NkW0C/jSqPfhJv+uwg==
X-Google-Smtp-Source: ABdhPJxacx36coGhhnpKfK8qMCUpPL2+nplUhikKP8ZVymm3Dxdz/VLcwrUh4ySugO6HI7YflMdd8A==
X-Received: by 2002:a63:1441:: with SMTP id 1mr18073840pgu.66.1636014272061;
        Thu, 04 Nov 2021 01:24:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id k6sm4577852pfu.48.2021.11.04.01.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:31 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 08/13] iio: at91-sama5d2: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:08 -0700
Message-Id: <20211104082413.3681212-9-gwendal@chromium.org>
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
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 4c922ef634f8e..92a57cf10fba4 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1586,7 +1586,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
 		*val = st->conversion_value;
 		ret = at91_adc_adjust_val_osr(st, val);
 		if (chan->scan_type.sign == 's')
-			*val = sign_extend32(*val, 11);
+			*val = sign_extend32(*val,
+					     chan->scan_type.realbits - 1);
 		st->conversion_done = false;
 	}
 
-- 
2.33.1.1089.g2158813163f-goog

