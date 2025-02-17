Return-Path: <linux-iio+bounces-15666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C8EA38548
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBA4171707
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23F21CA07;
	Mon, 17 Feb 2025 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxUvq4R/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D251422083
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800928; cv=none; b=DAxZ33iWHrlkc4YLFbCUyv/XQeWIy0cusYzOS0g/WGEXfyM7gTpeQN22sTuKDpTL+jOTP78aETFtb7sPur50kRsAGz3Qzd3j6W/aY0X6OLfxoGPBPT9S3spGTuuW82LCv/qqGrrO0ybCb8EerHfMkbYcfIO9MsD65fePRLd4XXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800928; c=relaxed/simple;
	bh=c5hQBcmykqE5kevKEtWoKMRPV69pPk8Kb6TSM8JIITg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS2WQUnpByFjU9qoAoyOwjYG3f9Maoc7xjTPNbkzC8D9xGYoDdpl1FzsXFYi06Io6uDRRW6Ee36EWX8Qs+zRoR0vW5Vv9mmO8zbvMAAfB3/c5IIuoijpa4PwZ3aC8aeKlDt8oLCvEUC6YJC1fSZ/PMOZuW3paHlUrgGo4hYV0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxUvq4R/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971CAC4CEEC;
	Mon, 17 Feb 2025 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739800928;
	bh=c5hQBcmykqE5kevKEtWoKMRPV69pPk8Kb6TSM8JIITg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxUvq4R/WUwwsCkO5yRW6Pp+42gC6cR5jnaTpyCJeW0KWwIXC28R16/zBbRNrqpmh
	 amRKSXJLtYAsPh9q6t6MZ/CvKaoopp4dE9qakC33Hb5LhJ8QFInkvc4ZjmJm6ppSIP
	 hSaM7ZWFnOUkuWmTaVxqxIl8eRbAxBunNF1AHLKyr3YCQgU6yyzWE478i9Q7eXA/Oo
	 /iabbWyORywbavKk6TI+YbPoK8OsB9Puwe2DHXIRXdXS/puYqYJLVNOUIVVfDltLmC
	 xN2GMSN9vyIDm6xxGx+CgjMn7QjapprWMPzJei8/0nVYFr/qvSihc7T2gAUNhPb9xB
	 g3cDwUGQ0krMw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/8] iio: accel: msa311: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 17 Feb 2025 14:01:34 +0000
Message-ID: <20250217140135.896574-8-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217140135.896574-1-jic23@kernel.org>
References: <20250217140135.896574-1-jic23@kernel.org>
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
 drivers/iio/accel/msa311.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 7f4ab7cdbc4a..d31c11fbbe68 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -594,13 +594,12 @@ static int msa311_read_raw_data(struct iio_dev *indio_dev,
 	__le16 axis;
 	int err;
 
-	err = iio_device_claim_direct_mode(indio_dev);
-	if (err)
-		return err;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return err;
 	}
 
@@ -611,7 +610,7 @@ static int msa311_read_raw_data(struct iio_dev *indio_dev,
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	if (err) {
 		dev_err(dev, "can't get axis %s (%pe)\n",
@@ -763,13 +762,12 @@ static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	 * enabled, because sometimes MSA311 chip returns outliers during
 	 * frequency values growing up in the read operation moment.
 	 */
-	err = iio_device_claim_direct_mode(indio_dev);
-	if (err)
-		return err;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	err = pm_runtime_resume_and_get(dev);
 	if (err) {
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return err;
 	}
 
@@ -786,7 +784,7 @@ static int msa311_write_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	if (err)
 		dev_err(dev, "can't update frequency (%pe)\n", ERR_PTR(err));
-- 
2.48.1


