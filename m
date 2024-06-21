Return-Path: <linux-iio+bounces-6676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D439124BA
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23898289F1D
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195D174EC2;
	Fri, 21 Jun 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1mKHCGL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250D1527B6;
	Fri, 21 Jun 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971546; cv=none; b=KmYKfoDMfjCcIYTBsGEAQhe1llxixYSYdrrcdlsgj/TL8/iRXntQp6AFbcv2jTYfyL/RJrQhBDXGlK8T4GTb+zVJfRkbIcdm98IyMop2EyufxYZZmXoweC/Jp6bottSThlxJRNo+pkDpvK16BdRLaxS52CN7Xobfu7Zei06acbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971546; c=relaxed/simple;
	bh=7NEdzMDsG1aF5JXdHMtlEyGPHIx8whif1ryBPcbKBwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNO7pMm+02ssR2AMLXGYfdhkSrcLm7QOZYiA+f1iDexIZ45jCFZ9lbh95fhZ6+NCVS2hncOzj7R7IfCSr2pY/ilCMrDE9nB6ag/Wtn6c0WeaSAyNjZN1uSiv8sHY/6slAMUSCquJev+RL24437Ks52Q0hQrEQv41QIJu55Q4HiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1mKHCGL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6f1c4800easo215299866b.3;
        Fri, 21 Jun 2024 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971543; x=1719576343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBWbR+qMKGw2FOTak+FHBEDOXI2ey/XY9oATFfyQUnE=;
        b=F1mKHCGLwyTYwel9y44GLRMBSl9opUjS/b2BUsIfAjYzL+SGhhClPqkx8U/uIOVarn
         joUtEjkYi/EcFo5oeCX5SNFEvSQhKRpIf9MGhiOTcrlVqGky5/aHmyrLkzVGLXR7UfS+
         BZkWdMNDJdUuXl+WykQROU5LTRicgpUXqhLMxUOdw3TAtR2Y+g7EOJiGWfO3FzQhKO7r
         lDc36XPFnzCXEMPeZI87ojKfT1A4ID3iGtZ97EErDl3SRUylZVFNH9bYOnRDKEvpmiMc
         1x02Jn3hLyk3s5Kqbgp/6eMWAqHgJ4fjwZzVWlbcNqcftEN4J0nnhd1ocDmNp5uuLW29
         Wybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971543; x=1719576343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBWbR+qMKGw2FOTak+FHBEDOXI2ey/XY9oATFfyQUnE=;
        b=Gc4cHeWlZhA/JlnkORN12Cd5CEfUwxZeoQJd1B5+ly0gJnHfQxc5ip/6We56nT0HZG
         A7ldSoPX02rS3ddCW0g1sqHVaktZgdN7Bn4bvVu35GqfampWUArjU/km+eqYTFCdq42z
         UuiueihsV2B6AZSw4h6vz5k/iSBAo9pQ2jRvia3g5yuuH87bfaGedPLx6hAdPUXYpa9y
         bZFftvQS7r7Jg2+rgD7LykGN903H5CPsPMxsuM2ih2OVRXV0p+a6jM84MyLqICO61CX7
         qq0TRMXYuvL/YvJgnuGEgZAQGOsTqKWYmD0H0BUjPhim2ix+56HJz8TGbAuy0JdoE4P3
         VHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDLrRm/RPyYNf2IkYCqNkvIZCD6Nn2+ArUbGS25gx8WFki4LaeOupe4lo922XtXpp4efa3UsyvcpYxow2FvkvRPtcrUU78+AVHVFBNEssJDfz3AJ3jtyD88cmKcj9vlmodQ2dr8oHu
X-Gm-Message-State: AOJu0YzxTxkxfk7TTNOVOQaqbS5wo1GVdWG5GkBLZ30j4aVP5gyoyGy7
	sAbsEpcZwd6nA5lL97OQQEogDmelvNcTH/JB3Ytkx7VWTEZPHMlb
X-Google-Smtp-Source: AGHT+IETpyaW331fL0IzgKYIRceuwpmtPDiQxCUQHWy88ZV2GMIRi5fyqhdvCelfrgnbvaNrvgZkSA==
X-Received: by 2002:a17:907:c24d:b0:a6f:c0e0:5512 with SMTP id a640c23a62f3a-a6fc0e055c5mr360768966b.23.1718971542880;
        Fri, 21 Jun 2024 05:05:42 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56ea09sm76975666b.201.2024.06.21.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:05:42 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
To: mitrutzceclan@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	dumitru.ceclan@analog.com0,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: [PATCH] iio: adc: ad_sigma_delta: fix disable_one callback
Date: Fri, 21 Jun 2024 15:05:39 +0300
Message-ID: <20240621120539.31351-1-dumitru.ceclan@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADC ad7192 is a sigma delta ADC with a sequencer that does not
require a disable_one callback as all enable channel bits are within
the same register.

Remove the requirement of the disable_one callback for sigma delta ADCs
with a sequencer.

This patch could be squashed with the commit that it fixes from patch
series: Add support for AD411x

Fixes: a25a0aab2187 ("iio: adc: ad_sigma_delta: add disable_one callback")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d6b5fca034a0..8c062b0d26e3 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -672,11 +672,6 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 			dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_all().\n");
 			return -EINVAL;
 		}
-
-		if (!info->disable_one) {
-			dev_err(&spi->dev, "ad_sigma_delta_info lacks disable_one().\n");
-			return -EINVAL;
-		}
 	}
 
 	if (info->irq_line)
-- 
2.43.0


