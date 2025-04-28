Return-Path: <linux-iio+bounces-18754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FD7A9E899
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 08:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDB017503C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 06:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB531D8E07;
	Mon, 28 Apr 2025 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbKDWS+j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208231D5174;
	Mon, 28 Apr 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823282; cv=none; b=QP1/2j2YkKHG2ROxrwMJ0LBICpuCx5XwCvrvO9MD+i+aAuTgRuGavVFrQtNd0DvOh9KliH4JZvsTVp2kjHTK0WtJmQaqx/sKpvGls/WdBbCmDoX+QIBye4Uz3/3ETUiiJj+dwfGIp26clou/Ddz0JRGsGA1HKsVnoxGjSpra48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823282; c=relaxed/simple;
	bh=o9rko7Mal2eB/MUZ2Oa01bIuz8dWUsyCQuiKuHvbZLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bGVLI++0kLstWaBzk0KIN3kfrs5M/8RhWn9hYAh0axQvwTlICTKg1m8DdOjGoNnXLvj+QDhulpe7uUSudxbmRm3uhSqxtjeVBr/f8lBXVyQH8RUetv5oXpoBoo2R9nH67u/UC6iDc6puZYrgnaQ3ObkekUIf4Oim74r1+3ko5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbKDWS+j; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso46544341fa.2;
        Sun, 27 Apr 2025 23:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745823279; x=1746428079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FTG6YAFpavOo57Q/QlOcqWA0covw0d5GqnQeh6CN/o=;
        b=nbKDWS+jumqe4YnmjLcxup+mx5xOlOkov5J99jtISNiO1ByS7/vMzAYYzNojcY5N5D
         zCtp6tBieW3kglmMW9s+K9mX4sqZcPE4ABaJ+624FWr2Z/sm2iJS7I7wk5z95KcV+/SZ
         obISwMmzadxZhbE30GNewi5tCI1cfyNbNhyXsOPw+UIYejoLTudr2qqixb3bFR/8iXmg
         6l96dp6RO7nQF2HnIriwydhAUEoRPT0VCbMIaJ8iv1myk61kM1T2sSr+//SrNZ89TXTM
         0pZ9YfeMypBThacMLzTUe3QZo+9Ugr2rZntXi3p78cY+Xe0kvlR6KDBxkXfM6WYTo/Y2
         fMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745823279; x=1746428079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FTG6YAFpavOo57Q/QlOcqWA0covw0d5GqnQeh6CN/o=;
        b=Ak4jUeTuMu3nP4C4fXzGB6zcHIIuFt7BeLn2KnIHcokHTobEPVKMmBEYEH3LnTqNHf
         HkHlX5zLL3f6HONTLSbepGJeJ9xXT4eJXmVdeZd2LwzE2Qs8/xxiUR68AQb88ElxNvLO
         sjxlE10/11LLOozctYq2YZOZiaF9heJT8bxqn7CDeAUoGzWrH2czYbitjgUUlTwN92t0
         wMhQ+8mAbfsVFQ4QWuCdMQ+ZlVrLm4wksBFsIsMZIO9rI3MjSYHVxmS2Id86XUYq16NR
         hahiIQqyNdXYR21lvdsw5574BSZUIP2bZYZnFD65nPvj7VupC9rT0KRpVr07oR63sdyV
         j6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXD7l6/4n9owNKvMEG+zrHpUz2YVQPVaIin9qCe02SJF5JAQSd0+ffLWsGFi8ToVGdWrQFJBqkSOzA@vger.kernel.org, AJvYcCXHZl/B0AD0XSRnUcJEMisxrdrIw/Tfb7oL9Ta749fFY2vfTmmshAXJpCeniqCYloC8HLPFpp4v5Eye@vger.kernel.org, AJvYcCXvwvzrFEK8nJ3B/6KGvfUA75DL9ZahbbLD1BgtxFwGgaN/mOezmk8+ezIU4GkyCJW7CWJL3wWLj34deKAr@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZsoLWeS/i1au3hrnVyBxd3YJMc4QKfphymcfTeFFZjAgbb+y
	1RJLgf96ZKF5LcEacvShKBYDoYM8Iqulu+TLSRoHs6EKhvqeHh08
X-Gm-Gg: ASbGnctnZhoxGixuTJYXZmt4UhBt5BMf0ulvrYIxhjdGZ2kz6NzzP30UhIWelM+zFMF
	5eR4inyMFrUQd3UCsjwueyVVhinPtBjjdjnIbNCJ4CHTmnFrtDHFoqF54uOFjSwf8xHlFUWHzV5
	D5RXNaMONSnzJCjb32BY99KiM+G5ZxI0569JnlNZDwgYnz70lSX38MrwXthuJUvXFq2x+2eZkB3
	uFIwReINt2mHl2H4k+TRUNMmDggz4T7CL8HMieAKAj27Nv7PMTFe8SpfzrJSSJTYdB0q7mIYD4r
	n7DXY/AxKyisRk5Jf1FdsBC3XicItOiHmEbYlkV/g2udgT/LFX193Cj9+uWHW/fSoT5E6MG2h6Y
	q5E5zB2Om2kQjG3NpygQ=
X-Google-Smtp-Source: AGHT+IGFHQ953XlFUNcdWeX3LFF7ZinSerC0mh6VkIwkXLw1YYkrlJKuT6eHgUezwJV415R2Utt+wg==
X-Received: by 2002:a2e:bc15:0:b0:30d:e104:a942 with SMTP id 38308e7fff4ca-319dd798a4cmr23585521fa.38.1745823279202;
        Sun, 27 Apr 2025 23:54:39 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cf659c4fsm20017871fa.21.2025.04.27.23.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 23:54:38 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 28 Apr 2025 08:54:12 +0200
Subject: [PATCH v2 2/3] dt-bindings: iio: adc: mcp3911: add reset-gpios
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-mcp3911-fixes-v2-2-406e39330c3d@gmail.com>
References: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
In-Reply-To: <20250428-mcp3911-fixes-v2-0-406e39330c3d@gmail.com>
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
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBoDyYh/Ug1dMfpEZK40qCZjPJlTVboll+EyXs+X
 qxZDRw+VSGJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaA8mIQAKCRCIgE5vWV1S
 MlH8EACKc1bBvasZIEvdmceQ7TMNQ+L/Nl1b+T2S6mnWxeEW0n8FDZpt2v2MrbdHYs17en/Baba
 Q03tW+qlP/1VVmNZH8oCWbiNwUVv0/DFLQA+aUkkZ9/5Tjmg+ZWwG7scaVC7IREYT19D0vUMGIS
 BkrRz3CjQ3FVURxBYJIcIMhLhw5RqX7DftsOZS+clF9ufUYfoRXA0us78T/a+LSvyxbx17Px3F/
 nTqttu926yHDooVWEH74U74FuZywiOWHUk7XBX2vqWt2X+g8XDyYN8/ySwLXDm1iuC4Peu+3HD1
 IUWUVb9hqwCbFaMNPUz9FucJmhV1KnZal+63MD8efUpF8J5z6DJhJmG1llJfrByMAflWH2zZBFJ
 Ep323Kp7V2rOfE7yKddsaNpMSkzUa9hKKFfGFHXVds549ARK7p4Fy6nv2kyodfHzs9W507TrOYg
 ZTnJIm7FdfzzCm6ePX4a9C139kcFbWrRpOxfCnIT/UBTy3xqjqZUPvyjc0Iuck+0dcVELdk/HzN
 YiEoSuv4s5qlkbMpq8pcnsLUR7jJ2Au6vVKlEGFs4im/I2LFo9dX8ht+fuX3G7SOROtSqPcmuxO
 mZMnFiGR4z2UGDXC29C479qbhYVzwbVTUdU0H9MOlaR64D3ZiBcxacNmvZjbSeSkYZ3rMuAgs5b
 z/VCTjOvamtQ59w==
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


