Return-Path: <linux-iio+bounces-6864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52F2915C3E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 04:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810932851DF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACF45C14;
	Tue, 25 Jun 2024 02:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE8YH9uV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0042345BE3;
	Tue, 25 Jun 2024 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282690; cv=none; b=LPG9dZd1V71wHqx9qlqcY6vVruXWNXCKIePwWKQNsTrk5nI8iPseM1sDRaQepdApKI4xUsVdJ0oJb2smu8G7NtFlNCZxZLHK7KKdw3oXTgLcRcKinO5LS5G4BHDM/7SIvXC5NTO/2jreGB6zsQZIO0xS+F0+g8p0ObDkPTopyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282690; c=relaxed/simple;
	bh=Yllm7Rb20wBvc3voJLV8/YDizQTD6fUDDo3niZWB538=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmXxzm4SALafYJfOsr6M12mBoyf4ZTqb6AI8QOXTQaxnGgl1y08FQAFSmZU6VxdatvtXglTs9uQOT3uUPEZslZEY7OpV79EeAG2k4EIPYf8RC8yemEtISvMcJ0ZdhrWj3wl1+P7wpw8QVEtHFeyiHJOHtLUkRwkdqy0Iw+4Xoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE8YH9uV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7024d571d8eso3954278b3a.0;
        Mon, 24 Jun 2024 19:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719282688; x=1719887488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmBaOej5BG+mP6vwRxETA+SYJI4odB2Q2w/hmSlshLI=;
        b=cE8YH9uVmL3Cfze7siF9ZOYLTBv+2e6Q9OrObcOKr1lgrWpvEzGcXQ++ZTWn5/DC0V
         vD9+rYacVg53ToR47p6EhhzWPtqghw7EPeisW1PwfsWo2PSX1f5e12d5F/QU6vM4QDsZ
         tI+3nAqMY5Yvsg7vcuv3JKwX9cmjrBzTFvU2i4Iw7w2bQGAuyu1E0GJZubcSnu/heDfr
         +owFHlAg/yt1LtuNLynh/ys/yQkHHfF9PffT4G79OH6vdiukgr0lLxUso/rAAmD3V7RX
         PSwlk8EcZzbLAjkkyAkQQd3rFeyc8/5txYCMVQyZctysC8eWiw9LTY/AJ5cVTLm3cw48
         3ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719282688; x=1719887488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmBaOej5BG+mP6vwRxETA+SYJI4odB2Q2w/hmSlshLI=;
        b=bhZ3lKnl35GCpTniEQ5vsHzIFlalkanhkOJbZmDJfayQj5EujBIwRDzCiZ0TFmGoXp
         IPFigCQD3zmy9J8OjDyfz94IRlocLM4WMKTc+eJS5STz6neH8RXRXQnD/0iwy0yK2tUI
         tkdmjDPM/vI+w/SqU0t6K9QAezYhg/q1y9wGH/dFb8jlw02EpwYTcqi+zdtdcLY7Hiyv
         Morh6IWQ8kYvE3cGVzDvos/0tRVFsFv8A6NMyOmagl57EcgN9ybLVK0qGiY2FYQkU7BS
         ck3O+/TyiOGu7kSDmfokNXWIfNV+MmFCXA3Z2TM6a28JoDg+Jzq6CrjB454rLwn8znrU
         kyGA==
X-Forwarded-Encrypted: i=1; AJvYcCX5OOazQdFCF5HclPHYOfhIPhGsVVq0FLAKJyvZuWFoC4OIu1i6OPvrnjLHWXXabVaKxMfnkVaHmU0ZlR78hXWToHzdtincgEr21hlL6GQCpNw/TBFPqynvUGBklQIADK+fCE0cvb4n
X-Gm-Message-State: AOJu0YxnzOHYgibPvcITBM6E9tdOic+yKhtpTC4aYTFcUYJ8miTH0Dtn
	TIYiMqTvhOgHDcB8wVfOZwUxOgceN3wubTlezNxMaNI6NdDh0MM01B/sJw7JLnOPxmP4
X-Google-Smtp-Source: AGHT+IHTWK3aI9e1oAcIJfcL2LqCaV6iJNBaEhvyvZDS7Xkr2Hj5e66ah7uDTtKiRbY12xe/mq1j9Q==
X-Received: by 2002:a05:6a00:22c8:b0:706:720a:72b4 with SMTP id d2e1a72fcca58-7067459db4fmr9876151b3a.3.1719282687756;
        Mon, 24 Jun 2024 19:31:27 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70677949b97sm3582945b3a.140.2024.06.24.19.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 19:31:27 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 25 Jun 2024 10:15:10 +0800
Subject: [PATCH v7 1/3] dt-bindings: vendor-prefixes: add tyhx
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-add-tyhx-hx9023s-sensor-driver-v7-1-b1d65b221811@gmail.com>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719282672; l=891;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=Yllm7Rb20wBvc3voJLV8/YDizQTD6fUDDo3niZWB538=;
 b=gTJR0SDQOAwpOF4stUo7IA0m0Dq2zIDkdljZ8aL99Cug5Y2t01bFf9E+t3vwwZyXDMVokpoU/
 FqSNEe1DhqZCYGEKoh1ZGKDAG4PKZR0nQGyBjU73lMbSA2Ao1T77EfM
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

Add vendor prefix for NanjingTianyihexin Electronics Ltd.
http://www.tianyihexin.com

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..989242da4f44 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1515,6 +1515,8 @@ patternProperties:
     description: Turing Machines, Inc.
   "^tyan,.*":
     description: Tyan Computer Corporation
+  "^tyhx,.*":
+    description: NanjingTianyihexin Electronics Ltd.
   "^u-blox,.*":
     description: u-blox
   "^u-boot,.*":

-- 
2.25.1


