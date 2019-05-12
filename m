Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB231AB39
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2019 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfELIcx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 May 2019 04:32:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38622 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfELIcw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 May 2019 04:32:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id y2so51214pfg.5;
        Sun, 12 May 2019 01:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=So49QM/G0e1w0Tw1JbHTUsVfTVbAXUEky8Oa0BHWDOE=;
        b=DtOdcTD2JCgcbPghfxWCN6MaD3kT9q0wiAPsmd6CBiPpgBx/En9lh04YNvIexlK0+R
         /zkzNidnYwSNO6m0W0JXAgQbmVdbdj+n0CwIiFowdiCBxNvwuFgzs7Ti/j6jaiIKlDsC
         hBjyDI04/YPxPFUHp8tKEBXhbJ/uuAQOd4HrQjsI95SHlE3dUTDyzqCLhOkHcO37T9c3
         jJUYNUubHOne16swK2waxI6c2BYHZfpW9YTrGh61geDfWHAjNmC767kbI+h3JG1+sPjU
         VcUnhEW3Xau8kT4XVBg3n7eGCy1n8SbtXUe+yJvUUB3JIsFGfmbIXt7Od2DF/HUo93YL
         Tp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=So49QM/G0e1w0Tw1JbHTUsVfTVbAXUEky8Oa0BHWDOE=;
        b=nt5UpiXPZm4dBr6OE2N9T+lm9YcA6ycuGeBkTfZghRHOK0bOvEVb4pQBPnhLd5i0ol
         EhV997g7bsOTARJV0liJQujuhsPO+Ebaj/5v6rwmoTFf5VtSdtczYNX498BXVhvjIc4x
         +iXq5x6EierQyv6WY8KaUeG7nqvPRco2FHtV9hyv/vWDR9+cSs3BQv5c569QiGh4/WMc
         kn6yJAE8zNFbJEW1/nlVq4HW54DUZK1CZXMAVAPKDjpcgHlL5LnMyKfYueS9qI1RhNKE
         FgFYGcEKRlu7XYmniAQUXhilcQY3oV38atEi/Y6Qp1kqhhXvjNNYK8pP7ap8I8e84mLn
         JtkA==
X-Gm-Message-State: APjAAAWB85zlaC6M6/uqdsVxxNjNfGfWW6yflErUvvGErAwm6kc+KW0r
        lB1XVWoOiPCD/7aAEKm4q10=
X-Google-Smtp-Source: APXvYqweVnvcwSjuHuUcc1OM3+ZMw8cyKqWLSc4nMOpfa6sB66dX9dD56Omee0QRO0iGZy8ytlkJAw==
X-Received: by 2002:a62:1a0d:: with SMTP id a13mr26330956pfa.198.1557649972136;
        Sun, 12 May 2019 01:32:52 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b67sm12076538pfb.150.2019.05.12.01.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 01:32:51 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] iio: adc: sun4i-gpadc-iio convert to SPDX license tags
Date:   Sun, 12 May 2019 04:32:41 -0400
Message-Id: <20190512083241.9191-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
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
index 04d7147e0110..f13c6248a662 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
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
2.17.0

