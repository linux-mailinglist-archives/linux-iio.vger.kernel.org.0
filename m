Return-Path: <linux-iio+bounces-8145-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7135945F64
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4671F2380D
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2ED20011F;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3R87ali"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9C20010F
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=DKEjtybE3hMaa9sspADMBitX8bpZmnawpHUDs5T5pbDuAhcWFHqetlXWi+NOdXpN+qFkLVzGuYhAgaMnJCnf+tdoFnC9DHnIcOOK3VqZ11UhTOae+2EmJAUQSSWH4aLTmluXjhwceUmvTQQWxk88LTgzslaeBBwwBpiJv7i/GQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=LBGVtqXy2Dw2aOtRs7LqF/AJmS8OwjJgdy7HRFXLzAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NnF+x6UlFZ+WLYE4gJdJXCl/fAOtD6+pE/gZ+Sn6X2OZe6v9iTNAhbnsZkuOT42xeC92H0+MUVfWLebOtJHu+P1ctIOiIcdiRR4HTGo218rLjJ2HvrGUfJkmvMpF4qMouMjHV0JRXbft2m5aA+5ZNudIo+Y+w0byL4m5TXSYUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3R87ali; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC46DC4AF17;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=LBGVtqXy2Dw2aOtRs7LqF/AJmS8OwjJgdy7HRFXLzAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T3R87alij5qkFhAnd5qtt1E3d9C4akqgbg1DXxMOLQnr1IZGUUqaAEBs+Djm5eJ7R
	 3JCrY5+EbzkIB1YJlDKJufillkDJZQXhJxVlbWxf75dQKwkqtBcQ2i96ItCBpwMLS9
	 FH5KbPrH9lOPuxidHT4RODdwVvAK2XRbOkv+Mzr3X11/kDV8MoH9o0hLWm9EPnhKMf
	 bG5PPV/gHHbWN/yZ1j9OlR+2ta2RmFnHT+AB6lhz7NwbEo7L/j8bVPbJFewoMczodt
	 VEaq8kQbpgMY5Cx5OjxKDOcqylSwbaWyuas/854WuuNYabdVylDCFyIVmRka+5F+ff
	 62fdxjCVPL5jA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D583EC52D6F;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:27:05 +0200
Subject: [PATCH v2 7/8] iio: adc: ad9467: add backend test mode helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-7-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=3095;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ORQVhXl18L7QpqOhlMxALCTW9W1adG0MCwa3NMU5bf8=;
 b=YbIh3Vv04Cv/TGptnpgRaT6I0SbpPmi8JNas51Sr2Ge2o56ND/+ux20I9lJ6+EgCYzA4u+f0u
 MAF7GhXrK3FA7gJG8aW2wMAeHDCy7k7+wgEUmKn3S6rEznZQmKFe+r5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Group the backend configurations to be done in preparing and stopping
calibration in two new helpers analogous to ad9467_testmode_set(). This
is in preparation for adding support for debugFS test_mode where
we need similar configurations as in the calibration process.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 67 ++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 557d98ca2f25..2f4bbbd5611c 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -494,11 +494,49 @@ static int ad9467_testmode_set(struct ad9467_state *st, unsigned int chan,
 				AN877_ADC_TRANSFER_SYNC);
 }
 
-static int ad9647_calibrate_prepare(struct ad9467_state *st)
+static int ad9467_backend_testmode_on(struct ad9467_state *st,
+				      unsigned int chan,
+				      enum iio_backend_test_pattern pattern)
 {
 	struct iio_backend_data_fmt data = {
 		.enable = false,
 	};
+	int ret;
+
+	ret = iio_backend_data_format_set(st->back, chan, &data);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_test_pattern_set(st->back, chan, pattern);
+	if (ret)
+		return ret;
+
+	return iio_backend_chan_enable(st->back, chan);
+}
+
+static int ad9467_backend_testmode_off(struct ad9467_state *st,
+				       unsigned int chan)
+{
+	struct iio_backend_data_fmt data = {
+		.enable = true,
+		.sign_extend = true,
+	};
+	int ret;
+
+	ret = iio_backend_chan_disable(st->back, chan);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_test_pattern_set(st->back, chan,
+					   IIO_BACKEND_NO_TEST_PATTERN);
+	if (ret)
+		return ret;
+
+	return iio_backend_data_format_set(st->back, chan, &data);
+}
+
+static int ad9647_calibrate_prepare(struct ad9467_state *st)
+{
 	unsigned int c;
 	int ret;
 
@@ -511,16 +549,8 @@ static int ad9647_calibrate_prepare(struct ad9467_state *st)
 		if (ret)
 			return ret;
 
-		ret = iio_backend_data_format_set(st->back, c, &data);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_test_pattern_set(st->back, c,
-						   IIO_BACKEND_ADI_PRBS_9A);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_chan_enable(st->back, c);
+		ret = ad9467_backend_testmode_on(st, c,
+						 IIO_BACKEND_ADI_PRBS_9A);
 		if (ret)
 			return ret;
 	}
@@ -601,24 +631,11 @@ static int ad9467_calibrate_apply(struct ad9467_state *st, unsigned int val)
 
 static int ad9647_calibrate_stop(struct ad9467_state *st)
 {
-	struct iio_backend_data_fmt data = {
-		.sign_extend = true,
-		.enable = true,
-	};
 	unsigned int c, mode;
 	int ret;
 
 	for (c = 0; c < st->info->num_channels; c++) {
-		ret = iio_backend_chan_disable(st->back, c);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_test_pattern_set(st->back, c,
-						   IIO_BACKEND_NO_TEST_PATTERN);
-		if (ret)
-			return ret;
-
-		ret = iio_backend_data_format_set(st->back, c, &data);
+		ret = ad9467_backend_testmode_off(st, c);
 		if (ret)
 			return ret;
 

-- 
2.45.2



