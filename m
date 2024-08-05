Return-Path: <linux-iio+bounces-8253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81185948377
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D241F233FF
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A014B08E;
	Mon,  5 Aug 2024 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KWC+u9fD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FB13E881;
	Mon,  5 Aug 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889919; cv=none; b=I7w4bd1UpXvXU2UcnyQ7QO+mLSG+QVtKu4+7qgrZoFPU9+saV0jRjKdr6s68vyN8b0T0/QFVWBEmV4NqA6hMZK0man8HxGxJo4sjVW1Fwiv2DZZjZAsDD5VEEjaAZKzxAU8Z3nRPtFWq/TAfv0gEloFUKvVa6wGXB6itXcbkN/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889919; c=relaxed/simple;
	bh=wcWTdUF7pxp543qUJLKtqxEzlt5attgYp5e8aejFUnw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z2Fi0VRpA+6w9Y1jNNizjlJjjDoqlIFnaieCF4NLAeSdIfP6T2oFsL0RHLwbKiDLhPVmiZekHVaM5TnrlYvDXIyyFYPm8maGmIqhKWi8U6PUVhY2JzaGA3ZcoqfzHuneYG6gzkyLlTKqVxS10xGdcV3/34UyaBCpSUsWO0/qros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KWC+u9fD; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.90] (86FF4CFD.dsl.pool.telekom.hu [134.255.76.253])
	by mail.mainlining.org (Postfix) with ESMTPSA id 4D543E450D;
	Mon,  5 Aug 2024 20:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1722889909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xOCMdrKpdl7h6Ru9X0ts71MK/mggmLDaOG/43E+LGt0=;
	b=KWC+u9fD4V+cXJR59Pl3vSEYg97sHofc90u4KmV9//OUHJTkLspkQl+dp0AXEAGYKXh0jL
	Pf99y4k5CP8WZ7jTIG3B2TtO44+/cd74PuDDeeF6bu2JmBLceUNEolNkHwyw141upP1mN8
	3HCtYvY+tNEirQ63IkBupVLnDF9hhvj0pDiE5J49TmtJLDLSvyEQ5j1jGZzcLseHagd5cm
	LDvw8TCnAdSQc9bAYn2Q+vJhhrZ52K2OlPXQrvvcVgMbbUiNzxfVGGDCGo6KOj8StSuMkH
	7vTUhiZJCrjUqtm52nnSmSDuCITTKnK2Q5w4m+7lLTfuqPPfO9opUjUvztM80Q==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH 0/3] Add support for AK09918
Date: Mon, 05 Aug 2024 22:31:41 +0200
Message-Id: <20240805-ak09918-v1-0-70837eebd7d8@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK02sWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNT3cRsA0tLQwtdk0Sz5LTUNEvDZGMjJaDqgqLUtMwKsEnRsbW1APE
 BrBRZAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722889909; l=1406;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=wcWTdUF7pxp543qUJLKtqxEzlt5attgYp5e8aejFUnw=;
 b=vmaORWi6ibAbRRXNZODCMAxYpRJeVZATvrnzj+3p0UWT1hMKigXoW2RPFRJuguwZnClXu+gX+
 wltkpAQd5R/A/bdOndDx0UPPla+PMdiaXPaVkIbdH4YHqvJg+qFf5PD
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
Barnabás Czémán (1):
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Danila Tikhonov (2):
      dt-bindings: iio: imu: magnetometer: Add ak09118
      iio: magnetometer: ak8975: Add AK09118 support

 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |  2 +
 drivers/iio/magnetometer/Kconfig                   |  2 +-
 drivers/iio/magnetometer/ak8975.c                  | 66 ++++++++++++++++------
 3 files changed, 53 insertions(+), 17 deletions(-)
---
base-commit: d6dbc9f56c3a70e915625b6f1887882c23dc5c91
change-id: 20240805-ak09918-4a6cfef91c32

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


