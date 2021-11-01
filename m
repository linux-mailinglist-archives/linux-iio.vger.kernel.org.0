Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B71441413
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 08:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhKAHVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhKAHVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 03:21:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB744C061764
        for <linux-iio@vger.kernel.org>; Mon,  1 Nov 2021 00:18:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 75so16471588pga.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Nov 2021 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6D1JYyv2enHYz/2SFd9fXc7m/s8rpqOqULQYI4PkUs=;
        b=HdMHHfGyqUBtBfdvYxHDjj6stzJ+UXy2/tchpE2msmFsXsw66Kkp2NCIWTtnsjuiEQ
         i+iIsRjVhytM4A7o1arg9Q823A/34J2A420lzsXYK0+wRuWJIyRGqJOFfaem8t3QjmsR
         Cijx/bKGaZnoCqnk3JHlku0EnCD38wqPpHBsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6D1JYyv2enHYz/2SFd9fXc7m/s8rpqOqULQYI4PkUs=;
        b=EZURLLpn19VC5A90xJNcby1qOoBn8F44PvcCo+xdHB8Dw4TjjGtYABpU1j2ZcAHF6a
         82d7yf064NSQdoZqsFvi/PT/lOJKVBo3jlTuLaHEc8KIgmHxXOQ652niHIxkA7YKbYmU
         E9BgUfmeE5ftDBFu751ZJalFOkbXSE+1M1KkZtXgwWpv15dFDaeBrs1/9WRS6inGkZpd
         d4NI5IcEoNyXwTOhovHH1IJaFfhusfQdnngoN97WkYiycDexgcYophWj2REEYXL5Avzu
         CsDdeOUNtxsxDSNbfHQcSAlsgObMwnGYY1m12TzJeXdWydKTFoIkDly6AuQ6n2NrEqlY
         c+Sw==
X-Gm-Message-State: AOAM530CInv55uiEZcmM6qHXsVmV90yIs3xwF6Hru2HoCQSuYR7RYnQn
        NguydALZQ7khkyItVdNw/KrrXw==
X-Google-Smtp-Source: ABdhPJxTBcIM73CFwEapUXvjjbjr76VDPmtyi9DhNlqIfQJ3DnXGEMNy5h/g3dPyTdjA0s8pSwd4sQ==
X-Received: by 2002:a63:4e06:: with SMTP id c6mr9611137pgb.299.1635751120428;
        Mon, 01 Nov 2021 00:18:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3f65:b35d:616a:31bd])
        by smtp.gmail.com with UTF8SMTPSA id s11sm6791153pfd.182.2021.11.01.00.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 00:18:40 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/4] iio: xilinx-xadc-core: Use local variable in xadc_read_raw
Date:   Mon,  1 Nov 2021 00:18:21 -0700
Message-Id: <20211101071822.522178-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211101071822.522178-1-gwendal@chromium.org>
References: <20211101071822.522178-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minor cleanup: bit is already defined as chan->scan_type.realbits,
use bit when needed.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/adc/xilinx-xadc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 83bea5ef765da..05050709e4f8a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -943,7 +943,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 				*val = 1000;
 				break;
 			}
-			*val2 = chan->scan_type.realbits;
+			*val2 = bits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
 			/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
-- 
2.33.1.1089.g2158813163f-goog

