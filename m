Return-Path: <linux-iio+bounces-9802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600F098774D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AE01C22971
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D9165F13;
	Thu, 26 Sep 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKIwQDM5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC816190B;
	Thu, 26 Sep 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366934; cv=none; b=HHcz0z84n8BD1xt0NM4iWYjX2gUYDQbLfDLfLElyCkVEfsh9Zbdrf+42Xu1UyeICEOhbtPtvcygB3D1Rt1sP+OvYS8NzSfKmqTXcd3beFA2Pf36eUNGmeXhz62kggqvkvFiXZ5yp5LjAjh0nJsY5d4qfzexaFk0qdDEAN9CfnGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366934; c=relaxed/simple;
	bh=xTmIMKWrAEJ2sxUaBzK8+gdHqeGN97Vi3rD2yxlm2m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rs2YCicFOtH8Z5YDhkn2NbFQqW1ooxSJ7ZJLu2CpPUOuuBWxQ4Ee+++Qrp1jxgp718V1V6gtIQTqsiN/EFVKkMFPRywVU0aIytFpZyVvjdkvHpehUN+1AkJmupyN+zzxV5eqyFz3XLTt+RCBm9H1Ka8LNQZ0Hqu5B1cLZVAwJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKIwQDM5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso222571566b.1;
        Thu, 26 Sep 2024 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366930; x=1727971730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfSfRbf6HpAPUG9dd1ayagyvrPMaeTlKhJpm5dY0lEg=;
        b=cKIwQDM5E+9h2I+F3Ky3eZc5N0t8dut6FSPH3OnBIkHDPQ7lGpdbsYC+SAUhadFibF
         NPtMrvIRGWFsWECBIh3FSITSOCtfyYmzfRzuXdQagfMTyvO9zpGnO1DM2d5X/MFxIx01
         zoaddBVtFqoR0O/zSxLyLyGD3hpa52pU5deiQeOk6AFKPWInJPFsAikCyPp+sKOJqD/s
         87IGq8N93q2euazXZQ/pGbLQTI0gmJdu2F3+LKrQ3rE+CRpAQZd0blVdGTbzV/G4Q/bS
         zNbus6AVsqPEaXfEJSajE6TqcqV9nQXO1F8kc+Mj4E9rB7xj98KiLmSOxHB6kOKj6934
         FSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366930; x=1727971730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfSfRbf6HpAPUG9dd1ayagyvrPMaeTlKhJpm5dY0lEg=;
        b=fIKmH0rbAnTT74ZylZt76QhGsf8SlngjZWIxPlafw0kv+ZIJ9J6doBuydu2AB7ToBf
         /Y4tE8/QPz//NXjDSVCNvAME0kaUnfMIjU2YX1Q5LC4IYQFaLxbqBe2JNyYFsV5wM8wo
         2WuSR0NEHylZXmz5IZ3GZd3X7FX1113B5CgJl/pdVgJVO3RdTyzXOMhkjnyQAaKR88Xv
         Rqs0V82Xj04s1c+p4/AuIpaPXcluQR9xGx1KmNnkTxfgPYvgW7OhEihkkNVXk0B6HpvS
         FqE5EziiOjoe/2rwNFZHUIGOaPJwk5T0Hsu0pyPWDPUJrrse3io8AatdzpBLx1dEiOwm
         U+UA==
X-Forwarded-Encrypted: i=1; AJvYcCUP+h7TLA6Pj0z033X8aY2aaoDEWbHjIO4/LPvCnqDCVZlBjfKfu6FN2nVBNhQ2+uWjBtpLLCX4Om/+UoNO@vger.kernel.org, AJvYcCWxxmdtri3siODNkXTHhaSL2gNbNoVzA2FBHdaYdeVKXxn1YRVTQx/76tUYqPLWtc09C1uGxPezahU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqziQ3eCpNAWghKu/AKBof7GGcZOaBpkwi7r6CD1rL6DSFAeY5
	dsi5ikx6pwAKdgF0tZcCGxQOE2MvkvEHzo9lVP8JkRU/u7yU84uDe7NhZG1a
X-Google-Smtp-Source: AGHT+IEa8ZK99gytPYhlMMIfBCh2WLdWCb9VYkK2bIOBiKcxBkDWAAatz/BvNKwWyUydN132lAq7Sw==
X-Received: by 2002:a17:907:d2e5:b0:a8d:5f69:c839 with SMTP id a640c23a62f3a-a93b15f92aamr392676866b.15.1727366930195;
        Thu, 26 Sep 2024 09:08:50 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6d88-4cd9-a9d4-f267.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d88:4cd9:a9d4:f267])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm13947966b.78.2024.09.26.09.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:08:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 26 Sep 2024 18:08:40 +0200
Subject: [PATCH 4/4] iio: adc: ad5755: use scoped
 device_for_each_child_node()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-iio_device_for_each_child_node_scoped-v1-4-64ca8a424578@gmail.com>
References: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
In-Reply-To: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727366918; l=1682;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=xTmIMKWrAEJ2sxUaBzK8+gdHqeGN97Vi3rD2yxlm2m8=;
 b=PgLKXJGq2MweGHIGTLRvljlOM7oxtbS7Y8PJM25aEBf0vmjeCKYh8ES4/Km4e2w0Irtx2nvj1
 ddQdkAH4KPBDo3JfVnrEyLrV2hVMi0/5mNJUuT+Hf4ES1FMXY9K209/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to device_for_each_child_node_scoped() to simplify the code by
removing the need for calls to fwnode_handle_put() in the error path, in
this particular case dropping the jump to error_out as well.

This prevents possible memory leaks if new error paths are added without
the required call to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dac/ad5755.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 0b24cb19ac9d..05e80b6ae2cc 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -699,7 +699,6 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
 
 static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 {
-	struct fwnode_handle *pp;
 	struct ad5755_platform_data *pdata;
 	unsigned int tmp;
 	unsigned int tmparray[3];
@@ -746,11 +745,12 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 	}
 
 	devnr = 0;
-	device_for_each_child_node(dev, pp) {
+	device_for_each_child_node_scoped(dev, pp) {
 		if (devnr >= AD5755_NUM_CHANNELS) {
 			dev_err(dev,
 				"There are too many channels defined in DT\n");
-			goto error_out;
+			devm_kfree(dev, pdata);
+			return NULL;
 		}
 
 		pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
@@ -800,11 +800,6 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
 	}
 
 	return pdata;
-
- error_out:
-	fwnode_handle_put(pp);
-	devm_kfree(dev, pdata);
-	return NULL;
 }
 
 static int ad5755_probe(struct spi_device *spi)

-- 
2.43.0


