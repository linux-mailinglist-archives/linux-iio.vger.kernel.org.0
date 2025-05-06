Return-Path: <linux-iio+bounces-19190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832A6AABE0F
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773B93AD2A2
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF6264A95;
	Tue,  6 May 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br2QyGAP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0744253920;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522092; cv=none; b=p1SJy30fuwwtE0h0+EVWFdOu08B4uAZElLJzn1JYSmLBONpvyMGDmDdnv16DsIA8H/q98vnlU8o0wOZH5zfUxrVJXae9QCruFlW2/VwmwpgGbpH+LzKUwN7B87sEnxjreQKiVMABwSOR18kPZGF2q+ymsOReQL6THNOEaj8pKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522092; c=relaxed/simple;
	bh=JXibkMDbejIFHci74gj1Ws/y17Lk0Z/3Sk4pdIyJ1Ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fccIhJIzfdftzW4rvHUvSQ3Ddpf7CWgtIhYx/lLss6qGD26jcq1Vp1pDAXgMkoa4zs3dZpRWHE6/0/Gmf0NUKVTNypeU5dzOvpgwgmU2vwuP9Wo4A3OCT2N58IjIlLfvDhRQafoJRYLBTyXf7dIaFqzc5jDM0ykL5obG77mx44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br2QyGAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6671FC4CEEE;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746522091;
	bh=JXibkMDbejIFHci74gj1Ws/y17Lk0Z/3Sk4pdIyJ1Ok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=br2QyGAP5SpTO3cGegug0cPGXlfnf+EPYB6GUwZb+Si8lo7bfH5+wt1XjDzmL03Mf
	 JbSsgG6D07f6hfHWgQSHo+uNUVJqZtotL2OOCExejvbHffCmNXUfuI9QXz3HNh/gfM
	 Oh9shmqRIHBjk9E9eRHwTitgJ+n/N6HqrXe8r6giYT0G0nLW0k5hcPL4hybRsyhUEF
	 hJWaT2Pi6LeWGHtpd4fGoJtv2FbCz6chsHhLAJAwnLsV8nnzKQAa/Q1T62xRdm8N1T
	 3FaMAwOWf8C6+yuhAKhR4uU90+KGuuONfSiAICgpCyD7vb+VFwSLQG8pfwtId4+VcH
	 KiB10Vvognn9g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550BDC3ABAC;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Date: Tue, 06 May 2025 11:01:15 +0200
Subject: [PATCH v4 1/2] dt-bindings: trivial-devices: Document SEN0322
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250506-iio-chemical-sen0322-v4-1-1465ac8dc190@gmail.com>
References: <20250506-iio-chemical-sen0322-v4-0-1465ac8dc190@gmail.com>
In-Reply-To: <20250506-iio-chemical-sen0322-v4-0-1465ac8dc190@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746522090; l=974;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=VzFnPjZnqjVvbbnD3sLYcomj606Uy+EsNotuByMgZoA=;
 b=bzeda0kNU7P4qJv3M+SKIDTLp39oMNEcNnm6S4gIVQtwVkIget53vfKYPX0qCwA4SOnPuwko+
 LtU+vtFaWM8CHKX8DMm3BQelXFp5+ozu4mVUHiunWHEYn46K0Q7dgc+
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

From: Tóth János <gomba007@gmail.com>

Add documentation for the DFRobot SEN0322 oxygen sensor.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tóth János <gomba007@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8da408107e55..a25bf2135649 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -85,6 +85,8 @@ properties:
           - devantech,srf08
             # Devantech SRF10 ultrasonic ranger
           - devantech,srf10
+            # DFRobot SEN0322 oxygen sensor
+          - dfrobot,sen0322
             # DH electronics GmbH on-board CPLD trivial SPI device
           - dh,dhcom-board
             # DA9053: flexible system level PMIC with multicore support

-- 
2.34.1



