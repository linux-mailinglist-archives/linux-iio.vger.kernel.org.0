Return-Path: <linux-iio+bounces-28023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04179D3BAAA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 23:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F31FE302759B
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 22:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD42F9D85;
	Mon, 19 Jan 2026 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrTYOEsf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFF28489B
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861067; cv=none; b=GB2A52qfzKMmCw8tltYcnjKVwXbMh9a6BCDXw+T0o8dQ5eCZ6k9bZWJXNmvEe/RtR9zMrZ59OuX8OSlU23MmntWZgte9KTECAm53E20uv2oCSn9tKjHU4HWkQLAz6LBJgHSGuNx4RHcAFQBjGDqb4Cv1+SZCdrlJ1x5fuj5zEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861067; c=relaxed/simple;
	bh=RyEaN2R3QaXDzRUPf0OJ6yeRAULAMy+6gbcs5oXh5IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBuONaUciVDUcI4Q6yyI0bfnrk84d/wQc3ZM0xCmwaOBGQALTbOUfuAsojBrgBpwoCle4Y4gAHNjkTL/7fLCH7bTNRQy91J47pRORXZbsiXElUGPhXLhOwvfjo3gNTihzJC4uh7Z4QaHQeNrje3+5nCgarGlRgtAhYVOb58Thwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrTYOEsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEFAC116C6;
	Mon, 19 Jan 2026 22:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768861066;
	bh=RyEaN2R3QaXDzRUPf0OJ6yeRAULAMy+6gbcs5oXh5IY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZrTYOEsftzsAZjpi+v3wlUKy8XdJlg+J7p4WT5ERlxKA4sK+DoQ4k8dJy4FifR617
	 IAqSrzEWDmoILzJwCPIXSoiNffiNkbmJYwaKOS/V2agKWkgplDV4t8D/UuEsS9EqfB
	 5EiPSQOEDRj78NXV0fgfTi0x9Ef9vHl5KqNQ9PFDUKcFFriXUN9DhOTz+V6W7Ypy+I
	 B6PyYStlcynmeE6ipqncIL9z1c0dMkqGkDzDzhPgy+RXNdZKb0TJgGGyLGqJxqjFqG
	 +B4va/jOLbUusnR1ROVT6Tt9WKqzHxGxYdCUuSi34oylJSlTsF35CnrUZhvTwm47HL
	 n9CNcNNKXQSqA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] iio: magn: mmc5633: Fix two build issues
Date: Mon, 19 Jan 2026 22:17:34 +0000
Message-ID: <20260119221736.804825-1-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The Kconfig  issue was one I came across whilst testing the second fix
which has been being reported by the bots for some time. Frank posted the
full fix for the undefined symbols a while back, but it is merged in
the middle i3c/for-next making it hard to merge into IIO as well.
So work around this to get the build issue resolved.

That workaround can be reverted next cycle.

I'll queue these up now but they can have brief 0-day exposure
before I push them out on the togreg branch to be picked up by
linux-next. Even after that comments on these ones welcome.

Thanks,

Jonathan


Jonathan Cameron (2):
  iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not build if I2C / I3C is
    not.
  iio: magn: mmc5633: Add some ifdef / __maybe_unused until stubs
    available

 drivers/iio/magnetometer/Kconfig   |  4 ++--
 drivers/iio/magnetometer/mmc5633.c | 25 +++++++++++++++++++++----
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
2.52.0


