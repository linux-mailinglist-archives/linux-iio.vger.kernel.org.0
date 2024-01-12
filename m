Return-Path: <linux-iio+bounces-1608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D76882C3C9
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF031F22BE6
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B215077638;
	Fri, 12 Jan 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9BMChWo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C4745C8;
	Fri, 12 Jan 2024 16:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBF43C43394;
	Fri, 12 Jan 2024 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705077626;
	bh=llTgEL2jxB3/8LfO0hE7GScF9TdiVC5zVso5JhVVfmI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=g9BMChWoK0Mdg4LV2VSVQ/6z7bD8+9WLm916ADItEg/He9oCK7e2Z8ZA1C8508T2w
	 PaCuyK4/cXsaSHFv4onv19o9erT87OkdvUTpQz7uXIjiovjuHoCgRENM/buCG4vhLA
	 M6gLwp479g1PLHKJ6du+HvMq4ntKzi0CHl4v4afxo5wfukp9n+dY57lK2Vs2FALsCW
	 Al/mlR4wpNeTBI43yiKmbYkFx/5gTetVdy1FimFaRA9rkrLeS3+cNkTVU9LHnTiyWs
	 /+UjYPNQCUEHn+YbD89PRK86ibD6VMKj+l48Umf/m8h6OYDCnySX0Nmc9hSzpj5fV6
	 kVOsy+y7Kb9Fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B738CC47258;
	Fri, 12 Jan 2024 16:40:26 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v5 0/8] iio: add new backend framework
Date: Fri, 12 Jan 2024 17:40:14 +0100
Message-Id: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG5roWUC/1XMQQ7CIBCF4as0sxZTKK3FlfcwXUxhbCcqGDCNp
 uHuYuPG5f+S962QKDIlOFYrRFo4cfAl2l0FdkY/kWBXGlStGqmkEcxBjGiv5J3AxlmJHR6w7aE
 8HpEu/Nq081B65vQM8b3hi/6uP0fVf86iRS2M6clI3Y+dUSf0eAvT3oY7DDnnD45GvtenAAAA
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705077624; l=3960;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=llTgEL2jxB3/8LfO0hE7GScF9TdiVC5zVso5JhVVfmI=;
 b=cVl7DqOnCFyUouSXvay6/FEwBFfI9NVb5dJnEPCbhlT5EH3J10NTwU3yGrntnUDE1z3kPH9Nl
 BiNZIv4ZZGPBKq587wN3xhLAy8Vr5PQljdWTzTc01GEmYDCvCe/gKjZ
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

Changes in v5:
 - Patch 2
  * Update commit subject and message;
  * Add '#io-backends-cells' property.
 - Patch 4
  * Also support '#io-backends-cells'.
 - Patch 6
  * Improve Kconfig help message;
  * Only use device_links to control backends access. With this, we can remove
    all the mutex + sync logic as we are now guaranteed that a frontend cannot
    be up and running if one of the backends is gone.
  * Error out if we can't create the device_link (so we can guarantee the above).
  * Improve docs for __devm_iio_backend_get_from_fwnode_lookup();
  * Add a __ prefix to devm_iio_backend_get_from_fwnode_lookup() so it's clear
    that API should not be used (or used with care);
  * Drop devm_iio_backend_get_optional();
  * remove unneeded headers.
 - Patch 7
  * Handle the optional backend in the driver.

The biggest difference is that the backend @ops pointer handling to
reason about the backend existence is gone. Now, we rely on device_links
as that makes sure all consumers (in the link) are unbound before the
provider. Hence, the frontend is guaranteed to be unbound if any of the
backends is gone. That simplifies things a lot...

Keeping the block diagram  so we don't have to follow links
to check one of the typical setups.

                                           -------------------------------------------------------
 ------------------                        | -----------         ------------      -------  FPGA |
 |     ADC        |------------------------| | AXI ADC |---------| DMA CORE |------| RAM |       |
 | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|          |------|     |       |
 |                |------------------------| -----------         ------------      -------       |
 ------------------                        -------------------------------------------------------

---
Nuno Sa (7):
      dt-bindings: adc: ad9467: add new io-backend property
      dt-bindings: adc: axi-adc: update bindings for backend framework
      driver: core: allow modifying device_links flags
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework

Olivier Moysan (1):
      of: property: add device link support for io-backends

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   4 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   7 +-
 MAINTAINERS                                        |   8 +
 drivers/base/core.c                                |  14 +-
 drivers/iio/Kconfig                                |   9 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad9467.c                           | 283 +++++++++-----
 drivers/iio/adc/adi-axi-adc.c                      | 381 +++++--------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
 drivers/iio/industrialio-backend.c                 | 411 +++++++++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 ----
 include/linux/iio/backend.h                        |  73 ++++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 15 files changed, 806 insertions(+), 470 deletions(-)
---
base-commit: 3f4525f924e21d4f532517b17a20ffa5df7c0db7
change-id: 20231219-iio-backend-a3dc1a6a7a58
--

Thanks!
- Nuno Sá


