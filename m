Return-Path: <linux-iio+bounces-18998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95500AA7583
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82477B204D
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAC22571CD;
	Fri,  2 May 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mZ78Ol0G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96B2566FA
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198287; cv=none; b=jclWICvLZTBLE1XsxQ9Sr0F0fn3A3QECg7E/T62wgXOnVkD4x53OoMTulH4rtjg4q9zciqn+z5r1p6kbM5Wrcjl40OSRdrQOrpTXDATN49uNQAiGs9ZuSdMkMqm4gGp5WFSBJtOtfw0JSNdJhS7BpuwJAXHDt3MnfhTgiGaY/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198287; c=relaxed/simple;
	bh=QB2pd6K32pPm/R4yNnvzN2uXpyKKtYoPhUKZ0fvdOl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rWg+t+Ihxnb93MPc+bKKAPETyqvMIXk2g1/G8AK+FxwKyGn5/HxJPiNsVRvZ05VkkdH7VSIMtSmFtS7qYawIrTVqrL0aKIw+S3U15UoVNIbXPQsLE15MDyPqPoD0az/1BgH78TOdS/J5p1Cn2eubPAfohQLuCQJQ4/5bgcsjVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mZ78Ol0G; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c7f876b320so1925498fac.1
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 08:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746198282; x=1746803082; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx+8S/vQHwR2Y2hsJMbT8d2LyCyrGyIwd6nkEI2M9RY=;
        b=mZ78Ol0Ggc1C8QpjO93TW5bLc5ysRWkMyywxI3QHQfkOGF1ab6UxZ8z7PbN0ZmwXP5
         jw85lvUwqWVMT5Vb9CF7EWAXMfjdbsej3kYMKwwJJSQBHEWbosRWyS1izOUQKe0DaPSg
         2LHstaRWBG1qYnkQ0oGZrW6aT5iAweOQl8ng8XcaTHJ/SvxWE4zEtEnU2H7D3IsYLAtE
         ic5D0jssPgUKFcuHEfWwUAsOgS1xpFEqrGAECXnloRfN+X+eDi7HdQWnt9VDf5R6Yyx6
         5d1Ca4w3HCE2C+zV8PVWCP/P+n19TFrWqyYP5nEA2VT1N77b/q/POromkIEt3J8MtjxS
         mfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198282; x=1746803082;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yx+8S/vQHwR2Y2hsJMbT8d2LyCyrGyIwd6nkEI2M9RY=;
        b=ilNM9XK8GKPWD9smaAkCTu+6CXWgWyHNMVnh+twscsFUBsfqqQJNM9lL3YN4Q6vP5D
         //pE+Tczc1UIhbe/lqSVntHeQ1LXdF2VyDCj2S7Q+XqA1KlAF+gSNOTAhDc3aMdc3l4H
         prn50T8Qkqx3U5Vv5Zl0iYYwsmf2F6XBzxMutTxHUkuHUSjMD0PR5V8CiJfSQ1oyX3O2
         RJsuE/09M5F1xqmYBMq8k1FhYJc3hWlowAF9fteg+TTfWFyih0MBSHUTQkpYmpcHsW8z
         LtPyGXNOBnC19pYYQPxzrGGLhQ8awV9WwsvtoWIYZTI+k0xvl/0s/wG2/kSTYo69B67Y
         bU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8SogPPr6Q0fIBtMmkRR4tYprAqf0qDvrTWgX7LWnAL77D0ZxJPDt/p7oofW4WQROJmH4qOITR75Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFh93hx5i20xmO1lEXguLwrzdIMxQubvBdK2vdMfw05Fw9W2/A
	rPgeMj5RSPmb1b1OKVlSmh1aDIGBCB3GoaMD/JBXkYCCkYAW3xnOJUiLazCXLdE=
X-Gm-Gg: ASbGncsGN3dmKfuo4QBKPyh/f7jGHm5NnxpKLVtZ+CXa8UrkWoXFJed2kEKF6PuqJTE
	V8jaQsGgQ8TfNsExBnwKoI6Fl8sThkE/1Xwftm6sims+T8SAFeZ4InI+Gmj4MFlNeyP+oO3RtXz
	6qzecC5rh/OZrjS/QvEqMzvChnhzciA8gm2E1MolBC2vd1s3i+hQjEXIGU7liIZrcBJESxVqRGR
	tRNRoeIk+I+zl3LJN7IfJrzKe8hGBCZ1sv2OjTl3BsGZj2UPgnjeVSJSMUMGXqFymVuW6DS0haB
	2oY82JDO4o8b7LBgWEO/tX4w+juOBAe/fIJWs85ABaIB5ew=
X-Google-Smtp-Source: AGHT+IGNMhkaVj+iDHOz99QtZekWxhAI81Hk2kvf5cOCHjEgB0H3yNw25pFfE+jxIY2yWDJiCPWz3w==
X-Received: by 2002:a05:6871:2b19:b0:2b8:fab0:33c with SMTP id 586e51a60fabf-2dab30da0e1mr1585109fac.23.1746198282144;
        Fri, 02 May 2025 08:04:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4489:d382:ca90:f531])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2daa0ed6ef5sm644551fac.13.2025.05.02.08.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:04:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 02 May 2025 10:04:30 -0500
Subject: [PATCH] iio: adc: ad7606: fix raw read for 18-bit chips
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAP3eFGgC/x2NMQ7CMBAEvxJdzUqOiYPFVxCFOV+Sa+LojAJSl
 L9jUUwxxeweVMVUKt27g0x2rVrWJv2lI17SOgs0NyfvfHDBeagWpMyN2+hGTPqFpQ9MUsZUDH3
 ES9/gRbcKye4aeIhROFGb3Exa8L97PM/zBwaB2Kp+AAAA
X-Change-ID: 20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-ed035c488eca
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=QB2pd6K32pPm/R4yNnvzN2uXpyKKtYoPhUKZ0fvdOl4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoFN8BDQTJjVmsd05Udedvo6DwlFVQpvv7G88qq
 m62v7OjfouJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBTfAQAKCRDCzCAB/wGP
 wMqSB/4p3EefATkSJOp2LT+eaEEcLEPE9eaEssAG+AMtZ6FabUpkWgb/YEFfTk3mnKSswvNwWa5
 5p8Fhtt1ksA/SZVBw6//aiLk8sDpMsbfDli/6VWnGmDkud4SQWtMm46BXu2f/57+vBBN3h/Bj7C
 iGUSvi7jDTSd2hWFgFb1I/puJg1pfQZq5PJF2D8rVNZ1Kxo0y1s4R5TqkIvHVjRmvOiSNOBg5VJ
 138bd/m0O4itiHDskJgdLKZVVjTFXh7KI8H81tiESAYrphQhy5AM4/XZo+VXtTcnFe5inGNKaoI
 nFQzAQhb37auUXkEbGP9np12Kstjjh7c0bj0qzc/KFNcgzUq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix 18-bit raw read for 18-bit chips by applying a mask to the value
we receive from the SPI controller.

SPI controllers either return 1, 2 or 4 bytes per word depending on the
bits_per_word. For 16-bit chips, there was no problem since they raw
data fit exactly in the 2 bytes received from the SPI controller. But
now that we have 18-bit chips and we are using bits_per_word = 18, we
cannot assume that the extra bits in the 32-bit word are always zero.
In fact, with the AXI SPI Engine controller, these bits are not always
zero which caused the raw values to read 10s of 1000s of volts instead
of the correct value. Therefore, we need to mask the value we receive
from the SPI controller to ensure that only the 18 bits of real data
are used.

Fixes: f3838e934dff ("iio: adc: ad7606: add support for AD7606C-{16,18} parts")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Jonathan, I based this on the fixes-togreg branch since I assume it will
go that route, but beware that there is a trivial merge conflict with
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=3b5b55ca940733b7b533fe3137a307ceacb4fb90
as that patch modifies an adjacent line.
---
 drivers/iio/adc/ad7606.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 703556eb7257ea0647135c4b268a8ead93115c6f..8ed65a35b4862315431a4852453639b4e056178e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -727,17 +727,16 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 		goto error_ret;
 
 	chan = &indio_dev->channels[ch + 1];
-	if (chan->scan_type.sign == 'u') {
-		if (realbits > 16)
-			*val = st->data.buf32[ch];
-		else
-			*val = st->data.buf16[ch];
-	} else {
-		if (realbits > 16)
-			*val = sign_extend32(st->data.buf32[ch], realbits - 1);
-		else
-			*val = sign_extend32(st->data.buf16[ch], realbits - 1);
-	}
+
+	if (realbits > 16)
+		*val = st->data.buf32[ch];
+	else
+		*val = st->data.buf16[ch];
+
+	*val &= GENMASK(realbits - 1, 0);
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(*val, realbits - 1);
 
 error_ret:
 	if (!st->gpio_convst) {

---
base-commit: 609bc31eca06c7408e6860d8b46311ebe45c1fef
change-id: 20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-ed035c488eca

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


