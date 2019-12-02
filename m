Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227FE10E6E7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLBI0I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:26:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38695 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLBI0I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:26:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so10946575lfm.5
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpFaEj2QFw73hwD48+XCq9Fg/UYZidDR2JZOAa7qqnw=;
        b=BZQe2PCZjdLdQii7EnRsx8O4jssVza/MrDQJn/3vbfYh/vw2BnpK6kGjWQu/EIzeLV
         VXtaM4rUQ7ecMLRhHEiGqQlSv1n9U74iB8uHvbFKxt7waRVx4BIyNH4o2TQCav5i5bPV
         N59qaZljCsFD5aKAExlP7GLm3H/YzQ2p+M3m8ZHX9Qnk8pgVvK0WZDjFMUvDb0GpRfiT
         b9wWCU7EUonETnWS36ahwJuNEui/gOnUzkbO8khlnpvubxso7rCP3GU05+b37ChgwAQs
         yKeKgf5ShDU4Az36vq/qnsvZWX1TJ1eXZLIy+ZLSRmp6F+A85UQhzeBhgJwzXDwAwuGW
         Z7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpFaEj2QFw73hwD48+XCq9Fg/UYZidDR2JZOAa7qqnw=;
        b=HPUrqv6H9h7iBHt3oRLK/pG+C9HFzKE8q03GAhIFdzxAIBtQWDQYJ12VPAot7ssElv
         D1Vwu7j1lWN+qQ9k62pI1lOpdXSNBmiecczWlFLzY0i0Wk319+RIPThk3QDAemu31/yL
         ttjLRe5rPRB8/2kf0MbC7FucJmA1wf7RAan8KcWkn3ETW67bkkMF1PLi6BAG3hiQUQmj
         Vsmltyb4uMkGLjATksw2EXEKJnCysQJi9G4Y/Ne3WJv+Fef5EthpsFEXO5auapz20tIh
         E4o+V99jMR1ndh9YhXFS2UcGD7GzwKr8Pdtgywok4rPd1d6PipUHHqq9Z8agRJVHn8V6
         +Wog==
X-Gm-Message-State: APjAAAXb7ILMO9cgVqLSw6GvuRye5iB+MMVImwUj3rChhzh/KaihKjID
        rMHonpOe6gv5wcY51JN6Fvcvuw==
X-Google-Smtp-Source: APXvYqzmu8Lw0u+lAo0SHQj1hBb2d5+/0GkaWeRediMU/CKJT8IxzjmEJCA+odAwIxriFWTFAj9kvg==
X-Received: by 2002:a19:5f05:: with SMTP id t5mr19168376lfb.149.1575275166212;
        Mon, 02 Dec 2019 00:26:06 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id k25sm5732266lji.42.2019.12.02.00.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:26:05 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: itg3200: Drop GPIO include
Date:   Mon,  2 Dec 2019 09:26:03 +0100
Message-Id: <20191202082603.63227-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver include <linux/gpio.h> yet does not use any
of the symbols from the header, so drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/itg3200_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index 981ae2291505..b3afa556f973 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -15,7 +15,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/module.h>
-- 
2.23.0

