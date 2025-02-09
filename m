Return-Path: <linux-iio+bounces-15213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D4CA2DFD1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B592161BD4
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC0D1E1A08;
	Sun,  9 Feb 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7Q6GHO+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F91E0DFE
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124551; cv=none; b=Fp93mNzuQXlN7CJg+xf+cvqg6HEYhneFO326RjViaRtTCBiK8B6KmFFmtBTn8eEHqqgWhJ61KPaXryfyeSpts99Jne7P6m8jl4InFyMYPO+f23V64PC4wmmszWdXyypo6cS/IHvkZjQ3bfouAp0O1735WmFJxbVDmOVkoRnGknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124551; c=relaxed/simple;
	bh=bmwY4eYPSPwIYEQE0xzFBYW4Vk8fPKHIWAts6VBI7OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ztyahhvjet79lxHXJ7y09fCZEa2uy0JVYv7bpq1x+t3j8Rrk0wlX3d08sBt4bLXfz+o/IaPCTdTum/npmRfIDmCaNOq5xw/qBB8DXJ+x9ODgWo+pGYoESE0hPg9slrGbdfd4XCEHfhe3SPmLNKe1BRQ9PzK5Ca/Xmx47raOM+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7Q6GHO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D448AC4CEDD;
	Sun,  9 Feb 2025 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124551;
	bh=bmwY4eYPSPwIYEQE0xzFBYW4Vk8fPKHIWAts6VBI7OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7Q6GHO+RCIqsMYWLLiw5sEcnd1bvWzsMOF/EGf+F6UpflwbZz8eEq7T/umj4oL5e
	 8lDBcBxno2+5TL5DFi3hvdPOpYI5KKvQZh5J6xBo/GmtStx324AicYSLIEHrZWCwNI
	 ISToBPtHuQQRItrJTgveICJSXtpD4rvWMrMlN+i4pC2RLdoGhhPOl7+dlXZs2iaCE0
	 Y/qYKEQBiuh2KFcpDZHCwfE3ToaaFvSg1AwnnFH3hsLwnZE6K5YTiKVJ/j99Z7TtYl
	 S9EDuvNEc5WTJmSehNMTfDR0IhJUMnQn4uxUC7f/WfBs8Ol68IGg6+iz0UVm3/uMWf
	 5M8iXMsZ8IWoQ==
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
Subject: [PATCH v2 20/27] iio: addac: ad74413r: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:17 +0000
Message-ID: <20250209180624.701140-21-jic23@kernel.org>
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
to check for unbalanced context. Includes moving a mutex lock
into a function rather than around it to simplify the error handling.

Cc: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/ad74413r.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index daea2bde7acf..f14d12b03da6 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -826,6 +826,8 @@ static int _ad74413r_get_single_adc_result(struct ad74413r_state *st,
 	unsigned int uval;
 	int ret;
 
+	guard(mutex)(&st->lock);
+
 	reinit_completion(&st->adc_data_completion);
 
 	ret = ad74413r_set_adc_channel_enable(st, channel, true);
@@ -865,12 +867,14 @@ static int ad74413r_get_single_adc_result(struct iio_dev *indio_dev,
 					  unsigned int channel, int *val)
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
+	int ret;
 
-	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-		guard(mutex)(&st->lock);
-		return _ad74413r_get_single_adc_result(st, channel, val);
-	}
-	unreachable();
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = _ad74413r_get_single_adc_result(st, channel, val);
+	iio_device_release_direct(indio_dev);
+	return ret;
 }
 
 static void ad74413r_adc_to_resistance_result(int adc_result, int *val)
-- 
2.48.1


