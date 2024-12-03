Return-Path: <linux-iio+bounces-13012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95699E1C0D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47942B44954
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFC1E764D;
	Tue,  3 Dec 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A861IbJF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4751E573A
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224426; cv=none; b=Z1p0wliOv5swNaqh2dk1Rxx5EjySgvhI0WE3VNt0oKlhf8z3Epr5HKDwAyg/PMXeehBidiazOQYCeoh5vMr033KPGmk3TZpAJKKMG+9sKJcKJOIm5nEcHKtBfz7Ri4jBMdcZRkLXJ5fo/nFXfn8hZ6AAQFoziQDgJyOE3PQ7g9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224426; c=relaxed/simple;
	bh=xJ4dALnf5mNTVJSAEIwW3H4ATLoC4Hm1NI+znfsjunw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gjEstjct0nc2A/cc8+vTQA//ywk8sZGa2kbkhrKxll20bqr5FizURLUtPjlsPTIAvSErW/9e2WUjuDkFsHqTGK5haMIdTPcRw4DfE2ENVF967KtMwlSOFllXHvcGuHUEUUA9ctlNSWHv8cTNUyAaHK2ph0BaLTzPY3uYJvT+04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A861IbJF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385df53e559so3004846f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224422; x=1733829222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbKn6tGUYWTywSMd7jgYmbuzMuj/ru2cA6G4h80SF4s=;
        b=A861IbJFvPqA0ouBOg6H/VFTbkVVUyfnDKvu2joAuZJxrouD6xfUJl/TLRH+NGhGMB
         7LkgwlXpWUqglpi9ncwFA+Gj6Z9Y9vMMyF19ydwDHh+TylqjmL455QNqRbeI982W7Kxj
         c5e2FmpJ/ORzqcZKc4DCG58GkClfNl5wxTZSG0Aqt2nMsX2zc/OkEaifBj3a6KVM49KD
         BoiJ1u94FdjpvesXHq8lx4D1SwTPka3YMz/wO9+KLBPkfrS50uVmFuXCgfiS+98olfVU
         EeorCt1y5XVfKhhU5IIcsZPBMIddEplRksqSQTGMUz3wxRdVjAEWg/PWTSKiQ/TieUua
         62kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224422; x=1733829222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbKn6tGUYWTywSMd7jgYmbuzMuj/ru2cA6G4h80SF4s=;
        b=X8DzTSNP94Xu3ER266IkwJ0zGQO0BVLnskzfhNiSS1f1fDOUb8fww0kaIV9JseGzt8
         LZFcEedhNbj+Rbve1/VwaxbnXC0MY6qJxMNT6YMPRV1BxwOx5GO7s/maT7VsKWDeqrSg
         /EaWitRxIZOL02jD5GpJ5P7F+cTLyYo1G8DBf8FEqaaw39YW9KXH8ltIJdtrA0PyqkSZ
         3VjUsu2CBiWGYX133bLejiDl0iuV9hkI6/jHCQX3RHQ4Zb8KGPKy8a1w8Fz1UL5RIQXh
         3cwjpczeDzAmKrAjE+IRiIeDYyJzlwNxZ8vxCNV49/7i3KeJqXvp07FgrOSG/PnCMsxf
         9Ccg==
X-Forwarded-Encrypted: i=1; AJvYcCWe3ZENN23SNQleJxuqZIyZfH+ZqDfW+sPNMvbXM2WaIO0uhe2YdIfIHmuYAbiPucHB/HJ3ztj0I14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZMW5Hz4PRF4OZpYgB8G5VcOmfpcgsjopPXZ3o9jkKTOqcBOt
	DEkseVYDz3xerHGqGdp+JWgSJgV3BNJAyjHEGBr1/6XXzY3Env/7rRi25l4xWFA=
X-Gm-Gg: ASbGncuFPvHoIAiZ+AA14498RBOWJDMHw3pcgYBPhJdH0dIuqC+bucMVfgITkAq8doj
	dg8cytgcEP6J+x6v/mXcN3yflhtizHKCWD8NoDy2KcADVFGBOhe1OpvL/geQj6KlLfPRBBQe25q
	q92K296OyW6UyVYwkGOOlkTsHzu7M7mGo732Q2wZyX/XMl2IjiU1ILMz5s7ktnDpx5wdPhbSwif
	UU9ljycKB2/QdeLUf1i6DjdZk1TcUIsUjwGGlUUkiHLW1G4melqaOJhwYg9Kvo4vFVAtb01VjNw
	cucf
X-Google-Smtp-Source: AGHT+IEOrZno5uDxt9ZVOUtNbpTQHBOs2RWQccg81owHc2jnjCTJ+2WWar5weAlgmhDsBKHCTYxVnw==
X-Received: by 2002:a5d:5988:0:b0:385:fb56:5596 with SMTP id ffacd0b85a97d-385fd3cebdamr1638266f8f.19.1733224422476;
        Tue, 03 Dec 2024 03:13:42 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 07/14] iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
Date: Tue,  3 Dec 2024 13:13:07 +0200
Message-Id: <20241203111314.2420473-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
change, consecutive conversion requests will no longer cause the device to
be runtime-enabled/disabled after each request. Instead, the device will
transition based on the delay configured by the user.

This approach reduces the frequency of hardware register access during
runtime PM suspend/resume cycles, thereby saving CPU cycles. The default
autosuspend delay is set to zero to maintain the previous driver behavior.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index eed2944bd98d..fda8b42ded81 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -207,7 +207,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	rzg2l_adc_start_stop(adc, false);
 
 rpm_put:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -372,7 +373,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -412,6 +414,9 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(adc->presetn);
 	}
 
+	/* Default 0 for power saving. Can be overridden via sysfs. */
+	pm_runtime_set_autosuspend_delay(dev, 0);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
-- 
2.39.2


