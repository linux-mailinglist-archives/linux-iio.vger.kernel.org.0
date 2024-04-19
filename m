Return-Path: <linux-iio+bounces-4350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E118AAA09
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4711F228A5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88753360;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7mc/P9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C43EA8C;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515137; cv=none; b=iLrxyW2OFPK6QpLapZ32p3smJ0iV1ufHAGJwJChrF+70B2RSBNFqoyXKJbs3s6KH2snfQ1r8szUY20g0VDSnN82J8+h8y5LWjUNDsZGb7bbIckBEJlGqhOFhhie9x0vY0AWWydJJlnKvM9lHEoq8Tob4D+huE8tbbQ16vK0As58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515137; c=relaxed/simple;
	bh=6Jc63Ty3AclW4Qt3X4Q3sXMZP6yZwhBtynEVSVLwiZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XIJNEi1GNiNuHyrOzgD8VLOMB9ucea15HWvGL5zqn9twAVE7WUVWdMFWuZRQfn0ZBxNs/umE3DPv98QUFRQgrO+eJ9X/GPW650D/LSQ94T1isYUdpO0yBZa1rokB5J0xBsBUSkqQQxdiLsw0feW/gZ4BGdLLIWbjQOLE1xsU52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7mc/P9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD79BC072AA;
	Fri, 19 Apr 2024 08:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713515136;
	bh=6Jc63Ty3AclW4Qt3X4Q3sXMZP6yZwhBtynEVSVLwiZo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=G7mc/P9B2NzcbmGGDqylb7J0UkIJ0omU2vmiVE5//sYP+pT2eC/HS7X9zzTUQd3B0
	 TqdH12uVKHEj1DDdkeyzpfDyhYSZwQQOI4NU8zKq9CW/uVFY78KVHIUlG+y1vW+Lnj
	 3aYmGe8j9xPEZTxAwX+U2rLBHhuaXNQRpbdPZlQxqEpnq0dIuQFxhzBi4aCqShA/Fs
	 hisI1ABltNMXBlAw4XGDOMVgh2S6Yrm7hE5hgTgOc+Jq1pAQiWdaUm6l92Npq+LHL+
	 K28LErVZkP3Iw80hoYYcqqfHAvOw2KLHBu1NvOo+Yi6fmw49bIejb0CdUWQNjDV1bQ
	 A8gAX4bVNGmrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62EEC4345F;
	Fri, 19 Apr 2024 08:25:36 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v4 00/10] iio: dac: support IIO backends on the output
 direction
Date: Fri, 19 Apr 2024 10:25:33 +0200
Message-Id: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH0qImYC/32NQQ6CMBBFr0Jm7ZjSVhJceQ/DYmgHmKgtaQ3BE
 O5u5QAu30v++xtkTsIZrtUGiRfJEkMBe6rATRRGRvGFQSttla01ikTsyT04eKRV0JPD3jQteUe
 2IQVlOSceZD2q967wJPkd0+c4WczP/u8tBhUabr11F63qob9RoGcczy6+oNv3/QsJjeE2twAAA
 A==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713515134; l=2355;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6Jc63Ty3AclW4Qt3X4Q3sXMZP6yZwhBtynEVSVLwiZo=;
 b=btC7zoHobyKtlNXdb77uQliTZs2BXBv2Fv5mSzJu9UQBdqwV00mwAoA9STXrQQDyhU4l6mI1+
 n7xxElW+5nLCEggR1im35BrVMtY8b0aSVfu8vq4k1fChNx/MsD+PzaB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes v4. Added default value for full scale current and
corrected the minimum value.

Full log:

v1:
 * https://lore.kernel.org/all/20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com

v2:
 * https://lore.kernel.org/all/20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com 

v3:
 * https://lore.kernel.org/r/20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com 

v4:
 * Patch 7:
   - Added default value for full scale current;
   - Corrected the minimum value for full scale current.
 * Patch 10:
   - Corrected the minimum value for full scale current. 

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
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |  95 +++
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
 15 files changed, 1706 insertions(+), 79 deletions(-)
---
base-commit: aabc0aa90c927a03d509d0b592720d9897894ce4
change-id: 20240412-iio-backend-axi-dac-b369adca46a0
--

Thanks!
- Nuno Sá



