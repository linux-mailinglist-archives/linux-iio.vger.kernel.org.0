Return-Path: <linux-iio+bounces-8386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE194D811
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 22:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA481C2273A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485916A92E;
	Fri,  9 Aug 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RkBcdn6i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D616728B;
	Fri,  9 Aug 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235185; cv=none; b=cPjrsGagl/4x+XCD297aOWz2fOIorDjJynW9sGOJxnGNg2AfjFghS06rNVvlKOGTJoUBTLT4SbQXcuFxgMRd9ABZvmLzSErlV2BSa/+Vu9QSS+R8zCjfeyu4YpkF6SZYU3Udj/gxMaIItVJZKbWPu5hY9ifPmVoGJmXoyxeQQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235185; c=relaxed/simple;
	bh=NfccXFTwJ51K3tWFsx7wPjDhAqA+dscULEhyIp2gPrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juQxRZGNlux/k+1IFsBKBDH2BeQajnIf3b3JV3wLhrpsa/5pUUgJkIgNPEpSf/pOA48+Lad0n4jI7ICM/70rZcfOA2mslY69IP8yS6Wlyk4KMBkn1Y14QTf1EHLp5QkmQEk9HTektVpIB9Il3ezA8DDNQKe4ws9ZAJ52tX6bpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RkBcdn6i; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC2494A8.dsl.pool.telekom.hu [188.36.148.168])
	by mail.mainlining.org (Postfix) with ESMTPSA id 02E7DE4522;
	Fri,  9 Aug 2024 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723235176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzoRDgezevgtxsVwiMOf6nbxK8OruBCqIZrAlBu9rgM=;
	b=RkBcdn6ihW3/DR+Ms2+Y05jXSkB+T2B/j6jdkegYH0PWoH/4KfZq3NSZjC/VRwovGGQDpG
	aWC6j+s3rRW23eKWlbJU8nm7J7XNojJgRFmgjobhDuV23qkHe/nHCo9iLnyCTK06N4lVAV
	Sv67zZp/F9N3Y43XC2UUJhouT0j75847Xwon76Gb8s4Kco////0/jX+ux64UpQtil5GZkr
	9LQF//5bWsbtaNDDbUwX4W/1Uu5ie0yDnuGtyhz+EHDrPHxSe63KTLu3T36P4MKHHpqNzf
	AiDW+SUPd993iB7fvuZQ7uNqbz2w1oikYILgeUS5TeKUPe5gFOQqpDZaKSdP6w==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 09 Aug 2024 22:25:41 +0200
Subject: [PATCH v3 3/4] dt-bindings: iio: imu: magnetometer: Add ak09118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240809-ak09918-v3-3-6b036db4d5ec@mainlining.org>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
In-Reply-To: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723235174; l=963;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=HFX2Yq8e+KcchqFaoKCFyeM53xTUMrEg2lLVZMBZvM0=;
 b=oAfiSCh0RHQLdbE+zLy/Ir6vTGjzuHH6Qp9osb2Kgd0bQIrGMFkY6FpM7p2cKPCpBelghwSxS
 pkWrk0aryS2DdNhnhw/27SI0NOiynY7UkynS5JlfVKbprzRurndh3Yo
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

From: Danila Tikhonov <danila@jiaxyga.com>

Document asahi-kasei,ak09918 compatible.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 9790f75fc669..ff93a935363f 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -18,6 +18,9 @@ properties:
           - asahi-kasei,ak09911
           - asahi-kasei,ak09912
           - asahi-kasei,ak09916
+      - items:
+          - const: asahi-kasei,ak09918
+          - const: asahi-kasei,ak09912
       - enum:
           - ak8975
           - ak8963

-- 
2.46.0


