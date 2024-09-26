Return-Path: <linux-iio+bounces-9800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC6987746
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 18:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778951C22AED
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08B15C13E;
	Thu, 26 Sep 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP8Gal21"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FCF15B55D;
	Thu, 26 Sep 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366929; cv=none; b=BaCYryURFpdJsg+pC5MQLXn1ZrSUJ72S1wBJ8e3mdXqmDdUNh9pfYwoN0dGY6ta46I3Ce45iBTSUu0IpUt5Ri8V/UjYQnEdxf2tOk/CwiGyz4CLzteS/vPvaNHwdN3kXHSnJiJW8ptin9/JeG8C3BZ8LiiwdMFMZQa8UKK+VFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366929; c=relaxed/simple;
	bh=EJRXbPr61KxXV+wd3zzOVNML9/DOwfwUtS+ORGYy5xE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbOeRsdsZ4AKS7iRXY0dndbgBu2ImwslnJGQL0WHUHbc2SFZvQNC7VWe+/WG/q00QGa/NOncoughrbCvf81zPs7ElsoDgZr0NeevSRueEBgn6godKFsCNAdT6WLn/bdKxJd9jUdZUFE8VERB8KdDN3P0hi3dE05nchrsR1JfTF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP8Gal21; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a843bef98so148365566b.2;
        Thu, 26 Sep 2024 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366925; x=1727971725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJWKgDcwHDzRJDVWC4NU1waaLgU2pU4Iy2cHBRbpC9w=;
        b=DP8Gal21TJtIUTGR3anmmJl1DXVk0I6aqhKdiDgP6M4ds2JZsK/hX6JUevnuY4a2vi
         v/JSvOCwVl+BhZ8DyEwVyFMYMDQYq7g4GdP9MLu9f23PuJdn6t/P/jjV0MGSF14vgv5u
         i86HEAP5A2OMqVfamlxcQDlmTYNwFMbtobWTZtGhWbvEYBaMRYTiXOucp1V8uqjG6Rla
         bQq0RPzootkhYzJHW990dKNYFP8D5mTPgyY8TY68WWZxthyHV5GJVFAGhc1OO3WIiA4N
         K6s+5DrGlSBMds1FhcejgeMibZea4knAEypyduZ1cOKF4zQQ9nFWv+PHPQQQviXCLJEN
         XjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366925; x=1727971725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJWKgDcwHDzRJDVWC4NU1waaLgU2pU4Iy2cHBRbpC9w=;
        b=DaBJHwl8ExuxishStMIhUQPMvFVHc/J8WAx8HtvkormmedSPa05Y4K2it1X6VAfBAw
         OJ6B2TLEka7bAwPekV9vpXbKRXB6aH6aQjbSwVEs7G3JKkf0fQDtY/C/MTR89KWqsL5i
         HKw5XLdUqCkc02N2IQH6OJ7bVgzBDoL8NmyBDbOyyURZAW7qH7o0Zd+QJ+DjokTLCSic
         SV0zr/nmzNLBuYSQ90W00q/Z7K8TNh67PjMGofBd5Qfozxp6pmuGZtREab4gveUdqNH5
         TgJZVFDX9lm/8eAcv58Jg1Z0I9j8m750JiCZe9hE4GEU6ZTOzrrM6fr2t7ut8nSl6tx2
         Z3JA==
X-Forwarded-Encrypted: i=1; AJvYcCUCRXykq+Xu6reWwsoD0zYKdv+YzIrKnXhividRze63NWtI7GTHCI3aB5R7+UQlqT4VvX2XxaPDNRk=@vger.kernel.org, AJvYcCUQM4k1wZUIeBepo632g1nAfLhJuahWLeAfta4WrSfmPWyQYx0tcVg2ugzo9+6sl9o7ZrQ3wk1fF1hkVJ1Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVAfkYPDwCVlXaCT1RjLvtayIkuY4ePRbTNRgX4WYhMjBR8W7
	GKnTeYf8/x5+ckd4b5pxpIIQmYKKYVLdXU4zwlbVtzaKdLG3m/AFyLUr+yQ+
X-Google-Smtp-Source: AGHT+IHZdg2jhk2e+Cn4R32SMBMGp+lA/vyCWsLnw2owXMmyeWM65kMhdSp1Pkri3UzB+6nV3OV+IQ==
X-Received: by 2002:a17:907:8692:b0:a8d:44a5:1c2f with SMTP id a640c23a62f3a-a93c48f089bmr2181666b.6.1727366925244;
        Thu, 26 Sep 2024 09:08:45 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6d88-4cd9-a9d4-f267.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d88:4cd9:a9d4:f267])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm13947966b.78.2024.09.26.09.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:08:43 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 26 Sep 2024 18:08:38 +0200
Subject: [PATCH 2/4] iio: adc: qcom-spmi-vadc: use scoped
 device_for_each_child_node()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-iio_device_for_each_child_node_scoped-v1-2-64ca8a424578@gmail.com>
References: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
In-Reply-To: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727366918; l=1374;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=EJRXbPr61KxXV+wd3zzOVNML9/DOwfwUtS+ORGYy5xE=;
 b=/f3X+kN5zg9IByr0xsPHywl8fBIPhkGkWyTcEpKXic1JID9p1QUtQZw+Rxv8rHnGNjltXPBXJ
 CEaXlT1j7D2CSGsPT/HYk1mzjnkj0PWoA3Ziq1lLMmt1Wlmh7WukNL8
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to device_for_each_child_node_scoped() to simplify the code by
removing the need for calls to fwnode_handle_put() in the error path.

This prevents possible memory leaks if new error paths are added without
the required call to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index f5c6f1f27b2c..00a7f0982025 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -754,7 +754,6 @@ static int vadc_get_fw_data(struct vadc_priv *vadc)
 	const struct vadc_channels *vadc_chan;
 	struct iio_chan_spec *iio_chan;
 	struct vadc_channel_prop prop;
-	struct fwnode_handle *child;
 	unsigned int index = 0;
 	int ret;
 
@@ -774,12 +773,10 @@ static int vadc_get_fw_data(struct vadc_priv *vadc)
 
 	iio_chan = vadc->iio_chans;
 
-	device_for_each_child_node(vadc->dev, child) {
+	device_for_each_child_node_scoped(vadc->dev, child) {
 		ret = vadc_get_fw_channel_data(vadc->dev, &prop, child);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 
 		prop.scale_fn_type = vadc_chans[prop.channel].scale_fn_type;
 		vadc->chan_props[index] = prop;

-- 
2.43.0


