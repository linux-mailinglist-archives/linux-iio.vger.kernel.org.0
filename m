Return-Path: <linux-iio+bounces-16630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A1A58731
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 19:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBBD3ABF90
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F11F874B;
	Sun,  9 Mar 2025 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJcYTKA6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE721F874E
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544508; cv=none; b=Nyw8pDrpsjidxBrMEFlo3yzJipikW7XrvWDxHOZ9fprFVUzwnD/SG1IjOoM1VWoJ8tFZ2yz/UcPHC93BpZvJeYQYcOrxBzlmlHRfSdF5wB+eV/zyM8GucN/mKMrZV/CcuFtVYrQxj3qvdW36vqPxby1r8y6ezqARgnQlMTJXI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544508; c=relaxed/simple;
	bh=SvTmjI8niBktBGht8PkuORYx7bpEvdvI0Qw8TPVAeSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+x2Ik4za2jvh7/MQ5ldImVWLqw2WxZUwN4mokmfiNCzpTGXEYdWRM/Kms+XS+4Q60oDz4zjy6MLAbGY0vT74Jgw587iaSVSCEoQmHi/uCqEfW5FQDf3yUZUshW1Ou6Zekd1orb9jMf577PDeW1YVRZdUsxYuFWPeAvIFd7RDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJcYTKA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B455C4CEE3;
	Sun,  9 Mar 2025 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741544508;
	bh=SvTmjI8niBktBGht8PkuORYx7bpEvdvI0Qw8TPVAeSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJcYTKA60dOTxFmHxmrCtCC2D6IOUUqhGLBOCxuoJsNsI7TKPdMsgcKT+SYPgpeef
	 w9Ctg7mIv7A8/QZbbzk5qXfpfHIifoicWYlTgp8EXyM3IjfdDIIUWb81SMEIxVKv8N
	 4v8FhWmfUYSYvWd5pCYQpzxebYsCgJx/yH9FFUYBIra9AR4b6wz+UQiQO/hIPfRKBW
	 Qj/kW7zziiUSwGktfjlDXE838uA9b1xLG6ux8F+Ane4TaD3HuuycGiQlQKj7rgP2YU
	 QbJQcELnT0D+SmlhNKeU8qNUyouMpm8q0ItBjSHqEI3Z5Z5u5Hcsnkx1zFs6n4dkuS
	 JxCxYMa5NQt0w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/16] iio: adc: ti-ads131e08: Use new iio_push_to_buffers_with_ts() to provide length sanity check.
Date: Sun,  9 Mar 2025 18:20:48 +0000
Message-ID: <20250309182100.1351128-5-jic23@kernel.org>
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

By providing the size of the buffer used, runtime checks can be performed
to ensure not overrun.

Also change the pushed data pointer to be that of the structure that also
contains the timestamp.  Not an actual bug but semantically incorrect
to push the channel data when we want the storage with the timestamp
as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads131e08.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index c6096b64664e..6e83d370f0b5 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -664,8 +664,9 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 		i++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->tmp_buf.data,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->tmp_buf,
+				    sizeof(st->tmp_buf),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.48.1


