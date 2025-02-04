Return-Path: <linux-iio+bounces-15007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1C0A27C60
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68FE165233
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7A42063CE;
	Tue,  4 Feb 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLKfVlWg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5914B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699446; cv=none; b=C3F2+iR6iMhFvL3MKb9RS16zH1IjIUDzxKfvjzb4uvJSwJsIhD5zjdBm6PHjAAyqsBn1ET1KvLDIudrtXnYdYSzxn+5Hg2FtPBt/4N18t3VI4fWE5ihi2GLfsak4hS3s8Zza8FdZZs2Qvve+OOQdffyixIhIrZXp0COyEAPkC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699446; c=relaxed/simple;
	bh=gS/HIVU5XFKWydq5BDZfCCZHpWPqZUALxuaSdvvXK3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/lCz6nkzXIAI5SradMpJ6T0879uiGhCGriBB24u+V4bb8GG+L7TKjnlHYtfcfZVUAU7fuXDFZmXHYkz6difcu5iQWA+UWkhaHw85e+ZHCLvR9LiQeDkGrGRfg+KVZuIh+Z42cYUrUF+I8hMpdsRuEwug0TQhSQqPyOD3ALyjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLKfVlWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDF3C4CEDF;
	Tue,  4 Feb 2025 20:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699446;
	bh=gS/HIVU5XFKWydq5BDZfCCZHpWPqZUALxuaSdvvXK3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLKfVlWg/o+jyL93nKzYrP/pIQw9L7lcKXOqIDaIN1BQlZDWHJcctHaEghbTAa40V
	 E9oL00OHt5NBQVfjoZrkeOYhwIi/xs22whjW+KyjcKYTlI1RQ1rCouwDTePhg0RTE4
	 xcIDbX9TNnth/WSLOyflPdaRZQrUMNjsSolv60OePvryOTW98WZuHIn4pLzImXGbEm
	 8zRR+LhzdVhPEM2SQ6xvbxBzZjpJl5qptK0WaYwvWLVyUS86Gu65J/lfORwjB1XDug
	 a1mG3o7CcOoaZ567tNu3SEs6m1Qyg/vLS+j7KQCMy5aztWxhmfBO9jl4hqdUWDptMM
	 2nbwNFneHgRYQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/27] iio: adc: ad7625: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:35 +0000
Message-ID: <20250204200250.636721-14-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
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
Cc: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad7625.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index adb4e25dd7ea..0466c0c7eae4 100644
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
2.48.1


