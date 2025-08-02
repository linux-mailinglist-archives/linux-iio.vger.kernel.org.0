Return-Path: <linux-iio+bounces-22215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A211B18F89
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683031899842
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65416A395;
	Sat,  2 Aug 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMhG1Fr3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C942173
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754154947; cv=none; b=GOWb0ZZwI4/7g91JogYbN/45vqQQi4t+7lAxqIUB1mFYZyvuCeCAxMSlb+Sxt/ke8rVNHdVIlnqwIN0YctvPFgQrOrCVCWMyKmnzYXVfxV5xa1EYjl4KaIU6/2GmDpWnosYlUWNvG/0gEr3lROg0+IqrrXa7VNXtC20viOXSRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754154947; c=relaxed/simple;
	bh=Ka3Rrb0WG0hYxMHxAKBh2zM0Oh2Zb6Dp+zUrx/ttZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4xFoKVNgtt27Sy7txw5K/qLNKj7sW7TJcN1w8AI1JnLdOg4UCamsulQwJBnbAi7y3tNdo4p6wAVDHNp928wEBmQQ23RXKLA5aGNpMOFLefP3mzOQ0tFOxXE7M8bmZ1ctCJ/D+ONGKnogLiaxMAnj5vrx1XwMa8fYVIWJv7yXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMhG1Fr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6BAC4CEEF;
	Sat,  2 Aug 2025 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754154947;
	bh=Ka3Rrb0WG0hYxMHxAKBh2zM0Oh2Zb6Dp+zUrx/ttZi0=;
	h=From:To:Cc:Subject:Date:From;
	b=HMhG1Fr3dJ591jh3HPvuIibprOj6euaN0pAwKr769OyaWwniDY97YuG/qf9EMILdd
	 Tx//FHjO6fasiFuQOoeLljQYVLM3322nu8b6vr37J42l/9ab2VmxD6PYhs/o4uCObl
	 qLsJxJAxPITfqF2dYP1N1RxgxRNn2ljBHgbUBAqXT7SjAElpG17Rn6+mKgZUs/yYVy
	 BuJYTOqgdpp+EZW162BxbPK3T9fza+EbCaSmT5/lyXGH/zkqHU/+Myn0+7os4WLQXx
	 DAa7EfdW1AWuLjQXN0bR2hboow3peyLTRIV/9Zk37KRHXhIvjLRBIG3Bgca6RvR4ov
	 NVTpHnSls+4PQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Shen Jianping <Jianping.Shen@de.bosch.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH RFT] iio: Fix core buffer demux failure to account for unwanted channels at tail
Date: Sat,  2 Aug 2025 18:15:39 +0100
Message-ID: <20250802171539.518747-1-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The IIO channel demultiplexer code is there to deal with a mismatch between
the channels captured and those requested by user space either due to
driver supporting only particular channel combinations
(available_scan_masks) or due to multiple concurrent consumers (e.g.
userspace IIO buffered interfaces and an inkernel consumer such as a
touch screen).

Whilst this code is exercised by many drivers, a corner case has been
hiding there all along.

Consider an input of (postfix is the channel size)

a_32, b_32, c_32, d_32, ts_64

and desired output of

a32, b_32, ts_64

the current code ends up with

a32, b_32, c_32, d_32

because of a failure to iterate over the tail of unwanted channels
(here c_32 and d_32).

Fix this by adding the code to walk the channels in the gap.

Reported-by: Jianping Shen <Jianping.Shen@de.bosch.com>
Closes: https://lore.kernel.org/all/AM8PR10MB4721FB1A78F25B204BE3A26ACD5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

This is an RFT because whilst the reporter has confirmed that it works
for their case, it is touching fiddly code and I don't have the original
set of tests to hand that I used when writing that code.

Hence I'd like a lot of eyes + some testing on this.  A number of drivers
should have hit this such as some of the larger IMUs, but only with
very specific channel combinations that perhaps were never of interest
to users.

Thanks to Jiangping Shen for all their hard work figuring out what
was wrong!

Whilst this is being tested I'll try to figure out a Fixes tag.
There is some code movement so needs more digging that I have time for
today.

 drivers/iio/industrialio-buffer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a80f7cc25a27..d7dd9764091d 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1082,6 +1082,20 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 		out_loc += length;
 		in_loc += length;
 	}
+	/* Walk remaining bits of active_scan_mask */
+	in_ind = find_next_bit(indio_dev->active_scan_mask, masklength,
+			       in_ind + 1);
+	while (in_ind != masklength) {
+		ret = iio_storage_bytes_for_si(indio_dev, in_ind);
+		if (ret < 0)
+			goto error_clear_mux_table;
+
+		length = ret;
+		/* Make sure we are aligned */
+		in_loc = roundup(in_loc, length) + length;
+		in_ind = find_next_bit(indio_dev->active_scan_mask,
+				       masklength, in_ind + 1);
+	}
 	/* Relies on scan_timestamp being last */
 	if (buffer->scan_timestamp) {
 		ret = iio_storage_bytes_for_timestamp(indio_dev);
-- 
2.50.1


