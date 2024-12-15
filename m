Return-Path: <linux-iio+bounces-13522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A59F2559
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4206188548D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E41B6D17;
	Sun, 15 Dec 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyPhiDXI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB742149C41
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287415; cv=none; b=imfEqYJQBIEP3fGGI3uCUXck7pifxB+ZJyBU3Pm+uncATbDL6Sdxc1nT4ihnADFwdup5lFeUHUOATxjkGQHdX30SLAEO0TZtM2lWWA9vQbcT8g7nhTJAZbWr2XDZ9paEHxmPWOjH617A0PDrm98OQtuq3TCYN0cJAo0HJ6RuEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287415; c=relaxed/simple;
	bh=QfoBBvHQQB5OnC+N5aALu+RsqgzPQLZkx8KwEB82kTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXEqgF4dQp46Ees7saMAvrtvdN2jBSxHsV83ECXmAVQkmMCBQRsOF8ijZ0blWBDoSiWmY5bG7ySQ1W6NN9nkYnuKc6uxJ/BKL9qB+3wPkfOyu+r8C1DMRh5uWfN40IaL1yc5eXb8bV1ADEay/jD7cnZPDQ9Ue2ISUBlWtQLmwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyPhiDXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3EAC4CECE;
	Sun, 15 Dec 2024 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287415;
	bh=QfoBBvHQQB5OnC+N5aALu+RsqgzPQLZkx8KwEB82kTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyPhiDXI+ADzR17nDGv3pfk7iK4SyCznxPI8TUtVRAKlWB5V1LALuNHDMqmjo6mgY
	 clfgFqZlY8I14nqPNGNaYQ7Mj3TfHmT01MQvNK/YEHWSeizxL1gKcuPMI/l8JZCjBN
	 vy3Cf35OdqMfX9dcz0FbK3z0ZW+ljCz3VRr2qV7Bljc2nQWvOVPOJGU+KxkH0Bqa0D
	 UVST3clcYnBC2CovHpEecJD/jR9oNOtdfh7o/h0WKvzhOQE5+YSllfCjeUlGluaXS6
	 wzw+a0eVJBkaae9z8vYcZrWx00+xpRmMOZ8x2z9DVlUb0wsBbqpHbD7foBxlDpKQtv
	 UIlJg4aTi6q5g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 17/20] iio: chemical: scd4x: switch timestamp type from int64_t __aligned(8) to aligned_s64
Date: Sun, 15 Dec 2024 18:29:08 +0000
Message-ID: <20241215182912.481706-18-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The vast majority of IIO drivers use aligned_s64 for the type of the
timestamp field.  It is not a bug to use int64_t and until this series
iio_push_to_buffers_with_timestamp() took and int64_t timestamp, it
is inconsistent.  This change is to remove that inconsistency and
ensure there is one obvious choice for future drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/scd4x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 52cad54e8572..50e3ac44422b 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -665,7 +665,7 @@ static irqreturn_t scd4x_trigger_handler(int irq, void *p)
 	struct scd4x_state *state = iio_priv(indio_dev);
 	struct {
 		uint16_t data[3];
-		int64_t ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	int ret;
 
-- 
2.47.1


