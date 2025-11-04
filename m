Return-Path: <linux-iio+bounces-25873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C9CC31DF4
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 071BD4F2537
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C109B2FB619;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdiJyohv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668927467D;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=u3Hu7BGroSeC1y2zjxfUtLUnDUCXfePp9J9tYkBRW661JBQI4wrivVK57WC8XbhWDi/aaKLBe/kfNF4PeWQ4Yjj6e/WAQu9hDh9AN5wiAsmrTyU+aTzrw3HGxXd3eZDJk/MGO3jeJFBhktfhLZULDfFMwUhkzv5/o7XLTduDP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=7iEpKsNY9UcWlnJ7pT3KJl2nLgV7qbqXVE2QPMDs5mw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SXjuj4rjeqLjve9CScAYJX14OqUDc8lWTscxTp/hvWWYStQpNLexUQjbeeENrFUqiaCkn9ngApNNcfkgkMpJ72/wBvvK8GolHdUJJH5B/W489a33h87D7RXuWOUiyINEtH2U4mDevzCQ+3TCH7gWBykHELMHbh5Pfo1zpB7Yplo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdiJyohv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD3D9C4CEF7;
	Tue,  4 Nov 2025 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270473;
	bh=7iEpKsNY9UcWlnJ7pT3KJl2nLgV7qbqXVE2QPMDs5mw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gdiJyohvLb5JLoWDanfDwZyBNjO7InvoAPX7L+fro4CR6ZH9sXBpNjhVMcJiVzQIm
	 8AlpIZKVaSDug4BQht6IkGhdCoxOfWjMHvwXXkLjPrQJWfr6DS7+x/qE9dFNveG1Fy
	 y9Za2OkO9BcLaFf+Sd8a/BTaApkVdaufTjXfu5LxZnLm6PBcaWhcipNlhxoyR54MdY
	 ceep3Gw4F1ViQrvO3mzF+OFOegYduPHhkbw8q1FsMkAGNbL+sF4GNznxNEVDUDxtKn
	 AGxN6XEaHGcFCH0RjBTkHcsyLZ9Z2S6Nb9y5GkoEd2f52HT4Wr3S0vXXAg7c15LTCo
	 FgQM705ltrvvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA2CCFA0C;
	Tue,  4 Nov 2025 15:34:33 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v4 00/12] iio: dac: ad5446: Refactor and add support for
 AD5542
Date: Tue, 04 Nov 2025 15:35:05 +0000
Message-Id: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACkdCmkC/3WOSw6CMBBAr2K6dkx/QHHlPYyL0hmgiRZDTaMh3
 N3CCkNczOLN5L3MxCKNniI7HyY2UvLRDyGDPh6Y623oCDxmZpLLQnChASmBRcxTFFqCcaZWGsl
 wIpal50itf6/B6y1z7+NrGD9rP4ll+zeVBAhwLYq6woYryy822PvQndzwYEsryY0v1eJpXULjA
 /rQRUgSOMiqtU1takGm3AXUJqDE7gGVfVSFzsfScfr153n+Ao2aH1UuAQAA
X-Change-ID: 20251014-dev-add-ad5542-8c8934de80ee
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=2152;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7iEpKsNY9UcWlnJ7pT3KJl2nLgV7qbqXVE2QPMDs5mw=;
 b=5L7Odu9gQy7Jw8c3ekOOT4+mL/wwB7bK3LUouy2Cb05NXb/eFdlo4hzzZbU6bl4EE/Tisv6Z6
 DcUNI/8HWNXDzsY3EeoY/o0+UTmVq4d+HliIoZF4+WU3AKDGpbDomA8
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Alright, what was suposed to be a simple one liner patch ended up being
a full refactor (modernization) of the whole thing :). I think the
changes are anyways fairly simple so hopefully nothing was broken.

I'm also aware of the checkpatch failure in Patch 7 ("iio: dac: ad5446:
Separate I2C/SPI into different drivers") but I'm really not seeing the
added value of adding the kconfig help text to the core symbol. 

---
Changes in v4:
- Patch 3
  * New patch
- Patch 6
  * Include err.h and asm/byteorder;
  * Changed Module description as suggested by Jonathan;
- Patch 8
  * New patch
- Link to v3: https://lore.kernel.org/r/20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com

---
Michael Hennerich (1):
      iio: dac: ad5446: Add AD5542 to the spi id table

Nuno Sá (11):
      dt-bindings: iio: dac: Document AD5446 and similar devices
      iio: dac: ad5446: Use DMA safe buffer for transfers
      iio: dac: ad5446: Drop duplicated spi_id entry
      iio: dac: ad5446: Don't ignore missing regulator
      iio: dac: ad5446: Move to single chip_info structures
      iio: dac: ad5456: Add missing DT compatibles
      iio: dac: ad5446: Separate I2C/SPI into different drivers
      iio: dac: ad5446: Make use of devm_mutex_init()
      iio: dac: ad5446: Make use of the cleanup helpers
      iio: dac: ad5446: Refactor header inclusion
      iio: dac: ad5446: Fix coding style issues

 .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 ++++++
 MAINTAINERS                                        |  12 +
 drivers/iio/dac/Kconfig                            |  31 +-
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad5446-i2c.c                       | 102 +++++
 drivers/iio/dac/ad5446-spi.c                       | 252 ++++++++++
 drivers/iio/dac/ad5446.c                           | 506 +++------------------
 drivers/iio/dac/ad5446.h                           |  76 ++++
 8 files changed, 664 insertions(+), 455 deletions(-)
---
base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
change-id: 20251014-dev-add-ad5542-8c8934de80ee
--

Thanks!
- Nuno Sá



