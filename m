Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B1125E07A
	for <lists+linux-iio@lfdr.de>; Fri,  4 Sep 2020 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIDREg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Sep 2020 13:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDREf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2020 13:04:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC217C061244;
        Fri,  4 Sep 2020 10:04:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so6706737wmb.4;
        Fri, 04 Sep 2020 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnhyxI2YW5mCxRpk6hspno3Ftt+MAEF29reZU4Qqw2U=;
        b=iZQkkf6izy+fvsbb5gd2CCpJANc2aFO2akcl5DrXKfp/Zd29xDWNH8JHNG7iH2QCPI
         3Lw/zdWQLASMouw+2tht0b9dJM7YwAClfzpE9Uyg+RdNJuYdSC24ClQcbs8TTsbgsH6E
         KVe8LIvhfpsfY8KOgERJYvJY7c8rsddfLmxCJ0LL3QdrKyH1hTb1aPx4uowyjB23RHZu
         /evXgP1vA4rx+EjTtO1WPLxTFQRG33rmDph6zGXhgux/YX4wZ0oin6GT3tKBvUsHlMCV
         cLEdbvhqoKhb6xbxti0lmjZ2QVqL4z+uPTeXZYunWzT8YjDmkI+OY/u+TAucokSqcZ1J
         SA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnhyxI2YW5mCxRpk6hspno3Ftt+MAEF29reZU4Qqw2U=;
        b=KI5pjDuf7+TMJ3DJ92TZ6oklOqsvULE/wZg2DVhr2zv1Wam1YkTp7hJv2022NxExQp
         d2AQOQpPRfmyTPS7NRXF57gnqGw3Qt3UWDlxa3/W9T6B852L0OLzkLtACCe28LQEcmy8
         2TxmZoiJqmQSnwsf+9KIiGAy3nsoB6SwMBD3jBKzWPwdkHimurN0ZrkYF2+9zed0o+4y
         R6oIYWYMdgadHo0Vp7KkaRq7k6p6jD426hhFz3qAu2nw6z/2cH2DzVpbzspBWUFFAfyu
         JWwDS0LcpbIR3As/yrWek/1Jl7wt/L6vR4xywlAdSrYlqTSgLiTkQxYrMTNzquKmlBsF
         qJ6A==
X-Gm-Message-State: AOAM532b3qvRaZGHZYAsrDnI9jfSooPjg+sY5Y64SDLwb/oeMuOvqP2N
        3zKXfzqXGIHn/7giqlu9oy0=
X-Google-Smtp-Source: ABdhPJwTay7wrMhUJ7lacbMquseeNhy37Fil53XNxaCXx7jKQTbxBga2aWvaK3SVGUi5cXCZB8GUng==
X-Received: by 2002:a05:600c:2109:: with SMTP id u9mr8060516wml.147.1599239072429;
        Fri, 04 Sep 2020 10:04:32 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id 5sm12144759wmz.22.2020.09.04.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:04:31 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] iio: adc: rockchip_saradc: Allow compile-testing with !ARM
Date:   Fri,  4 Sep 2020 18:04:16 +0100
Message-Id: <20200904170416.16061-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There seems no reason to allow for compile-testing on ARM only, so
remove this restriction.

Build-tested with allyesconfig on x86.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d94dc800b842..03929606bb01 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -863,7 +863,7 @@ config RN5T618_ADC
 
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
-	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on RESET_CONTROLLER
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
2.28.0

