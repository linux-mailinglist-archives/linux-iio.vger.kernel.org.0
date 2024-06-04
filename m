Return-Path: <linux-iio+bounces-5738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B398FAE9C
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641ECB20B9E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA5143860;
	Tue,  4 Jun 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOcA/0Q7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E11411F2
	for <linux-iio@vger.kernel.org>; Tue,  4 Jun 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492798; cv=none; b=kAKv+VOVdPxKM9IFTSisMgknGQHCL4cvSmu+rrjBrMzS6RJdeYloBc4SF+CKeooXIEynMp9iCd+rNELmZRvxxnmyChj6blVbV4m+U5QmBKq20eTqBcrBnyqTFuHKKVFR5gSzLpK93hxnWXxLL23iXAtzXWfugG2YloFWK83FwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492798; c=relaxed/simple;
	bh=LTfe3I1oDGnUnfaHQuaadz2LgYkAJh22qcxJQffuNHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g2RQv/YYVSF9EsZ7QDZQhTkF7J3S9c06qSvuWr9sgBTFKNd3VT+BmIWlxH2hP3pdFaa95VOWMvSVbWSj94LlC05LLIV4JMBflXTYE8U7YHI7QCP7VAuxsOiKGRxJdgkPAVfc9LLwTHoJKyy6R+fRWK7hvSevIAK8WCzC4lnfQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOcA/0Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00A51C2BBFC;
	Tue,  4 Jun 2024 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717492798;
	bh=LTfe3I1oDGnUnfaHQuaadz2LgYkAJh22qcxJQffuNHM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fOcA/0Q7d6hRoVYouARZu43nP6fQWD6spPBNyR3AdnymRNfTdhArVqwQoHA63/vh1
	 dX+W8WI7pBSL9zWIpSSWwl0cPD4/jsV2/7q6nV0r4EVBXBydj/YpO+dRbcZMs/RqRq
	 t6Cyo2hM9Jr1+M7QMTvfi+AsLARPmWrBQcoPOmo2DPdIhqMAEUKT7vIPM+PU4EGQRR
	 z1AvdLkREOHpqh3VnTltfKc+QNWrEB5SarQpkrSA5w9H2o0Pm8Xb0mTMWfJN8/y6vZ
	 v5jZ3kw+Z+AD7UgF69G7pMVmelalSRFKGVEuFbE6x4dslMW5seRdiC2/VzkdOgUW3r
	 JkDnPZ2LCxrtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47CEC25B78;
	Tue,  4 Jun 2024 09:19:57 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Jun 2024 11:19:56 +0200
Subject: [PATCH] iio: dac: adi-axi-dac: add platform dependencies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240604-dev-axi-dac-kconfig-v1-1-99ccd03938d1@analog.com>
X-B4-Tracking: v=1; b=H4sIADvcXmYC/x3MQQqAIBBA0avErBswMYOuEi3MmWoILBREkO6et
 HyL/yskjsIJ5q5C5CxJ7tAw9B3404WDUagZtNJGWWWQOKMrguQ8Xv4OuxzoJkPGjpo3stDKJ/I
 u5b8u6/t+hN+Q62UAAAA=
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717492796; l=920;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YrLqkABgojPI+8MFdEvEB5gbhTdxylKp34cyFJzLkSc=;
 b=N6SOgsSjzOXyztzd5wceCvQ8whG1LF4QV7wA9wELh3NAx+3KH4SDulmfwMmmutLhE9wWlzizh
 lnqlmDHkChtCpF9BHan+g2/kw///GvQt3fZZZTY+cNf3u8ktq54EkbV
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
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index ee0d9798d8b44..a2596c2d3de31 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -149,6 +149,7 @@ config AD9739A
 
 config ADI_AXI_DAC
 	tristate "Analog Devices Generic AXI DAC IP core driver"
+	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
 	select REGMAP_MMIO

---
base-commit: b3019fcdeb286b2cfe45e44bccb44dbcd8ff66dd
change-id: 20240604-dev-axi-dac-kconfig-a74d4652ebd6
--

Thanks!
- Nuno Sá



