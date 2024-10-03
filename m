Return-Path: <linux-iio+bounces-10066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FFC98F523
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE550B222D4
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03F1AB6FB;
	Thu,  3 Oct 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SAK3orNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D280C1AAE2B
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976639; cv=none; b=XfgbM2T2mGVcZ0Oej/4zbm+E2tvAHmjclp+XmdtcDFKxzmsZpIGzdHc+9kY1Rf2g/ZY0kh6KR9WwzVgJV1bK5gxESq6T+qZp4D+iMrYXY3PIJ1QU4+FqSnUXIkMJ306zuOMHIsMef0ReQdl9rcBqwaf1orpFShsNL/QC04WyrrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976639; c=relaxed/simple;
	bh=Sbxpl1/HIRudbv6w7Jz+mMf9rGjc6ZnOVMixxafTE3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkP78VK4o4znrzFcVn96vWU/zZOb+N5QD7P05vXZsJVFyaTXZxIYmnE65zag1Nqc7k8VNJv8Cw3MXeNlHQFlhqWgHnweYGWHbT3sa1r+5yKQ3WyECH1iS0nKChdmYa26uOM3s5MISKAI+23xw5IMtTZPnd1mHuaP7kPfkcolxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SAK3orNo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cc846fbc4so999245f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727976636; x=1728581436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1niSzI31R+eboWDyEOqEKu8Gn80ccy+m8gzhXKl0a4=;
        b=SAK3orNo9fMk4/tLfp6RrVTOKAFZJNrtSEAnVyBlzm5l8CTlrhDSWw1ZVDmK1tPAz+
         RhFwDxWhGKCNdNpWXiV9sfXkwOZP1DFCK/YWbX9t4ERUAZPorbLt9NPlfKp6asBoQyW3
         o6Gq1gZ+KoUHa+0MpO24phCXXwxKX0+ruG5vSHsrh/0YczoMXmkyvR8Bi0SeHTXN73Zh
         nQdboixyJno3rNaSWJ9d9+nysHQOsgtXDS/6C4VSeu+Skxj2zx5hL9x/tXK/8/GIHHAa
         688nIx7GnXZpcQ77c3gPV+9RU+QnmwoZrYiHQDjFP78KFgwbqeHj9eJV/X4SJZ1ydpfX
         dRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976636; x=1728581436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1niSzI31R+eboWDyEOqEKu8Gn80ccy+m8gzhXKl0a4=;
        b=VLqKZU4odxIAhJnV40FK6AKkKtj8QIcbwJBKAqROt7KcAH0X3el0PuKdasyg7vSsk/
         x58Xy/UZspghefgRzfau2lsKYYtITAw734yMBjOTIuVIPrzi0uddxanTihaRaOaOiSQQ
         Qs+G6HkzVtoxBTLq9fjYWvprvoX9q7iYXo1Vfp0cE3OkE8oMseSOwA8nbMtqzvUpeJvB
         HHQEKXC/YXs3zS0VRf4kiZSQDNMFKh/hQg9XzlrpjrITz4/k+RLBWM2Fjd2EKxhZZICW
         YfoGex1QOtL42Xj4RJOKeAVUsSFt6YApeHOcJW+a4vtHdd83UYkf+sNttNuPZiGKnEgb
         /tng==
X-Gm-Message-State: AOJu0YxGwvzgmtMFfg0q0PGNXByDNkYfeRwfAmYIRmVctHuJFbDBgXV5
	Xi4V3rGHLnfAY8MBBg+7FsAY/HVshsI0FjqgQKEzEKlraU/Tm4W21pH6AETsNGY=
X-Google-Smtp-Source: AGHT+IGmLj/YklOvnhUNqdfeY61DZZOVHxYh/5kiTAd6URRHk+Y+EtqdeCnYAagc+1R7PPdEFEPBoQ==
X-Received: by 2002:a05:6000:4590:b0:368:68d3:32b3 with SMTP id ffacd0b85a97d-37d0e778fd7mr98024f8f.26.1727976636241;
        Thu, 03 Oct 2024 10:30:36 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d116asm1703735f8f.90.2024.10.03.10.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:30:34 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 03 Oct 2024 19:29:01 +0200
Subject: [PATCH v4 04/11] dt-bindings: iio: dac: ad3552r: fix maximum spi
 speed
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-4-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix maximum SPI clock speed, as per datasheet (Rev. B, page 6).

Fixes: b0a96c5f599e ("dt-bindings: iio: dac: Add adi,ad3552r.yaml")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index fc8b97f82077..41fe00034742 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -30,7 +30,7 @@ properties:
     maxItems: 1
 
   spi-max-frequency:
-    maximum: 30000000
+    maximum: 66000000
 
   reset-gpios:
     maxItems: 1

-- 
2.45.0.rc1


