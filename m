Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71067255FE3
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 19:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgH1Rl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 13:41:59 -0400
Received: from foss.arm.com ([217.140.110.172]:54350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgH1Rl6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Aug 2020 13:41:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21A051FB;
        Fri, 28 Aug 2020 10:41:58 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A911C3F71F;
        Fri, 28 Aug 2020 10:41:56 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, xxm@rock-chips.com
Subject: [PATCH] iio: adc: rockchip_saradc: Select IIO_TRIGGERED_BUFFER
Date:   Fri, 28 Aug 2020 18:42:42 +0100
Message-Id: <20200828174242.338068-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Building the Rockchip saradc driver can trigger the following error if the
driver is compiled into the kernel, but the IIO triggered buffer is not:

aarch64-linux-gnu-ld: drivers/iio/adc/rockchip_saradc.o: in function `rockchip_saradc_probe':
/path/to/linux/drivers/iio/adc/rockchip_saradc.c:427: undefined reference to `devm_iio_triggered_buffer_setup'

This is because commit 4e130dc7b413 ("iio: adc: rockchip_saradc: Add
support iio buffers") added support for industrial I/O triggered buffers,
but didn't update Kconfig to build the required file. Fix that.

Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 66d9cc073157..baa36a07a9cf 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -865,6 +865,7 @@ config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
 	depends on RESET_CONTROLLER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the SARADC found in SoCs from
 	  Rockchip.
-- 
2.28.0

