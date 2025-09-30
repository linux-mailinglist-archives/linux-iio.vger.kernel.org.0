Return-Path: <linux-iio+bounces-24588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110BBBADE97
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 17:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA91886B33
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1023081A5;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JraphMlj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F4A3081AC
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246363; cv=none; b=YMg+E9QzV5jsCtEWlWddEZo21rSzafJUETrlkCn3zSb1WMSd2uKhSd+qzhdwcruxMqG15XZEumrc+Djp5Zbz1T5vrkJVm+dbKrvWhVw3x2NaVgx/qI9s1s8AJShy7a3/NJEAo/CPoizQGoVGJpGR/brRnM2m7f8m5JF0BlMHAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246363; c=relaxed/simple;
	bh=0CoOAC+/JjjNvCr3RZEIRkU3VZh7CAhWj37HtrYiDCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgTRHDbZ0L3U5O7p9Tv6/65n4ZHk8xqtwycBJCo/NuTPKk6Q9lHYb38AnTm3NSKS65r6Fm3pTX8Ou5xQJ6hgB3ftMH6+acKeSOjKweCqJa/feBYCv87uORrqqWRewWp1a5do34r/KQKkwDbA92a0JuCGO9vEaYnrhhWIapGFQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JraphMlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 275A3C113D0;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246363;
	bh=0CoOAC+/JjjNvCr3RZEIRkU3VZh7CAhWj37HtrYiDCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JraphMljxGE5hZ58TrjXkxWdV1r6r8IIfArmlRbYL0DkJ7n1l7FuTSjSM4ly8JI5U
	 tFV6PxtdPKVxo6Li5Fj4dy1O2xxOc0sxC4KxNy9WEKujoPtYUm/LjZbWkkhJ8ZToI6
	 Ax+qPu3b0jzgJa+U2aLDh6+7mt+xcdJ0ZKAobcWJSirlKvWhYsYjY8fTI9YC2fTIMQ
	 ue4Nm+dj8IQMMEmqp0gODlUIxDX3AkJmI6aPQzb1R601G5aY5BDRaNgvDXad4T8vgD
	 jf/gOpgAUyDlUJ5AS4e+9YCezFGqHcPRRBjOqhsFgk6oDuawhNCD8u3fLd3VJWbBNU
	 VesJq37ptM5kQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8EBCCA470;
	Tue, 30 Sep 2025 15:32:43 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 30 Sep 2025 16:33:11 +0100
Subject: [PATCH 2/9] iio: adc: ad7768-1: replace sprintf() with
 sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-dev-sprintf-cleanup-v1-2-5d65d096a952@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759246391; l=816;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=opjKFNFC21FJ8Tr+FRJKP5nMUNY1MqCJGUbkrC9mbo4=;
 b=I0vc10ghgU/I4y9IKY66Eo/578sswg1ydBiXpn2/7Q78Qn6zpJNh3d4+upWeTjCo+MFEQ7XN0
 qLGvyT+TKzZCtUsgArTLHhVrRARtj1essW4S/LsKmrHYPk3ScWu45dI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Update the ad7768_read_label() function to use sysfs_emit(() for
generating labels.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 872c88d0c86cab9f083e38dbc65463676c62001f..d96802b7847a6320c12fd121b0999256f3bd04a8 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -899,7 +899,7 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 
-	return sprintf(label, "%s\n", st->labels[chan->channel]);
+	return sysfs_emit(label, "%s\n", st->labels[chan->channel]);
 }
 
 static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,

-- 
2.51.0



