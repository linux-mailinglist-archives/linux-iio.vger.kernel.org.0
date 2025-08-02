Return-Path: <linux-iio+bounces-22213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DAB18F7A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FED7AB77D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0024DCFD;
	Sat,  2 Aug 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLXAdoi6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800792264D6
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153191; cv=none; b=Cqj3/xGMzBSMKJYN6gpc/9ZsY2w8H13VKGUv2mFsDYKzmDbqcNJd7V7mBBHyQuxO9MaL6BtxPJWw9gHILkD0fbIq0LJlQ9KG0pDtTRuN8noG0GQWi4W6O5nyZbC563UY9n3sOrZFmUR5RX4AYjLljdSKT73qV9VlrKUB8A76CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153191; c=relaxed/simple;
	bh=K/8wQLPbmsPEdbYFHDkzlczOdDonX12ri1FS0wycwAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEI0gcCOBsVUBM5W4AYXBJz2tKrr20gJjBDSRsp2Wd7NisjlPu1OWKbU/3cPkIQ1QzeD0jzOpeBO4BU7JpQDiNJGkFTKUDVDvZCc/peCZ5Ham5a3dyAhQfjvgVxMrWBccTYPZZWccVqtLb3gw5tuKirOjndrglybCiO7P+eOf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLXAdoi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70994C4CEEF;
	Sat,  2 Aug 2025 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153191;
	bh=K/8wQLPbmsPEdbYFHDkzlczOdDonX12ri1FS0wycwAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLXAdoi6F8ZMzURKo1ZkXRg3x2WqbEWfG7Ypa6Fx7VvLakyKxJI3izcY9rpTqwHJa
	 yxhQpnUs4WaqOAXGENhzbp0jYrXhleje0nF8R4hzJHCkx+4ExMLQ12plxb7XvKHc0s
	 D3H8LxajbmXSlUw2/NfoJTLLEvpnuSsJyfzVldxvaPbna3jJH11/xtx3KrwcawfDzy
	 dh/FdH9Yq5GCynouZaD6p6AXlgAOeRHsVOnP8l908YWLbXI0+d+pYAUndq/bFdD1Qu
	 YW22Z8RuNeiQhaoWdm52GhQ+9UFJWWp3KN6j3opMz+ygr8mZdaLMnLM5l6Q6IZvHIl
	 XNi+HLL7j/6Ow==
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
Subject: [PATCH 15/16] iio: light: vl6180: Use iio_push_to_buffers_with_ts() to allow source size runtime check
Date: Sat,  2 Aug 2025 17:44:35 +0100
Message-ID: <20250802164436.515988-16-jic23@kernel.org>
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

Also move the structure used as the source to the stack as it is only 16
bytes and not the target of an DMA or similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 38706424089c..c1314b144367 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -96,11 +96,6 @@ struct vl6180_data {
 	unsigned int als_it_ms;
 	unsigned int als_meas_rate;
 	unsigned int range_meas_rate;
-
-	struct {
-		u16 chan[2];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 enum { VL6180_ALS, VL6180_RANGE, VL6180_PROX };
@@ -545,6 +540,11 @@ static irqreturn_t vl6180_trigger_handler(int irq, void *priv)
 	struct vl6180_data *data = iio_priv(indio_dev);
 	s64 time_ns = iio_get_time_ns(indio_dev);
 	int ret, bit, i = 0;
+	struct {
+		u16 chan[2];
+		aligned_s64 timestamp;
+	} scan = { };
+
 
 	iio_for_each_active_channel(indio_dev, bit) {
 		if (vl6180_chan_regs_table[bit].word)
@@ -560,10 +560,10 @@ static irqreturn_t vl6180_trigger_handler(int irq, void *priv)
 			return IRQ_HANDLED;
 		}
 
-		data->scan.chan[i++] = ret;
+		scan.chan[i++] = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), time_ns);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	/* Clear the interrupt flag after data read */
-- 
2.50.1


