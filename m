Return-Path: <linux-iio+bounces-6087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37890144C
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 05:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D6B28218F
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9556139;
	Sun,  9 Jun 2024 03:09:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA64C79
	for <linux-iio@vger.kernel.org>; Sun,  9 Jun 2024 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717902575; cv=none; b=aNgEeV0C+Gw73XHO/qEt1dgioQga7ghqX+Vfe3KUOe4vTxAMoHV5VKrsaPnEyq9GEkBHcSiTl67NUqb1HYwa6Zczwg9+94kjWEFLCscapWjgUBmx7I0FQIMLoReKU63Txyajw8RNAmsMAgqn2wUq8dWSaO6t27vNmIsd1Vhba4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717902575; c=relaxed/simple;
	bh=idOdOi73qqy719T96GB2wb7ccduHCYGHON1JLMhJ5nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=meX5fGZKKR+sTica6hQQdHOowNgVfgwIU339Nk8lePHaXVLtI41WOUpmlGg19ZTPl9LSRTebMNYlhiICV3hnQyDw8FrUGK8SPvNk4qGBtN2iVr3nEnPzTTJGMmloUVcr+GXhhNf6wP/V50A1Z+8E4pS7um9P3dIwteDdSdYmAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2548a00c19eso827374fac.3
        for <linux-iio@vger.kernel.org>; Sat, 08 Jun 2024 20:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717902572; x=1718507372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmZ4dzc4NrQqvIlz6FsEQaW/bTW0g6StKvhfPvvX8ZA=;
        b=fi8e6V8juIzCJBSegCmw0NNS4arIdyRBLPVRlWZJl7LzmBpyGXbdaXz5VwIObri9Pt
         Rz4PRdeFPMq77zSJynpytGS37wgCnPCqxrnC4NtoZsWNUNWk4j58qZZUpEFPjgdfMqzH
         gSOLFGkT1mB5SHrevhesHtO/xAW8u3FjUCv3Y0SRDEApHn55rEF9P2n7agqqicZp7prZ
         HgdH/LBLv0rFh3RQRON8cV70E+IoGxXhMFj6szDObda3zTe8AI3Lx4e5GXwHajImaM8+
         +09Do/S6vkVvttBjIxHJoZvFNxaEbQURq6k7qZhQetVzZ8NKA2TZ0ICCVVQe37UYM2nE
         wkew==
X-Gm-Message-State: AOJu0YzOuplYeveYTv7Qu/leCGv14R0+hcn4esQcfvRS4yoqkclvMoXD
	Lwk+FfvkIezd7SYarx460nT4KVY2JVda7fOP9IIBPEFI49WiBdwtcT4hx6SqE2Y=
X-Google-Smtp-Source: AGHT+IGqY917suwVnfqPObr+mOmneqLgLtvisxwZl1vMtRK6y8YYAwnkcz4ypwdNewV/gExA0kluGg==
X-Received: by 2002:a05:6870:9a1b:b0:23a:982b:dd7d with SMTP id 586e51a60fabf-25464b78d0cmr7152062fac.2.1717902571242;
        Sat, 08 Jun 2024 20:09:31 -0700 (PDT)
Received: from localhost.localdomain (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7043180d0e5sm778608b3a.99.2024.06.08.20.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 20:09:30 -0700 (PDT)
From: Ke Sun <sunke@kylinos.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Nuno Sa <nuno.sa@analog.com>,
	Anshul Dalal <anshulusr@gmail.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Andrea Collamati <andrea.collamati@gmail.com>
Cc: linux-iio@vger.kernel.org,
	Ke Sun <sunke@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: dac: fix ad9739a random config compile error
Date: Sun,  9 Jun 2024 11:08:47 +0800
Message-Id: <20240609030847.2869455-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WARNING: unmet direct dependencies detected for REGMAP_SPI
  Depends on [n]: SPI [=n]
  Selected by [m]:
  - AD9739A [=m] && IIO [=m] && (SPI [=n] || COMPILE_TEST [=y])
...
ERROR: modpost: "spi_write_then_read" [drivers/base/regmap/regmap-spi.ko] undefined!
ERROR: modpost: "spi_async" [drivers/base/regmap/regmap-spi.ko] undefined!
ERROR: modpost: "spi_sync" [drivers/base/regmap/regmap-spi.ko] undefined!
ERROR: modpost: "__spi_register_driver" [drivers/iio/dac/ad9739a.ko] undefined!

Fixes: e77603d5468b ("iio: dac: support the ad9739a RF DAC")
Reported-by: k2ci <kernel-bot@kylinos.cn>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404250156.2PQRWmex-lkp@intel.com/

Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 3c2bf620f00f..ee0d9798d8b4 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -133,7 +133,7 @@ config AD5624R_SPI
 
 config AD9739A
 	tristate "Analog Devices AD9739A RF DAC spi driver"
-	depends on SPI || COMPILE_TEST
+	depends on SPI
 	select REGMAP_SPI
 	select IIO_BACKEND
 	help
-- 
2.34.1


