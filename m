Return-Path: <linux-iio+bounces-2229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475EE84B1FD
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 11:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22452866D4
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223112DDBB;
	Tue,  6 Feb 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWH9OaJF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32101E4AE;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214123; cv=none; b=otj444BkGPFsqiWCx5BWc9K8u1X81InBtk1sE7es2WNRItfBSKIoJLcdRG5f0fg/CeYQRZRuYOUzRAZtXZdKNIf1GwVLLbDMt1DMvOaED/BixvhVXU17VWPeI0AFMiQiHkODubuvJ6WB6lC3QtPeIdX16sbEIpcvY5pH8oqrMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214123; c=relaxed/simple;
	bh=OzYvq8VgwA+aNjVyozACROn98br9x+rokfdEO0b4lSQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ia2i97wN1uQK7O66cbw5/LclKmVgy0FKCv+RAIOkEAv5ozmj2qhikeMSQJ+zoo25Bxke9JPk+2Unfm2QGulh/vX3m6bp9OZfsFO2WMPCp6bOoZBi6d5ggrUvQxrptRkpnEvJW+mLMz/gCsh6qQNXMs4nqbnvDZWN7Hme+c5r740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWH9OaJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4373AC43390;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214123;
	bh=OzYvq8VgwA+aNjVyozACROn98br9x+rokfdEO0b4lSQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=TWH9OaJFGnEwJKWmJEiGWvNRBaHeOwBaTP9yaQeBOOEUpKkBT33R+zmkzfkukwNqF
	 rx+yptHfa5oJBGfeQDM7dEfgcUdHQdCu52laxjcKITRHoH6s4HC6eS5O1SrICLMvH6
	 C5pmdVMKugEpVV+isDqvTHwBIhGd0XnWsqpm/sm9qMADp+Kki657OmqX7tVKLy3nB8
	 D9UhbahPlrUXyQZ4GQ4ytCSqdeNh42K8oVjY+S2mZdLzkRoSQiHbh4kHOhKUbJLE7E
	 bPJ8cjRU0o51o2aYzaMbc6LGJL8enCcci9POy3ra2R3dtwwlnOt5XwJHj4nKKS48jS
	 EvOOROcARqLdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F74EC4829A;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v9 0/7] iio: add new backend framework
Date: Tue, 06 Feb 2024 11:08:23 +0100
Message-Id: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABcFwmUC/2XPzWoDIRSG4VsJrmvR489oVr2PksVRzyTSdiwzR
 VLC3Hud0NLIbITvwPOCN7bQnGlhx8ONzVTzksvUhn86sHjB6Uw8p7YZCFASpOc5Fx4wvtGUOKo
 UJVoc0DjWxOdMY77ea6+nti95+Srz9z1e9Xb97YDoOlVzwb135KV2wXp4wQnfy/k5lg+2har5w
 1pICT02DYdEEZPQEoPeYfuI+x9U27B03igblUFhdnh4wKB6PGw4jCMoG5z1aofdP25Pj13DozV
 ELjoQKnV4XdcfhACDTJsBAAA=
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707214121; l=4040;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=OzYvq8VgwA+aNjVyozACROn98br9x+rokfdEO0b4lSQ=;
 b=5lihuj2lIqcxnVBnVjn3xsZnY8lbBZOm5Uk9H//xDaBJnjvBcKIMo6LhyWF5PJUyYEJcNdQYs
 bg3D12RgtHJAQeHf4uBJaTP1vAB4Z/4kD8Xftjv96CmyigSu+oCh00x
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

v8:
 https://lore.kernel.org/r/20240202-iio-backend-v8-0-f65ee8c8203d@analog.com

Changes in v9:
 - Patch 2
   * io-backends-cells > io-backend-cells in both the property and example;
   * Add proper ':' termination.  
 - Patch 5
   * Adapted Copyright (2024 included);
   * Added missing headers;
   * Changed log pr_* to dev_*;
   * Allocate first struct iio_backend_buffer_pair and error out in failure
     (before we could be left with a buffer and not freeing it);
   * Fixed io-backends-names > io-backend-names;
   * Reworked getting the index when 'name' is given as suggested by Andy. 
   * Turned dev_dbg() -> dev_err() after fwnode_find_reference() as
     the optional get was dropped;
   * Used cleanup.h everywhere for consistency.

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
 drivers/iio/adc/ad9467.c                           | 268 ++++++++-----
 drivers/iio/adc/adi-axi-adc.c                      | 379 +++++--------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
 drivers/iio/industrialio-backend.c                 | 414 +++++++++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 ----
 include/linux/iio/backend.h                        |  72 ++++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 14 files changed, 795 insertions(+), 453 deletions(-)
---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20231219-iio-backend-a3dc1a6a7a58
--

Thanks!
- Nuno Sá


