Return-Path: <linux-iio+bounces-24591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE6BADEA7
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503707ACD7A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3193308F32;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTqg8AQX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8D3081C2
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=Y/kYAP9KLWS0EjtHMBkMnltUuQOKeEtEGgjBHZrRVNd3L/WC145A4SxcgZWXEiOymidzBIWd4zVEVcx27V3seokTu9XBYh52+C10Xwx2XqfUr39tWyli7xuWSBhryV1gA85arax2RQpk24pHKQJVUARLiLVbag6iMBY925NvaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=0taRmwjryYQarmdKG9R8MrepDyz2CA7phI7kKJgjPHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGAZuU3rMdnpGE2O/KCejPEJfDvrPLK8ALMq1SlXoEHctZeQZx/95SHZHfb9HYW6PDCchuRnZ5ONx6FU+R7s6d+YOCUy2kOtGTrJmtETp2VnSQnwZxF3tjfd69r5Y/bAjvMQf3PEei0e0pyv/yc4THvBFg/d9KWJVhT/NGQfQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTqg8AQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 653F3C4CEF0;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=0taRmwjryYQarmdKG9R8MrepDyz2CA7phI7kKJgjPHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tTqg8AQXSr1fex8CgYkVDtkE/QTZWP5by4ju1AAAp+YbNep5GEaihOeynH7HMhBgD
	 LK8UNtMaOMKQjyhWJ0XcJMxEt0RZVJn7RrHAGMU4/JFyOARgVSdYdNsiPOAPFr/gM6
	 5AMAQYmRV55zjXQKKrHd+ut17tNKCe5IKuYNElc3AGfS7OzaGPdeUJVAJTEEFJhD3q
	 6EzYcvSWLy+Ottk/ydZEd2sn0A62b+waIgG1CN2qF2jJiRP5BaeCsAp7tAZIxup0qu
	 ajPbDH2eJuBXA5PpjB7X9iWlk9Q0VkeRIlw12W70xmPjuZB3leAA55CWLbSoTzC04T
	 ix9KeQIqZnunw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE57CCA475;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:15 +0100
Subject: [PATCH 6/9] iio: adc: pac1921: replace sprintf() with sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-6-5d65d096a952@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=1061;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=466V0/0B47csEqruRL0ob9WL3H9t/OmaPrXaNfsTut4=;
 b=aC8PK+hT8/opOKbqTScLPZGn7FfUBiDJH5hEDNdfTS0WHI3CsiB0NI8Gfe++DZySSebxuKkkf
 hal60izx0NtBw+F1QY3qptKS1pc2sm97DaoNVAix7GtMp8PR4jizhE0
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the pac1921_read_label() function to use sysfs_emit() for
generating labels.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/pac1921.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 35433250b00872edfc9214c632917a8b8ae6e281..a0227b57f23883034f84ac2ada3d4f9319e5047d 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -672,13 +672,13 @@ static int pac1921_read_label(struct iio_dev *indio_dev,
 {
 	switch (chan->channel) {
 	case PAC1921_CHAN_VBUS:
-		return sprintf(label, "vbus\n");
+		return sysfs_emit(label, "vbus\n");
 	case PAC1921_CHAN_VSENSE:
-		return sprintf(label, "vsense\n");
+		return sysfs_emit(label, "vsense\n");
 	case PAC1921_CHAN_CURRENT:
-		return sprintf(label, "current\n");
+		return sysfs_emit(label, "current\n");
 	case PAC1921_CHAN_POWER:
-		return sprintf(label, "power\n");
+		return sysfs_emit(label, "power\n");
 	default:
 		return -EINVAL;
 	}

-- 
2.51.0



