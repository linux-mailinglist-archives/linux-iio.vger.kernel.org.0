Return-Path: <linux-iio+bounces-20178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC270ACC67C
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E31A3A3C5D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F35A22E402;
	Tue,  3 Jun 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="M33qxHlW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004A22F765
	for <linux-iio@vger.kernel.org>; Tue,  3 Jun 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748953564; cv=none; b=UGVVEW1O/9LhUamojXRcVwmroDfpLwWZcRB7bYXw4AE86Cp46nwBSfJw2lgQaTQVHCRRB05nW+kfuhJcwd2qNfRR3BfXfq8oWQQElyYY3G6C+LIQfK2OTCAWVyDhx1WRdQMmi4dG/FR8RwUnn8UoP+EY9D1H82qVK6RdBg21YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748953564; c=relaxed/simple;
	bh=/yXZlGDs4md91/o0FVCW0coTLoknhoIAGtxjk/CnPB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PS6TqtSWVp92SlDJDjGmxGaKJdkl4ct0ZK1WR43trWbd3qjvXhLus/oMqYtV1eMie4/Gd5/liZDYMQnpoEVMN5063LgGl12opQvT8DBbNvtx0dgtPSTEfOu4Cwr2HXd08CfTo+KQthd7HAVdWSLt5sjdCSmOZomwMrVQmC8CXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=M33qxHlW; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1748953552; x=1749212752;
	bh=3ez5X2N+es+sI87jrlyxEtNtyTKsgzhcCRRSrcaEdco=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=M33qxHlWhiExvR2Gqi6iP+7rnIC5jZekvPmMVCnPfneOZkhJ5nlQl69QIe67pQwhF
	 1ByWlj5XfdndnbJ2QTiFg+GaEZjLVM86TkAwDTYTHYMqbw6oMhokonwXewWKeAJdR1
	 mHWAK5Qp+ACqMU9DcLBb6SABpw8tmMQyykBNHyAk/RMK8L3oi9GRG1oUP/jIB1DI27
	 sv2pNYybbGm6POQRcza9ukBtpM/cJ7ikrdSBn2BwbU8LAnWux/BuWxVK9QMFjeX4Ip
	 WLIJEFnqim5H9LArQwVsrOYY8EarXeFVPe9869aRfROxhMnEy+JGgDr7M6nwsBhB7Y
	 TSm3WSsmM1TUg==
X-Pm-Submission-Id: 4bBVL63mZqz1DDSS
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 03 Jun 2025 14:25:44 +0200
Subject: [PATCH v2] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-fxlsrace-v2-1-5381b36ba1db@geanix.com>
X-B4-Tracking: v=1; b=H4sIAMfpPmgC/23MQQ7CIBCF4as0sxZDJ0WtK+9hukAY2kkUGjAE0
 3B3sWuX/8vLt0GiyJTg2m0QKXPi4FvgoQOzaD+TYNsaUKKSCgfhyjNFbUi4waIkHN0DR2j3NZL
 jslP3qfXC6R3iZ5dz/1v/ILkXvbBklDxZczlrus2kPZejCS+Yaq1fB8s/maEAAAA=
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
synchronize_irq() to ensure that no interrupt is currently running when
disabling buffer mode.

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
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v2:
- As per David's suggestion; switched to use synchronize_irq() instead.
- Link to v1: https://lore.kernel.org/r/20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com
---
 drivers/iio/accel/fxls8962af-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 6d23da3e7aa22c61f2d9348bb91d70cc5719a732..f2558fba491dffa78b26d47d2cd9f1f4d9811f54 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -866,6 +866,8 @@ static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	synchronize_irq(data->irq);
+
 	ret = __fxls8962af_fifo_set_mode(data, false);
 
 	if (data->enable_event)

---
base-commit: 5c3fcb36c92443a9a037683626a2e43d8825f783
change-id: 20250524-fxlsrace-f4d20e29fb29

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


