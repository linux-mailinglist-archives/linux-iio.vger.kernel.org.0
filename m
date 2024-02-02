Return-Path: <linux-iio+bounces-2095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F6C8472AD
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FA3B254FF
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8F145B25;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffb9k664"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74E145338;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886594; cv=none; b=VulrGEZpWt8wLJg56diB5pCXLL0W6hHsMFIHlFG4Diz3eGxr5BKUr5V9BAFKa4Xb2R5tDg0VpB1OG5B28GySWueChYfI7ysx8JxBq2LeepXP8wlnZDfBMoLU0AT93L3aPGXfOXNbonc83nwJiLxFYaGDoJCeeu9FqOppDSMc5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886594; c=relaxed/simple;
	bh=Bnr7/P2HmLqpYc3QWh+ZHHaLbnuta9Yxr8GeOUaUxI0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XJTfs1iOMDFYlrF/rMouD46vG8/jy9v/i7FHnKvuKzHS/rNtz6NRdGnVmKo5usejhcKyd+80HejXwFpuz7YEirN0x83AB9/UF8hR/XGjhatZeNN1zq4Pyj7rgu4DW1R01RQfcLbLei/7o5nrNsYAifKoNw73QM5AcshOpgj2SNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffb9k664; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE90AC433F1;
	Fri,  2 Feb 2024 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886594;
	bh=Bnr7/P2HmLqpYc3QWh+ZHHaLbnuta9Yxr8GeOUaUxI0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ffb9k664ITzPTjNXnmj3iMVDDKIYVWkO5fKiYhKE58UkLnqge7kCsJcCZodiS/yOg
	 gV9a03PEL3l61HRpZJb2CaQVOI6IfQjkwNROJBcp4/0QjqXhE1wlDV3DFeWd3QjO96
	 gWCmQTs/4NB3SR6dGTtq7M71QA+9sVGcST2YdVjMVHdHPQUHbw/4lHydgISdRaZOhd
	 cmrDwTCbV//Rh0WRDfBLMQLR15HI5sZ0A/24V4c8lpzGRASbwN93RK962VVQTN097i
	 r9PQZ4ax1AOmGcBKzdLCcuqtWWPC7iiYMCqS/wHmlJivhPeNT8izaWwdfTGdWS/Mgo
	 EBppriNN+Bxdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB96C4828F;
	Fri,  2 Feb 2024 15:09:53 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v8 0/7] iio: add new backend framework
Date: Fri, 02 Feb 2024 16:08:31 +0100
Message-Id: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG8FvWUC/2XPSwrCMBSF4a1IxkbybuLIfYiDm0c1qI20EpTSv
 ZsWhQaH58L3wx3REPoYBrTfjKgPOQ4xdWXo7Qa5C3TngKMvGzHCOGXU4BgTtuCuofMYuHcUFDQ
 gNSri0Yc2vpba8VT2JQ7P1L+XeBbz9dthpOpkgQk2RgdDhbbKsAN0cEvnnUt3NIey/GFBKGU1l
 gVbHxx4IihY8YfVGtcfZFUw1UZy5bgEIv9ws8KM17iZsW1bxpXVyvAKT9P0AS8x15teAQAA
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886592; l=3554;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Bnr7/P2HmLqpYc3QWh+ZHHaLbnuta9Yxr8GeOUaUxI0=;
 b=JvBolEcOjR8hYBAZSsl7OK1DM5GEvW3RY/pnGq8Fwpr9lokCogT7PaU7poz9CGf/8U5o5RDPl
 zI0fcZx75rVDgZmWZJERYtGr2aSzQN1JA36aDraNyVGo37XM2xzE7IL
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

v1:
 https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff

v2:
 https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e1@analog.com

v3:
 https://lore.kernel.org/linux-iio/20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com/

v4:
 https://lore.kernel.org/r/20231220-iio-backend-v4-0-998e9148b692@analog.com

v5:
 https://lore.kernel.org/r/20240112-iio-backend-v5-0-bdecad041ab4@analog.com

v6:
 https://lore.kernel.org/r/20240119-iio-backend-v6-0-189536c35a05@analog.com

v7
 https://lore.kernel.org/r/20240123-iio-backend-v7-0-1bff236b8693@analog.com

Changes in v8:
 - Dropped commit ("of: property: fix typo in io-channels") - applied
   via DT tree. Also dropped commit
   ("driver: core: allow modifying device_links flags") - did not made
   sense.
 - Patch 7
  * Do not change the version string format during probe.

Jonathan, the series is based on next-20240202 since it already includes
the io-channels fix Rob applied in his tree. I guess it should land in rc3 so
after you rebase, all patches should apply cleanly (if applying them of course
:)). Let me know if anything fails...

(also dropped the devlink Reviewers from the Cc list as that patch was
dropped).

Keeping the block diagram  so we don't have to follow links
to check one of the typical setups.

                                           -------------------------------------------------------
 ------------------                        | -----------         ------------      -------  FPGA |
 |     ADC        |------------------------| | AXI ADC |---------| DMA CORE |------| RAM |       |
 | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|          |------|     |       |
 |                |------------------------| -----------         ------------      -------       |
 ------------------                        -------------------------------------------------------

---
Nuno Sa (6):
      dt-bindings: adc: ad9467: add new io-backend property
      dt-bindings: adc: axi-adc: update bindings for backend framework
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework

Olivier Moysan (1):
      of: property: add device link support for io-backends

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   4 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   8 +-
 MAINTAINERS                                        |   8 +
 drivers/iio/Kconfig                                |   9 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad9467.c                           | 268 +++++++++-----
 drivers/iio/adc/adi-axi-adc.c                      | 379 +++++--------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
 drivers/iio/industrialio-backend.c                 | 412 +++++++++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 ----
 include/linux/iio/backend.h                        |  72 ++++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 14 files changed, 793 insertions(+), 453 deletions(-)
---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20231219-iio-backend-a3dc1a6a7a58
--

Thanks!
- Nuno Sá


