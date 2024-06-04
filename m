Return-Path: <linux-iio+bounces-5737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB028FAE8B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCFF1F233BD
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8C8143721;
	Tue,  4 Jun 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek9n651F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA751386D2
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492623; cv=none; b=dH1l/M/Lwm+L0BIT/UfvV2Yu1Spr8B8D2ybO0zc558QQhfDwARxljXBhTfoUqbr03b10JOBQNTunYo8nLs5USjoH4v3KrcPViRDfxdxC7niFDVKfLzdxA/ukVwl6js78vL/rbhG9sYyPkEZ9Ivp7wDZPwAvAAq0UwNSVWXBPh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492623; c=relaxed/simple;
	bh=gtX+3j/Uwryz5QRAEM/oZPW7Jxm0kjXE1eC0RzXgcuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QetHwmC4+aE4iY5MLXdJzOfKVnk8PrkGkF6K90Ch3gEpV/VVqXXpD2ZVj/T2eGH/7sFI6KjgAAd//VXRki+Ey3KAR39mGMWcEw/0s7FZt3lCI/1EO56IEDAqXU2iPs3FDVLISNCWq8hsspTX2N8M1QVfLRxsAnM0OiAeHO8nEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek9n651F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B54EC2BBFC;
	Tue,  4 Jun 2024 09:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717492623;
	bh=gtX+3j/Uwryz5QRAEM/oZPW7Jxm0kjXE1eC0RzXgcuc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Ek9n651FnU5i1LeCtL1M9noNoF91Tfj3YdOAXwzomaEWHVNNxAH6/fOTuxZpX8h3P
	 mnBHLSfNUp4hWXRQCyiR4hxJe1lHoz7lh87BGgZmiEgBPaKxj8FslaF3IWdZvA7TDB
	 pHhsLc/nB5MFi95jH0bugw00CrIR/D/O6FadhwAfIYeeZ9IEvbvSOW3fxWGpbyLxiu
	 ts1WZ9hi+heqXU+Vxoqr5PeJjYpyjjsejJOk/0w8vEFSw1PQOjPlN7mojtePcrUVF6
	 iCncvQw+d/YDZLB0W1hbInKuAGGcKiV/kCseuwxGVIjVFya7AQ2kNS2QwbbqkVdVR8
	 V6ozZF6BhssLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F5C25B78;
	Tue,  4 Jun 2024 09:17:03 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Jun 2024 11:16:58 +0200
Subject: [PATCH] iio: adc: adi-axi-adc: add platform dependencies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240604-dev-axi-adc-kconfig-v1-1-cfb725606b8e@analog.com>
X-B4-Tracking: v=1; b=H4sIAInbXmYC/x3MTQqAIBBA4avIrBswtR+6SrQwnWoINBQiCO+et
 PwW772QKTFlmMQLiW7OHENF2whwhw07IftqUFIZ2UuDnm60D6P1Dk8Xw8Y7trIbB63cqkcDtbw
 Sbfz813kp5QO8lt1BZQAAAA==
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717492622; l=928;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JrPT4YLeShRtu2BHWrN15sqGoA0Wm9+sv1TlaVGLUxk=;
 b=BcGneg9uohBTvTH5tRj9XtAjtgGIjfgHskjmXccgEIfUE9aaa9JSECdBoU2tFqa3Xe3Q7esJz
 Y4+amWOGW/kBBO4wKUDM8eSMctFeVeB00Q8FKJpFSUaz2uRs8Issey5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Being this device a soft core, it's only supported on some/specific
platforms. Hence add proper dependencies for the supported platforms.
Also add COMPILE_TEST to increase the build coverage.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5030319249c5..3d91015af6ea 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -353,6 +353,7 @@ config AD9467
 
 config ADI_AXI_ADC
 	tristate "Analog Devices Generic AXI ADC IP core driver"
+	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select IIO_BUFFER
 	select IIO_BUFFER_HW_CONSUMER
 	select IIO_BUFFER_DMAENGINE

---
base-commit: b3019fcdeb286b2cfe45e44bccb44dbcd8ff66dd
change-id: 20240604-dev-axi-adc-kconfig-1058732cb384
--

Thanks!
- Nuno Sá



