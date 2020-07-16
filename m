Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2882224A9
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 16:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGPOAo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgGPOAD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 10:00:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058FC08C5C0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so11717825wmo.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKASaRWXf6Jrobw8UPiL6AmNdIp32mR3nx4dwq7oKAc=;
        b=rViawsa3WdUpkRJOtl0hbcb351+pPz2u3LYDiLi2tj2Ho8sFnTR0UeVIzIlT4WNSe0
         aWrCkXQTRZuZV62OU0aKoery/BgPcT9Cncw7J80KMSq1DT4pYfbguTpS20woVdRkCD7D
         LfLqYlW1iQt5zc8KOxLJksfLxvlWEH8dZyROEPD2GTgtGFUDbYEELOkcbsrRm1kGDcjn
         xZXAB+bzOKURjqKnKOxTlouXKBGDpyFlNoTtjtzsp3P+VW0y5iqv1PRaCNazUW9qcDjs
         kHKBeqZrBSSh5KF5NhI/pPFsyx5Q+cTaEC/PXB43aKMHlBq5ZtxJON+AIcuZNNtIpiYq
         hhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKASaRWXf6Jrobw8UPiL6AmNdIp32mR3nx4dwq7oKAc=;
        b=tnWoP/qIPpRpmYUjU73Nf8NLlcQ2LEN/HIelsTI8bfO8TfR7Rx0MGI5IHptTmQkxyA
         wb+B3dOPn8SZnKHimiyNgd0+dyusTZvoYruk631WtMQ4GIjlqT47QKTHffOOf2afqXWd
         S6SOSZngoJTfEIUKM5C/eGXANY9bNtDait33bX6+OZwIaKRMQmAxjXL9KFlCQ6p3Mdbw
         kM7bJ45G+KOTpAcUmwOB1q67shuXVNIY1QOD5u61749uLcG54sTW1Ii/cix51taokA46
         yi/v+BU9Gia+V4dHo/qP7f3y1QzLB09PpOU6IOHW9G0wWcXqi0T8q+BqkpLBduniHMy7
         Sftw==
X-Gm-Message-State: AOAM531i9PHwDKAvsWlJO7czguzxxZ1/syttygPHrkoQ6+kbkxt0QaCs
        f7RdfLm33oHsH3fUpT6goXDp+g==
X-Google-Smtp-Source: ABdhPJxpaB51Ov3WuPfHAs0mfsQamBGiC60+2uEATqjVFq6kqZxUaJ+4h6Ae7gACMzlfdCrLLD6BHg==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr4712437wmp.91.1594908001865;
        Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:01 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>
Subject: [PATCH 24/30] iio: dac: ad5761: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:22 +0100
Message-Id: <20200716135928.1456727-25-lee.jones@linaro.org>
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

 drivers/iio/dac/ad5761.c:80: warning: Function parameter or member 'lock' not described in 'ad5761_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ricardo Ribalda <ribalda@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5761.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index 67c4fa75c6f13..1d9d0e22d6f44 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -57,7 +57,7 @@ enum ad5761_supported_device_ids {
  * @use_intref:		true when the internal voltage reference is used
  * @vref:		actual voltage reference in mVolts
  * @range:		output range mode used
- * @lock		lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  * @data:		cache aligned spi buffer
  */
 struct ad5761_state {
-- 
2.25.1

