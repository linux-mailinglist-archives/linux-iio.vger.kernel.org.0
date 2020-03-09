Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5955117E2DC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCIO5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 10:57:05 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53966 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgCIO5B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 10:57:01 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so1706845pjb.3;
        Mon, 09 Mar 2020 07:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eSoHXBFfI6Cg9QiCIUgyPKSeCGlztcqxEYCuiDIBPbE=;
        b=N6Mcn37LKTk1HhxFGGXXUDDruw7EeFh1XlfWb30Sx+OtbN0kzFZIALAAAGyHqz0n1f
         UE77mE7x0M4N6GW8KyDPwsPnSTGUkCT8Dp7CU0E/Nbf0K2XYvC2yFizbhePWc63QqlFB
         ARD9tSaECBGTAs3tNJbJIIUYle0SHJojVKMMkX0Q0AC8A1SkHektoxNxCtzO6U2oixVN
         hQFb1K0qticdMoYrA3SaoxWTctJldiDg4EwS8Oz1vgefOF6R+p4pekCFPlkcBsPtxXXy
         MZhviUh9ishDiMv/Iss8dc3TPjRaxLWfx1RptSN3SYRSd0RuEDWTNXH6OluSSo2ab1PD
         HMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eSoHXBFfI6Cg9QiCIUgyPKSeCGlztcqxEYCuiDIBPbE=;
        b=q2fditB3P/EW46mkevy8OIwoX7R8lUbCw92ule9n/Lu30bd/YNVyGf4ek9KTpwLtc5
         5zbfJh0X6PsVtOSVF3DtuYAEUx4zpdfE9GUMMRwqDkCzYtoBmZrNfR4+/P12/U/CxzLw
         PX3T1YgMXE9LwjgvFWKriZdAhkjP3wfSskEbJvadGTC746SgybPtMDyG06J9fRt3n1Sk
         4HBE64iU2upYIz5jD+enUgu64mmdh5ft0y4dfhuKcJojvUfsxQVa9UJMuOa22Yf5AaF/
         9eo+N1pUY/2M7QCf9whcBTozPb7c18KeV2NtGXXqYiNTh8Wz3/2J1l0Gxnw0oW4Z70nd
         08+Q==
X-Gm-Message-State: ANhLgQ0wXhHq2BwfGvuiqRoqE4VoxeT8XRBUhmlF/1q8IkwAzyM/zlfm
        BOzlyaIonPbECSEofpMA9WA=
X-Google-Smtp-Source: ADFU+vvAIpBS70nLs9aiIMD6NUSZlvL8wKi8nQWOduNRjxYWMn9szeSfZ/f1c4EZX3Cqcnq+Y4hGKA==
X-Received: by 2002:a17:902:524:: with SMTP id 33mr16775682plf.241.1583765819701;
        Mon, 09 Mar 2020 07:56:59 -0700 (PDT)
Received: from syed.domain.name ([103.201.127.32])
        by smtp.gmail.com with ESMTPSA id h65sm22800393pfg.12.2020.03.09.07.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 07:56:59 -0700 (PDT)
Date:   Mon, 9 Mar 2020 20:26:53 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     vilhelm.gray@gmail.com
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] counter: 104-quad-8: Add lock protection
Message-ID: <20200309145653.GA3329@syed.domain.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add lock protection from race conditions in the 104-quad-8 counter
driver. There is no IRQ handling so spin_lock calls are used for
protection.

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
---
 drivers/counter/104-quad-8.c | 138 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 9dab190..431c754 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -45,6 +45,7 @@ MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
  */
 struct quad8_iio {
 	struct counter_device counter;
+	spinlock_t lock;
 	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
 	unsigned int preset[QUAD8_NUM_COUNTERS];
 	unsigned int count_mode[QUAD8_NUM_COUNTERS];
@@ -111,15 +112,24 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (chan->type == IIO_INDEX) {
+			spin_lock(&priv->lock);
 			*val = !!(inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
 				& BIT(chan->channel));
+			spin_unlock(&priv->lock);
 			return IIO_VAL_INT;
 		}
 
+		spin_lock(&priv->lock);
+
 		flags = inb(base_offset + 1);
+
+		spin_unlock(&priv->lock);
+
 		borrow = flags & QUAD8_FLAG_BT;
 		carry = !!(flags & QUAD8_FLAG_CT);
 
+		spin_lock(&priv->lock);
+
 		/* Borrow XOR Carry effectively doubles count range */
 		*val = (borrow ^ carry) << 24;
 
@@ -130,6 +140,8 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 		for (i = 0; i < 3; i++)
 			*val |= (unsigned int)inb(base_offset) << (8 * i);
 
+		spin_unlock(&priv->lock);
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_ENABLE:
 		*val = priv->ab_enable[chan->channel];
@@ -160,6 +172,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		if ((unsigned int)val > 0xFFFFFF)
 			return -EINVAL;
 
+		spin_lock(&priv->lock);
+
 		/* Reset Byte Pointer */
 		outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
 
@@ -183,12 +197,16 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
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
@@ -196,6 +214,8 @@ static int quad8_write_raw(struct iio_dev *indio_dev,
 		/* Load I/O control configuration */
 		outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
+		spin_unlock(&priv->lock);
+
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
 		/* Quadrature scaling only available in quadrature mode */
@@ -255,6 +275,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
+	spin_lock(&priv->lock);
+
 	priv->preset[chan->channel] = preset;
 
 	/* Reset Byte Pointer */
@@ -264,6 +286,8 @@ static ssize_t quad8_write_preset(struct iio_dev *indio_dev, uintptr_t private,
 	for (i = 0; i < 3; i++)
 		outb(preset >> (8 * i), base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -293,6 +317,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
+	spin_lock(&priv->lock);
+
 	priv->preset_enable[chan->channel] = preset_enable;
 
 	ior_cfg = priv->ab_enable[chan->channel] |
@@ -301,6 +327,8 @@ static ssize_t quad8_write_set_to_preset_on_index(struct iio_dev *indio_dev,
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -314,8 +342,15 @@ static int quad8_get_noise_error(struct iio_dev *indio_dev,
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel + 1;
+	int quad8_noise_error;
 
-	return !!(inb(base_offset) & QUAD8_FLAG_E);
+	spin_lock(&priv->lock);
+
+	quad8_noise_error = !!(inb(base_offset) & QUAD8_FLAG_E);
+
+	spin_unlock(&priv->lock);
+
+	return quad8_noise_error;
 }
 
 static const struct iio_enum quad8_noise_error_enum = {
@@ -334,8 +369,15 @@ static int quad8_get_count_direction(struct iio_dev *indio_dev,
 {
 	struct quad8_iio *const priv = iio_priv(indio_dev);
 	const int base_offset = priv->base + 2 * chan->channel + 1;
+	int quad8_count_direction;
+
+	spin_lock(&priv->lock);
 
-	return !!(inb(base_offset) & QUAD8_FLAG_UD);
+	quad8_count_direction = !!(inb(base_offset) & QUAD8_FLAG_UD);
+
+	spin_unlock(&priv->lock);
+
+	return quad8_count_direction;
 }
 
 static const struct iio_enum quad8_count_direction_enum = {
@@ -358,6 +400,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	unsigned int mode_cfg = cnt_mode << 1;
 	const int base_offset = priv->base + 2 * chan->channel + 1;
 
+	spin_lock(&priv->lock);
+
 	priv->count_mode[chan->channel] = cnt_mode;
 
 	/* Add quadrature mode configuration */
@@ -367,6 +411,8 @@ static int quad8_set_count_mode(struct iio_dev *indio_dev,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -402,11 +448,15 @@ static int quad8_set_synchronous_mode(struct iio_dev *indio_dev,
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
 
@@ -448,11 +498,15 @@ static int quad8_set_quadrature_mode(struct iio_dev *indio_dev,
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
 
@@ -484,11 +538,15 @@ static int quad8_set_index_polarity(struct iio_dev *indio_dev,
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
 
@@ -578,9 +636,13 @@ static int quad8_signal_read(struct counter_device *counter,
 	if (signal->id < 16)
 		return -EINVAL;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	state = inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
 		& BIT(signal->id - 16);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	*val = (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
 
 	return 0;
@@ -596,10 +658,17 @@ static int quad8_count_read(struct counter_device *counter,
 	unsigned int carry;
 	int i;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	flags = inb(base_offset + 1);
+
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	borrow = flags & QUAD8_FLAG_BT;
 	carry = !!(flags & QUAD8_FLAG_CT);
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	/* Borrow XOR Carry effectively doubles count range */
 	*val = (unsigned long)(borrow ^ carry) << 24;
 
@@ -610,6 +679,8 @@ static int quad8_count_read(struct counter_device *counter,
 	for (i = 0; i < 3; i++)
 		*val |= (unsigned long)inb(base_offset) << (8 * i);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	return 0;
 }
 
@@ -624,6 +695,8 @@ static int quad8_count_write(struct counter_device *counter,
 	if (val > 0xFFFFFF)
 		return -EINVAL;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	/* Reset Byte Pointer */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP, base_offset + 1);
 
@@ -647,6 +720,8 @@ static int quad8_count_write(struct counter_device *counter,
 	/* Reset Error flag */
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_E, base_offset + 1);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	return 0;
 }
 
@@ -711,8 +786,11 @@ static int quad8_function_set(struct counter_device *counter,
 		/* Synchronous function not supported in non-quadrature mode */
 		if (*synchronous_mode) {
 			*synchronous_mode = 0;
+			spin_lock(&priv->lock);
 			/* Disable synchronous function mode */
 			outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
+			spin_unlock(&priv->lock);
+
 		}
 	} else {
 		*quadrature_mode = 1;
@@ -733,9 +811,13 @@ static int quad8_function_set(struct counter_device *counter,
 		}
 	}
 
+	spin_lock(&priv->lock);
+
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -746,9 +828,13 @@ static void quad8_direction_get(struct counter_device *counter,
 	unsigned int ud_flag;
 	const unsigned int flag_addr = priv->base + 2 * count->id + 1;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	/* U/D flag: nonzero = up, zero = down */
 	ud_flag = inb(flag_addr) & QUAD8_FLAG_UD;
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
 }
@@ -856,11 +942,15 @@ static int quad8_index_polarity_set(struct counter_device *counter,
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
 
@@ -895,11 +985,15 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
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
 
@@ -964,6 +1058,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
 		break;
 	}
 
+	spin_lock(&priv->lock);
+
 	priv->count_mode[count->id] = cnt_mode;
 
 	/* Set count mode configuration value */
@@ -976,6 +1072,8 @@ static int quad8_count_mode_set(struct counter_device *counter,
 	/* Load mode configuration to Counter Mode Register */
 	outb(QUAD8_CTR_CMR | mode_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return 0;
 }
 
@@ -1017,6 +1115,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	if (err)
 		return err;
 
+	spin_lock(&priv->lock);
+
 	priv->ab_enable[count->id] = ab_enable;
 
 	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
@@ -1024,6 +1124,8 @@ static ssize_t quad8_count_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1033,8 +1135,12 @@ static int quad8_error_noise_get(struct counter_device *counter,
 	const struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id + 1;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	*noise_error = !!(inb(base_offset) & QUAD8_FLAG_E);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	return 0;
 }
 
@@ -1069,6 +1175,8 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	if (preset > 0xFFFFFF)
 		return -EINVAL;
 
+	spin_lock(&priv->lock);
+
 	priv->preset[count->id] = preset;
 
 	/* Reset Byte Pointer */
@@ -1078,6 +1186,8 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 	for (i = 0; i < 3; i++)
 		outb(preset >> (8 * i), base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1137,6 +1247,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
+	spin_lock(&priv->lock);
+
 	priv->preset_enable[count->id] = preset_enable;
 
 	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
@@ -1144,6 +1256,8 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1160,9 +1274,13 @@ static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
 	if (disabled)
 		return -EINVAL;
 
+	spin_lock(&((struct quad8_iio *)priv)->lock);
+
 	/* Logic 0 = cable fault */
 	status = inb(priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	spin_unlock(&((struct quad8_iio *)priv)->lock);
+
 	/* Mask respective channel and invert logic */
 	fault = !(status & BIT(channel_id));
 
@@ -1194,6 +1312,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 	if (ret)
 		return ret;
 
+	spin_lock(&priv->lock);
+
 	if (enable)
 		priv->cable_fault_enable |= BIT(channel_id);
 	else
@@ -1204,6 +1324,8 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 
 	outb(cable_fault_enable, priv->base + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1230,6 +1352,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
+	spin_lock(&priv->lock);
+
 	priv->fck_prescaler[channel_id] = prescaler;
 
 	/* Reset Byte Pointer */
@@ -1240,6 +1364,8 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 	outb(QUAD8_CTR_RLD | QUAD8_RLD_RESET_BP | QUAD8_RLD_PRESET_PSC,
 	     base_offset + 1);
 
+	spin_unlock(&priv->lock);
+
 	return len;
 }
 
@@ -1429,6 +1555,11 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	quad8iio->counter.priv = quad8iio;
 	quad8iio->base = base[id];
 
+	/* Initialize spin lock */
+	spin_lock_init(&quad8iio->lock);
+
+	spin_lock(&quad8iio->lock);
+
 	/* Reset all counters and disable interrupt function */
 	outb(QUAD8_CHAN_OP_RESET_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 	/* Set initial configuration for all counters */
@@ -1456,11 +1587,14 @@ static int quad8_probe(struct device *dev, unsigned int id)
 		/* Disable index function; negative index polarity */
 		outb(QUAD8_CTR_IDR, base_offset + 1);
 	}
+
 	/* Disable Differential Encoder Cable Status for all channels */
 	outb(0xFF, base[id] + QUAD8_DIFF_ENCODER_CABLE_STATUS);
 	/* Enable all counters */
 	outb(QUAD8_CHAN_OP_ENABLE_COUNTERS, base[id] + QUAD8_REG_CHAN_OP);
 
+	spin_unlock(&quad8iio->lock);
+
 	/* Register IIO device */
 	err = devm_iio_device_register(dev, indio_dev);
 	if (err)
-- 
2.7.4

