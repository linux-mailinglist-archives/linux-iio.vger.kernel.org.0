Return-Path: <linux-iio+bounces-8674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0B95A754
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21791C22AC0
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1C117D8A9;
	Wed, 21 Aug 2024 21:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWiG8lrv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027C17B4EB;
	Wed, 21 Aug 2024 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277459; cv=none; b=GzEb3VJx6gAmMoeEtcELT1gApy/fSCKIwGuTrTn58NvNFvdYGkvMoWJXW6cVqhmgMht05Uk4V3IcYNowGwbwpc3Nrp/JzM+tiWymOo94qgZMYuo7XYahZsESgKtJASi1Teg2crRRn55SE6H5Yua+pDyFQ2N9ZprLSfOoZftFOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277459; c=relaxed/simple;
	bh=QoQjXg4zrkckps6OZl4xkgiuPOdfwY4t1fFBBZP8Uz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i33+l5iTZSOZQlM8mG2hwlDm6+9LS1HbmoD+3znzO6XQSuoqG6bW8VjqSVS5dep18pLtoEQYudZOxcZaQkFe4HXcO7opPnNGgVGKwajO2X56BJMXgLhC5zx8boFZOClpebcm+5AC0nCfVX2gBxfms44i6jc+s8IqLBwd8VCptNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWiG8lrv; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db145c8010so85818b6e.3;
        Wed, 21 Aug 2024 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277456; x=1724882256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys+sG5b9a6uhbl5zndW9/e6kK/Fuw6SOZtG6PQfHk44=;
        b=lWiG8lrvyj5LMjhtk9hw1ATSKccgYDxTBtzEIkOsH1N9IolrNE/DVNVo7GcHLO1xRB
         Qv9SucVAJ5F9AJWb/DJtLY3qsZRXF76bFWlzs6BrGW//9vXFWhIIg+7iMqz1NFyGdV0Y
         fiA/tbLB8xMeBTDaTITYnUssxBTMbCKLhSvR3sj88AZMITgzVzv0GI748g4Jqkvl1cwo
         m8nwxrcr9b0Keislh2qwuV+0RXAXSqEbX/gGobtTF1B7Djo2+f8UARSunmqvtxezLl2N
         hi74WrmoKPJqCanz7Bo2jzp9+Cf4ucVGCseiEzknau10yDS3xNqBI1E7Of/4yCq5BkZq
         1lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277456; x=1724882256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ys+sG5b9a6uhbl5zndW9/e6kK/Fuw6SOZtG6PQfHk44=;
        b=uNEvIWrniGRdUOIOs88vIcBDE+ReeivV+oT/K1w4ykOF3hB6D4N28uimWSEe/YKRDm
         dimmJeLomLJFQsjCAKNA6Avo2//7l6WL9CCTfArrDMmbHSXJD4Hw/WvjkXcCdacJbQjO
         kckEHKThJ46QfXTKl7OqLnRKHEPBia1+qfXGglZro1RUk3T2ukQoa8HjfFWEi9O+DtsC
         8wYNnR8wOyGNhv7lJWntVbIiH/dVvXaoQOfZXMeU1WmYwxocDY1rN1pu6SpcRXvT7cjP
         yw5NB7pJxULfR8Gp9oJn7QVdwyvUEmddyET6oyO8yIWBo0XQA/+1UtTYpXUY/9iUetaQ
         0FRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjDXFa1rs/T8B7P+6wFnhqum+Zemz1ofPgca78+kmCqpVtpXTpEAFE59GD3D+wNoMrOdWmfqFwQkLJ@vger.kernel.org, AJvYcCXQXdNN+HxAB9zeMsa+eaNtKtUEXtdsSzdp6H7nRtKws1/CYfdCtqmN+b87LP2ARrcQh2FDXLPOw7QG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsqxvoge38GQpYLKVhaS5szj3RUYFIgC5v73C+O3ptmWtYyK44
	gPDKolSzfLlgpdnaJNKx65SXq+cVSh7CJ012zSoPyW4/DeWTaBF9
X-Google-Smtp-Source: AGHT+IGSNGiLpSDGYbeQsr9hfzMxprNvYc1rfBeR6FKiK1Zn8vEKIFHLbFvwtoPro63cqF4NO+LkPA==
X-Received: by 2002:a05:6808:1211:b0:3d9:de82:f07b with SMTP id 5614622812f47-3de1951b88emr5131812b6e.28.1724277456012;
        Wed, 21 Aug 2024 14:57:36 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:35 -0700 (PDT)
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
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 09/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
Date: Wed, 21 Aug 2024 16:54:50 -0500
Message-Id: <20240821215456.962564-10-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the AXP717. It has BC 1.2 detection like the AXP813
and uses ADC channels like all other AXP devices, but otherwise is
very different requiring new registers for most functions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../supply/x-powers,axp20x-usb-power-supply.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
index ab24ebf2852f..2ec036405ae4 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
@@ -23,6 +23,7 @@ properties:
           - x-powers,axp202-usb-power-supply
           - x-powers,axp221-usb-power-supply
           - x-powers,axp223-usb-power-supply
+          - x-powers,axp717-usb-power-supply
           - x-powers,axp813-usb-power-supply
       - items:
           - const: x-powers,axp803-usb-power-supply
@@ -75,6 +76,19 @@ allOf:
         input-current-limit-microamp:
           enum: [500000, 900000]
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - x-powers,axp717-usb-power-supply
+    then:
+      properties:
+        input-current-limit-microamp:
+          description: Maximum input current in increments of 50000 uA.
+          minimum: 100000
+          maximum: 3250000
+
   - if:
       properties:
         compatible:
-- 
2.34.1


