Return-Path: <linux-iio+bounces-18561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD842A98DAC
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA60445B20
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9D2820CD;
	Wed, 23 Apr 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbS6h6Gu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F066B28152D;
	Wed, 23 Apr 2025 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419640; cv=none; b=aX6Ur4ycx82SKmwgVvqk5KByYVT+iR5ZjE0C35Y4jj/1f9rN3L9tCL6gEjjhARkY6/J5WiOyb8kAKs/rSDQVICxRUWlxUWcLEyofJF2A8vFg2aGNuXuo9OKkOKf8uAw/5yZlvmY9Ged3O4aSAfzjSuQL78msohETLIg9d6sroRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419640; c=relaxed/simple;
	bh=o9rko7Mal2eB/MUZ2Oa01bIuz8dWUsyCQuiKuHvbZLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xbmhb8+wffPFQxMP4iuAF9j6iE0gbY++fHm+qS5WczcC6HH0ySee9Qm8qn8JeGNtjT0T2SH24VKz1AhNXgAvuzd78hUQlvIR1tnKI/LWCTCoVbH6aiKCiyIeFG2oA8fXb4vrxzz+kQFCOhaLeCOu/Q8zVzmZ6jxsFkofYTZFbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbS6h6Gu; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54c090fc7adso6986498e87.2;
        Wed, 23 Apr 2025 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419635; x=1746024435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FTG6YAFpavOo57Q/QlOcqWA0covw0d5GqnQeh6CN/o=;
        b=mbS6h6GuNAp9XYXZxUAZtrnq+YEifywmPuhuLfMUuGI5JRhR7h2W58V9DyzOCU9ycz
         3TSYn6L6CX2f3gSF7AnRZ0BSK8gqh5MWsZo26wrFRhwOUypknHzBZVV/t5HUx++z6EzT
         cVw5+e9QwIfM/IsMp5UP9m8aSU75V0qYznBjo4dVWGMpXxAG5cXNcBz3YGWaJ7s83LNl
         7MZUGVt9BfNc/QBVZT1lhh7kZoRCm13uMMhZ1TZehuPyUK2PHaTREVBzE6lJc4oWDNX5
         46ZrLWLIdBxhqxifdbkmV24aL+0J2nJOGkDnwnzqpli3CQjPbmkYK93l/9UVQjaUBKit
         qHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419635; x=1746024435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FTG6YAFpavOo57Q/QlOcqWA0covw0d5GqnQeh6CN/o=;
        b=tuwmmynO/Bd6//5xNGHuBB5K4Z5ymizuqDhN/ziez97blmNRlDVJhdEVaAYvS43g6Z
         L4DT96ZazYSM4PPkooTzgKh4nbzQJfrI/S9dLST7NwHPBQ0XSMa0ELwbjCS4hcbg42ua
         uHcblWdeI43RX8zVhx3A17TOd8R0zKU2ruAdAhDj52xt9YeWVcTr3EvDC2QWx/AHGw4v
         XbNNdyLIi4U5oQofhwbcd0B0/KHmS3FOU422NAf8l1KC2pyKJ/Att16xtOORIfT1HX5+
         R6TxIOEtJPlClKDbhQB97Qgdg3K4OdHE2MgHqAWNIZB9F38pVVHixOJqlPpDXUaMCU8r
         VZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCV7S/aF1iIHQKfz8OmaPWmj9iy/CmzGY9McTHqNGA1FFaNHhgnPiuqnqVL/mGIISV/qonFlh2z2AVHpi936@vger.kernel.org, AJvYcCWPzj8SeXyEoek8rF0qBFMlq/ojvYoEPuGXuxABtulfBvK9HoapcjeO+lfd4fV25OstNBVG7dk8ysxm@vger.kernel.org, AJvYcCXc672/1uq/xHhof2G1amWe3AerRhGU09LkdWt8b2RQBmSH4ye7yesOaF8HJZOKWpvbwqMmDZFBOY0F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5u78q4cHtXcd9hF7q5rbanOXPPulod05SQHrC8Xoh7NSn5GZq
	XqdbR/CIgc/sQMQ0/aPo7yYWh8Dx206n4RSIgUivqSTe/A0reQH29XkpWBUAqDI=
X-Gm-Gg: ASbGncumgrU0ju9WixL7k0K/CxZnipbLhcSVUuDavky/SI0PXJi720hlbKJdt879/Zb
	tbMFG2dsalFGWDdxO5QYJfyfcObyn5TDasPY7o3PLmGOOkFc7m3kx2TsaNiSewk38cSBq4t+Xry
	xPUnHL7GQjiCDmM0+L+hn2g7/yiqfQYITwIU43R9sajg9rq0rvHx3qO3iZH+mxEjRARqJyO/KGP
	L4zjV/H9FR1S8h+EswHsYolh9uT0aWQObQlbXpy7DcQYWw4oFeSqFWuDD/9sP7JMRekAFkZad2c
	3uTdQEfuyGiPt67o/1bIICqfm6zyBvZmyeIUYTiVzaSbJX2p2jIvJv/yUB2yDJtayCIwgb6vVcD
	l0JZJmpkZ
X-Google-Smtp-Source: AGHT+IE2NCMhEfdxOrjrUQAK2PsxdjD4mqbJKZnA9JUQXHmxAM8QeFCCnSVnA2orwNV43NAcTBXVnQ==
X-Received: by 2002:a05:6512:39c5:b0:54a:cbfb:b647 with SMTP id 2adb3069b0e04-54d6e6589fdmr5586411e87.37.1745419635280;
        Wed, 23 Apr 2025 07:47:15 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5f61afsm1598498e87.246.2025.04.23.07.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:47:14 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 23 Apr 2025 16:46:50 +0200
Subject: [PATCH 2/3] dt-bindings: iio: adc: mcp3911: add reset-gpios
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-mcp3911-fixes-v1-2-5bd0b68ec481@gmail.com>
References: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
In-Reply-To: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
To: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lukas Rauber <lukas.rauber@janitza.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=o9rko7Mal2eB/MUZ2Oa01bIuz8dWUsyCQuiKuHvbZLk=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBoCP1kmxG8US86m/wfiOJ3qltfdRuJQ7UZElVgt
 ClakrfeORmJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaAj9ZAAKCRCIgE5vWV1S
 Mr4HEADe8ii7BsXgwiIETI93I7o/gmfkAlpGw1/94KnFe5JcE2k/Ss9dgjub69jqP/3o/WAzFwf
 s8IhXNKOGc7VekzaZNMPfAGdIfn/2WMEiRZp3qe8yD2KLDuSzpiMxAghDVlIZ4KYFnWR5rdY+0Z
 wgi+G3O1sTCr3en7/RbpFKl8uWZWVgSTsTJA98u0T/ENpvjjBFtHBg931ZtZ+8gnl5oSPPk9OXi
 mfmJeosghexPIu0nXS7XGO9h6RALfM3kfXp8IGUMyWgBlglNtzIdu0kD6Aiq1UyrPOOjOLLbpyk
 Ws8jNtCGmIoDCidID1DC+CkFlVIR/AaOlY7N81JPiONMH3clDJjDZDHrPOEZ7JKneX0RTLGhjHN
 o7RJXzs9KFaohVdwTASfwkjfJFCAfuHIFwGHqh7a/ddIplTRIWbskJ7/1Blp5K033UiTNA2j8VZ
 P/TENLKxUuoYrNuFGfQBJgNkaUblN84EOlzELfAPJzJE55BZTZTIBHRDTHdcuxI9JZqZWrbI3P1
 xD3rt6Ymi11uUi3EX/4kI5sJWLhkRR3XH8O2THCA115c0sfE6Y1xDj8TwdTCEPXv3yNJn4RqwGT
 Al5AKVZLViA3TI+RIQdNwQl5LKPR/yQ+PP2n9hgagvYbjjYEEwWDAx/gmHpANqay0hmvdxYHAfJ
 wUwyYXJUu4+yDhA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

The MCP391X family provides an active low reset signal that is still not
described in the bindings.

Add reset-gpios to the bindings and the example.

Co-developed-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Lukas Rauber <lukas.rauber@janitza.de>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 06951ec5f5da381a9bb942d0ac7416128eebd3bc..3a69ec60edb915ae16312b94fddd32f5c87f37a7 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -32,6 +32,9 @@ properties:
   spi-max-frequency:
     maximum: 20000000
 
+  reset-gpios:
+    maxItems: 1
+
   clocks:
     description: |
       Phandle and clock identifier for external sampling clock.
@@ -71,6 +74,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -80,6 +84,7 @@ examples:
         reg = <0>;
         interrupt-parent = <&gpio5>;
         interrupts = <15 2>;
+        reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
         spi-max-frequency = <20000000>;
         microchip,device-addr = <0>;
         vref-supply = <&vref_reg>;

-- 
2.49.0


