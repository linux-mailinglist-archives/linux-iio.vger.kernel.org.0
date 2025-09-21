Return-Path: <linux-iio+bounces-24331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61150B8DC35
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 15:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E1017253C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5B2D739A;
	Sun, 21 Sep 2025 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhiS1r4B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458523ABBF
	for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461674; cv=none; b=e4tM1LMCIwdYiUlVkcEq76YhIeIcWjISg+rv2oCRX8/x3oNkfNddtf4cUtUKv1zVjFvnnSvvwHq4vgdy7i9Q7j6WHsrZWWSH+5UralSnU09zOJPSaRbh6g4aThThWL0kguJ4Y/G9sRHm0E92kmk8tL4bV5WKw3TUC8QWrMM72Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461674; c=relaxed/simple;
	bh=W+MdQviWUrHmllDXqPNcRT0Vif/KVaI54aJjs7g2kRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SZlbh8Ulqeo3L9IHNMx2BW2ICvP8Aq1ofUV+61Q/Vmi9KoeBufYkgz8Rvo5OTt+zb3c1+pVUreQqleMfVvWdt7wVujsede1r1IHbPv7AQikZ1DNzY0a97lmUoD5m1ObFNFF46a9sIXgWZeQTHnUDzMIanQubEc1ZFHxXf9zIV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhiS1r4B; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee1381b835so2224886f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 06:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758461671; x=1759066471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMhhKCmyO0tkOfkSwmubre93MqE7/JLPoa9fLatUrvU=;
        b=RhiS1r4Bm5Ywpgny7F/7/ERcxFuVNZ1dLhJH7VxyiA2uQr8wjfbaiLOSVttpBRIWAe
         cNShyG7WMtyzga/baJiM31+ibBixPqsRJmuuRD5ZTi6uQTyuNj2ahWxj69PwhNfeCemG
         YBPYyq731QTmVexQrcZ/Er0KVuQafQ497ztt7+L5fX7920B/OYAAPPwBl3cz8WGu/Nch
         9/8OSHPk9fMS3INDh0MtZ6gsuBJ/pX/twCKP8Ie30TEPnoomVrysc9yjbVs6pJwx0dg9
         rIP7hmeY72SZv4Gtpybtt/TVLPJqI1yfqPqpX4XVHA0Yynz6Xc2JJHudVfPX+qjdALCy
         D6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461671; x=1759066471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMhhKCmyO0tkOfkSwmubre93MqE7/JLPoa9fLatUrvU=;
        b=QxXUCZJI+AEPTc/brKH1br8CU++13GEKiU5lFICgUGOwYjjBWL5l5vZvd7cdoU4Nbg
         q4sEm9ILeDxNVDn8+uSrCkHpCRLptmtHCrg1Uq3nAq+upYIg9En2JQRlWKSVFe2xvzhA
         yP004M92qPYeK6P+JqfSQ9aioLMCLZZbiIlGGJvbit0/qsVEdOmq9ppOelnlVPyJUwBU
         nbgqoBuBDOSW3SFAZN2KAfQnvGl7TGZopZGNEvX1uprrgeOjbALlGGlhEwzkdXWtyAtO
         G7qMz7o2un/HVnAUHiamgo2UmoDk+mMDp+X5Rw2IHpKdyi6eEkdmfKcp8qmrKEhAjdYP
         QQyw==
X-Forwarded-Encrypted: i=1; AJvYcCX6O1zOg4Y4dDZxlz+qfOeTMGbLqkyRLgFwrwS6odifSrJ3NXC7NMqQ4dC8SEGJfyVtlpgig42+cNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyURmd5x/2ir657NWgy6Oqdhppqtpv1FetvmLtjdqVWU9Jjpe6I
	l4O7SXvPTNzEf3Ls+b/AwyItHyXLAzHbu35XTStDsx1b9Ge7HC2TVHWO
X-Gm-Gg: ASbGncup8POOk0/Pio7l2UchVDTMmhzFL6P/qcYFZMTjFrfl+LMRIPN1KRMT373ApFL
	d3cEMTwDwHXqXD+avEN58sp+VgK9kdHhbWvcTEgH7II6p9vdAo5uGed4ZKUxHP8gxrwpAqC1gsC
	AuYF3gnVCioqMbdypKNsGNry3yaDEUPLbFXSUgjOyocrTCbPA+D0iO1CoeHeDrCG82mzJko06t7
	fgiV+EFoBkS4gyJQqO3Z4oxGhgkJ1Az8u/ETgXF9z6Q/13Dv2h6IZ5rCQS1VKdjE0LzTjGrjpBS
	CvXjr3+xxkCorTHcFf7R1uuTRph2loxrQLnef9RJ2FahHqMgfU37yNmFdLHDsyBTRuNOxzhCe25
	qwQ5+SvB5KV9ZHzaQ+IUHBEG3/Wp1loP6O30ASlRu
X-Google-Smtp-Source: AGHT+IEFtDhZUV//YELTB2p7puOk0cSYYIKzsLeyMKlfyOvsxg4B2DgsmNTjAlhUmPXeaySh7uGg9g==
X-Received: by 2002:a05:6000:2404:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-3ee7e10616fmr8560965f8f.25.1758461671168;
        Sun, 21 Sep 2025 06:34:31 -0700 (PDT)
Received: from localhost.localdomain ([78.211.117.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fc00a92sm15910316f8f.63.2025.09.21.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:34:30 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 0/3] iio: mpl3115: add support for DRDY interrupt
Date: Sun, 21 Sep 2025 15:33:25 +0200
Message-Id: <20250921133327.123726-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This set of patches adds support for the DRDY interrupt in the MPL3115
pressure sensor. The device has 2 interrupt lines, hence the new
binding. I also added support for the sampling frequency which
determines the time interval between subsequent measurements (in the
continuous measurements mode) so it's obiously tied to the DRDY
interrupt feature.

Kind regards,
Antoni Pokusinski

Antoni Pokusinski (3):
  dt-bindings: iio: pressure: add binding for mpl3115
  iio: mpl3115: add support for DRDY interrupt
  iio: mpl3115: add support for sampling frequency

 .../bindings/iio/pressure/fsl,mpl3115.yaml    |  63 +++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/pressure/mpl3115.c                | 247 +++++++++++++++++-
 3 files changed, 305 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

-- 
2.25.1


