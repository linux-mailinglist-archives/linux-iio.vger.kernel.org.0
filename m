Return-Path: <linux-iio+bounces-25059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C25BDAAF5
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6883E193E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E730498F;
	Tue, 14 Oct 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="1UReMpW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A999303A02;
	Tue, 14 Oct 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460208; cv=none; b=TBGzyke4Go7Uo5n5nyLBURPBiP6sa6WGUSLq+PZhBMXiXxFtezR5fTVkL/N0rvl+aGCY0g/f9uljFnBmH5jazzrwP+oGWQ0QJR147vLMdk81xMMp8Ksae9j3cam9I8Z2qz/9wda+hQpNw/YGI6FEBtw5P/Ma4yBNT2ZnS3w3dHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460208; c=relaxed/simple;
	bh=D9z3XpVae0nf7d0iRy14bWlufd2/RK/Cizthm/2+Jmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CBFKgahmT5l3foLTcjrTbBxbqXlPJyhJQZkyIpJ1M7Zgh3vCaVXlEvEcMG2lw4PRSA1y26CwHo30nA6OKHwXG9948zPow09kA+FZK/bTREDGBhWeFV0EWsNE1wciw51PnrIOIzKp3ZQfLMULIOakcfix3KkAV5zMKcDAjZBpT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=1UReMpW2; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 80309173BEC;
	Tue, 14 Oct 2025 19:43:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGVY7e1J+RldtRlcUKHLNFl6mqwK5VYBRoFH2nRpKt8=;
	b=1UReMpW22kYQmZCeCtSe35c0v3h5+7OpwZElnDF6bp68gOBeoOcZw/ozGiWF9VcBPiN8/K
	IM5s8AuEI0Bt63jrHMLB8Xi7jMdwOqY7vhq3M3cyr6EULJh3J/WIllCheLY4XF4HU4lmBX
	5UXxCqe7Ea+ZafoSRMgKmCrh/czaR9OuMf4TUXJz3zEQrFcwEiSXqhUmlitnEzK7wufHfz
	+oabj9OOfA2R6Oe7Zn80KCxiHYnYSd+ESBRbuxitjxri8l6LNanVlLdw/8U8HYZqLjkl7y
	N6+XTPoU/3F5VHhTiCfRX5RgOJJ1MLWOyA7P80Xq1fr8jQOrUVaUVqdJeH2/Yw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Tue, 14 Oct 2025 19:43:00 +0300
Subject: [PATCH 4/6] iio: accel: bma220: add low-g event detection
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-bma220_events-v1-4-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
In-Reply-To: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4606;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=D9z3XpVae0nf7d0iRy14bWlufd2/RK/Cizthm/2+Jmo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2p1ZloxZ0ljUHFlMy9DVjI4U2hiK3NvZzNHCkNsMHZHM1VIYjl4NS92SU41
 SzFaUVlrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzduMmR
 BQW9KRUhRcko2ZGpPa2xqRC9FUUFKRWFZbGN0cjkxYVlBV3JjT0NTeWtPRXppMFgxQ29WbXlmQQ
 pXWktGRC9yR25BeG01NHJZVkJaVEFQSGVJcjhPb0NwNHJsMHEvTG9JcjMvWGQ0YnRNdjRkQXdic
 TI4RGxlQ0FwCmQxTU5UNFc2UlJ1UmpEZ1BQWnIxWHNRWVhlcDFzYjkrT0xOaEFKMVBnaUxHSnJZ
 QkNOS3ZWVGYrd3lCTlZaNWYKQ010QmNpZno2bEVYSmhXZWhZbXFpeUs2dHlwZ0xwMUR5Y1ZRbGp
 5bENFS1lJcnJWUGVmOVo1ajQ1dTlyZ0N4SwpnTEpvSmNrNlVTSFdLODVKaUh2aWxkNGF2Z3c5L3
 lzMlVKT1ZJcTRNbDA3YmpYajBDL1pkZWlzbE45azdscFhECmdqdmhvdFJndVRtUDRkSkM3STFoV
 0FWZUl3UDRJNFBXMGd1VHEvSkVha0R2bi9RWjM2bmhtUHRQbnZ0Z2dPblEKTkpGZGhMZ3oxZHBE
 TnFEeXVjaitwTHBSYjZnUHdYTmlXQ3ZrdGRDRTVhT005VGJtYVI3eTZ6emc2cGtrN2x3QgpMZGl
 LMVFOWUFWa2Jkd3lURm5kZTMyb004OHlibXpzVW9wbWo5Ly9NcGFNZ2ZYZENrL2EyWFN6YjNQRD
 ZlSkc4Cm5Ua2cvcnFNRDN4cTJDUVFqb001YlJ3TEpJRDk2RW1zcGxrNGRpeDQ0R1Zrck9tTjhBb
 lA3VnZiS3Uwb2hGbDcKVVp3OTc3bThlUjBEY1hvU1VNZDl2K1VFZ3FyNElvcUQwTXN4VUdmendv
 WS9TQUNxNjRTRzNjMnZIOTVPbU9pTwpTaGdQUEFFTVkzaG15VWo2MXhMS20vcDAvd2RhbUoyTEl
 SK05BZnkwdDZjOXF2MEJjNXlsaEFkUUVCOG5PUDJMCnhmcENtOStjc2tNa3h3PT0KPSsvei8KLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add support for low-g detection.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/bma220_core.c | 101 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index c4bebf3e5548..daff22ec1f2d 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -119,6 +119,14 @@ static const struct iio_event_spec bma220_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 				       BIT(IIO_EV_INFO_PERIOD),
 	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+				       BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD) |
+				       BIT(IIO_EV_INFO_HYSTERESIS),
+	},
 };
 
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
@@ -509,6 +517,7 @@ static int bma220_read_event_config(struct iio_dev *indio_dev,
 	struct bma220_data *data = iio_priv(indio_dev);
 	bool int_en;
 	int ret;
+	unsigned int reg_val, val;
 
 	guard(mutex)(&data->lock);
 
@@ -530,6 +539,18 @@ static int bma220_read_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(data->regmap, BMA220_REG_IE1,
+					  &reg_val);
+			if (ret)
+				return ret;
+			val = FIELD_GET(BMA220_INT_EN_LOW_MSK, reg_val);
+			return val;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -561,6 +582,17 @@ static int bma220_write_event_config(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_update_bits(data->regmap, BMA220_REG_IE1,
+						 BMA220_INT_EN_LOW_MSK,
+						 FIELD_PREP(BMA220_INT_EN_LOW_MSK, state));
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -602,6 +634,37 @@ static int bma220_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_FALLING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF1,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_LOW_TH_MSK, reg_val);
+				return IIO_VAL_INT;
+			case IIO_EV_INFO_PERIOD:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF2,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_LOW_DUR_MSK, reg_val);
+				return IIO_VAL_INT;
+			case IIO_EV_INFO_HYSTERESIS:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF2,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_LOW_HY_MSK, reg_val);
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -636,6 +699,37 @@ static int bma220_write_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_FALLING:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				if (!FIELD_FIT(BMA220_LOW_TH_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF1,
+							  BMA220_LOW_TH_MSK,
+							  FIELD_PREP(BMA220_LOW_TH_MSK, val));
+			case IIO_EV_INFO_PERIOD:
+				if (!FIELD_FIT(BMA220_LOW_DUR_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF2,
+							  BMA220_LOW_DUR_MSK,
+							  FIELD_PREP(BMA220_LOW_DUR_MSK, val));
+			case IIO_EV_INFO_HYSTERESIS:
+				if (!FIELD_FIT(BMA220_LOW_HY_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF2,
+							  BMA220_LOW_HY_MSK,
+							  FIELD_PREP(BMA220_LOW_HY_MSK, val));
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -790,6 +884,13 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 		return IRQ_HANDLED;
 	}
 
+	if (FIELD_GET(BMA220_IF_LOW, bma220_reg_if1))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
+			       timestamp);
 	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
 
 		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)

-- 
2.49.1


