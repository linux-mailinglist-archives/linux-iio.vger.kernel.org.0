Return-Path: <linux-iio+bounces-3086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21DE8674F7
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 13:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BE28CCA7
	for <lists+linux-iio@lfdr.de>; Mon, 26 Feb 2024 12:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BC60BAF;
	Mon, 26 Feb 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy5de7Cg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD1A605C7
	for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950611; cv=none; b=BkYlJkRIPBml0nw1jY23rlxP6jkpkkDTA4v9AB45BmUvfyHS/ZUG9luoOTJKjsvnCt/YgrbRfn5/9mXw7KwbXQoRvL8o8tiYjM+Bttkpnm1Qt/ge3VQUX977kXsqT4wZHGbhUrTgc8aVBApVnxeUQN1FzSOu1wjM83kiYaLyQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950611; c=relaxed/simple;
	bh=Fm0clYVbu6hATD7ktts/psh5VC7LgiUZrv1c7nxuh8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P3qxdKAMb0WGjLJsxmhhEHEMm4XP4c4pWqpyQ+eYmgCuHaUPKjNqLl/9Bza5Q6dodymUN+YLtBJQwhIayabWNyqfGQof7iDqFGHWNodBjDVSeclC3a4qEBtC9AsQvFgrunKdYg64iFqfvnCI+WWxsN2lrmz59vfLLtcb9FAmRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jy5de7Cg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so4009034a12.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Feb 2024 04:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708950608; x=1709555408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wt7/2Uaa0FnEMeuY5Q17SqUB4gQ48xOd96E2rO+drXs=;
        b=Jy5de7CgyoGYlNr/r1VckpETDTSePRTAx74ouBeNn5kroB2TkV+o5/kNpjf1szlZtC
         clTu7rIFbHzknlsdVPtlhodsf56qw0Zmpen6lIudnQzeeEjdSyI4tIz8/UmTcOo7VyFb
         qgjT1LfXv5GSTHQy2xprGNZmJCDYdOOt7472He64tStHwPluCdOqhn4nrEUAZ+38xgPd
         y2yK/YDHmEk4rOwWIn09tT62jm/H0B+X7FRze1/1k8zpjsYY3wKxcqisdn8sqmzYI8NV
         XGQICDXaCqeqGqX4yXeQ/WhMecPGOkO7kUMe12yjfD1kaZyjciWdX1iMFJ7wOGYpRsJr
         Cl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950608; x=1709555408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wt7/2Uaa0FnEMeuY5Q17SqUB4gQ48xOd96E2rO+drXs=;
        b=Nx5UOWkOHgESPjYNld//6KRHPkABT9/Ud4r73I7xcx2vwtDjfIUlUhe7ySNZb6PRwR
         XV3IvSp6FAiUSONSQUaTRg2OoOAdWdRQgFU8XEVMdFHwPd4LCoOgkkmo2EJpjtmmhriT
         HI3fqTyR451ufJse1eOmqbdUqaihhymLTM8MjI0lT/Wfs9ZhPLuTOS3P8Oojdw0eUJ95
         MSkzBvzwfJW1wsg6Ad7I8k8ohNCaGbWBS+is6Db7R+locb3gmc3DkbMSfjioeHuZXmST
         UaZhlrk22fgNrx7xebavgVfrLqITTaR6yoHj9iTYQ7NR3IMMADA1qJiLEHGrL4nAt+yG
         xFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVFPK+HIcRkywKGuKLV1iR3pka0NpBHsl+L5SANeIrcu2lAJ0SndJ/VPWQQDu3KCiWuiBFKDELw7Bx4ihBgO182OzJXlsm5iwS
X-Gm-Message-State: AOJu0Yx5A18DeVtdo3UB6CsOEfJlkzwlvnEyQRcNCbVNzBEkZeAY559w
	ys0VBpRJLqokzEekxzhBXfptGVwcd42f/Qxw7GrlR9xd4G5rUCQrPG7pYNq8M1Q=
X-Google-Smtp-Source: AGHT+IHufhSjvKYboP4wKOqIELJB1hIkhyZjjsJ3/BEPDVaM2knYJ2Nr4lDKOKoceGuTC9pNeuV9lw==
X-Received: by 2002:a05:6402:14d4:b0:565:dce3:670c with SMTP id f20-20020a05640214d400b00565dce3670cmr1974804edx.41.1708950607820;
        Mon, 26 Feb 2024 04:30:07 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b00563f8233ba8sm2289585edq.7.2024.02.26.04.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:30:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: adc: drop redundant type from label
Date: Mon, 26 Feb 2024 13:30:04 +0100
Message-Id: <20240226123004.91061-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtschema defines label as string, so $ref in other bindings is
redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml            | 1 -
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 261601729745..36775f8f71df 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -22,7 +22,6 @@ properties:
     maxItems: 1
 
   label:
-    $ref: /schemas/types.yaml#/definitions/string
     description: Unique name to identify which channel this is.
 
   bipolar:
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 40fa0710f1f0..c28db0d635a0 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -75,7 +75,6 @@ patternProperties:
           in the PMIC-specific files in include/dt-bindings/iio/.
 
       label:
-        $ref: /schemas/types.yaml#/definitions/string
         description: |
             ADC input of the platform as seen in the schematics.
             For thermistor inputs connected to generic AMUX or GPIO inputs
-- 
2.34.1


