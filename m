Return-Path: <linux-iio+bounces-19126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD29AA9923
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B610B1B60CAE
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B0926A09B;
	Mon,  5 May 2025 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kKUvEXwK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3040C269820
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462770; cv=none; b=bj1WZqpTbxSj8eiE+vMQXv0BTVhI0KFbhP/o1XXY53ypOL6mw0L0qyOILmWa7nY2vCWmOyHF/wbeNNUeU3TRVwlNvbbTl0vS7kQz0JI9RYcA4WCiKqnAru6Upgo3aSJUeIurop/OCpJI4Vg3Qh0Skwh+PfQgk2kSimQspphOrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462770; c=relaxed/simple;
	bh=Vr9wDkA3SNoSLT9FCnDYkBa0JumGawTzg2ZkCcTYUYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mQwQ9lJgXbPqnoPTmVcok1CST8Qz1l7IwBrVn1MIpdGVtbJNVk6d7kcchG8kHjlhnpyPk3BpfHtNvAz4oicl+mwt2HgjXehZ54oVSyxFOPwRE2KGY0LdEZrN/BmmR0uMNxa+pH+Sz5WtHd4ZJZGZNIxxb9tNtAhlNExCjCIsAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kKUvEXwK; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-401c43671ecso2281058b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746462767; x=1747067567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIY1UYaU1fvtHky+5YvUDY5xMfkarvlEBEV1oBc96LA=;
        b=kKUvEXwK60vUpsDcCOHT8oYxSFX5YIX00JTItEVWHLAsamRFhDjJfvlLrj7gXld0Hy
         uvnaPIgigILjYZHJ+XLMY+6gqmEO7NYw1BnKpvybrq08ykOhbZbvDuur7NSGMUiFa8aZ
         gRBBLb/k8r7f5pCQO5T8lYcB6vLlvjUBrMHX0+p5sUmqvQPto9/jYoXYKuKYQno9wmpB
         LJIRXpUkW9UTx0DivyccjfbM7H4WVCKJfJ+Ebe0aG16cJP7j1NeNBZRFqIhoMFwav3st
         WraRXUsiT8GAv3vmrl1jFZduJM4mDBrsRmQneXGTSHRBvNlgr6z9vimkFgjTESu+taow
         ff9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462767; x=1747067567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIY1UYaU1fvtHky+5YvUDY5xMfkarvlEBEV1oBc96LA=;
        b=Sl8uF/25luBXJtjx7wtb3RL++Ksyg23YnmgrEhGgZtnjuo+9Q2n1Mb943tTJ+M1M46
         Oa/fRgeW8vUz2CqYW9NTKFiKYW89K944tzJa0kXfTKGqVb513GHvg2D93uhxht0pm0cU
         duw1blvokIIAqdpSBOKToOUHQwLy5Qi2bySMgbVMLdd+sbQG7hJOfkg2zke8IqIGqoIm
         KLzUxntu9n50dlOdbxiLx1Gc9SkFxlznVPW/gziV8cpEB5KED5rbpYbELMBTj+ZArbBJ
         Ni6NFJ9fvINXWWezN/splFTh11ckJ+OJRauWGwhiBeQr1cdtJTJlVImjpoxiERMAjXSa
         dq0A==
X-Gm-Message-State: AOJu0Yw5Te7NxjIBSV208xkoe1r1EZ73oYJFn1YFthHOWABcvcnztfBr
	wfCS4gyOKkIliGbSlo+kcFc2k2NEWwJryHjkR9E9ix/lCZ5f+j8x64IhrxWEbyc=
X-Gm-Gg: ASbGncuf8yntEUM5OBcr/6gVYR5T5VZTPaj3Wlmz95OwaTbR5uFUdUnlh5olm8zgL9b
	Q9DcV4opkOA0T0aKai8n6sXu4zGQF/cCFOWWfs10DY4pFMgMYszHUEFRXrdItrMOj297DIt2znz
	Y2KuJvdjZFaC9/v7O1bvGFVWz6nDXsUl2aYyacHwAHJl08o8qMJ2yOQU4Qg4VC3wFv4RFR3t4dD
	CJ4dy4okDqVPDJgkzIPHlzKKApmacrLkGviawzItBKgF57pN8XpsjwkAMfcBG9yoZtMMTw1pJqH
	63iX4ZgqeOoA6P3MXLXG06p+To1wiCePVV8Fz6hAs0INEQ==
X-Google-Smtp-Source: AGHT+IFozkxNYc+TkZ/Dl7Rtx6+wVKGzltkaPmqSwC5J4g3ybHlUKPIa71hZXXNMAqeUFbgBk2ljNw==
X-Received: by 2002:a05:6808:2217:b0:403:3192:385 with SMTP id 5614622812f47-403687eeba7mr98841b6e.4.1746462766974;
        Mon, 05 May 2025 09:32:46 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dae68f7sm1971854b6e.26.2025.05.05.09.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:32:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 11:31:46 -0500
Subject: [PATCH v5 5/7] iio: adc: ad7380: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-5-814b72b1cae3@baylibre.com>
References: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
In-Reply-To: <20250505-iio-introduce-iio_declare_buffer_with_ts-v5-0-814b72b1cae3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Vr9wDkA3SNoSLT9FCnDYkBa0JumGawTzg2ZkCcTYUYM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGOgTCR6lEzYtZByvCH+u97cNW3EB5n2Er5uth
 2EUH5CDdrWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBjoEwAKCRDCzCAB/wGP
 wPbbB/9F7PFPzkzoQ0p3LiG5VHOqbAw7G90nYahGDdDEobzVJ8JTUEsMqCWq+ewG5pPXhgKRTwf
 ORcWEUcY3IzIs48HpY3THjfD8eJlJ+VdJIkSw4II3q8KfyQyJErBr2p5xtd/2bV+HdpptcIg6M0
 uDEWtTj8NSd3vFiZodyhdFToWiiXAgJnvkIbwJnzHNDSHq9ufyj9m/nM6xgV1ia6jnlhybT9NEf
 TCUj5HDyM7+ZrzFk/WnrcvO9lv93/9xCEeqmJ0sGTz0hdDvWnIy0nek77Mrk/If+7NwNr0/waZK
 VAm35vK0LffyNySOEDgC11RS5l0RxFLHuDgltBidEC+zewSb
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

As discussed in v1, this one stays u8 because it is used with both 16
and 32-bit word sizes.

v3 changes:
* Use IIO_DECLARE_DMA_BUFFER_WITH_TS() and drop __align()

v2 changes:
* None (but I messed up and there was supposed to be a change).
---
 drivers/iio/adc/ad7380.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index f93e6c67766aa89b18c1a7dec02ae8912f65261c..ed5e43c8c84cfcc9c4ce1866659a05787c1d6f5e 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -909,8 +909,7 @@ struct ad7380_state {
 	 * Make the buffer large enough for MAX_NUM_CHANNELS 32-bit samples and
 	 * one 64-bit aligned 64-bit timestamp.
 	 */
-	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
-			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u8, scan_data, MAX_NUM_CHANNELS * sizeof(u32));
 	/* buffers for reading/writing registers */
 	u16 tx;
 	u16 rx;

-- 
2.43.0


