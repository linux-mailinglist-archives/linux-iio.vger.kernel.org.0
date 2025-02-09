Return-Path: <linux-iio+bounces-15212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F82A2DFD0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ED4188550E
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C11E0E13;
	Sun,  9 Feb 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d912ebs1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E796243368
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124544; cv=none; b=VorLvHKnYkho4Lv+RXDlruwoAEK36h16Pmo4sbSTpSe0pfbiciQ0yVoVfFfkAKe2sCX+cHmiBvE1pMuiSaxkwuJHolCXw/TuwGgGeDsFTC4RmT9jV/jhIA8ND7ar3OQX4vT3RaysUWn4CPOahNIBBP/YjW6xmgIb9ylh12jOA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124544; c=relaxed/simple;
	bh=Ilw3bhepF3JuY6FM1vMKHMhrhwxF5uDqtVL265Ma1vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCExtYcTEYa0avXniEW0aQOyVonBrTtPk3RImLjvDInDk6w+LyGX1Vo/xNc2VkA9qooGQEWO68NWODXeyfNTojITtV1+fG+2RFYww9oqqaaKf+HDaySBUZbdGu40nUr0HLMiUE86zpNSe+XNFrfA8bnTU3B432DLAo5jdftd810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d912ebs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9E3C4CEDD;
	Sun,  9 Feb 2025 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124544;
	bh=Ilw3bhepF3JuY6FM1vMKHMhrhwxF5uDqtVL265Ma1vI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d912ebs11BXcjOMbL2/waIi8x1RwepMDlx5lzPCYnM3gGA3IwmHG6jpfuztrY7V0a
	 ouSCeKhIEmeT4UbRWv9zq+a3DZB/660nng6QFPt2RVODQPll5MVm0CJYtMTgUaopuX
	 VIyn5ymUiSHYp1TFv8fnMs4m2iHCjfHEuTuLTP7YH7DzCEEk7i+BO8ADTzzqzVTYVw
	 DHMBi4mapmr/PyzdfpAy8eWDbXJEMZgFS2PqrKrCR7LFIk0ZgAPXNuEaiMyx2UYcir
	 GWKBR8BZSQf67o/nI2lCag3UUyzM3P2USx8ghTsahI/7wQkuLTjHCOMhTwo4/GA2CQ
	 hW/hNfWfUAHrA==
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
Subject: [PATCH v2 19/27] iio: adc: ti-ads1119: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:16 +0000
Message-ID: <20250209180624.701140-20-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209180624.701140-1-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
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

Cc: João Paulo Gonçalves <joao.goncalves@toradex.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


