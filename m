Return-Path: <linux-iio+bounces-3952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33AF892CB4
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EBDB2224A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F23FBAD;
	Sat, 30 Mar 2024 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaUsqU2A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E793FB81
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825749; cv=none; b=jzx9gQWZAMkVINhVMrI+WVgMofOyPiZckM3tA07e+zEeeGcNQKwIW/7fYVWZcvCdIY2hzzwuWSp1ADWJyBIz36p6rDnFD5tLcrFYhJZdzsEqqIvnep0GwxRW/cDjhPkXjHl0IV76prNsl7uItYGlACdMLYTFQiT1J5kd5RKeAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825749; c=relaxed/simple;
	bh=yaEwnOjwR+uZ4KT7IzIwdUTu/ymz+4wDK9JhXLazASs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtahXqVnVJSC5v3XFOuBk3aXrMQ4qAdSW/qG15C/n4L/FtEiHghRORp7vnMOgJrAIx87fIl4huYW3bCyeFHprAbeNBJVzp6THO2GmwpFjuE739BOvbs677bH/Z2kW8MDY1iyhoWpnA1Ys7W1XgzTnXbjx6hxd4WwGfmxg97ZBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaUsqU2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F02C433C7;
	Sat, 30 Mar 2024 19:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825749;
	bh=yaEwnOjwR+uZ4KT7IzIwdUTu/ymz+4wDK9JhXLazASs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaUsqU2AYADF2jecmMkiScOo18qZB5Jol3DszsQLFs+IERAPI4Hw+kNxVRqG903/W
	 YtA3vJXa8Jc4J82ebZ+18CJ1kZR8WGzMt8XGyu8UNhQcUA8Kjy3kPCqPJx5G09Rda+
	 ijYb0SV+XYZVYBsIWwVWp4KBtBGnMvulck48JLHRr6mThOU1+LjGRil5e55d6QpmWK
	 ZOkW9gFNrggv8vSiTlkjE1eLN2+aBFIiEG6QB8fMuoIdloa6c61ERt+Oto+Mep4joy
	 NmrOl7ANQUo00HqSWQdZ/iqrqYzSEuEiji6KFaJ4qkoUHG49/y5lnvBeKxzUz3PuB8
	 RtS069SnLPldw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/8] iio: adc: ab8500-gpadc: Fix kernel-doc parameter names.
Date: Sat, 30 Mar 2024 19:08:43 +0000
Message-ID: <20240330190849.1321065-3-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Seems these got renamed at somepoint but the documentation wasn't
updated to match.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ab8500-gpadc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
index 80645fee79a4..0bc1550c7f11 100644
--- a/drivers/iio/adc/ab8500-gpadc.c
+++ b/drivers/iio/adc/ab8500-gpadc.c
@@ -1021,8 +1021,8 @@ static int ab8500_gpadc_parse_channel(struct device *dev,
 /**
  * ab8500_gpadc_parse_channels() - Parse the GPADC channels from DT
  * @gpadc: the GPADC to configure the channels for
- * @chans: the IIO channels we parsed
- * @nchans: the number of IIO channels we parsed
+ * @chans_parsed: the IIO channels we parsed
+ * @nchans_parsed: the number of IIO channels we parsed
  */
 static int ab8500_gpadc_parse_channels(struct ab8500_gpadc *gpadc,
 				       struct iio_chan_spec **chans_parsed,
-- 
2.44.0


