Return-Path: <linux-iio+bounces-12213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B90F9C795C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533631F25AD8
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FC200C84;
	Wed, 13 Nov 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ACviE16K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AF1E1A28
	for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516930; cv=none; b=EaTN48jwwAu0PRrXQrBisy5jZTHHQfSwPPZk1/zYNKke2vCDqsX+3EzFV4Q3WYTcHqi7lckUd0VDLkH99FNI+h4b0uEXflxLD83guWQ9qIBzarQxsBNP85cai0cHXkQRUWzNNiNktD6acOUU7KNHzEZiUlH7mCNkInonWfFFb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516930; c=relaxed/simple;
	bh=FcOHKxBF8nl/v4SIQ/tCUbE1JuAOflWFIy3yGdifeC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YyqXehjYm9Hc7dI8GWK3z/Yx/wnkbvuobSRnt7lNm0u4jya4qXVxGg/adr4gauNAUeY1NrVPIYYP+aX2zKp8OCFzqtsrADnijG39OY76Khd98fEDQvYXO0OVKB3DtSMw0O9awdJxSIHo91tIaGHE5lpap2RJucsnymUl48VaipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ACviE16K; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288a90e4394so3199949fac.0
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731516927; x=1732121727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSikvYecjE5L7Fz7wq5gaGm5AXMewltD4jATzudM75s=;
        b=ACviE16KCe48ui6sPB9i/aKwNKj4q6sNYx4AMD3mL1kPjU7SEBvkAee/GmI4fkg6/Z
         h6b0oP++hm4lTeUzO0P/0fdGPhMJogi2zr4SXPJfG4ajPRsbq+/MG0nxArtZ/CjBThk9
         a4WJYaXcMQPsYG8t24OP+brte6kju7LTJO4yLsFKSwMJi15THpqEFn8iAFr9mR+PCvZX
         hQSclRmJW9IsxaDdtOJZj2q6J4O9JZT6Ykq/cPqWaJ15aJUT2OYWoiGZP01gng5GPzhA
         T0VRxfV//QAeyVSBw8XJISsEVhsqv+YyvTc5ZZ2f+Ke/+ALnteQHeH4e50Dt05pwKMar
         UjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516927; x=1732121727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSikvYecjE5L7Fz7wq5gaGm5AXMewltD4jATzudM75s=;
        b=SX6x7Q8Bczi1XD0Lpwr4pCudM7VKJPzRgwyEFdujcETaZkd1PJZAFWkjsW1PoktmDM
         JmQmeeM+HJc3Rp0y00h3+Q5wL9JVzDa9hHicEJgyLGKgu/gY5oA15gVZ6n4+cPuVL0NU
         +zOZTAMuYGdYshjG+8hCb5AYxsM26yM78PQi4NXepHr3UTpRAywvzw1lagbe8lYx/D0H
         jE48sM5dVCTSHSs4e1c7NUO8xn1pRqLfFE8OyByrv0t2Rn11whPhLRa9tp3PpTdzhHa0
         qA9QdrAK0tvITERvf5D4M0Z7efnuIVAVfJg69DejOla2WZXK6hcH0cELpoPj0euFZ4QZ
         KpGw==
X-Forwarded-Encrypted: i=1; AJvYcCV93WbRThjL5FdK3Es5CT9zVMKa1XZFhI0p31FF49tE1R/9A8c9xP7VCa76jBoP5LU5aH+P12P7UhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWYDMvxFPJvpVRFgpZnqjZNphLdiF7lFfrOan0LtBsyyZdtCL
	ZaicCnrJzOVvbxHhKSFnZ3PRoCDGji8iE2ASdaZYF0nNabKHVYU0Gc0xgr+LJkA=
X-Google-Smtp-Source: AGHT+IFJpZjge+IOMpaNgashhcck+YSg0qirNU1tLokH+1+ASRcY+i1i7QixDL8eiYp4UVv+7gSOuw==
X-Received: by 2002:a05:6870:899d:b0:284:ff51:58ad with SMTP id 586e51a60fabf-295cd216d11mr7802349fac.27.1731516927381;
        Wed, 13 Nov 2024 08:55:27 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8fe5c61sm873432fac.23.2024.11.13.08.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:55:26 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 13 Nov 2024 10:55:19 -0600
Subject: [PATCH 1/2] iio: adc: ad4695: move dt-bindings header
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-1-aba1f0f9b628@baylibre.com>
References: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
In-Reply-To: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Move the dt-bindings header file to the include/dt-bindings/iio/adc/
directory. ad4695 is an ADC driver, so it should be in the adc/
subdirectory for better organization. Previously, it was in the iio/
subdirectory.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/iio/ad4695.rst                   | 2 +-
 MAINTAINERS                                    | 2 +-
 drivers/iio/adc/ad4695.c                       | 2 +-
 include/dt-bindings/iio/{ => adc}/adi,ad4695.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index 33ed29b7c98a..9ec8bf466c15 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -101,7 +101,7 @@ The macro comes from:
 
 .. code-block::
 
-    #include <dt-bindings/iio/adi,ad4695.h>
+    #include <dt-bindings/iio/adc/adi,ad4695.h>
 
 Pairing two INx pins
 ^^^^^^^^^^^^^^^^^^^^
diff --git a/MAINTAINERS b/MAINTAINERS
index e69d1632c382..3fd398d6e64f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1268,7 +1268,7 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
 F:	Documentation/iio/ad4695.rst
 F:	drivers/iio/adc/ad4695.c
-F:	include/dt-bindings/iio/adi,ad4695.h
+F:	include/dt-bindings/iio/adc/adi,ad4695.h
 
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 595ec4158e73..3c2c01289fda 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -30,7 +30,7 @@
 #include <linux/spi/spi.h>
 #include <linux/units.h>
 
-#include <dt-bindings/iio/adi,ad4695.h>
+#include <dt-bindings/iio/adc/adi,ad4695.h>
 
 /* AD4695 registers */
 #define AD4695_REG_SPI_CONFIG_A				0x0000
diff --git a/include/dt-bindings/iio/adi,ad4695.h b/include/dt-bindings/iio/adc/adi,ad4695.h
similarity index 100%
rename from include/dt-bindings/iio/adi,ad4695.h
rename to include/dt-bindings/iio/adc/adi,ad4695.h

-- 
2.43.0


