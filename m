Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AE10E747
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 09:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLBI6y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 03:58:54 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39421 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLBI6y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 03:58:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so29909166ljj.6
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 00:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHT6AG89gI7zW8x7ZuRZ2mwQi0xJr6B7/V5dvzyMiw4=;
        b=WDNguznGWx2cESrlV6OsXeAXJnhk93SIXZcG4d42jAZTpxJlAsLjLKU8szu5D/0ICl
         9/mrRgToA4Q8js9Qd+VvQt/PvokpLa/bdjAS/YQ1JSskdWYt91SPzNCKGlPYMcc1LGIS
         I4FI1OCvN6OeMmmU3CwLWyjCcoUOUFKRGod/A+KCEnIPOVQIr6ZuBqK8gxhf04Pty6zv
         BuYB1gPNYVmX4k9tNx3I7cKTCfKVUEqRHvVE4atREHRAKna8CO4BhoxD2P9wydixSruj
         vZovhsE0xNkC+6VPDvGieUb76+PuoANWF8FsPKf1DXIBIvJKKQ+1BjPbwRtw/NBWovJI
         rKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHT6AG89gI7zW8x7ZuRZ2mwQi0xJr6B7/V5dvzyMiw4=;
        b=E/3Ad7dbp3z9brfXXVIwMzPzEVOHJggHzq8VfWSLm2O3ZDGzDdyi8WvuP0f/Z0BKge
         PKXSX0P3LHS7p6L/fWbz7ZE8xfbsIEiGVSDH3CFfguXx0IzRrnc9gJuiPguXnjEVWdxS
         h8ABswb1es+IfjKEkbqtGmrkUbEeM/ByCK4ioVlPzj3P/VChEG6zRdOlq4Ox+ugQOaZg
         XBH8aA6o1EHqmGzWpPv2tLf1umuORHefceACMCu4IEftkDzal8XGbFopZGvV1brY2Vw3
         WF6Bg90Z1JeCmETWPwy5avV9izP8C2cDmY2jqYjmNKxhRvOl6Uwxvb03Y0p+JZMkZK2B
         jfQw==
X-Gm-Message-State: APjAAAV31UPGQzvHoTToco25kvbvbXtz6YHI6kK+x9ip2a96VJn4191S
        cjO+ZODnfGEPf3gqTEp1D2XouA==
X-Google-Smtp-Source: APXvYqzc8fjz2TnML7ySjBL7MGbfM9LKyIGTyfAsEJzPtqCLtvElvsv6FVs9E9XIQL3HbpBGKP9dXg==
X-Received: by 2002:a2e:2283:: with SMTP id i125mr30365773lji.244.1575277131471;
        Mon, 02 Dec 2019 00:58:51 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f8sm9942982ljj.1.2019.12.02.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:58:50 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: ad5592r: Drop surplus GPIO header
Date:   Mon,  2 Dec 2019 09:58:48 +0100
Message-Id: <20191202085848.81573-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This driver uses all the modern GPIO APIs from
<linux/gpio/driver.h> and <linux/gpio/consumer.h> so
just drop the unused legacy header <linux/gpio.h>.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/dac/ad5592r-base.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 2d897e64c6a9..e2110113e884 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -15,7 +15,6 @@
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-#include <linux/gpio.h>
 #include <linux/property.h>
 
 #include <dt-bindings/iio/adi,ad5592r.h>
-- 
2.23.0

