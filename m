Return-Path: <linux-iio+bounces-4542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D964B8B3BE2
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 17:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0870A1C23F3A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Apr 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7B15623A;
	Fri, 26 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GULybcCC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF514AD26;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146149; cv=none; b=HEjfIlQrP6IcPNhHq71BIN4A4EZ19qHmiSIPZUq5M5tr8B4WpF/frpzpb/vHbBH7Hci7GIhfjdq3vsI07XDkw6SgHmXrDO8/8S7/FxFlEiaosPFDfaTka2TRjFJMK5XrhYpyx4ySKeKyAehNwbK4pDhdF+pyzn/HrzRwq1wKf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146149; c=relaxed/simple;
	bh=YZ6VXyeY39Amd3aJX1bAsPKuxCkd4qcZJwMJ/B4JMxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bqnZCrkDFqtHko3eIi9W/xUXdjlEdQTn5rovsymrdqg5/wfELqZWRNhD+Y9521+0H+EXVWeoVGqS7XzrLsyM2NMHPB0d6KZTZI5fN28CFTK4HI+5NrTK5k8brT8n6+x7+jCkStN1CHfp1MoW/uwPVq8deBjPoE1tthE69ZVdiJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GULybcCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 652CEC113CD;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714146149;
	bh=YZ6VXyeY39Amd3aJX1bAsPKuxCkd4qcZJwMJ/B4JMxM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GULybcCCQey5wNu+9sEdy7orCoH6vNv09YS3Pp8EY7n1HFhbjZjWgDE2Eh7+/pj+p
	 PW/wozPfxJj/Hes3AbAJINQDMelM8YvVNl7vFybd3GrDmBMNGlTUst03zTbQ4ruSAn
	 mFO8DMgSIWERtcyiel/mCYSbfxb1HS//FKbrMaW6UeATT/4gFIjjNOVKDbTqE8UZgz
	 Ck5XuyKxNTGOEaZuzWGjufEMH/WwwwklIhVcJOExyHzkrtip8pGk8pTbAnPCWQb1d8
	 rWZRS8CpukwSqY+muJvAv84gMZ8L/J9LoKR/GwLy8Qmt8lAHZObHx6O4kj6vrVBh/Q
	 O5F0Aeg0rteOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A9C04FFE;
	Fri, 26 Apr 2024 15:42:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/7] iio: ad9467: support interface tuning
Date: Fri, 26 Apr 2024 17:42:09 +0200
Message-Id: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFHLK2YC/32NQQ6CMBBFr0Jm7ZhSoagr72FYDHQGmmhrWkQN4
 e5WDuDyveS/v0Di6DjBuVgg8uySCz6D3hXQj+QHRmczg1a6UlV5QrKnyjTo+YXCND0jJ5ROOqK
 arSgDefmILO69Va9t5tGlKcTPdjKXP/u/N5eo8MCN0UcRY2u+kKdbGPZ9uEO7rusXFM/mSbcAA
 AA=
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714146147; l=1945;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YZ6VXyeY39Amd3aJX1bAsPKuxCkd4qcZJwMJ/B4JMxM=;
 b=TQICWzuVJ91VffhN/LdgZDj7U8z3Xq+4v7Yufhtr1yBwoX6V/EnxpP4ZZ9Nhv/kgfAZawurYa
 i5iNnv56ubVDSUkF60Z6YO7t235BqicbAk/AnIUmcqfniuPiJdkAaXZ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes v2. Some points were still left open on v1 but this should
already include most of the things you asked for. 

---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20240419-ad9467-new-features-v1-0-3e7628ff6d5e@analog.com

- Patch 1:
  * New patch;
  
- Patch 2:
  * Added IIO_BACKEND_NO_TESTPATERN to stop the pattern (may be a no-op);
  * Drop struct iio_backend_chan_status and use a bool pointer;
  * Rename tap -> taps;
  * Improved commit message.
  
- Patch 3 & 4:
  * Added fixes tag;
  * Imporved commit message (so one can better decide for backporting).

- Patch 6:
  * Add comment on the sleep before checking for error;
  * Use switch case in axi_adc_data_sample_trigger();
  * Add IIO_BACKEND_NO_TEST_PATTERN.

- Patch 7:
  * Instead of caching the sample_rate, use clk_get_rate() "in place";
  * Added comment clarifying dco (data clock output);
  * Remove shadow ret;
  * Moved the tuning table dump into debugfs.

---
Nuno Sa (7):
      iio: backend: change docs padding
      iio: backend: add API for interface tuning
      dt-bindings: adc: axi-adc: add clocks property
      iio: adc: axi-adc: make sure AXI clock is enabled
      iio: adc: adi-axi-adc: remove regmap max register
      iio: adc: adi-axi-adc: support digital interface calibration
      iio: adc: ad9467: support digital interface calibration

 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   5 +
 drivers/iio/adc/ad9467.c                           | 374 ++++++++++++++++++---
 drivers/iio/adc/adi-axi-adc.c                      | 127 ++++++-
 drivers/iio/industrialio-backend.c                 | 162 ++++++---
 include/linux/iio/backend.h                        |  74 ++--
 5 files changed, 643 insertions(+), 99 deletions(-)
---
base-commit: cd84b21017b5f7b993341ee8b5c5bf10ddba37ab
change-id: 20240419-ad9467-new-features-fbfbaa5edf06
--

Thanks!
- Nuno Sá



