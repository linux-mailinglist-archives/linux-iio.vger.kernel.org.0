Return-Path: <linux-iio+bounces-24592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A3BADEA0
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21BF380A81
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E69308F3B;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdVcb5cj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02E3081D3
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=HTTTgoibXNojvQ7Ceej0uW3ZMyCXaJ3KyK+eBnM/iATYcuZiGk0NUfVBR5YW8zoktlGyrPSm1hmNOFEZjMatan83MHlGbPSQjW2cx4ewKoP85QKw0e/Ow545xvHoPUGpijS6/K/SwEZRQUqMWV+9Vuxu26H41bi2g8ufUSEJ4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=qzOw/1IASQcrCflRUc8lbaXk8UhrVUy5XxSCtSHax+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQxlXv/qWG4tw5aoc90fOWjA+enV81JH8H2MI+3MuTrfqMeJSyNFMYOYu3iziBdaliFehSsbwFzwr2ErGzUBCZ7vNIagWdLoy72YoYMHrs+Hs2wEy+8F+eJLSawUT+DKeszWaKt0ORha1DKcP5rcJGBGWtw4sBsl66bX0pZfAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdVcb5cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77C5FC19422;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=qzOw/1IASQcrCflRUc8lbaXk8UhrVUy5XxSCtSHax+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pdVcb5cjshNELmKwE06ZoC3LWzWcUxyVjltBM6WaTfntwX2Cx6hLpmqkUuKWNgxv8
	 f0b/2sQjntqT+5RByBtIzSgL0DuykeBwLgpXiUcpiNwiVTQ2YftMse6IoFmSM1+23N
	 8wymkcTFhj0w4bqPqqBdmOikFtF/quu2sIQNaCl5d8iZcvX2CZ4KWK71nu1E0mIXXc
	 oYA5TuOYq5yrqIrRWCT08nDqwLZs7JMUyOhnyDFplLbs7FudwwQOl3nKUKKPnZt3JX
	 rX7qnzF49/w5DvzBAoy8rRbDAaM7CaPNEor+GzdrMWT9j7MnX26U+cHlr0+2pVydRK
	 JgiwLAmwxswsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F765CAC5B8;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:16 +0100
Subject: [PATCH 7/9] iio: adc: qcom-spmi-rradc: replace snprintf() with
 sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-7-5d65d096a952@analog.com>
References: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
In-Reply-To: <20250930-dev-sprintf-cleanup-v1-0-5d65d096a952@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=827;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=LSfxhhZe4Y9G3fVBPuRYQ9cDdJyKCoAbntGmW6cv3Eg=;
 b=ySGgncpBHt8kfBf0mbo0J/Jyy+BqieBr3dd3ewpOTQeGTAa8dz78d9UCtCINd3G9FNKrVdmxj
 sN6rBKmNi8TCyZ9S4XQuixf5d4zz0gl3YDpQkJM9TSc+V2KJccSYcIW
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the rradc_read_label() function to use sysfs_emit() for generating
labels.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/qcom-spmi-rradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
index f61ad0510f04c7760d3735020b5de854b0e31702..b245416bae12121e16033f0185d8d0d2ef28f7ee 100644
--- a/drivers/iio/adc/qcom-spmi-rradc.c
+++ b/drivers/iio/adc/qcom-spmi-rradc.c
@@ -769,7 +769,7 @@ static int rradc_read_raw(struct iio_dev *indio_dev,
 static int rradc_read_label(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, char *label)
 {
-	return snprintf(label, PAGE_SIZE, "%s\n",
+	return sysfs_emit(label, "%s\n",
 			rradc_chans[chan->address].label);
 }
 

-- 
2.51.0



