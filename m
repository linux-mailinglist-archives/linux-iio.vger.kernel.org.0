Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274D0553B76
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354287AbiFUUVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUVk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED71D31D
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08FCEB81B07
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83C2C3411C;
        Tue, 21 Jun 2022 20:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842896;
        bh=R2gsaiV4+lhilC5q8GSyNZWsyfrFLN7guWU0VpZnndU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4DiiQfTOvQvrX3lL2z+UfHikeDGWPyRIG5oURlBdLxkUHVKq/HW5rJ2yjBqkdYFC
         TNOWBr1eljjXSgQb6N1cmZhkisO/ldonM5gvg+6mgTW4TenFjnncC57yZCSbNDVK9h
         0TnJQ933eV3jMjBlsBw9EmqqzQWZAKY+Vcn5dxFwlBo/w1G1iH8H1LIfkLrLsY0Grh
         e/PTN4P2HXfqMqjhUy2k6n+3WslYyJs8H3S+kKS2O1pSSA94us4VxjH5pqOuVIBEua
         odGB3wCGjNH9cxqV7Lmqsl++c/GqPaBGYGVajuc8wQu+2CsOvA8yw+PoZvIMQzFX89
         kaFKjaiegexnw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Christian Eggers <ceggers@arri.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 26/36] iio: light: us5182: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Tue, 21 Jun 2022 21:27:09 +0100
Message-Id: <20220621202719.13644-27-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621202719.13644-1-jic23@kernel.org>
References: <20220621202719.13644-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Very likely it would be safe to use DEFINE_RUNTIME_DEV_PM_OPS() here,
but that would be a functional change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/us5182d.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index cbd9978540fa..80d2299da561 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -922,7 +922,6 @@ static int us5182d_remove(struct i2c_client *client)
 	return 0;
 }
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
 static int us5182d_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -945,11 +944,10 @@ static int us5182d_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops us5182d_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
-	SET_RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
+	RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
 };
 
 static const struct acpi_device_id us5182d_acpi_match[] = {
@@ -975,7 +973,7 @@ MODULE_DEVICE_TABLE(of, us5182d_of_match);
 static struct i2c_driver us5182d_driver = {
 	.driver = {
 		.name = US5182D_DRV_NAME,
-		.pm = &us5182d_pm_ops,
+		.pm = pm_ptr(&us5182d_pm_ops),
 		.of_match_table = us5182d_of_match,
 		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
 	},
-- 
2.36.1

