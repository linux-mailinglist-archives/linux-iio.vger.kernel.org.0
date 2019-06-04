Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0F349B9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfFDODt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 10:03:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45284 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfFDODt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2019 10:03:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id f20so590710edt.12
        for <linux-iio@vger.kernel.org>; Tue, 04 Jun 2019 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89Zm5tqX6wwdqdwxOr1J581zGxrK1/FIkPJm608gBw=;
        b=ReKQN1Ltrc6A4Z2El8pR0PXGPrStXWhkcji/2N49UFsdqNCVNCvN0X51v/dE1/VPRd
         HPhxKvSXknjmV5O5G37Zgr/+sD5IH9j3pfDGes/yd1qFzfjvkOeVJ9ueDFqRPogPOMFE
         kJ0k087RquGzueGpV1rBYb6vJ2sXkSzbpZJEhwVmSl81s4UCQC0LKLN+Kql5RCnWBOsn
         XRliNKxpM+wnPaNSqjD2PMGxo0FoKaNIJgMgeqzR0F/pRgTERUGzKSF7SKhZ08gis1dK
         olAB2pwpRVOYAw2XSWckeGQzDeMlS+P1M1RAjn+UinMUCzpJFpsiHg6Plsn6gDvyRZ4t
         dcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C89Zm5tqX6wwdqdwxOr1J581zGxrK1/FIkPJm608gBw=;
        b=RDj85AW9KtDKirQsThi4HCfAYYTeaTNWTm8eM2t2YODjm8QzIrZYMn/H957Foxe2ZF
         ls7EqBObtTWLlbLoRxmdPHP14rjw/XGI5yPgYYxYCaJCwMc604xIdBO4DpgfLbUqqJz4
         PSE7kYUAGlLTStMXbyuEL9QZbom360lZY5FAz6ZeqQESat2/ElZ0f+FC4cVovuFsK/mV
         beDglWIUWGvqAypZpUiaBfb0n7kfV0JKXhUXwIqVfTuybGHVNNVt5ulQbUfz7X0EmIak
         l2JAfjSfcnqmDbpKsc5TNw0bPfFd2TPaWEouQqzSueEIganssUy11KlfE8O301R0Qoww
         53Ng==
X-Gm-Message-State: APjAAAWNwdPRrKT1dlb30jpzG15NA3Uh+Pmh+XJxJLPEQqqlKvBOMGm1
        YFb3CRQkQ95MwKJ1jde4rzI8tA==
X-Google-Smtp-Source: APXvYqzNo6pxIWtWg6c+hl2tqLBkAFuScB+C1FTzvmh8Szoa7TT0yDrjXkqI6mOBi2SBSea2psc1yg==
X-Received: by 2002:a50:905a:: with SMTP id z26mr35907729edz.96.1559657027339;
        Tue, 04 Jun 2019 07:03:47 -0700 (PDT)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id j27sm3194485eja.91.2019.06.04.07.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:03:46 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/1] counter/ftm-quaddec: Add missing dependencies in Kconfig
Date:   Tue,  4 Jun 2019 16:03:26 +0200
Message-Id: <20190604140326.12295-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver uses devm_ioremap and of* functions. This fixes a
linking failure with e.g. ARCH=um.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/counter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 233ac305d878..c9e3f5c98484 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
 
 config FTM_QUADDEC
 	tristate "Flex Timer Module Quadrature decoder driver"
+	depends on HAS_IOMEM && OF
 	help
 	  Select this option to enable the Flex Timer Quadrature decoder
 	  driver.
-- 
2.19.1

