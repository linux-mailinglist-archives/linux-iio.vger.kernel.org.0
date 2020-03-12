Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D72182F07
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 12:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgCLLYz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 07:24:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43836 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgCLLYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 07:24:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id u12so2927238pgb.10;
        Thu, 12 Mar 2020 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TVdjPXjgYVVs0p2Z6tBb5FOSTttzRchQzUjoJtWQWRM=;
        b=MphdJdnNMx+1BDTZNFR3cdACIScvyahRTcXQsVIoQemXXboc8NxGxRtQF/8z65qCc9
         QM6Upe+wPg4713lmQn+nVgmqILEhtoMRdsYyg1w3rhO/d/7lKKbIP8jIKKzxjuFz1knM
         TdOPkpSgR/scXaIWxMgOIo5p4BErLBbwVC8IuiZ2VzHOu6vweIaY+3R4UREMPAeGKiem
         EGHRNxVkENBH7O3KJ3RmtLXBwJhhD3ZI0VNaQ9N+ilHB2FgpJIyVTQmhrvf3VKNga88Q
         PlLT7MRHIN6rv5jcbyioIVM19eMA7+yHMHNYtv1hWFKs896SI4o0d8R4uSwEPnQPBz2f
         QZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TVdjPXjgYVVs0p2Z6tBb5FOSTttzRchQzUjoJtWQWRM=;
        b=QbOMQdK3Mohzvh1+VKhahiJphxw9XaxBaSWbTWPhIAKfc4rKAamo6VenWZ0LGsHbFh
         Y2Pq44x9Nw9ymkw5BfBiYzZ4ElEC+/sjFunBygLI8qqkkDXet/9rCRDPcPyFNQh2lGT/
         EhtbPTc2eIRH6JS/HYdAcEi6n+aQhLBRwFPGQZTTX+rF1lqPvB4e4S1Tsscakme5Oaox
         MYEQbPVvp6N7YPfa6PdSNleVhLzziVgqly6O3JfpeHyqtzJcn+nxBThk/DK1FQ9/uk/5
         B5WkdHXseCfGHB8cCDGpRIG4yvRc/lRqDgM0iTyedUAUfvqtTlh6Gt1TNqgG46e7W3SC
         eGog==
X-Gm-Message-State: ANhLgQ2kRWpMqeZc0wMEH+VjuFamBjUr1WCJ5VCEN6MZ/iFR+VUbe+Ed
        ddaOeXo/cUmDJrc6cp3GyrUavOY6
X-Google-Smtp-Source: ADFU+vvMv/B8DX6Ez+rWALDRgqg7tjO8ikCVWpiV+5DpCyosm2BPp/1Td62PM0qgH6w1G6ZvoMIcIQ==
X-Received: by 2002:a62:7dd7:: with SMTP id y206mr7854259pfc.79.1584012292285;
        Thu, 12 Mar 2020 04:24:52 -0700 (PDT)
Received: from syed ([106.210.44.120])
        by smtp.gmail.com with ESMTPSA id x9sm23744288pfa.188.2020.03.12.04.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:24:51 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:54:38 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] counter: 104-quad-8: Add lock guards - generic
 interface
Message-ID: <20200312112438.GA32462@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add lock protection from race conditions to 104-quad-8 counter
driver generic interface code changes. There is no IRQ handling so spin_lock calls
are used for protection.

Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface
support")

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>

Split the patch from filter clock prescaler and differential encoder
cable status changes. Also, include more code statements for protection
using spin_lock calls and remove protection from few code statements as
they were unnecessary.
---
 drivers/counter/104-quad-8.c | 174 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 149 insertions(+), 25 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9dab190..7d42303 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -44,6 +44,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  * @base:		base port address of the IIO device
  */
 struct quad8_iio {
+	spinlock_t lock;
 	struct counter_device counter;
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
@@ -123,6 +124,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 		/* Borrow XOR Carry effectively doubles count range */
 		*val = (borrow ^ carry) << 24;
 
+		spin_lock(&priv->lock);
+
 		/* Reset Byte Pointer; transfer Counter to Output Latch */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
 		     base_offset + 1);
@@ -130,6 +133,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 		for (i = 0; i < 3; i++)
 			*val |= (unsigned int)inb(base_offset) << (8 * i);
 
+		spin_unlock(&priv->lock);
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_ENABLE:
 		*val = priv->ab_enable[chan->channel];
@@ -160,6 +165,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		if ((unsigned int)val > 0xFFFFFF)
 			return -EINVAL;
 
+		spin_lock(&priv->lock);
+
 		/* Reset Byte Pointer */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
 
@@ -183,12 +190,16 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		/* Reset Error flag */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
 
+		spin_unlock(&priv->lock);
+
 		return 0;
 	case IIO_CHAN_INFO_ENABLE:
 		/* only boolean values accepted */
 		if (val < 0 || val > 1)
 			return -EINVAL;
 
+		spin_lock(&priv->lock);
+
 		priv->ab_enable[chan->channel] = val;
 
 		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
@@ -196,8 +207,12 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		/* Load I/O control configuration */
 		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
+		spin_unlock(&priv->lock);
+
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
+		spin_lock(&priv->lock);
+
 		/* Quadrature scaling only available in quadrature mode */
 		if (!priv->quadrature_mode[chan->channel] && (val2 || val != 1))
 			return -EINVAL;
@@ -219,6 +234,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		else
 			return -EINVAL;
 
+		spin_unlock(&priv->lock);
+
 		return 0;
 	}
 
@@ -255,6 +272,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
+	spin_lock(&priv->lock);
+
 	priv->preset[chan->channel] = preset;
 
 	/* Reset Byte Pointer */
@@ -264,6 +283,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	for (i = 0; i < 3; i++)
 		outb(preset >> (8 * i), base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -293,6 +314,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
+	spin_lock(&priv->lock);
+
 	priv->preset_enable[chan->channel] = preset_enable;
 
 	ior_cfg = priv->ab_enable[chan->channel] |
@@ -301,6 +324,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -358,6 +383,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	unsigned int mode_cfg = cnt_mode << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 
+	spin_lock(&priv->lock);
+
 	priv->count_mode[chan->channel] = cnt_mode;
 
 	/* Add quadrature mode configuration */
@@ -367,6 +394,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -394,9 +423,13 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int synchronous_mode)
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const unsigned int idr_cfg = synchronous_mode |
-		priv->index_polarity[chan->channel] << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
+	unsigned int idr_cfg;
+
+	spin_lock(&priv->lock);
+
+	idr_cfg = synchronous_mode |
+		priv->index_polarity[chan->channel] << 1;
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
@@ -407,6 +440,8 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -434,8 +469,12 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int quadrature_mode)
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
-	unsigned int mode_cfg = priv->count_mode[chan->channel] << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
+	unsigned int mode_cfg;
+
+	spin_lock(&priv->lock);
+
+	mode_cfg = priv->count_mode[chan->channel] << 1;
 
 	if (quadrature_mode)
 		mode_cfg |= (priv->quadrature_scale[chan->channel] + 1) << 3;
@@ -453,6 +492,8 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -480,15 +521,21 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int index_polarity)
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
-	const unsigned int idr_cfg = priv->synchronous_mode[chan->channel] |
-		index_polarity << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
+	unsigned int idr_cfg;
+
+	spin_lock(&priv->lock);
+
+	idr_cfg = priv->synchronous_mode[chan->channel] |
+		index_polarity << 1;
 
 	priv->index_polarity[chan->channel] = index_polarity;
 
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -603,6 +650,8 @@ static int quad8_count_read(struct counter_device *counter,
 	/* Borrow XOR Carry effectively doubles count range */
 	*val = (unsigned long)(borrow ^ carry) << 24;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	/* Reset Byte Pointer; transfer Counter to Output Latch */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_CNTR_OUT,
 	     base_offset + 1);
@@ -610,6 +659,8 @@ static int quad8_count_read(struct counter_device *counter,
 	for (i = 0; i < 3; i++)
 		*val |= (unsigned long)inb(base_offset) << (8 * i);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	return 0;
 }
 
@@ -624,6 +675,8 @@ static int quad8_count_write(struct counter_device *counter,
 	if (val > 0xFFFFFF)
 		return -EINVAL;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	/* Reset Byte Pointer */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
 
@@ -647,6 +700,8 @@ static int quad8_count_write(struct counter_device *counter,
 	/* Reset Error flag */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	return 0;
 }
 
@@ -669,11 +724,11 @@ static int quad8_function_get(struct counter_device *counter,
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const int id = count->id;
-	const unsigned int quadrature_mode = priv->quadrature_mode[id];
-	const unsigned int scale = priv->quadrature_scale[id];
 
-	if (quadrature_mode)
-		switch (scale) {
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
+	if (priv->quadrature_mode[id])
+		switch (priv->quadrature_scale[id]) {
 		case 0:
 			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
 			break;
@@ -687,6 +742,8 @@ static int quad8_function_get(struct counter_device *counter,
 	else
 		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	return 0;
 }
 
@@ -697,10 +754,15 @@ static int quad8_function_set(struct counter_device *counter,
 	const int id = count->id;
 	unsigned int *const quadrature_mode = priv->quadrature_mode + id;
 	unsigned int *const scale = priv->quadrature_scale + id;
-	unsigned int mode_cfg = priv->count_mode[id] << 1;
 	unsigned int *const synchronous_mode = priv->synchronous_mode + id;
-	const unsigned int idr_cfg = priv->index_polarity[id] << 1;
 	const int base_offset = priv->base + 2 * id + 1;
+	unsigned int mode_cfg;
+	unsigned int idr_cfg;
+
+	spin_lock(&priv->lock);
+
+	mode_cfg = priv->count_mode[id] << 1;
+	idr_cfg = priv->index_polarity[id] << 1;
 
 	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
 		*quadrature_mode = 0;
@@ -736,6 +798,8 @@ static int quad8_function_set(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -852,15 +916,21 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
-	const unsigned int idr_cfg = priv->synchronous_mode[channel_id] |
-		index_polarity << 1;
 	const int base_offset = priv->base + 2 * channel_id + 1;
+	unsigned int idr_cfg;
+
+	spin_lock(&priv->lock);
+
+	idr_cfg = priv->synchronous_mode[channel_id] |
+		index_polarity << 1;
 
 	priv->index_polarity[channel_id] = index_polarity;
 
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -887,9 +957,13 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
-	const unsigned int idr_cfg = synchronous_mode |
-		priv->index_polarity[channel_id] << 1;
 	const int base_offset = priv->base + 2 * channel_id + 1;
+	unsigned int idr_cfg;
+
+	spin_lock(&priv->lock);
+
+	idr_cfg = synchronous_mode |
+		priv->index_polarity[channel_id] << 1;
 
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[channel_id])
@@ -900,6 +974,8 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -964,6 +1040,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
 		break;
 	}
 
+	spin_lock(&priv->lock);
+
 	priv->count_mode[count->id] = cnt_mode;
 
 	/* Set count mode configuration value */
@@ -976,6 +1054,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -1017,6 +1097,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	if (err)
 		return err;
 
+	spin_lock(&priv->lock);
+
 	priv->ab_enable[count->id] = ab_enable;
 
 	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
@@ -1024,6 +1106,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1052,6 +1136,22 @@ static ssize_t quad8_count_preset_read(struct counter_device *counter,
 	return sprintf(buf, "%u\n", priv->preset[count->id]);
 }
 
+void quad8_preset_register_set(struct counter_device *counter,
+		const int base_offset, int id, unsigned int preset)
+{
+	struct quad8_iio *const priv = counter->priv;
+	int i;
+
+	priv->preset[id] = preset;
+
+	/* Reset Byte Pointer */
+	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
+
+	/* Set Preset Register */
+	for (i = 0; i < 3; i++)
+		outb(preset >> (8 * i), base_offset);
+}
+
 static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	struct counter_count *count, void *private, const char *buf, size_t len)
 {
@@ -1059,7 +1159,6 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	const int base_offset = priv->base + 2 * count->id;
 	unsigned int preset;
 	int ret;
-	int i;
 
 	ret = kstrtouint(buf, 0, &preset);
 	if (ret)
@@ -1069,14 +1168,11 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
-	priv->preset[count->id] = preset;
+	spin_lock(&priv->lock);
 
-	/* Reset Byte Pointer */
-	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
+	quad8_preset_register_set(counter, base_offset, count->id, preset);
 
-	/* Set Preset Register */
-	for (i = 0; i < 3; i++)
-		outb(preset >> (8 * i), base_offset);
+	spin_unlock(&priv->lock);
 
 	return len;
 }
@@ -1086,13 +1182,17 @@ static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
 {
 	const struct quad8_iio *const priv = counter->priv;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
 	case 1:
 	case 3:
-		return quad8_count_preset_read(counter, count, private, buf);
+		return sprintf(buf, "%u\n", priv->preset[count->id]);
 	}
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
 	return sprintf(buf, "33554431\n");
 }
@@ -1101,15 +1201,32 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	struct counter_count *count, void *private, const char *buf, size_t len)
 {
 	struct quad8_iio *const priv = counter->priv;
+	const int base_offset = priv->base + 2 * count->id;
+	unsigned int preset;
+	int ret;
+
+	spin_lock(&priv->lock);
 
 	/* Range Limit and Modulo-N count modes use preset value as ceiling */
 	switch (priv->count_mode[count->id]) {
 	case 1:
 	case 3:
-		return quad8_count_preset_write(counter, count, private, buf,
-						len);
+		ret = kstrtouint(buf, 0, &preset);
+		if (ret)
+			return ret;
+
+		/* Only 24-bit values are supported */
+		if (preset > 0xFFFFFF)
+			return -EINVAL;
+
+		quad8_preset_register_set(counter, base_offset,
+				count->id, preset);
+
+		return len;
 	}
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1137,6 +1254,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
+	spin_lock(&priv->lock);
+
 	priv->preset_enable[count->id] = preset_enable;
 
 	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
@@ -1144,6 +1263,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1429,6 +1550,9 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	quad8iio->counter.priv = quad8iio;
 	quad8iio->base = base[id];
 
+	/* Initialize spin lock */
+	spin_lock_init(&quad8iio->lock);
+
 	/* Reset all counters and disable interrupt function */
 	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 	/* Set initial configuration for all counters */
-- 
2.7.4

