Return-Path: <linux-iio+bounces-7133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07699924027
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66E22879FF
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D981BA09C;
	Tue,  2 Jul 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIb2vZUI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15501BA06C;
	Tue,  2 Jul 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929627; cv=none; b=VoD5cDf53DglMeUkN+yilMiIO7enCDaZ1KAnLVC8BCnZwxKCFVO9CC7TVcxydg7FjVXj3EnJPdJ6k4rXgZ69Gel/AkpeXBw7ddWUSnP81RxJRtVqo5eCZiAYo5+5WcpRCJzV9ON3mIprtShL3s3qGFH6XXYMyH3J42T+d0sntFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929627; c=relaxed/simple;
	bh=H9NhAIwlXxLajGf/VmKJUno8Ov59oH1ORxg5Wfd0ozs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcKTlEygsdv7L9k/yCUDs5IZ1/1YRUQsVrCk8xG8ARsa+SHT05qUAR0+Ra6HUPWI7yw8k+wD+LR9teJi4/oOtGEc0nAt6yzx+LPX0deFghBdksALGcBu/1VsBTsJxpmtpol5s9H48jKh7YO/bNdatXJdvLyl0PfnM/f/VfLCMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIb2vZUI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706680d3a25so2929984b3a.0;
        Tue, 02 Jul 2024 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929625; x=1720534425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyCedTW1nN8xvbHGjz0S0E8d6Bz8vQg4lJTv3rxgtV0=;
        b=EIb2vZUIxDbZMWp5sufZAmreng7srr1SWhYLZk881O3Dio4M99DgJ2QQBQc8PmWFpv
         SpaSvbVDjHPwgcj+MwkZlZ5xYeGA/bD5sMositBYlnYJx2u0hvWoZJtO+JasM7KDjHdZ
         upZ6kfyzAJr4JO0YYg2ygdvZQ50UVxave7YJyPrN6bO2s9U/wzhJmkC0iuAgi8huoOPB
         6XBKRzvLHaxiDJH/vCJt4UDhH1fiF6VL5Ahx3vodUDk+uCwXOr0BBnmNeK5e1VMQWAVK
         eNVvPFyGfpAIFAVddRaXUl0bRaf/hatlF5HT6Gc6tc6uuEccfvABrVlSMmh7zxF+AVH1
         vnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929625; x=1720534425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyCedTW1nN8xvbHGjz0S0E8d6Bz8vQg4lJTv3rxgtV0=;
        b=vqBf4EO/Lle6+B6v3UIHX+OlWzuMftXPPTHIubVbxXTTRguzFZ6+zO4B8jR2rrmlvy
         wQXNwxVyrn7lKNqXKZQwqjB/AJbhmB1O2tRC8PMOQORct2BrOngS8y35WG+Aw3Ki/hXX
         r2ImmDgnXt++uF3RI84XAaQh8y9lFJqI9kZ3WcfoZncZILTMKmjOkvpD8+6w3K42nW+V
         kMT+HEuVpAweXNoFUwUMwnlnietFK6NJHQ7cKhdP+eQRgu9z7gjfkufjzpgDjHbkoZ19
         8PytL0p8jQEF8adCfe1wsN35mvuOvTynjQVsblGiiaSqdW7kIJQdLABJPKrBWGCBpc2R
         Et3g==
X-Forwarded-Encrypted: i=1; AJvYcCVauXopQ14/EkZwqM4tgp/hRtBfX0nm2kxPwolHNZDVqu3YXRGvKJJisScuoDGSFoOwJrbU2fzc2fSg/NNWXTZjfR0dKr0YzOUAgHWBQAbh7lpokFQPvCHj/gfvEH47suNrk1qgPXAn
X-Gm-Message-State: AOJu0Yx8LsLGyrgLLOrT+ehxb9lHEQxoPSXb5MN3RIR3jJ4XvwHATbsz
	By4BibzSMlJRTvPg5Y/AiEGn2K6hluNdQmDSQxgv+Tu+4mD2qVYk
X-Google-Smtp-Source: AGHT+IFsMxl2d//GSQ0gil6XTVnnnuoWXcqMx7vWJKLX0ReZ8Dr93n06HeRw92A+zAYQfnbb6bJK0A==
X-Received: by 2002:a05:6a00:1c82:b0:705:a7a7:b31f with SMTP id d2e1a72fcca58-70aaad4b080mr7667629b3a.10.1719929624682;
        Tue, 02 Jul 2024 07:13:44 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac1e1sm8547872b3a.163.2024.07.02.07.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:13:44 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 02 Jul 2024 22:12:32 +0800
Subject: [PATCH v9 1/3] dt-bindings: vendor-prefixes: add tyhx
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-add-tyhx-hx9023s-sensor-driver-v9-1-c030f1801d9b@gmail.com>
References: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
In-Reply-To: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719929607; l=891;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=H9NhAIwlXxLajGf/VmKJUno8Ov59oH1ORxg5Wfd0ozs=;
 b=skeKvvg+8gqT6ULjhvHUNivPu74+26iALix1/Dd9qpitYIwVa/G8GDhp3wEdcwx3OAYX88Hb2
 7zgFdl+JUXEAxApSbkjt8ECvNW3XTVdfuHXmzkbAuAh2J/0pn91K4V1
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
index bbae442d01d2..d7d15c9f30e3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1529,6 +1529,8 @@ patternProperties:
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


