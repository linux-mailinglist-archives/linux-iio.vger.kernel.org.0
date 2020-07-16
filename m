Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE11722248D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgGPN7w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgGPN7r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F0C08C5CE
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so7180190wrw.5
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lGrcjnEba4YmUzXvP3P2zNGvEOSHSw6x9xTgs1m5AS8=;
        b=lQmJngfqH1aydCD2CnW8Em4hBhXABb5MazDgBqwCCwd2smh1BADTX8C4W44klKhuIR
         s7q3p7w3/5E34p6dUWS8OxsggHHaWxOeckNSL6JLpfN03S9/7EscD/vI2OD5//EZggxa
         5+I5R2Ekxty6wybtZr6hq5UAHV5ffsWaUdBOHHtfYXbd4gx+PjJl7fwPI0dc1NKOHzwS
         Y5+A013Kn6FGhhZAvtOyEomv1m/5fXSzfYKVPcwzcJ5nOVRwKU3qgxHcViZUtmHIJ4t/
         LbYJb+CbMPEPWPo6pDw0ztFMhmNd+c4X0A/0xSHI8ZJrQ72UYMrY998IBvm+WQLhCbUA
         bOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGrcjnEba4YmUzXvP3P2zNGvEOSHSw6x9xTgs1m5AS8=;
        b=aS6M6U4v2dig15CI4UFJLwpyt3SBCfhqAhD9fn+llFBZ70k8v+p9kBI/LAVz7c6rHF
         GHIJAz5T0PgiN74Wr0kyUm/fuxxDlqpJCI5EIdiGG/tJ+ItKcqiEIkvz5iMi+eOxx1vL
         DkGTZ4mXdcc0PzxTdPRVUVMviKUKFshbUMyscjwwyuyz1PqVmsMX4menzXGe0PdqnUuo
         bsk9qAV8+ZvZfvnqILeu9aQIQD9VnOk9xVvDjmAvYLEvD56X0+zJwTBRo8MYqip6z80P
         CXeWHY/UGA78dnjrJwC2P7ZP/cnd0FNNWQZ6+M5KfUmJ6ec+vFMJa+9gTUjLIcjguR4h
         4VBQ==
X-Gm-Message-State: AOAM533HSk2E1Sm5VKWeZQL14jC9l5eBwo9LfCGuzY7H3qEZtruw7cga
        67FIL+dsDTqj1hMdoz30uTYnzg==
X-Google-Smtp-Source: ABdhPJzUuBHxEah7hrW8HxzzlwiEOHPkFSOu1MyX/ERMrdFJ/9pZmIYHwVXN+xfGtF2imKJbqKuNxg==
X-Received: by 2002:adf:ee0f:: with SMTP id y15mr5129073wrn.76.1594907985925;
        Thu, 16 Jul 2020 06:59:45 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 11/30] iio: dac: ad5421: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:09 +0100
Message-Id: <20200716135928.1456727-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5421.c:82: warning: Function parameter or member 'lock' not described in 'ad5421_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index fec27764cea88..95466c86f207a 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -62,7 +62,7 @@
  * @current_range:	current range which the device is configured for
  * @data:		spi transfer buffers
  * @fault_mask:		software masking of events
- * @lock	lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  */
 struct ad5421_state {
 	struct spi_device		*spi;
-- 
2.25.1

