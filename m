Return-Path: <linux-iio+bounces-9978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630DE98C6BB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815331C20FF5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2E1CEEA9;
	Tue,  1 Oct 2024 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Zfh2X3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A41CEE97;
	Tue,  1 Oct 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814110; cv=none; b=RhpUGgQCABhsXMRXA89drJqgp5mRga92/0q2lL+df2oftP+UZatZCFS3dsaaZKEayVtV3isukXUzKRnPcX6xqrOYRwONa3De9JWo0tI1oQOLJZa710qFYQ3lmf0KzV29k1jzOZASeIAMfELdEerTEttMLen+qAfrfY5maRmh8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814110; c=relaxed/simple;
	bh=q8FwDwo56C9iqr9K04+IlFVkhpkEpUaFpNVqlpnaH0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POgvGH/4Fe/7bf8KDaYzYbTVZM6tMnDzb8hI8j51t/GyCwvPMylMFeNvHJDJaYOojxr2uiBWAzJG2rckt2MBvwTtK5bqJDkOl3CW1tE+c5twnj2QxlJYMDf5P1vZ262wosI4pTfKLCGcyx8RBYE9mE9dNs5RVl99QA/5rKl8WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+Zfh2X3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso49008105e9.2;
        Tue, 01 Oct 2024 13:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814107; x=1728418907; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ELev4uZv7sI4OXtICgXw+pXJd/SMDS1j69x7XKzekk=;
        b=Z+Zfh2X3XEo2RC4FUjpbIF2O37f+IR/yIsMJozeOrNXHdp3c1YbsMqEiXlUgRYc1yk
         c+JFf28r8+ybnDaZYpPbtYSOw5Fk92X9uk37aBol4cmAdPvQ7lwVRB5ysK+PoC6rxP86
         8Dhb+ByGJnRLgOuxSHKU66X5zIes77ASV3Vf9/UBIOdy01UYN0cUhO++cxE/kgfXLkNJ
         Nf0q03iuXYAYPl+99u+jGQzP7EkwL69xN0AN6SF9crKFzFOOFg1ELIzaI0svsu6vb8IV
         COgeiE1+5D0jQaQbEp5bG7LU8tpIMSaraLFKkUTGgtWoVa4cyOZH292E4E7sSWUk08ED
         aYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814107; x=1728418907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ELev4uZv7sI4OXtICgXw+pXJd/SMDS1j69x7XKzekk=;
        b=NEIwkpdkGV5N0mvgKz6uPoqI7HHIhDSnK4ohfV3CJHNOlT9iliB21FKkrpDsT8twvt
         xl4JuOPlU9U+SN5HaYFaKfvUQ3Djuvfc8PQ5bRKwyeWagLYjc8RpIIfBNBZtW32kEuYE
         GwvPZAADTM2SS9WAAVr0dwdYgmPrvTFU/paoWzU1gfjIUik6wZUga2B63L7dczlPLoAA
         YXZO/efe+9mbnxyTldSSSXjW8BBduuydhe/KPZ3rfphu0uPI1cLfw+RXLoScBBuM4G7M
         C58+RTnCW2aC8OJ0OEY74TPU1POjBdtLgCQTjOvvFsavOA94+y/6IwGCKt1zbZq1R5Ml
         PZAw==
X-Forwarded-Encrypted: i=1; AJvYcCUPefzRIc/XdjArZQZlPVzmYLhVf+XviBVYHL2xQPjf/zDWpBw5fRbVB1gYrbqWS9v3QmaEIX0FAMRdT+V1@vger.kernel.org, AJvYcCUfQqkWgU+m5FbCazLVvQOfd98+lXqaxuHZaPwq3Hc1jXVoFmFrWMbIf9aGLoVn8y4Vx4te4OAtGu18@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyjQ8JbZC1k19dFCD0ulDOKRbs+4ZGMjszVI+6eI480kyj2X9
	khN/pp2tpRQhw6oRG/ycpDQIsVlZsjB6lGtTUjs3xJgMr4Bp/3RrHEBUl2rD
X-Google-Smtp-Source: AGHT+IGNJk6cnlBlay1XsFzUdSfqL+mtSzambJy8vwOBwnzNlpo+PS9VwHIh/1vO1PXcYJhFz8iDTw==
X-Received: by 2002:a05:600c:35d2:b0:42a:a6aa:4135 with SMTP id 5b1f17b1804b1-42f777c278dmr4507025e9.20.1727814106941;
        Tue, 01 Oct 2024 13:21:46 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:16 +0200
Subject: [PATCH v3 3/9] dt-bindings: iio: light: veml6030: add vdd-supply
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-3-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=1080;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=q8FwDwo56C9iqr9K04+IlFVkhpkEpUaFpNVqlpnaH0A=;
 b=rqHVmh5s9yN2L7KEiDDT5/+g7334tsHwmy3yBTWilHgfSUo1GkWM5wtp12cOo9kqsCEs2si4B
 waH+izMv4XOAgvlTXA8lPevkVYs9C4i3lecXjCPMwIXbFTg2CBuYQnq
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Add vdd-supply to account for the sensor's power source.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 7f4995557570..42a78cd4f812 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -41,9 +41,12 @@ properties:
       interrupt client node bindings.
     maxItems: 1
 
+  vdd-supply: true
+
 required:
   - compatible
   - reg
+  - vdd-supply
 
 additionalProperties: false
 
@@ -59,6 +62,7 @@ examples:
                 compatible = "vishay,veml6030";
                 reg = <0x10>;
                 interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+                vdd-supply = <&vdd>;
         };
     };
 ...

-- 
2.43.0


