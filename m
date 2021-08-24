Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D611D3F5A99
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhHXJNI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 05:13:08 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:46660 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhHXJNI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 05:13:08 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17O8rFHL098385;
        Tue, 24 Aug 2021 16:53:15 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 17:11:47 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [RESEND v4 06/15] iio: adc: aspeed: Add vref config function
Date:   Tue, 24 Aug 2021 17:12:34 +0800
Message-ID: <20210824091243.9393-7-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17O8rFHL098385
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the function to check the vref_fixed and set the value to driver
data.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index f03c7921d534..f260e40ab9b2 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -122,7 +122,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = data->model_data->vref_fixed;
+		*val = data->vref;
 		*val2 = ASPEED_RESOLUTION_BITS;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -187,6 +187,17 @@ static const struct iio_info aspeed_adc_iio_info = {
 	.debugfs_reg_access = aspeed_adc_reg_access,
 };
 
+static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
+{
+	struct aspeed_adc_data *data = iio_priv(indio_dev);
+
+	if (data->model_data->vref_fixed) {
+		data->vref = data->model_data->vref_fixed;
+		return 0;
+	}
+	return 0;
+}
+
 static int aspeed_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -242,6 +253,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	}
 	reset_control_deassert(data->rst);
 
+	ret = aspeed_adc_vref_config(indio_dev);
+	if (ret)
+		goto vref_config_error;
+
 	if (data->model_data->wait_init_sequence) {
 		/* Enable engine in normal mode. */
 		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
@@ -290,6 +305,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(data->clk_scaler->clk);
 clk_enable_error:
 poll_timeout_error:
+vref_config_error:
 	reset_control_assert(data->rst);
 reset_error:
 	clk_hw_unregister_divider(data->clk_scaler);
-- 
2.25.1

