Return-Path: <linux-iio+bounces-13919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2175A01AE9
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6752A3A2EE6
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 17:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1957189B8C;
	Sun,  5 Jan 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQM/yiPl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF08F6C
	for <linux-iio@vger.kernel.org>; Sun,  5 Jan 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736098035; cv=none; b=W2RSLaU0OxT4GOOtsSJEY7vneRllM9EgklWC5rQmvohBGvP7XCENd/er6c1ryHm4tiHcK1Dcm5x0uvbRN0CyfgNpGBtrs+VIn43WXKbFNAQ4FBM58SNi3FxKt/hjPtwMjrlCW0t+hYwm8a2fw7L1M73C0PrED+jW3lDEfeybPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736098035; c=relaxed/simple;
	bh=Q6Qsf2gEdxsJrcccQEnvDysXVWC+F3Su4CC6BUMXIQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6/9Ke/hYEfVQlkbN/l0CmP/ZmlGiILDqPPWwpoY0HLboIP9oXuxhfgfT3dueVpkH9v/VcD2G2nQ9GdTCGZ+s3EhanxYipgeLA0gyw5LxSjKK9eproXhwTLhkPvlBkDx0zPIZHu8w6ue0FTz9hWsTUnbgzwWb1TFOeLA4rC8Abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQM/yiPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F501C4CEDD;
	Sun,  5 Jan 2025 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736098035;
	bh=Q6Qsf2gEdxsJrcccQEnvDysXVWC+F3Su4CC6BUMXIQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQM/yiPl1yR8jTlexAQ/bkqgBCIU7GeQf7DVpYcn7ps8xHiTh1Ifao10jDU1UgA72
	 bcvPBrFhWzC5RBz0VuD3aDQv3BF9iZNeCb6uO0hYIBPn8CQvsHIgP1UntVrsqEDyUa
	 Dx/DulYpBDQiNwXxBErCSFV2dhU3PyeBFxGgMaNDUtxr0ZOhW/Q4nUaSWscyaX/v1S
	 AaTjzCjo31DEuFDe3yRm4HulzO7lUcXz7E+Vkguanh7hxucUn2XnWnwLbM9uEt6CNB
	 /t4QE0bSeJbZk2TQVH6QwhiVf5pR65lisnNEwmhAeUffUxZjoW195+jRaYKoV88ctF
	 Ip65Fh6BHGuFg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?=E2=80=9CLuc=20Van=20Oostenryck=E2=80=9D?= <luc.vanoostenryck@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 20/27] iio: adc: ti-ads1119: Stop using iio_device_claim_direct_scoped()
Date: Sun,  5 Jan 2025 17:26:05 +0000
Message-ID: <20250105172613.1204781-21-jic23@kernel.org>
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
 drivers/iio/adc/ti-ads1119.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 0a68ecdea4e6..fe8086622988 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -336,19 +336,24 @@ static int ads1119_read_raw(struct iio_dev *indio_dev,
 {
 	struct ads1119_state *st = iio_priv(indio_dev);
 	unsigned int index = chan->address;
+	int ret;
 
 	if (index >= st->num_channels_cfg)
 		return -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return ads1119_single_conversion(st, chan, val, false);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ads1119_single_conversion(st, chan, val, false);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_OFFSET:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
-			return ads1119_single_conversion(st, chan, val, true);
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ads1119_single_conversion(st, chan, val, true);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_uV / 1000;
 		*val /= st->channels_cfg[index].gain;
-- 
2.47.1


