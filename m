Return-Path: <linux-iio+bounces-14139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E25A0A5D4
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 21:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9341686DF
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 20:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332C1B87E4;
	Sat, 11 Jan 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quhuDFdX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149121B85CB;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736626270; cv=none; b=YT86GSPyzPBUWh0HDtrjU3Y+0RQ8QtBtOrsdI8uAp4ImakrUZQCngvXJwHeKhrzuW5miRFI+3eLzaeMYPDbqn0mOoWSVHye4kudkYiNngD2i60a6/FWX6Ndgz84H4S3ROvYbqe5t5SH2PES163oWCFOrk5e/maJaEjLi6tS8b3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736626270; c=relaxed/simple;
	bh=/2wNdRw+WQbyfxQS3NklGacoKVAmlCPk/EFYLbVlOVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2m0EYHqrNhD2GajTg4rktAvM6b/ZhZj+fMTqAxdIi1DI8EAtkTRPu1FARC9nUWOAj2/N6Z3PvUrRubRSZaHJyb9wqUi2dAfaX9VPb/93dk1I1dtksm6HUBTBFYRPE6ua0xE3+Ddf5t7VGmyXqLZWu+4pjVSqcHP5bE/6C9BzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quhuDFdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA90CC4CEE7;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736626269;
	bh=/2wNdRw+WQbyfxQS3NklGacoKVAmlCPk/EFYLbVlOVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=quhuDFdXm935tAIfZUbbP1pHprbefv8JwvifUY/5dwV35T6MjGTPq1byVml5GaPGv
	 TvTRLyODaLKqLfBiUJ5nwkITscfQB4L1ApjDEbuV/JrBmkzlFysOrCTgHYoml+SqF/
	 ttyN09S8GN3GCDsR4jsxX9AORLNSCZwku7Jnl7az2xh5Ee+ubgvKQ+wyNhONfOJ+pE
	 IF+biYeyDC3FCMVKsC3hvCxHBp8xL9RCbgLf3fUAQi3TlBfR+kc9LE3S1/5dyTUV5E
	 AvialTwMJ5+Q1Hs7bH1YQYDMaBZqT6FarWcvEcQclIf17HoKBsSEKE53MNDmggv+6Y
	 lCBz8sN1lxqIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C03E7719A;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sat, 11 Jan 2025 23:11:09 +0300
Subject: [PATCH 4/4] dt-bindings: iio: accel: mc3230: document mc3510c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-mainlining-mc3510c-v1-4-57be503addf8@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
In-Reply-To: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=kKqPGqcAMrV8Q/3yZlxILQP7a1DF7juDcij9I0w4AmM=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbLsRsbOf57LUpY1Gc8NOvEnNuVggs/qV4PsKL5f6mi
 bJqZisPdpSyMIhxMciKKbLYbPSYLZYfLjlp2lMFmDmsTCBDGLg4BWAiEQyMDC8Z1PhlP+yUbotb
 ZJYgo3bTQ3CiooDiZnc/211fAuXEtBgZ5gkvzPVpmpmaxx9378CsxprO5XYrJtXcUbP9OOt9h0I
 WGwA=
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

From: Vasiliy Doylov <nekodevelopper@gmail.com>

The MC3510C is a 3 asix digital accelerometer.
It handled by the same driver as MC3230.
Document it as a trivial device.

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



