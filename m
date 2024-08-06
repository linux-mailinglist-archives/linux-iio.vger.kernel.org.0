Return-Path: <linux-iio+bounces-8274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC09491A2
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE2A1F222C1
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB441D2F6D;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0YGygFS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B01D2780
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951307; cv=none; b=a2j4hZOHgpWJOZKHbtxjGPmfwiI4HE3YXRcQG01X++KODQ80ZzcU79NV2nCE7FWNwR6+12yUSq3aX9SHrMO1vuawEXMInRQlDK7qcH6mM/eHctG3f1fmaahc1SGxxe3aqP8aWFcBUJt4eq0dplQpIxw/d+7g9SOcN/WQtHy4/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951307; c=relaxed/simple;
	bh=t4ah0loUiZWAAYLrMq+MTbcEChyKjxhG/C/+7uCku7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfjjjHGoub1JMDN8wMTnjXbJ7sXC0NYcJi7LXjmx4KSGJsg7MIiOjFxW37p8wa03SApjRGU8hk64E8gbK+DXIU1xDWH5oLgT1sR0f3+4cmW8EzWiZzz8iq2KG5NgDFo2U2/Xq8qZS+JpVrOYIM5VNZl9ctVuoyho/rq5/bfGNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0YGygFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67576C4AF11;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951307;
	bh=t4ah0loUiZWAAYLrMq+MTbcEChyKjxhG/C/+7uCku7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R0YGygFSrzcGQSDbo0+IiY/1zjovu6WCGVT/61/MWUsgODeMgiNrh3AksDBNKK3j1
	 92a5oFLNZXg99u3PnpRbH6s1+nV6n7UbMWTsWyyCPKTgiHU8+50FdR7Du9K3hhyyZk
	 YUEjq7rBhWIf5M14pOyLxNeL/AdTqjv6xXKmREs5ZWLeYqoXvVLLwydnxLVbLQX4TT
	 DO2HifhfqraEr/bNBVPMQ6T/aj1v9hZYuepDD13FWek00ILPBnAswMmBxHcjwWR92m
	 eQYKOdx9Pd319emKq3HU8TMRGfJgefEXjrpesqf2mEjqelLmEywrMhKfbi3tPDAtc2
	 qej/cNhr3j0/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB7C49EA1;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Aug 2024 15:35:07 +0200
Subject: [PATCH 2/2] iio: dac: ad9739a: add backend debugfs interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dev-backend-dac-direct-reg-access-v1-2-b84a6e8ee8a0@analog.com>
References: <20240806-dev-backend-dac-direct-reg-access-v1-0-b84a6e8ee8a0@analog.com>
In-Reply-To: <20240806-dev-backend-dac-direct-reg-access-v1-0-b84a6e8ee8a0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722951306; l=880;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2tJLx9S3feK5aLP/bucGasBHK5sb0LjFdbnPk10uUfM=;
 b=1Xt2FwsLAKMhNBmQTfuH8OBmjzDVq/oNfTzyD24A55S4nHKWDODYFKG7A/MgG4gka7vBU+FRs
 aQ4BJbvw+LiC9clKHAlhieSFb3Ng4iZt2z6TXuiSF5+2F+a2obwGnJA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Call iio_backend_debugfs_add() to add (if available) the backend debug
interface.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/ad9739a.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
index 799387f21b9f..615d1a196db3 100644
--- a/drivers/iio/dac/ad9739a.c
+++ b/drivers/iio/dac/ad9739a.c
@@ -431,7 +431,13 @@ static int ad9739a_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad9739a_channels);
 	indio_dev->setup_ops = &ad9739a_buffer_setup_ops;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	iio_backend_debugfs_add(st->back, indio_dev);
+
+	return 0;
 }
 
 static const struct of_device_id ad9739a_of_match[] = {

-- 
2.45.2



