Return-Path: <linux-iio+bounces-18916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E1FAA548F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 21:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32C19879CF
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA73265CCB;
	Wed, 30 Apr 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va2UMEqz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287E25B1C2
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040300; cv=none; b=jU8WE/E4E3O3S2pH5fbDRYgbkDGfEhbAzJGQEn6dvS+nr+BktWjaw4vjUjPBUPDwyD9tYBZBFqkTEH4u9zENESny+PtqtbHWQLFun0/gj83MCac1fF/GEGE2pGk0MQXDGp++uk7D0bA8njZPlFxeorJR8fmtjOdcgRZH1x+BBHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040300; c=relaxed/simple;
	bh=2bFP43dapbGWE4ZRAc1z0YiUHgpSgPNLpmq5PzY723Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nDSFLo/wOVnMKz0eEHwW0AxR2+sTd0ROs9dYhvd6jdv2tznB/RteOuTUbtf13oP43lTDIYQyKb94gb3KlkBixPhAUbK9XFesvtpDdeO5hGCHVCm/uaT5iPqcTxSCbhg5asxeEihHW034e+IkwJdCrooyDm7ut3vTCND3w/683c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Va2UMEqz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-309f26c68b8so35796a91.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746040298; x=1746645098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wQTtv5JkEi4ThxDf2+1Nb34foz6ML8DQS11ZqZOPb0Q=;
        b=Va2UMEqz9pXY82FUM6Mhwl6roUKbwtcn7/ErbCwAqDrindc3vLfFEs3uiVlURPRMm7
         HZUPciUd8K/oA0+re9pagg5/F8Bce5vc1RNXMj2pwnG+wqEFta8T9ftKcbjlvZz3fxWU
         43B+NKiYUa+2lcfl9OH0XlTbkCdaM0F1iCViapbbqbZ50Js8SiwOcYmM8/k/5NXfhADR
         sZ59m4V7xAWbUVjWH2cu3YApEP85K+sl2tMDZLGT6Bsl3bAhpqxk4LOjQ6yGdSNAg+MK
         BeW0AcZJBvYj79LWLMpWfQvzPGUniPn3QjnhoV7N6b4GfdEBWA0MhrGLIZM+9Gut3QOZ
         VHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746040298; x=1746645098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQTtv5JkEi4ThxDf2+1Nb34foz6ML8DQS11ZqZOPb0Q=;
        b=bS9Gt+fHDNINzdIwg8jBXheowQf9gtYQ+SkTObw7CI2yzyabWk32SZS/6Oe3QZn86k
         phI8rfqmTVBG+MHSCZSUdDNnakSBKxxn0uUS6hwbKID80L3/A37SpsJTQDoNfHayCU1S
         SX2XvEfNqX1VfBSnXgrH4ddfFNebhcm6mDRMX481obTMlWye8DsYWLtIZmNOzPSNKDPS
         DSWMtCR3iQP2/Dihe4dq1jQqRkknx9Cs9cr+M/O6tz+cPeKhavIdOfB9TS8FHGppwiqm
         fSbBdB5ffXlZXfX6mkEf5vSrnPOl6VMfDds9MpHpr+dNwG/WcZMu6+n6cERnl3B5GVhh
         mTng==
X-Gm-Message-State: AOJu0YzEzZN+ijhJaan6khgf/eXChnRuJ7gmB7hJHTmbE45OmoUij65Q
	7UlZ1A73EXyPScS2KlzYBMsKrNpBDYzr2XV6ni2Sm5sfxJP0MXeL3O3fjQSNhgI=
X-Gm-Gg: ASbGncuwzzXDSzilX8qmdtz3uv0e8xpVSMfh0n1tNXC8zuMJdawTN8BMS6oLHh8eMgY
	ZbJmcUYhgZKRlcYrQDPSWB7Za9Cbzgsw9ZMPE2QCay4Ofc2N0TaUDdu3jUK4cjnD9JC+60uWokD
	VMLWjS21sGh+/EojYoMKCUciKJC7HRn6LbeHemxwxfwCbmTNWfL0srCsidMi77CE5hE3DeXLqpn
	NtSL8pe66JGw8+nEVQ+XE0kNY9d76mihBrTsynp6nG2cKZJtWdVfcy7qPCpeyY19OHdzKP+oyYY
	SBwetgsN3jF2FoX3TbUMU4yNwgTFGbkyfIMwXlVDRUSOFld4anDkxgaNmhQ=
X-Google-Smtp-Source: AGHT+IFloEfvMyu//X5PmF5lRNVG521QJzIMBp4X1fO2bXwv32UV3RSu3rhz5BkZXagYnJpkrKKOag==
X-Received: by 2002:a17:90b:1e09:b0:305:5f20:b28c with SMTP id 98e67ed59e1d1-30a34a96ae4mr2088048a91.5.1746040298506;
        Wed, 30 Apr 2025 12:11:38 -0700 (PDT)
Received: from arthur.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349ffeeasm2030413a91.13.2025.04.30.12.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 12:11:38 -0700 (PDT)
From: r2.arthur.prince@gmail.com
To: linux-iio@vger.kernel.org
Cc: arthur.prince@ime.usp.br,
	jic23@kernel.org,
	Arthur-Prince <r2.arthur.prince@gmail.com>,
	=?UTF-8?q?Mariana=20Val=C3=A9rio?= <mariana.valerio2@hotmail.com>
Subject: [PATCH] iio: adc: Kconfig: add kfifo dependency to fix module build
Date: Wed, 30 Apr 2025 16:07:37 -0300
Message-ID: <20250430191131.120831-1-r2.arthur.prince@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arthur-Prince <r2.arthur.prince@gmail.com>

Add dependency to Kconfig’s ti-ads1298 because compiling it as a module
failed with an undefined kfifo symbol.

Fixes: 00ef7708fa6 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
Co-developed-by: Mariana Valério <mariana.valerio2@hotmail.com>
Signed-off-by: Mariana Valério <mariana.valerio2@hotmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..513f2238fdee 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1492,6 +1492,7 @@ config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  If you say yes here you get support for Texas Instruments ADS1298
 	  medical ADC chips
-- 
2.45.2


