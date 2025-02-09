Return-Path: <linux-iio+bounces-15206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6DFA2DFCA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7861885391
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37821348;
	Sun,  9 Feb 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khl3bvyO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D621E04B9
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124499; cv=none; b=fEIbTcv3Gz9o/9ts9BAhEvrmuW+yR8BKiD+10BuXp/33az91fT50uTCsgdwbwmW4+78iyGu9UDu1hq+vBzQHzqWg/DtTWy6XAIatOS0kOT+UVyrVOowDG8TeJ5WQk/M59o9HYGvAa9PdQsSJdUEYEjXDqdEa2cP9Rmx/8dEzzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124499; c=relaxed/simple;
	bh=LwIB0QjFiFttqsmzzseL4XqgAFsdKiLMYtEI0rnsli4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WB0+aT3H6P5iHkc6XKHRWcZRwZuII74y8qFYC2wb9Kw0Bx3aAn/T6ohgHGYaFAWX2Lyhv8TvxIVzMuxIcvMdKu0RgfJRSXtY0S/Rs8McqFnNW+hzGxdBYrtVR7ksZwuE3IJKzIpG+jIv3C+b0pFwBWuEaz7aCgTnQTT4mlCz0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khl3bvyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527D8C4CEDD;
	Sun,  9 Feb 2025 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124499;
	bh=LwIB0QjFiFttqsmzzseL4XqgAFsdKiLMYtEI0rnsli4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khl3bvyOsTgr//1j2NkEC/YcUUBn6vZ9YqRy9ba6uaOu1CCsoa7jt3pQVvWDMyymg
	 hWXIUYYOfyztlMv8UcI8TsLTU4WazOlt7oo9jmvyjFNUdb2RSkYldDKZRi00vq4ikv
	 xdJ3TRJK4fbBaUc/OIi55T7giEjkkEvvV9kWI8sz9pjZRcY4i+zuY54gaUL5m1/6V1
	 rQOr+SdHopnWe9XR3WrlDiqerXhx9Wuljw2ZDvCk4dr/pUfXtCL1G9H4hYlmrWCZXf
	 xgpFahvN3WC/Y9zV3x5x0lIPWKuLvdNWvIHGU5tafyJRh91TG9zczP+JmIDN3Rmew3
	 6cjX18OuWjnUg==
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
Subject: [PATCH v2 13/27] iio: adc: ad7625: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:10 +0000
Message-ID: <20250209180624.701140-14-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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

Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


