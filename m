Return-Path: <linux-iio+bounces-5674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FF8D812B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A3285897
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8A784DED;
	Mon,  3 Jun 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="V4iavTcX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD072C6A3;
	Mon,  3 Jun 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717414000; cv=none; b=XG0ZKMq0Uvk7ks3uQpn9nn2A71LJtyKpHWX33OoVzABFyVCykgFpjfTwfVJ30f1NV2rRARQl+KTfbd/BjHyh7b7RhYM/27zxdLeQvorhfGanlve8gYY0DtF4R8FUmlfeWVUjeiIH49aYUBpfP5a+1jSLNOkK2og5hNEen6awccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717414000; c=relaxed/simple;
	bh=VQB7M/OA32TOG7anFdQ1QQfQ6RazIjMaq/tQbvkcVhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4PSXQlPZYEhCs04C2goakshld0FO6RGHjHh1wAmEgmcLj/8IY45cYKlOtERwskpJ7pwGfDJadnoGZGu8rzhCmQHtxhnrJAgAIhIEm4syUNbRH1JCnnZ6sbpVZeFgp34Pizt4Bax/1FPy4RDgDxT1G0Q57D5gC09EgTEOS81UWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=V4iavTcX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4539gDHX016607;
	Mon, 3 Jun 2024 07:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Aa9kb
	dP9fL85Ix5VrQJgqDS84ulqTL71e3O6ufrBx9E=; b=V4iavTcXMChRXJfbt6PmN
	juwLoG6MgKuXFOLR3v3E3IvZ+30OrkS1YRjcjEVYdE9p5bLxVbHIlpyKpaa9EF1y
	beBR8hTsYCZBk1gQ+uVebBedQ8RPg+Gud744aX/1MSnuBTYmQ9p4dOi3BcThTmzd
	1j6LOEfvWeH3yYQ5s70xYuLVDgvc7duGlAxr9udt5nRbEmFfMBFwJ8Vgs/lL02Uv
	HDQe8U2ebDWwVkjjIfpbydrDRx7YoOTE8ghJeaXmsHk3G0kisOAfzkv+Ih0EzCly
	r7T3Qe7Hg0nrOhs+ltkxcRUuFFyQfISFYms4IAxzqkPjn8g1uWVDoWas/859NdVG
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yfwg266rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 07:26:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 453BQIU8020171
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 07:26:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 3 Jun 2024
 07:26:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Jun 2024 07:26:17 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.151])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 453BQ1V5004841;
	Mon, 3 Jun 2024 07:26:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] drivers: iio: frequency: adf4350: add clk provider
Date: Mon, 3 Jun 2024 14:24:44 +0300
Message-ID: <20240603112447.23308-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603112447.23308-1-antoniu.miclaus@analog.com>
References: <20240603112447.23308-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Y7TMVR6eGyDNkOP988m7T_eW1H5emTkA
X-Proofpoint-GUID: Y7TMVR6eGyDNkOP988m7T_eW1H5emTkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_07,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030095

Add clk provider feature for the adf4350.

Even though the driver was sent as an IIO driver in most cases the
device is actually seen as a clock provider.

This patch aims to cover actual usecases requested by users in order to
completely control the output frequencies from userspace.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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


