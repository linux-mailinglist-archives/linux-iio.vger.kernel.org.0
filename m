Return-Path: <linux-iio+bounces-2385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099685065D
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 21:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40E81F21F80
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 20:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D85FBBF;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGvprrux"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81F5F879;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707598641; cv=none; b=USRJI7Zr5UlFMFbj5VnzTzY2QbmM3AUwh2L0Oql0wxLFvqasr2SJk2O/A9c/2OsIE0CpRNw2Ws0QDuRGrHtyK4x96JzlJKf2z/IHz8wHQuWE9ym3WyQHV6g2P1bgwI4knClPVd+sXBBGHMU6ewDidudrU2CaUjfQiA9JWNyVQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707598641; c=relaxed/simple;
	bh=q4V3T80Txq6jSUjNLG3n3P4nfNbu0tPkxZiFNMalY7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OduVJToWk3SqgCoSAeIrJBu5S1jPQHTqeshu9GnvmYNEWjP5vKW15nUw31PAugHqK4Q0aW0y63uCeu22Y/oCnsqm+bZSPoikJEumVsxBtyRfSgjA4Vy0/CFWE7G3XHHpJXbluNmrL3kVvW5Q2QR9nK3ZAWt+J8MN4RWs4V8gheg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGvprrux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07E52C433F1;
	Sat, 10 Feb 2024 20:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707598641;
	bh=q4V3T80Txq6jSUjNLG3n3P4nfNbu0tPkxZiFNMalY7s=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bGvprruxPEi5jIsTs9nC3i8f2k5zMRkkXS2VM9dXayHbK4SYPkYbtBgt4B5ddiOfT
	 WPQ3WIMYUwo3R82FgKRjaobPTF/g/n/WE0Eae9xSw+pU0LE76Kc4P9aK+f5SIciSxh
	 TRcNaJbH53Mzzp5Cp7aczDHxypPnVZIJ6YDl77Iex8GnnC7GCkci9EwIDyCvW7IqCG
	 5BcQbKwn+uox9D3+ZNGRYP7mX6t/zidK5YXVN6UhYjYZKVXkugGuzEQBt1lGmA0PQc
	 kdvYyK8IzO4i3V5rKy3m//9DOctvIowbTCCFkJqRlickue0yKl+BGu1DUb/ZclsnkU
	 zsng1iLEY5SpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1112C48260;
	Sat, 10 Feb 2024 20:57:20 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v11 0/7] iio: add new backend framework
Date: Sat, 10 Feb 2024 21:57:12 +0100
Message-Id: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACjjx2UC/2XP20rEMBCA4VdZcm0kk8M02SvfQ7yYHLob1EZaC
 crSdzddFBt6MzAD3w9zY0uac1rY+XRjc6p5yWVqC8DDiYUrTZfEc2wHJoVUIMHxnAv3FF7TFDm
 pGICQBjKWNfExpzF/3XPPL22/5uWzzN/3etXb9bcjRdepmgvunE0OtPXo5BNN9FYuj6G8sy1Uz
 R/WAkD22DTsYwoUhQby+oBxj/sPKjYM1hmFQRkS5oCHHZaqx8OG/ThKhd6iUwds/3EbPbYNj2h
 SssFKoeIBuz3GHruG44gYwbgghOjwuq4/ooAvHNkBAAA=
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707598639; l=3748;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=q4V3T80Txq6jSUjNLG3n3P4nfNbu0tPkxZiFNMalY7s=;
 b=mj9zDaKxZirMr/a7AvN8pw/m5jXV47e/D7X7RYcG779EudkgWBg4ysdG3U5bxgi7DRbsLgmgA
 X8iHGYG78QoBmy93uweVsJCYlIA2E+8FNEKXaKtjKvN3Li+nW2ZqmSh
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

v9:
 https://lore.kernel.org/r/20240206-iio-backend-v9-0-df66d159c000@analog.com

v10:
 https://lore.kernel.org/r/20240209-iio-backend-v10-0-3ed842064318@analog.com/

Changes in v11:
 - Patch 6
   * Directly use dev in devm_iio_backend_get();
   * Move comment above the proper place.
 - Patch 7
   * Added blank line between includes (to logically separate them);
   * Move back to 10 millisecond sleep;
   * Constify expected_ver and removed unneeded cast.

Jonathan, the series is based on next-20240202 since it already includes
the io-channels fix Rob applied in his tree. I guess it should land in rc3 so
after you rebase, all patches should apply cleanly (if applying them of course
:)). Let me know if anything fails...

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
 drivers/iio/adc/ad9467.c                           | 267 ++++++++-----
 drivers/iio/adc/adi-axi-adc.c                      | 385 +++++--------------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   8 +-
 drivers/iio/industrialio-backend.c                 | 418 +++++++++++++++++++++
 drivers/of/property.c                              |   2 +
 include/linux/iio/adc/adi-axi-adc.h                |  68 ----
 include/linux/iio/backend.h                        |  72 ++++
 include/linux/iio/buffer-dmaengine.h               |   3 +
 14 files changed, 802 insertions(+), 455 deletions(-)
---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20231219-iio-backend-a3dc1a6a7a58
--

Thanks!
- Nuno Sá


