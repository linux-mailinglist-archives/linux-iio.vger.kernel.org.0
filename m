Return-Path: <linux-iio+bounces-5990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 061EA900090
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 12:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856C81F21B97
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A189F15B14A;
	Fri,  7 Jun 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TL0HCKCK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F813CABA;
	Fri,  7 Jun 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755636; cv=none; b=uy6Vr+s8TJxd2mYB+yVYovHpDgsNXRgXuIvF6cDsnww+zla7oOcT18TtjIu2R0KQ3e5Cs9jtkHZ65V9C0Po6VQZgZ7yiisDUA13fomw49OQNoyV3GVvnI99LOOqoHAN5OkYZEBEwzw+4yY+XlUM5fNerHO6+cat9NjPqkab0bHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755636; c=relaxed/simple;
	bh=GcdSvjnr3Om6YD+WI52Rb+C2uuA5tFLGfq8/rUwc8j8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rp8d9JxykPl4IqoyR1OwFdHltQs+ApYk4hYVBVSS5605EH6m+cXw05WSy660tyc14uABShbTTT3+SZw3uZ8SceQA+GEOaW2scJxniuh12V/dQ2/wabvxl8McWf2Ska+Ur/i8hPPrRA6A20qUlTR8R7BqQBu3pN3T23przj9ESys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TL0HCKCK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4579D48A017159;
	Fri, 7 Jun 2024 06:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EWRHH
	zCY/pMA342fbYyxcp7dKaDV7WpnUiBh5eVB9y0=; b=TL0HCKCKgk2yTz75jMx8R
	laxUPonSnBYTIakR45tv7pjd3dW6u13VR44MORSvZe0UaKaJvKo4BBQ9YLYSvWcb
	hLgGrR5z43kqe0CP9Dz0s6TnsZOY67LFQoFyJBfmHu5OSsHhptvCZvpDdTgt44tt
	LlEA9SGo7E1ZLXdHpTNZ84XCkfH2pEK27CadjWDOLjPKo/X2d+C8T/nSciczYT/b
	DW2DdmlTw6g8YKdw9KMvyUHmjxDRKzqIn1/opELOmnIfrP8+hBuKt7Qr+DFfU3oe
	TS99vYHvhN30QSF/rcNYA9UHB2HeRYyoBj/gMdBC0xZlm6kh7T9mdOq1J/lfytkI
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ykycjrds8-676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 06:20:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4579whjO021249
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 05:58:43 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Jun 2024 05:58:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Jun 2024 05:58:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Jun 2024 05:58:42 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4579wOa8031809;
	Fri, 7 Jun 2024 05:58:35 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/2] iio: frequency: adf4350: add clk provider
Date: Fri, 7 Jun 2024 12:57:53 +0300
Message-ID: <20240607095806.3299-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607095806.3299-1-antoniu.miclaus@analog.com>
References: <20240607095806.3299-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Q-SZsEn4Bf2xJmF7NzK0fw75a4yLRwGF
X-Proofpoint-ORIG-GUID: Q-SZsEn4Bf2xJmF7NzK0fw75a4yLRwGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_04,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070075

Add clk provider feature for the adf4350.

Even though the driver was sent as an IIO driver in most cases the
device is actually seen as a clock provider.

This patch aims to cover actual usecases requested by users in order to
completely control the output frequencies from userspace.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - rework commit title
 drivers/iio/frequency/adf4350.c | 129 ++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 4abf80f75ef5..1eb8bce71fe1 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -19,6 +19,7 @@
 #include <linux/gpio/consumer.h>
 #include <asm/div64.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -31,11 +32,21 @@ enum {
 	ADF4350_PWRDOWN,
 };
 
+struct adf4350_output {
+	struct clk_hw hw;
+	struct iio_dev *indio_dev;
+};
+
+#define to_output(_hw) container_of(_hw, struct adf4350_output, hw)
+
 struct adf4350_state {
 	struct spi_device		*spi;
 	struct gpio_desc		*lock_detect_gpiod;
 	struct adf4350_platform_data	*pdata;
 	struct clk			*clk;
+	struct clk			*clkout;
+	const char			*clk_out_name;
+	struct adf4350_output		output;
 	unsigned long			clkin;
 	unsigned long			chspc; /* Channel Spacing */
 	unsigned long			fpfd; /* Phase Frequency Detector */
@@ -264,6 +275,10 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
 	mutex_lock(&st->lock);
 	switch ((u32)private) {
 	case ADF4350_FREQ:
+		if (st->clkout) {
+			ret = clk_set_rate(st->clkout, readin);
+			break;
+		}
 		ret = adf4350_set_freq(st, readin);
 		break;
 	case ADF4350_FREQ_REFIN:
@@ -381,6 +396,115 @@ static const struct iio_info adf4350_info = {
 	.debugfs_reg_access = &adf4350_reg_access,
 };
 
+static void adf4350_clk_del_provider(void *data)
+{
+	struct adf4350_state *st = data;
+
+	of_clk_del_provider(st->spi->dev.of_node);
+}
+
+static unsigned long adf4350_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct iio_dev *indio_dev = to_output(hw)->indio_dev;
+	struct adf4350_state *st = iio_priv(indio_dev);
+	unsigned long long tmp;
+
+	tmp = (u64)(st->r0_int * st->r1_mod + st->r0_fract) * st->fpfd;
+	do_div(tmp, st->r1_mod * (1 << st->r4_rf_div_sel));
+
+	return tmp;
+}
+
+static int adf4350_clk_set_rate(struct clk_hw *hw,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct iio_dev *indio_dev = to_output(hw)->indio_dev;
+	struct adf4350_state *st = iio_priv(indio_dev);
+
+	if (parent_rate == 0 || parent_rate > ADF4350_MAX_FREQ_REFIN)
+		return -EINVAL;
+
+	st->clkin = parent_rate;
+
+	return adf4350_set_freq(st, rate);
+}
+
+static int adf4350_clk_prepare(struct clk_hw *hw)
+{
+	struct iio_dev *indio_dev = to_output(hw)->indio_dev;
+	struct adf4350_state *st = iio_priv(indio_dev);
+
+	st->regs[ADF4350_REG2] &= ~ADF4350_REG2_POWER_DOWN_EN;
+
+	return adf4350_sync_config(st);
+}
+
+static void adf4350_clk_unprepare(struct clk_hw *hw)
+{
+	struct iio_dev *indio_dev = to_output(hw)->indio_dev;
+	struct adf4350_state *st = iio_priv(indio_dev);
+
+	st->regs[ADF4350_REG2] |= ADF4350_REG2_POWER_DOWN_EN;
+
+	adf4350_sync_config(st);
+}
+
+static int adf4350_clk_is_enabled(struct clk_hw *hw)
+{
+	struct iio_dev *indio_dev = to_output(hw)->indio_dev;
+	struct adf4350_state *st = iio_priv(indio_dev);
+
+	return (st->regs[ADF4350_REG2] & ADF4350_REG2_POWER_DOWN_EN);
+}
+
+static const struct clk_ops adf4350_clk_ops = {
+	.recalc_rate = adf4350_clk_recalc_rate,
+	.set_rate = adf4350_clk_set_rate,
+	.prepare = adf4350_clk_prepare,
+	.unprepare = adf4350_clk_unprepare,
+	.is_enabled = adf4350_clk_is_enabled,
+};
+
+static int adf4350_clk_register(struct adf4350_state *st)
+{
+	struct spi_device *spi = st->spi;
+	struct clk_init_data init;
+	struct clk *clk;
+	const char *parent_name;
+	int ret;
+
+	if (!device_property_present(&spi->dev, "#clock-cells"))
+		return 0;
+
+	init.name = devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
+				   fwnode_get_name(dev_fwnode(&spi->dev)));
+	device_property_read_string(&spi->dev, "clock-output-names",
+				    &init.name);
+
+	parent_name = of_clk_get_parent_name(spi->dev.of_node, 0);
+	if (!parent_name)
+		return -EINVAL;
+
+	init.ops = &adf4350_clk_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	st->output.hw.init = &init;
+	clk = devm_clk_register(&spi->dev, &st->output.hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get, clk);
+	if (ret)
+		return ret;
+
+	st->clkout = clk;
+
+	return devm_add_action_or_reset(&spi->dev, adf4350_clk_del_provider, st);
+}
+
 static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 {
 	struct adf4350_platform_data *pdata;
@@ -524,6 +648,7 @@ static int adf4350_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &adf4350_chan;
 	indio_dev->num_channels = 1;
+	st->output.indio_dev = indio_dev;
 
 	mutex_init(&st->lock);
 
@@ -551,6 +676,10 @@ static int adf4350_probe(struct spi_device *spi)
 			return ret;
 	}
 
+	ret = adf4350_clk_register(st);
+	if (ret)
+		return ret;
+
 	ret = devm_add_action_or_reset(&spi->dev, adf4350_power_down, indio_dev);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret,
-- 
2.45.1


