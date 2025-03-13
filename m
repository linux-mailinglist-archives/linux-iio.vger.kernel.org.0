Return-Path: <linux-iio+bounces-16752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE40AA5E940
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 02:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3002B17B3CA
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA170809;
	Thu, 13 Mar 2025 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qB99r5xO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78BA179BD
	for <linux-iio@vger.kernel.org>; Thu, 13 Mar 2025 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828578; cv=none; b=B9fpCZ3gxRGAEpnGIetjykaXy6lTWivEF9Hqa9H/cZWG4NIIbokQNK+OPo1B5H10kySNsM+NEk/TPu7jO02wSKcgNSdWY1cfzMIfxVSaA2rIJflIc7rAxDL2g7ZXbIjNBVZP3R2ZK3YBbELctJQ+n9k/ufYJxJzngWK408mKNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828578; c=relaxed/simple;
	bh=xZHcGGygz8rLb2jKnacJRSX2NoW/pbcS9hwvQWXE9dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EP4UeCVpD2rjostAHvawyjGQ/GRpcmh55noGiQNjOzJlNXXRWFOMmBEGS1xA8ENSq+NoC0uoQeiJozEEHEQF3rebgTlmrmZx+7yCOjAia6OC+OAcSUs6LxHCT1ymRnj2IQNm9Y6uEndu/68I0dROyt5Djz5ziV0pY8+aJ91kdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qB99r5xO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7271239d89fso130234a34.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Mar 2025 18:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828576; x=1742433376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn6syc6wh8t9UYBPXOdzHhnfpFN2bWgwC2EMK9hX77c=;
        b=qB99r5xOzcOAYUWu46n7Ox0hAC6ROLLSW+NXSF5tQOxfG+/5JfhJP3WrQEuvn/LX7Q
         Jm/CpFsezQYeiPf2/bU+MFS9c+eVn4eZpkGvrrWrgG2hVJ8Kjvx5SQEONjvup2MseHA6
         EztbpC1yukmvfC+RArhhkS52Su2/MlE8AHT3cV2OhoK6AUgyDj9ueuu5M4eIR+2urYRL
         kzqbQERYUL6IhXGuVQEBubj4YfW3wHdQ69Xk+MQ6j6faSzY7rqK0380mZOk6hzs7jMRT
         Kv/s9i+/vsDYHgmyY8LZR/AmqLxqYRO8yrenYW4xKkfiIT4McGYF0hVn6CpoUcU5H6Ng
         rMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828576; x=1742433376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn6syc6wh8t9UYBPXOdzHhnfpFN2bWgwC2EMK9hX77c=;
        b=jWbnanRwnRAg7deGueIZu3LGr/YbbTinVV44baNIF7+1xiHo3iykp1lxF/WkPLk6oE
         UbdItHbVG5bLhh6MdP04aImPjbJMU2kWmJ5jOuWkpQYOW1H+vMql7dcJQnuoP7kIv9tC
         E16irjo6wdOA1jPXnvFcShxX6oj8ITQfjLZzWaEjSgGgYyN+VtV4W23YGMtCZx3s8Yye
         ddK0nPG8KMjg2kKXGZT6U88nDCgx9iLDtzEDCGr5IF7tE+lmA37bUMxRecFPM9DlErzz
         y5BTsr82i9mcte8yU7hthadEMkpGc/plS+mYT+jycG2u+kgVyn7k1sH7PQZeKrtpXfzZ
         h9qw==
X-Forwarded-Encrypted: i=1; AJvYcCVIVyXnn2oQBdNkA1WQ8dF00dQRp9SRjlJJj6bqpzqdPnBxTocVJpREIARuzZ1/lJS04K2TPFY13mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQum05nVFDx7upblyNWhZi7rU3tgwTn3oacyE125Em7vg74aE
	CgGHxxCO28CxBLCDP6ecwejXVkegFuaQFzHHmQPRanMuHUsXmLlZrlaCUUYYGFP3Tuonb3GfLiR
	k9Gc=
X-Gm-Gg: ASbGnctcXwgRDmb28mOPU4y2L9DR/siTGObvSCbkyS3HHHet6bvw/X/TuEFP78Fjftx
	xlKu2SKVdvd6td/blcYaaptzwFTciioIqdp2RWA1QgKnLd8Z8L/y6QWzcKaxJmO/az+DiNqOt9r
	ueKMLJRU2UR5hgRxF89oT4pJOYgZX9MhtWhnKBWm9Mh4PU+nzHGDpML1lp2LqLyeSjLMw9lxqEv
	vEmzAOtMFfdt5VK+WorBuW1vmw8u408fDHHpEBVyt5PsqwFJiLFIf4fyv0x23yaRf15qnA0MXA7
	2zb44Qwdsg1Hcn29GzPmbd/LqlKCVaVn+iQDDHGgFfYPuK+6FXoniWnxpHVrnpW38xKzIedsAKi
	HQFUVh4QWMNY=
X-Google-Smtp-Source: AGHT+IFqI99xnlFy4vifJ2ohpC02lCYpxCA0dEsc1Wso3XCVcaj9+mlk9yGOjVOWn1sqikxx0nYmpQ==
X-Received: by 2002:a05:6830:6201:b0:727:4356:9f07 with SMTP id 46e09a7af769-72a37ba072amr12944875a34.14.1741828575757;
        Wed, 12 Mar 2025 18:16:15 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:40 -0500
Subject: [PATCH 02/11] iio: adc: ad7606: check for NULL before calling
 sw_mode_config()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-2-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=xZHcGGygz8rLb2jKnacJRSX2NoW/pbcS9hwvQWXE9dI=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHa3XB7NLH6KlhxCimyly37UP6OgW+jgn4ji
 O1EenmhXI2JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMCcQ/7BfJcfeY3IbXeqBUQzMYAqUbr5OxwuJ6SRo4Y7Ky
 +n152MA7Xi1730p+i94R8ssYBgq0ZG3ukWTbMiU9EGmaRILr4Ou8fm1tsq1CxGE2OJGYJM27r62
 VPHpBhc6BTwNbEbn3SSnLuFUEwDNd/COcz9byTJ8kw1EnmktcM/VsynUnL4Yfpv42qtnF9sJkQo
 x9U1dVTYPWpKqfK1m+ER27D06DNtaz36G0rP9S73i2NE9zJKqoDbO73teee/mohAQa7MOE/jswv
 GqEkpgHnFUvtOXvcAchjdN/lIztILIKao7QH4NI9Mfzkyh9gnEaj9k5fv0k8tWrYDx56VS7UZ8Y
 O6YWni56Bus4UVJXm9pTRoUC+6zfie0rjinrukkganorAu11xVt9zYYyt5G0T01A3ULhypT67Bu
 CvTlkTh+/E4nKQv7pz5wqea+At+SfESe9MoMc7MC9jyMXT552hi/uINWmCWnRMLue7rXEbnouj3
 kMOpKfymNovEAcaDo9rjfNIU5lvpTEBesf//+ZDwLo5m01By/YsCmal2XtYeVn0TQNvmhBVPwVo
 aY9QVcpRpMw2DlylcAY+QbGHV/obMrSmEMZYQ8JPScnkpk0aqhuoH0C7+6KtKLPVpcSgIljfeL0
 VaGfi8BuoRO0gPJr+pitKe/A7x1DrHd7BspgJjMhRDh0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Check that the sw_mode_config function pointer is not NULL before
calling it. Not all buses define this callback, which resulted in a NULL
pointer dereference.

Fixes: e571c1902116 ("iio: adc: ad7606: move scale_setup as function pointer on chip-info")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 631e837171679ad95e71cef2ce6c55c2c756881a..ec444aba25e89ced7b84b723aded3c9dbf2c738b 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1236,9 +1236,11 @@ static int ad7616_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7616_write_scale_sw;
 	st->write_os = &ad7616_write_os_sw;
 
-	ret = st->bops->sw_mode_config(indio_dev);
-	if (ret)
-		return ret;
+	if (st->bops->sw_mode_config) {
+		ret = st->bops->sw_mode_config(indio_dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Activate Burst mode and SEQEN MODE */
 	return ad7606_write_mask(st, AD7616_CONFIGURATION_REGISTER,
@@ -1268,6 +1270,9 @@ static int ad7606b_sw_mode_setup(struct iio_dev *indio_dev)
 	st->write_scale = ad7606_write_scale_sw;
 	st->write_os = &ad7606_write_os_sw;
 
+	if (!st->bops->sw_mode_config)
+		return 0;
+
 	return st->bops->sw_mode_config(indio_dev);
 }
 

-- 
2.43.0


