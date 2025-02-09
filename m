Return-Path: <linux-iio+bounces-15215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24775A2DFD6
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 19:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88913A5954
	for <lists+linux-iio@lfdr.de>; Sun,  9 Feb 2025 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C701E1C1F;
	Sun,  9 Feb 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aizonGWl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D6F1E1A16
	for <linux-iio@vger.kernel.org>; Sun,  9 Feb 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739124566; cv=none; b=EfwXG1JPDsH8WPbWimMMvCikXygy4cepzLnLauC6AqF96PaYRBEzrBWwnghC3l1NsUg39JHdWCpdpJb8CNiTXCtFpMbNGqnwU2VFaANFT10uekezKBxAnkVBGhjtKGvT+txJCg7wW1B7OImwwvBpP26Oh5lJ8ner9k7QQBzG2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739124566; c=relaxed/simple;
	bh=/rH9YMnwk3UQjIgoczlcYCk5sn5AQkhffS+8xH7qVRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtR2cxV2oQ/Y9a8imqH82gOPtfvPSCx06UZY8jRXKZn82VRt+jjwoUfCYX7GmEGvjF0pqNrn0JF7KgTpzuWUIlvbgmBQCqetWAdvEGdf34+npbL0xoQuXlwgxdd0LF1XTzDjs39kACI6rXPTS/1VxKYrEWOWqSIs+WSiZljcsdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aizonGWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33745C4CEDD;
	Sun,  9 Feb 2025 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739124565;
	bh=/rH9YMnwk3UQjIgoczlcYCk5sn5AQkhffS+8xH7qVRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aizonGWllaxgNqfMNfWCMeriXZ7A7dCfNkeTZhTmUb/C6MKdsoqJ6i3b8atc0n5QS
	 79dcdPZV4s3QphblvCGR4USd4hRsWyDb6IHwEE8c4arJoICqPJmaGMcTONTXGb9TTO
	 argmUl1vTROaFug7AwpCpkdBeoCuzuz/0BWX8LEcRseTclgfrjUPda02DlSP1hyl7l
	 HvZHblXKT0fVcKT7nY/Mh50Q3REVH+dmsbYaAqfEpUAj24mXuZHJothujT7eEo73OX
	 eJjN3NEnbiEgYz95LguWk2QnOT1v06ulNyT8q5CZJjYk1ANpDUc4vkox/yeIM/pcKm
	 JrDr9E9p7OCbA==
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
Subject: [PATCH v2 22/27] iio: dac: ad3552r-hs: Stop using iio_device_claim_direct_scoped()
Date: Sun,  9 Feb 2025 18:06:19 +0000
Message-ID: <20250209180624.701140-23-jic23@kernel.org>
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

Cc: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad3552r-hs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index c1dae58c1975..cd8dabb60c55 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -129,16 +129,19 @@ static int ad3552r_hs_write_raw(struct iio_dev *indio_dev,
 				int val, int val2, long mask)
 {
 	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 		/* For RAW accesses, stay always in simple-spi. */
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return st->data->bus_reg_write(st->back,
-				    AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
-				    val, 2);
-		}
-		unreachable();
+		ret = st->data->bus_reg_write(st->back,
+			AD3552R_REG_ADDR_CH_DAC_16B(chan->channel),
+			val, 2);
+
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.48.1


