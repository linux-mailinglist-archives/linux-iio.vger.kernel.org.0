Return-Path: <linux-iio+bounces-15013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387AEA27C65
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8CD3A3A94
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132442063DB;
	Tue,  4 Feb 2025 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1bTVmvU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC714B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699476; cv=none; b=qTIUzek/44UbC2Qu+ECe52M38KMhhKgQV1r8eY3GZumDi8NvtP8hUFkV976uuJz24cmYs5rXXV6v4SVYebY+85HHySvMXCIesL/BculjOgu28xovY4kdeNgIHCvs6JDFj1R5acAGDxHuCUpt6kq6snITP4YUast4FqxX4raJAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699476; c=relaxed/simple;
	bh=OhJ14cf56WuSmCqfPqK9cbdK/PH6cPuZELLteOo9BYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOBF3QrAAdLBSpD2QffVEztM9p+/6+i46j34muw9JXUinHxuMCBxRb1/AW/udv2pb/vi51cFDlf9hxSzVw0nx/CH1fldjDJEeiK78jKi7t8sStAe5L2waUW0hIwEH6sdSdpr33bGRSd7G4WRZRRzwEo85sm3fo6tVLakpwbyAGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1bTVmvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370EFC4CEE2;
	Tue,  4 Feb 2025 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699476;
	bh=OhJ14cf56WuSmCqfPqK9cbdK/PH6cPuZELLteOo9BYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1bTVmvUaNqsPFsqTK10CyA02TQ4zGMw7DU+YJzu87f4uou21gtdkPVCd/6xQz3VK
	 JhcI+kOTUDiBA5qGt6WvD5GnnI/h4CL8kNX87L/pvPywkoqewaTdufmEyZV3kpHYXH
	 1QsW3IzKxHUOJQi2k3/uEId+3jTgccfQi0DG1W18MP7FKz6haRKecMDuxDs6VuG0Xw
	 /pp1esoeeI7AlziWJDHP4f2/Ax0IajH7RSjTa0Yvkh2aq9FpvenlU9TtuqTQxutQK5
	 uc1lVQf3lqJ/W8M5XRGEisZABbZNnErS7Hj7CNVhlamsvZU9aoCPOoLJCuDJLWwMMF
	 XUMCccb7oOr+g==
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
Subject: [PATCH 19/27] iio: adc: ti-ads1119: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:41 +0000
Message-ID: <20250204200250.636721-20-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This complex cleanup.h use case of conditional guards has proved
to be more trouble that it is worth in terms of false positive compiler
warnings and hard to read code.

Move directly to the new claim/release_direct() that allow sparse
to check for unbalanced context.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 drivers/iio/adc/ti-ads1119.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index de019b3faa48..f120e7e21cff 100644
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
2.48.1


