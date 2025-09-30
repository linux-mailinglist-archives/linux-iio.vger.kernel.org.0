Return-Path: <linux-iio+bounces-24595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B85BADEAF
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744EE188B809
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C833081B7;
	Tue, 30 Sep 2025 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJN+IAhE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCF308F14
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=ZXSJy6vQUCTWwt0stUcPpvjHiwaX5HMmy9ltxi+PdyvMbSY7zzUFlovs582gtHX8X8eebLPShGWxyNP+7M9uCFZVuToHax2wL2fPfGRg0g46bIoV/3ZAQhCo74TSgjraNA5Rb1F4I6Mf2mC/ZvSAFKu416leSBoohkYTC3RDloY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=uhUWqYkYbXP2hYL7b0j8QLYx1gQglmxuFKrMbjuEXTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqQNe9/D+iKioMTIzt1juTGiJQnVSKfCLl2PyRjWEoqgac3PdYCcFjyvlO2RUWJ+fi2xZluMYMLq2vJa2GiNjS3CVi1RQ4zjVnIvvb3rXCgz/hZUuQGspOynRCPaWe8u1rPNJwFht8MtIlQazj484/C1qAQ+GD/vAuwzQalzeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJN+IAhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45830C116D0;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=uhUWqYkYbXP2hYL7b0j8QLYx1gQglmxuFKrMbjuEXTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SJN+IAhElSJmzC1cPDIW/CFb/lpIcQMYQdb9sh1KstjUmC4bEafUNkfvF+nwvJI8M
	 9nyROj7eRDu/3GSRyaSxuqOuHsXjoj/qoYyF1rTYV1mkj6/hRIX9Ozy4F5vycOhq3g
	 vKS0mRHhy/Ize3W7f+hjOTtLO3PMP+v6BR57m4R8sYoFRT9FVSGG9SjqCshU4A8QKc
	 qT9vB452rQn7uOK1WLZqrkyZuIM6P6z0axE7lMpOQ2Tp4bj3oQrIg6XxC7aJhhdfam
	 F305HJNQYfQL+NDJUttc3xIFb1Quj6cJLGDAryDYF8KFHfU22FrI9mYWdgXg5kJ1kc
	 F03OvQAllz7QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D223CCA471;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:13 +0100
Subject: [PATCH 4/9] iio: adc: meson_saradc: replace sprintf() with
 sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-4-5d65d096a952@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=1089;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CO1dW13uEq5iQy8PTF8+VarBtppTsSzenQ9AxsdRKFs=;
 b=4y4uDQITwsisSt6tGbaCrHAG7F6eERYGflEv1FzUMEcWRuohGhkZ81PLpLQFSU4g0KZTs3PrO
 eTmGjJUS8BwBZ5BVXFJg3udBxU2crACim+Fj4KHs1T3EnolD+l+15q5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the read_label() function to use sysfs_emit() for generating
labels.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/meson_saradc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index f7e7172ef4f6c2042f9ad54583d399f477ef7f5d..47cd350498a0d42536445ab324cc9249966b37d0 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1181,12 +1181,12 @@ static int read_label(struct iio_dev *indio_dev,
 		      char *label)
 {
 	if (chan->type == IIO_TEMP)
-		return sprintf(label, "temp-sensor\n");
+		return sysfs_emit(label, "temp-sensor\n");
 	if (chan->type == IIO_VOLTAGE && chan->channel >= NUM_MUX_0_VSS)
-		return sprintf(label, "%s\n",
+		return sysfs_emit(label, "%s\n",
 			       chan7_mux_names[chan->channel - NUM_MUX_0_VSS]);
 	if (chan->type == IIO_VOLTAGE)
-		return sprintf(label, "channel-%d\n", chan->channel);
+		return sysfs_emit(label, "channel-%d\n", chan->channel);
 	return 0;
 }
 

-- 
2.51.0



