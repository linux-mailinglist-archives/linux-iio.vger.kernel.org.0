Return-Path: <linux-iio+bounces-24587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F7BADE9A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EBC7AB41C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2283081AD;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJlpNoEQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAC3081AA
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=Gd+XqKsWcXq1t7bycSex1A5F0i2So2npbLKlm9gsyG6+Yg+nmE1iUeDJIfWQ6/GirLnS47xFzT2MFW2WCzFxp2SUiR1w993c7KP2CCtgTyzVBPrM7oxdCWWA58mQR7dw6n+I2A2uxx9amA+gM8YtMwaMnvvUoAU+1Qi89FsW+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=oOSWbFtHicR9CGGrzO8eCy1PHRwl+zJODxbJ+XW0YQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFjoI0+Hp0541ZTMlZPs9Nx/Z8kgJfTz62EqApBXjKXIoAaN6p6/e1Z9aeXPx1X1eqwGJhUDiMFykQzVLAr28PvnbwJCG3NMjIs9XREMjmVcAWpuASI5y6FJeub18aTQQ9T+BoBOeY1+C504lLrSOKq6PfP6Yj62boDjSChw6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJlpNoEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36599C16AAE;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=oOSWbFtHicR9CGGrzO8eCy1PHRwl+zJODxbJ+XW0YQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fJlpNoEQagX0HfnvqRxdMtXl50w7A8rxT7WArsBTuMmNXegBOsYZPqmv4rprR/1Br
	 9pizcIG9LDAOX+8YVK2J25mJIR/fse00+qaaJ3c/qNmeN9EMOWg7sWgbcrM7xmn7XH
	 mCodX32XOhvXKfhEtM9tqol+FHhxuSFK5w24QH3CRwkBr0HUP/Mh2TdiWtcKa8paOI
	 7FVjeNn/kscXPrKmwifnHydHpNpX6UodJZ1a/ib5c+zKlYSQt/zxzhS9Rbl189Kccr
	 4hY1vMRCW0Mu7Yme3lZLnloV6kkUhFkwUTx0QGLGaUNvVbLWCRioZqrazIKfUhPNuw
	 fk44Q3E4b869w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA66CAC5BE;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:12 +0100
Subject: [PATCH 3/9] iio: adc: mcp3564: replace sprintf() with sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-3-5d65d096a952@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=813;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Rp9zqAHR7um92cdrmdYf87T1TPcS5eCjH+Y/yw2ogfs=;
 b=TSEbpHN0Ta7K7iH/bVI6lgGBHEHfP7HzGhBHW8wDELffXwzKA7ksrSA22uIRbkL1qThkdU8qF
 XdYqd1+kxJwDCALJ5U4Q4IOyTqykx9mQ4TJ4SpJToB5/b7AGfpDZsLf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the mcp3564_read_label() function to use sysfs_emit() for
generating labels.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/mcp3564.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index cd679ff10a97c4be19ca461126bdfae2fa8431f2..fcdf13f49c48f31ba3a0a9079686d2b81a792744 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -987,7 +987,7 @@ static int mcp3564_read_label(struct iio_dev *indio_dev,
 {
 	struct mcp3564_state *adc = iio_priv(indio_dev);
 
-	return sprintf(label, "%s\n", adc->labels[chan->scan_index]);
+	return sysfs_emit(label, "%s\n", adc->labels[chan->scan_index]);
 }
 
 static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)

-- 
2.51.0



