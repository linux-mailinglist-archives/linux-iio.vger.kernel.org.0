Return-Path: <linux-iio+bounces-17458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E745A76597
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818FE7A35A2
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A01E51EF;
	Mon, 31 Mar 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKnMD10C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146E1E3DFC
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423391; cv=none; b=FtbFepDL4kEE29zpOOnXoYpNCEXgN9VkOOMm6BFqVZeNeMRUmdakR81UvswbzJGyTedzNswM6rrJtwQS5QO0nl4aMbZgGmJ8VHzQp4KzaAFAKvYNeUkOwaynk1ZtxxvYhgqfN81wdwOvvqVbd4Y2eQJwaqePmLeF7he7UVVAdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423391; c=relaxed/simple;
	bh=Iz4qiV8Ly1KzdhGnc1n/KWhYz9IveIFj9UfC1DZr6/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAJhASxaSESVuW47uns921BpKmUCa7b/KOhL3SezhGAWpOlG5AqBiLDONdzfD86kbuFVLJizj1wKO7s6Jxrv1AkTtq6aERwpBJIhTW2/0YfnobssGhXtFMLBPESesNCbtrkOM/0J51mISFZ7KFE0AUKbLH7040iCAEAjuGB0+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKnMD10C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73877C4CEE3;
	Mon, 31 Mar 2025 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423391;
	bh=Iz4qiV8Ly1KzdhGnc1n/KWhYz9IveIFj9UfC1DZr6/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKnMD10C0ipWUvbEmYzf9KuRV+PqW2GYJBtrLWn7huLpojtVr0VvwDYQ99S5ZKyQG
	 /wN7e3kvuEldkiJ+7Y04DfaO232SZyYzJlNocOqUmt286Cz0MbEKeh64hZrAZ8M5NW
	 IymYWkiZjzv7T4xomYevTAlhpuMLdh06X8NkxZ+JAIbafjCtMduVvs5oR1qk1yyRAl
	 59EgOJoJA11spP4en2vAWwVOLH1bjMBn+f+OWG2nq2vl/5sS382fykjA5VAkmvLato
	 eVNurZphBTegCr8lbhO3IjGGPVlKGLgU6IXacm/vLZD0ub3htAkH9camBhQXJsJdeA
	 0lzoawSby6J0A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 28/37] iio: pressure: ms5611: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:08 +0100
Message-ID: <20250331121317.1694135-29-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/ms5611_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 00c077b2a2a4..bdac27bd5a5d 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -308,7 +308,6 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
 {
 	struct ms5611_state *st = iio_priv(indio_dev);
 	const struct ms5611_osr *osr = NULL;
-	int ret;
 
 	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
 		return -EINVAL;
@@ -322,9 +321,8 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
 	if (!osr)
 		return -EINVAL;
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	mutex_lock(&st->lock);
 
@@ -334,7 +332,7 @@ static int ms5611_write_raw(struct iio_dev *indio_dev,
 		st->pressure_osr = osr;
 
 	mutex_unlock(&st->lock);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return 0;
 }
-- 
2.48.1


