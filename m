Return-Path: <linux-iio+bounces-22200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E97CB18F6D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D51B17EEFB
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35262512C8;
	Sat,  2 Aug 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBcRbgzr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168724887C
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153111; cv=none; b=NrJygkFF1bx0Ty02+R1b+GxZ30iUS+NN5/auRlLyBVyBvsE5Vs+cfaS62B8nghLuhz693PkW4uJKXn2KZ0hKsYfCj9x17M2plZ6AOJxQtOd28kepIlNGDJ7WRDdL2FYAfPERyUZEGiGrm0Uamj4DEhGpnyuKAy4AFJulnYMHOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153111; c=relaxed/simple;
	bh=oNr7ya0c5WZ2KM26MNAvdiQbwrBS+KyKLmufQJ1t+5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp2hQCCgrr0MCYqoZx2wR2D2Hsre5FlLtcEwJckvuaauJVVtImM0xyZFEkFz/iiW1GivdISAiwBPTja1WbpXsosh1GxBIElPg6FX0q0hFgYtjOJQfPDdi3cV1KkgqnrK3D79rt0yg+0md9IzB3k1cEi8mOYQ7f+ckCY2NlynuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBcRbgzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D45C4CEEF;
	Sat,  2 Aug 2025 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153111;
	bh=oNr7ya0c5WZ2KM26MNAvdiQbwrBS+KyKLmufQJ1t+5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBcRbgzrq/HAQObGtLHzuNZKOidtw7vcyxMtzUHfC1WKwm30L/nxnBUVtqOKtUaoD
	 GZuTR3JHwbKzohTEjn/UxMvnnc/o9zDQvNP4anRdEX45om/0kRFtH2YSVZP2iSClo8
	 1iq6cJgdowcKahmXiwtXb/20Mx7hww6fzdxoW/qdBxYLbmvIinsehMJ/q5jWXQnNzA
	 OHiO7nqedG7CW4nPkc+JrQ13ckUMuNkHuGTaDmqA55HdWhEtydBcrC10C3wT162vgZ
	 KPK2NJkRUlxquVPUNrqhRhOOmKopwCX1pUP6o9EnIKkzDSkbn58Hh7EZXM9/PHd73W
	 pKP4cpCJXzheA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/16] iio: light: vcnl4035: Fix endianness vs data placement in buffer issue.
Date: Sat,  2 Aug 2025 17:44:22 +0100
Message-ID: <20250802164436.515988-3-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The assumption is that the channel ends up in the first 16 bits
of the buffer.  On a big endian system, the regmap_read() will
read a 16 bit value into the 4 byte location, leaving the value in bytes
2 and 3.  Fix this by using a a local variable and copying into the
current location.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/vcnl4035.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index 01bc99564f98..79ec41b60530 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -104,14 +104,16 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct vcnl4035_data *data = iio_priv(indio_dev);
 	/* Ensure naturally aligned timestamp */
 	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
+	int val;
 	int ret;
 
-	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
+	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &val);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"Trigger consumer can't read from sensor.\n");
 		goto fail_read;
 	}
+	*((u16 *)buffer) = val;
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
 					iio_get_time_ns(indio_dev));
 
-- 
2.50.1


