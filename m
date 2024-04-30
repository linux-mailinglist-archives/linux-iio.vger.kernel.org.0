Return-Path: <linux-iio+bounces-4663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCA08B6694
	for <lists+linux-iio@lfdr.de>; Tue, 30 Apr 2024 01:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68298B23C8A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A91A38EF;
	Mon, 29 Apr 2024 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pbHWLuh1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533D1A0AF4
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434044; cv=none; b=HB/KHLby1GVMqcLhbvxcDyAwHqE8D5J2ygH/ELa9Cb822hdNfkdZ6EegKz4NSME9U4wYgEsPFQJ7sjCFy2yxRr1fORfF53h09Llw8733jbD57N9+PneF//lxSL2cH4J4zyNqPeoJSoBMkkehR3Cd7fkxXz46PAk60wFN4ZLOa+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434044; c=relaxed/simple;
	bh=f4G2L1z1zSkKaPQHDBq/6+aryPTA/FbiB2tWbX2f5ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8muAnIFRnOkhK0IDKYsISD5XT1UZOxJrft6HBsDUKrr2Wn+WUtprtQ8x5FPFIJvOFMxya1XxCI2aPauRzqfD7B970V8qJsMskX+iul8ow2WZOmDUQwe/X5jBnA/6lPtWXyOAdOQkqTlTVQDuC4ph2w3ASKVk1U8tPdlsDyw5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pbHWLuh1; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-233f389a61eso2596568fac.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714434041; x=1715038841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ+ZTMWPcJc+hIlvH7T2PbKtWet9tgeGz07/T80YEuU=;
        b=pbHWLuh1Xtu6uL38XxK4B+0fCiYd7UAwdMdtMKEw/UnHF+S5JWR9mR8jvJ3OUqvOzN
         +XZS726FcasBZjgbGGkIgIKBUfRivinxaNyiqaIrikWJeI8r7gNxTlyZzuzuXox2+/FT
         2AQjVJCSbxn2GGKD3hKBaOv7Ht925iNAwn62flLi3MhStzwJnVi2znE9gcVZyG2WPGAO
         YEr1UUDXrWCr3PhBrJg5FQuMcvfnvMhNLYeBrdaqvzMYX98mauFd7Ld/p8IUN//xEpFn
         FLz2S3oonXYn8tsBuPNLQuA28PQpkvrdFT/GnsmpriwdnuiApTQACfseTpOKCR5GIwDz
         hFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434041; x=1715038841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJ+ZTMWPcJc+hIlvH7T2PbKtWet9tgeGz07/T80YEuU=;
        b=Ll3+Lkxzsv+XUacfYCoW5Ze0446+OBPdYjIU6B4g7IMpZmrws71/a4z72POxTTpKI5
         Wng6GloK6TgcK5lXefplZYzxhIHVKf2kfWQ9KSxSJwAJAvZVW3sx3ucZ33ONg2esysVB
         KcG88EGdaW2aH5bhWhng8l6UsDmYsPz1oM3xPKFnXAoOrprZ//Ex4j9/H/LrCL8tRrc1
         CEEduFxD8FZrWfUev/iKg34b9fbNT05W8gYVURcncAamZVY/1gyleOf0o4vONIw3IWw6
         0vZAkKB7YdapjaWEOdglH4SB0v1cD857S8K3wVX7vUzkZS7+CLjzPGOT3YyJi9Xqlq5l
         KpiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6H/uV6AXT7/fR92mFqt/vKGyBqv31O9EfxJTh+CSNBJd96QOIXU6LkeaHFlxmSAs/F0rs54eYlIngvHyFVdHmSRJFQ41LcEQG
X-Gm-Message-State: AOJu0YxwXTB0hTCfaT6w2VFMkztoKooDyPDpphoGtxoJD9FFKVOVziuu
	j+wRH2y7pVYzRJO2asOI006NmZSEQtmc0xEQz/O2zttlQTnTptzmRG7L+NqTAns=
X-Google-Smtp-Source: AGHT+IGUMUBHGEj5nThSng3xMh0/uoevSE7AVeKx5UlHjVLAZMEu4Nr0mRW++UlSgbku/YpyKEuPfw==
X-Received: by 2002:a05:6870:618a:b0:23b:4854:820b with SMTP id a10-20020a056870618a00b0023b4854820bmr12720046oah.2.1714434041609;
        Mon, 29 Apr 2024 16:40:41 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id hp22-20020a0568709a9600b0023b58aa20afsm2144508oab.25.2024.04.29.16.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 16:40:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 7/7] Input: mpr121: Use devm_regulator_get_enable_read_voltage()
Date: Mon, 29 Apr 2024 18:40:15 -0500
Message-ID: <20240429-regulator-get-enable-get-votlage-v2-7-b1f11ab766c1@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
References: <20240429-regulator-get-enable-get-votlage-v2-0-b1f11ab766c1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

We can reduce boilerplate code by using
devm_regulator_get_enable_read_voltage().

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* renamed to devm_regulator_get_enable_read_voltage()
* restored error message
---
 drivers/input/keyboard/mpr121_touchkey.c | 45 +++-----------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index d434753afab1..0ea3ab9b8bbb 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -82,42 +82,6 @@ static const struct mpr121_init_register init_reg_table[] = {
 	{ AUTO_CONFIG_CTRL_ADDR, 0x0b },
 };
 
-static void mpr121_vdd_supply_disable(void *data)
-{
-	struct regulator *vdd_supply = data;
-
-	regulator_disable(vdd_supply);
-}
-
-static struct regulator *mpr121_vdd_supply_init(struct device *dev)
-{
-	struct regulator *vdd_supply;
-	int err;
-
-	vdd_supply = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(vdd_supply)) {
-		dev_err(dev, "failed to get vdd regulator: %ld\n",
-			PTR_ERR(vdd_supply));
-		return vdd_supply;
-	}
-
-	err = regulator_enable(vdd_supply);
-	if (err) {
-		dev_err(dev, "failed to enable vdd regulator: %d\n", err);
-		return ERR_PTR(err);
-	}
-
-	err = devm_add_action_or_reset(dev, mpr121_vdd_supply_disable,
-				       vdd_supply);
-	if (err) {
-		dev_err(dev, "failed to add disable regulator action: %d\n",
-			err);
-		return ERR_PTR(err);
-	}
-
-	return vdd_supply;
-}
-
 static void mpr_touchkey_report(struct input_dev *dev)
 {
 	struct mpr121_touchkey *mpr121 = input_get_drvdata(dev);
@@ -233,7 +197,6 @@ static int mpr121_phys_init(struct mpr121_touchkey *mpr121,
 static int mpr_touchkey_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct regulator *vdd_supply;
 	int vdd_uv;
 	struct mpr121_touchkey *mpr121;
 	struct input_dev *input_dev;
@@ -241,11 +204,9 @@ static int mpr_touchkey_probe(struct i2c_client *client)
 	int error;
 	int i;
 
-	vdd_supply = mpr121_vdd_supply_init(dev);
-	if (IS_ERR(vdd_supply))
-		return PTR_ERR(vdd_supply);
-
-	vdd_uv = regulator_get_voltage(vdd_supply);
+	vdd_uv = devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (vdd_uv < 0)
+		return dev_err_probe(dev, vdd_uv, "failed to get vdd voltage\n");
 
 	mpr121 = devm_kzalloc(dev, sizeof(*mpr121), GFP_KERNEL);
 	if (!mpr121)

-- 
2.43.2


