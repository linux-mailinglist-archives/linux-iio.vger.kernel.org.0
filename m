Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6B31BC9A
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 16:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBOPcU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 10:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhBOPbH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 10:31:07 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37CEC0613D6
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 07:30:26 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u4so8219160ljh.6
        for <linux-iio@vger.kernel.org>; Mon, 15 Feb 2021 07:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tw5kGX/wN0aLH+g+NvPcP8n/H7DznXIrgtDbZyQfeHU=;
        b=rjRU6U6SRdnWxqm5DLwVj+p6NHPTLkQ6WF2lHWITpkFPMpeufJlgNJXpzw0lfygO1B
         EolObpR3JYUczChlN8BJSYjPx7Pve1ClOcjbnnPpdqeeory8wwOzRCDIH9SpgvqFGdzA
         y7J9SKsOP/WS8+i353wr6ihWBXN84J+ksZpBryVcxknLb0qMUpbMNpJsprgbpP93FjO1
         4EaFE/qrUsVejag5TtnvSjIqO9LaWTI8EF6uEIX/FYKRYeORvKduxBOrVIu+pYjRULoS
         bmADN//1gCc96RsKPIK6BIT/jb5hBl8Iys+vbWi4BQ+jhy7hFPFkrIAxwi3nBHD2pPe8
         gWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tw5kGX/wN0aLH+g+NvPcP8n/H7DznXIrgtDbZyQfeHU=;
        b=IWc+X5nPogqUioF5ihtHksMxaaluyBSJsTEBE05Vzi2X3BwBCTSZliIEHD0nb9CNGa
         /8XZqQe9V1Oe/cT0BeHPTRyNHeq5OL4kG/yimH1eBtpHcwY4MYnyCSdLDrwXnY+Any7V
         yvs6JhqZePht9d/SgLBNXKzMtX3H3eIJrJcGyPAS+qyV+TTB38Fw0vRhtEX1hQBvZ8I7
         MiqLuv0KLUB/tpC2lWfINe1rFb+989+/5DuJdlH8a3uiMMeUHmaXNeFDUPBbgvxJoVUX
         Wn7AIa4TDg7JkX9rRzdvS+oFxbEtJt8ENny8jw4iUoSqs+mZM94b8Sp6bYpDsaBzapj8
         w3Hw==
X-Gm-Message-State: AOAM531b7RMEbNuXAQM8T34+2NYXYNevzAcUN7QfCunpSbI6FpPHEPui
        fs34TMLKPS4wB1GNjdfCmRHwfg==
X-Google-Smtp-Source: ABdhPJxuVIFMpJPt1pcGebXuNF9BKxSpAVHZiQBy9whACiHPkMcnQOtcHoLg7B4Hyjg+3v7QvuHyGg==
X-Received: by 2002:a2e:ba18:: with SMTP id p24mr9418061lja.488.1613403025394;
        Mon, 15 Feb 2021 07:30:25 -0800 (PST)
Received: from genomnajs.publikt.skane.se (host-78-76-89-148.homerun.telia.com. [78.76.89.148])
        by smtp.gmail.com with ESMTPSA id n6sm395777lfi.92.2021.02.15.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:30:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 1/2] iio: magnetometer: yas530: Fix return value on errorpath
Date:   Mon, 15 Feb 2021 16:30:23 +0100
Message-Id: <20210215153023.47899-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There was a missed return variable assignment in the
default errorpath of the switch statement in yas5xx_probe().
Fix it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index d46f23d82b3d..cee6207d8847 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -887,6 +887,7 @@ static int yas5xx_probe(struct i2c_client *i2c,
 		strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
 		break;
 	default:
+		ret = -ENODEV;
 		dev_err(dev, "unhandled device ID %02x\n", yas5xx->devid);
 		goto assert_reset;
 	}
-- 
2.29.2

