Return-Path: <linux-iio+bounces-25737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73DCC25036
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E35C420AFC
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8A33F8CD;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlSsEVNl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AC2773CC
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913861; cv=none; b=WAo3/mfpbKByc/GPvWLvEArhrsyYcVOX+xCa/U/OYhNAdeTiBWa/Qwg+H5CidZxXlsisUFNAksFoK+yddaBhPKy9ZUoDIYeeONBR7YLGWxTYAmjasg6eDEPdNt+EItqKOCdZSMOUVx71hxcQ6GG4jPF6KYsVFlkNiGrRIv8gnPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913861; c=relaxed/simple;
	bh=jWiOqwF7DWrzPKoJfUyuoXIXrfNLEtkDJ9x6KviWuyA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jkV5IS4MYE2ukylSlGMFx/vQXF5CTBhDoqE7OlDCIIfpcOvEe63s9Z1DjqzxvcX5yM5FUbPWM60aNRd5Ip5mCtcJCOD3UMKVJtTaRp9eT+iMcl4KZydM1OOXRGjT6h2YcoV/NtFwHknzP9jev8EgskrR6iJs4qxqBjVsJJQLhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlSsEVNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 829F1C4CEFB;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913861;
	bh=jWiOqwF7DWrzPKoJfUyuoXIXrfNLEtkDJ9x6KviWuyA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NlSsEVNlRcFbg1QbcKmpQ0aWlrYHOOQWEr2hdI3+7utcV4LPoKJnVy2HR8t4OJXB7
	 4zuuYjZFaDh4kQooW74b8Ez/sWlKuBbV8iW4rxAjVp52iOa468JSGzIP8Dw5qLAz6T
	 nVbIRKKSBoCGYH0KuktSpiprBu1vc4X3TDLLEUq0Q/L+Rz2xjb9yF5Q0MaR57zJk8l
	 Labjrg6hlXJePwseXZzhRscCIQCOCT05nTSEDIAu+EnnA3RsrbahekqNV8VNl0Eb6f
	 iM54Pxz11HNO5FVhgs/gPzSFHdujQCWY9xiNTS3kZxelttUViW1rvyOpL3A4vRgcfv
	 XtUI1ZEhgd3BQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3CDCCF9FE;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 00/10] iio: dac: ad5446: Refactor and add support for
 AD5542
Date: Fri, 31 Oct 2025 12:31:21 +0000
Message-Id: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABmsBGkC/3WMvQ7CIBRGX6Vh9hr+2oKT72EcKNy2JAoGDNE0f
 XdpJx0cvuF8yTkLyZg8ZnJqFpKw+OxjqCAODbGzCROCd5UJp7xllElwWMA4V9e2koOySgvpUFF
 EUqVHwtG/9uDlWnn2+RnTe+8Xtr1/U4UBAzs6pns3UGHo2QRzi9PRxjvZWoV/+VxsnpQdDD44H
 6YMhQMF3o9m0EozVN1PYF3XD1d62QvuAAAA
X-Change-ID: 20251014-dev-add-ad5542-8c8934de80ee
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=2096;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=jWiOqwF7DWrzPKoJfUyuoXIXrfNLEtkDJ9x6KviWuyA=;
 b=HdkM0cxlCm7NuBbo9wGO1HJgCRkwWc5wkUaHkJt+OFwAO9XQM9LcDX4iQ7IQ/v36fkuElw8aS
 Ot1UkRIHWfjAFYDMrhM9iDZ1Y0Gt4xM1v5yfiWjzYKmV5ZPLOMqDEzs
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Alright, what was suposed to be a simple one liner patch ended up being
a full refactor (modernization) of the whole thing :). I think the
changes are anyways fairly simple so hopefully nothing was broken.

I'm also aware of the checkpatch failure in Patch 6 ("iio: dac: ad5446:
Separate I2C/SPI into different drivers") but I'm really not seeing the
added value of adding the kconfig help text to the core symbol. 

---
Changes in v3:
- Patch 1:
   * Changed commit message as suggested by Conor;
   * Dropped formatting on the binding description;
   * Used typical Analog title in MAINTAINERS entry.
- Patch 2-4, 6-9
   * New patches.
- Link to v2: https://lore.kernel.org/r/20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com

---
Michael Hennerich (1):
      iio: dac: ad5446: Add AD5542 to the spi id table

Nuno Sá (9):
      dt-bindings: iio: dac: Document AD5446 and similar devices
      iio: dac: ad5446: Use DMA safe buffer for transfers
      iio: dac: ad5446: Don't ignore missing regulator
      iio: dac: ad5446: Move to single chip_info structures
      iio: dac: ad5456: Add missing DT compatibles
      iio: dac: ad5446: Separate I2C/SPI into different drivers
      iio: dac: ad5446: Make use of devm_mutex_init()
      iio: dac: ad5446: Make use of the cleanup helpers
      iio: dac: ad5446: Fix coding style issues

 .../devicetree/bindings/iio/dac/adi,ad5446.yaml    | 138 ++++++
 MAINTAINERS                                        |  12 +
 drivers/iio/dac/Kconfig                            |  31 +-
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad5446-i2c.c                       |  99 ++++
 drivers/iio/dac/ad5446-spi.c                       | 254 +++++++++++
 drivers/iio/dac/ad5446.c                           | 498 +++------------------
 drivers/iio/dac/ad5446.h                           |  76 ++++
 8 files changed, 663 insertions(+), 447 deletions(-)
---
base-commit: 4b17a60d1e1c2d9d2ccbd58642f6f4ac2fa364ba
change-id: 20251014-dev-add-ad5542-8c8934de80ee
--

Thanks!
- Nuno Sá



