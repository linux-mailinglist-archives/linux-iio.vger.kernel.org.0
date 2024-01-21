Return-Path: <linux-iio+bounces-1776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E8B83548F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 06:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD9B1F2203B
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA889364D2;
	Sun, 21 Jan 2024 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="HU/Tvzsn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8C364C1
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705814280; cv=none; b=nhqMZkF+aJP6saoC4LNkoqY2/SMWWr5+mzazkdg5bsKihukfNE/3qCoScCmNszbeHvVUmhZvnkC6b30UflWK56sAQcpT1sQkuyi8zyEipw08x2tIP39NO6bYditDKwdwT98Kta+FNyhxOr6sKDieQWWR65rYEs2V8SPltgioVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705814280; c=relaxed/simple;
	bh=9PPgyl4c02AhR7tsdj/3jHF5jJWRSgTdQEG0MfhuJW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSWtfjrpNSX8RYOIARSBlVO3mJ6rUljB1PyIjU2i+TzNKD32GPN5f76j+8aEh9Pfa+Km92tQcuToXCY5kiVRt3FohefjQDcPaf4duBt4ZO2A0n7rtcwpJLfnSIpkwqBj/gHVY11LdH//Hi4i0AEHJTDPoUNtw1xcJMWeMu0BoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=HU/Tvzsn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dbd7f1a300so422541b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jan 2024 21:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705814278; x=1706419078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbZe2AzIkKy+l4ATOd5FQ3m1RMu6EicdGaUIFG7TJls=;
        b=HU/TvzsnK5Fq+1Re4RIUSjQogNCvsbQ/PcWz66oY/FNGgUZkO6WYaALZMeTH5uMHp4
         BcnGJ12iXlEjsD5Ck527bHmP8wMyRIWUGSlXC/ToZFyhL92Yqk8JDhQGSeWrbEv82ZN8
         dX8etNCuRenb+Z4qWmcZh6Be4OFXV/vm2Bed1vYJ+NnI8Awf5V5g0Pzh4ivSSkVovDsj
         arA0i2CuagxyoSq0jjh5hMyn3eohYk5dFkvxLIaGLsE2j0HH4cGvd1A82lcSH2CQKJHz
         DPftZ9/SX8tJgn+B/MEFrI3hHHE0QhaGFu73Ubz32F88jXrDmkoPgW2OhguH7rzMle+O
         1NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705814278; x=1706419078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbZe2AzIkKy+l4ATOd5FQ3m1RMu6EicdGaUIFG7TJls=;
        b=sEhrWD41mkZijJzqO7UUlJCZkWZIySyXtkbI5gh4x5ZyUU5PQY49uA0kAcRxEL3ftb
         NkHGfk3ED1CEM4kuA4TDalSe9n/NC7bgc8fEBOuEdSm2QW+evmkmsN9yDBuXueSzdKUe
         5lsWk2AvcqlHtggoVI0hiloMhIubHvslrPdjCZRJ/wvNRqnpcpLP0BVcAsyNUafKN3Z6
         uccvv5lO5mKo0eNxDhLeqhnKneljYBCLyjoxgjbi0Ex+feMgrtgYSc4UGCiFAkZX9P+d
         Weqvw2RB1ESxKSsjHbXrgWQuehU3IZuzPQ1Jayl+ybN9gS1SlcwKpUBTyE9A58/d21Sl
         HU1g==
X-Gm-Message-State: AOJu0YxJUg9j0dqd6kA4vx4S1gjqphhKRN6lr9x4G0vQ9+M6qhiVSh3B
	U/UDv1fV07cgIozphaHQo1kFFwUvFWvCcrcbFHxz4I/enaErUq3xH3y/n8BG71A=
X-Google-Smtp-Source: AGHT+IFevGHaPKM+SIBslDZEahr4PU5NhW4eEVPcS+/9n12nXetRoXAFD6wxA8n1WRWV1BaAFBZizA==
X-Received: by 2002:aa7:9d1e:0:b0:6da:b959:3782 with SMTP id k30-20020aa79d1e000000b006dab9593782mr3416555pfp.35.1705814278565;
        Sat, 20 Jan 2024 21:17:58 -0800 (PST)
Received: from localhost.localdomain (2403-580d-82f4-0-3fa1-f9ce-6074-3bab.ip6.aussiebb.net. [2403:580d:82f4:0:3fa1:f9ce:6074:3bab])
        by smtp.gmail.com with ESMTPSA id f6-20020a056a000b0600b006d96d034befsm7547196pfu.30.2024.01.20.21.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:17:58 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: iio: light: Avago APDS9306
Date: Sun, 21 Jan 2024 15:47:33 +1030
Message-Id: <20240121051735.32246-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding device tree support for APDS9306 Ambient Light Sensor.
Updating datasheet hyperlinks.
Adding interrupt definition macro and header file.
Adding vdd-supply property.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v2 -> v5:
 - Implemented changes as per previous reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 .../bindings/iio/light/avago,apds9300.yaml        | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index c610780346e8..bee73a590424 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -4,19 +4,21 @@
 $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Avago Gesture/RGB/ALS/Proximity sensors
+title: Avago (Broadcom) Gesture/RGB/ALS/Proximity sensors
 
 maintainers:
   - Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
 
 description: |
-  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
-  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-1077EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-4191EN
+  Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
 
 properties:
   compatible:
     enum:
       - avago,apds9300
+      - avago,apds9306
       - avago,apds9960
 
   reg:
@@ -25,6 +27,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
 additionalProperties: false
 
 required:
@@ -33,6 +37,8 @@ required:
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -41,7 +47,8 @@ examples:
             compatible = "avago,apds9300";
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
-            interrupts = <29 8>;
+            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&regulator_3v3>;
         };
     };
 ...
-- 
2.34.1


