Return-Path: <linux-iio+bounces-10758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8839A4B1D
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 05:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A32B21C8E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 03:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7841CF2AA;
	Sat, 19 Oct 2024 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf2xLP9h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF5137E;
	Sat, 19 Oct 2024 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729309462; cv=none; b=ByVhUx9lKctS5AIUcOky1Y79FiFZIBHYGhmz/99YIC6r9V7w5LnE6O7qX/Gjyu62giPwxIghb2v+x2B04SGA3poXkiCXE99wwEUQUgBFg/CZN4aJjbRi8JCd866Fo2B4aVGgpn0SEW96aiQTXtQPTpN7L2lkClPUDEcwDpu7RRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729309462; c=relaxed/simple;
	bh=9Hof6kLaX2KKH33qWdelzUil5kX+1EazXBDXIbgmp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqN6d33bgXgrgaswDkjpcy88Ade8RqPRr2qM0pKEIKztPoDr6+1XylUStPwysUWPT00l80+M3U7F/HxYIncYZLJQhOl9SOS1qNWzy8j+3ntWXAwst9/PfMiK571iQzQMyquNfFsUKahjNO3oFjAII0y9zagauIHwEDjP0iAC3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf2xLP9h; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2129409a12.2;
        Fri, 18 Oct 2024 20:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729309460; x=1729914260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eThC6hVzWsdHtEhWDhCbyZEHYHBJN4kvgmT/qDBPVlg=;
        b=Yf2xLP9h9z8VNqWZGQhBMepNPgFsMVSoY8oIEgt+vF2OMWLC/pQk0bF/0rHJmMNxUC
         36FqJTzUuRakzC7hqNn4d4TJs2w3FFHD0SpYfLWsQ+DHc/CKCNxF45RdlT0az0RCdM+n
         cMErFiJ6E+/Hmi79lF+5hI25CuBop8sXMuBs8/p7dH692aUh8oYkrMRG3Ej4mMlCLrlc
         pac+081EoH36GqNx+EaBEGyDTkSnu5h+IU/s/bFXp8/pWwNLf7HT8qv3rX79Sl0GK0iQ
         lIgwYMnt9NR+Xv6kMCX/10uY7A/P5oIi542AveJ2l728aZ4sr56o44bKMwL3nmVpWw9Z
         MS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729309460; x=1729914260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eThC6hVzWsdHtEhWDhCbyZEHYHBJN4kvgmT/qDBPVlg=;
        b=aFxsOd5WLy/VQSZ321F/YA2BI9u8+6G7QQQc1+hpc4e8E5/rYwg1RLJ0eWBtQUbKW8
         CwEHxum2Hjm9GH33d/6EIi+jTpcax0utmjn7/2NX4xmx+81mjlMUYqP/FLzZH2XQ16Kl
         k9JhJTsrg2sanuaZv/7xE+tGWCHCnGZ/omkWMCesYFU3Yiv460kcSh9oLLjq9shvJOhM
         kmUSAmKaS8RYo7/iZ8mgjMv/xVvCC98g7nBC7r1AEd6nGQ2Y0bPUU128G9M/5cfRxd1+
         DEvWAhNMkgVPJ96MaIC3JlDXE1mlXVtsJ0JFDvLtorShnqmQuRGl1RAcFP/1sfxMW/4W
         joHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Ms+EOI4h51+2xnPkRrAJ8wQ9aJ3MWqRMvmMhKLfsgc3FGac4UiYr6SO7IMIlZ0E9Sl24Ufsr0CA=@vger.kernel.org, AJvYcCV8yM+0XqTCBPwyNI5zcypwP4SDV6xNbe/ARsterN69ydRMg8qBEldL1rlx4JwdgV2mqkgB2S61tenTy9h9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2ndYqk3L4HMNNpCEfc8IIGjJ1lPw8SvSBeKhtm9Fedds418V
	z6qG87Fg8FUHQ0FJAF8GN+euUwfb+tnTftV/dlNCmGx86D4tp21K
X-Google-Smtp-Source: AGHT+IF/LzVEcKUcuB9qout1Q2wSfEN0p0a89i0W245kI2zIQGsP0IC01PUWfoEDP2YOLzl2/i50yQ==
X-Received: by 2002:a17:90a:f581:b0:2e2:c6b9:fd4a with SMTP id 98e67ed59e1d1-2e561756ce7mr5211959a91.18.1729309460220;
        Fri, 18 Oct 2024 20:44:20 -0700 (PDT)
Received: from ernestox.hitronhub.home ([2407:4d00:3c04:81a0:204d:4917:a5b1:22a6])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e5611d5d0dsm2869145a91.23.2024.10.18.20.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 20:44:19 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: gyro: list adis16137 in Kconfig description
Date: Sat, 19 Oct 2024 11:42:05 +0800
Message-ID: <20241019034213.429464-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adis16136 driver also supports the adis16137 model, but it is not
mentioned in the Kconfig help. Add it to the description in Kconfig.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 drivers/iio/gyro/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 97b86c4a53a6..3e193ee0fb61 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -27,7 +27,7 @@ config ADIS16136
 	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
 	help
 	  Say yes here to build support for the Analog Devices ADIS16133, ADIS16135,
-	  ADIS16136 gyroscope devices.
+	  ADIS16136, ADIS16137 gyroscope devices.
 
 config ADIS16260
 	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
-- 
2.43.0


