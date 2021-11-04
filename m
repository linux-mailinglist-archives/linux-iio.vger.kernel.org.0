Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C6445027
	for <lists+linux-iio@lfdr.de>; Thu,  4 Nov 2021 09:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhKDI1B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Nov 2021 04:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhKDI1B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Nov 2021 04:27:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF33C061714
        for <linux-iio@vger.kernel.org>; Thu,  4 Nov 2021 01:24:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u33so5122019pfg.8
        for <linux-iio@vger.kernel.org>; Thu, 04 Nov 2021 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bh12gTIx46vyaIw8y+v4iTIFGiXlnzf9QVNIRa80mj8=;
        b=W2JNMqpz6m9aCOtX+sl0dQ+5C97ljhFYmINFYx866Uk8H1mzzcno9zUmmD5BaalMkD
         /Y3ybrWE2TGsuK6T9mDSHpY4ES9Hvwbv9VKHkupxgEwYBxkKhQCsOUn6dq2wjw23rLQm
         1/qq3drkWoPeSzzfh4We7H4/9wKHBbw7fJfW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bh12gTIx46vyaIw8y+v4iTIFGiXlnzf9QVNIRa80mj8=;
        b=wzA/MkyLGmIpq9eEX12rF99xRvUwCwBtrkmRW6IMHlSVIrHi7aUT4OXqI2pgv7UqqS
         FZEb1lo8VxNuuQh0aMO8jobbSXVWE5Ggjq+GfQs39GtQySg+OC0rpmaqiMjnbuXI/rWS
         kphbrT1cO6YQJ+W07FoLV6QxFcjXDHKGyPcYgHKrqmJsMH6X1l1rXXWlV5E8ywcb7YnE
         8vm/XJmMi8b1Kfm6RsJqlPEn9WsfKoZUpKc1erg9MuiX2539N6hymQ2xYAsUzpEgxz/b
         A7VBb0vIccQ5a/tscdNrxlqHiRbwGx3uATGK0VTBC8vXeoAKdjWI21fa+V9Jr62PHcFI
         wt+Q==
X-Gm-Message-State: AOAM5311hIaOmdHc55EOruB8M+62m+MwI59FPaQKYdnHcpIZ2L4Tbomz
        SlV6MiklbUSjHQFZNc0hN7ycQw==
X-Google-Smtp-Source: ABdhPJz63x2jRIxS+l+dcPUxdVnj4vgnWQVLTjHEy9y+qsf5FyvEKrNbqdZMkmRssC0+GMMWFf9Z7w==
X-Received: by 2002:a63:8a43:: with SMTP id y64mr21723482pgd.113.1636014263326;
        Thu, 04 Nov 2021 01:24:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b129:c9aa:6634:6c4c])
        by smtp.gmail.com with UTF8SMTPSA id q9sm4777423pfj.88.2021.11.04.01.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 01:24:23 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 02/13] iio: kxcjk-1013: Use scan_type when processing raw data
Date:   Thu,  4 Nov 2021 01:24:02 -0700
Message-Id: <20211104082413.3681212-3-gwendal@chromium.org>
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
 drivers/iio/accel/kxcjk-1013.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a51fdd3c9b5b5..88cf0c276893a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -927,7 +927,8 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
-			*val = sign_extend32(ret >> 4, 11);
+			*val = sign_extend32(ret >> chan->scan_type.shift,
+					     chan->scan_type.realbits - 1);
 			ret = kxcjk1013_set_power_state(data, false);
 		}
 		mutex_unlock(&data->mutex);
-- 
2.33.1.1089.g2158813163f-goog

