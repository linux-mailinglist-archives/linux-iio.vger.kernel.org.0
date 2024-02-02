Return-Path: <linux-iio+bounces-2094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A348472AC
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC076297CCC
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EE0145B29;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMP/WmKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6D2145335;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886594; cv=none; b=swef0Yg8/prfWQdw6ZXJAJmfVBsL0jgOsRaNWRLE40cFoDeaAghrVT+RGMLTfkTW08ySzmzO7NgOJjIpvD7RDthD8XLJSffxcYAqFd5AdHK3MgSBUD83wwROhz1XpwFX4BW4DbyIhc3CDG6+oz6DP97qE6u4Mu9gZdqpLsMosPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886594; c=relaxed/simple;
	bh=cRBsVA/gjcOt9pjoEuJIhQ39NaZaSPebkpAvtLwDKu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgNCkvHvOrCK7xkTWcdOwnktlsUvWaeRlbF0OtnSTbFJiWfdxZ0BitwJiz/5m82XGHZNZPg0rQTQDZoZg60FuZcz9ir/xos3eG528xV2hD9a7LdOvAxtQtrf54B2kiTuamX5c3D5niY7bEvEwFXn9fKMggKlBTBJy7LhoJcbUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMP/WmKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17F31C433C7;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886594;
	bh=cRBsVA/gjcOt9pjoEuJIhQ39NaZaSPebkpAvtLwDKu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZMP/WmKWkVHoDA4SEzbQuHozY277U9i7LpFlRGHwcIi08t2EKIkkt0+lcFQaecDT0
	 4aVZl8sYhZpgIG+rI97mN+4SL6LLpk8G0ngyWrBCUfNigIhPXokLifIXdEWMXrAJ/+
	 WjAZojtuxM2OLQz+adFD6GV/C1eCw8Bp8Qlp6Mthc+AoiiaOtUC80Y9WWQh94YVG4D
	 AfK2qXWTlC98y9I6dU2CIbyICEh9rBm+j1hUBFvTXj1UCoGBbwYuFskduAn28xcNr5
	 o92nBFnkJVcC+JctCaGh9FBGEuFCR0dVyZvErN8Jvdxwgwka6Up+C+DnS2HavEISNI
	 sBXltSB1abX1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847DC48291;
	Fri,  2 Feb 2024 15:09:53 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Feb 2024 16:08:32 +0100
Subject: [PATCH v8 1/7] dt-bindings: adc: ad9467: add new io-backend
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-iio-backend-v8-1-f65ee8c8203d@analog.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
In-Reply-To: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886592; l=1193;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u0BDfBpNIPqTnjAdSKSUmF2FUWY8hltyVdK2adeadi0=;
 b=kOcJcwzGqWd41o7nmQs+taYEO+t9y0Eg8n1MWdHv7hSuLA5+xudT1MXrtCMe+kR2j2yW1F9bM
 aisMyKc6BBCCTLsqTUVMmY5yXKqLJHa7orJ4sbbiKNe+grz/YCgG1vF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

The ad9467 will make use of the new IIO backend framework which is a
provider - consumer interface where IIO backends provide services to
consumers. As such, and being this device a consumer,  add the new
generic io-backend property to the bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
index 7aa748d6b7a0..eecd5fbab695 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
@@ -44,6 +44,9 @@ properties:
       Pin that controls the powerdown mode of the device.
     maxItems: 1
 
+  io-backends:
+    maxItems: 1
+
   reset-gpios:
     description:
       Reset pin for the device.
@@ -68,6 +71,7 @@ examples:
             reg = <0>;
             clocks = <&adc_clk>;
             clock-names = "adc-clk";
+            io-backends = <&iio_backend>;
         };
     };
 ...

-- 
2.43.0


