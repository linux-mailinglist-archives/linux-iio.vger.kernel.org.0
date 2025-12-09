Return-Path: <linux-iio+bounces-26965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F7CAF491
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 09:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73F86300FA24
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC39263F34;
	Tue,  9 Dec 2025 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kr2rj9dt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D323F26A;
	Tue,  9 Dec 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268798; cv=none; b=iis6zVzk03NfeF5vcCiYekn12d/b7aw69UCh7Kpw5D2uyWvp+QYZ7tubpOxoCYAqdy0pEst+iWrmFEmqkkvK6fC5AZ5sTakRl7iem/w4lpUAHO55xxrbc6vnVFgzmdcIRQNlG7Pa940+w+epBcqM87k6C/TKaUUoZo+oLD5Hcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268798; c=relaxed/simple;
	bh=nKdUQzzW0/YQhKAPxApxRtEO82JqKZPBc1syDJS039Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOV1+7xifilOTXrzGB/MghPRFXkGfE302bNlnftT2hc8+cdssmn2oVFOJeS01xrdtN+PcgbMNeqtqQZCv018K8tIbR0otDEXSDi6eO7pKSS9eQyopoi4svO6tbgVuINzIXotfHw3uBD5dik2gIn8N52PCpbK0NH+KjwjMI/S1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kr2rj9dt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 54473C180E2;
	Tue,  9 Dec 2025 08:26:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2259B60714;
	Tue,  9 Dec 2025 08:26:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DF9B11930218;
	Tue,  9 Dec 2025 09:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765268791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=m78Ml2oAhSe1A01ovJ9j5MEiBZnMD25VYhSFXxFMl0A=;
	b=Kr2rj9dt3DwTQ0zXnGEE+qsFaAgzY22oPRHZfzZBZ3E97W635VYnUkjJca17PQJdRtFE67
	VBgYxJ5xssTJmoBCoeP2s+zIq9bSkrcln5YBJoTtsIDGhQklcD5weke9rOtBYidAzj4SYF
	PPD5ANfHIabK+a4AWo6jZWCm0Q79+1reut4xjAlJ9njk4jiwUPj4u63TjnBhgM7mni0HDk
	qjAposkcjYmzbXslhn9p3TfrAlTu0DDNPxKWrv00AP3M/YiXWLwkz0XKLm3jyuuYP2T9Hu
	lZt+0ZRf5m96Nm4l9rODhUNkUILQmqRnnFBzrpf7wMWd99YRs2yqIqzHvkyDYQ==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 09 Dec 2025 09:25:55 +0100
Subject: [PATCH v2 1/2] iio: dac: ds4424: drop unused include IIO consumer
 header
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-iio-inkern-use-namespaced-exports-v2-1-9799a33c4b7f@bootlin.com>
References: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
In-Reply-To: <20251209-iio-inkern-use-namespaced-exports-v2-0-9799a33c4b7f@bootlin.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Guenter Roeck <linux@roeck-us.net>, 
 Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Hans de Goede <hansg@kernel.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Paul Cercueil <paul@crapouillou.net>, Iskren Chernev <me@iskren.info>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, 
 Saravanan Sekar <sravanhome@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

To prepare for the introduction of namespaced exports for the IIO consumer
API, remove this include directive which isn't actually used by the driver.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/dac/ds4424.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
index a8198ba4f98a..6dda8918975a 100644
--- a/drivers/iio/dac/ds4424.c
+++ b/drivers/iio/dac/ds4424.c
@@ -14,7 +14,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/iio/machine.h>
-#include <linux/iio/consumer.h>
 
 #define DS4422_MAX_DAC_CHANNELS		2
 #define DS4424_MAX_DAC_CHANNELS		4

-- 
2.51.2


