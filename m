Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284FB790B9D
	for <lists+linux-iio@lfdr.de>; Sun,  3 Sep 2023 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjICLac (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Sep 2023 07:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjICLab (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Sep 2023 07:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A53F2
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 04:30:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A2F61154
        for <linux-iio@vger.kernel.org>; Sun,  3 Sep 2023 11:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D4EC433C7;
        Sun,  3 Sep 2023 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693740627;
        bh=5j21tsKr0A5efOjvvxG1gnfhwg5gBOVOBa8zPe138U8=;
        h=From:To:Cc:Subject:Date:From;
        b=TDkBmcZlCWZTUWEb7SeoR9IjCFmR9ztt4IoKwQz2GN+kkHAHbaFIxnyc9PNZN8D3x
         aTnm//znFUgnBnBn6G8Y+Uy7Vyw1lcWfxixjtaRGVe30wnKhk49NFtqXdTIn6r9q1K
         VoYVaqtuLGhyZ6RMjbEPV5LPe/2MdcR8aqmUFziEGX5YgTmkGhMuVy3WpgeBReNnTO
         RlykjUNUhGoEWaHse0OSjun8ocekKbhqNqQjSd5lwK4AQJWBx/nuFV1Qua5VTFP8t2
         vXNw06UufPAH5cEeBJAboU/6AqugCkq0cFKGRx9o+BmsgLXQN0eV6X7xQGjoOeqj42
         HS8KIma1zb4Gw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [PATCH] iio: imu: bno055: Fix missing Kconfig dependencies
Date:   Sun,  3 Sep 2023 12:30:52 +0100
Message-ID: <20230903113052.846298-1-jic23@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver uses IIO triggered buffers so it needs to select them in
Kconfig.

on riscv-32bit:

/opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: drivers/iio/imu/bno055/bno055.o: in function `.L367':
bno055.c:(.text+0x2c96): undefined reference to `devm_iio_triggered_buffer_setup_ext'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-next/40566b4b-3950-81fe-ff14-871d8c447627@infradead.org/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/imu/bno055/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
index fa79b1ac4f85..83e53acfbe88 100644
--- a/drivers/iio/imu/bno055/Kconfig
+++ b/drivers/iio/imu/bno055/Kconfig
@@ -2,6 +2,8 @@
 
 config BOSCH_BNO055
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config BOSCH_BNO055_SERIAL
 	tristate "Bosch BNO055 attached via UART"
-- 
2.42.0

