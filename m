Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819F777038F
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHDOvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjHDOvY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 10:51:24 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B749D7
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 07:51:22 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 374DPfe8011410;
        Fri, 4 Aug 2023 10:51:19 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s8gfs64we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 10:51:18 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 374EpHFl005016
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 10:51:17 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Aug 2023 10:51:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Aug 2023 10:51:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Aug 2023 10:51:16 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 374Ep87i010508;
        Fri, 4 Aug 2023 10:51:14 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 2/3] iio: adc: ad9647: add based on converter framework
Date:   Fri, 4 Aug 2023 16:53:40 +0200
Message-ID: <20230804145342.1600136-3-nuno.sa@analog.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804145342.1600136-1-nuno.sa@analog.com>
References: <20230804145342.1600136-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: AKejXqI6B84n-NKpGIAio2G8Xk04iEOx
X-Proofpoint-GUID: AKejXqI6B84n-NKpGIAio2G8Xk04iEOx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308040133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467_new.c | 830 +++++++++++++++++++++++++++++++++++
 1 file changed, 830 insertions(+)
 create mode 100644 drivers/iio/adc/ad9467_new.c

diff --git a/drivers/iio/adc/ad9467_new.c b/drivers/iio/adc/ad9467_new.c
new file mode 100644
index 000000000000..ccdd3a893beb
--- /dev/null
+++ b/drivers/iio/adc/ad9467_new.c
@@ -0,0 +1,830 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD9467 SPI ADC driver
+ *
+ * Copyright 2012-2023 Analog Devices Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/addc/converter.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/iio.h>
+
+/*
+ * ADI High-Speed ADC common spi interface registers
+ * See Application-Note AN-877:
+ *   https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
+ */
+
+#define AN877_ADC_REG_CHIP_ID		0x01
+#define AN877_ADC_REG_CHAN_INDEX        0x05
+#define AN877_ADC_REG_TEST_IO		0x0D
+#define AN877_ADC_REG_OUTPUT_MODE	0x14
+#define AN877_ADC_REG_OUTPUT_PHASE	0x16
+#define AN877_ADC_REG_OUTPUT_DELAY	0x17
+#define AN877_ADC_REG_VREF		0x18
+#define AN877_ADC_REG_TRANSFER		0xFF
+
+/* AN877_ADC_REG_TRANSFER */
+#define AN877_ADC_TRANSFER_SYNC		0x1
+
+/* AN877_ADC_REG_OUTPUT_MODE */
+#define AN877_ADC_OUTPUT_MODE_OFFSET_BINARY	0x0
+#define AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT	0x1
+
+/* AN877_ADC_REG_OUTPUT_PHASE */
+#define AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN	0x20
+#define AN877_ADC_INVERT_DCO_CLK		0x80
+
+/* AN877_ADC_REG_TEST_IO */
+#define AN877_ADC_TESTMODE_OFF			0x0
+#define AN877_ADC_TESTMODE_PN23_SEQ             0x5
+#define AN877_ADC_TESTMODE_PN9_SEQ              0x6
+
+#define AD9647_MAX_TEST_POINTS		32
+/*
+ * Analog Devices AD9265 16-Bit, 125/105/80 MSPS ADC
+ */
+
+#define CHIPID_AD9265			0x64
+#define AD9265_DEF_OUTPUT_MODE		0x40
+#define AD9265_REG_VREF_MASK		0xC0
+
+/*
+ * Analog Devices AD9434 12-Bit, 370/500 MSPS ADC
+ */
+
+#define CHIPID_AD9434			0x6A
+#define AD9434_DEF_OUTPUT_MODE		0x00
+#define AD9434_REG_VREF_MASK		0xC0
+
+/*
+ * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
+ */
+
+#define CHIPID_AD9467			0x50
+#define AD9467_DEF_OUTPUT_MODE		0x08
+#define AD9467_REG_VREF_MASK		0x0F
+
+struct ad9467_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	const unsigned int (*scale_table)[2];
+	unsigned int id;
+	int num_scales;
+	unsigned long max_rate;
+	unsigned int default_output_mode;
+	unsigned int vref_mask;
+	unsigned int num_channels;
+	unsigned int num_lanes;
+	bool has_dco;
+};
+
+struct ad9467_state {
+	const struct ad9467_chip_info *info;
+	struct converter_backend *conv;
+	struct spi_device *spi;
+	struct clk *clk;
+	unsigned int output_mode;
+	unsigned long adc_clk;
+};
+
+/*
+ * Infer about moving to regmap (looks pretty straight)...
+ * Moreover we need to make this DMA safe
+ */
+static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
+{
+	unsigned char tbuf[2], rbuf[1];
+	int ret;
+
+	tbuf[0] = 0x80 | (reg >> 8);
+	tbuf[1] = reg & 0xFF;
+
+	ret = spi_write_then_read(spi,
+				  tbuf, ARRAY_SIZE(tbuf),
+				  rbuf, ARRAY_SIZE(rbuf));
+
+	if (ret < 0)
+		return ret;
+
+	return rbuf[0];
+}
+
+static int ad9467_spi_write(struct spi_device *spi, unsigned int reg,
+			    unsigned int val)
+{
+	unsigned char buf[3];
+
+	buf[0] = reg >> 8;
+	buf[1] = reg & 0xFF;
+	buf[2] = val;
+
+	return spi_write(spi, buf, ARRAY_SIZE(buf));
+}
+
+static void __ad9467_get_scale(struct ad9467_state *st, int index,
+			       unsigned int *val, unsigned int *val2)
+{
+	const struct iio_chan_spec *chan = &st->info->channels[0];
+	unsigned int tmp;
+
+	tmp = (st->info->scale_table[index][0] * 1000000ULL) >> chan->scan_type.realbits;
+	*val = tmp / 1000000;
+	*val2 = tmp % 1000000;
+}
+
+/* needs to check for ret codes */
+static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
+{
+	unsigned int i, vref_val;
+
+	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+
+	vref_val &= st->info->vref_mask;
+
+	for (i = 0; i < st->info->num_scales; i++) {
+		if (vref_val == st->info->scale_table[i][1])
+			break;
+	}
+
+	if (i == st->info->num_scales)
+		return -ERANGE;
+
+	__ad9467_get_scale(st, i, val, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+/* Needs mutex and check for ret codes */
+static int ad9467_set_scale(struct ad9467_state *st, int val, int val2)
+{
+	unsigned int scale_val[2];
+	unsigned int i;
+
+	if (val != 0)
+		return -EINVAL;
+
+	for (i = 0; i < st->info->num_scales; i++) {
+		__ad9467_get_scale(st, i, &scale_val[0], &scale_val[1]);
+		if (scale_val[0] != val || scale_val[1] != val2)
+			continue;
+
+		ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
+				 st->info->scale_table[i][1]);
+		ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+				 AN877_ADC_TRANSFER_SYNC);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ad9467_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad9467_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad9467_get_scale(st, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(st->clk);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9647_calibrate_prepare(const struct ad9467_state *st)
+{
+	int ret;
+
+	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TEST_IO,
+			       AN877_ADC_TESTMODE_PN9_SEQ);
+	if (ret)
+		return ret;
+
+	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+			       AN877_ADC_TRANSFER_SYNC);
+		if (ret)
+			return ret;
+
+	ret = converter_test_pattern_set(st->conv, 0, CONVERTER_ADI_PRBS_9A);
+	if (ret)
+		return ret;
+
+	return converter_chan_enable(st->conv, 0);
+}
+
+static int ad9647_calibrate_stop(const struct ad9467_state *st)
+{
+	int ret;
+
+	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TEST_IO,
+			       AN877_ADC_TESTMODE_OFF);
+	if (ret)
+		return ret;
+
+	ret = ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+			       AN877_ADC_TRANSFER_SYNC);
+	if (ret)
+		return ret;
+
+	return converter_chan_disable(st->conv, 0);
+}
+
+static int ad9467_calibrate_apply(const struct ad9467_state *st,
+				  unsigned int val)
+{
+	if (st->info->has_dco) {
+		int ret;
+
+		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_DELAY,
+				       val);
+		if (ret)
+			return ret;
+
+		return ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
+	}
+
+	return converter_iodelay_set(st->conv, st->info->num_lanes, val);
+}
+
+static int ad9467_calibrate_status_check(const struct ad9467_state *st)
+{
+	struct converter_chan_status status = {0};
+	int ret;
+
+	ret = converter_chan_status_get(st->conv, 0, &status);
+	if (ret)
+		return ret;
+
+	if (status.errors)
+		return 1;
+
+	return 0;
+}
+
+static void ad9467_dump_table(const unsigned char *err_field,
+			      unsigned int size, unsigned int val)
+{
+	unsigned int cnt;
+
+	for (cnt = 0; cnt < size; cnt++) {
+		if (cnt == val) {
+			pr_debug("|");
+			continue;
+		}
+
+		pr_debug("%c", err_field[cnt] ? '-' : 'o');
+		if (cnt == size / 2)
+			pr_debug("\n");
+	}
+}
+
+static int ad9467_find_optimal_point(const unsigned char *err_field,
+				     unsigned int size)
+{
+	unsigned int val, cnt = 0, max_cnt = 0, max_start = 0;
+	int start = -1;
+
+	for (val = 0; val < size; val++) {
+		if (!err_field[val]) {
+			if (start == -1)
+				start = val;
+			cnt++;
+		} else {
+			if (cnt > max_cnt) {
+				max_cnt = cnt;
+				max_start = start;
+			}
+
+			start = -1;
+			cnt = 0;
+		}
+	}
+
+	if (cnt > max_cnt) {
+		max_cnt = cnt;
+		max_start = start;
+	}
+
+	if (!max_cnt)
+		return -EIO;
+
+	val = max_start + max_cnt / 2;
+	ad9467_dump_table(err_field, size, val);
+
+	return val;
+}
+
+static int ad9467_do_calibrate(const struct ad9467_state *st)
+{
+	unsigned char err_field[AD9647_MAX_TEST_POINTS * 2] = {0};
+	unsigned int max_val = AD9647_MAX_TEST_POINTS, val;
+	bool inv_range = false;
+	int ret;
+
+	ret = ad9647_calibrate_prepare(st);
+	if (ret)
+		return ret;
+retune:
+	if (st->info->has_dco) {
+		unsigned int phase = AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN;
+
+		if (inv_range)
+			phase |= AN877_ADC_INVERT_DCO_CLK;
+
+		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_OUTPUT_PHASE,
+				       phase);
+		if (ret)
+			return ret;
+	} else {
+		if (inv_range)
+			ret = converter_sample_on_falling_edge(st->conv);
+		else
+			ret = converter_sample_on_rising_edge(st->conv);
+
+		if (ret)
+			return ret;
+	}
+
+	for (val = 0; val < max_val; val++) {
+		ret = ad9467_calibrate_apply(st, val);
+		if (ret)
+			return ret;
+
+		ret = ad9467_calibrate_status_check(st);
+		if (ret < 0)
+			return ret;
+
+		err_field[val + inv_range * max_val] = ret;
+	}
+
+	if (!inv_range) {
+		inv_range = true;
+		goto retune;
+	}
+
+	val = ad9467_find_optimal_point(err_field, sizeof(err_field));
+	if (val < 0)
+		return val;
+
+	if (val < max_val) {
+		if (st->info->has_dco)
+			ret = ad9467_spi_write(st->spi,
+					       AN877_ADC_REG_OUTPUT_PHASE,
+					       AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN);
+		else
+			ret = converter_sample_on_rising_edge(st->conv);
+	} else {
+		val -= max_val + 1;
+		/*
+		 * inv_range = true is the last test to run. Hence, there's no
+		 * need to re-do any configuration
+		 */
+		inv_range = false;
+	}
+
+	if (st->info->has_dco)
+		dev_dbg(&st->spi->dev,
+			" %s DCO 0x%X CLK %lu Hz\n", inv_range ? "INVERT" : "",
+			 val, st->adc_clk);
+	else
+		dev_dbg(&st->spi->dev,
+			" %s IDELAY 0x%x\n", inv_range ? "INVERT" : "", val);
+
+	ret = ad9647_calibrate_stop(st);
+	if (ret)
+		return ret;
+
+	/* finally apply the optimal value */
+	return ad9467_calibrate_apply(st, val);
+}
+
+static int ad9467_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ad9467_state *st = iio_priv(indio_dev);
+	long r_clk;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad9467_set_scale(st, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		r_clk = clk_round_rate(st->clk, val);
+		if (r_clk < 0 || r_clk > st->info->max_rate) {
+			dev_warn(&st->spi->dev,
+				 "Error setting ADC sample rate %ld", r_clk);
+			iio_device_release_direct_mode(indio_dev);
+			return -EINVAL;
+		}
+
+		if (st->adc_clk == r_clk) {
+			iio_device_release_direct_mode(indio_dev);
+			return 0;
+		}
+
+		ret = clk_set_rate(st->clk, r_clk);
+		if (ret) {
+			iio_device_release_direct_mode(indio_dev);
+			return ret;
+		}
+
+		st->adc_clk = r_clk;
+		ret = ad9467_do_calibrate(st);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9467_read_available(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 const int **vals, int *type, int *length,
+				 long mask)
+{
+	struct ad9467_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->info->scale_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = st->info->num_scales * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9467_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad9467_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			ret = converter_chan_enable(st->conv, c);
+		else
+			ret = converter_chan_disable(st->conv, c);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad9467_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct ad9467_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = st->spi;
+	int ret;
+
+	if (!readval) {
+		ret = ad9467_spi_write(spi, reg, writeval);
+		if (ret)
+			return ret;
+
+		return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+					AN877_ADC_TRANSFER_SYNC);
+	}
+
+	ret = ad9467_spi_read(spi, reg);
+	if (ret < 0)
+		return ret;
+
+	*readval = ret;
+
+	return 0;
+}
+
+/* missing available scales... */
+#define AD9467_CHAN(_chan, _si, _bits, _sign)				\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),	\
+	.scan_index = _si,						\
+	.scan_type = {							\
+		.sign = _sign,						\
+		.realbits = _bits,					\
+		.storagebits = 16,					\
+	},								\
+}
+
+static const struct iio_chan_spec ad9434_channels[] = {
+	AD9467_CHAN(0, 0, 12, 'S'),
+};
+
+static const struct iio_chan_spec ad9467_channels[] = {
+	AD9467_CHAN(0, 0, 16, 'S'),
+};
+
+static const unsigned int ad9265_scale_table[][2] = {
+	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
+};
+
+static const unsigned int ad9434_scale_table[][2] = {
+	{1600, 0x1C}, {1580, 0x1D}, {1550, 0x1E}, {1520, 0x1F}, {1500, 0x00},
+	{1470, 0x01}, {1440, 0x02}, {1420, 0x03}, {1390, 0x04}, {1360, 0x05},
+	{1340, 0x06}, {1310, 0x07}, {1280, 0x08}, {1260, 0x09}, {1230, 0x0A},
+	{1200, 0x0B}, {1180, 0x0C},
+};
+
+static const unsigned int ad9467_scale_table[][2] = {
+	{2000, 0}, {2100, 6}, {2200, 7},
+	{2300, 8}, {2400, 9}, {2500, 10},
+};
+
+static const struct ad9467_chip_info ad9467_chip_tbl = {
+	.name = "ad9467",
+	.id = CHIPID_AD9467,
+	.max_rate = 250000000UL,
+	.scale_table = ad9467_scale_table,
+	.num_scales = ARRAY_SIZE(ad9467_scale_table),
+	.channels = ad9467_channels,
+	.num_channels = ARRAY_SIZE(ad9467_channels),
+	.default_output_mode = AD9467_DEF_OUTPUT_MODE,
+	.vref_mask = AD9467_REG_VREF_MASK,
+	.num_lanes = 8,
+};
+
+static const struct ad9467_chip_info ad9265_chip_tbl = {
+	.name = "ad9265",
+	.id = CHIPID_AD9265,
+	.max_rate = 125000000UL,
+	.scale_table = ad9265_scale_table,
+	.num_scales = ARRAY_SIZE(ad9265_scale_table),
+	.channels = ad9467_channels,
+	.num_channels = ARRAY_SIZE(ad9467_channels),
+	.default_output_mode = AD9265_DEF_OUTPUT_MODE,
+	.vref_mask = AD9265_REG_VREF_MASK,
+	.has_dco = true,
+};
+
+static const struct ad9467_chip_info ad9434_chip_tbl = {
+	.name = "ad9434",
+	.id = CHIPID_AD9434,
+	.max_rate = 500000000UL,
+	.scale_table = ad9434_scale_table,
+	.num_scales = ARRAY_SIZE(ad9434_scale_table),
+	.channels = ad9434_channels,
+	.num_channels = ARRAY_SIZE(ad9434_channels),
+	.default_output_mode = AD9434_DEF_OUTPUT_MODE,
+	.vref_mask = AD9434_REG_VREF_MASK,
+	.num_lanes = 6,
+};
+
+static const struct iio_info ad9467_info = {
+	.read_raw = ad9467_read_raw,
+	.write_raw = ad9467_write_raw,
+	.update_scan_mode = ad9467_update_scan_mode,
+	.debugfs_reg_access = ad9467_reg_access,
+	.read_avail = ad9467_read_available,
+};
+
+static int ad9467_reset(struct device *dev)
+{
+	struct gpio_desc *gpio;
+
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+	if (!gpio)
+		return 0;
+
+	fsleep(1);
+	gpiod_set_value_cansleep(gpio, 0);
+	fsleep(10);
+
+	return 0;
+}
+
+/*
+ * Also candidate for a generic helper...
+ *
+ * This is something that I don't like much because, hardwarewise, the dma is
+ * connected to the backend device so it would make sense for the dma
+ * properties to be in the platform device rather than the frontend. However,
+ * detaching the IIO DMA buffer like that from the place where the IIO
+ * device is handled would feel equally odd and, while doable, it would
+ * require some hacking and new converter ops to make sure that resources
+ * lifetime feel right (so also export the non devm_ @iio_dmaengine_buffer_alloc()).
+ */
+static int ad9467_buffer_get(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	const char *dma_name;
+
+	if (!device_property_present(dev, "dmas"))
+		return 0;
+
+	if (device_property_read_string(dev, "dma-names", &dma_name))
+		dma_name = "rx";
+
+	return devm_iio_dmaengine_buffer_setup(dev, indio_dev, dma_name);
+}
+
+static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
+{
+	int ret;
+
+	ret = ad9467_spi_write(spi, AN877_ADC_REG_OUTPUT_MODE, mode);
+	if (ret < 0)
+		return ret;
+
+	return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+				AN877_ADC_TRANSFER_SYNC);
+}
+
+static int ad9467_channels_setup(const struct ad9467_state *st, bool test_mode)
+{
+	struct converter_data_fmt data;
+	unsigned int c, mode;
+	int ret;
+
+	if (test_mode) {
+		data.enable = false;
+		mode = st->info->default_output_mode;
+	} else {
+		mode = st->info->default_output_mode |
+				AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+		data.type = CONVERTER_TWOS_COMPLEMENT;
+		data.sign_extend = true;
+		data.enable = true;
+	}
+
+	ret = ad9467_outputmode_set(st->spi, mode);
+	if (ret)
+		return ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		ret = converter_data_format_set(st->conv, c, &data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad9467_calibrate(const struct ad9467_state *st)
+{
+	int ret;
+
+	ret = ad9467_channels_setup(st, true);
+	if (ret)
+		return ret;
+
+	ret = ad9467_do_calibrate(st);
+	if (ret)
+		return ret;
+
+	return ad9467_channels_setup(st, false);
+}
+
+static int ad9467_init(struct converter_frontend *frontend, struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct iio_dev *indio_dev;
+	struct ad9467_state *st;
+	unsigned int id;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -EINVAL;
+
+	st->conv = converter_get(frontend, NULL);
+	if (IS_ERR(st->conv))
+		return PTR_ERR(st->conv);
+
+	st->clk = devm_clk_get_enabled(dev, "adc-clk");
+	if (IS_ERR(st->clk))
+		return PTR_ERR(st->clk);
+
+	st->adc_clk = clk_get_rate(st->clk);
+
+	ret = ad9467_reset(dev);
+	if (ret)
+		return ret;
+
+	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
+	if (id != st->info->id) {
+		dev_err(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
+			id, st->info->id);
+		return -ENODEV;
+	}
+
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &ad9467_info;
+
+	ret = ad9467_buffer_get(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = converter_enable(st->conv);
+	if (ret)
+		return ret;
+
+	ret = ad9467_calibrate(st);
+	if (ret)
+		return ret;
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	converter_add_direct_reg_access(st->conv, indio_dev);
+
+	return 0;
+}
+
+static const struct frontend_ops ad9467_ops = {
+	.frontend_init = ad9467_init,
+};
+
+static int ad9467_probe(struct spi_device *spi)
+{
+	return converter_frontend_add(&spi->dev, &ad9467_ops);
+}
+
+/*
+ * It actually matters to remove the frontend in the .remove() hook. This means
+ * that all the converters (and the frontend) will be tear down before running
+ * any specific devres cleanup (at the driver core level). What this all means is
+ * that we can use devm_ apis in .frontend_init() and being sure those resources
+ * will be released after the backend resources and before any devm_* used
+ * in .probe().
+ */
+static void ad9467_remove(struct spi_device *spi)
+{
+	converter_del(&spi->dev);
+}
+
+static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
+	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
+	{ .compatible = "adi,ad9467-new", .data = &ad9467_chip_tbl, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad9467_of_match);
+
+static const struct spi_device_id ad9467_ids[] = {
+	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
+	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
+	{ "ad9467-new", (kernel_ulong_t)&ad9467_chip_tbl },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad9467_ids);
+
+static struct spi_driver ad9467_driver = {
+	.driver = {
+		.name = "ad9467",
+		.of_match_table = ad9467_of_match,
+	},
+	.probe = ad9467_probe,
+	.remove = ad9467_remove,
+	.id_table = ad9467_ids,
+};
+module_spi_driver(ad9467_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_CONVERTER);
-- 
2.41.0

