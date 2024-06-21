Return-Path: <linux-iio+bounces-6699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B691302B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817121C22964
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2116A943;
	Fri, 21 Jun 2024 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="21/8oaao"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F1817D351
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007931; cv=none; b=iZRUtJXgxIEHzugUdSEA/MTj8gAUQBy3ZUeUeFdv0A8qmqznv0BKG60I/OydpxZSJDO0XOGrPx4Gp1qtt/Lmoud7mbMXMl6X8EK0RBFaOdsvXevOkcR4QXGQ8I4IsCow36Ff3siPt+60rr8EykFj2pYurQx7Vv458CvzByUxOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007931; c=relaxed/simple;
	bh=c45u7G6z+GsvBppir2vDrLXceKh9GQoDTGQPqSgCblg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dhxy59kNP2m/qd5SkQvtELdrB2jvzoB3KSDTNYn5yazqrn20mF2kpTupSqvG5yS0A7m0NeajJAo7YJfThVSWDUzU3tOg89ECgPkriFukg17ELXTsUg8bodBol7eu5XNPAalIkb82MiwpSue7dOfnAhBFnzIbEB5HnwNYE2RFX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=21/8oaao; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b5254f9c32so1170881eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007929; x=1719612729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so6aBU+eDqnCDSaguZCLxm5y7z6KxLSHynmcPlHhQSc=;
        b=21/8oaaoAhWaoKfyLfmqddZoPGo3O3NfVfQ4wrABj7dJ36AEyGi0/6KaOxi5DqZRxz
         kKXGA6lDngh3lxd80xqA4Tc/XHJcUP4idNtPpIZnlNl2fJqiiLJVnap4NBfLi60x37LX
         ETnRxfMe5OjkpHEyxSrKCD7f/2IEFwULM1KrK/OczWMUSs5N2qHNg42TQiFWoLOA96TQ
         OgjvK8hap9MEidgXQxAch2ZYbuMeRw4SeMhXVYwXp8ucwE9eAuG+r9aRMdH/aFWBuHqv
         oic30RmpcLO6KUt5N7ES08e2MLbx+T/zzGoyH3veVOT3LdR53dXGcD8Te4DjyjIVsKge
         OMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007929; x=1719612729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so6aBU+eDqnCDSaguZCLxm5y7z6KxLSHynmcPlHhQSc=;
        b=UYxgeORMMC/gKbM81m1mE4A5Zwjk4LmwhLK+j6FOpyYScptseIndJA/zYdYwh9OUP+
         jVHSWR2PBjNqBvc8r2ymCoPkvDWuNm2G8cvrR5BJ6z/MHs/ucNm5pJiTyaxBmBcNcQTm
         XDdtkQPeaBZ8OkNr5Q+tgMNV3XSSobCue8aHsJvMRbmYYV5I1qJUw3JBEOd60+T/GVre
         oUXGLv08rM095cpz9u1Fj6cgqZPqVt/JSLwBZLKhshzc8pGFDVws9LB4tKnYhs/L2xwN
         UUX2zQdHUF26ayGYGPF6fxY7fmOrca2mgnHv2AdfzOlhi/XDcz7r56UAaVmH1HMXFMto
         JfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX20aGgPGWNELxpDkBERD1O873MeMMGfU08Z3wez6j05SFEh+K6HXX+fBFh0G1basT1AA1TZoDqHBwvS9U1PogGJygRMJ9G1284
X-Gm-Message-State: AOJu0YwzNe8SWeN6dF8sS++Nxw0hRXuVXVauNRO47NnRvND5uyDMgiFu
	Sqg4k8McBJk/J+8nHNmXaDobw4724i1OdX/wPLp0Hml/pypjyKY6ubtmovOrM94=
X-Google-Smtp-Source: AGHT+IGCM/8sRsLCLqFNICTMywqS3PsKIuS/B/sed5essCH1YgcxL2TzQancR7MJmS3Wfz2Pkd4FGg==
X-Received: by 2002:a4a:3c5b:0:b0:5bb:294a:cb90 with SMTP id 006d021491bc7-5c1adbf1d68mr9897886eaf.5.1719007928519;
        Fri, 21 Jun 2024 15:12:08 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
Date: Fri, 21 Jun 2024 17:11:54 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-7-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
References: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Use devm_regulator_get_enable_read_voltage() to simplify the code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-adc108s102.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 69fcbbc7e418..9758ac801310 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -58,7 +58,6 @@
 
 struct adc108s102_state {
 	struct spi_device		*spi;
-	struct regulator		*reg;
 	u32				va_millivolt;
 	/* SPI transfer used by triggered buffer handler*/
 	struct spi_transfer		ring_xfer;
@@ -216,11 +215,6 @@ static const struct iio_info adc108s102_info = {
 	.update_scan_mode	= &adc108s102_update_scan_mode,
 };
 
-static void adc108s102_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int adc108s102_probe(struct spi_device *spi)
 {
 	struct adc108s102_state *st;
@@ -236,25 +230,9 @@ static int adc108s102_probe(struct spi_device *spi)
 	if (ACPI_COMPANION(&spi->dev)) {
 		st->va_millivolt = ADC108S102_VA_MV_ACPI_DEFAULT;
 	} else {
-		st->reg = devm_regulator_get(&spi->dev, "vref");
-		if (IS_ERR(st->reg))
-			return PTR_ERR(st->reg);
-
-		ret = regulator_enable(st->reg);
-		if (ret < 0) {
-			dev_err(&spi->dev, "Cannot enable vref regulator\n");
-			return ret;
-		}
-		ret = devm_add_action_or_reset(&spi->dev, adc108s102_reg_disable,
-					       st->reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->reg);
-		if (ret < 0) {
-			dev_err(&spi->dev, "vref get voltage failed\n");
-			return ret;
-		}
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret, "failed get vref voltage\n");
 
 		st->va_millivolt = ret / 1000;
 	}

-- 
2.45.2


