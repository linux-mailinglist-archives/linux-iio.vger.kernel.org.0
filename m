Return-Path: <linux-iio+bounces-6494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4DA90D4DB
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09881C234B5
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647916F277;
	Tue, 18 Jun 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vHcANnZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657B16EB45
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719361; cv=none; b=rqT8qhbiFREHmuQGtQ4IGaCnU5rhnlmFBBAJObqdaBw8DUcuj+szhKGokMfiGCznU0TL4coJ8epXXehWvo/y1D7RDM6EKiZ3z+GYeS/Htjjm+UoW9KTkO5NnKbajNLizB4NUkvgXOAU8WHz668rgZY88yaQ2whPS+aJk7MEmq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719361; c=relaxed/simple;
	bh=cWqIUPEPN7Udkq4+lFTiE2RXC6AoRwx5p3drvRYtbjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmjFDLCChkcioWHsD1kUR4rgaw0VOepsgG6uF0JDxWSP0hI5VpKMhnOSXrrTE7TDZ5ho6TSuVty0d6n2yzBXTa5dd4XeqIJoTAfPzlvnkBNUZG8ojYOXffpmGnEfTz/f01++kjD7mvst5xt1Yq9+0+C8z+Mf44YcDlLVP5wiU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vHcANnZj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36087277246so2308870f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719356; x=1719324156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Wrqm5DzrB9rfiL9awg4tiFTM9PHAHUELJgH4ibg92I=;
        b=vHcANnZjlBkre4EVmaL8tGKwfZYGinBHtZB2QV/GzNNqhcDLAxo+ykSOXMcHZNEx4F
         Q2jxQW1MAR/HA94+Z7CXpcGwyuW5QMQpSU3/wrCdUgtYwykd0/zznidOBimAsM+fMYZF
         5X1/yZEs+iX323dApLuN/qg40Io1Lq9pPEvznmlPNaKKgFIzoyOWtS6GH2IBHjlFob6X
         d2J0c7JoQEOMGjDOG61XLqYS5+76WZFFDRiHDiqWP9xiGc3OxUk92hZnKmUX65HLzVM+
         aBZwcSk7Bhg8EUrwhq4cGb3GzXrqP/cR7NYKyTULfZeVWdQUd6dfBsG9bGpeifWG5Rnu
         1cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719356; x=1719324156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Wrqm5DzrB9rfiL9awg4tiFTM9PHAHUELJgH4ibg92I=;
        b=U2Te2aNwWIJk/zvYcm3ZkAl8MoVJmL+vEFy7RfUuOBbL3/JaB4g7B6qLP8yx3P1gBd
         wn+sccs6LFw5jzoVmT7R1V50IWt6O5Gyc/lvxELC60ZNl0IFghSoLpqAOXCRvrfS9QIX
         AluH3HQAYVMcW6CcyTn0yHVh1313gR4HrEsEM/XBvAJuN2SPjLNZUnE9xOQhp4AGQKzp
         6v2GWInbWzfFrAy1nFMd9/Zy5DxDjHNGAWdt71T6s+BYtUhz1yAvKJfYJofE/gM4uy68
         9vV6WRXmaeW+TzCrSQGyQ4Y11JEsX0u/k13C4CyFw/QYrPvkrreCsOpvE78RJk3pf2J7
         g9ow==
X-Gm-Message-State: AOJu0YwHeIu2AdhMw+G4xIKwq2NOihMtonNg0aIxy6iavz95fAH+yKkI
	3fb1P38/aXR+PGZI9pGwcjrcPDD80Akpv7qaDEoRRAAE0duN9ctXgm/Jc4yOUrE=
X-Google-Smtp-Source: AGHT+IGeSMCl1GadLFgkDPuhpwEcL3FXopw0KUDqKdsouTUQDtdzzlakx+O+Eto4p6nRE0Ptb091YA==
X-Received: by 2002:a05:6000:b42:b0:361:fd04:95ed with SMTP id ffacd0b85a97d-361fd0496a1mr1497363f8f.15.1718719356709;
        Tue, 18 Jun 2024 07:02:36 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:36 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:36 +0000
Subject: [PATCH 4/9] dt-bindings: iio: adc: adi,ad7606: add supply
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-4-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Add voltage supplies

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 80866940123c..e480c9a7c7ca 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -35,6 +35,15 @@ properties:
 
   avcc-supply: true
 
+  vdrive-supply:
+    description:
+      Determines the voltage level at which the interface logic pins will
+      operate.
+
+  refin-supply:
+    description:
+      The voltage supply for optional external reference voltage.
+
   interrupts:
     description:
       The BUSY pin falling edge indicates that the conversion is over, and thus

-- 
2.34.1


