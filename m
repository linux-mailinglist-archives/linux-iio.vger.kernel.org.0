Return-Path: <linux-iio+bounces-13148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092969E6D07
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C27A1884258
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F90202C2A;
	Fri,  6 Dec 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RlVFnxWX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C2202C29
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483656; cv=none; b=CpL+RQmljbDr/aWrGhCTM6+NjDkMQBQgk87VUOWIUeiAm6U0fUGRviCtLtGeo9M0sWJdNS7MQ5Pb8o7F+Xi4mThEc8+gTFDxtKWTLHhQ0reUvO/7EDhBbHDSd64tnQixvwjAG+7s7gC9qCmox8FGp0Wmfz1OmeJ18aYTUiXFER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483656; c=relaxed/simple;
	bh=fiQmPOGrFM1sT1OFzrZ1mHt7tw1wgM6W+Xfd0aJucl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iIOLHIZiJ7R1PXu4Z30Uf19nYU9y2z4HsjwPXHRbP+Av9VndDjqf4L6AHV2nMMEbpJld9ulKWOyu6tjxrr7240zyVp9RRsWQ4eUt016nzrUD959ZRcBWRCEoIdHEefQX58HTGSkHEjRzzOlT6O+TfyxtJ9GsvXlNLKkEIFDxxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RlVFnxWX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e1f12c82so1611423f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483653; x=1734088453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G1+H4vCuAFYlF6vDclbc4UqdYRAmFagMT67tI+psAM=;
        b=RlVFnxWXp+EbulnFE5rQyswB6EXsnGumjjxC9xclRMpnXSTSHk5RB5Auv4T3qcKQ4t
         UwXtSKluyv1XPIb5FCeq+iXFeh6fWoKBK5j8c2j/hBgItksEWjI6/OCU3S0chdUpqz0z
         Yl6/Lymb6P9bRqZ78GHLzf44c26mp7WxsLLDXiYqx5AcgBXOsUgy5EGx+G6aKLcSuv/i
         RsQQDJ03Pcywb2AeAFpYbTpMuq0245cCauAPHL2wHikZ0aNJf/ya4kxn3yQbLx/gYXWE
         bSsj6sgxrcG6FMQOhVd9bnSgx23W6Wt4Nkw5r5SctWbSj5t8T7rdWy1oRph3O0vjAQcw
         5g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483653; x=1734088453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4G1+H4vCuAFYlF6vDclbc4UqdYRAmFagMT67tI+psAM=;
        b=gAilD/KWCLWv5uEipYciE/LYUPbhe00mg0DA6IFMTjrMTnLW8kfg9KDKJtH6aa2Fov
         gmEGmZBHJouk03ysMH+Qc7A7PloAXkiIz6rG0NBDIVCqKJ9rFBbiWfCZh849Qoa8W7QN
         faNatU59Ad5SNsux0nudXMtadSVq9BmcTzLdkU3cdUGxUzZVpLq3aNyY7VVmMihRpgjs
         Sv3RXmyPnueMoIAcsay4FvjGA/GsGo0/Sx/ZxU9TY9fUOk1NFaWmBM+EW7wQtOF/xD1l
         98FnKrwm6KzcUYhOFH/ASyuQuENsirdBrhwG3+TNKM3NmXixKmj8dzcMA9UMswSbOeJf
         iuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGALaTWr4GcYcLG1OgDZ7rnPPFCHKjjVhcRsnAjdPelCS1jLLQE+0BlThCq53zvzrZuP75me1wPo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2w5dtDwu3W5O3Mwg0EIHQ6704j5Ntl30c56NLBixpd40Qxm2
	3ELMGzhzNBmb0orKT9xAC3PuZ1sbmpIWb4sRSyLEqK8cxt7+kBueTKpeD6Vni1w=
X-Gm-Gg: ASbGnctEVmEkNa/85rQAWWy0OzSj6yDjMfw2AuDCR6D8QwLKdusq+Fgvd+flJSh6Q8o
	HYcbGCyubToh8ULc0D1cWODMLTCvVaeCOP+It7pg35/QYjidrwnzCHPr/3yFO+zlWk4bOrqjf6C
	OsKYeCmRMQY0PBnbdeTKF6bEfNLiWo8PW9p6c8NYjbx0pgiuF0Hd37VdcXODlmYg9rLulwwZTvf
	ZMliBb/S4EXFESI+9VTb1dms0oxEBW5VwHI52UltWMqddVb64wlsTLgdm0x1VUWv5Cr73UUI5uU
	k1Hk
X-Google-Smtp-Source: AGHT+IEXTKNP4MKWcbf/JA1+bXvtEWlNT3ImVzjM+DDONN2Br3jW+udfgrQ804DeDzabWUv7DT92fA==
X-Received: by 2002:a5d:47af:0:b0:385:e5dc:e285 with SMTP id ffacd0b85a97d-3862b3e4f43mr1602093f8f.58.1733483653344;
        Fri, 06 Dec 2024 03:14:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:12 -0800 (PST)
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
Subject: [PATCH v2 11/15] iio: adc: rzg2l_adc: Add suspend/resume support
Date: Fri,  6 Dec 2024 13:13:33 +0200
Message-Id: <20241206111337.726244-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC features a power-saving mode where power to most of
the SoC components is turned off, including the ADC IP.

Suspend/resume support has been added to the rzg2l_adc driver to restore
functionality after resuming from this power-saving mode. During suspend,
the ADC resets are asserted, and the ADC is powered down. On resume, the
ADC resets are de-asserted, the hardware is re-initialized, and the ADC
power is restored using the runtime PM APIs.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 drivers/iio/adc/rzg2l_adc.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index e8dbc5dfbea1..2a911269a358 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -88,6 +88,7 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
+	bool was_rpm_active;
 };
 
 /**
@@ -527,8 +528,77 @@ static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int rzg2l_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = adc->presetn },
+		{ .rstc = adc->adrstn },
+	};
+	int ret;
+
+	if (pm_runtime_suspended(dev)) {
+		adc->was_rpm_active = false;
+	} else {
+		ret = pm_runtime_force_suspend(dev);
+		if (ret)
+			return ret;
+		adc->was_rpm_active = true;
+	}
+
+	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		goto rpm_restore;
+
+	return 0;
+
+rpm_restore:
+	if (adc->was_rpm_active)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+
+static int rzg2l_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = adc->adrstn },
+		{ .rstc = adc->presetn },
+	};
+	int ret;
+
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		return ret;
+
+	if (adc->was_rpm_active) {
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			goto resets_restore;
+	}
+
+	ret = rzg2l_adc_hw_init(dev, adc);
+	if (ret)
+		goto rpm_restore;
+
+	return 0;
+
+rpm_restore:
+	if (adc->was_rpm_active) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+resets_restore:
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	return ret;
+}
+
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
 	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(rzg2l_adc_suspend, rzg2l_adc_resume)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
-- 
2.39.2


