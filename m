Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341903A65B1
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhFNLl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236053AbhFNLhY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9949561105;
        Mon, 14 Jun 2021 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670416;
        bh=R0SIWw7QIlIp4dnMNNCvAJ6bdVhUe7SSvOvR7PWf4uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfIJi1K3Q1WhMoXI/3VpRqzguXyTzKzxxJuEwYQB/CM6hd0fiEwHHdU2O0jBe3slM
         gJwtE67vnIbPYhybLZBx7KFUJX9AClh6Ug9DI8ni5hG8itUyxhRKgNlSxnzi22I3Ca
         M4zaNJElkCC2KfQ6Cq15bhP4JaSJfzOxvgoH2e+NSgSqt3+p4uEOM5rDww4MEPPHKo
         SD+adyXMUPq1wJ8L38gA2UMSgPF/GIzdZaUxgYu1a/DtDeHygjrjgniG8RRnmx/lkO
         SxWbAlpJeCPK4Cp29koOHU3/3Nl3VST/e3UCQ/cyQWYrN9RwrQYlsTLIYED5YQqkqa
         Tg2Z5i45eWnCA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/17] staging:iio:adc:ad7280a: Standardize extended ABI naming
Date:   Mon, 14 Jun 2021 12:34:57 +0100
Message-Id: <20210614113507.897732-8-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The *_balance_switch_en and *_balance_switch_timer attributes had non
standard prefixes. Use the ext_info framework to automatically
create then with in_voltageX-voltageY_ prefix.

Documentation for these two unusual attributes to follow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 174 ++++++++----------------------
 1 file changed, 43 insertions(+), 131 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0aeca39388cf..032d6430bebf 100644
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
@@ -949,7 +866,6 @@ static const struct iio_info ad7280_info = {
 	.read_raw = ad7280_read_raw,
 	.read_event_value = &ad7280a_read_thresh,
 	.write_event_value = &ad7280a_write_thresh,
-	.attrs = &ad7280_attrs_group,
 };
 
 static const struct ad7280_platform_data ad7793_default_pdata = {
@@ -1030,10 +946,6 @@ static int ad7280_probe(struct spi_device *spi)
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
2.32.0

