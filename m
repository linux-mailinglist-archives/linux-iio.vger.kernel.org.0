Return-Path: <linux-iio+bounces-24593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5035BADEA6
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F388380A53
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1F3090D0;
	Tue, 30 Sep 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVqZnYyN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41D73081D7
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=B9JQ76BH7LrazVzvkbDjRUSxCKYVz6DTGsacIqU5rlgknKc3wKdQPULG58JLOBuHkV/ErS/1LGC/exaoTiZhfRpvTnkt0gYEyu0v+apwhmy3a/aCPOYSKOx/IZXejhxuLpB/OOaB07ZD+ZQriFxx6upDM4Uo8/J9xflsqnVjovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=zzdMgcBaKU6eRKI25tPcN2q9Kh5omaURGGTI8W17VNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzKpezWXaK5vVqogKK98Yp6VNiPPTnDPfM0dbyIVZc23THlQqiJ6FqTSplwa6sgjoISbDc1lIfNijA4/lUZnrXYIufx6aa9fZM7vvFs0c+Pu9Wl06UIu11KrZgGnL5za8628tWn8hIugMjA7pmE1dmVu7RXf1Dkqx2I6EPuVeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVqZnYyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84132C19421;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=zzdMgcBaKU6eRKI25tPcN2q9Kh5omaURGGTI8W17VNw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JVqZnYyNh0Gjg/zzOjVgfU1397jU5WW8lp6z04prnzNW6kk3t6IjbByIXbZJ0RBGN
	 8LoF39ELMfztoY4DBgz8KIvVdo9/MLZp9PMWb/b8Y9Jjyoe5kMFo7XCWXNC8H/uibe
	 F8qbG1OkyzdwtCcmRdb+5/4fGbKx69ffM3lu3of8/bmpnj73BGLTFAzV2eid0AQX2Q
	 ACt5+ZsEYu2uCbQFqksQ3ZCu4hISBtM/nyGSgZA8sA6r4fCcbGubFQYMopEEukV+C3
	 bZsKS54jpqAIQUCNsSyNah827bET6BvMWGr3j34MaOKvQkL+4XKFIB7gcgxYcm6iX5
	 jMVZmiJn2zZZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C4CCA471;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:17 +0100
Subject: [PATCH 8/9] iio: position: hid-sensor-custom-intel-hinge: replace
 sprintf() with sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-8-5d65d096a952@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=913;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=uBtD7rHGY3JgmTsmJdv+GuLLNqnv03EVwKBOigNns3k=;
 b=n3RoQwDKC0s7FIS6Kjp9M1VCu+DSp/1GKeuNZC7e3Gb1aZpx30Sl6UWBiJdjo3JWAWFBZQK1r
 QMhlaWYj35pDGfXEQ2hV/M7ic/pJoAJOewYfyueZ11cZvjjdJoYvi1u
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the hinge_read_label() function to use sysfs_emit() for generating
labels.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index bff7039690ac33bcc9747add8055023dd5a1f3ab..a26d391661fdb64cc34c8c0e163333c01c1f069b 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -176,7 +176,7 @@ static int hinge_read_label(struct iio_dev *indio_dev,
 {
 	struct hinge_state *st = iio_priv(indio_dev);
 
-	return sprintf(label, "%s\n", st->labels[chan->channel]);
+	return sysfs_emit(label, "%s\n", st->labels[chan->channel]);
 }
 
 static const struct iio_info hinge_info = {

-- 
2.51.0



