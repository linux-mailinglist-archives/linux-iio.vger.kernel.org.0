Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DBF23A112
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHCIaV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 04:30:21 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:48367 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCIaU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 04:30:20 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ED4EE22EE4;
        Mon,  3 Aug 2020 10:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1596443417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OIZj9ZscenWslEagGF3KNIIVzm1zaVR0sAtkh3SLZQc=;
        b=lbSw7vySBDIDPmgI2Exq+wQEUihNRiC0YVXBS7x5RFKCYDWILQaf96x3/yakxTuOEFAVfx
        s8+JSiNpZ+hl6WPXOn1ChywazptEEusZPn3fZp5ERqmfTITt2i8MMAwT7MCw6JkBz9GRZj
        Uu2zhkA2EKLHKf2xnw9Gwjq5BmjOcwY=
From:   Michael Walle <michael@walle.cc>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Simon Xue <xxm@rock-chips.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] iio: adc: rockchip_saradc: select IIO_TRIGGERED_BUFFER
Date:   Mon,  3 Aug 2020 10:30:01 +0200
Message-Id: <20200803083001.6689-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The kernel fails to compile due to undefined reference to
devm_iio_triggered_buffer_setup() if IIO_TRIGGERED_BUFFER is not
enabled. The original patch [1] had this dependency. But somehow it
didn't make it into the kernel tree. Re-add it.

[1] https://lore.kernel.org/lkml/20200623233011.2319035-3-heiko@sntech.de/

Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 66d9cc073157..d94dc800b842 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -865,6 +865,8 @@ config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
 	depends on RESET_CONTROLLER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the SARADC found in SoCs from
 	  Rockchip.
-- 
2.20.1

