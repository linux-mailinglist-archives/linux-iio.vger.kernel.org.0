Return-Path: <linux-iio+bounces-11238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EF9AF3F7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 22:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FE61F2175F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF372178E0;
	Thu, 24 Oct 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuEwxdoC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D12170DA;
	Thu, 24 Oct 2024 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802699; cv=none; b=mT7Y5ng6PVZb3pMby9e6lUsxsWgDwier7nn3bRf+bBYhPEbYmWfSZMp0Pcg+sa6JuQ4a3m1c/SSRrmAY5YW6Kll+wcTBmORYG41g92RKtPJ6A19fyb8U3hbRHlvFxO+391exzRo6weJ16DRco0uzTS2nLgxQzIQiUoC0MA+vt3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802699; c=relaxed/simple;
	bh=ZKMGInAqWH7QRa4Ec19fqlWRKNcb1OloZH0CQOBSYUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XDfsLT4vGzlVuG2ZkOyhUnNlSSoEVoUI9oH1KsLFRaOrwP9VNCpYtBOSALd3YlSi1vOrCCg+eFacFmDXDdq0iwGlN52q/4z3u5njYT0H3iMb0nc5G3XXAD1mWQkTINJ7w4hYvz53uO3aPS36J97G1HXHWYDfoCjdL52qXZuLr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuEwxdoC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d41894a32so1011853f8f.1;
        Thu, 24 Oct 2024 13:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729802695; x=1730407495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOrLlS9Ohpgx54onG7kOMgb8DFojzqKE2L7KM4OkY4Y=;
        b=BuEwxdoCMGtUlq0ToVAiYVU6wOO/otQnbcgES6Keezue02znSVQ3Ox02yhH8nxRJaj
         Hk5wOZKnKEF6x+CckAyZhO4WFgRdWWvIdvWNAnMUwx2DlF4roAvNUr7EFTIeSMq80LUl
         L/QtuDNnJjB6+1BOFILld1C95rHq1HKnAaysMicl9Wmbyb/BjyQDYt/X+sTk8k55Grll
         A7eCmFYeI2LRo8c9V+3eB8yoSrDMQcN2QDcvTSo1h1/8xWnYMwFe9rjUCq0OPagIdCDC
         eCOOgoEUufcCyN1NbaXhDaDAZSjHCpwMi7R/VoFarJLbj31SFtSFlei7MueJXE79+isM
         omdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802695; x=1730407495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOrLlS9Ohpgx54onG7kOMgb8DFojzqKE2L7KM4OkY4Y=;
        b=B7H7gy1Vt+V/d73eq12SIsjlcl/YfiZApCEJdEf+S+yXV92QohJb1I/pkVaYNrDSy6
         dD9hg4EyVljBq2CmfG7d+NIAJH9xA9/4cr4Gm1g2kzJsGXDsoJ8LOVyLm2Z7PcjhcEH1
         Mbd436+CUq0LMMP0vxZYPgmNFMoeBrjngNSuRr+SLHVVnQhicn70rokiGxD7Klf0YB3w
         Ctq398Jc42+LLEFSOTWph1egOZxH78KuiJ3V5ncDsv6wLf18hItZAFRT7jYlYUEj7yzk
         Sm4DbPJyRvaa4OSRDx77+FNk3RwtJDldQyjM1nEsAzKKOnlE/Ju03EtdmLrTZLJfm9mT
         d/4g==
X-Forwarded-Encrypted: i=1; AJvYcCVGdIAnEXV68iC1b2a+LZJmj/C4LWBzwGpiGoavlimF8j4zK0ozXmDWBPeyFF6xHyU1zBnWxF+FQkof@vger.kernel.org, AJvYcCX3nMB8KuBXHNqhFG6jif+l9EqhTu3KStN+tUdPb+z3rBqrFbwacsdH1drvldLvAARuISHokSMGLGHrzYZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXoGpYVZWD84lKiC3MP9qal4SkcWSkRpul4csO33iCP075umC
	72/iiY6j37T6JeIT6kkGYeQ/0dqQurpZZPq/N7pO62Qhlw9/tjXEd8sY4A==
X-Google-Smtp-Source: AGHT+IGSdmwilMt02Jj7MRPaVEBLuxN27LC8S+e1Z2C6KVVCM2XHOuSaUQJZs8GM7MCghHh36RcVHA==
X-Received: by 2002:adf:e54b:0:b0:374:bf6b:1021 with SMTP id ffacd0b85a97d-380458827cdmr2188490f8f.27.1729802695157;
        Thu, 24 Oct 2024 13:44:55 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-937a-2f15-cf5f-c6fb.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:937a:2f15:cf5f:c6fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4ad48sm12105728f8f.42.2024.10.24.13.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:44:53 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 24 Oct 2024 22:44:48 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: light: veml6075: document
 rset-ohms
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-veml6070-integration-time-v2-1-d53272ec0feb@gmail.com>
References: <20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com>
In-Reply-To: <20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802691; l=1484;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ZKMGInAqWH7QRa4Ec19fqlWRKNcb1OloZH0CQOBSYUQ=;
 b=I6skoi5TqdYSlehEYtUX6shs8+xjdIqimfMvR1n+I+iNcO3nztxs7xzYdZPiSDn03NF7LBH38
 guV9Ork+6sVBVT0+JLkBZ4JDD5rXBuAu1hpz+8ivGTcQANGSslmMg/I
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6070 provides a configurable integration time by means of an
external resistor (Rset in the datasheet) with values between 75 and
1200 kohms.

Document rset-ohms to select the integration time.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/iio/light/vishay,veml6075.yaml        | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
index 96c1317541fa..dfd64c411658 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
@@ -22,6 +22,10 @@ properties:
   reg:
     maxItems: 1
 
+  rset-ohms:
+    description:
+      Resistor used to select the integration time.
+
   vdd-supply: true
 
 required:
@@ -29,6 +33,29 @@ required:
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
+        rset-ohms: false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml6070
+    then:
+      properties:
+        rset-ohms:
+          default: 270000
+          minimum: 75000
+          maximum: 1200000
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


