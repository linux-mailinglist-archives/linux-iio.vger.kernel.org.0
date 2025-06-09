Return-Path: <linux-iio+bounces-20322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B2EAD18D2
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 09:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4FB3A8AD0
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 07:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060A280334;
	Mon,  9 Jun 2025 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px9XatRE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39411185
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2025 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452787; cv=none; b=Q2Y0KNWVLtWYxqzmCh+mcbugAV7e3qmSemHKnN/R4PpuKPhCmoRnnSD3PFICbZWfLFJKWsETDw3iphyeC4A7gTOkYvJvgfSX4ukYCs+tCL7zHRlo4j8o3HyoFF/Gmf4F5TfxWhmPXM7z5c0bd0E+B1xQPBH5sI+I8NU1uOMcq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452787; c=relaxed/simple;
	bh=YmewFNhK4XWdmKQ7sFfkD1qpEhMJBlI97VCwY4Kmbd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=doiHSg4Fd5p/ijleHKkFlYV+ocdOo/G56PHR7x3fqcjHSPs0OYY3MPFlwWVGgeIpQ9iIEiPme12mGZuhduIclYLtU6w0tSQaV5YDHpyHgXZxbnAIRojfJ3c6pGH8INks8QVYB9oLDslJUUAzirHaVghwlIM1gj9mJRziUw0aqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px9XatRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585A8C4CEEB;
	Mon,  9 Jun 2025 07:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749452786;
	bh=YmewFNhK4XWdmKQ7sFfkD1qpEhMJBlI97VCwY4Kmbd0=;
	h=From:To:Cc:Subject:Date:From;
	b=px9XatREO7HCYXZdbpCdLGLgCayLi9xBFJSs8hVc9uu5f5+ugqknOE/zh4uUF50tT
	 icQv/0kHA6Fq987bmoZ/Je+jO2fgv7f6iY9LFkaoi0jQrCuop/xXtDgJ7QIp4Ts7L7
	 XBL6gjrFIQbcR9KR8glnP0aZBjWGKFDsurFeo9t+Cejh/Kq7gSjerh390qYKyDt0xa
	 BnGwE/b67qJowvcO7krz4vWcQ8diY4w1qXIVBZtAFWGBke38UkmDxdxIhjsXTziFpY
	 blXuQISVMM4lHzFfIaUyvE89T6NwUPH4hAGBmpJELrHYRJRfu4ZgQLiuBL1j//U/10
	 4vrRxLdamofwA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] IIO: Drop some unneeded export.h includes
Date: Mon,  9 Jun 2025 08:06:14 +0100
Message-ID: <20250609070616.3923709-1-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

7d95680d64ac8 ("scripts/misc-check: check unnecessary #include <linux/export.h> when W=1")
brings some new warnings about including export.h where it isn't used.

There are similar warnings where it is missing and should be present but more
of those than I'm going to resolve this morning.

Jonathan


Jonathan Cameron (2):
  iio: potentiometer: Drop unused export.h includes
  iio: dummy: drop unused export.h include.

 drivers/iio/dummy/iio_simple_dummy_buffer.c | 1 -
 drivers/iio/potentiometer/ds1803.c          | 1 -
 drivers/iio/potentiometer/mcp4131.c         | 1 -
 3 files changed, 3 deletions(-)

-- 
2.49.0


