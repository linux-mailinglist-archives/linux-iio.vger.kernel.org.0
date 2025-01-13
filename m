Return-Path: <linux-iio+bounces-14283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E841BA0B8EF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9516273E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71579237A3D;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVvCha9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3F3E49D;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776923; cv=none; b=SicYAl0kLgmMzFUAmYlxD6uYaYwEJUU1ior0MuIglEwTRYBE4oTSfSavYugiChK0NCJwBhSFfQZOgOwtYlqWi16+poABg2A4px8ZC2DySjy3ZPyEBQ18tvbexqx46nR1klaYbpR4oj5lkt+sPu2u1ju2pK44Iu/389f3l8uwcxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776923; c=relaxed/simple;
	bh=y4ngFRv0AOBNbmFrZkhBTx2rszuk5J+ukbqnUzzOgZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSFXWozWBoDqki0ZS4DH5XgVcQMFowEyHoJGPXKO+aTivPz6Vc3mESxFOlblyGCBD9V/uyBYteNdQ5183XHPh2cSvXLtl3Whyg1t7Fz0Bl/hgwlf0wQDosudcMoID+7CxzcYrP0RrKDhiG0T2BO5uJ4D9OYNEsHdTq6hTcxKNys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVvCha9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3739C4CEE2;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736776922;
	bh=y4ngFRv0AOBNbmFrZkhBTx2rszuk5J+ukbqnUzzOgZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GVvCha9mdczE2AVtIICDzZqQ0VvlqANXZvChje0JLzJeTt7jESZ/HigmDKCttgRgS
	 KLSiya0Gy4KK5Bopy+yPzkwTIYUrfltCbANnYRCw0q04XQrDEM3+/CnYqZD4fU1vCN
	 rl1AXSFyJhrTjvUQK63gwVL+u7n29o6vNFPyAAK18mkN9QzWI14qmsAF//L/Bx9XtY
	 6cza5sHE1EQhHHpKiAkmXGxTWqaMPRH4B8p7npP+s2l7QddDxtvKR5TjlApIXxItrX
	 HJsnVbiLKlSCT6M02kZcOFGtADDj1CZh+jzCzQ7Wf3vU37H4/RevcGxYSsrTvJgM/O
	 n3Ym72sq+V2xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBDC02183;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Mon, 13 Jan 2025 17:02:00 +0300
Subject: [PATCH v4 1/5] dt-bindings: iio: accel: mc3230: document mc3510c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mainlining-mc3510c-v4-1-4118411ef569@gmail.com>
References: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
In-Reply-To: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNJbZW5s8YlUjBEOM5Kdv/Zk8uWOt25xVvN/G128v5k77
 +T2CQtUO0pZGMS4GGTFFFlsNnrMFssPl5w07akCzBxWJpAhDFycAjCRnwEM/7NCL2YHMt8LMd62
 eYdo9+S2Rl7pjHtdgWJfRCOj59np2zH8T8lQrVpY6uipnjnlgqz9pCWi/R3qQSHiDE1ZuxRXBu5
 hAwA=
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



