Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA3817D342
	for <lists+linux-iio@lfdr.de>; Sun,  8 Mar 2020 11:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgCHKlI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 06:41:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40343 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHKlI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2020 06:41:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so3366811pgj.7;
        Sun, 08 Mar 2020 03:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yq2nFAp4rJ/xlEM+BQvH6AUscZ3lCE2gJLlowUXj+b0=;
        b=pZM4Ruj+eg6RBwKJDATi5LUttF5mq5NMWYslV26+YmdYrnPq/AAwQbYaG7Z+FQ17dA
         7zEmijfu6HpN6dXOCgGeGBFn+iMt/1Vn/kky/mb2Ut59T3ExDKYbR4m3MbLlGkG1UTt0
         PK6q+9rQOmoJ1M4eIrhpaToA3RTNZCrg6EespFx5c8dKdIDaQBII0XkhfikCTKYSQ2iA
         kyj4i7LAMuR/20zZPNBd7HosEfTqjvw2d4zTKqt/lVWIhfIke4pP2aJRfpq7f7DZGEHK
         x5Sc+/RJisg/oz+8O2XgGSfmClzUI9F102CMGB5rYtfoaIOv8cRRQA16fQ8nk0dCUmFv
         /vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yq2nFAp4rJ/xlEM+BQvH6AUscZ3lCE2gJLlowUXj+b0=;
        b=IQo8rQ3aBnnr1bSxnP8Na5+pIhxlMB8/zBhN7/OZk7IrNtkLPJqXuFjJTCiEtw0bR0
         BmvnwTR12xMe4rIpBSEs79DK2WRkqkRhH9Sd665iq60409PUwSHjX94QFsQzW2PaJug+
         wblBHopvyvoKHmPFl7pzY/m0CSR1Pe6o5Fn0xVQsKEXHSlJ8kW/yitZ9hFukejyrIHGD
         4NpNBE8TVQ6ZdIIqhzvKoS6PfNDA6uf/ZiLg5f4w9kX9bdRBCiNQDBB5wyCREjSnkeGQ
         3h7PcrbEuQtjI/3y0eyI07IKSHEmyRDNDco+bGOfVI3BHOBEK6sN6Yq8/fGz3he1HI3M
         DA5w==
X-Gm-Message-State: ANhLgQ3hYGKRTYpfHufy6VLDsKlSYm2lfjXBl2bR5ioVSCXNzFGQSiX7
        0vjwQjRHWc6sVT3iqBDjB/O/8O31Nuk=
X-Google-Smtp-Source: ADFU+vsuLxhrIAEF8rb9zsQqttsntnkj669foWTZIbmaKHqBr0HiDQC8/ubq/o/oZuu9L4x/l3IdHA==
X-Received: by 2002:aa7:8426:: with SMTP id q6mr11871698pfn.221.1583664066561;
        Sun, 08 Mar 2020 03:41:06 -0700 (PDT)
Received: from syed.domain.name ([103.201.127.4])
        by smtp.gmail.com with ESMTPSA id e80sm2517740pfh.117.2020.03.08.03.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2020 03:41:06 -0700 (PDT)
Date:   Sun, 8 Mar 2020 16:11:01 +0530
From:   Syed Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Testing: counter: 104-quad-8.c: Added lock protection
Message-ID: <20200308104101.GA18548@syed.domain.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Added protection for quad8_iio configurations from race conditions in
the 104-quad-8 counter driver. There are no IRQs, used spin-locks for
protection.

Signed-off-by: Syed Waris <syednwaris@gmail.com>
---
 drivers/counter/104-quad-8.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 0cfc813..cd8e09f 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -43,6 +43,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  */
 struct quad8_iio {
 	struct counter_device counter;
+	spinlock_t lock;
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int count_mode[QUAD8_NUM_COUNTERS];
@@ -185,6 +186,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 || val > 1)
 			return -EINVAL;
 
+		spin_lock(&priv->lock);
+
 		priv->ab_enable[chan->channel] = val;
 
 		ior_cfg = val | priv->preset_enable[chan->channel] << 1;
@@ -192,6 +195,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		/* Load I/O control configuration */
 		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
+		spin_unlock(&priv->lock);
+
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
 		/* Quadrature scaling only available in quadrature mode */
@@ -251,6 +256,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
+	spin_lock(&priv->lock);
+
 	priv->preset[chan->channel] = preset;
 
 	/* Reset Byte Pointer */
@@ -260,6 +267,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	for (i = 0; i < 3; i++)
 		outb(preset >> (8 * i), base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -289,6 +298,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
+	spin_lock(&priv->lock);
+
 	priv->preset_enable[chan->channel] = preset_enable;
 
 	ior_cfg = priv->ab_enable[chan->channel] |
@@ -297,6 +308,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -354,6 +367,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	unsigned int mode_cfg = cnt_mode << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 
+	spin_lock(&priv->lock);
+
 	priv->count_mode[chan->channel] = cnt_mode;
 
 	/* Add quadrature mode configuration */
@@ -363,6 +378,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -398,11 +415,15 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
 	if (synchronous_mode && !priv->quadrature_mode[chan->channel])
 		return -EINVAL;
 
+	spin_lock(&priv->lock);
+
 	priv->synchronous_mode[chan->channel] = synchronous_mode;
 
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -444,11 +465,15 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
 			quad8_set_synchronous_mode(indio_dev, chan, 0);
 	}
 
+	spin_lock(&priv->lock);
+
 	priv->quadrature_mode[chan->channel] = quadrature_mode;
 
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -480,11 +505,15 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
 		index_polarity << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 
+	spin_lock(&priv->lock);
+
 	priv->index_polarity[chan->channel] = index_polarity;
 
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -852,11 +881,15 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 		index_polarity << 1;
 	const int base_offset = priv->base + 2 * channel_id + 1;
 
+	spin_lock(&priv->lock);
+
 	priv->index_polarity[channel_id] = index_polarity;
 
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -891,11 +924,15 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	if (synchronous_mode && !priv->quadrature_mode[channel_id])
 		return -EINVAL;
 
+	spin_lock(&priv->lock);
+
 	priv->synchronous_mode[channel_id] = synchronous_mode;
 
 	/* Load Index Control configuration to Index Control Register */
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -960,6 +997,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
 		break;
 	}
 
+	spin_lock(&priv->lock);
+
 	priv->count_mode[count->id] = cnt_mode;
 
 	/* Set count mode configuration value */
@@ -972,6 +1011,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -1013,6 +1054,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	if (err)
 		return err;
 
+	spin_lock(&priv->lock);
+
 	priv->ab_enable[count->id] = ab_enable;
 
 	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
@@ -1020,6 +1063,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1065,6 +1110,8 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
+	spin_lock(&priv->lock);
+
 	priv->preset[count->id] = preset;
 
 	/* Reset Byte Pointer */
@@ -1074,6 +1121,8 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	for (i = 0; i < 3; i++)
 		outb(preset >> (8 * i), base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1133,6 +1182,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
+	spin_lock(&priv->lock);
+
 	priv->preset_enable[count->id] = preset_enable;
 
 	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
@@ -1140,6 +1191,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1166,6 +1219,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
+	spin_lock(&priv->lock);
+
 	priv->fck_prescaler[channel_id] = prescaler;
 
 	/* Reset Byte Pointer */
@@ -1176,6 +1231,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
 	     base_offset + 1);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1383,6 +1440,10 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		/* Disable index function; negative index polarity */
 		outb(QUAD8_CTR_IDR, base_offset + 1);
 	}
+
+	/* Initialize the spin lock */
+	spin_lock_init(&quad8iio->lock);
+
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
-- 
2.7.4

