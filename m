Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3E31E30E7
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbgEZVDE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391685AbgEZVCz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:02:55 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A9C061A0F;
        Tue, 26 May 2020 14:02:54 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w10so26356654ljo.0;
        Tue, 26 May 2020 14:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7szgAjSgR9Dxc5OfQmj2wG81qBzS351Y34fwZU3ACdg=;
        b=JFvZsvn7M8wwKWkgMnNYUUu8Z0Gg+2qhBAFDcx5roPbQVVlFnODV9dTzIfF5bWyK8r
         TDOozjhqYP6H+UKRo+M8XDNJAtFngmhEsUuaGPjkwKXrZS7dY9bf0Cky+YJwdumlfUwE
         +vtuIOnPgCEkcIC3HJXCw/2TD44oK4Q1O4UWmi6Fwf/yDqsiNcZ00WIqYh4ZTDJ4mYgk
         8tNLnPECaw85TSwLVfM9VzMz1B6XuL0Z8NxahS4E/hETV8LO+g6WKGlG4r0u7kj8qs59
         OdrbbFcUR83zRxjnJqd/Xu7zbAbDS7sqFP6qFwJX2zd27KYP3oZuKz566Mz9ZLi7G/8f
         +7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7szgAjSgR9Dxc5OfQmj2wG81qBzS351Y34fwZU3ACdg=;
        b=o4bNpQcp0mDRdcjUUlNw4NcR81ejYWUjt1utT4IOPpwIc6kMWtizoVjOicky85LGLv
         mvBpRTnUmpZcqi5gN06n01qXJe17Gat9ePCcRygu62dS5z+Oyeqi9tSdWIaLp8FAeY/w
         3w3Y9zttf17W0jK6ALW129vmhYIVkeFLLjTUhht6Vc93zx/bdMSpmtICj18CGX48gwmk
         rNg9+eu9vZ8vvoDW7htP7QuMALYbmzyVgBla9L0m1SlvJ0J1rZbRMEUj1ysjncRyFEEb
         pEC4oGE4uBFcCG1Vh6vYfvyduH+G9OGlyivVnpsv0edlCWKaNCTudRFoudlRiescRqBD
         MrWw==
X-Gm-Message-State: AOAM530Xae2s+Sa5/pV9gsZZV1kVHYkxSOJmJcrfJ5Xz6Kt/+7JbayUh
        2CG1slIGbJNmPQ3I+qHUvpI=
X-Google-Smtp-Source: ABdhPJy6iVIbUisUyaxZ7Wsy0lvp/WF590HWd4bc+DrD8zCO4JFD4s7lOdudWJ/TykwOpoXlaNWYqA==
X-Received: by 2002:a2e:88d8:: with SMTP id a24mr1594053ljk.62.1590526973327;
        Tue, 26 May 2020 14:02:53 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id z133sm240443lfa.41.2020.05.26.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:52 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 6/6] iio: magnetometer: mmc35240: Constify struct reg_default
Date:   Tue, 26 May 2020 23:02:23 +0200
Message-Id: <20200526210223.1672-7-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
References: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

mmc35240_reg_defaults is not modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   9759    3288     128   13175    3377 drivers/iio/magnetometer/mmc35240.o

After:
   text    data     bss     dec     hex filename
   9823    3224     128   13175    3377 drivers/iio/magnetometer/mmc35240.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iio/magnetometer/mmc35240.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 1787d656d009..f27586716b5c 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -459,7 +459,7 @@ static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct reg_default mmc35240_reg_defaults[] = {
+static const struct reg_default mmc35240_reg_defaults[] = {
 	{ MMC35240_REG_CTRL0,  0x00 },
 	{ MMC35240_REG_CTRL1,  0x00 },
 };
-- 
2.26.2

