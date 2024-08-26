Return-Path: <linux-iio+bounces-8816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149395FB95
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 23:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828121C2103A
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E519ABC3;
	Mon, 26 Aug 2024 21:23:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0013D61A
	for <linux-iio@vger.kernel.org>; Mon, 26 Aug 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707430; cv=none; b=djtPaNCY9YmiPLLLpwLJYTxYbfFcykDxeFBxARN4CoHGSSI08DqW9OFzFrWGi1U3wqDm+vn7lSrSSsxbaN0wa6GcHerKNRFwCT/Hrt9tNTK/Uccc7IW/YmYbMBBEtmNRqbSgW0SnpmeZsFrpfqWpXxwpp7JY4Zvxkssben0z9A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707430; c=relaxed/simple;
	bh=tg4FG3gnn4wsUsXMgSc1EDgDopNHuoZayLRDtOQjQPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3ifKRtCujF8Ex3IkALxrfWsIEzen1TKemPqT8eTT6JT44Jj8KbSESP1XwPUvAtO1XhmQLwzRjbZr4ALCZfgUW1NF2xoO+zzwljLNuVUzpnfuGfk0f1EWVAIgOkDimUtre4e6DF40vGvT3oVDooJ3CZbwbvLg4tO4rc7ci6TAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 79b27532-63f1-11ef-8e5b-005056bd6ce9;
	Tue, 27 Aug 2024 00:23:45 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/2] iio: imu: st_lsm6dsx: Clean up ACPI/fwnode code paths
Date: Tue, 27 Aug 2024 00:22:38 +0300
Message-ID: <20240826212344.866928-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a couple of cleanups that should not affect any functionality.

Andy Shevchenko (2):
  iio: imu: st_lsm6dsx: Use iio_read_acpi_mount_matrix() helper
  iio: imu: st_lsm6dsx: Remove useless dev_fwnode() calls

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 93 ++------------------
 1 file changed, 7 insertions(+), 86 deletions(-)

-- 
2.46.0


