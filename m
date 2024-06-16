Return-Path: <linux-iio+bounces-6313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B4E909B19
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 03:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CFA1F221DB
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 01:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CE1552FE;
	Sun, 16 Jun 2024 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cD4CNg5O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003181552FF
	for <linux-iio@vger.kernel.org>; Sun, 16 Jun 2024 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718501143; cv=none; b=RYVa/M+76HVcrRf7YbH7y2MKSz74bbWEuaVLmCkeDIF4E2iwt8czF15nhmZnX0ssFex/TaPA2E9sz6FSHzG2FVNWi9Ut3j9tVG9lPdGFhaPZpKrs7nSg4ZSZ1A1BQhsjql9SsZjbMrD6DXKkRuTXcIMMLuEo3gKplcrj1jbfLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718501143; c=relaxed/simple;
	bh=TNTvvYis8B90+i8p/Z65lN6JmLBeayserglnYMBu3w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=on8wzgECP/+PVWE2oWAABHlaZQL10OEOu9oUAlbBhcN2XhwQWyOLAwrZe8WRWAUp8mV25QtXwFZelzzMaFMafqTCBt7SLpFfSQ6rmwz0oIgsD5T/6HgcrlO5Mrw4rzdGu9SP3ci1rfBUHjhvqptMcfS4pC2G6q6G0rGh7WYX3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cD4CNg5O; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4405c2263eeso17459381cf.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Jun 2024 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718501141; x=1719105941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCrX2aP7omTOt40mjhlbJGCmLHhusecgyid8m4PMNe0=;
        b=cD4CNg5OTlFXcaBgZn1Er4CvTrk9Fhp4OZg77EpJJKqSLhgYW1OAqb+eIC00yncMUk
         n2QuPFS06hnCmCKJFYVBwbyscEW/uytC3DHq47rF0cYKHa8/3JMtSC+dwGVQzq8yvDSc
         KrKBFI0Ja3AR1MNOL4UqKvmNYlHmvGybblf00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718501141; x=1719105941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCrX2aP7omTOt40mjhlbJGCmLHhusecgyid8m4PMNe0=;
        b=DPkI0/mMUNdMFndLk8i0BqDl5+xBclKn5Q8tuF+EVcjbq0ULz0ymz5teb4jENAQjRy
         cFANVFl+sQ6X8u4lWyPcmYzEWrKIi/40Ujw40/f83fYVaqy0oUpQ8oI7W0oXOw0AzQRD
         tufoL2tHGppQZVS20NJBbopf0PRw/PmksZSyC+pXSsxw05xQX9eIO1LMhg/l7xAKSHBP
         IMWzKU4pNEWsZp6UbA0N/vAEKjbaW+ey8SIOXa5EIENZbmOWyBFowpOWqD4FqlVbTVI/
         2fFYtY0Jtl9ESxrwnc2uoXPj19+ceHYQKA+nYZDJccHBaJSqjfen4QYiCK/+HrrqUpRC
         dYeA==
X-Forwarded-Encrypted: i=1; AJvYcCVow20Gihik/QUE5XZrEDr/Zztel/ycV02RYFOJ5QOIi99QeKcL5UoGnZnNPlBomgkM7GWvwfO4r8zZoTjEPOZscQUaJRKW0/55
X-Gm-Message-State: AOJu0Yz5OjrtXCyUAYuwMhXvfTzItMxtrHDusby+cvxYrx7JsQdRO/nv
	vJVYBc0WaIp1GFQ7ceIjR4TJtyHRQsQn16kloTxA0l1o0w96Jo97iCMmcUWXdQ==
X-Google-Smtp-Source: AGHT+IG29Vm1eX4EMSaDAYflKH0cuDBu7WkYeoXWjmR1hkQVFmvlJrcmLUBw6U+nnvmj44pJx+WVcQ==
X-Received: by 2002:ac8:5a8c:0:b0:440:60f3:733b with SMTP id d75a77b69052e-4421685caa4mr69850701cf.14.1718501140971;
        Sat, 15 Jun 2024 18:25:40 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f310dae0sm32256121cf.97.2024.06.15.18.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 18:25:40 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	bcm-kernel-feedback-list@broadcom.com,
	lkp@intel.com
Cc: zack.rusin@broadcom.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	linux-iio@vger.kernel.org,
	jic23@kernel.org,
	lars@metafoo.de,
	nuno.sa@analog.com,
	dragos.bogdan@analog.com,
	anshulusr@gmail.com,
	andrea.collamati@gmail.com,
	oe-kbuild-all@lists.linux.dev,
	x86@kernel.org,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH 2/2] iio: dac: Fix dependencies of AD9739A
Date: Sat, 15 Jun 2024 18:25:11 -0700
Message-Id: <20240616012511.198243-2-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240616012511.198243-1-alexey.makhalov@broadcom.com>
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240616012511.198243-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0-DAY CI Kernel Test automation reported an issue:

   ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_read':
   regmap-spi.c:(.text+0xf): undefined reference to `spi_write_then_read'
   ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_gather_write':
   regmap-spi.c:(.text+0x2b4): undefined reference to `spi_sync'
   ld: drivers/base/regmap/regmap-spi.o: in function `spi_sync_transfer.constprop.0':
   regmap-spi.c:(.text+0x337): undefined reference to `spi_sync'
   ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_async_write':
   regmap-spi.c:(.text+0x445): undefined reference to `spi_async'
   ld: drivers/iio/dac/ad9739a.o: in function `ad9739a_driver_init':
   ad9739a.c:(.init.text+0x10): undefined reference to `__spi_register_driver'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [y]:
   - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])

The issue is caused by CONFIG_AD9739A=y when CONFIG_SPI is not set.

Add explicit dependency on SPI and conditional selection of REGMAP_SPI.

Fixes: e77603d5468b ("iio: dac: support the ad9739a RF DAC")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 drivers/iio/dac/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 3c2bf620f00f..d095f4d26e49 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -133,8 +133,8 @@ config AD5624R_SPI
 
 config AD9739A
 	tristate "Analog Devices AD9739A RF DAC spi driver"
-	depends on SPI || COMPILE_TEST
-	select REGMAP_SPI
+	depends on SPI
+	select REGMAP_SPI if SPI_MASTER
 	select IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD9739A Digital-to
-- 
2.39.4


