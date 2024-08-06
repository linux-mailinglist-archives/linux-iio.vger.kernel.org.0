Return-Path: <linux-iio+bounces-8264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B10948935
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 08:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED241F240C1
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 06:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF011BCA00;
	Tue,  6 Aug 2024 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="sE4ztBlt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58292173355;
	Tue,  6 Aug 2024 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924626; cv=none; b=uDl9Y86DT2XzH1TCMO/D1TmVOAFfHQSGwPWl/O06gjpu/+HbNZwIseOtR5a0R/rrjieN3p2lKJTxm9AM+HnjKio1lC28zfsXL9s4kiO25ryLejubRaeATEGFEeLAGtNjZm9W/hmj3a2yNRcwdjHRvNbANKxLZNBit0dpE86fKEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924626; c=relaxed/simple;
	bh=/aR0rd0XPcnGk9sgCYTOVDuWkg0jv1QW76X2UGj+JVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qW5WTbRBuwZM2RDDMWSSy4Xs/ybKB8RgkSVRD51MUArKISwwEm1H6lqFmFhBP7M2DMMrtLNQ8wsO+Mh6pyXt4suhIF0eP75/j7nBnJqwMrDdBCoJqNf4pUUZrICK+6pdF8IVmCbnaOGkmX3OGILnrZxefgKYzMuil7MIVadC2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=sE4ztBlt; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.90] (86FF4CFD.dsl.pool.telekom.hu [134.255.76.253])
	by mail.mainlining.org (Postfix) with ESMTPSA id AE47EE4518;
	Tue,  6 Aug 2024 06:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1722924623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJZUmn7JyGIcTWkU35zRShPZwpKokJ9nyUFL88PGBxY=;
	b=sE4ztBltpjGLHhU3n9JW+B3KWHAx30jeMpXxToFLstxxLiScyDWuAu7beYpErx8oUD7g2a
	+Bx0k9OSdjt7NT/W4fSQSffRCmCcyF9/KRFF8wLb2SGxFeRv7oqO+P2NlY0481SXCYTvnW
	iSJQQzICG5koZBG+0ER8YaowXTvmNero2loUr7y4uV1qL+HIVCPI8vT4qDxWevZ1vyMZPk
	dIR34lYtvAWi+eBYGqM9BXBG2mO5SP0CrmHyTGdGJ59hOhE7pzaGJdlriunU7pTrdsDKoh
	SezniZjNf40Ddv21JngObuTvpz4KgTFZEMPL5u+0C7aJMKsPy52MF2NrU/x6EQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 06 Aug 2024 08:10:19 +0200
Subject: [PATCH v2 2/3] dt-bindings: iio: imu: magnetometer: Add ak09118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-ak09918-v2-2-c300da66c198@mainlining.org>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
In-Reply-To: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722924621; l=897;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=J/+B3b4VjBRnoZnfNcIcJo3x+qavQtylTR6VOAYGePc=;
 b=4PeA/OAMZmPLjGTgMN0DI/lUhq0/mli9saFlv7JmGiSnbu640SaEeHVLYyUxqmmENUyXRQ/Q/
 z/3MPfQ5jOYBz2JvERfXIwVihstC+HBpzMjUp1+OoHZuF2GROMe6U4v
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

From: Danila Tikhonov <danila@jiaxyga.com>

Document asahi-kasei,ak09918 compatible.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 9790f75fc669..583cdd2fad7e 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -18,6 +18,7 @@ properties:
           - asahi-kasei,ak09911
           - asahi-kasei,ak09912
           - asahi-kasei,ak09916
+          - asahi-kasei,ak09918
       - enum:
           - ak8975
           - ak8963

-- 
2.46.0


