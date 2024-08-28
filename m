Return-Path: <linux-iio+bounces-8850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B279632FC
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6461C21ACB
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36641AE046;
	Wed, 28 Aug 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R13QM8Ey"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FB1AD9EC;
	Wed, 28 Aug 2024 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878302; cv=none; b=EuNLvSXjop4JXHjFkqxROQt26HRr5jORyLxuIAXEkT6jk5Tfioah1L5W3DSYvsVbX0tkKn17JqH10g45jAQlY+VzVClFUsm9nOT95gmAZuS87zCGSBx8tYXbfBQrVdZ4dOptqsPYyUsVnuAHiQ+rX/LdzzvxNlFWee2MZmaOy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878302; c=relaxed/simple;
	bh=0iet7D0rlK7q1YjM9WSEX/rBTI0SAhaaIvLj+kxB2Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BU78fCHD2Dye6WYea9WjMDZF3SZLbz8ZlrjxcDDYHngQGb2FkX+Cq1wfWHPc6PTj5r9DuFR2ou1q8m3piyRP3g3eGI/89hDLsAP1NXFU0DYzmIgGwQRxnciydCuCoNlp/dR9LEZtptP2XrcWi3FDSpFrFzRCITkD6a2ZYe6ssvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R13QM8Ey; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff443so8360001a12.1;
        Wed, 28 Aug 2024 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878299; x=1725483099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhIMLJlEIHmwmWp2tRa34XckrWlMANUJGP6JuPKZqLc=;
        b=R13QM8Ey3HPLG+o2nTEG0vEHsFekmLt7MkBGPDZUlhWcLtcq+yFbxYRnL2KlPHnQKy
         DZgH+W8GfrwFVwBQNkJlkoRHXvKUkuNNlmeLbqCw2kOj2EY4STZDRO6SqP6o3oA2sESa
         Y89YR0wYacfRI/x7wjKHkkFPRa5GFrtu7kYwem03zOVA5yz+1rc7gg4csfVnb1K7FXqF
         eUnpOr6MuQtmLWhSruD9lzf1NSv0shiRpbSrE65CVvuPDDZ8bNcNVvLPtmyJrF6ILAt8
         u/nmkhCVNn4eybphgVhjo8KYwB90XadY0VGSg/q/a7iOLKACazsLg82CipoYUxGh7Bso
         a0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878299; x=1725483099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhIMLJlEIHmwmWp2tRa34XckrWlMANUJGP6JuPKZqLc=;
        b=s4zURjwuLiqmTyU0wcs22jvpq4hpyhXc8lHDWJz00M+rGz3lJcZl2mvrA91MDn71uE
         88EBedZG6HwPd1JwCrb8+PIqPayYrSFVqFWQw7d9OHBmwc/CTqJoYm7Fy3c1xd4tHZ6X
         BX092hUyVx/EeMDlFwwPE4hZAXTbvqdWsLA/bPdDD70S0CDlOtLFVkYt/vRNnouWVvCb
         VS+t5lfcyXVZPzMVxmwbvwKy0cvAzjf1gQnVlRwH0wKCqC2TAnCOynNSFu2UYsk3qAaO
         sy+N+38zCwe8NUB1hPmGEIF4eaVVsjlu4NNJSwe5YyKJEp5YMk/VFsvuhIjwb95Ai2iT
         rD2w==
X-Forwarded-Encrypted: i=1; AJvYcCU7DVlVugGc46IilZ/5Xqn0YcqmppQAUvd4fPlxLXmNbkcIlpKC9IUs8mBTVBrtsYBLlXQQujhW+uV+3j1I@vger.kernel.org, AJvYcCWdxDMGKMnf3abrHxHn1fBSxReAfXapwpbJP0ykgW7/knLuGuRy7W8Njlspoy37ZZp3Do8jlKhvQbWg@vger.kernel.org, AJvYcCXttqTeNmaTvtrCkZ4e9iMzBPJZDu/5yhEkSxYSDf/7tYM70JTwfp9Akd2FpJNNZXZRtmahrBZ9G65d@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2GHhwBlPLQxsLV5zi0hCnagfW8bGWKJ6xXuec6Gzd6V8ixfk
	fl40JUCGxZUlSNcwxYt/BUuyY+9PpfrGcTRVCbvEMpol76KyJ/qn
X-Google-Smtp-Source: AGHT+IFLyEkG91DwnEIVHhppVs5RZ9UJUlnFzgtkC9ODeVltQEq5VEf9924E2lA+nbkXJmpVH9u1yg==
X-Received: by 2002:a05:6402:2714:b0:5bf:c8:774 with SMTP id 4fb4d7f45d1cf-5c21ed4085bmr573646a12.15.1724878298515;
        Wed, 28 Aug 2024 13:51:38 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:38 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v4 3/7] iio: pressure: bmp280: Remove config error check for IIR filter updates
Date: Wed, 28 Aug 2024 22:51:23 +0200
Message-Id: <20240828205128.92145-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828205128.92145-1-vassilisamir@gmail.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is a change in the configuration of the BMP3xx device, several
steps take place. These steps include:

1) Update the OSR settings and check if there was an update
2) Update the ODR settings and check if there was an update
3) Update the IIR settings and check if there was an update
4) Check if there was an update with the following procedure:
	a) Set sensor to SLEEP mode and after to NORMAL mode to trigger
	   a new measurement.
	b) Wait the maximum amount possible depending on the OSR settings
	c) Check the configuration error register if there was an error
	   during the configuration of the sensor.

This check is necessary, because there could be a case where the OSR is
too high for the requested ODR so either the ODR needs to be slower or the
OSR needs to be less. This is something that is checked internally by the
sensor when it runs in NORMAL mode.

In the BMP58x devices the previous steps are done internally by the sensor.

The IIR filter settings do not depend on the OSR or ODR settings, and there
is no need to run a check in case they change.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 193a8fcbb5d8..2ca907771d42 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1562,14 +1562,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	change = change || aux;
 
 	/* Set filter data */
-	ret = regmap_update_bits_check(data->regmap, BMP380_REG_CONFIG, BMP380_FILTER_MASK,
-				       FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff),
-				       &aux);
+	ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG, BMP380_FILTER_MASK,
+				 FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff));
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
-	change = change || aux;
 
 	if (change) {
 		/*
@@ -2159,15 +2157,13 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	reg_val = FIELD_PREP(BMP580_DSP_IIR_PRESS_MASK, data->iir_filter_coeff) |
 		  FIELD_PREP(BMP580_DSP_IIR_TEMP_MASK, data->iir_filter_coeff);
 
-	ret = regmap_update_bits_check(data->regmap, BMP580_REG_DSP_IIR,
-				       BMP580_DSP_IIR_PRESS_MASK |
-				       BMP580_DSP_IIR_TEMP_MASK,
-				       reg_val, &aux);
+	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
+				 BMP580_DSP_IIR_PRESS_MASK | BMP580_DSP_IIR_TEMP_MASK,
+				 reg_val);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
-	change = change || aux;
 
 	/* Restore sensor to normal operation mode */
 	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
-- 
2.25.1


