Return-Path: <linux-iio+bounces-13782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6259FBF30
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 15:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1ABE164194
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14568192B69;
	Tue, 24 Dec 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XZ1YqM2w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F431D63F3;
	Tue, 24 Dec 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050640; cv=none; b=HmHhFXsxJ7rOVfLPLgx3VOR7COoQlPxqvEVs19LBek0d+a09O7ouEesgB+eY8navBO5tICFuDIMjyLEfM5L6SU/rbWl3VZ9U2jwYXeGL22uG34R5tEs5Rvoe5SHUkk0hlAKRHCERV7fOGEdv+LaioMEwc6dIpPBTefxtAlGULpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050640; c=relaxed/simple;
	bh=GcILu2TSFeCXUdhqnV2Fs1QuVwOARat9oR+UBlq9hvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElLmAqFzMrkAijIo8PQDkPa0hqizQfqoumxU1sb9/3yEBbysXUH720BAG3gDOUvSULpqAMpnZDa69uyVFjYXppLHWHkb4la4ICxB2xuJc2PD2Ek6Bbn3ke2l1zFpOmjYe9Rs8tpUPa+GxIgEqVxCm3Oswui0O6jbxZzcjX32FEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=XZ1YqM2w; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa66e4d1d5aso830811866b.2;
        Tue, 24 Dec 2024 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735050637; x=1735655437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9GoekDoCU0xMxFyd9N4qiMFnHW9OjntIxlAzqCVuPI=;
        b=XZ1YqM2w5j2DIB+i415Zo/RwzRaW2nTxFbze0q+c6A8UebfwzFvvDBcndrBwrAUnww
         d8gcojNP1WdcYgJCHLxGxiKomdMYyhlRe4CudmpNIRMEbL5k/K9JL6Iu97g7UDejSPin
         fFffsJQzvhu9FQxXnj2lC5g5pGllOxPRay5Xe16ClI8GH6AJx5j2pXLqFudsRqFSVkV1
         iCxYEJm8oJSgurVv/+bYAlvSUOW66bZOGEVuJ0II/Q65RWNmJ0QjIy22NmwJ96LReYrP
         8yIlDIU42vL4bKkPQf/h0dn0s6/IkicyG+5RipY4Hcr38gtfUYk1HMpmzsKbYRdG4D+0
         hXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735050637; x=1735655437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9GoekDoCU0xMxFyd9N4qiMFnHW9OjntIxlAzqCVuPI=;
        b=UBULZr4/MtFk8DPbcUVBHTaNsQ/ZnrZSB49CAKrdnNYRZEZtpWBNVrBmvyjUmM/Rqm
         xXmRQSLY+lMGeFr21r6kKIbCC2uk1b3CO9svrcnX1bZrweLVkzOUa8tIPBw6I4m631di
         lOrxcHRTaicY95nXWSE8hGN9H/G3LpAPoMh8YuKmVwA6+fdN+6CJu+r3m/iYzbDEs1bT
         NK6NhaCA47jdj0iAweKoaEvQNr5jd5Z/0jS+LrerpQRmFGVGJMwgVhzAXo644h4JkuBs
         /bwRadEN+DBvosNykuPoTxHsXA9HI0iaw7oD+bBuh5L03HqmkLdamzmE+MMyJVrbpULi
         UQaA==
X-Forwarded-Encrypted: i=1; AJvYcCVftZydCtUSXhprYKN5eSKf6C7HDL8DjoUpeAsx5PYEX17G8wX6LKEDy55N5/GzgbxKLc6bQzbxY0gz9kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbkLyqxb4R2BLBICG8zbFpxsZG6Bbq7aNnBGwofXdsEbXvinJm
	CvwqOAwap84Rb2mjW2sdWeiyOso5e78yjKLkgeswdjebB6uKdSEcobYXQQ==
X-Gm-Gg: ASbGncu5JOC/vnrXNJqrmsPMw85caz6u3qR7xKM+hYcsHncKR3F5bwBXrrsoFVI8xHm
	q+AuBi0jJyXjgfj1iHzObqvHzVsglnpKs1ShBsZZTOipkBqOjtnP+QnAyDHfXwiqabMe3qZ57Yu
	WZuLk1ZXrPMq6rolzlbr8xr5LkVDvxr4AZbI3iEVUJ63ZXNzM/VVorhj0Rf/d/QhA49mtBcr4eT
	5ks7nsPG6LjrSoYPXMOWHwsv89RP4CJqc+dC60oyH4M362agCKdtzNkxi0p+/YA/HrQnHrDzpp9
	ShYG0XhcDjB6fqkYADPnxELFzk+XxMHvrdmrVyUjLxCruBlIkIMpE2EbqM/Z6iwfyCb7FtmWR8y
	EkRL2DOw=
X-Google-Smtp-Source: AGHT+IGhElsQeCU3jdwWZkcauyJOHjacVPTPXhTENgcdJxCU29OOCPEQW7SqtJztuYY6P3IG+jd58g==
X-Received: by 2002:a17:907:2d2c:b0:aa6:8b38:52a3 with SMTP id a640c23a62f3a-aac33787557mr1286928066b.50.1735050636535;
        Tue, 24 Dec 2024 06:30:36 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-a5d7-4700-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:a5d7:4700::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0eae74e4sm658827166b.91.2024.12.24.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:30:35 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-iio@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	gnstark@salutedevices.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	neil.armstrong@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] iio: adc: meson: fix voltage reference selection field name typo
Date: Tue, 24 Dec 2024 15:29:39 +0100
Message-ID: <20241224142941.97759-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224142941.97759-1-martin.blumenstingl@googlemail.com>
References: <20241224142941.97759-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field should be called "vref_voltage", without a typo in the word
voltage. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 2d475b43e717..4cfbb3482a2e 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -327,7 +327,7 @@ struct meson_sar_adc_param {
 	u8					vref_select;
 	u8					cmv_select;
 	u8					adc_eoc;
-	enum meson_sar_adc_vref_sel		vref_volatge;
+	enum meson_sar_adc_vref_sel		vref_voltage;
 };
 
 struct meson_sar_adc_data {
@@ -989,7 +989,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 		}
 
 		regval = FIELD_PREP(MESON_SAR_ADC_REG11_VREF_VOLTAGE,
-				    priv->param->vref_volatge);
+				    priv->param->vref_voltage);
 		regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 				   MESON_SAR_ADC_REG11_VREF_VOLTAGE, regval);
 
@@ -1212,7 +1212,7 @@ static const struct meson_sar_adc_param meson_sar_adc_gxbb_param = {
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 10,
 	.has_reg11 = true,
-	.vref_volatge = 1,
+	.vref_voltage = 1,
 	.cmv_select = 1,
 };
 
@@ -1224,7 +1224,7 @@ static const struct meson_sar_adc_param meson_sar_adc_gxl_param = {
 	.resolution = 12,
 	.disable_ring_counter = 1,
 	.has_reg11 = true,
-	.vref_volatge = 1,
+	.vref_voltage = 1,
 	.cmv_select = 1,
 };
 
@@ -1236,7 +1236,7 @@ static const struct meson_sar_adc_param meson_sar_adc_axg_param = {
 	.resolution = 12,
 	.disable_ring_counter = 1,
 	.has_reg11 = true,
-	.vref_volatge = 1,
+	.vref_voltage = 1,
 	.has_vref_select = true,
 	.vref_select = VREF_VDDA,
 	.cmv_select = 1,
-- 
2.47.1


