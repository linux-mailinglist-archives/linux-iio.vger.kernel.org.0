Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B355B2A3
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiFZP3J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiFZP3H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 11:29:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EC9DF74
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 08:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E26A7B80D56
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 15:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6673C34114;
        Sun, 26 Jun 2022 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656257343;
        bh=T8Psk+ZrFWxix7ovyV2dpncjYjzPrV5uKwbHmWwXX0o=;
        h=From:To:Cc:Subject:Date:From;
        b=hyfgdeAFVEqFEZeBNPMgO+3G9qUMi4ceAlQm1V9WKH2sLbWLfbNK+0F4pcqCYgcHs
         a0M/LdH2dCy6j9GDEPBLLwXESF4Fw7/xTLlgg20odzrjzPAwCn0Fg8Mq6XMwKp+MvX
         DpPFA3UGEPYvwl7dorgxQK6pp/UPNiVpQ6tgu3h8YIafxrIBaXvORl665coFJ7KWwn
         MIb33pIecbS1eiAsafZa3KsD7YfTl7xP/Md3B79Jy2TJ45KkcziCxRiiZtRASQRng6
         +y6maZXliHk0bz1b0bIgdydaTIpbaqIYOere3Bq7gopW/9h6oKVwjMShoZQw/47+bB
         Z4Wb2t2F1ixWw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: adc: ti-ads124s08: Drop unused parameter to ads124s_read()
Date:   Sun, 26 Jun 2022 16:38:28 +0100
Message-Id: <20220626153828.589664-1-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The channel number is never used in this call, so don't pass it in.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads124s08.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 64833156c199..4ca62121f0d1 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -193,7 +193,7 @@ static int ads124s_reset(struct iio_dev *indio_dev)
 	return 0;
 };
 
-static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
+static int ads124s_read(struct iio_dev *indio_dev)
 {
 	struct ads124s_private *priv = iio_priv(indio_dev);
 	int ret;
@@ -242,7 +242,7 @@ static int ads124s_read_raw(struct iio_dev *indio_dev,
 			goto out;
 		}
 
-		ret = ads124s_read(indio_dev, chan->channel);
+		ret = ads124s_read(indio_dev);
 		if (ret < 0) {
 			dev_err(&priv->spi->dev, "Read ADC failed\n");
 			goto out;
@@ -290,7 +290,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		if (ret)
 			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
 
-		priv->buffer[j] = ads124s_read(indio_dev, scan_index);
+		priv->buffer[j] = ads124s_read(indio_dev);
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
 		if (ret)
 			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
-- 
2.36.1

