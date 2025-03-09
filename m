Return-Path: <linux-iio+bounces-16597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C14A585EA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA59D1889E0D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878051DEFCC;
	Sun,  9 Mar 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN0J3hgD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46604748F
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741539518; cv=none; b=Q7NIm6xrzWxe+wIfBZyKLdinvuZEwhs96g0ESFBEw76QdFalxs8mspNRbUDQ3DSOjIVcoYg7fviLWNCSSq4HN4ZUI/WeesHNT2YBuXVGLQ8pmkr0wu40mv2mrCZHd/mRx6+cuBRDtPa4uFCnDEC+8zw6x4KkcjMNrZK/XxkE30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741539518; c=relaxed/simple;
	bh=AD2/woqzJPAcf+isDXVCrVfqeLXlrYYbHu7bDUTZPhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLLA04q169oEMJPVTIkk7mejZ9FrznRCft++AJDKG64KnXc0qkCjHH4P8VxhUiMOExUoIpHScSDvVgtidt7xp2IZVsM8ji7Q6zbRPXQTgs2lkvosx9qanzjL/dg1iaUUHlb9c/OWyxH4ny9QrwaVf365232YgIH0dtOahTfbjec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN0J3hgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E39C4CEE3;
	Sun,  9 Mar 2025 16:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741539517;
	bh=AD2/woqzJPAcf+isDXVCrVfqeLXlrYYbHu7bDUTZPhs=;
	h=From:To:Cc:Subject:Date:From;
	b=BN0J3hgDpLAkzxAlqPfhXRaYHnOu+HJ04aRRabw4Z10s1BjDy6qkq069vTUwSz/WS
	 YXLy+MWqm9PSKY0uapMpd3DxlvAPmsenzxAwnkcA5mgkjqGCPDfbjq2LozcPjSbsEq
	 UaP39ZDBXqYXRa0mvzxm+AJJczLZn+4Xk/CwDqbQ4AaBzXxY7VDe2vSorJ9H7uuJ39
	 D/yyALRLXMIkSOTp7UQUHv5w1/mwwzoQLqCI9lYCI9s+QEWCt8g5Um5mckEkKvihPL
	 4vOtRd0sMcNrolDll16tMwP05rrzkvSuGWRHGdcRIK9SnL34oAT+v91FJaM+6EKlSI
	 wkEemTmJaqz1A==
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/8] IIO: ADCs: Sparse friendly claim of direct mode
Date: Sun,  9 Mar 2025 16:58:11 +0000
Message-ID: <20250309165819.1346684-1-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resend of remaining unreviewed updates in drivers/iio/adc/*

I will eventually just apply these, but I'd much rather someone
else took a quick look to check I haven't done anything stupid!

Note that a number of the drivers touched in this series have no
obvious active maintainer, so it would be much appreciated if anyone
has time to take a look! It is a large series so feel free to review
any you have time to look at rather than feeling you need to look
at the whole thing!

This is effectively part 3 of what will probably be around 5 series
focused on moving from iio_device_claim/release_direct_mode() to
iio_device_claim/release_direct(). The new form is more consistent
with conditional locking semantics and sparse markings have been
added that let us detect miss-balance between claim and release.

More details can be found in the cover letter of the first series:
https://lore.kernel.org/all/20250209180624.701140-1-jic23@kernel.org/

This series focuses on the ADC drivers.

Jonathan Cameron (8):
  iio: adc: vf610: Move claim of direct mode to caller of
    vf610_read_sample and use guard(mutex)
  iio: adc: vf610: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ti-ads1100: Use guard(mutex) to allow direct returns
  iio: adc: ti-ads1100: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: ti-ads1015: Use guard(mutex) and factor out code for
    INFO_RAW
  iio: adc: ti-ads1015: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: mxs-lradc: Switch to sparse friendly
    iio_device_claim/release_direct()
  iio: adc: rcar: Switch to sparse friendly
    iio_device_claim/release_direct()

 drivers/iio/adc/mxs-lradc-adc.c |  14 ++-
 drivers/iio/adc/rcar-gyroadc.c  |   9 +-
 drivers/iio/adc/ti-ads1015.c    | 168 +++++++++++++-------------------
 drivers/iio/adc/ti-ads1100.c    |  44 +++------
 drivers/iio/adc/vf610_adc.c     |  36 +++----
 5 files changed, 105 insertions(+), 166 deletions(-)

-- 
2.48.1


