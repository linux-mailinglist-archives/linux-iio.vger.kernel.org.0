Return-Path: <linux-iio+bounces-8387-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA8F94D814
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 22:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BA82832F6
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4749D16B397;
	Fri,  9 Aug 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LG599ayR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601815ECD2;
	Fri,  9 Aug 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235186; cv=none; b=dnafMTizXUHyjfXV7hV3QeGm+jRZvIj1jH2lHIH5FqvyavYW/Q5Wub97eNT48BVBOyENXXFTulk7XXo+CwkH06cw5ig58GFpnIsezJqGdn60G3XSZV6dd0Dso3unLHStDuXlblcxKoQuwAUXJatDKFa7wjZBfof2NoI/jEKSOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235186; c=relaxed/simple;
	bh=pJOj3I+1WYRt4u/xk9Puogg+uhLXAydx/fsPRWIpHIs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lm0Pi/+9Oi87HUUno/wm47fFndkW6yhE2rT89XBZVY4xGvaWsep5ip5XEjBtUxtSV2HgXQSn1rVx1AoiUyT0bX8n1ZTyfzqmg1McqqdfFBX+4vc4BWenRJyw18yVH60/rKVgp4s9bdP/CFJurU0hVdJIY7Og8Sa4NUf14nUq5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LG599ayR; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC2494A8.dsl.pool.telekom.hu [188.36.148.168])
	by mail.mainlining.org (Postfix) with ESMTPSA id 2514FE450D;
	Fri,  9 Aug 2024 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723235174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3UpBynITifOtGQ+JTyMz1lNTDAi+fw+DIc0dQaABNH0=;
	b=LG599ayRAVk+9hbZF/ZYdcNoI3fDd43ICq76jYgx7XteURLzUokl5zqwQkBUcODDMeg+l4
	SV2UfhvJQ8yKXLcPHzm7aJYuAk1SYTOtBIkmz6mhXPyBn5VSTXS2wmMVqNksBW3ocUK3IM
	0jK1gO6z509zN8cAr9cqqhnETB2jw3ZNgfBL2OzZD29XL4S+QcvWC8XF/QZzP+k2u/3BNE
	6avt3sbS5saqUeQ8BVbh2GNf4e3C3XCDx4DmAHIk1JWDVNodd4FPQiKShJn5PRvS/isbgb
	QxlFsXrWSS+dK4Sov14ZwbfwU7e2CyYoygTpqn3nIg25x0fq4DLFJIJxgY1mvw==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Subject: [PATCH v3 0/4] Add support for AK09918
Date: Fri, 09 Aug 2024 22:25:38 +0200
Message-Id: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEJ7tmYC/2WMwQ7CIBAFf6XhLGaBSqkn/8N4QNi2G5UaMETT9
 N+lvWjS47y8mYkljISJHauJRcyUaAwF1K5ibrChR06+MJMgazBw4PYGbSsMr612HXatcEqy8n5
 G7Oi9ls6XwgOl1xg/aziLZd02suDAGzCqQbz6xpvTw1K4U6DQ78fYsyWU5b+sf7IsslMA3mrtR
 LuV53n+AprfsEPgAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723235174; l=1997;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=pJOj3I+1WYRt4u/xk9Puogg+uhLXAydx/fsPRWIpHIs=;
 b=sWT1Nxhak7TPGFUxcri9Iiy1f9//zEmFuuvgE+bySYGFdiAJAH7d9Cqp4/nxfqxli5ZxRUGAy
 HJwVyQwAi8YBNHBTFRaXG6beRf09dnqAfs3KBnDr26x+lMnYCAXDiqI
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
      dt-bindings: iio: imu: magnetometer: Add ak09118
      iio: magnetometer: ak8975: Add AK09118 support

 .../iio/magnetometer/asahi-kasei,ak8975.yaml       |  3 +
 drivers/iio/magnetometer/Kconfig                   |  2 +-
 drivers/iio/magnetometer/ak8975.c                  | 73 ++++++++++++++++------
 3 files changed, 57 insertions(+), 21 deletions(-)
---
base-commit: 61c01d2e181adfba02fe09764f9fca1de2be0dbe
change-id: 20240805-ak09918-4a6cfef91c32

Best regards,
-- 
Barnabás Czémán <barnabas.czeman@mainlining.org>


