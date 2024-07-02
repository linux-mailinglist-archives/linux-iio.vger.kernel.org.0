Return-Path: <linux-iio+bounces-7120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0AD91F050
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB271C242E2
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848C613D61A;
	Tue,  2 Jul 2024 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEalWEyU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7E74047
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905717; cv=none; b=FMlL16ciFuv7t7cSlViI5wbaXzHYxV746yoNQBDJvfUZULkXjwVr8BMZDCdJJzmzFbKdcIg0opjI+Xy4snD4xHFQLKbnWTGQm0RjVZY73FH73wl3rZkfJJXs2gv2RkvXbSAiTtss+Q3ElCyV0zBQXvjBANeq3fcNXlivWKEvTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905717; c=relaxed/simple;
	bh=2qVhGY/eUm5eBfKrzpE+D4pFGrPGZbZlUfROe0PgEHU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=bv1fJXmX2xYgQm/mFvRTgi4b5r6/TTvfsYbNZxUU9KSwdoqY6eMUZRNxFNl4OmI/WdrhDPzRX851v5LJhXpPnVcoBlPFnesbEzFLtGbCwYO/bELPOglEedqFdjuFqvdJAZCUM+vUj7oDqc4zvkfIuzjE4SSYGzwu0p0hXifjuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEalWEyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D5FC116B1;
	Tue,  2 Jul 2024 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719905717;
	bh=2qVhGY/eUm5eBfKrzpE+D4pFGrPGZbZlUfROe0PgEHU=;
	h=Date:From:To:Subject:From;
	b=IEalWEyUO+eitJ6ksn6uHbBna7KXT7VKDeZ7fEGQNmhwyoDWUXZQa7xkEC+dnZTc0
	 NACvSo4rTsDmZQQST5xJ9tyLDUFXERv5SA4EwEga18NYoOzLxVph92zqn5sQMJHT+O
	 XR3DuMmrgWQp0Qck3/irPhJPjjid198ECcnJpbtW/lgmfH3rv4NfmMXicFOtLHH2D7
	 lsNE/duViLsjWGYrSiPRegacIu3igVy1r7tTvb9psZAjXpFDajVYf32zwKqdLypZ2h
	 LCsFJhKpbeTRmKMo/ca27Rgg99MuVhIXhkSrq0yc4jRXV3zyEQ/IaFZQZ7Ndreqmm4
	 jwV6bSzv9LI0Q==
Date: Tue, 2 Jul 2024 08:35:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO: 3rd set of fixes for the 6.10 cycle (or for 6.11 merge
 window)
Message-ID: <20240702083511.1197a537@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 8fe050e94daeb0280338d04ff8c6207dea44ddfc:

  Merge tag 'iio-fixes-for-6.10b' of ssh://gitolite.kernel.org/pub/scm/linu=
x/kernel/git/jic23/iio into char-misc-linus (2024-06-17 20:01:23 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fi=
xes-for-6.10c

for you to fetch changes up to 1a5cba43096c9242fab503a40b053ec6b93d313a:

  iio: light: apds9306: Fix error handing (2024-06-29 18:51:25 +0100)

----------------------------------------------------------------
IIO: 3rd round of fixes for 6.10

core:
- Trigger check on on whether a device was using own trigger was inverted.
avago,apds9306
- Checking wrong variable in an error check.

----------------------------------------------------------------
Jo=C3=A3o Paulo Gon=C3=A7alves (1):
      iio: trigger: Fix condition for own trigger

Mudit Sharma (1):
      iio: light: apds9306: Fix error handing

 drivers/iio/industrialio-trigger.c | 2 +-
 drivers/iio/light/apds9306.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

