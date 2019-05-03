Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7BC128C9
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfECH2q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 03:28:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37355 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfECH2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 03:28:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so2318895pgc.4;
        Fri, 03 May 2019 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV91r0hSgx47A83AU5LfJSSAdebNF8xkPCOvty2B81w=;
        b=f0kMsjpx0hReZbqS9A/IXDD04OeHrLmjwND+PaKZnv0lNFwIvz1+8f/D0fcaBpcjIr
         3THia+s7KlQAPC75y6kfAM5tFbhKhcK34VvYtG4SXXajH/prr3rBdObYEUimYeMrLHAM
         W9stvHHEUJWhi/4TWXlJBqWsT9hZSZP2hS/A+mhwG5KMLY0Nh0oFW2fr+lFayywX4In0
         iEQuIFu8AXL/SFXCBXSjZJiu/68s0Vcvab2mgf6lLgypQd+wNuiqu6e7aGeAz40vry7K
         0QXiQC5eQDPBGYe90V+j2Vs6Ek4/nQiUNNjl0nkv+uApUE6juP602HM41dGAu2IDWZsd
         3cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV91r0hSgx47A83AU5LfJSSAdebNF8xkPCOvty2B81w=;
        b=a5cln8kXhHIN0AaGE5AtBWG0poSpip+nGNHrhKjcxdTaXMPAATp5+98zaWaQY6RSqh
         opX7mUzTQa4JhEA50H7WjgLAdefVUfPxOpmn9Dnc6pI8YE2olhBLRt4GgjW0TjMYQQ87
         9n+xLhvj2Yb6L8pkM7lEMy93x9Vywfh9+zS/vC5ksMLhSQaCWepsLO969cyeKul5+84T
         07os/Mx2X3f9Tjc1S6eRox2nJeOLisC4SbTevUz5jHNiV21EUZdZEEpabg4Lblv8hkYB
         VY6BxvyLVcxhW5x/qAMwJRp2aqItBgFWEvgK4qBRkuvB88kRzk90LTemcEHsQ23p6/7B
         nqog==
X-Gm-Message-State: APjAAAU7kTRXGLGZBNC0V1y+/P1dx00BoAqaV7+fUUVc+u6JakIKLapz
        ei7hgG5QMK1tmIYSuibh85k=
X-Google-Smtp-Source: APXvYqx3mHSYhYaU9e7dYSrcNlJV0QAsUNqmUsZfT1vnGpilYcYIfUsnBG2kbbtSGDGI8szlCy5aNg==
X-Received: by 2002:a63:534f:: with SMTP id t15mr8595106pgl.445.1556868521022;
        Fri, 03 May 2019 00:28:41 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id c18sm2318243pfc.0.2019.05.03.00.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 00:28:40 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 7/7] iio: adc: sun4i-gpadc-iio convert to SPDX license tags
Date:   Fri,  3 May 2019 03:28:13 -0400
Message-Id: <20190503072813.2719-8-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190503072813.2719-1-tiny.windzz@gmail.com>
References: <20190503072813.2719-1-tiny.windzz@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Updates license to use SPDX-License-Identifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 9b6fc592f54c..cf2bf3ab3342 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
  *
  * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
  *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- *
  * The Allwinner SoCs all have an ADC that can also act as a touchscreen
  * controller and a thermal sensor.
  * The thermal sensor works only when the ADC acts as a touchscreen controller
-- 
2.17.1

