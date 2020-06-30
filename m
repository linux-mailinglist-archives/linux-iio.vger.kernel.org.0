Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61C120EEF3
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 09:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgF3HF5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 03:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgF3HF5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 03:05:57 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC824C03E979
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:05:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cv20so2420702qvb.12
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2020 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hQbCC2Qtr4ZiCu8Gyf8ZErDlr2Im7SfT6dGGEw7uc9s=;
        b=v3MS5UlpyyIOGIgiRkyrMu89BT/RmNLmfvCiTy3zQfQL5chxlg4UNWuuPqWEdHsVkP
         h+MFK3DHpk2T0r7qjo/Y8tef+6qHC3Zrz3maD/Ls2G/URaqS0e65WoGof7TkOTZpouyY
         HGc5oey1D1jZTZ8Z7Bfmw7wBPdPdrLdbq5JmCNIim1n7BFDBG7wcLl9JHtpS+Xv43SRT
         WP1xr3TkS3H3hdQdmzNdarusxOd/r4VUcGckXxvYJ1PeZ2bAa+rLniX36Yu9kg2R1pEO
         qw0q+roZW3oKRI4UvWTNunmMojxDVwo9vU70LYaVgPd6OfsDl8TBAYj3mCjUeOmFafxR
         wiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hQbCC2Qtr4ZiCu8Gyf8ZErDlr2Im7SfT6dGGEw7uc9s=;
        b=eSkiZoB8M0RJLOGkvvWipMAjtMKAQX9/MeLcTRGpPU9GiNOx2FvOTXCw4/JdKicC1M
         iX4kr7Z83rXJvQ6GPl0TTCdO8FI2s91grRrefEHy9p5D0mJxgwFr9JeCHdMg1TC/aczL
         MNzXYRLBRmilj2jWx2gAv4pshuzWDQw5tBWUDNTc7ZxcVLLJ5g/y1RrHi0iOhcZo8Lhq
         yfCK69RDFemRqhJLnQKZIikb3Cw6bEy9uMepOJ3M3THzMuyDT8hFmk1Eq09GNTA59Axa
         zlX6RBpNydT19R4n8sjA/Pb+oIVXTxEOV1Xg2Y2mWdeqZ2lu9BJapncxfUSIE7syAajT
         WoCA==
X-Gm-Message-State: AOAM533i2DdhlwkQToAAhOfPtdaIUOJrRVXBUV2iNzqlswNjMTUgpzQv
        VbKrCXgYssiDPhMGw88RsVcicScnz+7SxQ==
X-Google-Smtp-Source: ABdhPJwN7uykbB/bDW1h89wzKPqw2CED5tJDZtdxDVSbRv8kD4qujFvyuDzeIzBDwuH35ErSNiRk9MyWZPBwbg==
X-Received: by 2002:ad4:5042:: with SMTP id m2mr8029298qvq.225.1593500755983;
 Tue, 30 Jun 2020 00:05:55 -0700 (PDT)
Date:   Tue, 30 Jun 2020 00:05:52 -0700
Message-Id: <20200630070552.1110864-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] iio: adc: Specify IOMEM dependency for adi-axi-adc driver
From:   David Gow <davidgow@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Analog Devices AXI ADC driver uses the devm_ioremap_resource
function, but does not specify a dependency on IOMEM in Kconfig. This
causes a build failure on architectures without IOMEM, for example, UML
(notably with make allyesconfig).

Fix this by making CONFIG_ADI_AXI_ADC depend on CONFIG_IOMEM.

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ff3569635ce0..f5009b61b80c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -263,6 +263,7 @@ config AD9467
 
 config ADI_AXI_ADC
 	tristate "Analog Devices Generic AXI ADC IP core driver"
+	depends on IOMEM
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	select IIO_BUFFER_DMAENGINE
-- 
2.27.0.212.ge8ba1cc988-goog

