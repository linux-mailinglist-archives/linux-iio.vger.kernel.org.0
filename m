Return-Path: <linux-iio+bounces-20962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B18AE8B2A
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 19:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD5175D24
	for <lists+linux-iio@lfdr.de>; Wed, 25 Jun 2025 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA612D29D5;
	Wed, 25 Jun 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9AlNk6X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2028D8FE;
	Wed, 25 Jun 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870955; cv=none; b=mHw6l3sAKvocJR8I12h2xDELXPNnMp9T9SZT+6uICkmtuiZle2/GifDqqmochpYnuEJvqaGIOTiOGvIU3VkJ9BkcAvnH6BThdlOjejJ8ved5i16p9eFadzS0VSnirOlO1im7oZO9mByc+byanhY+dsmCPE1AKtwGNq2Ex7UZGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870955; c=relaxed/simple;
	bh=N50hT8VEHYddcT/RAP1xOT9lPv83004F8OUxqy1UH5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hBiF0z/leJ7PicPKkknub1F7FzSvODAK3O+WfWXbNE/mIV8KLuXCHy8sa95qoxRfUCwUpXiRzZ/RpyAuBPKahTNNrB+VdOyowosApUa4dNI3PEwz6KROFGFSCDDYs1GcDQlXFW5S3S/MtNN1d7tDGM7pPrlCmJcXMlwroyBI8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9AlNk6X; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60bbfe9e864so8488a12.1;
        Wed, 25 Jun 2025 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870952; x=1751475752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOdk14vXFlLtpbY7hWGNpgAfHVc6f/iGH5twokX/P1Q=;
        b=N9AlNk6XQExg59ct+1AWq0WHBPoOtgI0Fb8wWALUS+EhG9qLOsnE1vxX+OLOPiLJKf
         6SfdJubCL9/db3fUKAfA3jO7wvw6RkD2CZ6uCZ93d4B0zBHdrRiQjs20y2o2M0KiTuxo
         kwaJE6W2KIBBtTR80I0tDXKOY1QYObJ5NEHw6C1IdbCDxpGA6FJFcZjN9PKsAKZlDJLY
         Ct7PCWhLnU9RRMEMJMlK6sTJpCvEV/QyLAbe/ZiX+S0j/m9jcALMx2erARXDcvQ2mCCI
         01OgyK8sP30auQjGhH+jE9kSOdac6lV30fyfElBcxMe3Aqg/dsp0rUwvM/BxAKG5rufa
         i9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870952; x=1751475752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOdk14vXFlLtpbY7hWGNpgAfHVc6f/iGH5twokX/P1Q=;
        b=FRwibw3AW5Kyab4/wSQpa4jEXP9eFAqxOESNKELQA63vo4RMCL92Qu4zvAkY4VgUHP
         aNvPn+8wBYKEkfnaReaOROoU+ZVUbEsnKBZIKD3yzr/auC7OSe13pXOL3tUTjDWP8Spc
         By52+k2VxFR3vP1j7pQ82gK8pVjyr1OfKAhB9joaHCf7w0o3Aa3il0U4v38mTUt7/KJf
         SOifGbs7bzhPaO95qaoGH5gEvjN4vYe19ZnZ9r8cZnpaCGSpvT5vSO51O/OSww/TMvqU
         aOmc3yqwoWpQwaXSkfqNaNrX+/JPUm4A+/F/nuE5cG52ph0ynthVp1OVfPACQUkP2ZsI
         3duQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzVIs8I6xrW1nLFeFQ6S6qRPppFS4prrRU5CU1BuKMus5vuOGtawRvYh6JWIkxP+2xaASFtFV0rKsTnUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhBJoUvwb4Xl4AB3lsSgmPVw1URbi0NplljGpss+qqoAmWTzh
	fZZ7rh9lPAd5Rd2T8nH2ahidV2XKKpjuO896aI72rtJ6PcO6mC7k2cJ8
X-Gm-Gg: ASbGncspgOyhUAdpKxKuWLtqAymLLsZH80gh3kFJnmPjkVN2XQg1D1HDpmB7VEVRmij
	PIM2JsslSMlFGvRJCAiVOBRFvcuV7vgFjtwYCD9iIdY7UvcktEeyt7ottCbMi5VE9uP/TYln3xs
	P0jIpgIttFbKoNYI+8djRRzfPMEtVEf6bNsgfFlT7YXkedlhi2hDNOEhu6VgZq4UpebWyzQp+cp
	1DCZO/64rKmFG8rgJEFdvig+1ntChTEUEnzpvFnMkQWMuMO1Vz/yQ/B9PROi8f3oDCZE5DWtfKL
	7R41w9DaZM/U6NChXqubmQh+KHIj3Ju80QQVayKxUAz+Y2MtQ7T0AdVY6Lr1VS8dwNWTiSs6h/u
	9+H1JuVDej++CG2iOS/Q9s3+XjFiKnEh6
X-Google-Smtp-Source: AGHT+IGaZC9Rml1a4PR4Iq+dPLxqOVNQqzhj1FFaq7Sj6I5q5FQE9R2CNAYd3gQnL9ujbOk8ZkoyyQ==
X-Received: by 2002:a17:907:1ca8:b0:ad8:aa3a:772b with SMTP id a640c23a62f3a-ae0bea37b6cmr139097066b.15.1750870952011;
        Wed, 25 Jun 2025 10:02:32 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0cb358618sm69249766b.102.2025.06.25.10.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 10:02:31 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: mazziesaccount@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	l.rubusch@gmail.com
Subject: [PATCH v1 2/2] iio: adc: ti-adc128s052: replace literal by unit expression
Date: Wed, 25 Jun 2025 17:02:18 +0000
Message-Id: <20250625170218.545654-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625170218.545654-1-l.rubusch@gmail.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the literal number 1000 by MILLI from linux/units.h

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/adc/ti-adc128s052.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index cf271c39e663..67bc7fbd52bc 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -18,6 +18,7 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 struct adc128_configuration {
 	const struct iio_chan_spec	*channels;
@@ -189,7 +190,7 @@ static int adc128_probe(struct spi_device *spi)
 				     "failed to read '%s' voltage",
 				     config->refname);
 
-	adc->vref_mv = ret / 1000;
+	adc->vref_mv = ret / MILLI;
 
 	if (config->num_other_regulators) {
 		ret = devm_regulator_bulk_get_enable(&spi->dev,
-- 
2.39.5


