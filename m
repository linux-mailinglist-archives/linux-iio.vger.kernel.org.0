Return-Path: <linux-iio+bounces-21592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC7B027B4
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 01:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBE61CC0AB8
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2722236FC;
	Fri, 11 Jul 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCdfVudu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E962628D;
	Fri, 11 Jul 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752276983; cv=none; b=NJwGKu10jWi2k6nbsqZB/vGm7CYzebumRm1/7Ri5YIaB2RqGLBD6i1DgJ5gFAdSIPzKlIrAEjtP6Ai5F8U+gayvxG7dmWOqVdYXCLvBPmXbt7iJd9/uSrjPgMNQ2XrQ5swHhh40vAcgHFrIWZJm+soYO5DbLeWTDw0u/EGr3v8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752276983; c=relaxed/simple;
	bh=zro00Tv/mknvh3+v7cicZxR58sTx9xt6qXr3l0qTLRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5SMaoNIBOgfo0/eK/bSz3vSY3zDkFBItFlzp42WrBUvb8iu6sv8bVm7D/Rc/wkCXJRqwMP8zs9mE+WS6tiQmB4O6WfD9u9sD369kyUXzzAfc3V2qDxll1j1mEB7jqJm0KOSEZQ1dWdcr/OjzfQcgkAhqs1pctcU9VnVoljyR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCdfVudu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so3158086b3a.0;
        Fri, 11 Jul 2025 16:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752276981; x=1752881781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kk3JY1ebfLO8LpK1Yhe4GAUb4B9miP2uc1BRrcMxPzk=;
        b=MCdfVudu6bsK8oE4ht5bkrcFkkAHCOlgAAuQ1JQuP2Gti2+L7Pcv321gaRismXSaro
         shuI9lcXPOnMSLvUkVSonvVecNGtNN/1ksgCX2AFC+PNFEQ/Lyv7xKtR67l+TMnd4tEn
         5X2GY4ZkFtBNs5x66blUYXgcLRRnvdSFdDeYtFhM1zqnh0/ncXdojC/LB0NQ3w8n7yHw
         wb/BEhj3twRflhSixoLh6glDYT9kVn170nyStst7bs5su32AzSnkj8XnAWCjI/GF4dMg
         112hCuqE1BS1HDkkojbzHfviq8ITpISEltNbM/pP3PSqDcdl5Dyvhl7YYK3uyvBFvdbZ
         58Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752276981; x=1752881781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kk3JY1ebfLO8LpK1Yhe4GAUb4B9miP2uc1BRrcMxPzk=;
        b=DHl1LIFxwHd98NGNIAHSp6ysn5VbK8wxp2VchIX9SGRjqogikDGPDiaD87/iVBj0mU
         r9UHWDGyhrwc70JVyFDk+m4QoLlFZF8I461khFmQAidpFgBeOHbm0IBrEBj05NYWd9e9
         NkRYPac+RZsS7pbdOvCZDek3HrhmDPDXLl6z1j2SJ5aR2uGP9SsPh0zAEgRvHZ6FEdCU
         pYhR9MI2o9lXggbOvnnOtaY+ll1oB4/V9zBIleqtoQtqMoCRc8HBAxdvYXXVBQRzHmZU
         luihXgGwhF3y1RU8sGof7riNjrk/Rm9FEYyWJbr5zAZPSBn/kdxUhy63PmAA/K34C/ij
         fvPg==
X-Forwarded-Encrypted: i=1; AJvYcCW9UKB/pAaz9WRy2N0gBfRMvDRRUCvAR2upmPZ4s6IUoahHRg3JZWGWy6voZ38AjNgThhx2PW14bo9TqYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jplmMIfF0MhpighhVTlgQ8JwwSDKYtJRkiBBHJzm6VGnOvRl
	EvJ91U51tCbjVrVPJqJB+Q1HVVfHQddufjH2+n31uCb/AZJarsXNezEo
X-Gm-Gg: ASbGncsL65bGGBU8ivDPJhS48QMAXjdolxTvtEK2tXBAKPv0CecTni78ywg5rWxV86R
	uIzKbzqzFw+2K0ahFgl4HoFvVw6yjkk/lak5V7E0o6PddcURe8/9q8vHw3w0CeaGNQmoXnJrwqJ
	HoapF5jP57uKINNGkp+gs1H25/3w8bZi/m4hh6zr8JXHOTEesMMfK71vDBh+5O575nKXeiWCMHL
	qfvUAVGb2VWR0p0vuj8BbiweDxs6RF11EoECFre55gKHHUg/O37yd6e5I01u3iNEr0jlGRwXJAT
	aqxvK4iaF6cIM5JlrcMGh5JAzKRIHtGxIzn5Q5TPSRAY/lkwVyCvwW8cZkfb0iVlfAUsBl0Dyh4
	p/QZU9B49lkZH/0ox
X-Google-Smtp-Source: AGHT+IFGBJeJR99ZLGpHLOA+FjY9+w0KTH3fHV9B2UlbIoKuXFfOHiy7GttC5Lkgh9eKGmqtLRwqnA==
X-Received: by 2002:a05:6a21:3990:b0:215:e02f:1eb8 with SMTP id adf61e73a8af0-231278bd6c4mr7111326637.14.1752276980750;
        Fri, 11 Jul 2025 16:36:20 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498::13a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4cb57sm6319471b3a.136.2025.07.11.16.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 16:36:20 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Date: Fri, 11 Jul 2025 20:36:03 -0300
Message-ID: <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752273682; l=17496;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=GRnQfagKayZ1tc9w9oQO3ixyf+DuWih4RO0NlGOpqNg=;
 b=dii+PuhsLxIWo87rXArgyWuD6wzK3sExKCtMBwvwR4yjnPff9gcjvmeAKJOw8exmqC81fLM8h
 N1zYU1ZTWY9BZMRuDxNRxxncx3DMYlqdYjPxeUOHln46N13CEXQrJfA
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=
Content-Transfer-Encoding: quoted-printable

Any-motion event can be enabled on a per-axis basis and triggers a=0D
combined event when motion is detected on any axis.=0D
=0D
No-motion event is triggered if the rate of change on all axes falls=0D
below a specified threshold for a configurable duration. A fake channel=0D
is used to report this event.=0D
=0D
Threshold and duration can be configured from userspace.=0D
=0D
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>=0D
---=0D
Changes in v4:=0D
- Reworked the threshold for the any-motion event so that threshold *=0D
  accel_scale is given in m/s^2, in accordance with the ABI=0D
  Also the range of available values for the threshold is now determined=0D
  dynamically based on the value of the accelerometer scale=0D
- Fixed alignment and styling of some statements and macros=0D
- Simplified the return statement in the bmi270_read_event_config()=0D
  function by returning the boolean expression directly=0D
---=0D
 drivers/iio/imu/bmi270/bmi270_core.c | 384 +++++++++++++++++++++++++++++++=
++--=0D
 1 file changed, 364 insertions(+), 20 deletions(-)=0D
=0D
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/=
bmi270_core.c=0D
index 519f1c9d466dceb301b53efee905f1b8fc4468c0..b9491618eb9b35632ea11de6f70=
52d8fdac394ba 100644=0D
--- a/drivers/iio/imu/bmi270/bmi270_core.c=0D
+++ b/drivers/iio/imu/bmi270/bmi270_core.c=0D
@@ -31,6 +31,8 @@=0D
 =0D
 #define BMI270_INT_STATUS_0_REG				0x1c=0D
 #define BMI270_INT_STATUS_0_STEP_CNT_MSK		BIT(1)=0D
+#define BMI270_INT_STATUS_0_NOMOTION_MSK		BIT(5)=0D
+#define BMI270_INT_STATUS_0_MOTION_MSK			BIT(6)=0D
 =0D
 #define BMI270_INT_STATUS_1_REG				0x1d=0D
 #define BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK		GENMASK(7, 6)=0D
@@ -81,6 +83,8 @@=0D
 #define BMI270_INT1_MAP_FEAT_REG			0x56=0D
 #define BMI270_INT2_MAP_FEAT_REG			0x57=0D
 #define BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK		BIT(1)=0D
+#define BMI270_INT_MAP_FEAT_NOMOTION_MSK		BIT(5)=0D
+#define BMI270_INT_MAP_FEAT_ANYMOTION_MSK		BIT(6)=0D
 =0D
 #define BMI270_INT_MAP_DATA_REG				0x58=0D
 #define BMI270_INT_MAP_DATA_DRDY_INT1_MSK		BIT(2)=0D
@@ -106,6 +110,25 @@=0D
 #define BMI270_STEP_SC26_RST_CNT_MSK			BIT(10)=0D
 #define BMI270_STEP_SC26_EN_CNT_MSK			BIT(12)=0D
 =0D
+#define BMI270_FEAT_MOTION_DURATION_MSK			GENMASK(12, 0)=0D
+#define BMI270_FEAT_MOTION_X_EN_MSK			BIT(13)=0D
+#define BMI270_FEAT_MOTION_Y_EN_MSK			BIT(14)=0D
+#define BMI270_FEAT_MOTION_Z_EN_MSK			BIT(15)=0D
+#define BMI270_FEAT_MOTION_XYZ_EN_MSK			GENMASK(15, 13)=0D
+#define BMI270_FEAT_MOTION_THRESHOLD_MSK		GENMASK(10, 0)=0D
+#define BMI270_FEAT_MOTION_OUT_CONF_MSK			GENMASK(14, 11)=0D
+#define BMI270_FEAT_MOTION_ENABLE_MSK			BIT(15)=0D
+=0D
+#define BMI270_MOTION_XYZ_MSK				GENMASK(2, 0)=0D
+=0D
+/* See pages 92 and 93 of the datasheet */=0D
+#define BMI270_MOTION_THRES_FULL_SCALE			GENMASK(10, 0)=0D
+#define BMI270_MOTION_DURAT_SCALE			50=0D
+#define BMI270_MOTION_DURAT_MAX				162=0D
+=0D
+/* 9.81 * 1000000 m/s^2 */=0D
+#define BMI270_G_MEGA_M_S_2				9810000=0D
+=0D
 /* See datasheet section 4.6.14, Temperature Sensor */=0D
 #define BMI270_TEMP_OFFSET				11776=0D
 #define BMI270_TEMP_SCALE				1953125=0D
@@ -114,6 +137,11 @@=0D
 #define BMI270_STEP_COUNTER_FACTOR			20=0D
 #define BMI270_STEP_COUNTER_MAX				20460=0D
 =0D
+#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \=0D
+	((val) * (scale) + ((val2) * (scale)) / MEGA)=0D
+#define BMI270_RAW_TO_MICRO(raw, scale) \=0D
+	((((raw) % (scale)) * MEGA) / scale)=0D
+=0D
 #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"=0D
 #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"=0D
 =0D
@@ -309,6 +337,13 @@ static const struct  bmi270_odr_item bmi270_odr_table[=
] =3D {=0D
 };=0D
 =0D
 enum bmi270_feature_reg_id {=0D
+	/* Page 1 registers */=0D
+	BMI270_ANYMO1_REG,=0D
+	BMI270_ANYMO2_REG,=0D
+	/* Page 2 registers */=0D
+	BMI270_NOMO1_REG,=0D
+	BMI270_NOMO2_REG,=0D
+	/* Page 6 registers */=0D
 	BMI270_SC_26_REG,=0D
 };=0D
 =0D
@@ -318,6 +353,22 @@ struct bmi270_feature_reg {=0D
 };=0D
 =0D
 static const struct bmi270_feature_reg bmi270_feature_regs[] =3D {=0D
+	[BMI270_ANYMO1_REG] =3D {=0D
+		.page =3D 1,=0D
+		.addr =3D 0x3c,=0D
+	},=0D
+	[BMI270_ANYMO2_REG] =3D {=0D
+		.page =3D 1,=0D
+		.addr =3D 0x3e,=0D
+	},=0D
+	[BMI270_NOMO1_REG] =3D {=0D
+		.page =3D 2,=0D
+		.addr =3D 0x30,=0D
+	},=0D
+	[BMI270_NOMO2_REG] =3D {=0D
+		.page =3D 2,=0D
+		.addr =3D 0x32,=0D
+	},=0D
 	[BMI270_SC_26_REG] =3D {=0D
 		.page =3D 6,=0D
 		.addr =3D 0x32,=0D
@@ -439,6 +490,121 @@ static int bmi270_step_wtrmrk_en(struct bmi270_data *=
data, bool state)=0D
 					     state));=0D
 }=0D
 =0D
+static int bmi270_motion_reg(enum iio_event_type type, enum iio_event_info=
 info)=0D
+{=0D
+	switch (info) {=0D
+	case IIO_EV_INFO_PERIOD:=0D
+		switch (type) {=0D
+		case IIO_EV_TYPE_MAG_ADAPTIVE:=0D
+			return BMI270_ANYMO1_REG;=0D
+		case IIO_EV_TYPE_ROC:=0D
+			return BMI270_NOMO1_REG;=0D
+		default:=0D
+			return -EINVAL;=0D
+		}=0D
+	case IIO_EV_INFO_VALUE:=0D
+		switch (type) {=0D
+		case IIO_EV_TYPE_MAG_ADAPTIVE:=0D
+			return BMI270_ANYMO2_REG;=0D
+		case IIO_EV_TYPE_ROC:=0D
+			return BMI270_NOMO2_REG;=0D
+		default:=0D
+			return -EINVAL;=0D
+		}=0D
+	default:=0D
+		return -EINVAL;=0D
+	}=0D
+}=0D
+=0D
+static int bmi270_anymotion_event_en(struct bmi270_data *data,=0D
+				     struct iio_chan_spec const *chan,=0D
+				     bool state)=0D
+{=0D
+	u16 axis_msk, axis_field_val, regval;=0D
+	int ret, irq_reg;=0D
+	bool axis_en;=0D
+=0D
+	irq_reg =3D bmi270_int_map_reg(data->irq_pin);=0D
+	if (irq_reg < 0)=0D
+		return irq_reg;=0D
+=0D
+	guard(mutex)(&data->mutex);=0D
+=0D
+	ret =3D bmi270_read_feature_reg(data, BMI270_ANYMO1_REG, &regval);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	switch (chan->channel2) {=0D
+	case IIO_MOD_X:=0D
+		axis_msk =3D BMI270_FEAT_MOTION_X_EN_MSK;=0D
+		axis_field_val =3D FIELD_PREP(BMI270_FEAT_MOTION_X_EN_MSK, state);=0D
+		axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_Y_EN_MSK, regval) |=0D
+			  FIELD_GET(BMI270_FEAT_MOTION_Z_EN_MSK, regval);=0D
+		break;=0D
+	case IIO_MOD_Y:=0D
+		axis_msk =3D BMI270_FEAT_MOTION_Y_EN_MSK;=0D
+		axis_field_val =3D FIELD_PREP(BMI270_FEAT_MOTION_Y_EN_MSK, state);=0D
+		axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_X_EN_MSK, regval) |=0D
+			  FIELD_GET(BMI270_FEAT_MOTION_Z_EN_MSK, regval);=0D
+		break;=0D
+	case IIO_MOD_Z:=0D
+		axis_msk =3D BMI270_FEAT_MOTION_Z_EN_MSK;=0D
+		axis_field_val =3D FIELD_PREP(BMI270_FEAT_MOTION_Z_EN_MSK, state);=0D
+		axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_X_EN_MSK, regval) |=0D
+			  FIELD_GET(BMI270_FEAT_MOTION_Y_EN_MSK, regval);=0D
+		break;=0D
+	default:=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	ret =3D bmi270_update_feature_reg(data, BMI270_ANYMO1_REG, axis_msk,=0D
+					axis_field_val);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D bmi270_update_feature_reg(data, BMI270_ANYMO2_REG,=0D
+					BMI270_FEAT_MOTION_ENABLE_MSK,=0D
+					FIELD_PREP(BMI270_FEAT_MOTION_ENABLE_MSK,=0D
+						   state || axis_en));=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	return regmap_update_bits(data->regmap, irq_reg,=0D
+				  BMI270_INT_MAP_FEAT_ANYMOTION_MSK,=0D
+				  FIELD_PREP(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,=0D
+					     state || axis_en));=0D
+}=0D
+=0D
+static int bmi270_nomotion_event_en(struct bmi270_data *data, bool state)=
=0D
+{=0D
+	int ret, irq_reg;=0D
+=0D
+	irq_reg =3D bmi270_int_map_reg(data->irq_pin);=0D
+	if (irq_reg < 0)=0D
+		return irq_reg;=0D
+=0D
+	guard(mutex)(&data->mutex);=0D
+=0D
+	ret =3D bmi270_update_feature_reg(data, BMI270_NOMO1_REG,=0D
+					BMI270_FEAT_MOTION_XYZ_EN_MSK,=0D
+					FIELD_PREP(BMI270_FEAT_MOTION_XYZ_EN_MSK,=0D
+						   state ? BMI270_MOTION_XYZ_MSK : 0));=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	ret =3D bmi270_update_feature_reg(data, BMI270_NOMO2_REG,=0D
+					BMI270_FEAT_MOTION_ENABLE_MSK,=0D
+					FIELD_PREP(BMI270_FEAT_MOTION_ENABLE_MSK,=0D
+						   state));=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	return regmap_update_bits(data->regmap, irq_reg,=0D
+				  BMI270_INT_MAP_FEAT_NOMOTION_MSK,=0D
+				  FIELD_PREP(BMI270_INT_MAP_FEAT_NOMOTION_MSK,=0D
+					     state));=0D
+}=0D
+=0D
 static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int u=
scale)=0D
 {=0D
 	int i;=0D
@@ -479,8 +645,6 @@ static int bmi270_get_scale(struct bmi270_data *data, i=
nt chan_type, int *scale,=0D
 	unsigned int val;=0D
 	struct bmi270_scale_item bmi270_scale_item;=0D
 =0D
-	guard(mutex)(&data->mutex);=0D
-=0D
 	switch (chan_type) {=0D
 	case IIO_ACCEL:=0D
 		ret =3D regmap_read(data->regmap, BMI270_ACC_CONF_RANGE_REG, &val);=0D
@@ -614,6 +778,20 @@ static irqreturn_t bmi270_irq_thread_handler(int irq, =
void *private)=0D
 	if (FIELD_GET(BMI270_INT_STATUS_1_ACC_GYR_DRDY_MSK, status1))=0D
 		iio_trigger_poll_nested(data->trig);=0D
 =0D
+	if (FIELD_GET(BMI270_INT_STATUS_0_MOTION_MSK, status0))=0D
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,=0D
+							     IIO_MOD_X_OR_Y_OR_Z,=0D
+							     IIO_EV_TYPE_MAG_ADAPTIVE,=0D
+							     IIO_EV_DIR_RISING),=0D
+			       timestamp);=0D
+=0D
+	if (FIELD_GET(BMI270_INT_STATUS_0_NOMOTION_MSK, status0))=0D
+		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,=0D
+							     IIO_MOD_X_AND_Y_AND_Z,=0D
+							     IIO_EV_TYPE_ROC,=0D
+							     IIO_EV_DIR_RISING),=0D
+			       timestamp);=0D
+=0D
 	if (FIELD_GET(BMI270_INT_STATUS_0_STEP_CNT_MSK, status0))=0D
 		iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_STEPS, 0,=0D
 							       IIO_EV_TYPE_CHANGE,=0D
@@ -827,6 +1005,40 @@ static int bmi270_read_avail(struct iio_dev *indio_de=
v,=0D
 	}=0D
 }=0D
 =0D
+static ssize_t bmi270_show_accel_value_avail(struct device *dev,=0D
+					     struct device_attribute *attr,=0D
+					     char *buf)=0D
+{=0D
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);=0D
+	struct bmi270_data *data =3D iio_priv(indio_dev);=0D
+	int ret, scale, uscale;=0D
+	unsigned int step, max;=0D
+=0D
+	ret =3D bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
+	max =3D BMI270_G_MEGA_M_S_2 / uscale;=0D
+	step =3D max / BMI270_MOTION_THRES_FULL_SCALE;=0D
+=0D
+	return sysfs_emit(buf, "[0 %u %u]\n", step, max);=0D
+}=0D
+=0D
+static IIO_DEVICE_ATTR(in_accel_value_available, 0444,=0D
+		       bmi270_show_accel_value_avail, NULL, 0);=0D
+=0D
+static IIO_CONST_ATTR(in_accel_period_available, "[0.0 0.02 162.0]");=0D
+=0D
+static struct attribute *bmi270_event_attributes[] =3D {=0D
+	&iio_dev_attr_in_accel_value_available.dev_attr.attr,=0D
+	&iio_const_attr_in_accel_period_available.dev_attr.attr,=0D
+	NULL=0D
+};=0D
+=0D
+static const struct attribute_group bmi270_event_attribute_group =3D {=0D
+	.attrs =3D bmi270_event_attributes,=0D
+};=0D
+=0D
 static int bmi270_write_event_config(struct iio_dev *indio_dev,=0D
 				     const struct iio_chan_spec *chan,=0D
 				     enum iio_event_type type,=0D
@@ -835,6 +1047,10 @@ static int bmi270_write_event_config(struct iio_dev *=
indio_dev,=0D
 	struct bmi270_data *data =3D iio_priv(indio_dev);=0D
 =0D
 	switch (type) {=0D
+	case IIO_EV_TYPE_MAG_ADAPTIVE:=0D
+		return bmi270_anymotion_event_en(data, chan, state);=0D
+	case IIO_EV_TYPE_ROC:=0D
+		return bmi270_nomotion_event_en(data, state);=0D
 	case IIO_EV_TYPE_CHANGE:=0D
 		return bmi270_step_wtrmrk_en(data, state);=0D
 	default:=0D
@@ -848,21 +1064,57 @@ static int bmi270_read_event_config(struct iio_dev *=
indio_dev,=0D
 				    enum iio_event_direction dir)=0D
 {=0D
 	struct bmi270_data *data =3D iio_priv(indio_dev);=0D
+	bool feat_en, axis_en;=0D
 	int ret, reg, regval;=0D
+	u16 motion_reg;=0D
 =0D
 	guard(mutex)(&data->mutex);=0D
 =0D
+	reg =3D bmi270_int_map_reg(data->irq_pin);=0D
+	if (reg < 0)=0D
+		return reg;=0D
+=0D
+	ret =3D regmap_read(data->regmap, reg, &regval);=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
 	switch (chan->type) {=0D
 	case IIO_STEPS:=0D
-		reg =3D bmi270_int_map_reg(data->irq_pin);=0D
-		if (reg)=0D
-			return reg;=0D
+		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK, regval) ?=0D
+									1 : 0;=0D
+	case IIO_ACCEL:=0D
+		switch (type) {=0D
+		case IIO_EV_TYPE_ROC:=0D
+			return FIELD_GET(BMI270_INT_MAP_FEAT_NOMOTION_MSK,=0D
+					 regval) ? 1 : 0;=0D
+		case IIO_EV_TYPE_MAG_ADAPTIVE:=0D
+			ret =3D bmi270_read_feature_reg(data, BMI270_ANYMO1_REG,=0D
+						      &motion_reg);=0D
+			if (ret)=0D
+				return ret;=0D
 =0D
-		ret =3D regmap_read(data->regmap, reg, &regval);=0D
-		if (ret)=0D
-			return ret;=0D
-		return FIELD_GET(BMI270_INT_MAP_FEAT_STEP_CNT_WTRMRK_MSK,=0D
-				 regval) ? 1 : 0;=0D
+			feat_en =3D FIELD_GET(BMI270_INT_MAP_FEAT_ANYMOTION_MSK,=0D
+					    regval);=0D
+			switch (chan->channel2) {=0D
+			case IIO_MOD_X:=0D
+				axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_X_EN_MSK,=0D
+						    motion_reg);=0D
+				break;=0D
+			case IIO_MOD_Y:=0D
+				axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_Y_EN_MSK,=0D
+						    motion_reg);=0D
+				break;=0D
+			case IIO_MOD_Z:=0D
+				axis_en =3D FIELD_GET(BMI270_FEAT_MOTION_Z_EN_MSK,=0D
+						    motion_reg);=0D
+				break;=0D
+			default:=0D
+				return -EINVAL;=0D
+			}=0D
+			return axis_en && feat_en;=0D
+		default:=0D
+			return -EINVAL;=0D
+		}=0D
 	default:=0D
 		return -EINVAL;=0D
 	}=0D
@@ -876,20 +1128,50 @@ static int bmi270_write_event_value(struct iio_dev *=
indio_dev,=0D
 				    int val, int val2)=0D
 {=0D
 	struct bmi270_data *data =3D iio_priv(indio_dev);=0D
-	unsigned int raw;=0D
+	unsigned int raw, mask, regval;=0D
+	int ret, reg, scale, uscale;=0D
+	u64 tmp;=0D
 =0D
 	guard(mutex)(&data->mutex);=0D
 =0D
-	switch (type) {=0D
-	case IIO_EV_TYPE_CHANGE:=0D
+	if (type =3D=3D IIO_EV_TYPE_CHANGE) {=0D
 		if (!in_range(val, 0, BMI270_STEP_COUNTER_MAX + 1))=0D
 			return -EINVAL;=0D
 =0D
 		raw =3D val / BMI270_STEP_COUNTER_FACTOR;=0D
-		return bmi270_update_feature_reg(data, BMI270_SC_26_REG,=0D
-						 BMI270_STEP_SC26_WTRMRK_MSK,=0D
-						 FIELD_PREP(BMI270_STEP_SC26_WTRMRK_MSK,=0D
-							    raw));=0D
+		mask =3D BMI270_STEP_SC26_WTRMRK_MSK;=0D
+		regval =3D FIELD_PREP(BMI270_STEP_SC26_WTRMRK_MSK, raw);=0D
+		return bmi270_update_feature_reg(data, BMI270_SC_26_REG, mask,=0D
+						 regval);=0D
+	}=0D
+=0D
+	reg =3D bmi270_motion_reg(type, info);=0D
+	if (reg < 0)=0D
+		return reg;=0D
+=0D
+	switch (info) {=0D
+	case IIO_EV_INFO_VALUE:=0D
+		ret =3D bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);=0D
+		if (ret)=0D
+			return ret;=0D
+=0D
+		if (!in_range(val, 0, (BMI270_G_MEGA_M_S_2 / uscale) + 1))=0D
+			return -EINVAL;=0D
+=0D
+		tmp =3D (u64)val * BMI270_MOTION_THRES_FULL_SCALE * uscale;=0D
+		raw =3D DIV_ROUND_CLOSEST_ULL(tmp, BMI270_G_MEGA_M_S_2);=0D
+		mask =3D BMI270_FEAT_MOTION_THRESHOLD_MSK;=0D
+		regval =3D FIELD_PREP(BMI270_FEAT_MOTION_THRESHOLD_MSK, raw);=0D
+		return bmi270_update_feature_reg(data, reg, mask, regval);=0D
+	case IIO_EV_INFO_PERIOD:=0D
+		if (!in_range(val, 0, BMI270_MOTION_DURAT_MAX + 1))=0D
+			return -EINVAL;=0D
+=0D
+		raw =3D BMI270_INT_MICRO_TO_RAW(val, val2,=0D
+					      BMI270_MOTION_DURAT_SCALE);=0D
+		mask =3D BMI270_FEAT_MOTION_DURATION_MSK;=0D
+		regval =3D FIELD_PREP(BMI270_FEAT_MOTION_DURATION_MSK, raw);=0D
+		return bmi270_update_feature_reg(data, reg, mask, regval);=0D
 	default:=0D
 		return -EINVAL;=0D
 	}=0D
@@ -903,14 +1185,14 @@ static int bmi270_read_event_value(struct iio_dev *i=
ndio_dev,=0D
 				   int *val, int *val2)=0D
 {=0D
 	struct bmi270_data *data =3D iio_priv(indio_dev);=0D
+	int ret, reg, scale, uscale;=0D
 	unsigned int raw;=0D
 	u16 regval;=0D
-	int ret;=0D
+	u64 tmp;=0D
 =0D
 	guard(mutex)(&data->mutex);=0D
 =0D
-	switch (type) {=0D
-	case IIO_EV_TYPE_CHANGE:=0D
+	if (type =3D=3D IIO_EV_TYPE_CHANGE) {=0D
 		ret =3D bmi270_read_feature_reg(data, BMI270_SC_26_REG, &regval);=0D
 		if (ret)=0D
 			return ret;=0D
@@ -918,6 +1200,36 @@ static int bmi270_read_event_value(struct iio_dev *in=
dio_dev,=0D
 		raw =3D FIELD_GET(BMI270_STEP_SC26_WTRMRK_MSK, regval);=0D
 		*val =3D raw * BMI270_STEP_COUNTER_FACTOR;=0D
 		return IIO_VAL_INT;=0D
+	}=0D
+=0D
+	reg =3D bmi270_motion_reg(type, info);=0D
+	if (reg < 0)=0D
+		return reg;=0D
+=0D
+	switch (info) {=0D
+	case IIO_EV_INFO_VALUE:=0D
+		ret =3D bmi270_read_feature_reg(data, reg, &regval);=0D
+		if (ret)=0D
+			return ret;=0D
+=0D
+		ret =3D bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);=0D
+		if (ret)=0D
+			return ret;=0D
+=0D
+		raw =3D FIELD_GET(BMI270_FEAT_MOTION_THRESHOLD_MSK, regval);=0D
+		tmp =3D (u64)raw * BMI270_G_MEGA_M_S_2;=0D
+		*val =3D DIV_ROUND_CLOSEST_ULL(tmp,=0D
+					     BMI270_MOTION_THRES_FULL_SCALE * uscale);=0D
+		return IIO_VAL_INT;=0D
+	case IIO_EV_INFO_PERIOD:=0D
+		ret =3D bmi270_read_feature_reg(data, reg, &regval);=0D
+		if (ret)=0D
+			return ret;=0D
+=0D
+		raw =3D FIELD_GET(BMI270_FEAT_MOTION_DURATION_MSK, regval);=0D
+		*val =3D raw / BMI270_MOTION_DURAT_SCALE;=0D
+		*val2 =3D BMI270_RAW_TO_MICRO(raw, BMI270_MOTION_DURAT_SCALE);=0D
+		return IIO_VAL_INT_PLUS_MICRO;=0D
 	default:=0D
 		return -EINVAL;=0D
 	}=0D
@@ -929,6 +1241,20 @@ static const struct iio_event_spec bmi270_step_wtrmrk=
_event =3D {=0D
 	.mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE)=
,=0D
 };=0D
 =0D
+static const struct iio_event_spec bmi270_anymotion_event =3D {=0D
+	.type =3D IIO_EV_TYPE_MAG_ADAPTIVE,=0D
+	.dir =3D IIO_EV_DIR_RISING,=0D
+	.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),=0D
+	.mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_PERIOD)=
,=0D
+};=0D
+=0D
+static const struct iio_event_spec bmi270_nomotion_event =3D {=0D
+	.type =3D IIO_EV_TYPE_ROC,=0D
+	.dir =3D IIO_EV_DIR_RISING,=0D
+	.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),=0D
+	.mask_shared_by_type =3D BIT(IIO_EV_INFO_VALUE) | BIT(IIO_EV_INFO_PERIOD)=
,=0D
+};=0D
+=0D
 static const struct iio_info bmi270_info =3D {=0D
 	.read_raw =3D bmi270_read_raw,=0D
 	.write_raw =3D bmi270_write_raw,=0D
@@ -937,6 +1263,7 @@ static const struct iio_info bmi270_info =3D {=0D
 	.read_event_config =3D bmi270_read_event_config,=0D
 	.write_event_value =3D bmi270_write_event_value,=0D
 	.read_event_value =3D bmi270_read_event_value,=0D
+	.event_attrs =3D &bmi270_event_attribute_group,=0D
 };=0D
 =0D
 #define BMI270_ACCEL_CHANNEL(_axis) {				\=0D
@@ -956,6 +1283,8 @@ static const struct iio_info bmi270_info =3D {=0D
 		.storagebits =3D 16,				\=0D
 		.endianness =3D IIO_LE,				\=0D
 	},	                                                \=0D
+	.event_spec =3D &bmi270_anymotion_event,			\=0D
+	.num_event_specs =3D 1,					\=0D
 }=0D
 =0D
 #define BMI270_ANG_VEL_CHANNEL(_axis) {				\=0D
@@ -1000,6 +1329,14 @@ static const struct iio_chan_spec bmi270_channels[] =
=3D {=0D
 		.num_event_specs =3D 1,=0D
 	},=0D
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),=0D
+	{=0D
+		.type =3D IIO_ACCEL,=0D
+		.modified =3D 1,=0D
+		.channel2 =3D IIO_MOD_X_AND_Y_AND_Z,=0D
+		.scan_index =3D -1, /* Fake channel */=0D
+		.event_spec =3D &bmi270_nomotion_event,=0D
+		.num_event_specs =3D 1,=0D
+	},=0D
 };=0D
 =0D
 static int bmi270_int_pin_config(struct bmi270_data *data,=0D
@@ -1107,6 +1444,13 @@ static int bmi270_trigger_probe(struct bmi270_data *=
data,=0D
 		return dev_err_probe(data->dev, ret,=0D
 				     "Trigger registration failed\n");=0D
 =0D
+	/* Disable axes for motion events */=0D
+	ret =3D bmi270_update_feature_reg(data, BMI270_ANYMO1_REG,=0D
+					BMI270_FEAT_MOTION_XYZ_EN_MSK,=0D
+					FIELD_PREP(BMI270_FEAT_MOTION_XYZ_EN_MSK, 0));=0D
+	if (ret)=0D
+		return ret;=0D
+=0D
 	data->irq_pin =3D irq_pin;=0D
 =0D
 	return 0;=0D
=0D
-- =0D
2.50.0=0D
=0D

