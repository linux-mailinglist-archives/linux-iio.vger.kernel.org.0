Return-Path: <linux-iio+bounces-894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B5A811588
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A4328289D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Dec 2023 15:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029352FC51;
	Wed, 13 Dec 2023 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDIHnZ9s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C62FC3A;
	Wed, 13 Dec 2023 15:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29DD4C433C7;
	Wed, 13 Dec 2023 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702479787;
	bh=2eAeAB2OSKA3kMHm2dotaI1S60CZCs+9Bu00lkPC4pg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YDIHnZ9s0F/iWtaRN+95VdGtiT5Z6pSqe1owm6a1rFJjKSQkT/pwKy05rRapiI5eS
	 ngskBe2g6aeHm576rQ+3Ol9voaqjJkciscQwJ22Dp0fZhVcbhKW5Q07RDRivXv5teR
	 eh2m9z7ufTlYrLtJpJNfGXmgaHmOov4bME6RwiKNllegK6NmjuZ/Zu9BLViIgk0ah2
	 CZ5/oSnEhM+hz4ujZ/G2YFPSere2bszEWE4fCN+78QZNEgVFvxHK53RiIQZ5lriOx6
	 Qy7TwoEXB2vatLybRfAm69c0H5tQUH0jXrEtgxfDCULzdR4B0FdYRdOArQGW6cNSmK
	 D7ON0lmHU3sEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A64C4332F;
	Wed, 13 Dec 2023 15:03:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/8] iio: add new backend framework
Date: Wed, 13 Dec 2023 16:02:31 +0100
Message-Id: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIfHeWUC/2WNQQ6CMBBFr0Jm7Zi20AiuvIdhUdoBJmpLWtNoC
 He34tLle8l/f4VEkSnBuVohUubEwReoDxXY2fiJkF1hUELVUiqBjjIyBxyMvZF36GQzNKfaSNe
 NUFZLpJFfe/HaF545PUN87wdZfe2vpUT718oKBepGi07LttMkL8abe5iONjyg37btAykssoGvA
 AAA
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702479785; l=3859;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2eAeAB2OSKA3kMHm2dotaI1S60CZCs+9Bu00lkPC4pg=;
 b=ZdBPKtdhFrWiX5W0MlzQLvi5FZAO29nTrtsbsIrwQyNVmksYsFYN3aNJp7tbTT/Pzydz4Kyu6
 Ro2nEf24vrgDj2mOP5fBmOfBhshsYQ05u5TeNgbAzwgpVYH7RLxq+nw
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

Changes in v3:
- Patch 1:
 * Use proposed generic schema [1]. Also make it a required property;
 * Improved the commit message.
- Patch 2:
 * Improved commit message.
- Patch 4:
 * Namespace all IIO DMAENGINE buffer exports;
 * Removed unrelated new line removal change.
- Patch 5:
 * Namespace all IIO backend exports.
- Patch 6:
 * Set backend.h in alphabetical order;
 * Import IIO backend namespace.
- Patch 7:
 * Don't depend on OF in kbuild anymore;
 * Import IIO backend namespace.

For the bindings patches, I tried not to enter into much details about
the IIO framework as I think specifics of the implementation don't care
from the bindings perspective. Hopefully the commit messages are good
enough.

I'm also aware that patch 1 is not backward compatible but we are
anyways doing it on the driver side (and on the driver the property is
indeed required). Anyways, just let me know if making the property
required is not acceptable (I'm fairly confident no one was using the
upstream version of the driver and so validating devicetrees for it). 

Keeping the block diagram in v3's cover so we don't have to follow links
to check the one of the typicals setups. 

                                           -------------------------------------------------------
 ------------------                        | -----------         ------------      -------  FPGA |
 |     ADC        |------------------------| | AXI ADC |---------| DMA CORE |------| RAM |       |
 | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|          |------|     |       |
 |                |------------------------| -----------         ------------      -------       |
 ------------------                        -------------------------------------------------------
 
Jonathan, I was also tempted in including the diagram in the source
file. Would that be a good idea?

[1]: https://github.com/devicetree-org/dt-schema/pull/120

---
Nuno Sa (7):
      dt-bindings: adc: ad9467: add new io-backend property
      dt-bindings: adc: axi-adc: deprecate 'adi,adc-dev'
      driver: core: allow modifying device_links flags
      iio: buffer-dmaengine: export buffer alloc and free functions
      iio: add the IIO backend framework
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: move to backend framework

Olivier Moysan (1):
      of: property: add device link support for io-backends

 .../devicetree/bindings/iio/adc/adi,ad9467.yaml    |   5 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   4 +-
 MAINTAINERS                                        |   8 +
 drivers/base/core.c                                |  14 +-
 drivers/iio/Kconfig                                |   5 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |   4 +-
 drivers/iio/adc/ad9467.c                           | 243 +++++++------
 drivers/iio/adc/adi-axi-adc.c                      | 381 +++++---------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
 drivers/iio/industrialio-backend.c                 | 386 +++++++++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 ----
 include/linux/iio/backend.h                        |  68 ++++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 15 files changed, 730 insertions(+), 470 deletions(-)
---
base-commit: 3cde3cdb0b23151dbaac476b17eb1868335993aa
change-id: 20231120-dev-iio-backend-d14b473a1d9f
--

Thanks!
- Nuno Sá


