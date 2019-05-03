Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5499F12FFD
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2019 16:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfECOWS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 10:22:18 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:40363 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728099AbfECOWS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 10:22:18 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hMYh1-000K4m-UA; Fri, 03 May 2019 15:57:39 +0200
Received: from [46.140.72.82] (helo=philippe-pc.toradex.int)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91 (FreeBSD))
        (envelope-from <dev@pschenker.ch>)
        id 1hMYh1-0003ks-Oj; Fri, 03 May 2019 15:57:39 +0200
X-Authenticated-Sender-Id: dev@pschenker.ch
From:   Philippe Schenker <dev@pschenker.ch>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     dev@pschenker.ch,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] iio: stmpe-adc: Enable all stmpe-adc interrupts just once
Date:   Fri,  3 May 2019 15:57:25 +0200
Message-Id: <20190503135725.9959-3-dev@pschenker.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503135725.9959-1-dev@pschenker.ch>
References: <20190503135725.9959-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This commit will enable the interrupts of all channels handled by this
driver only once in the probe function.

This will improve performance because one byte less has to be written over
i2c on each read out of the adc. On the fastest ADC mode this will improve
read out speed by 15%.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 drivers/iio/adc/stmpe-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index baa41ffc0d76..427c890c6e7d 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -72,9 +72,6 @@ static int stmpe_read_voltage(struct stmpe_adc *info,
 		return -EINVAL;
 	}
 
-	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
-			STMPE_ADC_CH(info->channel));
-
 	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
 			STMPE_ADC_CH(info->channel));
 
@@ -328,6 +325,9 @@ static int stmpe_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
+			~(norequest_mask & 0xFF));
+
 	return devm_iio_device_register(&pdev->dev, indio_dev);
 }
 
-- 
2.21.0

