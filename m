Return-Path: <linux-iio+bounces-8262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA44594892F
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 08:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C8F1F23EA3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 06:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295F1BC092;
	Tue,  6 Aug 2024 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="b0F8+7Ak"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF441BBBE6;
	Tue,  6 Aug 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924625; cv=none; b=HUM0i4tZiwifzk5fLh1r/IS+/mrhjYtTwezPnLkpYzHSd6svtq5UvIy/S2X/BoCAGBWAjQWgR/VqhyhYxc9zjEPGw4ONWDfUpuqgSLzwLU5Bee+g1tsk/cTJ1ATGKQwCofhatV9VRBLPmxGiAFCmOfXc+orhhiQAjeo9/TT5GQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924625; c=relaxed/simple;
	bh=Twr+vUNDMWh20/Auw8fpCEZfivCucrMiX86KHgJbywQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b9eCLOUJE4uQC4cWaZPVJP4XeKzUfeISfY+QZVw9fnIJQ/ZFxz0S96RdcWezgWbWNtPJrhe5Eg9DCqs6O4jbMtdHIOzzxdiJIi6DRCOVOSjEx000duteGpE6ukskrhUb0be9MiJM+I4ID8l6UADJyErCPfQlIvCc/sRVGrIxZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=b0F8+7Ak; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.90] (86FF4CFD.dsl.pool.telekom.hu [134.255.76.253])
	by mail.mainlining.org (Postfix) with ESMTPSA id 4D783E450D;
	Tue,  6 Aug 2024 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1722924621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rsga1xJfJPrQXQrllrXna2pGVq+a1r3SwVz8K8iMhLQ=;
	b=b0F8+7AkbW2McHCGlf6oe88N/cNdVmiAQHErlYqd6j7tg83wyHi5MLLKFA1BXc4Pb5Ewt1
	ykIwNSDT3aIe1gSw5nlSGulO1o3vDo6HG9ZzOPyX1w6wTu3xXaCnIfpHMhphLdq/OyAN7c
	NHAMhRBIof4T3AXtSJK6ls9lI21qNT+/UJhenwbOxh+p9oTYFt97J4FZnZJzCD3Ar3i6Ib
	soGPhBdoO9svf+if7a7LmN5BZDeOqsp1kSzA1ZBk1U2D2hCHnxNXvmENd5w5m6umuDcSQN
	bSpLs9g5cxGy2wigop+DlvyzpO2x5nnlLDtHnGNkG31+Lgqzq7izcRUDU86fhw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v2 0/3] Add support for AK09918
Date: Tue, 06 Aug 2024 08:10:17 +0200
Message-Id: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEq+sWYC/2XMQQ7CIBCF4as0sxYz0GrBlfcwXSCdthMVDBiia
 bi72K3L/+XlWyFRZEpwalaIlDlx8DXUrgG3WD+T4LE2KFQdajwIe0NjpBadPbqJJiNdq6C+n5E
 mfm/SZai9cHqF+NngLH/rv5GlQNGjbnui69iP+vyw7O/s2c/7EGcYSilfPYh4F6MAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722924621; l=1562;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=Twr+vUNDMWh20/Auw8fpCEZfivCucrMiX86KHgJbywQ=;
 b=b212hznlhpeLgowt4TPrOQUPZW+lia9ELTKp05oJUNjT4y15zDHLmDGD/wvRndBwi4WFJKI88
 nq5gipUdblhDMsqi88pTyFCNLHc+rHmyN0LuSjPfCNu7B0K6oHjWKAk
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add support for AK09918 which is register and scaling compatible with
AK09912.

It was tested in Xiaomi Redmi 5 Plus (vince).

magnetometer@c {
  compatible = "asahi-kasei,ak09918";
  reg = <0x0c>;
  vdd-supply = <&pm8953_l6>;
  mount-matrix = "1", "0", "0",
                 "0", "1", "0",
                 "0", "0", "1";
};

Add a fix for data reading according to datasheet [1] (9.4.3.2.)
ST2 register should be read out after read measurment data as third step.
ST2 read out is required and get correct value during measurment data
read.

[1] https://www.akm.com/content/dam/documents/products/electronic-compass/ak09918c/ak09918c-en-datasheet.pdf

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v2:
- Remove unnecessary ak09918 compatbile.
- Link to v1: https://lore.kernel.org/r/20240805-ak09918-v1-0-70837eebd7d8@mainlining.org

---
Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Danila Tikhonov (2):
      dt-bindings: iio: imu: magnetometer: Add ak09118
      iio: magnetometer: ak8975: Add AK09118 support

 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |  1 +
 drivers/iio/magnetometer/Kconfig                   |  2 +-
 drivers/iio/magnetometer/ak8975.c                  | 65 ++++++++++++++++------
 3 files changed, 51 insertions(+), 17 deletions(-)
---
base-commit: d6dbc9f56c3a70e915625b6f1887882c23dc5c91
change-id: 20240805-ak09918-4a6cfef91c32

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


