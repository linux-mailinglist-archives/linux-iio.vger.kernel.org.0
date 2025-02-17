Return-Path: <linux-iio+bounces-15659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DEA38540
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FBB188E276
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636FC18E3F;
	Mon, 17 Feb 2025 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn+IBB1P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AF33DF
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800906; cv=none; b=Thd75dfMcqh7V0SglTS0Ceky4Zdm1Z7k7YefFkSHyRAP+CmWrClCT4vU1c2cut1KhiulKzIZcTaLWMcPoctXLX0+S3zlTAdXuCNrLuDFCCjEfE0/dv4mHrionFuAGPi/J0JR+FBuFQchVa1AqcauHBOfEYIzfPdqwSo25Rt17FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800906; c=relaxed/simple;
	bh=joZqa1kOkCOCZgherMEIQsuwWNb3hoU1WM+RYULVCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sFMtfOBDim0ZSSmJy3R3PbQWFxGh5Q3dj168LGZaVQGNp3uNQJv1U08l/7JL/62OLJGLyOBZhNgTRrUbrAra71xdYyeKCNNCxy59Y3qTYOlG9Vsej14tUbMxfHFAE/4uQSjZ7b0877c2E7kTnWg9IkbdQHajaNEJ8tQJfpoBl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn+IBB1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC030C4CED1;
	Mon, 17 Feb 2025 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800905;
	bh=joZqa1kOkCOCZgherMEIQsuwWNb3hoU1WM+RYULVCCk=;
	h=From:To:Cc:Subject:Date:From;
	b=Qn+IBB1P1OOKdEDOZouQDoDqIzOwvC8TeJONXn6eXFdc2x45M+1++UjZrNrS0r+Gw
	 d+bpjagb1QCj3KFjC7xkZJCk2UaVp8T5GbqcCFiDPZUGiid/kHBgKJZn7rj4lmE/w0
	 suPZlWDzJyj/JdV9Ij4DSoYacNUJ3dQlc7Ggu3YWNFWWBf5FOGaEbjRJse3LVDc8FV
	 K91s/Uijap9xniQqwZh4poMBWoMV14J7kSA9R8SeFwRkZh9LXrx1wFTOjpe/gUTDp9
	 3Rzyag1hz3l2458wggr+wjBm8u5FIEYr47L2wAAYr3pU07qGOggPSJfLbtXGOnC6rI
	 5mtC8Z+oZ0iKA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] IIO: Accelerometers: Sparse friendly claim of direct mode
Date: Mon, 17 Feb 2025 14:01:27 +0000
Message-ID: <20250217140135.896574-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note that a number of the drivers touched in this series have no
obvious active maintainer, so it would be much appreciated if anyone
has time to take a look!

This is effectively part 2 of what will probably be around 5 series
focused on moving from iio_device_claim/release_direct_mode() to
iio_device_claim/release_direct(). The new form is more consistent
with conditional locking semantics and sparse markings have been
added that let us detect miss-balance between claim and release.

More details can be found in the cover letter of the first series:
https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/

This series focuses on the accelerometer drivers. There are a couple
of fixes in here that showed up during the conversion.  They are
old issues in error paths that I guess no one hit in practice,
so I see no reason to rush them in before the next merge window.

Jonathan Cameron (8):
  iio: accel: mma8452: Ensure error return on failure to matching
    oversampling ratio
  iio: accel: mma8452: Factor out guts of write_raw() to simplify
    locking
  iio: accel: mma8452: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: accel: kx022a: Factor out guts of write_raw() to allow direct
    returns
  iio: accel: kx022a: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: accel: msa311: Fix failure to release runtime pm if direct mode
    claim fails.
  iio: accel: msa311: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: accel: Switch to sparse friendly
    iio_device_claim/release_direct()

 drivers/iio/accel/adxl372.c           |  7 +--
 drivers/iio/accel/adxl380.c           |  7 +--
 drivers/iio/accel/bma180.c            |  7 +--
 drivers/iio/accel/bmi088-accel-core.c |  7 ++-
 drivers/iio/accel/fxls8962af-core.c   | 21 +++----
 drivers/iio/accel/kionix-kx022a.c     | 74 ++++++++++++-----------
 drivers/iio/accel/mma8452.c           | 86 +++++++++++++--------------
 drivers/iio/accel/msa311.c            | 32 +++++-----
 8 files changed, 119 insertions(+), 122 deletions(-)

-- 
2.48.1


