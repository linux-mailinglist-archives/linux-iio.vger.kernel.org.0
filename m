Return-Path: <linux-iio+bounces-21831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26371B0C73E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27467167FC2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E112BE02C;
	Mon, 21 Jul 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbmTTgMc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522561F2B88
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110386; cv=none; b=IeKPaSgXfdcaKbMs7hJSlPwISzRT6OhHXKSl9MpQ2IPW3BdoaXSrpGOjzRc07y0JPQco+uj5llH9OEhUgqvYLWFI25koltlWZPAXHoSDX8cjSp9VUOoED48UqrVsw/8tZYFK8BLLOODjc+7pEsvVEcodQffkHl3vxe/qJO6K5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110386; c=relaxed/simple;
	bh=FVYG0jLde90pYxz1kRqt+fkegLXvVxmwLXIDDaQLoqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DphG5RbG0i6dRwqGGFP6FG3nr44C48ucc0Uo5f8KS421mdT+Fyw8ifZWzwGEjzHLqDnbsAz+G4YYTynIvT7VzgEHvqYZsfS9p0Pn0GFYpghHbg6ifLXv7nlo7mrqG1BFFWtYBAPM3VUWKlM9kybRiMmWu+58rii0jzvHGXt5UgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbmTTgMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8CBC4CEED;
	Mon, 21 Jul 2025 15:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753110385;
	bh=FVYG0jLde90pYxz1kRqt+fkegLXvVxmwLXIDDaQLoqs=;
	h=From:To:Cc:Subject:Date:From;
	b=VbmTTgMcIfM3NMt2wutDGHzL2RXRlouvNQgtRku54QrpgwzqqzCO07/P2YnIyCsQ/
	 +08/S4x9AJWcADXM50adUbr/UoNZWH9Hm6VEtxGJ2+IjfQtFyOilG5g3kGAGBVJy42
	 YXXZ1Z3lDbbakFnl0ix2LAs/gavnTmzaWV6lZT8w43gAHq78BM+OIwVAjWFeOdzRmV
	 I1x+Z8ZQVclIUwkUxM2MMhEHgs1nTO0k2n1/x9/AwOrWxM7rvcY5jaXGTan7Udfrq1
	 eoKRx1Sef1uVutMT2m4uUFuEl3VaFj4aJMERElAhmEhHJrL6d5l49Ua33s5oDy4Txy
	 CwxDE/qTmwShg==
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
Date: Mon, 21 Jul 2025 17:06:12 +0200
Message-ID: <20250721150614.51918-1-hansg@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here is v2 of my patch to add an IIO driver for the Intel Dollar Cove TI
PMIC ADC. Unlike what I mentioned in the review email thread of v1 I'm
sending this out as a separate series rather then bundling it together
with the power-supply series which adds a consumer of the ADC value:
https://lore.kernel.org/linux-pm/20250721122605.46724-1-hansg@kernel.org/
(in hindsight I think it is better to keep this a separate series).

Changes in v2:
- Add new "iio: Improve iio_read_channel_processed_scale() precision"
  patch to the series
- Add IIO_CHAN_INFO_SCALE and provide ADC scale info for Vbat
- Add IIO_CHAN_INFO_PROCESSED which applies calibration and
  scaling for the VBat channel
- Address some other small review remarks

Regards,

Hans


Hans de Goede (2):
  iio: Improve iio_read_channel_processed_scale() precision
  iio: adc: Add Intel Dollar Cove TI PMIC ADC driver

 drivers/iio/adc/Kconfig           |  11 +
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/adc/intel_dc_ti_adc.c | 348 ++++++++++++++++++++++++++++++
 drivers/iio/inkern.c              |  24 ++-
 4 files changed, 381 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/adc/intel_dc_ti_adc.c

-- 
2.49.0


