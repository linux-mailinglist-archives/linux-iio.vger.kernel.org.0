Return-Path: <linux-iio+bounces-18049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E454A8718D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03473AF312
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB9F19D8B7;
	Sun, 13 Apr 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt80Nq9G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D32AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540507; cv=none; b=PD2THS8Cn9yuQr7W0/uebI/nbVO2lBYTt2UV8wvSM/M16fQthSPaRxcolNXjP7MWN2j+koNj6Lz6gOF9ZpSlzZRuxXK2jpSEy9ZlPJLOiqNygi547W9TAr0EZ2U7aTGbrwuUUPZZ1peabRuhuOdYAtRd0Xk4pRI/PoNjzCu1AUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540507; c=relaxed/simple;
	bh=a5SVTYnZmk+/a6ZCAwSH/vhLhQo2QYaGNjqSou2BsdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDw9P2pEZz3o+R8bb6l03OJoFKAYGno9at3/LvhYES3JDH1fLCK6YWmZbFdZWWjZrWJvp5P8rbMlgWvXryPOU2FavFvsviKXSYJHdfX3IfirY6VIJL1QOROnWJ1rylDyEgKql1X+MUWZ18jTm2OroqjOe5ynrYpiMGxehqyjCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt80Nq9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3D4C4CEEA;
	Sun, 13 Apr 2025 10:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540507;
	bh=a5SVTYnZmk+/a6ZCAwSH/vhLhQo2QYaGNjqSou2BsdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yt80Nq9GCKz2alFK9YprUzDavanzJ56+C0rPNTlXFFpU0KcGuRIjm+h+sHiXCY3Kk
	 2xqlg7vwDe8Q367ONZXrXu3CeZ7L0nPRcQk0OcfJF0jp9gdnEhUMfpzGQ8nokyvi6e
	 IKCGdUWUdL7HwEVwtdlr2M0c3tNbWPxtSXw15Lvc2XwYxa1mU8t5QwwllgLMQ9ocaX
	 H2zhoXdPL1oZP3F1V6ZFt9nSaUtT4ALQn02H/Zgu0gnxlTPJ10359uqACvJiX7VFr2
	 u6pWXcmnN8IDzU2V+gb7eKL+1qgl8FHOrMpuYQbmKRdId6SRnrvKEKekPRjA4wxda3
	 QVPjjqKwdHHkA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 05/20] iio: introduced iio_push_to_buffers_with_ts() that takes a data_total_len argument.
Date: Sun, 13 Apr 2025 11:34:28 +0100
Message-ID: <20250413103443.2420727-6-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Check that data_total_len argument against iio_dev->scan_bytes.

The size needs to be at least as big as the scan. It can be larger,
which is typical if only part of fixed sized storage is used due to
a subset of channels being enabled.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
- Use an s64 instead of int64_t for the new function (Andy)

v2:
- Rename size to data_total_len to make it clear that it is about
  data but also that it isn't simply the length to be used.
- Added an unlikely marking.
---
 include/linux/iio/buffer.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 3b8d618bb3df..5c84ec4a9810 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -45,6 +45,18 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 	return iio_push_to_buffers(indio_dev, data);
 }
 
+static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
+					      void *data, size_t data_total_len,
+					      s64 timestamp)
+{
+	if (unlikely(data_total_len < indio_dev->scan_bytes)) {
+		dev_err(&indio_dev->dev, "Undersized storage pushed to buffer\n");
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
2.49.0


