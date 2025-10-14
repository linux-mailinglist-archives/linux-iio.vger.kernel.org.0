Return-Path: <linux-iio+bounces-25061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4DBDAACE
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F819A4091
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92630748B;
	Tue, 14 Oct 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Bvi9EuMT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06A303A32;
	Tue, 14 Oct 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460210; cv=none; b=MYrosPetmK6RWzbKhyY/pjyqLVgjIxgQ3JktfbnECilG6die2XpmMgmYndTJsIC1I9JJHb9h89x6aXfEWORKsFQNnfpCgG6wbDT1ehvSYHSxB3t171qLu/2yVc3tQplge3rGJ/hl7Qwj0mRWwkkmlezLJFKbVhXJW/gKuVQaop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460210; c=relaxed/simple;
	bh=hD0QVxi4ot0KG3V1y5g3NPZLHgiANGBJVNODIKkKWNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qw1N6O58ftdzHIpvLLp8Rv/2sKG6zdpN8qMR55Es5alYbta68VGSU3EmUXXe+RSuEccwlH600qRIgO/kcTY2AS1ivSauMRXVzbgAalvqSdUZaKO5+yKPcIzGUOoT+Ew8SHES5kxLxrRqIjjYkRYX0Flap0OiAMATDombx2BGt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Bvi9EuMT; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id CE6E3173BED;
	Tue, 14 Oct 2025 19:43:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4hNeRBKdeMZfs72/KttZKtNs3sltBGcHjWb0zKFFQg=;
	b=Bvi9EuMTDys+lA+A+ROf8gKfxePveuQYUg4eBclKuJ1gG1P28j14PUEh3vO3cipVPqkGej
	16hmuBxse16Zy5r+u5sp0TCEiD5xehgJqc1RfhWxANEk/pLB6nP/Zotfi8YvJ9G7V16cS9
	98r0KRa6oFzfwcdNghlvl0aJdj7FWyp3mIfNJfXm54envQ2rBvKY3PnJz/gNIfVrCdm2wB
	GlFvla3Nxx5vBynxrF4qLp56pyuiGgCfiVGAqwykaftJJA7f5PoiyHIzOBIKwMLsPFQLfx
	tAHSPFUam7zhmzKRchgK7uTzfyfGKmORL66UNsjYGBXnJkNOVdVqr+SFdgQFOg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Tue, 14 Oct 2025 19:43:01 +0300
Subject: [PATCH 5/6] iio: accel: bma220: add high-g event detection
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-bma220_events-v1-5-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
In-Reply-To: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=hD0QVxi4ot0KG3V1y5g3NPZLHgiANGBJVNODIKkKWNA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2p1Zlo4WU9iUzN6d3E3Y3NUQkkyYmJqLzN3CmVoZkdBNlhlZTIybHVUQk9j
 eHk0QUlrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzduMmZ
 BQW9KRUhRcko2ZGpPa2xqOTU0UC9SUXc4VVFlakR4eE9ETFFFK3Zvd3dGdUR1cVA0enVqNDBrbg
 pabHFTZWx1UEluTkd0S3d3ZWtHeU5mbWVNNUpTYk1Xb1dJNUFXVGkxRGRJVG50YVJhb2ZHQmM3U
 VEvdmpPUHAzCk9Za1dQencxM2NGbjZabnpnbnZlM3JkZlhyK2ZOb0hxaHgvcXlucThXZFdyd1lt
 QTVDUXR5SnJRSk9nREgyb2oKUm03YXgzNU5OYlZNNlNXSkZuc1hyTy9MUWNXN3c0MlBYYnpsQVR
 lck9ZZ1BQZXhKRTZRa3QxS3JmRndzM1lDeQoxMjFZL0VzYjFkOEZvcXVRTW0yWVNLNExsOTJ0Ym
 RPRUZCOHJWMTRiUld4WHBKQk9SSVd6VmhNWHh0ZW9kTHRiCjJkLytCdmNmbExZdEF4Mk0vaTB1U
 mYrNjVkZkxicll4anFIbG5VMko4emdQcUNBMGtCY1ZOd25GZ0F1cEM1TisKWmQvUEY4cTh4b2VT
 VTZ6b05Obm15QURRTFBUNG0vKyt5OUdqT252WlFPTFBHT3lZVjhjeHUrbDNKRHNOalRlawpHQ1J
 wQTJGbVBjZTlFVjVEbnY1SnNST2ptTEptYWQvOG0vU1hrMEdHdVF0bG1acElCckhYVTdVZlp2ck
 51VHYyCllod0w1d3dna2Fzc1dEdmV6NDVqTlM3ckhkMms4MUJSLzNIYWZaVWQyWURFZHZyYytKe
 UxOVE1UelVxRUtTSkQKRnlVZ2dxc2NDZDhDenlYQ1c0UVVjalRUdkRDNlA3QWduQVdpcExWajdz
 N3NKVi9lTWpRUDMwZjVyV1dUbzFBawpIaTVZMzhtbXgvVU5zVk5NSUhvYjVwK1lHTG01SXZ0dVh
 BQU5NWXJkWmNyWXRZL0pBQkl3RlJQUElFWUJEbUhPCm56QWh1MFV0YjVnaE5nPT0KPVY5N2oKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add support for high-g detection.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 132 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index daff22ec1f2d..f1d4646b495d 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -127,6 +127,14 @@ static const struct iio_event_spec bma220_events[] = {
 				       BIT(IIO_EV_INFO_PERIOD) |
 				       BIT(IIO_EV_INFO_HYSTERESIS),
 	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS),
+	},
 };
 
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
@@ -464,6 +472,34 @@ static int bma220_is_tap_en(struct bma220_data *data,
 	return 0;
 }
 
+static int bma220_is_high_en(struct bma220_data *data,
+			      enum iio_modifier axis,
+			      bool *en)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMA220_REG_IE1, &reg_val);
+	if (ret)
+		return ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		*en = FIELD_GET(BMA220_INT_EN_HIGH_X_MSK, reg_val);
+		break;
+	case IIO_MOD_Y:
+		*en = FIELD_GET(BMA220_INT_EN_HIGH_Y_MSK, reg_val);
+		break;
+	case IIO_MOD_Z:
+		*en = FIELD_GET(BMA220_INT_EN_HIGH_Z_MSK, reg_val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bma220_set_tap_en(struct bma220_data *data,
 			     enum iio_modifier axis,
 			     int type,
@@ -509,6 +545,35 @@ static int bma220_set_tap_en(struct bma220_data *data,
 	return 0;
 }
 
+static int bma220_set_high_en(struct bma220_data *data,
+			      enum iio_modifier axis,
+			      bool en)
+{
+	int ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+					 BMA220_INT_EN_HIGH_X_MSK,
+					 FIELD_PREP(BMA220_INT_EN_HIGH_X_MSK, en));
+		break;
+	case IIO_MOD_Y:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+					 BMA220_INT_EN_HIGH_Y_MSK,
+					 FIELD_PREP(BMA220_INT_EN_HIGH_Y_MSK, en));
+		break;
+	case IIO_MOD_Z:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+					 BMA220_INT_EN_HIGH_Z_MSK,
+					 FIELD_PREP(BMA220_INT_EN_HIGH_Z_MSK, en));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
 static int bma220_read_event_config(struct iio_dev *indio_dev,
 				    const struct iio_chan_spec *chan,
 				    enum iio_event_type type,
@@ -548,6 +613,11 @@ static int bma220_read_event_config(struct iio_dev *indio_dev,
 				return ret;
 			val = FIELD_GET(BMA220_INT_EN_LOW_MSK, reg_val);
 			return val;
+		case IIO_EV_DIR_RISING:
+			ret = bma220_is_high_en(data, chan->channel2, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -589,6 +659,9 @@ static int bma220_write_event_config(struct iio_dev *indio_dev,
 						 BMA220_INT_EN_LOW_MSK,
 						 FIELD_PREP(BMA220_INT_EN_LOW_MSK, state));
 			break;
+		case IIO_EV_DIR_RISING:
+			ret = bma220_set_high_en(data, chan->channel2, state);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -662,6 +735,32 @@ static int bma220_read_event_value(struct iio_dev *indio_dev,
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_DIR_RISING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF1,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_HIGH_TH_MSK, reg_val);
+				return IIO_VAL_INT;
+			case IIO_EV_INFO_PERIOD:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF0,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_HIGH_DUR_MSK, reg_val);
+				return IIO_VAL_INT;
+			case IIO_EV_INFO_HYSTERESIS:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF0,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_HIGH_HY_MSK, reg_val);
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
 		default:
 			return -EINVAL;
 		}
@@ -727,6 +826,32 @@ static int bma220_write_event_value(struct iio_dev *indio_dev,
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_DIR_RISING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				if (!FIELD_FIT(BMA220_HIGH_TH_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF1,
+							  BMA220_HIGH_TH_MSK,
+							  FIELD_PREP(BMA220_HIGH_TH_MSK, val));
+			case IIO_EV_INFO_PERIOD:
+				if (!FIELD_FIT(BMA220_HIGH_DUR_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF0,
+							  BMA220_HIGH_DUR_MSK,
+							  FIELD_PREP(BMA220_HIGH_DUR_MSK, val));
+			case IIO_EV_INFO_HYSTERESIS:
+				if (!FIELD_FIT(BMA220_HIGH_HY_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF0,
+							  BMA220_HIGH_HY_MSK,
+							  FIELD_PREP(BMA220_HIGH_HY_MSK, val));
+			default:
+				return -EINVAL;
+			}
 		default:
 			return -EINVAL;
 		}
@@ -891,6 +1016,13 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_FALLING),
 			       timestamp);
+	if (FIELD_GET(BMA220_IF_HIGH, bma220_reg_if1))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
+			       timestamp);
 	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
 
 		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)

-- 
2.49.1


