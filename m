Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D048CF35
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfHNJV4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 05:21:56 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:42380 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfHNJV4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Aug 2019 05:21:56 -0400
Received: from x4dbd508b.dyn.telefonica.de ([77.189.80.139] helo=martin-debian-1.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1hxpTa-0008Na-5F; Wed, 14 Aug 2019 11:21:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] iio: max5481: use devres for iio device registration
Date:   Wed, 14 Aug 2019 11:21:44 +0200
Message-Id: <20190814092144.10980-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace iio_device_register with the devres variant and drop the
explicit function call to unregister the iio device.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/iio/potentiometer/max5481.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index 732375b6d131..40b7212e68dc 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -162,7 +162,7 @@ static int max5481_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static int max5481_remove(struct spi_device *spi)
@@ -170,8 +170,6 @@ static int max5481_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
 	struct max5481_data *data = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	/* save wiper reg to NV reg */
 	return max5481_write_cmd(data, MAX5481_COPY_AB_TO_NV, 0);
 }
-- 
2.11.0

