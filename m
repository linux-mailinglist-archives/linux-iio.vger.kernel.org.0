Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FCC103C38
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2019 14:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfKTNlt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Nov 2019 08:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbfKTNls (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:48 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DBD224D0;
        Wed, 20 Nov 2019 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257308;
        bh=Ji/d8zDpNXz2ULxuAqJq6wiOMM2wmyReCHpUzZYzkwE=;
        h=From:To:Cc:Subject:Date:From;
        b=jXmBgxsGumokE0ef/plIwRMyCW3R5sn20F46tnew2Lgywni198kqmqX0o/68RImGE
         cmuPSMNhEHRvbLowInK2gtMG0oI96ehyGTBipluDD2Vu9ilj1VFfDOPYnqvsUdPHjM
         CUOZIF+pPru9ibdBHv8uVrk+RVWzpKwCApXEajYQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:44 +0800
Message-Id: <20191120134144.15302-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/gyro/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 95e6f96d4529..f91af3b8e4da 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -82,11 +82,11 @@ config FXAS21002C
        select FXAS21002C_SPI if (SPI)
        depends on (I2C || SPI_MASTER)
        help
-         Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
-         Sensor driver connected via I2C or SPI.
+	 Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
+	 Sensor driver connected via I2C or SPI.
 
-         This driver can also be built as a module.  If so, the module
-         will be called fxas21002c_i2c or fxas21002c_spi.
+	 This driver can also be built as a module.  If so, the module
+	 will be called fxas21002c_i2c or fxas21002c_spi.
 
 config FXAS21002C_I2C
        tristate
-- 
2.17.1

