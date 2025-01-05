Return-Path: <linux-iio+bounces-13913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA39A01AE3
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E055161E24
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F1186E20;
	Sun,  5 Jan 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HF8EuydL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A388F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098019; cv=none; b=HU83grc/Y2AkRZjvIxcruwvuskFXjeEFVby6av81Pn84syCP/dMlzM1T9r0glEw2O/5svkNPSbi+RPyLMCGJaXwxgZj9q1hnlLzpLoTzMHM573kxIBc9qbM9f+MP/nbPsNJI/HjVtTS/Xkxafhhnbd5Nk/bi3e6H8Fm317kcLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098019; c=relaxed/simple;
	bh=KU6HxxU/RSeeEVD61ryK+g3swM1J7O+RmQKPu0C5KYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVJm5X6T8+YleWIrUFutEOMEcyvqELZketcY3muk45cmzjSnXXh+J6DI8a97htCQDcoF7trWvWdT8CbvQyEh2cr4ockVIFA7R+yTJ/H3IZiW2Leux9JZtVTgHWMwq7jxOyp0eDkcrFgCkSODoY6EKvXIKEzd+sEqSgah7PJ2rZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HF8EuydL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8DAC4CED0;
	Sun,  5 Jan 2025 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098019;
	bh=KU6HxxU/RSeeEVD61ryK+g3swM1J7O+RmQKPu0C5KYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HF8EuydLGUw4pbzZkSNraFKQsxhgmX0t/dyEePWXWnp09rdM20GyNZ7XYo3c1AzUn
	 fxhomcbkiKPkur/JCEehNRZgPXX6Zsts8XtxQwekpda8PQzR2p8FxOVIduPmMkOnLk
	 i+JmINzr7DUt9YPIZR5b3VRKBfmXqxuqkAtfOy3njzU4yhOt2lUFpElVouCyI9+sr0
	 Hf/O4SbQBEhrXlGDm3Wo0PyyGzxTYwMMD6OZtyX9+AhPWyJV5iXVeNySbawSktUXnV
	 OJ8kgzb0qR/zQp02/r8X3OUd+m4UIcf8rXM7PfiT/gxbYVnxvVQDX5vKF9zz42vvoE
	 I17VHXdVI1Z9w==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 14/27] iio: adc: ad7625: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:25:59 +0000
Message-ID: <20250105172613.1204781-15-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250105172613.1204781-1-jic23@kernel.org>
References: <20250105172613.1204781-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7625.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index afa9bf4ddf3c..a39c970450a2 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -248,12 +248,15 @@ static int ad7625_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long info)
 {
 	struct ad7625_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return ad7625_set_sampling_freq(st, val);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad7625_set_sampling_freq(st, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.1


