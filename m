Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA1366E20B
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 16:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjAQPZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 10:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjAQPZT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 10:25:19 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B442BFA
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673969092;
  x=1705505092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dHH9T+lTlvszF/h/7EbtIRUggJMtqeajLkeifWusHXo=;
  b=lPQk/cPKjW8eN4S1ph43OITQXiua7mTpEhODNmdT+LkNk0f4ix7OLJ6V
   aFj4KzVnUG3f5QOfbpb/tjOGEWqk94A9A7N7XvHKaJeYwCiv5ZrUFBWc6
   JKd9KG+0WstFksVU/RAjvaNWJUwhNPkrgJNWzLNEOdvA00spFoXIDDjo1
   GXd+XTwjJ0INm0+XcEc6BlVJ52RvIv80Di8uOzvMdHNO/3BkGFvWo9vMN
   rhQGS1oh87nBDNiHB+ErfmeqFHyYfL0evZ3EhmOasLv1I3FnsRG0VhtSH
   v4rP9OF3L9T1nlSWiW7zE3yWiiAZWwAdMWSxXFgka+TBVy/x02EBEwIsT
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v4 1/3] iio: light: vcnl4000: Prepare for more generic setup
Date:   Tue, 17 Jan 2023 16:24:33 +0100
Message-ID: <20230117152435.3510319-2-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117152435.3510319-1-marten.lindahl@axis.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In order to allow the chip_spec array reference the function pointers
for interrupts, the code for these functions need to be moved above the
chip_spec array.

This is a prestep to support a more generic setup of interrupts.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 256 +++++++++++++++++------------------
 1 file changed, 128 insertions(+), 128 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cc1a2062e76d..11b54b57e592 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -887,6 +887,134 @@ static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
 	return sprintf(buf, "%u\n", data->near_level);
 }
 
+static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	unsigned long isr;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
+	if (ret < 0)
+		goto end;
+
+	isr = ret;
+
+	if (isr & VCNL4010_INT_THR) {
+		if (test_bit(VCNL4010_INT_THR_LOW, &isr)) {
+			iio_push_event(indio_dev,
+				       IIO_UNMOD_EVENT_CODE(
+					       IIO_PROXIMITY,
+					       1,
+					       IIO_EV_TYPE_THRESH,
+					       IIO_EV_DIR_FALLING),
+				       iio_get_time_ns(indio_dev));
+		}
+
+		if (test_bit(VCNL4010_INT_THR_HIGH, &isr)) {
+			iio_push_event(indio_dev,
+				       IIO_UNMOD_EVENT_CODE(
+					       IIO_PROXIMITY,
+					       1,
+					       IIO_EV_TYPE_THRESH,
+					       IIO_EV_DIR_RISING),
+				       iio_get_time_ns(indio_dev));
+		}
+
+		i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
+					  isr & VCNL4010_INT_THR);
+	}
+
+	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
+		iio_trigger_poll_chained(indio_dev->trig);
+
+end:
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
+	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */
+	bool data_read = false;
+	unsigned long isr;
+	int val = 0;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
+	if (ret < 0)
+		goto end;
+
+	isr = ret;
+
+	if (test_bit(0, active_scan_mask)) {
+		if (test_bit(VCNL4010_INT_PROXIMITY, &isr)) {
+			ret = vcnl4000_read_data(data,
+						 VCNL4000_PS_RESULT_HI,
+						 &val);
+			if (ret < 0)
+				goto end;
+
+			buffer[0] = val;
+			data_read = true;
+		}
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
+					isr & VCNL4010_INT_DRDY);
+	if (ret < 0)
+		goto end;
+
+	if (!data_read)
+		goto end;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+					   iio_get_time_ns(indio_dev));
+
+end:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
+	int cmd;
+
+	/* Do not enable the buffer if we are already capturing events. */
+	if (vcnl4010_is_in_periodic_mode(data))
+		return -EBUSY;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
+					VCNL4010_INT_PROX_EN);
+	if (ret < 0)
+		return ret;
+
+	cmd = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
+	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, cmd);
+}
+
+static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
+}
+
+static const struct iio_buffer_setup_ops vcnl4010_buffer_ops = {
+	.postenable = &vcnl4010_buffer_postenable,
+	.predisable = &vcnl4010_buffer_predisable,
+};
+
 static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
 	{
 		.name = "nearlevel",
@@ -1030,134 +1158,6 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	},
 };
 
-static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
-{
-	struct iio_dev *indio_dev = p;
-	struct vcnl4000_data *data = iio_priv(indio_dev);
-	unsigned long isr;
-	int ret;
-
-	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
-	if (ret < 0)
-		goto end;
-
-	isr = ret;
-
-	if (isr & VCNL4010_INT_THR) {
-		if (test_bit(VCNL4010_INT_THR_LOW, &isr)) {
-			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(
-					       IIO_PROXIMITY,
-					       1,
-					       IIO_EV_TYPE_THRESH,
-					       IIO_EV_DIR_FALLING),
-				       iio_get_time_ns(indio_dev));
-		}
-
-		if (test_bit(VCNL4010_INT_THR_HIGH, &isr)) {
-			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(
-					       IIO_PROXIMITY,
-					       1,
-					       IIO_EV_TYPE_THRESH,
-					       IIO_EV_DIR_RISING),
-				       iio_get_time_ns(indio_dev));
-		}
-
-		i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
-					  isr & VCNL4010_INT_THR);
-	}
-
-	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
-		iio_trigger_poll_chained(indio_dev->trig);
-
-end:
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct vcnl4000_data *data = iio_priv(indio_dev);
-	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
-	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */
-	bool data_read = false;
-	unsigned long isr;
-	int val = 0;
-	int ret;
-
-	ret = i2c_smbus_read_byte_data(data->client, VCNL4010_ISR);
-	if (ret < 0)
-		goto end;
-
-	isr = ret;
-
-	if (test_bit(0, active_scan_mask)) {
-		if (test_bit(VCNL4010_INT_PROXIMITY, &isr)) {
-			ret = vcnl4000_read_data(data,
-						 VCNL4000_PS_RESULT_HI,
-						 &val);
-			if (ret < 0)
-				goto end;
-
-			buffer[0] = val;
-			data_read = true;
-		}
-	}
-
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_ISR,
-					isr & VCNL4010_INT_DRDY);
-	if (ret < 0)
-		goto end;
-
-	if (!data_read)
-		goto end;
-
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-					   iio_get_time_ns(indio_dev));
-
-end:
-	iio_trigger_notify_done(indio_dev->trig);
-	return IRQ_HANDLED;
-}
-
-static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
-{
-	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret;
-	int cmd;
-
-	/* Do not enable the buffer if we are already capturing events. */
-	if (vcnl4010_is_in_periodic_mode(data))
-		return -EBUSY;
-
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
-					VCNL4010_INT_PROX_EN);
-	if (ret < 0)
-		return ret;
-
-	cmd = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
-	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, cmd);
-}
-
-static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
-{
-	struct vcnl4000_data *data = iio_priv(indio_dev);
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
-	if (ret < 0)
-		return ret;
-
-	return i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
-}
-
-static const struct iio_buffer_setup_ops vcnl4010_buffer_ops = {
-	.postenable = &vcnl4010_buffer_postenable,
-	.predisable = &vcnl4010_buffer_predisable,
-};
-
 static const struct iio_trigger_ops vcnl4010_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
-- 
2.30.2

