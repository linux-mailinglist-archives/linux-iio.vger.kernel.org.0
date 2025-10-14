Return-Path: <linux-iio+bounces-25060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4033DBDAAD1
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B6754FC5F9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59256305061;
	Tue, 14 Oct 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="AmheMPa2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF1303A2F;
	Tue, 14 Oct 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460209; cv=none; b=uEMEjRkOzk30Rf3TJq7n472YMlqW8EPVwOZn1NA6kEQA8UQ1XeiRHytN7lYEIxmdah+KGQL3YaUflT6iluRE1nSQ3in8HorlCBhA2WvHYRuK871w7ipQV5eozUduCrWQCRp294Uil05jv/nxkK/6eG8LvF2DOqACodit2a7GDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460209; c=relaxed/simple;
	bh=+qzvf2SUrf6G6/lZgkL2owRNfuo8+LwSwVi+jGVDeiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9k2UGh1K5dYN74ZxCYF6JJaD1pvT+wmTjr6RoUWCowBMcUU4aPj5bELSdW+DhA+R8pBnNtxKYoM/gl708qqSXQWOkHXSZmtV4x6PKvINc2fiOBX7tYvgCDYu1aBIJy8Ho7TUND+SRGmqUenFtPOHpBwV0AQzqx1yC4GyNBiAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=AmheMPa2; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2A1DD173BEE;
	Tue, 14 Oct 2025 19:43:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760460197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eAAhdLuwXraHXXsOTtTA8hVvW90BoSNfLBGXUUAsdo=;
	b=AmheMPa2wkzoLyZLlgPZmBiFrfdBNpNswJLJbC/RqbMQDtsMA5qGEhXC/AKXBytqVJ4qeI
	fU+FtrTY6behU46LTSKy+KHkm7TLnVR67xNVj7skWi2v/nJaS4mIkdRZ1eg0hAgg6RR5kH
	aA7C6A7ZmzXFMjvXwSPEUoyJoiShaSKJ2J2njbvJ0ljLYyrQAg0SbbVyAxl567P9h+rezN
	vrAPb4Is+fc49JKtF87vw7aIa/ake8sptILooBFLvA9/tpvWlJUgVa9Xm+3dUY0j/Eo7si
	JlmOBt98Wecrx9XR+yfm6lwRQWHdGeN5NOS0CcVS95sxxNwe5dDqrmX1sypyeg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Tue, 14 Oct 2025 19:43:02 +0300
Subject: [PATCH 6/6] iio: accel: bma220: add any-motion detection
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-bma220_events-v1-6-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
In-Reply-To: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5410;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=+qzvf2SUrf6G6/lZgkL2owRNfuo8+LwSwVi+jGVDeiU=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2p1ZmFBZ0NuVDdqaHpTa2tlQUplazY4V0czCjhscnhWczdFMitPQTdScDdr
 aXViMklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzduMmd
 BQW9KRUhRcko2ZGpPa2xqYkRrUUFLZUJGSVR3QlJYalBhcFhaMnA0V1BFa0laRENuRW1mcTdpRg
 pYM1JCSzBtdkpSYW9PQzl5VktkbGd0WHlheVcySkdqdHJQbzNaK01IQ0dmRUNFNy8wV2xFNXZWW
 XUyUEtZRExHCnNaRHpzeThVUENXREJIcTFyamNMWE9qWlE1NFVZWHE5cHFFL0tUbzFLcXBQa2lj
 QkVjTVEzaGJ6RnlLUU5lUUUKYzl0OERpMFdORmN5b25IY3pYWXpocTFHTE5nbVVvMTJBQWZuaHd
 3eE1sLzRXbTh5dWZtdEx4NER1YTFFNGMrRAovcTlFVFBVYnVkR0JtU1FGN0ZmMFZSSlRzT0xQOF
 ZETUk2QlUra00wSDRhcWt5SXA1TXI1SnlhMlNJVTIwcXorCllVa0pMMG9JcmE4MllreDM2UTNRN
 zJ2aUlvWTJqVDJTUk1zNUl0WlRKdjc5NVdxbS9wdVR0UlhuZEhmaUkzeUsKRS95b3hRb3Vwb1lE
 VFF0Q1prN3h4K2VCWDRuNzlGK1h5cWJSbzlWUElTSVRHZjZqdXhiUmcxS01nMEp2R2diSQp6di9
 oUWFHb2x2NGdNWTREVEdUczJ4RDZQbHpuMWpod1Y5elRpdnBZdnh0RUVaTVozOWw4UkQ3ZHVCV2
 94MUp6CnFzNmhBSFlpWUk5YmEyZmhVVTdnTHhYVVM5Und4NFU1cVl0Zk5rSS9rOVB0NTdvRGFhV
 kFhN0F3N095Z1ZkVjkKdEhrU2NwelFGWThxZVowbjBlbWIvQngvZklDUFRFZksrbmNFQVJtRlZK
 S3dWUTl3U1Q0VHErSDVFdElkYzlaVQo0ZE4xbmdjYzdjc212SkRlaVVyVnJtOVFCWUpKMzNOSEp
 janhSWHZUeTNWNitkQjdkVmgwdnNPbENsaDlPczBQCk5hV3ViMnBicjlZZmp3PT0KPTA2akEKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add support for what Bosch calls "any-motion (slope)" detection.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
I think Jonathan remarked that this might be improper use of the iio API?
please advise.
---
 drivers/iio/accel/bma220_core.c | 116 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index f1d4646b495d..f79901ae8786 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -135,6 +135,13 @@ static const struct iio_event_spec bma220_events[] = {
 				       BIT(IIO_EV_INFO_PERIOD) |
 				       BIT(IIO_EV_INFO_HYSTERESIS),
 	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+				       BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 #define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
@@ -500,6 +507,34 @@ static int bma220_is_high_en(struct bma220_data *data,
 	return 0;
 }
 
+static int bma220_is_slope_en(struct bma220_data *data,
+			      enum iio_modifier axis,
+			      bool *en)
+{
+	unsigned int reg_val;
+	int ret;
+
+	ret = regmap_read(data->regmap, BMA220_REG_IE0, &reg_val);
+	if (ret)
+		return ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		*en = FIELD_GET(BMA220_INT_EN_SLOPE_X_MSK, reg_val);
+		break;
+	case IIO_MOD_Y:
+		*en = FIELD_GET(BMA220_INT_EN_SLOPE_Y_MSK, reg_val);
+		break;
+	case IIO_MOD_Z:
+		*en = FIELD_GET(BMA220_INT_EN_SLOPE_Z_MSK, reg_val);
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
@@ -574,6 +609,34 @@ static int bma220_set_high_en(struct bma220_data *data,
 	return ret;
 }
 
+static int bma220_set_slope_en(struct bma220_data *data, enum iio_modifier axis,
+			       bool en)
+{
+	int ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_SLOPE_X_MSK,
+					 FIELD_PREP(BMA220_INT_EN_SLOPE_X_MSK, en));
+		break;
+	case IIO_MOD_Y:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_SLOPE_Y_MSK,
+					 FIELD_PREP(BMA220_INT_EN_SLOPE_Y_MSK, en));
+		break;
+	case IIO_MOD_Z:
+		ret = regmap_update_bits(data->regmap, BMA220_REG_IE0,
+					 BMA220_INT_EN_SLOPE_Z_MSK,
+					 FIELD_PREP(BMA220_INT_EN_SLOPE_Z_MSK, en));
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
@@ -618,6 +681,11 @@ static int bma220_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en;
+		case IIO_EV_DIR_EITHER:
+			ret = bma220_is_slope_en(data, chan->channel2, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -662,6 +730,9 @@ static int bma220_write_event_config(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_RISING:
 			ret = bma220_set_high_en(data, chan->channel2, state);
 			break;
+		case IIO_EV_DIR_EITHER:
+			ret = bma220_set_slope_en(data, chan->channel2, state);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -761,6 +832,25 @@ static int bma220_read_event_value(struct iio_dev *indio_dev,
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_DIR_EITHER:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF4,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_SLOPE_TH_MSK, reg_val);
+				return IIO_VAL_INT;
+			case IIO_EV_INFO_PERIOD:
+				ret = regmap_read(data->regmap, BMA220_REG_CONF4,
+						  &reg_val);
+				if (ret)
+					return ret;
+				*val = FIELD_GET(BMA220_SLOPE_DUR_MSK, reg_val);
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
 		default:
 			return -EINVAL;
 		}
@@ -852,6 +942,25 @@ static int bma220_write_event_value(struct iio_dev *indio_dev,
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_DIR_EITHER:
+			switch (info) {
+			case IIO_EV_INFO_VALUE:
+				if (!FIELD_FIT(BMA220_SLOPE_TH_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF4,
+							  BMA220_SLOPE_TH_MSK,
+							  FIELD_PREP(BMA220_SLOPE_TH_MSK, val));
+			case IIO_EV_INFO_PERIOD:
+				if (!FIELD_FIT(BMA220_SLOPE_DUR_MSK, val))
+					return -EINVAL;
+				return regmap_update_bits(data->regmap,
+							  BMA220_REG_CONF4,
+							  BMA220_SLOPE_DUR_MSK,
+							  FIELD_PREP(BMA220_SLOPE_DUR_MSK, val));
+			default:
+				return -EINVAL;
+			}
 		default:
 			return -EINVAL;
 		}
@@ -1023,6 +1132,13 @@ static irqreturn_t bma220_irq_handler(int irq, void *private)
 						  IIO_EV_TYPE_THRESH,
 						  IIO_EV_DIR_RISING),
 			       timestamp);
+	if (FIELD_GET(BMA220_IF_SLOPE, bma220_reg_if1))
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+						  IIO_MOD_X_OR_Y_OR_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+			       timestamp);
 	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
 
 		if (data->tap_type == BMA220_TAP_TYPE_SINGLE)

-- 
2.49.1


