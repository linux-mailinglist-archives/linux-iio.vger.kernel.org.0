Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A14AB17A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbiBFS5h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343801AbiBFS5g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EDC06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECFAFB80E66
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A29C340F0;
        Sun,  6 Feb 2022 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173852;
        bh=OzrwC75C31Nz7OaSvEu7UbpeOE25MKSPAcNu1BeuFI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5iX7GOdb3rv4h/+K4EfTmmfA3kI7q0ojHabZcHDD1J3/xspsb4RJe5mJnPZdjy+Q
         lPtmKFbvA47bp4eEd2vB/NanrtWpn+fn4KJ1TeIWnvvqecADuIdjFoPz1tUYtB0CpI
         Y1vD8lcgoh7YfWoHRJKeuOg+G8rcW9C0hJLGjMaAaT+3Jc5o+E3uyZ0zLsmLJ/KE0n
         thWE0jOnpT6AO0vJHb10L56ftChgTACweLX7lO8KQpyXiKhIARF5wDz/AbQciVgFYY
         4PXBKxWFe2wmCMaC6dA5bDdZ/nDxCTGu9b0+kN3XrpZoa/ARemfEe4fw/bx3ZKBkE2
         MPVlNOSf0ZQ3w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 07/20] staging:iio:adc:ad7280a: Standardize extended ABI naming
Date:   Sun,  6 Feb 2022 19:03:15 +0000
Message-Id: <20220206190328.333093-8-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The *_balance_switch_en and *_balance_switch_timer attributes had non
standard prefixes. Use the ext_info framework to automatically
create then with in_voltageX-voltageY_ prefix.

Documentation for these two unusual attributes to follow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 174 ++++++++----------------------
 1 file changed, 43 insertions(+), 131 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 34b0f826ebee..29edbda64230 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -156,7 +156,6 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
 struct ad7280_state {
 	struct spi_device		*spi;
 	struct iio_chan_spec		*channels;
-	struct iio_dev_attr		*iio_attr;
 	int				slave_num;
 	int				scan_cnt;
 	int				readback_delay_us;
@@ -447,37 +446,33 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 	return ret;
 }
 
-static ssize_t ad7280_show_balance_sw(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
+static ssize_t ad7280_show_balance_sw(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan, char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7280_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	return sprintf(buf, "%d\n",
-		       !!(st->cb_mask[this_attr->address >> 8] &
-		       (1 << ((this_attr->address & 0xFF) + 2))));
+	return sysfs_emit(buf, "%d\n",
+			  !!(st->cb_mask[chan->address >> 8] &
+			  (1 << ((chan->address & 0xFF) + 2))));
 }
 
-static ssize_t ad7280_store_balance_sw(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t len)
+static ssize_t ad7280_store_balance_sw(struct iio_dev *indio_dev,
+				       uintptr_t private,
+				       const struct iio_chan_spec *chan,
+				       const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7280_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned int devaddr, ch;
 	bool readin;
 	int ret;
-	unsigned int devaddr, ch;
 
 	ret = strtobool(buf, &readin);
 	if (ret)
 		return ret;
 
-	devaddr = this_attr->address >> 8;
-	ch = this_attr->address & 0xFF;
+	devaddr = chan->address >> 8;
+	ch = chan->address & 0xFF;
 
 	mutex_lock(&st->lock);
 	if (readin)
@@ -492,19 +487,18 @@ static ssize_t ad7280_store_balance_sw(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t ad7280_show_balance_timer(struct device *dev,
-					 struct device_attribute *attr,
+static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
 					 char *buf)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7280_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
 	unsigned int msecs;
+	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad7280_read_reg(st, this_attr->address >> 8,
-			      this_attr->address & 0xFF);
+	ret = ad7280_read_reg(st, chan->address >> 8,
+			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
 	mutex_unlock(&st->lock);
 
 	if (ret < 0)
@@ -512,43 +506,50 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
 
 	msecs = FIELD_GET(AD7280A_CB_TIMER_VAL_MSK, ret) * 71500;
 
-	return sprintf(buf, "%u\n", msecs);
+	return sysfs_emit(buf, "%u.%u\n", msecs / 1000, msecs % 1000);
 }
 
-static ssize_t ad7280_store_balance_timer(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf,
-					  size_t len)
+static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  const char *buf, size_t len)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7280_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned long val;
+	int val, val2;
 	int ret;
 
-	ret = kstrtoul(buf, 10, &val);
+	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
 	if (ret)
 		return ret;
 
+	val = val * 1000 + val2;
 	val /= 71500;
 
 	if (val > 31)
 		return -EINVAL;
 
 	mutex_lock(&st->lock);
-	ret = ad7280_write(st, this_attr->address >> 8,
-			   this_attr->address & 0xFF, 0,
+	ret = ad7280_write(st, chan->address >> 8,
+			   (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG, 0,
 			   FIELD_PREP(AD7280A_CB_TIMER_VAL_MSK, val));
 	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
 
-static struct attribute *ad7280_attributes[AD7280A_MAX_CHAIN *
-					   AD7280A_CELLS_PER_DEV * 2 + 1];
-
-static const struct attribute_group ad7280_attrs_group = {
-	.attrs = ad7280_attributes,
+static const struct iio_chan_spec_ext_info ad7280_cell_ext_info[] = {
+	{
+		.name = "balance_switch_en",
+		.read = ad7280_show_balance_sw,
+		.write = ad7280_store_balance_sw,
+		.shared = IIO_SEPARATE,
+	}, {
+		.name = "balance_switch_timer",
+		.read = ad7280_show_balance_timer,
+		.write = ad7280_store_balance_timer,
+		.shared = IIO_SEPARATE,
+	},
+	{}
 };
 
 static const struct iio_event_spec ad7280_events[] = {
@@ -571,6 +572,7 @@ static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i)
 	chan->channel2 = chan->channel + 1;
 	chan->event_spec = ad7280_events;
 	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
+	chan->ext_info = ad7280_cell_ext_info;
 }
 
 static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i)
@@ -663,91 +665,6 @@ static int ad7280_channel_init(struct ad7280_state *st)
 	return cnt + 1;
 }
 
-static int ad7280_balance_switch_attr_init(struct iio_dev_attr *attr,
-					   struct device *dev, int addr, int i)
-{
-	attr->address = addr;
-	attr->dev_attr.attr.mode = 0644;
-	attr->dev_attr.show = ad7280_show_balance_sw;
-	attr->dev_attr.store = ad7280_store_balance_sw;
-	attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-						  "in%d-in%d_balance_switch_en",
-						  i, i + 1);
-	if (!attr->dev_attr.attr.name)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int ad7280_balance_timer_attr_init(struct iio_dev_attr *attr,
-					  struct device *dev, int addr, int i)
-{
-	attr->address = addr;
-	attr->dev_attr.attr.mode = 0644;
-	attr->dev_attr.show = ad7280_show_balance_timer;
-	attr->dev_attr.store = ad7280_store_balance_timer;
-	attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
-						  "in%d-in%d_balance_timer",
-						  i, i + 1);
-	if (!attr->dev_attr.attr.name)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static int ad7280_init_dev_attrs(struct ad7280_state *st, int dev, int *cnt)
-{
-	int addr, ch, i, ret;
-	struct iio_dev_attr *iio_attr;
-	struct device *sdev = &st->spi->dev;
-
-	for (ch = AD7280A_CELL_VOLTAGE_1_REG; ch <= AD7280A_CELL_VOLTAGE_6_REG; ch++) {
-		iio_attr = &st->iio_attr[*cnt];
-		addr = ad7280a_devaddr(dev) << 8 | ch;
-		i = dev * AD7280A_CELLS_PER_DEV + ch;
-
-		ret = ad7280_balance_switch_attr_init(iio_attr, sdev, addr, i);
-		if (ret < 0)
-			return ret;
-
-		ad7280_attributes[*cnt] = &iio_attr->dev_attr.attr;
-
-		(*cnt)++;
-		iio_attr = &st->iio_attr[*cnt];
-		addr = ad7280a_devaddr(dev) << 8 | (AD7280A_CB1_TIMER_REG + ch);
-
-		ret = ad7280_balance_timer_attr_init(iio_attr, sdev, addr, i);
-		if (ret < 0)
-			return ret;
-
-		ad7280_attributes[*cnt] = &iio_attr->dev_attr.attr;
-		(*cnt)++;
-	}
-
-	ad7280_attributes[*cnt] = NULL;
-
-	return 0;
-}
-
-static int ad7280_attr_init(struct ad7280_state *st)
-{
-	int dev, cnt = 0, ret;
-
-	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
-				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
-				    GFP_KERNEL);
-	if (!st->iio_attr)
-		return -ENOMEM;
-
-	for (dev = 0; dev <= st->slave_num; dev++) {
-		ret = ad7280_init_dev_attrs(st, dev, &cnt);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int ad7280a_read_thresh(struct iio_dev *indio_dev,
 			       const struct iio_chan_spec *chan,
 			       enum iio_event_type type,
@@ -964,7 +881,6 @@ static const struct iio_info ad7280_info = {
 	.read_raw = ad7280_read_raw,
 	.read_event_value = &ad7280a_read_thresh,
 	.write_event_value = &ad7280a_write_thresh,
-	.attrs = &ad7280_attrs_group,
 };
 
 static const struct ad7280_platform_data ad7793_default_pdata = {
@@ -1045,10 +961,6 @@ static int ad7280_probe(struct spi_device *spi)
 	indio_dev->channels = st->channels;
 	indio_dev->info = &ad7280_info;
 
-	ret = ad7280_attr_init(st);
-	if (ret < 0)
-		return ret;
-
 	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
-- 
2.35.1

