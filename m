Return-Path: <linux-iio+bounces-11659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59709B7052
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71571C21299
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9FC217647;
	Wed, 30 Oct 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhB396zj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45B1C461C;
	Wed, 30 Oct 2024 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730329808; cv=none; b=uf1tWI249Xm1a0m41YWoZoJD0VAMHiZ4RfCN6vpLmOFKuC8AY09Jr1ZSRyvSXvZO0ApTUyxSAjpgwgQBMHnTDyCCFGVwjPjdMoTyzu7CS4c5HlawAcunElfzItsbgpn+Qlxm+Yek7tILYRvt30V9YFa77tb6LQGd23tIxp7XVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730329808; c=relaxed/simple;
	bh=qWnR2rmnhwGHq7mAsIHZILDGlSmqxUHxGBDr9jSrTqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ne6GezB6fonHuYs939+iKCShuuPtaAURdMcPjDwBT8XbR33XGxT7BQYvW7jN2wvLHzYR9rsirPAzVozM8ZLODT9wfDXbDpK2KEKmp4ohpt0XT38Y99dQ9JwGFhqLzgypDUJBoyD4JuePo/nXdohtqQZDk3OT4uZlBZD5yjTx0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhB396zj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43163667f0eso2942905e9.0;
        Wed, 30 Oct 2024 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730329805; x=1730934605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cumYjcBz0I1e4AdDhe+4/VCui4W7eGiW1fPLdLsyy08=;
        b=JhB396zjRBYFZrwMg1JeRt1EcnMMuILrPib0dXA1qv2zMigsCVy+zMUbFdXk1j9IMG
         pUkZ6u+aBOML8P10q4imdiaFTfe23Nw9Lq/+KWPC0UOIIR0zUT/sGxQb5tpmC1STaeNO
         qYywbQY0e0WOW8gnHKiW1Rv7fNRfzwAHFhMvRTB9meOxPH1MVU0EBJS5jTS7i8yfYtNv
         l4Ep3RGVPUr86lLQCGPJz0WlIFMyEcUWBwfzspWamzJNf7Iac+RYKFt696VkKEBNWzGm
         cj4JoWGayzFjHSd6RbaASOnpiFkNS54xOC8XdjqYW5tjoNaSAmVcYOzz254aa083INj5
         iByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730329805; x=1730934605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cumYjcBz0I1e4AdDhe+4/VCui4W7eGiW1fPLdLsyy08=;
        b=onzWIXHlibAOE2Ah69m1LobCEzdJ9RTucpDQNglMevyVbX3gFIQohiG8Y1Wkg3gXTW
         dWCdLnHqt/+LdVONdotSMrECjDnYt1fy6ZaIdXopxIPmrrEJH9/2cPkiaFTbZoLlPUK9
         gSrPuUXqcHe/KmQnU0yt+RTqI+eJ76E+hip09KtmouipeLsMgh85XzHQs2P7qrF16N44
         LIRi9jvlVCMuj2vSwJ5UamEmShVddmJ6kVLsq/PPTXYW3tm1wDm2OKi5o9CIomOpmAuj
         RI9nPjQcxektq64vRIxMGeVZGHN4wrCCV803HWfphhG2CRAPlUUySj64n8viOauU6B1R
         KeYg==
X-Forwarded-Encrypted: i=1; AJvYcCX/sOeFl+DkbzZLa37e13od503eSRVn2avk76nTvBE3+QcoDEY+salgzVQ9DBMP0peiy4twYphYHmgc@vger.kernel.org, AJvYcCXE/k/xxfq9Gs6wYE+OdY7OoYtUZVJVx3PbyivUB03AKO8uCmFYOYPEB8+UMArM+xRz3HbHg0MqAK4wafle@vger.kernel.org
X-Gm-Message-State: AOJu0YxIreQLNZ4LTrmofHn0B25+ZmfTHlE48cbuomeN7bVD1SKs4/Ou
	gm3vPFsRuCeUnuwj4HdROWalZudIGh8+ORrMG6bZaAFJ3IkJwdjLRQUtwoFQ
X-Google-Smtp-Source: AGHT+IGUJjwcoXteocK8oS6I7yQ/VwqNGJ7R/1sTAkTT4YW4Yya20nfyl9cBidfXM7PdgIz11CuAfA==
X-Received: by 2002:a05:600c:350b:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-4319acb8a7cmr144016295e9.19.1730329804886;
        Wed, 30 Oct 2024 16:10:04 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fbf3-0656-23c1-5ba1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fbf3:656:23c1:5ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e848csm34819375e9.3.2024.10.30.16.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 16:10:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 31 Oct 2024 00:09:57 +0100
Subject: [PATCH v4 1/2] dt-bindings: iio: light: veml6075: document
 vishay,rset-ohms
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-veml6070-integration-time-v4-1-c66da6788256@gmail.com>
References: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
In-Reply-To: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730329801; l=1329;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qWnR2rmnhwGHq7mAsIHZILDGlSmqxUHxGBDr9jSrTqg=;
 b=IVgjR+kPGspj5bVmNmpbtCFy9zefsFdIrH/9DZImLKWrpIbh/9MIpBqtUasu7pRvmtzb/5QTM
 dxYQ3bCWghWB+AXqDelvkGIoJvFv9PzRmPeEEUgFAQebxUtEVWGVi2t
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6070 provides a configurable integration time by means of an
external resistor (Rset in the datasheet) with values between 75 and
1200 kohms.

Document vishay,rset-ohms to select the integration time.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,veml6075.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
index 96c1317541fa..d2effccbfb56 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -22,6 +22,13 @@ properties:
   reg:
     maxItems: 1
 
+  vishay,rset-ohms:
+    description:
+      Resistor used to select the integration time.
+    default: 270000
+    minimum: 75000
+    maximum: 1200000
+
   vdd-supply: true
 
 required:
@@ -29,6 +36,17 @@ required:
   - reg
   - vdd-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml6040
+            - vishay,veml6075
+    then:
+      properties:
+        vishay,rset-ohms: false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


