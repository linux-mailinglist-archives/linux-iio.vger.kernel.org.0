Return-Path: <linux-iio+bounces-16615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E27A58604
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F37A475F
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC21DF742;
	Sun,  9 Mar 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR1mvApY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D902AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540043; cv=none; b=NhRf/rDQ5HF1cltFgSd9OoKx/5p/JyUnLq8Z6MYF9076ZR1oAzPueqNpmsFwcw89/PZdWOP3LB+PSCI0txxG/lhxjOOgQWI/4W7Mluiv+YaiwMjdI8kcbyWH1CuDR5BEUJFRdpzfQRh4P2bmsocn0dtleIQKegr/LKkjh42+C0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540043; c=relaxed/simple;
	bh=ye0c/buz8uMKKYPCulz2vhbBKAzVviJVStdeIP3qkyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5Gee9iJg56FlCVo3xGbRUcQIDC9acOWpyZm8y5iXOjszeTPyClO/aAYT7UarLbP7hFe/anO6wiWe8NhzCg0o2fMCF20Tu2TTtrJ9c1LesOZuatwztghDu07SN2oQ1TtpEVKry9Uqy5VIuDi4x/bo0y09KfM0YpLuYw1P1pVXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR1mvApY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64292C4CEE3;
	Sun,  9 Mar 2025 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540043;
	bh=ye0c/buz8uMKKYPCulz2vhbBKAzVviJVStdeIP3qkyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KR1mvApYT5xH+hQnFjqqjkNv7hCUV3t9dxsnRbOSjGcA5fhq1dqNOKs6skKQ8710y
	 XcreVYqsEIsoYFHoGoOrlSt5WNOohDwVBZx2m30e0yKzpiumhXPy2A9Le6v39xMkJK
	 xULdy3x6jMuzpA9ILs4swDBT5jdluTpdjPqoALfJ4G/uepJZpdSedfY77AK68rOcqi
	 +Y1cbXcCx85jf2myiZKJAmxBZZgvQhLvrXAMHP1Ney4B1Jt4m7es8gmaxFHeENmopB
	 vW8lo3qnOicX4fQNPw0eAxVx/LWAJvFtREhu+T9dA5FQLgXLcdc/WjVetyOX1OcnIz
	 LiqJvcB2vHRYw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/18] iio: light: opt4060: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:24 +0000
Message-ID: <20250309170633.1347476-10-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
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
functions that are deprecated.  This is a case where the code
is pinning down the mode so also has a claim on buffered mode.
A follow up set may move those calls over to a sparse friendly
form as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Per-Daniel Olsson <perdaniel.olsson@axis.com>
---
 drivers/iio/light/opt4060.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index ab55f8d2ea0c..f4085020e03e 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -311,7 +311,7 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 		 * concurrently change. And we just keep trying until we get one
 		 * of the modes...
 		 */
-		if (iio_device_claim_direct_mode(indio_dev))
+		if (!iio_device_claim_direct(indio_dev))
 			goto any_mode_retry;
 		/*
 		 * This path means that we managed to claim direct mode. In
@@ -320,7 +320,8 @@ static int opt4060_set_driver_state(struct iio_dev *indio_dev,
 		 */
 		ret = opt4060_set_state_common(chip, continuous_sampling,
 					       continuous_irq);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	} else {
 		/*
 		 * This path means that we managed to claim buffer mode. In
-- 
2.48.1


