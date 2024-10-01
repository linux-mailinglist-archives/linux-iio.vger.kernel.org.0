Return-Path: <linux-iio+bounces-9979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19898C6BF
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947E9B2238A
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A26A1CF297;
	Tue,  1 Oct 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzeSNhrk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641111CF287;
	Tue,  1 Oct 2024 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814114; cv=none; b=lpDtMO7peJlF18Tc859isJqa2TXWzYQYO7W61gI3fsh2gf7w3zb/FYaic73u02sGAFJwU4aImoudNckSNR+C5XcAFgqGnJGNslaPfAY31U6vAnuzn/xylLQMng1B3CYdtftAYSHAMHGiu6M4w/wruELVfn+fqRJ5mHR4Jm7MWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814114; c=relaxed/simple;
	bh=xgxLh+rAz89buZ/oPb9iuOaqEqfTt0zyVA8NpMpdP5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXh/xk3vJ/HtGU50hO485fcMR/DoAcskkMBGqbIUpxqd0ZdVAeDhgUze9hvBA4DtJscBI+pIfV9uWDdlHWSUbH0kjbjMSV9IwK2BgFLz3Db51EkDimjplc2lKzllOowUUxaeCtuEafJwNdUcf1/eJRV7TVLt785WThYl88NVmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzeSNhrk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cc8782869so54982995e9.2;
        Tue, 01 Oct 2024 13:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814110; x=1728418910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKpfX4jd/6xZA26W9u5SbrDdfUvg83IHr89HZKnf32E=;
        b=PzeSNhrkkQ5foGLU4XgkW0GVtwk95qFPmMR08Qp5rAZxDwmdYoM4mFuPLZQd42a7MH
         7AWIaFXJeIQnENfQiDwrtKIEoGeCLYbhIIbSDW1pFlRpUbRkzuvRMA0fg/yJx4pP4gdg
         FD/Be8utJWr1gfC4DW/ZeJK/DHY4cax/zIEvyBjO2YFus6Kie/B3HfktNABlNEriMc3C
         zoj2RbbBDdeNrvgPwbP/+RwJ2tSnDtrhqkp+6xZMst5pl4oAk3pLtxXhOdNIP/TCVO/S
         6ZLZvNIeFDpfr6K2LEmmF8cOO8CqxdhA3jK9L2ZNhMoDoU4gU77zejbzfGsi9bssFoP5
         p5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814110; x=1728418910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKpfX4jd/6xZA26W9u5SbrDdfUvg83IHr89HZKnf32E=;
        b=o7WQdELTEnxGrwiKqrSLTLB5MvwHtBZN11wC8ER1EWzl00psmEXjgv+x9WWH0Q64bO
         ZFBHrH0ahbGYxP3DsSfYYq+OjznHUmrfIBYVd8/1zWRiVk+ex8EoSzd1bEymvq67SCpo
         +B2jR8y4SJm5piWUXKZLdfpBehCGP7RRYEL03hM7UXQ2WHiqM7OMEdd1J/y31/IScZVo
         FsvRhhFJeJd2n6lsTax0IoU1JWr1yQq99mttXUZlZ7VjaQskX8E5OFfoozg0LxBPxcVH
         /V5suyjdtbz7HMk7fg1AJwMn+cMHXK9ww2XIWvVLs6x4O7/c9NWqNLEVbOOm5q76orRb
         9DgA==
X-Forwarded-Encrypted: i=1; AJvYcCWEOklxUbDm0rmnfylnrcuggYq+rzbRPP7s0GPm9SPGSIAXmzbB9jln1/iGaJIdRh0T5X0qR/hvOkBG@vger.kernel.org, AJvYcCWcE0USEN0T+cC++fQh7d0noAUSC3/NJvUw2Vw0LxLjJkn8lsUSWNOdrY/rA/7amIVOuNZsmHVqU2q+1NFH@vger.kernel.org
X-Gm-Message-State: AOJu0YxPG8PTDMfiK2Zfe6IKcM5K8nx57Uteafaa7O9keIILKSYgc5B3
	dvq+Ju94BiYIvj/KkyHF2I5IXc5ijCfxRNHUlL+zSqPlhTyclrQnNpmGkG34
X-Google-Smtp-Source: AGHT+IH+xZ06kSpbFzz1J/U1jWJri+7DC5+I0vCOTUnE16ElPXoMisXkskG82QwmBGspp8y+V/moRQ==
X-Received: by 2002:a05:600c:1d9c:b0:42c:bd27:4be4 with SMTP id 5b1f17b1804b1-42f7936bf09mr1435015e9.8.1727814110410;
        Tue, 01 Oct 2024 13:21:50 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:49 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:17 +0200
Subject: [PATCH v3 4/9] iio: light: veml6030: add support for a regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-4-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=1203;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xgxLh+rAz89buZ/oPb9iuOaqEqfTt0zyVA8NpMpdP5M=;
 b=Kb7WMcoe4jq1SIKn27ycLgVdEsX0zrNGY3hHW+vYCr1gost4wlbG+Y3UIw73/xbqZ6MxSmy3x
 vDMP+s/LzScBaVPny1BOGsnQevKvevH4+GqeaCl54c0MrVsyaOt3NWe
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the device managed function from the regulator API to get and enable
a regulator powering the device.

Use "vdd" as the ID to account for the provided name in the datasheet.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6646fe2e74a7..72c1988e48e6 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
@@ -807,6 +808,11 @@ static int veml6030_probe(struct i2c_client *client)
 	data->client = client;
 	data->regmap = regmap;
 
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to enable regulator\n");
+
 	indio_dev->name = "veml6030";
 	indio_dev->channels = veml6030_channels;
 	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);

-- 
2.43.0


