Return-Path: <linux-iio+bounces-8279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11399494BA
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1BC1F233E7
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D241123776;
	Tue,  6 Aug 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQgyUN4N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930814A2C
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958850; cv=none; b=ksI84ZBAtWrvgoVDFwc8dUeN8USMB1uFkpVZAXaqCfd/dAeglchfG+iqT4mz5P7QbdyMmNr1cT5ywg38SB38rl3lvYMu2cMgSYKoyjlTHVZF8cXnAV8WCFPoi3FMZICSALMBJNoseUo1vgLji7YlQNyIr2zE1vMXg6pl7hYcFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958850; c=relaxed/simple;
	bh=kW7R0LweFHazMHIhec7jLh8PMB5BaXVvLLfkSszg8KI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gD23W6XD4mujKzl7YFCwODvnMBaIWLzjMSjO33iMPyJabUujHZ2j4W1SHsdyrwfwSCY18a3jQLkACT9M7bPyXZ+9Pi2ZOYDYdehQXgdIMdk4H7s71OW/9EU3iBVlVdpwbenFWPFdaDPUkNzcPHnXffYMhVrJ8vRVhsKCo8LIEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQgyUN4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19FA7C4AF0C;
	Tue,  6 Aug 2024 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722958850;
	bh=kW7R0LweFHazMHIhec7jLh8PMB5BaXVvLLfkSszg8KI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=QQgyUN4N52hAoiXOCuJfJXGAMJLdRAXV+RQUvLDIWmF2lokhC1EATUTbNcTo/1eSq
	 dzDVUVn3Zv6XvtamHU/swRrpqAbHH7els1/dSRs/sec1kwO1B9hG/UVw5s/WIlBqy2
	 wvLxFBpZCE+Ra5GspBB39Q8zI9EsSf4nN2Jfk1Uqffx4h36jaP1QF4++ISXelI8xBx
	 CkOwtAalKKZcvqH6kdOmUr2UyL9oijQbtuK9MyBrxdPGcVvewkB6LKk6zOdNs8Ufl/
	 FPwhIIQF3GZ0tj3BUPAY/YQ4TKCf7xBpV7dq+usGWENCvuPMlY8iNnmOTHvXJXJ8oo
	 4T1uvqEtJDPMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DEEC52D71;
	Tue,  6 Aug 2024 15:40:50 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Aug 2024 17:40:49 +0200
Subject: [PATCH] iio: adc: ad_sigma_delta: fix irq_flags on irq request
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-dev-fix-ad-sigma-delta-v1-1-aa25b173c063@analog.com>
X-B4-Tracking: v=1; b=H4sIAABEsmYC/x2MSwqAMAwFryJZG2irFPEq4iKYqAF/tCKCeHeDy
 3nMmweyJJUMbfFAkkuz7puBLwsYZtomQWVjCC7UrnERWS4c9UZizDqtZMNyElbsna8jh0AR7Hw
 kMesPd/37fp9KzF1oAAAA
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722958849; l=1377;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+YEFvjCJxa2eedif6Vm6NGhVp6V9JbA4Q0ngV/mhSWg=;
 b=loeKN2ll6nkGoGDQAxiCypLdyXh92uhegPcl1Xlz7C15OIkmgDXGz/5Vf2SpgG3/E/ks3gGNY
 A2wNz8lhKy0AYqWbS8AwnTooV97Bge4iwXySJsFdOlcJ9aJevRpYdx1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

With commit 7b0c9f8fa3d2 ("iio: adc: ad_sigma_delta: Add optional irq
selection"), we can get the irq line from struct ad_sigma_delta_info
instead of the spi device. However, in devm_ad_sd_probe_trigger(), when
getting the irq_flags with irq_get_trigger_type() we are still using
the spi device irq instead of the one used for devm_request_irq().

Fixes: 7b0c9f8fa3d2 ("iio: adc: ad_sigma_delta: Add optional irq selection")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 389930186bb6..e2bed2d648f2 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -569,7 +569,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	unsigned long irq_flags = irq_get_trigger_type(sigma_delta->spi->irq);
+	unsigned long irq_flags = irq_get_trigger_type(sigma_delta->irq_line);
 	int ret;
 
 	if (dev != &sigma_delta->spi->dev) {

---
base-commit: 593737c18ae789dc6e4b493510a0c00977972e2e
change-id: 20240806-dev-fix-ad-sigma-delta-3d10146d22a6
--

Thanks!
- Nuno Sá



