Return-Path: <linux-iio+bounces-14178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E35A0A8EF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF0B1679F6
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454FA1B219B;
	Sun, 12 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/c4evub"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B4139B;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683565; cv=none; b=iYFYoXU0LRNjA+EL1kKB8cA4acV9h2MxoL+25+xJmLau0uixAWmCg/qN6Ba9T0swKe2rgTWUY7wGzCE6zyWYfV195AZeLqWGRV0f2zRPc005s5aImDs5VYEazbynUmnySK3jK1s6/j2vNzDybkxN3ekGiR9PIgL1AFPRKqis1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683565; c=relaxed/simple;
	bh=/2wNdRw+WQbyfxQS3NklGacoKVAmlCPk/EFYLbVlOVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h37+tDsDlyDqbui3keS5xfq8wfcWirLE4GdKtwmJzgVSrcdHyg9TCDu9no/R582Yql5CAW3AAr6dKDVUVJxysJGKQeojvfy8MPD6WFS3AZI6r04ctHa6cMFl7K7mYpgCrLxrg04Upy3oZwvQB0eIfYL2Xi2YRgScXeTz/hdOS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/c4evub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BEBFC4CEE3;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683564;
	bh=/2wNdRw+WQbyfxQS3NklGacoKVAmlCPk/EFYLbVlOVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J/c4evub0hg5Apb+TGG3JOtwFz89BsFZYZ0oldJG85vVgfsIExaQemjUafzMbyyc8
	 CWq1YEpovcBeYCd8aSylkCf/aTmnba4m/3PJIU7DcuYLqwFfCpE3l8Wmhxf/AT4Mww
	 SvpSOCHuB0/IC7v78oznzbqknna6QMWfM2TBoB5ApHzRLm0NVIhI4IE/xEngUJbZPl
	 JibycTECtzXWiIJPTDlhYCA2JhAX/bUEnmhSTNcGuXMXl4+SJhYg63gQbG5xtmJ4Fw
	 HIh4jelpi6xfY0CGXiLbMXWTMUg7J/hNJqoylK1zn4CxB4ikjphI1LlHBNBadWbpn9
	 UkvNWn6Ad7WEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9DE7719D;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Date: Sun, 12 Jan 2025 15:06:02 +0300
Subject: [PATCH v2 1/5] dt-bindings: iio: accel: mc3230: document mc3510c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-mainlining-mc3510c-v2-1-322804a545cf@gmail.com>
References: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
In-Reply-To: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
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
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbN2jxT9hxW2Q3S+P0vDNTAoSmscfsvfgq3Mp9UsHV/
 bHiUjO7O0pZGMS4GGTFFFlsNnrMFssPl5w07akCzBxWJpAhDFycAjCR2CWMDGdZtxpInSyyZ/s/
 d2v4Bpf81z2PV1+L4tOSO5wf4PasI4bhf+6CmzxLvVssmj/NDVZqajAubV9z+szFj5nTXNPV2X+
 y8AIA
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



