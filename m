Return-Path: <linux-iio+bounces-16627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82AA58722
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCB9188C1B3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47484215050;
	Sun,  9 Mar 2025 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lbp0d+ft"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B6214A9A
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544502; cv=none; b=IG7/jWSaIpdbMst+jM1b142BAqlId4FNANo9DwpEtvVeGizmPqCK0BbSijBaUH4pM27I3/PIodizeVR9pW30raT0Av0WHBDfBzlJkdrWX0L+7OjuK2mbkrXqptuN2TJn5Ab8nVsfcU/slsaG1YGqcLjNNoMzYqElem+NX8XeB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544502; c=relaxed/simple;
	bh=tBjYTi30fghSWvEl8GUjy0zmQdIqQAM7k37MnI3Sy/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B46DnoULdulxtK0o5TG2szQEVj61JE4eqi5w4hXshseQuz+L18KUJI5LhtHnwUcp3g7TD9vqoXe3iEEdBVBZAxNcYpFZSkShOBgh7utYK5wiH1j61NMW+lWajyaKqd4hsppQz4k9cBsQ1wQ96yrwtFdTx2gMB1kLY2OfxUAUCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lbp0d+ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD1AC4CEE3;
	Sun,  9 Mar 2025 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544501;
	bh=tBjYTi30fghSWvEl8GUjy0zmQdIqQAM7k37MnI3Sy/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lbp0d+ftVbjygyZ1oVDSgghljrP76GrqeO4FXqWEEG1nMMNbWnfHYfAcaOioYFtJI
	 fIWcZZ2HJ74OZR75HqtZiclKQsfs7eQaSZsb4jXQEF5SoUoyC3DbEoWSsQodks40am
	 iNOphwetrrsGPOs+gJHQLxzBLiAhriMQsvXNSFu0J1cYNDAdh9Lh9VpvL4VPj2ma8W
	 ZDP8WdC4vpeJ4R9B+9SGtQG9yrfe481zS2QrLkCMvqqVwbtw7Oab8XHimNWeFHtD02
	 PzDEN50o4dj3YYrDS5f9RPT7A/ebMAEtzWRAWRol9dz0IFxr5gnL07fykwm4KKwp/A
	 3mtf6DFagEWvw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/16] iio: introduced iio_push_to_buffers_with_ts() that takes a total_len argument.
Date: Sun,  9 Mar 2025 18:20:45 +0000
Message-ID: <20250309182100.1351128-2-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309182100.1351128-1-jic23@kernel.org>
References: <20250309182100.1351128-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Check that total_len argument against iio_dev->scan_bytes.

The size needs to be at least as big as the scan. It can be larger,
which is typical if only part of fixed sized storage is used due to
a subset of channels being enabled.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/iio/buffer.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 3b8d618bb3df..75d5e58b646b 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -45,6 +45,19 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
+static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
+					      void *data, size_t total_len,
+					      int64_t timestamp)
+{
+	if (total_len < indio_dev->scan_bytes) {
+		dev_err(&indio_dev->dev,
+			"Undersized storage pushed to buffer\n");
+		return -ENOSPC;
+	}
+
+	return iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
+}
+
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data, size_t data_sz,
 					  int64_t timestamp);
-- 
2.48.1


