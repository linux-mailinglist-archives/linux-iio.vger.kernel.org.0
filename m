Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36434BA93
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 05:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhC1DxJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Mar 2021 23:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhC1Dwp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Mar 2021 23:52:45 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D663C0613B1;
        Sat, 27 Mar 2021 20:52:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h7so7139328qtx.3;
        Sat, 27 Mar 2021 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rc7yssPbV27sYNALyL+r3owRxSm/5ty2UM3T5ky+ids=;
        b=H5ybrH9DttYV1k+Y4B1WzKhMHEJtScukLQbtndy6DB7p8KvLu78+x+Ws3jTwbYPz9V
         iL8mGZqkOpd3KRsjImM4iRB20okyB9Nh5/xjIhQABcTpiRIammSIpGTvK6Sad/Q7Byo0
         HtDPwXh6Y9wtA8pkeoar8hs4OVjMhgPhb6zRe3PiznfLI2AWuxOiKwHHcFql2rcOZfVK
         TiG5XfYvCGOLULFvu/EENkYRqBdxItKOKNnKfnY6i7Kg0U2Rm8aKZJmLN1aVF4D+rnfv
         +g647T0MWuIB/7hsyaFavwiTuIrPIsvtLpik/3DXOYi5uyBLweNt+g47d75lw2NDHnCT
         zGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=rc7yssPbV27sYNALyL+r3owRxSm/5ty2UM3T5ky+ids=;
        b=QK/Jx/XxqVv5f+9S0+oQEVyK/rw6bNU8TlwECOCTl5mLEzazosub3ANpp9y/AONo5S
         1ZzNWVa0ZHUjNnxPSzyiEeqHGteIfKypTMgmq4l9y2rcaupi2d5PNX5R+a7jxXi7fdS6
         qi7OcY1AnLv+eAlCyPMrTsWKvzyP/k3ktySt+E2zkN9maAsLvW0u9mEwalHNueh+zphE
         GRUIQSxBQt5MI7eiztjF9Mjdv4kRA3O8iwy6tt/KvYvPF5uWI4tnytqJHjOqH3cuwF13
         cQ9hHAVNZ3+2Id0yXkCgh6Mp4eGA+lYhK1z6LB2chHHiFvdsY8jMJXILDtpYiVkBDvIn
         E7vg==
X-Gm-Message-State: AOAM533OkLpPD1ULpeH0CONRZ1S5gCD16JUSWHnWQAQIJMN9CQoag0WF
        ivDB9ctV3VA9XR+SqDZiqdU=
X-Google-Smtp-Source: ABdhPJwajyUzsIXfJ9bvfbUUi1c4OU1ufMrq1i2EHc9UbUgtmwThpRlGoRyaVIn5P4m7ygCzq5xEeg==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr17897181qtn.148.1616903561702;
        Sat, 27 Mar 2021 20:52:41 -0700 (PDT)
Received: from kde-neon-desktop.orld.fl.wtsky.net ([208.64.158.251])
        by smtp.gmail.com with ESMTPSA id i14sm8715426qtq.81.2021.03.27.20.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 20:52:41 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     jic23@kernel.org
Cc:     fazilyildiran@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: iio: adc: fix unmet dependency on OF
Date:   Sat, 27 Mar 2021 23:51:59 -0400
Message-Id: <20210328035159.47259-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When AD9467 is enabled, and OF is disabled,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for ADI_AXI_ADC
 Depends on [n]: IIO [=y] && HAS_IOMEM [=y] && OF [=n]
 Selected by [y]:
 - AD9467 [=y] && IIO [=y] && SPI [=y]

This is because AD9467 selects ADI_AXI_ADC
without selecting or depending on OF,
despite ADI_AXI_ADC depending on OF.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e0667c4b3c08..7606c9b1630e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -248,7 +248,7 @@ config AD799X
 
 config AD9467
 	tristate "Analog Devices AD9467 High Speed ADC driver"
-	depends on SPI
+	depends on SPI && OF
 	select ADI_AXI_ADC
 	help
 	  Say yes here to build support for Analog Devices:
-- 
2.25.1

