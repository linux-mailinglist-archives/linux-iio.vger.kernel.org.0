Return-Path: <linux-iio+bounces-19518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45BAB74C9
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37F38C4490
	for <lists+linux-iio@lfdr.de>; Wed, 14 May 2025 18:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34226289809;
	Wed, 14 May 2025 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AISI39mK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635711F4CB7
	for <linux-iio@vger.kernel.org>; Wed, 14 May 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248784; cv=none; b=S/u8bnlT/p83QNc2tVewFs25ErtwLI5yOZis7wD927jopkDj9oIsgW/H7JBsiryX8MKNou0E0RCSiuSGX2yi5kn01JEpO3++FrFiiCJ80Y+Q0PWW43yuO0+9R406JHRiFhekRR2PIJ2Nhgd8PSkfvg0iNAwKRqtms9vpLHNqbXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248784; c=relaxed/simple;
	bh=3RgcHARqnAJced/zs10JHBkUyX2lh3u22zAbn0go1JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moBcyTybWZ+GS7ycLzJRDaMvZAlT1hdfVThVMkT9RaVgh/jIaqmmWK5mqb03JzFHI7seIjOAu30FT+UyEJ4i038hcnTrajQxR1+zzIwUvwxXTfAeXai1jF6Q0z2Oi08MKvdXHK9kMDt/vjkAxlOY26e+CN6IniWQLzyCHmUWiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AISI39mK; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so31470241.0
        for <linux-iio@vger.kernel.org>; Wed, 14 May 2025 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747248781; x=1747853581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/ASA9BDi8yEO5MEUBlBSX333Yc8cFbruCFi9WNhI04=;
        b=AISI39mKOJWbRjJfndt38NBxzCeUSKe5uDTAt2oug4H4iDfWZlqvpQz9BqEMGXSs4Z
         d7LEGkxStPGgG1aV2u/eLorCNTMNLOoZCGVaWn5jT74Deyw1RvAL4sdyWdeFFiO5u/cu
         zx4ax0Pdk72WUNnVADZ/30KAott4TCyd82nxsQUD/fb9H/BK439ox+udllUktu969ZnQ
         XvZ0RMcZV8QAEk9KmkPl3puCRCO0c2rLD7P8sTDMQvZPvgdsLV0xOZrAakZujuIhSTqy
         kdfvrrK3rkgIFoIFf12BErIwsgvtGIZlsp8xd61dIHk9g8S8FM4955nWOeXMBkG6TX3y
         WHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747248781; x=1747853581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/ASA9BDi8yEO5MEUBlBSX333Yc8cFbruCFi9WNhI04=;
        b=M5UI0y9GuRjblkRYYwF4VHc582M34Z8Qsj6IaApwd99uyLxnA4DlKkoZ83SRGB7bv8
         trOoNNX88LaiQkOE/TOVMh21tPI3YNB1s5xJVQGCC3b18KuU+MY/dGn5O0wQ+J2DMVjI
         eQ+bjStz8qksYkB3OBx+CJVx6WeLh+ie5GbUqRzxLN/WpDjBbb58RyHu4OjduVWxW2aT
         ik2X7s5HeEsaHaCZl09VvCdmogJt8JjXIOxFEqo3E1bxfx+M+cJ0e7nzInLJYxHMheOT
         rzuTTkE+/Wba33i11X6TLuv+0qPk5kUVWBiXiao3j9Y5jvOjyYWMpuuDUHMe6iDSIFoJ
         kjBQ==
X-Gm-Message-State: AOJu0YwgIu+++l4lflmpdKBQBlp6Xw8k2A1WkGsJNpBc8X/lrsWg6CiA
	cJmGdUK3dteHXVzFWxDRWkEaKi+Ge1VSCbsvO0ix+xF1smoEB5pN
X-Gm-Gg: ASbGncuOb4qCpuYL2NyKTioSkC2tlZnVmfbGqcNFsAXWUSGCY9gW12jwsubMuMK8Qjn
	19kAxTiyYhIH6YfLzk9DsJkzntbthB2FOC8dv9S/1mdItGqSkKfSE/TAjDhZY5uDi8gyjBpFFJk
	y6tJOO+30wgv/fLHDJijJDsSrapXyXO5gFAFr3H2uvFBxwxIrEdV7Y1Ng5W1S/s6dljouuGJItC
	cJhqWaevUO08NvO7Af3ywVWo+A3RULrr1KdXTiKCNJQyqnlXy/WUxUJKP0f+gM4fCKQYQOvNPRl
	e1Z6wY57CZLdoSJ4QcakE8BGDf3dKBO7YLghjvY8aNptPbflRZU/swhXO33N0Wyfq0dJ9pHucBS
	nLDs=
X-Google-Smtp-Source: AGHT+IGiC8tEpn+sKpmQBU3BG/U8ivk/X3odn7+TfNS8Or4f8y8pLCJrv2k78qoWIV8+7ZDrWCZW1A==
X-Received: by 2002:a05:6102:3fa9:b0:4da:e6e1:9196 with SMTP id ada2fe7eead31-4df7dae026bmr5281926137.0.1747248781225;
        Wed, 14 May 2025 11:53:01 -0700 (PDT)
Received: from biel.taila13fa3.ts.net ([179.87.255.82])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4deb203c26bsm8669589137.27.2025.05.14.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 11:53:00 -0700 (PDT)
From: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>,
	Cesar Bispo <cesar.bispo@ime.usp.br>
Subject: [PATCH v2] iio: adc: Modernize single regulator call
Date: Wed, 14 May 2025 15:52:20 -0300
Message-ID: <20250514185239.10078-1-gabrielfsouza.araujo@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a single instance of legacy regulator with devm_regulator_get_enable().
This change improves code clarity and aligns with modern kernel APIs.

Signed-off-by: Gabriel Souza Araujo <gabrielfsouza.araujo@gmail.com>
Co-developed-by: Cesar Bispo <cesar.bispo@ime.usp.br>
Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
---
The first version [1] did not compile due to incorrect use of pointers and improper 
parameterization of the devm_regulator_get_enable() function. 
These issues have been fixed, and the code now compiles successfully.

[1] https://lore.kernel.org/linux-iio/20250429160526.5934-1-cesar.bispo@ime.usp.br/

 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 226285992..8b2e798d0 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -923,7 +923,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 			pm8xxx_eoc_irq, NULL, 0, variant->name, indio_dev);
 	if (ret) {
 		dev_err(dev, "unable to request IRQ\n");
-		goto out_disable_vref;
+		return ret;
 	}
 
 	indio_dev->name = variant->name;
@@ -934,7 +934,7 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto out_disable_vref;
+		return ret;
 
 	ret = pm8xxx_calibrate_device(adc);
 	if (ret)
@@ -946,8 +946,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
 
 out_unreg_device:
 	iio_device_unregister(indio_dev);
-out_disable_vref:
-	regulator_disable(adc->vref);
 
 	return ret;
 }
-- 
2.45.2


