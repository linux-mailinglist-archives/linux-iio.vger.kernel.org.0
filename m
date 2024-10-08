Return-Path: <linux-iio+bounces-10340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4E09953B1
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D50DB2502B
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DB81E132F;
	Tue,  8 Oct 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Rg1gmGAa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DB1E104F
	for <linux-iio@vger.kernel.org>; Tue,  8 Oct 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402328; cv=none; b=OesWd62RnwrzEIpRIqfzM++9lEEK9KLSyjKiE4oX3ypYlfFTuz3HGpBkmAxSGM9zcGrBeWiMDsFN13tV41s6J27AFaoRJDK+1PWACzSJBT6LNjtRwL6KFl9PF+GbLFurx4hhng9C3qmym8Lx4pTjZWSIBo3A4ABCRETypvabXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402328; c=relaxed/simple;
	bh=iIDwGqolTd1HpLnj9SN11+oq2F3sidqm8mJBhcm2C6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2Vxig3VxKI2eDgquePm/8YEl7m/4F8jQqYKXDbvCxdFFYecFVkOif7z/I/OCctXEokbMnHGNECBLyQWTg5uep7L3k76t7gr56/Em9AX3OHaYCcRvsb2YtzQzDJN4cxBP83RlSup4MU19mnlF53LUapXclIhGF4ajBR/wBN/y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Rg1gmGAa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb2191107so52167935e9.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2024 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728402325; x=1729007125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG7iKoFeabciCOG8LbA5wLcP1lXi7bRJI0HkySWmPCU=;
        b=Rg1gmGAaVQ/R60BsjTiWmDVIvEy58MiN4A5J+quIoV6mwdfEvolhZMSDt7DoyE4+Rg
         Rft4QaPoE2uatM5Gp29Y3bz3z4LiDjiwMe2IUaWHgAkD4x49LDX7+zDso/Ok/9uPQWf2
         PAYQ7SdA3LfRWepspt0jKfZ21lSW1vZYs3vhqVXPIC6o5fhbdKxsF7UtfD0bc+cmXl9+
         sZbg0ZOEBTAB7Y5JZACuSg0OBtBAYRIhIU/qmaRQcJ11w4HrO8uCxm7w0n0JxK2N/RC/
         FvIY1fLCbnhxRiJnFJHaH0eqPwGfLZuRPD3tFczbGYXi0xFXgFpexqTE4NRrcJ6Kmtry
         6LCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402325; x=1729007125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JG7iKoFeabciCOG8LbA5wLcP1lXi7bRJI0HkySWmPCU=;
        b=p91xyocvszbXtv1Edv+WGr+KOGw6fe9SCCibby79uys74tpCbA5rC4xFLc/2hEuBGt
         iWFtN27fYUc86aYM+UjiUIusOVPQWh38dCaII8DuU+2ywhvr1d1q0wvCRtttIIDZmGSb
         1OebwZkSVeZXQOsac4X/RG6YtK+iNMd+Xw+SR15R5XfeDHnFPoiSKzTmwdXCu/6wG+1Y
         istI42cmb286uqzNvM56D9h8bPYkG9FIuA55KtftNbIY6PF0lN6SnbtnuiX2rdBeJa/z
         gX0bRu7dxlXfb1YCMvlu/QmaNz38st14Cp+19kW+LdvcaiYk6NgjDL3b+zoXjCA9F1dI
         OMLA==
X-Forwarded-Encrypted: i=1; AJvYcCVl3b2uaP5L8dX1NgYMDkTFbJVINzexiNL5jQ75RgHOAEkGPvlqF9whOT4ZXLZ/XZWXlNehmCcOBuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqZ2UlRVs08ohZ8eXXV/QmuiD9U2OtdZt2cKsd89yvtioe2Ni
	HBF4/Ugs/VEYfo/851Gg/6u1JQPali1h2UxvxzSaTQcFrcVttAGAsm7aMDdxL4s=
X-Google-Smtp-Source: AGHT+IFBq3qkcocY6U7WDcC6TJgK5ci2qJeccL5YGvUFDj8BD9aYlAdbkIT7htn64+DozgA+3wPTyQ==
X-Received: by 2002:a05:600c:3c94:b0:428:ec2a:8c94 with SMTP id 5b1f17b1804b1-42f85ab8972mr126056515e9.10.1728402324414;
        Tue, 08 Oct 2024 08:45:24 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d826sm129591215e9.26.2024.10.08.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:45:19 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Oct 2024 17:43:39 +0200
Subject: [PATCH v5 07/10] iio: dac: ad3552r: changes to use FIELD_PREP
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-7-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dletchner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Changes to use FIELD_PREP, so that driver-specific ad3552r_field_prep
is removed. Variables (arrays) that was used to call ad3552r_field_prep
are removed too.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r.c | 166 ++++++++++++++--------------------------------
 1 file changed, 49 insertions(+), 117 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index bd37d304ca70..c27706c5ba10 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -210,46 +210,6 @@ static const s32 gains_scaling_table[] = {
 	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
 };
 
-enum ad3552r_dev_attributes {
-	/* - Direct register values */
-	/* From 0-3 */
-	AD3552R_SDO_DRIVE_STRENGTH,
-	/*
-	 * 0 -> Internal Vref, vref_io pin floating (default)
-	 * 1 -> Internal Vref, vref_io driven by internal vref
-	 * 2 or 3 -> External Vref
-	 */
-	AD3552R_VREF_SELECT,
-	/* Read registers in ascending order if set. Else descending */
-	AD3552R_ADDR_ASCENSION,
-};
-
-enum ad3552r_ch_attributes {
-	/* DAC powerdown */
-	AD3552R_CH_DAC_POWERDOWN,
-	/* DAC amplifier powerdown */
-	AD3552R_CH_AMPLIFIER_POWERDOWN,
-	/* Select the output range. Select from enum ad3552r_ch_output_range */
-	AD3552R_CH_OUTPUT_RANGE_SEL,
-	/*
-	 * Over-rider the range selector in order to manually set the output
-	 * voltage range
-	 */
-	AD3552R_CH_RANGE_OVERRIDE,
-	/* Manually set the offset voltage */
-	AD3552R_CH_GAIN_OFFSET,
-	/* Sets the polarity of the offset. */
-	AD3552R_CH_GAIN_OFFSET_POLARITY,
-	/* PDAC gain scaling */
-	AD3552R_CH_GAIN_SCALING_P,
-	/* NDAC gain scaling */
-	AD3552R_CH_GAIN_SCALING_N,
-	/* Rfb value */
-	AD3552R_CH_RFB,
-	/* Channel select. When set allow Input -> DAC and Mask -> DAC */
-	AD3552R_CH_SELECT,
-};
-
 struct ad3552r_ch_data {
 	s32	scale_int;
 	s32	scale_dec;
@@ -285,45 +245,6 @@ struct ad3552r_desc {
 	unsigned int		num_ch;
 };
 
-static const u16 addr_mask_map[][2] = {
-	[AD3552R_ADDR_ASCENSION] = {
-			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
-			AD3552R_MASK_ADDR_ASCENSION
-	},
-	[AD3552R_SDO_DRIVE_STRENGTH] = {
-			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-			AD3552R_MASK_SDO_DRIVE_STRENGTH
-	},
-	[AD3552R_VREF_SELECT] = {
-			AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
-			AD3552R_MASK_REFERENCE_VOLTAGE_SEL
-	},
-};
-
-/* 0 -> reg addr, 1->ch0 mask, 2->ch1 mask */
-static const u16 addr_mask_map_ch[][3] = {
-	[AD3552R_CH_DAC_POWERDOWN] = {
-			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
-			AD3552R_MASK_CH_DAC_POWERDOWN(0),
-			AD3552R_MASK_CH_DAC_POWERDOWN(1)
-	},
-	[AD3552R_CH_AMPLIFIER_POWERDOWN] = {
-			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
-			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0),
-			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1)
-	},
-	[AD3552R_CH_OUTPUT_RANGE_SEL] = {
-			AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
-			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0),
-			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1)
-	},
-	[AD3552R_CH_SELECT] = {
-			AD3552R_REG_ADDR_CH_SELECT_16B,
-			AD3552R_MASK_CH(0),
-			AD3552R_MASK_CH(1)
-	}
-};
-
 static u8 _ad3552r_reg_len(u8 addr)
 {
 	switch (addr) {
@@ -399,11 +320,6 @@ static int ad3552r_read_reg(struct ad3552r_desc *dac, u8 addr, u16 *val)
 	return 0;
 }
 
-static u16 ad3552r_field_prep(u16 val, u16 mask)
-{
-	return (val << __ffs(mask)) & mask;
-}
-
 /* Update field of a register, shift val if needed */
 static int ad3552r_update_reg_field(struct ad3552r_desc *dac, u8 addr, u16 mask,
 				    u16 val)
@@ -416,21 +332,11 @@ static int ad3552r_update_reg_field(struct ad3552r_desc *dac, u8 addr, u16 mask,
 		return ret;
 
 	reg &= ~mask;
-	reg |= ad3552r_field_prep(val, mask);
+	reg |= val;
 
 	return ad3552r_write_reg(dac, addr, reg);
 }
 
-static int ad3552r_set_ch_value(struct ad3552r_desc *dac,
-				enum ad3552r_ch_attributes attr,
-				u8 ch,
-				u16 val)
-{
-	/* Update register related to attributes in chip */
-	return ad3552r_update_reg_field(dac, addr_mask_map_ch[attr][0],
-				       addr_mask_map_ch[attr][ch + 1], val);
-}
-
 #define AD3552R_CH_DAC(_idx) ((struct iio_chan_spec) {		\
 	.type = IIO_VOLTAGE,					\
 	.output = true,						\
@@ -510,8 +416,14 @@ static int ad3552r_write_raw(struct iio_dev *indio_dev,
 					val);
 		break;
 	case IIO_CHAN_INFO_ENABLE:
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_DAC_POWERDOWN,
-					   chan->channel, !val);
+		if (chan->channel == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(0), !val);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(1), !val);
+
+		err = ad3552r_update_reg_field(dac, AD3552R_REG_ADDR_POWERDOWN_CONFIG,
+					       AD3552R_MASK_CH_DAC_POWERDOWN(chan->channel),
+					       val);
 		break;
 	default:
 		err = -EINVAL;
@@ -715,9 +627,9 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 	}
 
 	return ad3552r_update_reg_field(dac,
-					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
-					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
-					val);
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
+					AD3552R_MASK_ADDR_ASCENSION,
+					FIELD_PREP(AD3552R_MASK_ADDR_ASCENSION, val));
 }
 
 static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, s32 *v_min,
@@ -812,20 +724,20 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 				     "mandatory custom-output-range-config property missing\n");
 
 	dac->ch_data[ch].range_override = 1;
-	reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
 
 	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "mandatory adi,gain-scaling-p property missing\n");
-	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, val);
 	dac->ch_data[ch].p = val;
 
 	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
 	if (err)
 		return dev_err_probe(dev, err,
 				     "mandatory adi,gain-scaling-n property missing\n");
-	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, val);
 	dac->ch_data[ch].n = val;
 
 	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
@@ -841,9 +753,9 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 	dac->ch_data[ch].gain_offset = val;
 
 	offset = abs((s32)val);
-	reg |= ad3552r_field_prep((offset >> 8), AD3552R_MASK_CH_OFFSET_BIT_8);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, (offset >> 8));
 
-	reg |= ad3552r_field_prep((s32)val < 0, AD3552R_MASK_CH_OFFSET_POLARITY);
+	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)val < 0);
 	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
 	err = ad3552r_write_reg(dac, addr,
 				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
@@ -886,9 +798,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	}
 
 	err = ad3552r_update_reg_field(dac,
-				       addr_mask_map[AD3552R_VREF_SELECT][0],
-				       addr_mask_map[AD3552R_VREF_SELECT][1],
-				       val);
+				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				       AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+				       FIELD_PREP(AD3552R_MASK_REFERENCE_VOLTAGE_SEL, val));
 	if (err)
 		return err;
 
@@ -900,9 +812,9 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 		}
 
 		err = ad3552r_update_reg_field(dac,
-					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][0],
-					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][1],
-					       val);
+					       AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					       AD3552R_MASK_SDO_DRIVE_STRENGTH,
+					       FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, val));
 		if (err)
 			return err;
 	}
@@ -938,9 +850,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 						     "Invalid adi,output-range-microvolt value\n");
 
 			val = err;
-			err = ad3552r_set_ch_value(dac,
-						   AD3552R_CH_OUTPUT_RANGE_SEL,
-						   ch, val);
+			if (ch == 0)
+				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), val);
+			else
+				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), val);
+
+			err = ad3552r_update_reg_field(dac,
+						       AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+						       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
+						       val);
 			if (err)
 				return err;
 
@@ -958,7 +876,14 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 		ad3552r_calc_gain_and_offset(dac, ch);
 		dac->enabled_ch |= BIT(ch);
 
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
+		if (ch == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH(0), 1);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH(1), 1);
+
+		err = ad3552r_update_reg_field(dac,
+					       AD3552R_REG_ADDR_CH_SELECT_16B,
+					       AD3552R_MASK_CH(ch), val);
 		if (err < 0)
 			return err;
 
@@ -970,8 +895,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	/* Disable unused channels */
 	for_each_clear_bit(ch, &dac->enabled_ch,
 			   dac->model_data->num_hw_channels) {
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_AMPLIFIER_POWERDOWN,
-					   ch, 1);
+		if (ch == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), 1);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), 1);
+
+		err = ad3552r_update_reg_field(dac,
+					       AD3552R_REG_ADDR_POWERDOWN_CONFIG,
+					       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
+					       val);
 		if (err)
 			return err;
 	}

-- 
2.45.0.rc1


