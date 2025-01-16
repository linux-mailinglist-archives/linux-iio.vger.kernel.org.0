Return-Path: <linux-iio+bounces-14394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC05A13B4C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AADD3A2BE8
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 13:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142C22ACEB;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVwJRB1b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029F1DE4EC;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035613; cv=none; b=t02k7uDotbLFlg71wngVEDQe8U1cwP2fz2heybTTeG7wQZXVmbr6QtJ895elwr/K5asI5yLYDnZrWlXTJNc5OCXNYsDLr3VNyf/ieIbvi+uxGDFxLFuRSDHOJYFbGMpLjBxvg2gdrH6xBw2h3Po8q9YeWDTwCp7ZBVYMXgyxRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035613; c=relaxed/simple;
	bh=y4ngFRv0AOBNbmFrZkhBTx2rszuk5J+ukbqnUzzOgZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pcFDvUYgaHCXQsmnF3pk6klfGH5JisIA+n+dlk8SUAFM5D47zDKb+DpZGYD1th7loK1zNbh3jVogyHDTebBoWk5XZ0tJNIFwTtacUVvndWjKGzs9I+lN96QHKqx6E/2zuHUO5tSCRFslO96OW+gyZeaAVa8gw3+D863Rlfu0Fmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVwJRB1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07A01C4CEE1;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035613;
	bh=y4ngFRv0AOBNbmFrZkhBTx2rszuk5J+ukbqnUzzOgZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RVwJRB1bqkNop3aZ96xu0OCDb3Z8x0jcEgIs/37iySndhKPh/WeDbJObEliTgTfzT
	 XPh3wKhbRecPTTC6vAjZampZO1TfqVl1AAlNBL/8gueBB0v+8oU0nRcRKZj9DTPx58
	 RyJqZjo76q5vpJvI7DDGCdkc3SaneIDhIH6aDnc9h9kLuukUIGRZnLqCtUH198ogpu
	 rzow+dPqokytsEjpSkINQQPWlGTegL1Wzhz29fuIJXtPdVDmBNRlAIcDHsVwslexez
	 0hBbXQRzRLvHDhoMCEp4fmMmn7MOV5kndY/eAeXa/L53A/vdyBJloTy9kPdXZcrIZx
	 wZSBzwh6VJSzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E944DC02188;
	Thu, 16 Jan 2025 13:53:32 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Thu, 16 Jan 2025 16:52:42 +0300
Subject: [PATCH RESEND v4 1/5] dt-bindings: iio: accel: mc3230: document
 mc3510c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-mainlining-mc3510c-v4-1-a41308b85ec2@gmail.com>
References: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
In-Reply-To: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=QPSsNqso95qPWrSIr5ihfDk9Bwjnpi3oQpu3J2o7Ics=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNI7+aPKls1232xRVLHyhqT5e94uFkMG/0zPy8eu9f89q
 PFoUm1oRykLgxgXg6yYIovNRo/ZYvnhkpOmPVWAmcPKBDKEgYtTACbi94mRYd/aIO2a01/azsjy
 XeEUO7TROfHrqWiTk3MV857c8Z7bMZvhf/D1GvU3xzOt/ktFfT95KsyvmiNdZPK34q79jU8/RXA
 3cAEA
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

The MC3510C is a 3 asix digital accelerometer. It handled by the same
driver as MC3230. Document it as a trivial device.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8c39faedfe62874d4eba25a0bf30e..6c34e4c0dcc6df5a4d8edc5effb80980de820db9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -187,6 +187,8 @@ properties:
           - maxim,max6621
             # mCube 3-axis 8-bit digital accelerometer
           - mcube,mc3230
+            # mCube 3-axis 8-bit digital accelerometer
+          - mcube,mc3510c
             # Measurement Specialities I2C temperature and humidity sensor
           - meas,htu21
             # Measurement Specialities I2C pressure and temperature sensor

-- 
2.47.1



