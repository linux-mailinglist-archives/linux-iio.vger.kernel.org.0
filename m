Return-Path: <linux-iio+bounces-13881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB9A00A2F
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DEF1640F6
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2025 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4531FAC42;
	Fri,  3 Jan 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="T/bZ5UT7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6351FA8DA
	for <linux-iio@vger.kernel.org>; Fri,  3 Jan 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912863; cv=none; b=eWaYoe6SPg3g2UYgkqUaqiQoTumTZ7RF1PhQykTKQtaaTkZJVi65AcXZm2f71bj3PIsFMPY4RmU7/039l32CdXRUa3DPl/qsE5nrPlGkHDbpWt5JsW5FpkYgqYneDtSScRHuhcBG6W8U+J9mtlkjlZ68gnZEvgRnqagzyE2s27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912863; c=relaxed/simple;
	bh=EuNVdSlSZudyJoOAdfDuJcdMXRlPdSBuq49eBU9+fpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Le4YDhzfBQgGIrPyWHEgfNPPjEDn9zhrSh+isBTNFq0dGjbkk8QCMiAXATLGRiQsmmdqVFWKWMgFuZ14TesvTaWAvneTfQAm79FKjfpTvA+KM6gx7V6EmrVECWcdNDTjTXy/l6tu1wgSLfaPXvaJFTINz5Fyo4nZ1P3BQAq7Ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=T/bZ5UT7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so5971438a12.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Jan 2025 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1735912857; x=1736517657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyoJR7eM+UULUVfgeh2RQ3JsSmCjTnPlEP7eCTmVZEM=;
        b=T/bZ5UT73CoqhM5XtnHfBCJOiLWuWT0OfsmasT+MBHyRKh6X62SEjlKJPUt/H5o7cf
         5FnhkUNZdiYhObMiH5CjDWazzu1Ywhhw6URKiUWJ/BmGOmKiJXc+qEsWBVUtapza+fne
         SZL/UHtQt5z9RWHj2RCltLmxMibB041T2ILjvF3HKg4r7+XXa9ps9ojocjPB6GEhI7oe
         EPVu1YYJLcgQoMOzKNRsSglUba7S0FgzcHeZ+SiChyJ2I21CTYjihUlVfQzn+d6/CLJ/
         VXKfRWYkS+9Upsu/rlxL1BjMkp/eaxLIuRfqeGiJ7yaeBWFSblsRcLwuZSOxnKJ8nioH
         6EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912857; x=1736517657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyoJR7eM+UULUVfgeh2RQ3JsSmCjTnPlEP7eCTmVZEM=;
        b=AbNocrORVOkGayfG37CZotaDDbN/I1+Njb6RDuyvafkhbZ9h48iizhY8Z6csSn+cc/
         GIRQUOPixEy/JjW8AEZpFSDvl7eafnWoIE6YA7k3QKGISvkrif9PEMg+S/r4EAZIPwzE
         0qmUk/Ds/uZZLO4fjn8eKa7p/E9v0nNx5YRwhr1nm4uQ0hkFORbmbJr6aLng7W5kPwEP
         LXnUBNGN9bjT0kyjKpwIHXDgGNtBdCwweFBp1+TY9ETY+Zctrq7ELlQJFcP2ennfUB6H
         fTnp3sZc8AwVq9Nvdsp/ZUoJMQhuABhy1LXUJ4KHVCIobRFVeP18ulcLdLpTobU59WRJ
         pipw==
X-Gm-Message-State: AOJu0Yzdlg/s1ecVeyJlHKnfQCm7MposiRyq9UxfhBxhVd18grf7gdMv
	9PWZSHWdf/sQgSlbLx0mv+BC9SQNia+xzCVIoaLzeOlQMuQK23mQoZS3kvKMmoc=
X-Gm-Gg: ASbGncujoBKrIQHCXvYfuXo0q9CvZ4lMYmVhz9U3Ey0w9vnGD4Wz8/glK8Mrl6E4jie
	KC8rWL+Ipov8n2aQziVr5tlZKJyyjA1RVf9CT4xLSWfh4rfSpOqTr/TzkdRJiOE64TeRxEUaK/f
	/J2HxnLqQHucJw3CskvwmgyGZajWdkK7hXjp2DyNgO7cvyjKoHlq9VdEzROoK1KnS5U2Xy/RlVy
	jZNboqWNWZFRgIh3doTrgeVqyd12H2Hq7jdUAT95wePFvjUIRLKs0kWJa5YuNVhpKgYDGtkW5G6
	A/VF7YaWreE=
X-Google-Smtp-Source: AGHT+IH73GcCsE/lQyg6qOmyCUftPapB8Jd9zfJekawKG6luwVZg0kmD20Vj1IYY2YIztuCKga/dhg==
X-Received: by 2002:a05:6402:13cf:b0:5d3:fc60:a504 with SMTP id 4fb4d7f45d1cf-5d81ddb0d51mr39508173a12.20.1735912856437;
        Fri, 03 Jan 2025 06:00:56 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f0e4sm19502384a12.42.2025.01.03.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 06:00:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	ulf.hansson@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Date: Fri,  3 Jan 2025 16:00:41 +0200
Message-ID: <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On all systems where the rzg2l_adc driver is used, the ADC clocks are part
of a PM domain. The code that implements the PM domains support is in
drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
domains support is registered with GENPD_FLAG_PM_CLK which, according to
the documentation, instructs genpd to use the PM clk framework while
powering on/off attached devices.

During probe, the ADC device is attached to the PM domain
controlling the ADC clocks. Similarly, during removal, the ADC device is
detached from the PM domain.

The detachment call stack is as follows:

device_driver_detach() ->
  device_release_driver_internal() ->
    __device_release_driver() ->
      device_remove() ->
        platform_remove() ->
          dev_pm_domain_detach()

During driver unbind, after the ADC device is detached from its PM domain,
the device_unbind_cleanup() function is called, which subsequently invokes
devres_release_all(). This function handles devres resource cleanup.

If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
triggers the action or reset function for disabling runtime PM. This
function is pm_runtime_disable_action(), which leads to the following call
stack of interest when called:

pm_runtime_disable_action() ->
  pm_runtime_dont_use_autosuspend() ->
    __pm_runtime_use_autosuspend() ->
      update_autosuspend() ->
        rpm_idle()

The rpm_idle() function attempts to runtime resume the ADC device. However,
at the point it is called, the ADC device is no longer part of the PM
domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
APIs directly modifies hardware registers, the
rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
being enabled. This is because the PM domain no longer resumes along with
the ADC device. As a result, this leads to system aborts.

Drop the devres API for runtime PM enable.

Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 883c167c0670..f12f3daf08cc 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -464,25 +464,26 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(dev, 300);
 	pm_runtime_use_autosuspend(dev);
-	ret = devm_pm_runtime_enable(dev);
-	if (ret)
-		return ret;
+	pm_runtime_enable(dev);
 
 	platform_set_drvdata(pdev, indio_dev);
 
 	ret = rzg2l_adc_hw_init(dev, adc);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to initialize ADC HW\n");
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW\n");
+		goto rpm_disable;
+	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto rpm_disable;
+	}
 
 	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
 			       0, dev_name(dev), adc);
 	if (ret < 0)
-		return ret;
+		goto rpm_disable;
 
 	init_completion(&adc->completion);
 
@@ -493,6 +494,19 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = adc->data->num_channels;
 
 	return devm_iio_device_register(dev, indio_dev);
+
+rpm_disable:
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	return ret;
+}
+
+static void rzg2l_adc_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
@@ -614,6 +628,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
 
 static struct platform_driver rzg2l_adc_driver = {
 	.probe		= rzg2l_adc_probe,
+	.remove		= rzg2l_adc_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-- 
2.43.0


