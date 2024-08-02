Return-Path: <linux-iio+bounces-8156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816539463C4
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EBB1C210AA
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA1F166F04;
	Fri,  2 Aug 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfTgWCJy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89624165F0B;
	Fri,  2 Aug 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626578; cv=none; b=g4DIJj5UVeCF7DkMKXwBao3fC/jfl7B4KxC02EZX9wtpUj3MTB+4ngff/RZW0PQEFwz7Na0bXQFz4y0vzl+PblDt3K3lv5kRcZACDXgdI/JnLEzsL89An0iBNr1wty7aQd7bdXq2adeeula6eXZTCzhmOVkF2v8bbnemC74hIg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626578; c=relaxed/simple;
	bh=4y5dka9Ir5lnHkbs38KhflB8tgwWZxeU5OvpvbN1pks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulyQOOdD3HwHChJFuZK10ay0htC0KlnY+z2QeSHNpUP6VPIjsDHQ4LNCTXE8hrBWdV9JG+kS/iDBJWdiTY/fi6jZKrvOhySbRKZ4sFWty1nOXHW0yyzgsgKFQJGveEdexNKh0PaIhpwom6geSSM5829IhRWLpKrLuTBYIOc9zAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfTgWCJy; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db23a6085aso1950518b6e.1;
        Fri, 02 Aug 2024 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626576; x=1723231376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOyuQfbILcMGTmLZPccNjk0siFr1lyw/4cIfSrAVrWo=;
        b=ZfTgWCJyq3xXgL+N4XQd8rJJoBwB+RZLez5oSlQEutoQqUgeAYB930+3eUKlQiI3FS
         NYUDVr8igGE+o8Vd53VUDtOvG56DsbrdStrXOoxU4IWIxAPs1q7znSVMgjgggs5v/SsS
         vR2aiSuDT+IvjLgsatDdwLr6+Oe3qvI88nzWo5mQs7zFNJK1EIawUMkqvpKxuMCbnXAz
         ZPhUjD8ko6etKinWjzirVutWMfVDGG/1JHmQ8gBgwWJuyTvNRvRkHc+jwV12OV3ttGAt
         a4s0lr/Gp5t8P0CMi5kBjxU/BoLox+qStalTwO4JQQ6Fz60/AnZs/cy2QZgzSAi+X2YW
         UteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626576; x=1723231376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOyuQfbILcMGTmLZPccNjk0siFr1lyw/4cIfSrAVrWo=;
        b=DsVc6KxPwmVe3xMYMKoIY9rbkDgPHyYdssQo0RsysfZnmbezlHtpuiRWXJj1rk+xOF
         8m50ZYfvteSnsSim5LCmzO4AaDFnKpvJELiBKSHTD/+2h1woOTILEvUX7RfORKu23zsc
         KTZlwgazLzvb95xGY++cXJtWwxllJqPDbZauvimsxauH4EdGATuvs5ZnJVdDVzJpyO9f
         qS6LaeC6Eu4so4/UBm9jhpPVUHR8SAE9cxZ8sgrQQk0Y/OnPwBAE8N8N23GdDtkHghI4
         8UNmNnlNLHSAJ936fSCA+hDk/p+aUDUpruSKLP/vKxMsLaEI4lAnidEDtwigs+qwo7zp
         nYcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5fDwtcoPtRieTB4+Gm7TXHMpcmRicGskbftlCkq/Lk8yqKzP99Mfc0cs5/bz5YplhS13Vk4UKJk2oytJ88Jo0MbZAPga3mUroPUYYcPB0tOaSdiV+2ASE+zCHG9w19LBefH8lBg==
X-Gm-Message-State: AOJu0Yxxy83OTLAbKFKidOF23D3BTvXiTlBGUUuxYAjHmmXCY83ybRzr
	55HGbVaNZfVsx846GI/7kgdGmp04HibQHKfDlOHjl/tT5SOYr5yr
X-Google-Smtp-Source: AGHT+IFxPdAe/2YdHaq99lURfivc8IRArlYVgwZnu48DQyuvdfvclsbedQRdAd0XWC+Tjce6SDTJNQ==
X-Received: by 2002:a05:6808:1304:b0:3d5:6529:bea0 with SMTP id 5614622812f47-3db537d3682mr2277502b6e.6.1722626575664;
        Fri, 02 Aug 2024 12:22:55 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:55 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 07/15] dt-bindings: power: supply: axp20x-battery: Add monitored-battery
Date: Fri,  2 Aug 2024 14:20:18 -0500
Message-Id: <20240802192026.446344-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Document the monitored-battery property, which the existing driver can
use to set certain properties.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index e0b95ecbbebd..f196bf70b248 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -28,6 +28,12 @@ properties:
           - const: x-powers,axp813-battery-power-supply
       - const: x-powers,axp813-battery-power-supply
 
+  monitored-battery:
+    description:
+      Specifies the phandle of an optional simple-battery connected to
+      this gauge.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
 
-- 
2.34.1


