Return-Path: <linux-iio+bounces-7175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88CE92466E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 19:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93858281DEE
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E971C9ED5;
	Tue,  2 Jul 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X9OwpT/G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1FD1C0054
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941654; cv=none; b=Bo/Ufm4LDR71X0+dqsC/PKwNLtb2mSbHltX5kKFSel3lth7d65w0nPiGDDzTFZ0p3S/wUCpHRjy2Y+LLRYfXeinMbJEZ/F+YuU8U3SYwAsOVKmvEV+mLSof1gd77pXdRRsRDb49l0CoDBMVMZf/hJvGcnSKpNznMATZEi4d+Nh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941654; c=relaxed/simple;
	bh=nGzK2S78m0bky0xL6X4TlkILzMXZbw7Q567KAtyItso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XaDHJwYqPIBGehu07n4VSf1JFMNmmHAjO4rLU6qg5OzojGNzcT2ChjjhPBn5W9Oidkoieyn0Ii2FUoMruaCzC+nGlSJZHhwVCf5gtId5lit3qYjc7AIlsE3Tyu22kjj+dfN1Ia9mt64GAywQamHmXj+vwzSm42iYlo+X33lEAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X9OwpT/G; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cf4ca8904so7345957e87.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719941649; x=1720546449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqVxrCmaqTdd1OivUsUaCiiNGBxmmQjkW28fKPO8hWM=;
        b=X9OwpT/GOyRvGYNRAocpe5BorQ35LZ8cPEWEfpTR6VVmG/PAiBclZWeABUcaqBY7qh
         LDPrH3wmj2M9egaLNVE0QXywMfeRljb3nFTSSHVEA2Fq6BttdiEj5Wg1LvIhwsPo3FQN
         YSjl8QJTLn5CachTFU1FE9zAyxIYewQNASAbijE5rrbCTLor6iymiVQlZGI3yH81+hre
         hmhcxSoPQ6mjcnmwbRKMq9gwBFiRFv6XD3dcXiah3zLKRFZiNea74dhik8S2mz6Ho3lL
         t4WG2pmXB7JXCj9SJxI9Vc/mfFhv7GyeVtS+zPSNqggUVVSPskvwEtL0EMutxK6dI13F
         TPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941649; x=1720546449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqVxrCmaqTdd1OivUsUaCiiNGBxmmQjkW28fKPO8hWM=;
        b=MvErgNKsAg0wnRs1Ovoe4jsFCZtCQwXgDBm2i7b328W3sGPCa7JXg6CK1lq+ychWq7
         cnfyOcToiPkUNjnXr1Owsz2hERk2pXFsV8daoo1qWMn1ll/DNwf9DzbLoitfbeGvdnb2
         ceZXfn8Poo9miTsZ+txRIb6OmKUuyaNUBOTuCtyvRnJ9SXyi1CnJ8dISqc9rWlSNmSfb
         +qayN+tVLSHOFmoFyFuYo6SYYfiOzrvfe21aR4Q/mlwgdxF2YVxhxZi8UeEsz7rTcnfu
         MpyaTyQJ9Pdh+Ds+ToXbDyK5YFuj8On4uEHEiQCdg/23vnXCCnWM7VH0RKagrsFS0CCm
         ewqQ==
X-Gm-Message-State: AOJu0Ywn7dIWEM+v9/BlB0Sb0xQzcUxRq/nvuN4lhpyrsLsFptIJNVyo
	dY464bj5w+Q0NxqWMHq6wFtrdEQEOul2N/IEhOd7gyoM9qrBEfyQeYQAH4flPu3lemGNXiqROTX
	1
X-Google-Smtp-Source: AGHT+IENS/hi3LdGvHKX10bpeZAX/pN6vBzZfnzLA+VvEBpaHsDKR8zQxnIVkfkUxagS9XQHEEGRZQ==
X-Received: by 2002:a05:6512:3d1b:b0:52c:b008:3db8 with SMTP id 2adb3069b0e04-52e826898e6mr5673752e87.38.1719941648842;
        Tue, 02 Jul 2024 10:34:08 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af59732sm207594485e9.11.2024.07.02.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:34:08 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 02 Jul 2024 17:34:08 +0000
Subject: [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix example
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-cleanup-ad7606-v3-4-57fd02a4e2aa@baylibre.com>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
In-Reply-To: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0

Example uses adi,ad7606-8 as compatible, but adi,sw-mode is not
available for it. So remove this property from example.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index bb716182db63..499b6ad5525a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -152,7 +152,6 @@ examples:
                                            <&gpio 23 GPIO_ACTIVE_HIGH>,
                                            <&gpio 26 GPIO_ACTIVE_HIGH>;
             standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
-            adi,sw-mode;
         };
     };
 ...

-- 
2.34.1


