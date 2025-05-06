Return-Path: <linux-iio+bounces-19186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A014AABDD5
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 10:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C083AE5AE
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E682566DF;
	Tue,  6 May 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sj+KjBsc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED73218AB4;
	Tue,  6 May 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521635; cv=none; b=UpqwTb+XETrfEwRtwVoykw45faYej0dj1fyn6kkCK5t8hhmvDydYFOglzMA3oNakTmpLKrY2QyiX9BydaUYkaYQsL/S7NxSeUEMdhW3u3w/lYSjQTTp1VBuKtPl9NxWbgiTDSskgacONOT2/NZ9S7bgolLmlAHy71UHnDaLfYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521635; c=relaxed/simple;
	bh=1v1/rio6XCqOmkruQ3uZOyPmUNsBY2ySnofdSs8eHtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkdimhJbD+VpQfAMIxYULunuLTb5XONmoeUM8i3zddmYePQTuXpyGN/fcGaEGWSYT4tVlnyFq8Mj9PfZqyUIoZKLUKH/rm5EGN7WMCnox0ZOz6wd/t1da2GTiqdORpaeiPzjPRwuMbf6bcCEWZMX1Dik2Xb66PzNBEbAdDeiMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sj+KjBsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2FEDC4CEF5;
	Tue,  6 May 2025 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521635;
	bh=1v1/rio6XCqOmkruQ3uZOyPmUNsBY2ySnofdSs8eHtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sj+KjBsc3EKOCCg7tGFrCo7JudxhLYyzlotfwaDYxcukiayaMaznJdChHEv5YL0yY
	 ZppVGZFR4qewGK2MHXo5YoCZ79n/GFfyF5KJYMmiziGewZe3t5l2eNFBALn4bYD8yd
	 4y5/aZ76xQVTTSHwYofKxwuTL0hrCnRhysyjZF1hXuUEDDpf9LzOoPnhF7vTTzlH8r
	 GP7nZOXJbh0BSSL0XJ8+XjZYbjgEbYFXcHQ0n/JcRumMIzpL1TLSYy5hd253ZAcJjr
	 kLXoJRCpaSNho63aHEcdgLD7jgbejjJovRrJGeaa3GH914lyndVrh6V2LNs+vk0fQ+
	 75G6+j6kDdBMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C10C3ABC0;
	Tue,  6 May 2025 08:53:54 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Date: Tue, 06 May 2025 10:53:44 +0200
Subject: [PATCH v3 1/2] dt-bindings: trivial-devices: Document SEN0322
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250506-iio-chemical-sen0322-v3-1-d6aa4acd00e0@gmail.com>
References: <20250506-iio-chemical-sen0322-v3-0-d6aa4acd00e0@gmail.com>
In-Reply-To: <20250506-iio-chemical-sen0322-v3-0-d6aa4acd00e0@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746521633; l=910;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=1Mfxr5j12EbsEQWdQ2AY6ErLyezlks+9xDkOv+/nbsM=;
 b=h/n3ewsW92pesv1GFdW/DZjSabUvduncYfGqJyLtN1DVkKWG6CZqR73ITYiCRoTW+b4WEI+KE
 0FEouIuXgQ3DFyEZ71OTjpCxnoXBJwubSfbGR8u++ByGdyI7pxwBovD
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

From: Tóth János <gomba007@gmail.com>

Add documentation for the DFRobot SEN0322 oxygen sensor.

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



