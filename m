Return-Path: <linux-iio+bounces-18930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE786AA5CF4
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 12:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A3D4A7395
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10144224240;
	Thu,  1 May 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5J1kff1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E150944F;
	Thu,  1 May 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093724; cv=none; b=GWikWBu8bj3LyzMc5R2xIr7G6EEtngmRMijVZaPTq5Mf8/IODJS4v0SYsyPmYfktF5MugmeyPco0OTa1md7m4SXRMEdPk1Ffe+sAaECcVzvefL843AWp5KjnLDC8bYy/XQSI312Cl3lfM7HyAVAXa1iCnriMPYF1RifHzl9Ttw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093724; c=relaxed/simple;
	bh=/TtrDcnI3jGwmYe99ghaQbY6F5wrZGqA98bdnfjCyNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H0dkGRRCsXaR//6T1iRPqlhoqYRQJ6k8giDAGkmNo2YRV3O90j4h9sN3g9fqD/Rvda4L+NBQyN628QpqxcHHKkw475/LtUzj/twGynTnFfBKFqb2LF+Jw/Ig5sWrYR7O7BzrsSwW1krzbhXysv3nSDXJbeBnacF2k0/brJxweWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5J1kff1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so718397a12.2;
        Thu, 01 May 2025 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746093722; x=1746698522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+yshCywKiuZ4tPT9Q/qTWdnzUIcRTdbJjvFlNDsvV4=;
        b=E5J1kff1zjR4Ol3H6Pc/6S/wbXI6I40ZwTHl4B67DfQ3hL3D+Owift4iELye1wnvJK
         rjaWR44minLLq8wd/1Gnpnvdxf5aNWQBEqAJQO54JgpddNJsK/e1h2ujD+TmSvUwJ0x2
         TmWJ1LCF1R/ZNCZfnC93pObaeOR8dfXggwinkf8O1uSdPKbZCzDGNRKQUSOF5dyhVZMB
         /mzStx/gKcgb7uolYxWDtmWzFot/jRpXVxB8ACH8E3cOvoMEu9NaTWLkPVlOV13d5W+3
         a2AceabraDUdpHI21d8nlnnzT0+jLrgoKvJX064Vz3uuG8K+qDBMCS5TvA3sA+fBtoho
         dlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746093722; x=1746698522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+yshCywKiuZ4tPT9Q/qTWdnzUIcRTdbJjvFlNDsvV4=;
        b=GhQ4byyUwBA2o/LkdBGpZEz5EskPNp1c0F+OCWOoerS08QBDgBpYdGPXr0aKVE+nfI
         HBKhhisdgwBoXupNpOPTOaTkAjimK5Kn0/hzWWUCNReNF34S+NE5A3eHsNzpRtryuuOu
         EYPHpFycVymyLpOLpX1FG6Q9TXmdFutAUYSpdqte/0kxxCm3ZOmk4Rkclp0ZfLl9QZyv
         YVoJp106JEaAol5h8/rLQbJlOdjoprg09eU69u6uripByHLH4hAtBSUOlF3mizYHFJhJ
         Q+0pjvkFQxcQXLHQqXGjCgqprJpruM4ICLEoAOuSsWLQ+8K8fswfdpd8n6yWBNI6MpKy
         E8zA==
X-Forwarded-Encrypted: i=1; AJvYcCWUnLUv5VwL10S+hgUmQjZ3RgIEI/GJViMWOjxl6Dph3WARnT5ZtUt8jvKyI/4DBYsOmnqTJez6XpOhg5rJ@vger.kernel.org, AJvYcCXsRYKKfVbStnok/8tzowvxMdUMN6pvgczp7r8ZO+/wC7PAch/LTvZFwBjB9bv8EQrmLuYj+O/R3ZTE@vger.kernel.org
X-Gm-Message-State: AOJu0YwSn3cEB+hEv/1bhpd/1RM6vDqOIyC/rlkLCIQPaSDD0oLy0nP4
	Kdv+/sg+vR3IERW1DCYzgClSv9be9ph2WGxgz8jzgI1QHZA5LwQ07Det7oNPRTI=
X-Gm-Gg: ASbGncswhW7G/DaxFnIt/c04aUQeGtcsgOpbNUrNpOcYXHjP7pFrUlCLYOo7+Go9fGf
	adtcQbNs6V8L4qatqb4AroQe8tzSHqcer0Sjlca12KL+uOOPOWnkr7tqXbRk2IkzbJPoY9fxynW
	BDZ/ExGxcEXGcLk8k1YTR6TaYAiNrGTq8Y1v/y6GK7/+9dI3ILbm/1lacq/IhQZwLi0E97e8WeS
	IxZ0Zql+naOyfBbDWhDtxo4aha+4PZDIKBD+ypKbMzUnSfhJpGpAvCNcd9XW9uj0MkyxcG7Tnyg
	wUSUdiSKXZ0M0ScuOkgNtBCi23wfJ545oSrZlIMjl2MJ+9+xqf22nh6tUw==
X-Google-Smtp-Source: AGHT+IFu5AO8aNSqxiixa8qxvLmhOycEFHviXNKuVoxC5raQFq7tT19VVYCPESFTZIqnVbPDXN9fDw==
X-Received: by 2002:a17:90b:51c1:b0:2fe:b735:87da with SMTP id 98e67ed59e1d1-30a3f908513mr4201362a91.0.1746093722467;
        Thu, 01 May 2025 03:02:02 -0700 (PDT)
Received: from debian.domain.name ([2401:4900:1c45:13dc:af05:2012:1f6c:ed34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47476120sm472477a91.13.2025.05.01.03.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:02:02 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-iio@vger.kernel.org
Cc: sayyad.abid16@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	olivier.moysan@foss.st.com,
	gstols@baylibre.com,
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	stefan.popa@analog.com,
	ramona.gradinariu@analog.com,
	herve.codina@bootlin.com,
	tobias.sperling@softing.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] MAINTAINERS: add entry for TI ADS1262 ADC driver
Date: Thu,  1 May 2025 15:30:42 +0530
Message-Id: <20250501100043.325423-5-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250501100043.325423-1-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new MAINTAINERS section for the TI ADS1262 ADC driver, which includes
the main source file and the device tree binding documentation.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cbf9ac0d83f..10b2e9293a99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24187,6 +24187,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
 F:	drivers/iio/adc/ti-ads7924.c
 
+TI ADS1262 ADC DRIVER
+M:	Sayyad Abid <sayyad.abid16@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
+F:	drivers/iio/adc/ads1262.c
+
 TI AM437X VPFE DRIVER
 M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.39.5


