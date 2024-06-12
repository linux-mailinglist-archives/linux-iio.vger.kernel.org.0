Return-Path: <linux-iio+bounces-6228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F98D905D6B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 23:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497041C20983
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 21:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2512E1D9;
	Wed, 12 Jun 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y8bxFewT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EFA12A14C
	for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718226205; cv=none; b=S6Y1NOTgD8mMt55kw54KQHjVLB97jK3E4CiV8vhM7V2q0J4Gsu4WWi7WAYOJub97HMp4TY0hF1i21bve7nYM4bBv69ZbmAB3XF6xOmkSgwvN8Ed7Uk+J1Q4LIo90PfI208t1Sms8KHdJzsjZxKdJZ9qEBT6MIGT64mZy8iDF0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718226205; c=relaxed/simple;
	bh=LHX54IPohUPO/ja4UGsPmeS+kesms5VmpdxF3oWqNgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv/QCKg2vhS6VzRZGFseRBC3RKRIQuAM+boGiquNMJeWDC09OLZ3T2CnKJ8UdGtub71l3NlRfzIzSTCRhWOz6hmDuUttiS0kHt4yRwGVtmRb7BC5gocMvQ5jovoegYbWPN9qL54/Gmb26Y52rPKVu9h79y6ccxIcYidLR5Zm1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y8bxFewT; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c9c36db8eeso119458b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Jun 2024 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718226203; x=1718831003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfd4KKhAKeSc8nJGyWlf0fHOe2Cz1V6aByHicOapUF8=;
        b=Y8bxFewTnYQT8RbeWQtF4iyaxR/XkICY/Mn4/LwcGymSLG6kemamvCxN8mCvEmjU27
         P33Qr+UYB81awreVVQDCGnBdU25JTCeOhYCf/V6N7apxZ2Dp5cdBqWMWh+/S+iXE36lH
         aVJB3CxhXe0yv1LaQ7rMHZK4i6uTjz5XD5/7RoYlSBvsaWM3V4tyY+7PBVsibWaYng+v
         CRDbA6J2l/fqYcwzfcTbQA27kwaBUdKZjeWw/Zn/Yhavi6vpTC/l8GhFfuG0aPGwULmz
         FOLugfIl6huzseIBcI1mFwMEdqCrP2wMgeEfTz75G2uTJXerkta/BRpcO2DtLMP831JF
         MK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718226203; x=1718831003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfd4KKhAKeSc8nJGyWlf0fHOe2Cz1V6aByHicOapUF8=;
        b=s4CpWCQfPBMudQ2tW+KSNygBvK9gYoWTmq0VIUjyRwLgyj3bg/17BziTRDd7XFfFYP
         JC0p1CxDz0ujd0ks+futTWiZ8eSzh7j6tqNYLTQ7zLFgD0Db1rgXEAW6Dp4BB4GHUqxF
         4JBLDmyhXt5s2yhZccUvm2RZVXYh5cQAYOP0IpRP0TQOXH9iLkx+NW5lW+gy4AfRqTqs
         3W6phAFuHox2Y+KxSHyYyGxrai0eZ1+ZNpJvjhM7c5goImIHF1Sq4bPM1DTqi3aroCu7
         OtVo6NG7Ugpee2q0/3O8MxLYnhR/Hr17X87SVe+N8ER16D4SCvmAddTUpxwxb+WDWaU1
         rytQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT7B1IXgQuubeEynnjhIKGtcdP89kKNTughMuivrcOQy0K8xME0BvLezfZtk1wr58g/cQ2uhVYb72RajkE1Snkgkxt1SOePdfn
X-Gm-Message-State: AOJu0YwFN6vCvyDVaBfOsqjQaTlgdkKNCgW82A7ALrhOAD1BcUYiGsLt
	LvlJKmJS0LgZrCgF+X7Fagu1S6UxVaH8XrcVcg2l6CJY1jRjAeRoGQFDeJQ08vE=
X-Google-Smtp-Source: AGHT+IFqU/5rjB/9qgNYmiXyV9btPuQJBs/CvDCI2j8yxhXc9NcK7vXOFCo903edhIGqelGT2FOyeg==
X-Received: by 2002:a05:6808:2f0e:b0:3d2:1cfa:94d3 with SMTP id 5614622812f47-3d23e108174mr3327209b6e.47.1718226203250;
        Wed, 12 Jun 2024 14:03:23 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d20b68f5a1sm2433368b6e.23.2024.06.12.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:03:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] iio: adc: ad7944: use devm_regulator_get_enable_read_voltage
Date: Wed, 12 Jun 2024 16:03:09 -0500
Message-ID: <20240612-iio-adc-ref-supply-refactor-v2-5-fa622e7354e9@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
- don't read voltage from refin regulator
- avoid else in return value checks
---
 drivers/iio/adc/ad7944.c | 54 +++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index e2cb64cef476..f8bf03feba07 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -464,23 +464,17 @@ static const char * const ad7944_power_supplies[] = {
 	"avdd",	"dvdd",	"bvdd", "vio"
 };
 
-static void ad7944_ref_disable(void *ref)
-{
-	regulator_disable(ref);
-}
-
 static int ad7944_probe(struct spi_device *spi)
 {
 	const struct ad7944_chip_info *chip_info;
 	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad7944_adc *adc;
-	bool have_refin = false;
-	struct regulator *ref;
+	bool have_refin;
 	struct iio_chan_spec *chain_chan;
 	unsigned long *chain_scan_masks;
 	u32 n_chain_dev;
-	int ret;
+	int ret, ref_mv;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
@@ -531,47 +525,23 @@ static int ad7944_probe(struct spi_device *spi)
 	 * - external reference: REF is connected, REFIN is not connected
 	 */
 
-	ref = devm_regulator_get_optional(dev, "ref");
-	if (IS_ERR(ref)) {
-		if (PTR_ERR(ref) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(ref),
-					     "failed to get REF supply\n");
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
 
-		ref = NULL;
-	}
+	ref_mv = ret == -ENODEV ? 0 : ret / 1000;
 
 	ret = devm_regulator_get_enable_optional(dev, "refin");
-	if (ret == 0)
-		have_refin = true;
-	else if (ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "failed to get and enable REFIN supply\n");
+	if (ret < 0 && ret == -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
+
+	have_refin = ret != -ENODEV;
 
-	if (have_refin && ref)
+	if (have_refin && ref_mv)
 		return dev_err_probe(dev, -EINVAL,
 				     "cannot have both refin and ref supplies\n");
 
-	if (ref) {
-		ret = regulator_enable(ref);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "failed to enable REF supply\n");
-
-		ret = devm_add_action_or_reset(dev, ad7944_ref_disable, ref);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(ref);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "failed to get REF voltage\n");
-
-		/* external reference */
-		adc->ref_mv = ret / 1000;
-	} else {
-		/* internal reference */
-		adc->ref_mv = AD7944_INTERNAL_REF_MV;
-	}
+	adc->ref_mv = ref_mv ?: AD7944_INTERNAL_REF_MV;
 
 	adc->cnv = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
 	if (IS_ERR(adc->cnv))

-- 
2.45.2


