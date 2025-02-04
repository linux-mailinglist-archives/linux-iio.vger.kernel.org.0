Return-Path: <linux-iio+bounces-15014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C22A27C68
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCBB1884B2A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D52063F9;
	Tue,  4 Feb 2025 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwF4eYGu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530314B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699481; cv=none; b=Pui/S3zd4X3PE+8GQrcops1y6qQpe5dbbbpmRyY532VeWl+qZ6/IbkEqyR7PTxuMmiHrTvP0DYbhyK49bjzCuGCB4YWBK4urV/DtxklXPqyFalSQ56W1Y594LxPQuGXucyU2jv19PprgB4FbF1h5mhQxo5QV/Nm/f7YqbhzlFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699481; c=relaxed/simple;
	bh=b8qf5o8/lc7Hbk5D9Hk0uqj6i/6AWvOGVFKenRdE82s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyO67J5vxMPmd2GEkd79UDVHMGzaMZ5vDSf70d+8bBtWsNqwlEIvw6oxN0dOFae2jQmGwesXaOqimxKLq+eZl7EUr3kfjAcPlSnFN3c/ISN+BGAzTHFhhCqKBT8/olFbFIoFY2BBIcxg3elwcIcicnWEeJTO8SHidDP9PgOr5Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwF4eYGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22857C4CEDF;
	Tue,  4 Feb 2025 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699481;
	bh=b8qf5o8/lc7Hbk5D9Hk0uqj6i/6AWvOGVFKenRdE82s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwF4eYGuOckxkaR9o0STyD8vs0TMfeItqk6S+/Q8Qmi6CcZFsb2fS1jtN6vAOAiL1
	 VwOkV6MsYmVi+ROXPL9k3r4r1//9O0i5LBlTVWr+sKDZNWEx2/PRD6Ds7dxH18cNV+
	 jwQd40dqVOgJteZ648US6nGk6Jf5CEvg7Fwlz+4lAx5LpZDdjg6T/lhQ6sCNc8FBvQ
	 8cOSlNksUGXX3aDwnnjt9iNCpJGlboncYeESKNgyg7n6qu+qmruGOZUnO4yrcBUpRy
	 LJ14jhv5iS1MAc7dCCM5Og4UUt3bYeziHkEZXoCIMW6M47W7eNIoqMvUyc5MoeOd6a
	 pRnSoigxrLvKg==
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
Subject: [PATCH 20/27] iio: addac: ad74413r: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:42 +0000
Message-ID: <20250204200250.636721-21-jic23@kernel.org>
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
to check for unbalanced context. Includes moving a mutex lock
into a function rather than around it to simplify the error handling.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sa <nuno.sa@analog.com>
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


