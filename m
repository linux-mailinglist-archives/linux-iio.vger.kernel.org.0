Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5396445032
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKDI1Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhKDI1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E2C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u17so5975169plg.9
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9OqXE6OoYroe6veay0WvtZ0d2Pt4NYeP8Cveo7pjMiI=;
        b=kFDRN3o694lxq25DAIUimKGXetwMqsYgmCGoDEvR5/biyn8883oj5q96V5mnHKLCeC
         t49/RzAxFcPNwUxGo5tPntzaSVzzLh9vUipTQtZxZecV2VB+pPY3mTikUVWRDzCKwlqP
         +yBVnSFClvRKFETBl+RDrUG9FUFZ0FNzwHshg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9OqXE6OoYroe6veay0WvtZ0d2Pt4NYeP8Cveo7pjMiI=;
        b=NegdvGFpiYFraJe0Ulu1vyOUoyU0dNMtNLPWeR16rsgLHgBH18+scVtFvM5nVyY9Xr
         f9QZQtZXCr244MPFz3HW5K6rHGF0LjMd2ogwsf6WuZUs/wl3IlaB7Ofg6gudR36VDHmy
         +/7hU2QAkrO0vZNQYso5qtgi8o4ju+D7833NdYfd0tD/qXTs+rcymW3zsSmmYTKmRTZE
         W4HO8RvvsKN3shtBk5KDoIKhytXZ5WKc+mGUzSCjaeAuoxjCgjBolUFjipgAkRIOtWZm
         V7uow+zSJBX3QBntJpj/hpmVsEjibg2MpOKpXbub/VMq4aB/14aNzETIx+rGzdCjLsDq
         7x6A==
X-Gm-Message-State: AOAM532abOxx41SAYiiDow/275FyGxWbSW0c2fclAH1Poza9N/WB7WKT
        e/ZJ7gACylucmHPMB9iVVWLrRtOr9NrToA==
X-Google-Smtp-Source: ABdhPJztlPFBfKoxDSZ78lXY2ziFIiCo8FVKBQdKfkynUmy445uClyxZOTHgcj7djcY10n+7se+B6A==
X-Received: by 2002:a17:90b:4f45:: with SMTP id pj5mr4267631pjb.70.1636014277789;
        Thu, 04 Nov 2021 01:24:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id e187sm4444948pfe.181.2021.11.04.01.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:37 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 12/13] iio: xilinx-xadc-core: Use local variable in xadc_read_raw
Date:   Thu,  4 Nov 2021 01:24:12 -0700
Message-Id: <20211104082413.3681212-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211104082413.3681212-1-gwendal@chromium.org>
References: <20211104082413.3681212-1-gwendal@chromium.org>
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
index 2aa4278ecba78..823c8e5f9809b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -944,7 +944,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
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

