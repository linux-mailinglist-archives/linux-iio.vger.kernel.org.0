Return-Path: <linux-iio+bounces-15012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B649A27C66
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C8F7A1EC4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8C2063E0;
	Tue,  4 Feb 2025 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9XcCsqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2014B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699472; cv=none; b=ASgpsO7QAuRh8PnfbvphNrezQvgCiYKHMapYhzqTS9m/0Y7T2f3czyVN0daGmdk1vFYGK5XMH4ziKxm84vcDpRxyW/2/gdjPBOH9WSQdi1W6xAF//3kaLihSjnbh5nVWIbGA1IXuInfzWAnfxaJTYQedn/3zW3EjtnlrxS54+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699472; c=relaxed/simple;
	bh=W1+YFF4zGS62LITFamYUxaCTZ5xJP5oBTswhyMteZAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RhNAEAzAClCtBUxZYoWQ3gWxqxmeioX5/96n14eUCjCbhck4AGkRSOoT8XyftD7GTQgzKWtVvDbCiFSyrvw7cbKyNqKD4oJggeCir/DHfEAE0sUG/unsmzAc1w+KGLh1PRZpqVbVb2f5ntfqsvaeRlNqBI0+XexG+9S6JM1O28o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9XcCsqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC29C4CEDF;
	Tue,  4 Feb 2025 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699471;
	bh=W1+YFF4zGS62LITFamYUxaCTZ5xJP5oBTswhyMteZAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9XcCsqFihWNwRynVzgt0Ug4frxvypt07YL8c4KGLgJEbdtUhSPhIu9EJDi/ww2tK
	 YFrUwU/SDKxwlWzLhpYz9LNwmdc/e4JEHsdDSFq+vbd2tFm6OT7TiPGhaGahMK01F9
	 73KETFz4qI0hq1qeNN1JQKV60QcmECQf5qYn8oS0+1d7P7z1WCpRAETdrCKeBjQFl7
	 1TCxQ7AfHrSBqRyrU9Z0ukIaPP1XIZSu5Jpi+eqGQEAZevWIW/9oTkJ0tJVhMoVhP7
	 nS8xarDtT9cNiaESBId6cRR96b5Tz4L/ioRxie0PbxJHf3W0O7+91tVl08fASDxu4L
	 GN7Xb6IdlegOw==
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
Subject: [PATCH 18/27] iio: adc: ti-adc161s626: Stop using iio_device_claim_direct_scoped()
Date: Tue,  4 Feb 2025 20:02:40 +0000
Message-ID: <20250204200250.636721-19-jic23@kernel.org>
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
to check for unbalanced context

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc161s626.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 474e733fb8e0..28aa6b80160c 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -137,13 +137,13 @@ static int ti_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			ret = ti_adc_read_measurement(data, chan, val);
-			if (ret)
-				return ret;
-			return IIO_VAL_INT;
-		}
-		unreachable();
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ti_adc_read_measurement(data, chan, val);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		ret = regulator_get_voltage(data->ref);
 		if (ret < 0)
-- 
2.48.1


