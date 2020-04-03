Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1709119D791
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 15:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgDCN1Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 09:27:25 -0400
Received: from www381.your-server.de ([78.46.137.84]:34636 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCN1Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 09:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YGLAT1V3R5awmVZU2D7CZNoyaL0BdkYe3NWzEAyoBjA=; b=L0cZ1VU079bXNKjCmvKyWz8CJ7
        h4Ph9Px09ZXoPca26i2E5gd1ch7/fClSFbB7i25L7/TMSBcJ/pHmWyIJUeyGLZav+LEesflnB5rOx
        krra2rPtragIKYbwJqQR6aM0eIuRS1rQhHhAz66JXZYZ5CCCthg5rhRmnZeHBqhb1/yOntYJNr9Vc
        WiDbxnBuieujxdGyq81a0YXfYbbYkXA1fq3biwMi3g6MvlJiaU0OKgKn8j/vCXzmLGN8CFjwdQCDf
        sUYbLFtx0vH9QPjc5ceJu3ToA7PsJ94tYAs1HX0XC+SLO+NI4Qm4Vd3+fiVz0OAhgWsoIjCwe+BiU
        h7oIkeeQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLz-0004FN-5I; Fri, 03 Apr 2020 15:27:23 +0200
Received: from [82.135.69.229] (helo=lars-desktop.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jKMLy-000CaC-RV; Fri, 03 Apr 2020 15:27:22 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] iio: xilinx-xadc: Make sure not exceed maximum samplerate
Date:   Fri,  3 Apr 2020 15:27:16 +0200
Message-Id: <20200403132717.24682-4-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403132717.24682-1-lars@metafoo.de>
References: <20200403132717.24682-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25770/Thu Apr  2 14:58:54 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The XADC supports a samplerate of up to 1MSPS. Unfortunately the hardware
does not have a FIFO, which means it generates an interrupt for each
conversion sequence. At one 1MSPS this creates an interrupt storm that
causes the system to soft-lock.

For this reason the driver limits the maximum samplerate to 150kSPS.
Currently this check is only done when setting a new samplerate. But it is
also possible that the initial samplerate configured in the FPGA bitstream
exceeds the limit.

In this case when starting to capture data without first changing the
samplerate the system can overload.

To prevent this check the currently configured samplerate in the probe
function and reduce it to the maximum if necessary.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/xilinx-xadc-core.c | 78 +++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 4acababda4d5..c724b8788007 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -102,6 +102,16 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 
 #define XADC_FLAGS_BUFFERED BIT(0)
 
+/*
+ * The XADC hardware supports a samplerate of up to 1MSPS. Unfortunately it does
+ * not have a hardware FIFO. Which means an interrupt is generated for each
+ * conversion sequence. At 1MSPS sample rate the CPU in ZYNQ7000 is completely
+ * overloaded by the interrupts that it soft-lockups. For this reason the driver
+ * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
+ * but still responsive.
+ */
+#define XADC_MAX_SAMPLERATE 150000
+
 static void xadc_write_reg(struct xadc *xadc, unsigned int reg,
 	uint32_t val)
 {
@@ -834,11 +844,27 @@ static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 	.postdisable = &xadc_postdisable,
 };
 
+static int xadc_read_samplerate(struct xadc *xadc)
+{
+	unsigned int div;
+	uint16_t val16;
+	int ret;
+
+	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
+	if (ret)
+		return ret;
+
+	div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
+	if (div < 2)
+		div = 2;
+
+	return xadc_get_dclk_rate(xadc) / div / 26;
+}
+
 static int xadc_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long info)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	unsigned int div;
 	uint16_t val16;
 	int ret;
 
@@ -891,41 +917,31 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 		*val = -((273150 << 12) / 503975);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
-		if (ret)
+		ret = xadc_read_samplerate(xadc);
+		if (ret < 0)
 			return ret;
 
-		div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
-		if (div < 2)
-			div = 2;
-
-		*val = xadc_get_dclk_rate(xadc) / div / 26;
-
+		*val = ret;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
 }
 
-static int xadc_write_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int val, int val2, long info)
+static int xadc_write_samplerate(struct xadc *xadc, int val)
 {
-	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long clk_rate = xadc_get_dclk_rate(xadc);
 	unsigned int div;
 
 	if (!clk_rate)
 		return -EINVAL;
 
-	if (info != IIO_CHAN_INFO_SAMP_FREQ)
-		return -EINVAL;
-
 	if (val <= 0)
 		return -EINVAL;
 
 	/* Max. 150 kSPS */
-	if (val > 150000)
-		val = 150000;
+	if (val > XADC_MAX_SAMPLERATE)
+		val = XADC_MAX_SAMPLERATE;
 
 	val *= 26;
 
@@ -938,7 +954,7 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
 	 * limit.
 	 */
 	div = clk_rate / val;
-	if (clk_rate / div / 26 > 150000)
+	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE)
 		div++;
 	if (div < 2)
 		div = 2;
@@ -949,6 +965,17 @@ static int xadc_write_raw(struct iio_dev *indio_dev,
 		div << XADC_CONF2_DIV_OFFSET);
 }
 
+static int xadc_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long info)
+{
+	struct xadc *xadc = iio_priv(indio_dev);
+
+	if (info != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	return xadc_write_samplerate(xadc, val);
+}
+
 static const struct iio_event_spec xadc_temp_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -1234,6 +1261,21 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_samplerate_trigger;
 
+	/*
+	 * Make sure not to exceed the maximum samplerate since otherwise the
+	 * resulting interrupt storm will soft-lock the system.
+	 */
+	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
+		ret = xadc_read_samplerate(xadc);
+		if (ret < 0)
+			goto err_free_samplerate_trigger;
+		if (ret > XADC_MAX_SAMPLERATE) {
+			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
+			if (ret < 0)
+				goto err_free_samplerate_trigger;
+		}
+	}
+
 	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
 			dev_name(&pdev->dev), indio_dev);
 	if (ret)
-- 
2.20.1

