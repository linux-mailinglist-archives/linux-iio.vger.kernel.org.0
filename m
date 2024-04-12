Return-Path: <linux-iio+bounces-4199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2838A2F86
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E8EB21986
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132DB83CDC;
	Fri, 12 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhvoL0aK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C343559B4B;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928970; cv=none; b=lnDeUKkS7e5LkFkgS71BUGY2S+diPhRUNqY2QgraPiOYx8z9M9bBZm4RDJyLEMYvFooKsb9I8KJ0L0dGBFAonnH8wa87EZrA+Lu86FPfBk+EAoBCSNEx7nSKeKFxtYWIGi9af1jbDSG6HVNOwlHyV2bH6u6EgicBBm2tpuvZmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928970; c=relaxed/simple;
	bh=6oxKzxB+8rFGDVu9kvubnME1zu8znjwX0ryuim96c6o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mxFOXjQzUZgul/GYFkMrSaSNpHXllMv1hi4kTvQ5FJ7XbLHitHve6dSXzDSsXWOSBHrfLmgFNpJ/hy7eyKe35pxJDcLdv+ySyyMX9QLyvPey16DPfgkccMsXGRIWBeTulbq6ewuakGyYm8S9hfb+xeyFulWa1NiQcGM01ifKuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhvoL0aK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D65BC113CC;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928970;
	bh=6oxKzxB+8rFGDVu9kvubnME1zu8znjwX0ryuim96c6o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lhvoL0aKqcrcYg8oW7x/FAEJk5h9+5Xc0Yci2A+Wl8Y6ZCfYqdnvhUGdcLgvU0uwl
	 10VwJ2bk1i0d0XU05t021EbgcOdOwvn6lKddel08KA9gKm/RgP+d9AdeM6UFSHmaTF
	 CwtbIJcLy5JxR0d6glH7uPZNhUWj0drlAyGQQc3FAwKqj9tODOr100e70PbgT+dFj1
	 U16SFJmMohjvp2srbRBfBwmYuxSy+BgWDU59R2IpyoiuJdJyClVuKMkQXPBSkpBVSw
	 E+1N+51AiiY6ZLKgHMIpCoQ5Kgcy6fY3s/NZULykTrMVLlXqgjCgDUXKKnWGgE9Imt
	 KKjneQ7Be04NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F598C4345F;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 00/10] iio: dac: support IIO backends on the output
 direction
Date: Fri, 12 Apr 2024 15:36:07 +0200
Message-Id: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMc4GWYC/x3MQQqAIBBA0avIrBswlaCuEi1GnWoINBQiiO6et
 HyL/x+oXIQrTOqBwpdUyanBdgrCTmljlNgMRhunXW9QJKOncHCKSLdgpIDeDiPFQG4gDa08C69
 y/9d5ed8Px1ATkGUAAAA=
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712928968; l=2523;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6oxKzxB+8rFGDVu9kvubnME1zu8znjwX0ryuim96c6o=;
 b=ZCNsOMhBadBinoP/FmWDKvnMW9b9E73q5IYzBTA2qO+DOWTDFB8eE5xeoXXZqr5r4o/EA77Eu
 P65K9TxGJRiAEW+iBlYM4nro/nxjv4NmH3VP8B00UMlP+uWqqyWlbqi
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes v3. Only thing that is not exactly closed is the 2 channels
in the DAC driver. So, I kind of added a comment with something similar
to my reply in v2 [1].

Full log:

v1:
 * https://lore.kernel.org/all/20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com/

v2:
 * https://lore.kernel.org/all/20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com 

v3:
 - Patch 3:
   * Align on open parenthesis.
 - Patch 8
   * Removed asm-generic/errno-base.h;
   * Only use default (1 to 1 backend frontend) method to get backends.
 - Patch 10:
   * Add comment for having 2 different channels.

[1]: https://lore.kernel.org/linux-iio/20240405-iio-backend-axi-dac-v2-4-293bab7d5552@analog.com/T/#m11d3716a702e49c217879940cdda14805609909c

---
Nuno Sa (6):
      iio: buffer-dma: add iio_dmaengine_buffer_setup()
      dt-bindings: iio: dac: add docs for AXI DAC IP
      dt-bindings: iio: dac: add docs for AD9739A
      iio: backend: add new functionality
      iio: dac: add support for AXI DAC IP core
      iio: dac: support the ad9739a RF DAC

Paul Cercueil (4):
      iio: buffer-dma: Rename iio_dma_buffer_data_available()
      iio: buffer-dma: Enable buffer write support
      iio: buffer-dmaengine: Support specifying buffer direction
      iio: buffer-dmaengine: Enable write support

 Documentation/ABI/testing/sysfs-bus-iio-ad9739a    |  19 +
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |  94 +++
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  62 ++
 MAINTAINERS                                        |  17 +
 drivers/iio/adc/adi-axi-adc.c                      |  16 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       | 100 +++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  83 +--
 drivers/iio/dac/Kconfig                            |  37 ++
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad9739a.c                          | 463 +++++++++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 635 +++++++++++++++++++++
 drivers/iio/industrialio-backend.c                 | 179 ++++++
 include/linux/iio/backend.h                        |  49 ++
 include/linux/iio/buffer-dma.h                     |   4 +-
 include/linux/iio/buffer-dmaengine.h               |  24 +-
 15 files changed, 1705 insertions(+), 79 deletions(-)
---
base-commit: aabc0aa90c927a03d509d0b592720d9897894ce4
change-id: 20240412-iio-backend-axi-dac-b369adca46a0
--

Thanks!
- Nuno Sá



