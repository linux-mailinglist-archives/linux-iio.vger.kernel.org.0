Return-Path: <linux-iio+bounces-19851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B114CAC2EE8
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 12:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B08A21369
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07B19E806;
	Sat, 24 May 2025 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SrtgbnFI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26A4A1D;
	Sat, 24 May 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748082876; cv=none; b=IZ/vkoujGR2/+0rDeuXjnMtFkuDaYI7VvgPXYMOxEECzdQyornhvwUFymT4OpqICFHIE5mJKRtj9Gs9ULdBn6oquL0ExsPVlnqabe5ztlTtdmPsqo9LASZnAuDQk3aU0lt+ewEYQEDqeKhbtrLnnVTLYGkjhE+ruTxIIr40Di2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748082876; c=relaxed/simple;
	bh=lsFtioseImBgHOQCJ/8wNlWF3Zh2XAqHF4Wf1kYgKMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8cucCYX4aOM7Di/zJhOSAUavT7QHLBFtBEQSxgCGq4C4d23IfaH2Ad7pQJD3ZRDvm5l4i7iTiPR7SYhUv6BEQI4eVpm1ic3NRNLf+yPsWfU3u3gHF2SOdEJwqK7ddYF5D619T+9uOUMe+4dREUXctKsX7lQ//hCQXkf7PqcAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SrtgbnFI; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1748082862; x=1748342062;
	bh=3utV04QVDNdgmlcQ0/F+/DRX6Wib0HgLdg3n7ShD7iY=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=SrtgbnFIqZ0jF+TED7bsuMBaYN4YKev1Eg1GL+UnoKZ0RrRbKneAEpfrwiZN1pLIY
	 b5sM+7UCD7OH1tqc2ybOHoPMgQjOslr3K/Tx9kpf+w1LuvD/Bj5Yovxgod9ZcJMRrr
	 h4zdVoCNuBjZuPnkd+VillxeRf3d42wmEjFjPskFGc3mz1I9WdWFl+TBGNri5e7rI9
	 l4ucd6BpnzgzB0QkmjdehzNfA9v0SITK5ovnnQmxihc2Bu0uE0yGEPMX5+qM/CiCxi
	 6GdnVz34KDN0hbwEEybRJGRyl6+p5gd3LjfPb9bAXFWLHDpHApS0piiVt4jw0325mE
	 x4xMnO+YOPd4g==
X-Pm-Submission-Id: 4b4JL43xZ3zDNK
From: Sean Nyekjaer <sean@geanix.com>
Date: Sat, 24 May 2025 12:34:09 +0200
Subject: [PATCH] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
X-B4-Tracking: v=1; b=H4sIAKCgMWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyMT3bSKnOKixORU3TSTFCODVCPLtCQjSyWg8oKi1LTMCrBR0bG1tQA
 mwpIQWgAAAA==
X-Change-ID: 20250524-fxlsrace-f4d20e29fb29
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

fxls8962af_fifo_flush() uses indio_dev->active_scan_mask (with
iio_for_each_active_channel()) without making sure the indio_dev
stays in buffer mode.
There is a race if indio_dev exits buffer mode in the middle of the
interrupt that flushes the fifo. Fix this by calling
iio_device_claim_buffer_mode() to ensure indio_dev can't exit buffer
mode during the flush.

Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[...]
_find_first_bit_le from fxls8962af_fifo_flush+0x17c/0x290
fxls8962af_fifo_flush from fxls8962af_interrupt+0x80/0x178
fxls8962af_interrupt from irq_thread_fn+0x1c/0x7c
irq_thread_fn from irq_thread+0x110/0x1f4
irq_thread from kthread+0xe0/0xfc
kthread from ret_from_fork+0x14/0x2c

Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 6d23da3e7aa22c61f2d9348bb91d70cc5719a732..7db83ebeea823173d79bf8ff484add16f575edfc 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -973,6 +973,9 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	if (iio_device_claim_buffer_mode(indio_dev) < 0)
+		return 0;
+
 	/* Demux hw FIFO into kfifo. */
 	for (i = 0; i < count; i++) {
 		int j, bit;
@@ -989,6 +992,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 		tstamp += sample_period;
 	}
 
+	iio_device_release_buffer_mode(indio_dev);
+
 	return count;
 }
 

---
base-commit: 5c3fcb36c92443a9a037683626a2e43d8825f783
change-id: 20250524-fxlsrace-f4d20e29fb29

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


