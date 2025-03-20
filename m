Return-Path: <linux-iio+bounces-17154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6DCA6AAF7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30911883762
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D71EDA06;
	Thu, 20 Mar 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MMdhkUsv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885117B402
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487737; cv=none; b=OZFvePuHofuXl2+0bTYj9OHEjArGSm2fmh6+vhkDl3ccHcV7NduFHhJr3YZtL7OKvA9uGaEl459vfNomZ0q+P8WOpTN6xc/s+JhPB+J+HBLbQjSMRxHsNl20nP7ktfUNv0DCIKWkSsyHxHugmTlJqQvV9rJwwUv+982qBB0lU1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487737; c=relaxed/simple;
	bh=baXdZMpYZMQFEC98ABjVNqhaMT77K0PYCTO+rEXCflE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GIQIf5770q69Kj+AsKlOv05dm1eVKTATX5FVVQPQ3ZRc9Nc+QbPu9AF1dTusFzMFyI8uhpq+CEmMJGYBdjTIrltdohhfXd3yU2/Vh7CAymeViKiMz4JqUl8qgpNKDZ3AaACz5Ejzx3xIK6MVvOmu+324xRoveCyRSXf3PbAwy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MMdhkUsv; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-728a433ec30so1163890a34.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742487733; x=1743092533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1q8PxXByFyxgJV41FsWeAnzj3IPlFF5hA9w9NPTGBY=;
        b=MMdhkUsv5ljJa8yaTxg4vgJ4rnffA2KiY/lAZ7C3SA9FpZsGfRP5th95F9hZm6iQ9s
         KccemdUOmeF6S/rutJLWNhTY9f8bodYNYkcFjYtivki6epxRhNy604/93Zb3zq3n9kLn
         yi7lo4a6D803rMOggL0UX+n5lKMFYLDsstsvAnhKH8ckZNFFG7LukUEsAK4nYX0Pj6PX
         vuPkatksaKuDx9pVr6/yPxe9zU/7RjD+iLUByATAszL/CSQRs8myFNBaoleMvbNsTHBI
         t0ph3N+x+OtjrfmBzmpAj6hkAKPjH6GB0Rhl+2jC0kCzDXFwDf8t5Kwj2P+LETm0aBLl
         pOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487733; x=1743092533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1q8PxXByFyxgJV41FsWeAnzj3IPlFF5hA9w9NPTGBY=;
        b=SI8Q6V220MSYH+rLdNkdLJVvcauqUOfVQSOVOmqoGLz9ORP9Zm1OrGAFZebbvlJD7B
         QTvC5UNTVP1fOrJDSgis3pVcypuudAXvDCB/vjdOwWgirAqB0VRHZmDaeO5ntwp1mGOV
         1XoeRrlSyIbobR1r+PkcOxivTdY/Tnxwsx8nJBDvor87olFWShGay+dgwjShJrLgbCXZ
         Acw8e2V/SSkwj14etb7U/1CMK4/RJiyGxCw9RsiZAh7vj8X9uvJpjsMQ1WOUsrBrwUV1
         Q/tNQLhN/V2BeIOm16RBVn/7HCFuxvp8fwKhhBTtrSrFsDLdHY/7az8TKCdpiU1sBn9O
         wCBA==
X-Forwarded-Encrypted: i=1; AJvYcCXz2WT8vH9kRgtqGMTXlPyL2tBw1s4YHWNtbA6qwcaB7a4n+piPn90ZJBScEhMqp/jmJj0zdWDd/n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB4wZMu2nZfvK8dG8QsIiyGtytKXJdnhAV5ChRobBYQtTRIbJ
	zkRPvXZuSLWZ8ib1OK2OkyHJZ41u6e26HBOThnCA4XwdNqyCTE6X9MHadhZ3x8c=
X-Gm-Gg: ASbGnctiD+sf96Of4SHNzR7uJEfyM6rk84imJfMlBaPYDkgNcqNifDIiMCf40+NnHW8
	FqrMzUylsE0+EsLE2jRDO9XfnBtV7Lcvi0h9no21jx1Kn+7PTC0U6JswTa9GmJssVGhcjEOn4M/
	k20JHS8qMaIo3rUHQ6x9GsNJV6G45z52e8ZCuevyVDEtECpQ5A+ptVYk1td98rZ+Gv+g3WHjYA/
	O5CT4D61OQnFNiKTaGH0hJXZjInIXB+6mqWbjHdNwU84M3soPGkQYISFW7/B9cth60MLcXg3qmT
	nWpuhTCzkG0TalQJlW2syKYe4yBEn8UEqQHUZcGps+SevlwJgY15dQaVfqUQJhjYP6SBh6u3tE5
	9
X-Google-Smtp-Source: AGHT+IEAZT7cZkFi3N9O/7IkgUUC+ipDr7D1yuSmft24Q4Rr0rzYbqQCmkGBkC/KBVJ8ZoW7p0n/wQ==
X-Received: by 2002:a05:6830:718c:b0:72b:9cc7:25c4 with SMTP id 46e09a7af769-72c02e63703mr3004295a34.22.1742487733064;
        Thu, 20 Mar 2025 09:22:13 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abcc1f2sm3616a34.37.2025.03.20.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:22:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 20 Mar 2025 11:21:52 -0500
Subject: [PATCH] iio: adc: ad7380: disable offload before using SPI bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJ9A3GcC/x2NwQrCQAxEf6XkbCDdIlZ/RTxkN4kGSrfsogil/
 27wMIfH8GZ26NpcO9yGHZp+vHtdA8bTAOXF61PRJRgSpTNNidC9IkuJXKaZ0PyLfXOsZktlwfw
 204ZbU/HOeVHkmUYplq+FCGI2qpD+l/fHcfwAukE6LYIAAAA=
X-Change-ID: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801dcfb9c00
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=baXdZMpYZMQFEC98ABjVNqhaMT77K0PYCTO+rEXCflE=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn3EClI3Pa5Tr0wrsxXWIzbCMYcJ0fBD9bjJwjh
 DknTWpRQYWJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9xApRUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMg0BAAqBRIy1Z1KsEU9bRBzDpY9Lrsp9h+mOyeUxg2hoi
 a2T9iKDhOwr6dq4TksNbJdXBLmpqbc10orghnZbYdi2WFdL7laCq9fRZSJPZ19ma5oQQnh0mhLA
 TYtqR9XfPsM0QwvE2Jo/XYnc5TjDAoO0UTnxgtm2fGLcfT/3ZBBtO2kGAox/ji/nXOx/kwlajy5
 jaTFNIfooA+/B74EOBK0r7OtX+y4ZfeZDgPh6eg7IyXX8VMybrmJzc6olDSXePxaSwiyXf70W53
 s2xB0GX404PCE9927RkKOJEuFV1c6axPiENlEjbnL/EBSyMPuXYYF3fqO1BUPqM5RSnsWR6d6ry
 PmNaCAml7dEyib3P/MmQ8jvK7tjfEg4vj8L0cMdA5gK8u5ixNvBn2lO6drR03bx37s8edW9v56I
 lmZn3zBon4MJtD8NpUfpcZT5UV+VnROqlvs9xPg9CM5Ct4yw1DzZIlzOf4mqj+T8YEpjzIUn4/3
 VIE0pXeqL8yxdt9VUgQaw71rawiH7dCmzxoO2ZF1/rIpLPhtO1AJM1P2h/64HsBKwLQdJRGpbNL
 xBHx8YNKGtr4wMs9GLe7uOki/IyrD12cFl96AY+mPOhw9YJYKt1jSn0rfhrANnp04FWB0u6GplZ
 aAHkx5KHcrFaacV350HG29sG3KvH5+nCRQDU1HEndTh4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Move disabling of the SPI offload before attempting to use the SPI bus
to write a register in ad7380_offload_buffer_predisable().

This caused a crash in the spi_engine_irq() interrupt handler due to
being in an invalid state.

Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..a2b41980c942e4cd1575bfe4f3846e297ad5d01d 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1211,6 +1211,9 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7380_state *st = iio_priv(indio_dev);
 	int ret;
 
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->offload_msg);
+
 	if (st->seq) {
 		ret = regmap_update_bits(st->regmap,
 					 AD7380_REG_ADDR_CONFIG1,
@@ -1222,10 +1225,6 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
 		st->seq = false;
 	}
 
-	spi_offload_trigger_disable(st->offload, st->offload_trigger);
-
-	spi_unoptimize_message(&st->offload_msg);
-
 	return 0;
 }
 

---
base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
change-id: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801dcfb9c00

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


