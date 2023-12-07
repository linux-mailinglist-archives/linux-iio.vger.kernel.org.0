Return-Path: <linux-iio+bounces-714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7208C808805
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33271C2159F
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5286939AEC;
	Thu,  7 Dec 2023 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYpg5K0o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288E3D0AD
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70EBAC4339A;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952769;
	bh=ekRpSov0OH+RQs3kWb/G2dyDyU25+q6hoMNwsGihdRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WYpg5K0ogyxasM/jT7jA811TpfShobAkqCwDh+EL+OA2jVSzNfs2x2o9rXM7ehoW2
	 TfLfayM+Wo/aJN47Eb90lQHdsO0pzWA3fcmimqVm6Idrv30O67SYgzfwWWGwouUNdd
	 j6VLkScecJ24MaXQL9JSYdxpXpVeLPKgCsiPpbS6GAbQ6bQXnNwl7bRUZcqDto7HFT
	 x5lFpuSPHMXIeEU6gMOZ59kp7urKbTlT09Ajp5PVXFDrc7HRlktxWwZKmXMC3Yh2Wc
	 JUuRrhTh4Fm4SE7dYi37qsOb6mlgk5bYfR8K8GlWnfSrAeVLXaM4gHJ8s7KrsW4V5j
	 FrsiERRjmGPgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C72C10F04;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 07 Dec 2023 13:39:30 +0100
Subject: [PATCH v2 7/8] iio: adc: ad9467: use the more common !val NULL
 check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-iio-backend-prep-v2-7-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701952767; l=759;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zVjj1DQ8OD7RUy7uaCTyUmHiIyQXQxKb7ynVzBw9F74=;
 b=1R/KgZoTQeiPfmE3j5sFUEbpQwDnOqEdQ7NB91FhP9VtIA8S0BSK0TekLA3OhVc1mOAMebW5k
 CNY4R/Ze37YARLaTEqCvdchX04E+7K4Aq8abLnqaSPV2yxqqf7iMRTv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Check !val instead of directing checking for NULL (val == NULL).
No functional changes intended.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index c5ed62cc8646..6581fce4ba95 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -158,7 +158,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	struct spi_device *spi = st->spi;
 	int ret;
 
-	if (readval == NULL) {
+	if (!readval) {
 		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(spi, reg, writeval);
 		if (ret)

-- 
2.43.0


