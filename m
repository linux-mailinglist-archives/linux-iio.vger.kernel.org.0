Return-Path: <linux-iio+bounces-5181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1318CC3B5
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 17:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7FB1C216DE
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE403BBD5;
	Wed, 22 May 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LckNCFsD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1BAD23
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390174; cv=none; b=FqEGxvroc3C/tGGi6u6dudFH48HlF8PnxmGcUo5LquxVeZQjI5befhIhdIwN7M+8r/ymY+7+xbeNxp2iU7Ijz8VHh8tkEjS57tBW3GFmkqgs+AMk5tGN9uvvRMVrZW2aTQ05UZ14iuISgnxoDsDQCldD7KOkRjuPfA0uN5vfWDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390174; c=relaxed/simple;
	bh=Oyivc8v0nPgyt25Ej8yA93bFsXe74OIpIMbFcFJaQZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRdulwvS6iA/oipC4NMOHblszkr5Vj9pC9fkm1xsQFnxDw6j8azu14xXK7KCW4fkTQiF5jk6z6c4A4Uuy9jikxdOE8cYN4PACz2L3qq5Dw0Cq70uTKa93zCVoA3qXmjCjF+wkW1jB5EpnGMXj2lEwiHYXogjziqxaPV+YN57LzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LckNCFsD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so87652441fa.2
        for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716390171; x=1716994971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB4aFrxJGRpEFoDCF3w8d3C8gCv5YBGExDQ2YOzvshA=;
        b=LckNCFsDKH+aWSA8Li2pAvIW5abUE0UIKW3jCXJNPgpjHu0T68hIF7DRduCkbWTUUv
         fk791piCxcn7hhgSZt1aPt+XTw6aoTBWZ7s6qDUrZba80Be83EBBNo0gazwE+0PlZhJC
         qCMUGYgshQV+OlUkEjWwMe/uZOtGvzkuBluGiA8kn/eWzCEjq8t6tcg0cBXAp4iy1bSG
         glrVRH0LoZRvLC2gO7lIWeicakvlSIKidLYX09sOeYiluQdp6dAfk47xqnBdfdnNochA
         xsrdwHET0P4TaPCFXnHmBSZEOV1sG9xofKdxQPFbFYsJUOqQajuHZvOLpSA8Hdnd+ZmX
         MNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716390171; x=1716994971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB4aFrxJGRpEFoDCF3w8d3C8gCv5YBGExDQ2YOzvshA=;
        b=Ii42m9gTj1HHlsgPtDUOLBd8md+tVdw5BKZ06z/CEENTj8gOJV1eCr31Jbc1fRIVCE
         DxtWwqQ96LTtzjip3OQYaMAE3u1zsASJXHyJDV7F5dhwrJSAtDOnJftrEDEVT8JuhU3g
         nMn4ucPsxPhIFwcNlZdwuihOGtMGxo02nXCkCIMLsmpX3aYHNE+o/36+/re3rClCdwxo
         Bs8r+j/3F2TKUK7xGWKiHt+RfM8V9p4iRpyseZAPOaLNDKFk1wpUofvgWPKhLMNpS4Xf
         zni4mQObuFuphdOkJs8E46bVasQmYdgjoI6Juhcd0uhNpBFZd37YMgUzLfzm2BxeYJ34
         1CKA==
X-Forwarded-Encrypted: i=1; AJvYcCVGk3LQRZtrpXKC4pC4wpBL0Y6l6bNNqu24OELN2ix98tyuUrYV+YVJ2SRp2izIslh0HptXoyJqTL6Ftxs6eLVGZkQiWCSDTHmO
X-Gm-Message-State: AOJu0Yzk67+ppdy1MYHdCPyHCYjgl+vDxgU3T/wD8zB8o7V/IM7lJ1sC
	CjXzhAeTOrHIRxZdSNY9L/TMek6xRS58bR1uPcElt6PWat3Mun53TIjRzHm/m0Q=
X-Google-Smtp-Source: AGHT+IGlikuVJrqPYvrWxSHDc7Uj9hjg+XjhYNt1RjMzI7JQOL8qSiKK1w02HqMK2osgyUdoEB1T/w==
X-Received: by 2002:a2e:720c:0:b0:2e4:f8e:3a64 with SMTP id 38308e7fff4ca-2e949518e3emr15052791fa.30.1716390170644;
        Wed, 22 May 2024 08:02:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-16-6-145.retail.telecomitalia.it. [79.16.6.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm531370515e9.9.2024.05.22.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:02:50 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v2 2/6] dt-bindings: iio: dac: add ad35xxr single output variants
Date: Wed, 22 May 2024 17:01:37 +0200
Message-ID: <20240522150141.1776196-3-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
In-Reply-To: <20240522150141.1776196-1-adureghello@baylibre.org>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for ad3541r and ad3551r single output variants.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes for v2:
- bounds reg value to 0 and channel nodes for the 1-channel models.
---
 .../bindings/iio/dac/adi,ad3552r.yaml         | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
index 4e9f80445405..fc8b97f82077 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -13,13 +13,17 @@ maintainers:
 description: |
   Bindings for the Analog Devices AD3552R DAC device and similar.
   Datasheet can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3541r.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/ad3542r.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3551r.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
 
 properties:
   compatible:
     enum:
+      - adi,ad3541r
       - adi,ad3542r
+      - adi,ad3551r
       - adi,ad3552r
 
   reg:
@@ -128,7 +132,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad3542r
+            enum:
+              - adi,ad3541r
+              - adi,ad3542r
     then:
       patternProperties:
         "^channel@([0-1])$":
@@ -158,7 +164,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: adi,ad3552r
+            enum:
+              - adi,ad3551r
+              - adi,ad3552r
     then:
       patternProperties:
         "^channel@([0-1])$":
@@ -182,6 +190,21 @@ allOf:
                     - const: -10000000
                     - const: 10000000
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad3541r
+              - adi,ad3551r
+    then:
+      properties:
+        channel@1: false
+        channel@0:
+          properties:
+            reg:
+              const: 0
+
 required:
   - compatible
   - reg
-- 
2.45.0.rc1


