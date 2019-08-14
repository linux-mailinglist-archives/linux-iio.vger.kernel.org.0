Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6888CF3B
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfHNJWU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 05:22:20 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:43064 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfHNJWU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Aug 2019 05:22:20 -0400
Received: from x4dbd508b.dyn.telefonica.de ([77.189.80.139] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1hxpU0-0008O2-BN; Wed, 14 Aug 2019 11:22:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] iio: max5487: use devres for iio device registration
Date:   Wed, 14 Aug 2019 11:22:05 +0200
Message-Id: <20190814092205.11031-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace iio_device_register with the devres variant and drop the
explicit function call to unregister the iio device.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/iio/potentiometer/max5487.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
index 68ff806d4668..a6c92050d397 100644
--- a/drivers/iio/potentiometer/max5487.c
+++ b/drivers/iio/potentiometer/max5487.c
@@ -110,15 +110,11 @@ static int max5487_spi_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static int max5487_spi_remove(struct spi_device *spi)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
-
-	iio_device_unregister(indio_dev);
-
 	/* save both wiper regs to NV regs */
 	return max5487_write_cmd(spi, MAX5487_COPY_AB_TO_NV);
 }
-- 
2.11.0

