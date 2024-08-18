Return-Path: <linux-iio+bounces-8575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD5955FE0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 00:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2425EB21264
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 22:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D8155CB0;
	Sun, 18 Aug 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gEVHR6+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1319A610D;
	Sun, 18 Aug 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020190; cv=none; b=TlX8achE7p+6bJRh0PSw9D/SdB4IvjfiaQK6aiAII2yJGqmJshu/koItOUArHSSrFu2TNDOWuwVel4VExHjI+pczPFCnYXwJrf/mT8OPdHCC770HuPBXNKk1YvV7QFPbeULj5lLhUtZC2y0sHQY3PuoC4DfQUw7U/8MJt2NBbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020190; c=relaxed/simple;
	bh=sVBvcItCPMl157fUaJ97j45gpoVrmYOEQ7YAli8oNKg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HiXgeipck2cmti5w8NXGj6JquYlvh+pjXC4Vbhc9Q1DQw2nHjMqX+lCJ7jvFw2ru0tp22v3s66V9/bOMckPZ25i8yawZ/bhjveUvbxC6YXQHtKAH6SWqvIoU5Ncn5d2Fb9OpHgVG7XvQrKfsmFUwucgYx5WTKZGSQMhln8BtPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gEVHR6+d; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC24970D.unconfigured.pool.telekom.hu [188.36.151.13])
	by mail.mainlining.org (Postfix) with ESMTPSA id C9C0FE44F4;
	Sun, 18 Aug 2024 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1724020181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fDdtpMhkU7ZYnNhSM/vzJlYTeLfXo6t3Fahm464i6do=;
	b=gEVHR6+dqT3VHhCJJC22K7x5cT4nWJxaryYFeuSeyPCc8uOC6yjhXf2jrj5lD6fou6s1+H
	4eL64Ngqp+d0bG/75pVcLKFq07dWfKG9u9g8Vtg8u3kwmri3siaa42CKfEbZn91gv1fWTm
	0P/wy15fkkpHvVuUnj8xqZFlc79DDDAtzVc9cLg9h8v46Y18BQKLhow+1/Ba5cbCd2ceZe
	brTOYRfwf8qXW5S2QJYc2+Jo4T2NN4pTrdlrzjhVag/fgYIH09ChWxG8Vm7dibx1/lPzEn
	1w0R8yyZP9Rb6pvIs4pjjfVO2YvzL8ECu3iN4+6WhLOvQiR9FdsJcKIP2QDn5A==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v4 0/4] Add support for AK09918
Date: Mon, 19 Aug 2024 00:29:38 +0200
Message-Id: <20240819-ak09918-v4-0-f0734d14cfb9@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANJ1wmYC/23MQQ6CMBCF4auYrq2ZtlCoK+9hXJR2gIlaTDFEQ
 7i7hQ0kuHyT+f6R9RgJe3Y+jCziQD11IY3seGCutaFBTj5tJkFmUELO7R2MESXPrHY11kY4JVn
 6fkWs6bOUrre0W+rfXfwu4UHM131jEBx4AaUqECtf+PLytBQeFCg0py42bA4Ncov1imXCTgF4q
 7UT5j9WW2xWrBLWFSjtq8zn6HZ4mqYfOwDaMR0BAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Gwendal Grignou <gwendal@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724020180; l=2196;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=sVBvcItCPMl157fUaJ97j45gpoVrmYOEQ7YAli8oNKg=;
 b=IJZteH12ghV8hKvldl/1vpbdgTnzxr6PkO+hwI6zF1lAHEKU8Gpg1v93gLnPOBKgLsLjAOndU
 fJjgtMUsQ23B9K4IhAwIVVDFBj/pSaWony0/joBq5TNYO664qqItXes
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Add support for AK09918 which is register and scaling compatible with
AK09912.

It was tested in Xiaomi Redmi 5 Plus (vince).

magnetometer@c {
  compatible = "asahi-kasei,ak09918", "asahi-kasei,ak09912";
  reg = <0x0c>;
  vdd-supply = <&pm8953_l6>;
  mount-matrix = "1", "0", "0",
                 "0", "1", "0",
                 "0", "0", "1";
};

Add a fix for data reading according to datasheet [1] (9.4.3.2.) 
ST2 register have to be read out after read measurment data as third step
because ST2 will realasing the lock on the measurment data. Without it
the next reading will fail.

[1] https://www.akm.com/content/dam/documents/products/electronic-compass/ak09918c/ak09918c-en-datasheet.pdf

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
Changes in v4:
- Fix commit title.
- Add Fixes tag.
- Add more comments inline.
- Rebase on latest next.
- Link to v3: https://lore.kernel.org/r/20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org

Changes in v3:
- Relax failure on unknown device id
for support more register compatible variants.
- Change to fallback compatible.
- Make ST2 to be always read after measuremnt read.
- Reword fix commit with more explanation.
- Link to v2: https://lore.kernel.org/r/20240806-ak09918-v2-0-c300da66c198@mainlining.org

Changes in v2:
- Remove unnecessary ak09918 compatbile.
- Link to v1: https://lore.kernel.org/r/20240805-ak09918-v1-0-70837eebd7d8@mainlining.org

---
Barnabás Czémán (2):
      iio: magnetometer: ak8975: Relax failure on unknown id
      iio: magnetometer: ak8975: Fix reading for ak099xx sensors

Danila Tikhonov (2):
      dt-bindings: iio: magnetometer: Add ak09118
      iio: magnetometer: ak8975: Add AK09118 support

 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |  4 ++
 drivers/iio/magnetometer/Kconfig                   |  2 +-
 drivers/iio/magnetometer/ak8975.c                  | 78 ++++++++++++++++------
 3 files changed, 64 insertions(+), 20 deletions(-)
---
base-commit: 367b5c3d53e57d51a5878816804652963da90950
change-id: 20240805-ak09918-4a6cfef91c32

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


