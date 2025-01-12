Return-Path: <linux-iio+bounces-14189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A188CA0A916
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4431885F41
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103941B372C;
	Sun, 12 Jan 2025 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh5xem92"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE881B0F30;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736684780; cv=none; b=tA6+FlbiUmodNqLH6mvKeHh/AS9ko1bT/337EAasplAI/TmzM/aqMpp/Nn5DKxXL3/mrFI6ud0BTCu1WbGGg5v/lR/aOBzyLfKjnp131YbsiLs0O+nB6LIsIWsm8lZzpBa9k8F7hPVvS5ff+0yoLKa/amQENNrkDMmwEeplAzTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736684780; c=relaxed/simple;
	bh=/2wNdRw+WQbyfxQS3NklGacoKVAmlCPk/EFYLbVlOVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgpGk5eIaO2K+rvyTVxWY+IhE+HvcxR9sTGFS5vWqSKlpncPBwjFJ42+SkJAznZp5cra6GSZQn73dmnQ2mLjJpius9+kPyigkVnB6nOMhUp0P8bDUjBVDWM8RBU/RXMXYaDUnlkssQDvxUocfJFccsfmLfi8sLMqp8S4GMh9EPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh5xem92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A3BEC4CEE3;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736684780;
	bh=/2wNdRw+WQbyfxQS3NklGacoKVAmlCPk/EFYLbVlOVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kh5xem92FDcmq7kICF7WqrQ9rEmuCmK9noJiunomPZ3av9ddmVrjkJnPdkxkv3EUe
	 oygxmuOrumcamMKC6UllCAwqaRcVY9TVcrM8KE34HDH/U9u0tn41h7JLNaukhRPyyz
	 YwhD/Sa5NjsT6ZisxfXKKPrCzk2gSFPBuv+QOBb0pcXkCZULxVsm9Ny3FIXzAQsI9R
	 mYJ7mpf3kkQvw40cGbIV5aRUI7hW2LYqs6J9M2GcKUZTYp+eVlEs1i0G5OuXm0CYbm
	 ETYA3G406XGIUhNBvnLoCkBcNvnlQhrMUnpfH6YfoR0Hmdk5KktHBnxZIYC1e2ntbG
	 aPk9Fg/c0LkOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B326E7719C;
	Sun, 12 Jan 2025 12:26:20 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:25:35 +0300
Subject: [PATCH v3 1/5] dt-bindings: iio: accel: mc3230: document mc3510c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v3-1-9ee6520ab69d@gmail.com>
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbt7yat2zhtSW6ZzhPTFqv13/kRM2uR0bM7aU7eKbyL
 1l8LshftKOUhUGMi0FWTJHFZqPHbLH8cMlJ054qwMxhZQIZwsDFKQATaQhm+MPLf3HCrxiHJVyO
 DRP+FYvr573ezf/qOkuHI1+NxMJNJ+UY/nDN22lzw3sPx4dJ7hOFDktEuno85PTdv2h94XmfWR/
 UzBgB
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



