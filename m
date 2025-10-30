Return-Path: <linux-iio+bounces-25687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA73C2139A
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 17:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F5104EEB37
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64DF366FCA;
	Thu, 30 Oct 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtXl7teC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF3366FBA
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842110; cv=none; b=PY0aFmM6XG8JS4tWanMkhFjX/Z57Ce9D7uRJp2u70h6alEBnL8hpXEz9dpeIG1aMGqEO4zEjLZ0UVHNhaQwF1k0klUx3eY2EacwnD/9WPhrNRVIvGgFdhF5DRLTq8p246pz4GWxMRBkZUOVI4rtT2qGux8tLBbtFpRSwxH/79bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842110; c=relaxed/simple;
	bh=KJhi7r1IxwKr2jceL8YpXI0OH3nQqefJ5FVtqYdua5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=od1gUIEavchsKuBQNT6fftR1whPXK24spCmlBGBTv5m4NiWeHa+L6c5ZsIfm/qgVCVoTXlWpf3le9b4PLe8bJ2LVnHTCb5dvuEjTN5qIDmOkD1E2kL++ZusbOTH9M3+BZAcVgGrABAFkpDNOgZ4T6KbVnzG6Hhcv/BXdT8ZqxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtXl7teC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781010ff051so1121450b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842108; x=1762446908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGxSll59pDGaTOq1wz4y9sLfdgQmv4t8Ak/F6aB1JEE=;
        b=RtXl7teCAhVeKP6/PyY54VoDUTJsdL4qEgzfduQcdLicZXxhKzc5IR8FyYCIzxEOxB
         bKc8yxg7YXAR54SK57pSjsNf5r7MRX7YElNQh6IVl+IF8Mmbe9KiQJyUVOEXqSsdwVOp
         NQMYHxH0tPGP0o+KtxXzih/4/S4ARFUiXPMxD5R0xPBG6s6jx0YWzuANpHM41yg1TRSm
         BOwa9B0c/QFKtjSsPS4c8YtIcYctGGalgbQqtIGjvvNH2lm+aNyWhRBigKv8rHIk5cu+
         J884vJfMfZ6fxscpY3YZ+j8HeOZUXRI1bVbvqJBATGm/IjFeP3VYS1tGmmJ8dZyrUpL4
         tgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842108; x=1762446908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGxSll59pDGaTOq1wz4y9sLfdgQmv4t8Ak/F6aB1JEE=;
        b=mKNrXyuW4nsY5EoiV1xBlYcSECSuXPdm9m/bItfn+nMD2Q6OwWxFftJggtTM7mfyhj
         KYkPfCD6sNBvpKa0UxNZ9UaJUcqcpklKBDD9qw+TqFMpPRBhW7dRdWezHEyVPjuqYtLk
         ZtMxwyI3EEQLsT5cvGxB4AdQJInnnWrhDaLvj6zTxI4Tbv5rsLxPwuK1x3O6fCo74Zvg
         snFnquFqfxoozxm/lMLs41T28Tsu2P/M2yUwOuyKaXWZmNQRs+jmHejNFXoSETQdHNSi
         kFiQUkIjNFJmixSZ8YxbUgNV0OKbLzpQ0jPhkKuAk/2N5v8Bb9NdWcHX5nFHVPmnLCMU
         gmDw==
X-Gm-Message-State: AOJu0YyiLQq0WgEo5kO/LLhITa/dP7CEjRQUXpDSN1xVJtWMspD3cD+o
	KTBuT5/Q3j81u4/rp8XI3y9wrH51n2NGmtVrJV8fQQhYdSvAu3wv27CsSepUeqMt9s4=
X-Gm-Gg: ASbGnctFPqG2ZIG8mfbs2Bkx9pnrwhbzQ58lXTXxx2NHsftOBl0GNSOOTW0sfHHrzLA
	EpFIVRqNAUNh6xtgogGv3xZUsxxQEGiAupiC5cVh4ct7p6KpWFHkdeYo9XakfKT8UuPm/6lS3BW
	CXYnM6i28zmUxaetSSHMy8DR+hVlEFwLYYLe0hsnEYynujcskGt74qgW6hhRy2LFnLAZGuWjZsn
	OCuW3svbulmafhW6AL6pBuaHUKFA3ZVgMb88TBpl9BjgamMC4PO7hL+ys2iwQ7skELkOUMmMuQL
	AJlESQ15hEKvUYKiyd+A0bG3pLPmgtx8TG78RqOb6+zUx0eFW1kYKIfTkpx6bpDRr7PYClNzioR
	WBLdpXd38Y4OcTYDCQgQAUzmAmLylQhNJxk12PFpjne0T3BDon+Cwm02Q44K/dd0pYWCg5cn8H3
	yDbGDrT7d7OGzyA6tgpyx/Mr4y+P9jKqbHHqxiLCcTXf0+pOdtBe3cpq2rgsWbNukZS39DE9sUO
	X9J1GjfXHPn9TiVPhlDhYdyiTaecbOZH7U4/y7CBGPN2Oc=
X-Google-Smtp-Source: AGHT+IEVgKwJVYk3LLzSGMiiVO2pd0zD6q0iNRm3NjG4WchOau35P7hbFf8JKXrswaA2JhS14jL/xA==
X-Received: by 2002:a17:903:2348:b0:290:7e29:f59f with SMTP id d9443c01a7336-2951a3c366cmr5308655ad.27.1761842107861;
        Thu, 30 Oct 2025 09:35:07 -0700 (PDT)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:339d:c9c4:e069:47f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm190932845ad.100.2025.10.30.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:35:07 -0700 (PDT)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [RFC PATCH 3/3] MAINTAINERS: Add entry for TI ADS1120 ADC driver
Date: Thu, 30 Oct 2025 22:04:11 +0530
Message-Id: <20251030163411.236672-4-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new MAINTAINERS entry for the Texas Instruments ADS1120
ADC driver and its device tree binding.
Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a7..1efe88fc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25613,6 +25613,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS1120 ADC DRIVER
+M:	Ajith Anandhan <ajithanandhan0406@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
+F:	drivers/iio/adc/ti-ads1120.c
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


