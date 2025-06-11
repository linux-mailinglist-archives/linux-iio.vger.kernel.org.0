Return-Path: <linux-iio+bounces-20504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C13AD62DC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 00:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29971BC32F2
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 22:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE725E451;
	Wed, 11 Jun 2025 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Yce5wZl8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12525D1FB
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681766; cv=none; b=IiHai2PZuMFLq8QfYSdnNUxDYzUhwhrQspAx7SCejp+FxIWAz8hdY91uvqFm1fYZrOboVLUa+tSYPE+8Xedwz4mrWQ4SAju5aKEwUcAkYl3DDUU1l8evKm7nzqEWZZSTFKvGoOUr8A7C288IZslwbODTDiOprlMWSYZioextxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681766; c=relaxed/simple;
	bh=5XDESMLoIhQpWzCEq2C2tgUyVZF/Bo3//3/twALhLps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTQCkjdiS1Q457RxbolXJUxVWHC4di51qz1Cui6KtudA1gBaX/7U/9+GhJeCcmlKu1/rU4O+aE598eCO3ATJSEs+8awa939sRzDzr0TAjmi5VyGBswbJiE8Rd2D7l/F0hgwg4AxMCqdgpBzSJKUWaYTmNClSMjiukuXnmv+Op00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Yce5wZl8; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-406e31162c6so124085b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 15:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749681763; x=1750286563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grWWpqkFx3VZeZHS3cu1IgF+mji/0suRYvkUNQaAo2M=;
        b=Yce5wZl8NcnZGnXze45VBERPr+GdgfJgXDu7W9+7O4mlSOhmYWuxbahAMR1pItW4i8
         9+yHbhjovbPzZHhuOlYaQci78vz8qG6/bDxUmFWNFpgcAullMt8hGbJn1vnel76/k1B/
         1nNrDk8c21rGaY/YeBedGXngZhsNqD3vhYUrfLjm/INZ6smdulVAGnuxzCAOi6iPpOd/
         H2pld/c6Qflx/mTKkqVbKU7KfrHikYVhnIKBF8dbyziI8LW1fTNwO6mCF1KQl2K0HUme
         QhobR4Eo1OvYEshoAar2aHkp8sxl4z93Ve3DKmHQAd1ViyJW2xBU1P4rWbpL4Gv3yevh
         xbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749681763; x=1750286563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grWWpqkFx3VZeZHS3cu1IgF+mji/0suRYvkUNQaAo2M=;
        b=WXON6yCBvLVdOHvEjZGsrWRZ02OxprCGsAntlpHkmhx8eXwTNwo3RTLS5iGrgUVsro
         6XTMncc2dp2H+GCm2xmoUM/5ApXbmid6Fx6zW8Xc73mZTNPW832djYZw97rrUSJLKCDh
         Y4OM+zGMkbq+TzelZNbFbAFo/TmQ24w9J5aGsFnrNSH8hdb4W3XFKFxc5HkD/e29bR6w
         3L2VDOucxNn17/7vck1DK1J2mojdef3zm2lFgZ+mN3NscIbY0ny2sVJkvRmtyQ3hLABU
         jiBIbexL0jto65evuc2UI/83KH05Wi1CwHwlQjXK3S+KfxJRPcNrvlHyIZ511CY78yZ1
         Gx4A==
X-Gm-Message-State: AOJu0Yzn1atdvTXz3WEDoMjmWnxTaL48np+5Qm/2bETJbJeRtKvC/HVn
	C5B2k7CYBqKl1mbhd2oIilAHvEG4yN1ogodH5eq7HRL0M1J6mmLYZ2iPa8U5XVk6kaI=
X-Gm-Gg: ASbGncugVOXcEwZNI7okUTkVUGo/rSSc0MA/kRHvak1HJOxFcaYhRI+sv+aXZyN4SgF
	+RS66PiFsFN3Sb1cpzk0IK2nXn3hfEkKgR47mf/Gf00/S6mtFQ8ocMxmNGREsZqQx4yKMjS1bfc
	R43Uspryuj+gBnE1DUObZBeob+fYVTXbyCWG5298VXgcRbKLl8MkfJ3sW54nEYvwZn+sXt2gLNs
	RJGTOVnDFbUgUIktYKFxylvTuApSCoL+fkR6CXLktPQoZ4xoHukHo19fYI8ChVqPGJpOTbxkGPk
	ftfTaap1wBBkMgkXx64O7lCsB9eIIzLeX55ooxU2f43eV3Am+MVVmQfY3P9lhNksmNdtpG6RCnr
	jC6s=
X-Google-Smtp-Source: AGHT+IEcwqu4j736p3LcoP9RK7c1t3h3vtLigrmQmQXvolB9PCLNg9UOQOYCbdmCSMZJHTC5173d2A==
X-Received: by 2002:a05:6808:178d:b0:409:f8e:72a4 with SMTP id 5614622812f47-40a5d05e776mr3722453b6e.2.1749681762900;
        Wed, 11 Jun 2025 15:42:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a682fbf05sm24684b6e.32.2025.06.11.15.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 15:42:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 17:39:05 -0500
Subject: [PATCH 13/28] iio: chemical: scd30: use = { } instead of memset()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-13-ebb2d0a24302@baylibre.com>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, 
 Roan van Dijk <roan@protonic.nl>, 
 Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
 Jacopo Mondi <jacopo@jmondi.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Mudit Sharma <muditsharma.info@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=5XDESMLoIhQpWzCEq2C2tgUyVZF/Bo3//3/twALhLps=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSgXZRwKjwWR/y52G6u0y4MdHz3+z3OU7EB2di
 1dhrLGz2YmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEoF2QAKCRDCzCAB/wGP
 wMtsCACJ/xWk2LPxNgDVgxzxAyBLwPF0PwZ+uQ2OnVZ/GKv4J2FuZDLTEK8T1XbSMOtLfNe3Emp
 g1WSmomvx01TlhG5cJCNgELnTbtZDAKvzuZ3aJ0YaAlab0axLhbvOxxqK5KcfI7G1vuzwrVwjRD
 txipOkAWnZ1mGS1U0hXSv4oYKB16S5Z56mkqqgOjtzjZEb1+YGybjl73FD3eN1K5SYYrp2Z6aqV
 glfuOs3MYd4xbj9SpdPMC+zKvBKyjga031caed8DL3D7MvrboWa/CoWmmIAJfMRFoeO2+yr84yT
 zqstaruPKxBUMHnLEBtRUeoXXFrx6mJM3kA7FDJl/xC7bJkC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use { } instead of memset() to zero-initialize stack memory to simplify
the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/chemical/scd30_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 8316720b1fa32b9746b4aeefe7aedc77b3ba57e6..5df1926cd5d985a60c7095f692a63093d522d434 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -587,7 +587,7 @@ static irqreturn_t scd30_trigger_handler(int irq, void *p)
 	struct {
 		int data[SCD30_MEAS_COUNT];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int ret;
 
 	mutex_lock(&state->lock);
@@ -595,7 +595,6 @@ static irqreturn_t scd30_trigger_handler(int irq, void *p)
 		ret = scd30_read_poll(state);
 	else
 		ret = scd30_read_meas(state);
-	memset(&scan, 0, sizeof(scan));
 	memcpy(scan.data, state->meas, sizeof(state->meas));
 	mutex_unlock(&state->lock);
 	if (ret)

-- 
2.43.0


