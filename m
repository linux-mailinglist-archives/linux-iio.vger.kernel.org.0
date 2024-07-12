Return-Path: <linux-iio+bounces-7552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434192FE15
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1FB5B21F50
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B3717623E;
	Fri, 12 Jul 2024 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QnmO49jl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6F175545
	for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800247; cv=none; b=IJDoWvWjadGm5014qN+ETbbavs66YK7B5NQ2OxEMEjq8Yk5ptTaZ0j6LIArJq+6hQDpGVVFRCd5oEKHlqNH4uqrTOKEXnI+0Ge0Af+2oHHuhiltsn7UkwiHWd0xDlLF0LY1MLHQvmTW1cSXSGltiAz1Jm8B3OG0NXSBR3F2ttD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800247; c=relaxed/simple;
	bh=Y/k/wdBv/5beOfFpJAQFfQXG5QorlewTAyQxhJSger4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=to68mJ4VT3ktQgUsLgUy0mPHjLq7p5Si2RT3D2Q3L/3tt23pb8CVwGviHo4kk6/VHU0THXr8usonYkGSI3AnPdpdIGmDoSjvy0djIOkCuiBu8zorPI+o4PhRp1fGw90chShxtlJaabOio5+plychYufz+U8nF5fS9vD9Q1mVkrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QnmO49jl; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7037c464792so1128396a34.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2024 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720800245; x=1721405045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtk0UvTBio0HdPiv9SeTHdQ/nYZSzty+YaDbepVhjDk=;
        b=QnmO49jlVfOP5X+O3cHivPKymPZJd4lFil1HBGfoJ4qvg0IbvoPY9m5+ZokpaLpA7I
         n8X+LlmymvsfE/47bQaV69wiGdOq4DIOIeymue6tFahIFyx3XueT678CYrhADLp/U35t
         Gi78sFv2PYchfiYGMJJjcs0AWleJTuJu94gBBTtU8xO8uKivjWKDpyDYaZLwxW6btNlt
         9HKfm4CxTucC66ijB11ptNxaug7uHPVY68m4fGMTJbf3ITmjFrlBnF7oE+XFFtCBNzaJ
         1/uzj0V7sXa3Wd5Rm1QFGSoM+Cl5wZWSzfM94o0qaRY9aHu+SOodD7Wo0atNq0RXYVqV
         SAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800245; x=1721405045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xtk0UvTBio0HdPiv9SeTHdQ/nYZSzty+YaDbepVhjDk=;
        b=eQXyOneyyjJZCCq1+HHus3njBYvh091+tZ6hOBVpTqu7kY5+M4SyzT7iSpYDbsV6n8
         TyxRpox56nBxna7vq3uzcGKYqmnXALP8uYS+3Bxvc2huQROMXPh451LEXBlRqWDGjTi0
         xZ9aB7CpPrY0KLnswNx7k3ulnudV3OMqWr6J7abAplK/XVb3KVdlU2T7VSIP/CTwEjna
         fyLvQmDiFTLd2tYmoZMFEYh9e/vQpJYlxl2vV9JLFJ2ICRQP550TwJheJZzkCI5p5ka8
         HusQLiEFLqb3MSwd6A9gGOuRHqqGNi51GLiYHL0Iht29zP3TBx9Fgj22ejT1FKk256Y4
         2LFg==
X-Forwarded-Encrypted: i=1; AJvYcCVxu5Xm51OtgdrAxy+RH3Nibaa5Gv8mg8Co0oQQz8rbMetHv0Rkuick1ZBOH43V+i4qM63cruMWsfoqYR+tGm5EP0e1XeR8oqUB
X-Gm-Message-State: AOJu0Yzhc15OS5d3qB+ilLcoZKwBVHog4d7RSst+QIEWTJepxslW99ne
	pciLOkIojKbz8W/yRWQtuIfZ0YBvAq8vNOQrc0iQRb5TeC6SA1ValCs4uZe8AWk=
X-Google-Smtp-Source: AGHT+IH9XtVdLylUZCQ+EzQ5KpOpsjBt1EAapLPX8XGhtAR2cvYah4rBJcTwPGQIOWEJcZUPCn7lRA==
X-Received: by 2002:a05:6870:d612:b0:25e:8509:160e with SMTP id 586e51a60fabf-25eae74a09amr10623112fac.3.1720800244908;
        Fri, 12 Jul 2024 09:04:04 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d35sm1615131a34.23.2024.07.12.09.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:04:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>
Cc: David Lechner <dlechner@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iio: dac: mcp4728: use devm_regulator_get_enable_read_voltage()
Date: Fri, 12 Jul 2024 11:03:53 -0500
Message-ID: <20240712-iio-regulator-refactor-round-3-v1-2-835017bae43d@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
References: <20240712-iio-regulator-refactor-round-3-v1-0-835017bae43d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
helper function to reduce boilerplate code in the MCP4728 DAC driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/mcp4728.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
index 300985beb35d..192175dc6419 100644
--- a/drivers/iio/dac/mcp4728.c
+++ b/drivers/iio/dac/mcp4728.c
@@ -84,7 +84,6 @@ enum mcp4728_scale {
 
 struct mcp4728_data {
 	struct i2c_client *client;
-	struct regulator *vdd_reg;
 	bool powerdown;
 	int scales_avail[MCP4728_N_SCALES * 2];
 	struct mcp4728_channel_data chdata[MCP4728_N_CHANNELS];
@@ -415,15 +414,9 @@ static void mcp4728_init_scale_avail(enum mcp4728_scale scale, int vref_mv,
 	data->scales_avail[scale * 2 + 1] = value_micro;
 }
 
-static int mcp4728_init_scales_avail(struct mcp4728_data *data)
+static int mcp4728_init_scales_avail(struct mcp4728_data *data, int vdd_mv)
 {
-	int ret;
-
-	ret = regulator_get_voltage(data->vdd_reg);
-	if (ret < 0)
-		return ret;
-
-	mcp4728_init_scale_avail(MCP4728_SCALE_VDD, ret / 1000, data);
+	mcp4728_init_scale_avail(MCP4728_SCALE_VDD, vdd_mv, data);
 	mcp4728_init_scale_avail(MCP4728_SCALE_VINT_NO_GAIN, 2048, data);
 	mcp4728_init_scale_avail(MCP4728_SCALE_VINT_GAIN_X2, 4096, data);
 
@@ -530,17 +523,12 @@ static int mcp4728_init_channels_data(struct mcp4728_data *data)
 	return 0;
 }
 
-static void mcp4728_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int mcp4728_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct mcp4728_data *data;
 	struct iio_dev *indio_dev;
-	int ret;
+	int ret, vdd_mv;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -550,18 +538,11 @@ static int mcp4728_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
-	if (IS_ERR(data->vdd_reg))
-		return PTR_ERR(data->vdd_reg);
-
-	ret = regulator_enable(data->vdd_reg);
-	if (ret)
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vdd");
+	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, mcp4728_reg_disable,
-				       data->vdd_reg);
-	if (ret)
-		return ret;
+	vdd_mv = ret / 1000;
 
 	/*
 	 * MCP4728 has internal EEPROM that save each channel boot
@@ -575,7 +556,7 @@ static int mcp4728_probe(struct i2c_client *client)
 			"failed to read mcp4728 current configuration\n");
 	}
 
-	ret = mcp4728_init_scales_avail(data);
+	ret = mcp4728_init_scales_avail(data, vdd_mv);
 	if (ret) {
 		return dev_err_probe(&client->dev, ret,
 				     "failed to init scales\n");

-- 
2.43.0


