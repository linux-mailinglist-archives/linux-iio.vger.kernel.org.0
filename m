Return-Path: <linux-iio+bounces-14859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5338A24D9F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 11:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0681884475
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2025 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D51D63D5;
	Sun,  2 Feb 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdZVIBmA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E371DA53;
	Sun,  2 Feb 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738493404; cv=none; b=JBm9Sdbg5zhorRqFBtEDUtZ6HLMZ5+MTG7MtyH5O4Qon+QR23pv8FfpcsePVAi8cvKRnIkMl7DzLGPcGQ+f/6sCAIh2sS0HRVEqily30AwXjiQASSCzN4CFPcUJ+LhrwXdH7tmO/y/NESLGm9cibchmZsJxNoo/yU30Ygr8KTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738493404; c=relaxed/simple;
	bh=r0Icp78Gx1eXekt43NNQ6V014oRvWvzYcfZ/4xJrZ6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AjJGbyYmMEw5rAKNPYOydyMD5Y1Q+k+GAtxVxTnfalzu+ObchEcaRkNFnELWs1sGa9OJTOipHYiAMceLXdqNyQB9KF9DwzLERRiAT3ITOnVuf01h+GNLLJ+3OHUvTv1CzZXQMFExugz0hkR3yihqUeBSFsXH5Wo3ennFQQ0PChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdZVIBmA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21634338cfdso82712595ad.2;
        Sun, 02 Feb 2025 02:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738493402; x=1739098202; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDLBWK5bNDj91qAd3ox+eXVfZ+1ieDJwIx8cpYqNEd0=;
        b=bdZVIBmAXbYnjyoO+yP0OzoWrbdx30xTNplA/mel+YVSpaKHUa8gHjvwV4Fc95ln8f
         BOnrSYF0p0Uip+ubAHU0aExJCBxThRrCt+pSdo5eqMIs45pfRExm9/u+LoqwB1CftV5E
         CncQwZLWejiJqZ84gZxJHZbL/Mwk1pPMASG6C9HbYOXmLluBco2+2vWuYddyg74DEGXd
         REl3TfVHlnNxVjygYQkVYFD3xBYoIqCQzh49rcI/fN0licglMNjzIo8TacoHeavCa6eO
         IMmVigbwTskloA5kcvW9fQQECEeutvC5gqX82oG4+ySbRvlMDX0C0YsEiYquM7Uxl4Sm
         yMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738493402; x=1739098202;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDLBWK5bNDj91qAd3ox+eXVfZ+1ieDJwIx8cpYqNEd0=;
        b=OKcjtB6RzpkLAWRexq6jbMy598lTkG9g+Zfp7KPMqv4aM7zGM/y7X4ZQXwp36Zv0jM
         FLLzCqMUtzIoRcFLA8prDJAQIeLI4hYw4Fqq9szbWISwIhw30Huvjf4t3a21/ePYP72L
         90RqSqIVmDAQ4bijgqDQJPIo+XMf4foG565hL2DAZqpr7gHNqTIaP4JBgL73ZUb8QYqz
         aahdAqGVuf90qsRk2+dkObVQl6bIO8AOJ9FL4yM8K5iy1+GXToWAaRGW7x9T/yppbx91
         wZISzyOhRfxr+u7BVQSwNdxjkgDzL/OATh+Bqbz/WqByzubNNvCq1qu3B4I5Pa9jcMYD
         6slQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1T3XkSKgBD/lzd4W8bOzc2lsMoplxb8yeRFDEu7GW4X4/lwjzYzh0L5FbPc2RT1A6gPrnw7/k7Hc=@vger.kernel.org, AJvYcCXa5sx1oU5xx9wl6PZSKcG7HQXtaaf+ClaMQFQh8iScdpQVFkE1xd8bOg6d+qLHlL0OCeoGeAKa4eueCBoV@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxZIBQ6iduxXlZTgh9EeOWCFGsVHtDb9EJv9CB5YH1i7BUAEv
	tbgmrRaaQ2nqSdRg51dr8aafsP5PlEJokJV4zWgA0HN7o+0PkhRl
X-Gm-Gg: ASbGnct/P5E5xzV+6dZ0tQQ5MZEzsmIVQtcwJvoWMGCFPMP9TXdt+mu1OJOb8O987ie
	Y2JVl/yUd4vMSvqA/auBkELdYrbtYOPoWu2sxDJ0fkAYAqBHhlZdz2LzRf9T91mbjb5h3HIjsdz
	6FlAJtIl8JVw1MOBlV1engX4gzfMe6g8Vgwck+Lk+cyTjqeiOTDM5yKCpX2tESI8IXzIxsz/n7A
	0WividNIvjv14z425ekn0wWAu2IMp/BSoe5m+yuxxIZN6fJZdIHKj7F7fQOrHAL302wAZtPFKUa
	k42gWEAovxCBCepkXdpQEpfj
X-Google-Smtp-Source: AGHT+IEboNMAKyZLzpu8LLUCY8ncsmBNUi2i4ZWWqnwEjz7dRX9GgIQg+zto2IscIAJZB6+mYcacOg==
X-Received: by 2002:a05:6a20:438c:b0:1e2:5c9:65e0 with SMTP id adf61e73a8af0-1ed7a5ee2dfmr32684730637.32.1738493401760;
        Sun, 02 Feb 2025 02:50:01 -0800 (PST)
Received: from Emma ([110.226.176.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe856951sm5892384a12.34.2025.02.02.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 02:50:01 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Sun, 02 Feb 2025 10:49:58 +0000
Subject: [PATCH] iio: light: Add check for array bounds in
 veml6075_read_int_time_ms
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-outofboundsread1573409-v1-1-5e3dd97a24a6@gmail.com>
X-B4-Tracking: v=1; b=H4sIANVNn2cC/x2MQQqAIBAAvxJ7TtAszL4SHSq32ouGmxFIf0+6D
 MxhJgNjJGQYqgwRb2IKvoiqK1iP2e8oyBWHRjadLBAhXWFbQvKOI85OdUa30gptemtNq+2CCkp
 8Rtzo+cfj9L4fTbZJmGgAAAA=
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738493398; l=1352;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=r0Icp78Gx1eXekt43NNQ6V014oRvWvzYcfZ/4xJrZ6Q=;
 b=AEQ4EcDS0Ri2XtBNFp1q29X3ZEnH2Tgo2e0W3ylx1vgbFiIGttgxMIIjjADlvD/HWZxkRhpY0
 p2diVJpR0ysD4OXJGPdXJYVHlmPM3CYsAs2euCD2vQd8K5/L94WKjxU
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

The array contains only 5 elements, but the index calculated by
veml6075_read_int_time_index can range from 0 to 7,
which could lead to out-of-bounds access. The check prevents this issue.

Coverity Issue
CID 1574309: (#1 of 1): Out-of-bounds read (OVERRUN)
overrun-local: Overrunning array veml6075_it_ms of 5 4-byte
elements at element index 7 (byte offset 31) using
index int_index (which evaluates to 7)

Fixes: 3b82f43238ae ("iio: light: add VEML6075 UVA and UVB light sensor driver")
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 drivers/iio/light/veml6075.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index 05d4c0e9015d..a892330582f4 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -210,7 +210,7 @@ static int veml6075_read_int_time_ms(struct veml6075_data *data, int *val)
 
 	guard(mutex)(&data->lock);
 	int_index = veml6075_read_int_time_index(data);
-	if (int_index < 0)
+	if (int_index < 0 || int_index >= ARRAY_SIZE(veml6075_it_ms))
 		return int_index;
 
 	*val = veml6075_it_ms[int_index];

---
base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
change-id: 20250202-outofboundsread1573409-378997439be1

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


