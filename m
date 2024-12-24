Return-Path: <linux-iio+bounces-13783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611EF9FBF32
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E211884F0E
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235041D959E;
	Tue, 24 Dec 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Q2etoBsN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442151D90AC;
	Tue, 24 Dec 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050643; cv=none; b=n8aTO7U7CdlL15mbp0hau8PHWbvf/plWlwEP90IyIUBL5LEOlX+6K3JlnxLRKBh5+LPbo7cMwX8XnvLM4XJetNodTrBG9/eGX0wGhKTTQqNnNV3sps4RiB1LQ4lPOp0WYH8tYHfrSI9YxAEcluZNuclZlQFQ1dJ2iZLQdw9ynBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050643; c=relaxed/simple;
	bh=6M9NjheTSV6KwlUuO5B/7sO5xnqIgWYhWYAx0DF03No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdGFfylKwhGIQYkhR+Plqw9X0FwyLfoQyLrGdWqYB2hJOjgWqgsfOpHA/6rmL6Um8jHo12qwQXBoJniaj3PwCMXa8CtIPnajp8XYoectjH2Aor/SOyy4Jc0Fo5+M4FCn8Q9WtOmqf527yQfeIAvP/k2UVJKZt/DpkiwYNNHQLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Q2etoBsN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaeef97ff02so118952966b.1;
        Tue, 24 Dec 2024 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735050640; x=1735655440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdy6SZd8FG0XOydpfx03ysjyzRhbHoW5G6enWzLPqXA=;
        b=Q2etoBsNhXr/C+ZZpvCWDjU/6N6d+cePGTm/BYSc0+9wN0e0ZTLKFqi4h6nPi+AdoF
         9axamrQKn5vuW2T7TFNFxSzelUtUSZ3h9TFkVw7KsdX3aLsFKnt0rgCn4W0x0z55kOIF
         JbRdcdWwYfiZKWhlsneljOE0o9gT9U0PTyy91fWGH3DuWmZrzyJpKl4wjO7y11SADPoE
         eNVuyD2RK+LbF6FmfJPHxIKh/8vidD3xhJclhjS4LR5t3urC3kqZe5R3vI7UJerbsgR9
         7Q15RV5LkPHFlapDTGtj1RGp+3MsBm1xXir+TO33TdvjEXBpwWq6Yj0FcHs0RWc9Qyjc
         k8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735050640; x=1735655440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdy6SZd8FG0XOydpfx03ysjyzRhbHoW5G6enWzLPqXA=;
        b=IVsrsFMcGbyRiLOY6eFgG14Z7pfTXmI/+abv66LETSA/oaETXDlvm/HGBc1xWevTVx
         WccMGoP7zJJ1CfoWYdsncR7S873EnDzsnU6XR1sesHF9Ci4rQp0cBEC2XaJQKca4FSAo
         lQrC5jeiyloBCT9X2ymDckkez0pdNar5HS2Db1X1lbO3L/Xvn8uDvacBYJcJQg1J+MFk
         JyEbh4E5guiI3MXpPi+ieiYdv/3j6v1qw9xdsFQj1UenbcVXUR4C5nK3D0+5RURUGk0R
         VLUySxQYS5A0oDHuwrveG4tBXYuEcf/X4izK9BLFvdnFGEFpYE61QBLztTM4LpELHt6q
         h2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCX4YAcTjo6MvbjHh8kUIoKnjFAAYndVHV6eonQ/OCMUdotKdf5OAxHTaXvnCTX08y9S6a/d9fRrP2+1el0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx5+K4zDKmXEiNmr/A7GQYXNJfnQtgbPUVHGowVeUfPAetjMcW
	222hWPHD8yhlLxFfEryueDsBiGOuQYPL66NeiJBLYpQyXLFfK3Q4saQ07A==
X-Gm-Gg: ASbGncuqn90AV29iS0fTFOF97sHu4AsKatpIboO+s+xUd3nB1ROjMUFXvDKrJ73ejy+
	MYWcIza9dWSdA8P+oX1+spJuuGA55YEl/wfWNZN8J0C9wg2FnbcYdLX0tlWu4ky/U/r9NKBJ/fe
	ccHQGYByXm4qxL++Z2rm2Fi+nxlX5ef/VhGr9NLrAoBki+kWJ+y6hix7ehjGKKiYwDp/sOMPb5V
	Bj1I0J6oHx1APqVLb5M3aY5wSrwiiSYqYu6cpXyCILeeV2wl0+m97ZW8+ndZTmraazCrkBUuIWi
	OmgqNAnHT9PWVtFxdh99RHfyXyhdspXRYXYvcitDoYMYxSTtteTV3bOA1d+ZmkZ2HanK6LnNb36
	rj/5/k1g=
X-Google-Smtp-Source: AGHT+IF+RA6pGEMNPeEIvtinon7wnHw8ZYLmyQnZK7PR3NdDBs1HQuAtj3EPBYyccO1+vDKHN6vReQ==
X-Received: by 2002:a17:906:f59d:b0:aa6:9372:cac7 with SMTP id a640c23a62f3a-aac334c1628mr1727003066b.31.1735050638526;
        Tue, 24 Dec 2024 06:30:38 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-a5d7-4700-0000-0000-0000-0e63.310.pool.telefonica.de. [2a02:3100:a5d7:4700::e63])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0eae74e4sm658827166b.91.2024.12.24.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:30:37 -0800 (PST)
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
Subject: [PATCH v2 2/3] iio: adc: meson: use tabs instead of spaces for some REG11 bit fields
Date: Tue, 24 Dec 2024 15:29:40 +0100
Message-ID: <20241224142941.97759-3-martin.blumenstingl@googlemail.com>
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

This makes them consistent with the rest of the driver. No functional
changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 4cfbb3482a2e..469af3c57066 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -155,10 +155,10 @@
  */
 #define MESON_SAR_ADC_REG11					0x2c
 	#define MESON_SAR_ADC_REG11_BANDGAP_EN			BIT(13)
-	#define MESON_SAR_ADC_REG11_CMV_SEL                     BIT(6)
-	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE                BIT(5)
-	#define MESON_SAR_ADC_REG11_EOC                         BIT(1)
-	#define MESON_SAR_ADC_REG11_VREF_SEL                    BIT(0)
+	#define MESON_SAR_ADC_REG11_CMV_SEL			BIT(6)
+	#define MESON_SAR_ADC_REG11_VREF_VOLTAGE		BIT(5)
+	#define MESON_SAR_ADC_REG11_EOC				BIT(1)
+	#define MESON_SAR_ADC_REG11_VREF_SEL			BIT(0)
 
 #define MESON_SAR_ADC_REG13					0x34
 	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
-- 
2.47.1


