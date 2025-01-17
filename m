Return-Path: <linux-iio+bounces-14411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F351A14EAB
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 12:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7461692CD
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00C1FECA9;
	Fri, 17 Jan 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HoUGYT5C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2D35960
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114356; cv=none; b=MEl0sKtqKEqlly4OqC3anAE3z9Bi1twfw0Y7AdaD3qJdyhwsS8PfjUxHBWNekW9q7QfKVylRspbWLwtGVESlmOwDtUuwCUSdG8A3Qw+xKyK14bZ9OgO+CzbCEJKf/gpIWfTnvEsSDxc4EQ/Y2C+vjQtyC7OlY754WMRyV5gIMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114356; c=relaxed/simple;
	bh=53V4mDk+itym6kMFP2LAtwCEDK2W9XMEniFbze8Xb58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ga+28aCxWUBy+82Aj4eQOzxvy9RAJ7xcXMv4OaMbK22G4LZ7W72w10CmgcfnjXNFkQ/UYxQBJNndpimBAzLqCCQelXV9Zj+hMuaOV+oMfVeJRCTkB25XUYTYfX/bykDL2PbZGD6zFYhQLhQ5BBLCGWcRMP8c+CTuGxeuroADMnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HoUGYT5C; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38634c35129so1606086f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 03:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737114352; x=1737719152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDWSQkaFP0eTmUAVm7GcOJC09zF+62CBev8hupRleKw=;
        b=HoUGYT5CHIO/otbFKeiooWH5qLEBqWjJlLyj8COpml+jfWDm7fj3goU6LRlukzH9Ok
         0+ePTzhWSfPXva3qhyB6XQfvbW3nTlDXstsmLhS5iFmeWRmOjD3/k2QMZVurtyyXR35Q
         unK7iXDVXF7QxDR2lyS2gdqRidxsmB9WJGFBGK9nPtKFoT8UBXwLNozV52hYV5OoeKkB
         bwgxnX7xTk8pAMl+/dfqbH23v0EWWhWLpEslZE+eYYKYoRB+b8dNn8MOI13+Qc2QRPlk
         HwfKGIkC3k2scQyJ+hZ7Rc/dRjdI+X4KazdFCh0s89d0xeQxeYyllPhEH7zFgE3QMJna
         p2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737114352; x=1737719152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDWSQkaFP0eTmUAVm7GcOJC09zF+62CBev8hupRleKw=;
        b=PEhOXzRvCnOdv4EyLBEn1R3HQVwFq9jw6RziJOz+U6p73XYVXQkHhnhsucvPeu5xQe
         ouBSL9tIgZd+IhxKCji/OtExaR/KDTR4w5lNMcBpMrxNEqvVN+68awoMGewBPj6HDlDp
         qwIXwpLs1vxoWKTFHlqKrZ/cd+mCGH2eDnWQlczZYlmYLFphODqaqhg6lbbhtmjpdKmB
         uZj7MH2nqzM0qX1Mm0cPYMjalumi2Bl6KO2ubjksGPD2wk6p/24z7hQ4Frqr/oad34mn
         PGrRBq4GFjbJejy2KAmqnQ8FdXuqvZhnwkrqJTvUNLL0VRKDoahl9GbP3w+ghTppa7T+
         fcug==
X-Forwarded-Encrypted: i=1; AJvYcCV+vp6fHM/ciCvHah+GKgkMfj3IdnvlNn18dIkagr0M6DPo59pz+3uKxXpsSux9AbMK9kvyXfgy0L8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8pehQFOnpBaBLFQvlySaywSqb2Y3dpyZrknoS+atbnIls+CT
	+zsr9cL+fZUCz/+MePRdPa2ypwFDfyYZTDbcZL9gVbh3i1sFe3E4rgDHjzyFDz58DhWzV67EiJR
	j
X-Gm-Gg: ASbGncuVfiBNOuqjrfk96f0eZA1OG4qLQHugUX/rYGFhmENY1c+OtcwZIfCWrqcRxvl
	k9k82CpYcSZ2HHXjw/vVgt3GldZG6lu2hYByBL4qT9NGpk7EoHQA62Ujp8LBKe8MWndHBSfdAzA
	j7lgXbcEMQw69q8qYIhr+Lvc/PsvbMmPAWdFWFgEd/6j+o4R7I5euMYEpKJ3EnU2vOdDRF6/87K
	D1rBXNJETbK3HQlJfISlF6zcmwifqhIwv6eF0qOezWVhokt4LEvLO9topolZ/0osxPiAdIz1MXV
	1LabV+QPVq8=
X-Google-Smtp-Source: AGHT+IGU/eWQr6GxoGkP+hRgnfbSFQIEduWrJJ3ySOP/gb2XWklvdeAu5zzmhcBMS+53D7WILmKsYw==
X-Received: by 2002:a5d:588b:0:b0:385:f1d9:4b90 with SMTP id ffacd0b85a97d-38bf577f826mr1988861f8f.13.1737114352231;
        Fri, 17 Jan 2025 03:45:52 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322aab8sm2348496f8f.57.2025.01.17.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 03:45:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Date: Fri, 17 Jan 2025 13:45:39 +0200
Message-ID: <20250117114540.289248-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com>
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

Drop the devres API for runtime PM enable along with the other devres APIs
after it (devm_request_irq(), devm_register_iio_device()).

Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected Ulf's tag
- add a comment above pm_runtime_enable() explaining the reason
  it shouldn't be converted to devres
- drop devres calls that request IRQ and register IIO device
  as proposed in the review process: Ulf, I still kept you Rb
  tag; please let me know otherwise

 drivers/iio/adc/rzg2l_adc.c | 60 ++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 883c167c0670..4742a727a80c 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -87,6 +87,7 @@ struct rzg2l_adc {
 	const struct rzg2l_adc_hw_params *hw_params;
 	struct completion completion;
 	struct mutex lock;
+	int irq;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
 	bool was_rpm_active;
 };
@@ -430,7 +431,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct rzg2l_adc *adc;
 	int ret;
-	int irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
 	if (!indio_dev)
@@ -464,25 +464,33 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(dev, 300);
 	pm_runtime_use_autosuspend(dev);
-	ret = devm_pm_runtime_enable(dev);
-	if (ret)
-		return ret;
+	/*
+	 * Use non-devres APIs from this point onward, as the ADC clocks are
+	 * managed through its power domain. Otherwise, durring repeated
+	 * unbind/bind operations, the ADC may be runtime resumed when it
+	 * is not part of its power domain, leading to accessing ADC
+	 * registers without its clocks being enabled and its PM domain
+	 * being turned on.
+	 */
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
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto rpm_disable;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	adc->irq = ret;
 
-	ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
-			       0, dev_name(dev), adc);
+	ret = request_irq(adc->irq, rzg2l_adc_isr, 0, dev_name(dev), adc);
 	if (ret < 0)
-		return ret;
+		goto rpm_disable;
 
 	init_completion(&adc->completion);
 
@@ -492,7 +500,30 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = adc->data->channels;
 	indio_dev->num_channels = adc->data->num_channels;
 
-	return devm_iio_device_register(dev, indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto free_irq;
+
+	return 0;
+
+free_irq:
+	free_irq(adc->irq, adc);
+rpm_disable:
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	return ret;
+}
+
+static void rzg2l_adc_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	free_irq(adc->irq, adc);
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 }
 
 static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
@@ -614,6 +645,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
 
 static struct platform_driver rzg2l_adc_driver = {
 	.probe		= rzg2l_adc_probe,
+	.remove		= rzg2l_adc_remove,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-- 
2.43.0


