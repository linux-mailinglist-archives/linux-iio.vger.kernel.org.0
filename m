Return-Path: <linux-iio+bounces-27329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16433CD8895
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 10:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 570EC305222A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA54F303A30;
	Tue, 23 Dec 2025 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/Tz364/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCBA322B70
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766481163; cv=none; b=PlFGe3uomuHOWg9O26Nxvrhp2n3+8Rm0ik5qQKil1yRCuwn6l39IKnez8V8hKHlMNdaxAw6OYnqu0ybrWnCv1Sa/Z/TIIwcDSiXg3gHRuWL5RbFteiBo3NyDgVNtVLFQcVKdXqZG5QAsGfBXsXaCD2ced9ISBoiDVxbw32UE8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766481163; c=relaxed/simple;
	bh=S8OEpcXpBEONfmjqfR3syMAXK/IV6W+U/9C5wzdJYO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lixxeeJC+j5HY8ZowEJkKljcn0O7PjeA9dvl/1dD2G5F/pdQDaoAvdzqIOOCXCO0AfPd0WOwkbXFfh6Ibyh/3IAiFJsK0PZ3YL6I3RyjD30QSQxzrsk5Di7/HuBR2l+aZ6k7Ie2Q7BXmByoSk+G3HdAAzvlYjbViS+SMYboBF0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/Tz364/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3991825b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 01:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766481161; x=1767085961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKre85fWvMpDGBSufwyT7PttY316kDFDWNTXYHvVPt4=;
        b=l/Tz364/NO6yaEX2g0v/OjT5eNduG2lcNeJ7zBimDtfO5rdNKL4MR/Uff7DgxxVri/
         R+h7r/JRqhWjxTSGL1BYAxlXn3IQdtMTb1+bD1YKfdzus8JgnlEW1sB5bZEsnFlM1S0m
         hU9ektCB8LHjSbLDGuXzPy8qPmtJGL0d034nZZ4sMckOkK06DIsTPZaiHMa/uqMPEkPp
         DJ/b47Sj7pp1vj/HvJtaoI0KavHBzxn3LrrR8iAs+EqYf59JnR/X4OV9GzRT1Nc6oVVn
         GrlSnGdH8JbL5fo5Xrs/0dqdVIxAHg4nCPvbavq65SSYzbr59ZrDuDw6xqyiP0LnmVlu
         Zlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766481161; x=1767085961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKre85fWvMpDGBSufwyT7PttY316kDFDWNTXYHvVPt4=;
        b=P6rbMqpQ4uXlbBpe4uyYbkO1pRjVF/2vojnNJ6kbbHx8WEvC8bnDeCzBE8qm625DB3
         qpOnoHldsGiTS4snoDyjbzGRzOU7+0C4IBNTVzBcOLj/wEk8d6CLeF/XahcXq0QNinvd
         FZh49ofMmChNKyZowup6vZzIDySy8OMOeqLLMADNlKILbmgTTB0uzQv6P1rPkiIfm/TY
         YRlwCNyRCgzdO/KDySY6uC2rym+lvF0tEb7nKSn4BBu404ozM4etD7nVH2lJWv6f9DW1
         DQ/MN5LDOJJH9996zTiJ2TYLIuY+BRbkqYNwuOnzDfXOLovn1Nh8M1BMWrmLKIKqiMHN
         jk3g==
X-Forwarded-Encrypted: i=1; AJvYcCUnWv+M6ub9IrgtzcgQow+kXx0sfr4byQO568K5REwoaRJFdBfJKZ3lNsKOxWQv+Cb258q44AGZqvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwriDtozSgB0A2TH//T4fTqHxojgYxxCMB0GZcaooz/h1b5oTN2
	+P2UvneooF0I+2tdxWY+NozNm2/e7lPjrQox98gayarj161Fwpghn01Y
X-Gm-Gg: AY/fxX6OyietVL9dXx6yakhi1CRqVzf2cwKQS/hlLqH3qtuW5jx7DMqNl6N5yXKLKYq
	2iJCJ8xZnutzlOyip7Y2fmUlBFhnuoltgKPMuToETlP5fL6jE741J5+7EKUVPV1Vmw3xAfMXX3v
	aInJth06COX633Y9zmfx7z8VOSim2Map1TBkOtmuzj5IhuKKi7OampssK6YU1dAjdv4xpQjFrl6
	ikCGXTpkgIkK5OXE629+TEXMwchfU22mkDS5yu+1z9zNey67Z5K4Jdf41pfiEpZuuEVtV/dPiVk
	u5Gri2B7c31LGHHksKk8T+rVrtDHQ9fmz4H1B+u61paVYxK9H+5/QorGi7LrBgjjXXPpmnBddnb
	a0Z12cSXPpRaojJDwe2bcKEIVE3yxAeuCh1n/+hu1x+IVrlm7HAu+A/OPguw2xMP6i0RvK67+2Z
	oAcE5mNltWopXBxnp8S3cUgcbxLfN4uFF8B327HhhdlqFnOd+vifY=
X-Google-Smtp-Source: AGHT+IFb8nq5pHNU4Lw558+3nSA5hlVwvrQvQ/fUlsD2Htq3k/K8wz2pYmZURYEMYcJ3ZQUW8K/4gQ==
X-Received: by 2002:a05:6a21:3086:b0:366:187c:55 with SMTP id adf61e73a8af0-376a4c66ccamr13104281637.0.1766481161371;
        Tue, 23 Dec 2025 01:12:41 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9224d9e5sm12352454a91.17.2025.12.23.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:12:41 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 23 Dec 2025 17:12:25 +0800
Subject: [PATCH 1/2] dt-bindings: adc: ltc2497: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-add_ltc2305_driver-v1-1-dfa0827fd620@gmail.com>
References: <20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com>
In-Reply-To: <20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=S8OEpcXpBEONfmjqfR3syMAXK/IV6W+U/9C5wzdJYO0=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpSl0Dpsdjt0FovFejrcSdweINxpHDfrRl8wEeZ
 kPKTRg08bWJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUpdAwAKCRClg0K3CVbE
 gRWuCACVYbmKhPuOt+ucPuTweOnMCQE4W8fXTu3J4as8T4/V4kV3UfHTEpTpdoi46UwHJitUsnW
 82LiJCVrRfSvu++RcyhL/CK3T6xpUPyK4bEWqDYYCjLWgpi4ofNDbv5E7jy8UWwrsmypOSxjSps
 ln7VhEJU+I+aJhJkuplSgpevFNE0pBXB/l8jZVGeqrQt3dorQeblYEZDHeRFGf3lGa4MQ/kASqx
 gIDFj9vWPfRjCoMKe5BshVNt7c31nZTw1bALitPPIw14qif3a+AW0jeM91QN1Vh7JmijDLT9UkN
 LunOxZ4LBjLKAZQlytPYB17aVSAIadZVEpky6m6BaOzF2I9P
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add documentation for the 2-channel LTC2305 ADC in the
existing ltc2497 binding.
This enables automatic device tree matching for LTC2305
while using the LTC2309 driver (drivers/iio/adc/ltc2309.c),
since both ADCs share the same I2C interface and 12-bit SAR architecture.
The main difference is the number of channels (LTC2305: 2, LTC2309: 8).

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 5cc6a9684077..c884b6e03767 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -11,6 +11,12 @@ maintainers:
   - Liam Beguin <liambeguin@gmail.com>
 
 description: |
+  LTC2305:
+    low noise, low power, 2-channel, 12-bit successive approximation ADC with an
+    I2C compatible serial interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
+
   LTC2309:
     low noise, low power, 8-channel, 12-bit successive approximation ADC with an
     I2C compatible serial interface.
@@ -28,6 +34,7 @@ description: |
 properties:
   compatible:
     enum:
+      - lltc,ltc2305
       - lltc,ltc2309
       - lltc,ltc2497
       - lltc,ltc2499

-- 
2.34.1


