Return-Path: <linux-iio+bounces-23769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F4B4558B
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365E4A00868
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8987342CB6;
	Fri,  5 Sep 2025 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="NuM0vW9w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326F22D4DE;
	Fri,  5 Sep 2025 11:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070093; cv=none; b=e4aiKigzmbRni6lzBZN1+r4TR8H/QkTcaThBqW5a+UUJCAsSa796CpBFlCQb0sdwhosfenR980AVnFhOqxCmemfUsIcm0mND99uWZbJRY+rZX4kJTtyAOYyHPGrV5VwzYE60B1Z/unO+x4EzZbTo/nUk10qwytvC/smD/5iY5gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070093; c=relaxed/simple;
	bh=9JhG6l9aYXd0tr5rpMP/JH7+4zmVZlrSGb616SvhYjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ls28TogwNwjiMH4nNKekhUej47e1RkAlTmurRq1cNb8UReY/JM7B7FCvFOhZvY2o2sJIqnv1ZwbshZf15KK5Q8lGZhnKixWVNL2MJJvATRAYhY4D/gWo7tOlRMGx92nSDmW3jN9d2dd85PaLQF28ZoZhI1FLBvY+uAGbFIuH+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=NuM0vW9w; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=rlGvPgM9RCjyuzqwy9Jz8R1zuOjSOwFc2U7uSTIgvLY=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1757070067; v=1; x=1757502067;
 b=NuM0vW9w+Gg2NWMN6lw9uHVc8GTJypF+Yj+Z5X/pA4Qd2KHT6QqOFPEU+/wnYxZBIKhrjFQ/
 YztAcMSOmmGrlEO97CdbuBqM4/EPLSFJaSqO/lmjheL1CeWvQ4m89Q+qNvYZNETKJJIqK/pvdBI
 +035Nrjy5DzXKNS8WMeVxznUNpa2t8XleCdsdAuxfxacocYBJn2zOH7pW54mKAQv3qnc3SDF9mY
 DRC1ohaSPiCFZyWbJhbgZo+bZTJcOz7YCkOcXN/UJxqvi4w+Sz4YfJVM0B+arcQGBpjd+dBdR6F
 8+FDVWWZ+EXP83kjJe4sW06HnmSP18GQcliqcNbViynCA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 87d9ab46; Fri, 05 Sep 2025 13:01:07 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 05 Sep 2025 13:00:56 +0200
Subject: [PATCH v3 3/3] mfd: 88pm886: Add GPADC cell
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250905-88pm886-gpadc-v3-3-4601ad9ccb51@dujemihanovic.xyz>
References: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
In-Reply-To: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=9JhG6l9aYXd0tr5rpMP/JH7+4zmVZlrSGb616SvhYjU=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBm7Dr3Xy0yODL2z/MzlH+mPjKXX7JymPi3669KGOvaDd
 l5272aad5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBEUp8w/FObwZheky7V/PL/
 3K0TOWp/hdvrp19IMHy2LmXamkShAmaG/yluL5/anD6cF9ZuYcIyNd/2g5NW4N8LlslzrKb8Dq2
 X5wAA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add a cell for the PMIC's onboard General Purpose ADC.

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v2:
- Sort cell names
---
 drivers/mfd/88pm886.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/88pm886.c b/drivers/mfd/88pm886.c
index 39dd9a818b0f0e1e5839f76768ff54940f4cefa5..e411d8dee55420e10b6d7ad7069576c681360de1 100644
--- a/drivers/mfd/88pm886.c
+++ b/drivers/mfd/88pm886.c
@@ -35,6 +35,7 @@ static const struct resource pm886_onkey_resources[] = {
 };
 
 static const struct mfd_cell pm886_devs[] = {
+	MFD_CELL_NAME("88pm886-gpadc"),
 	MFD_CELL_RES("88pm886-onkey", pm886_onkey_resources),
 	MFD_CELL_NAME("88pm886-regulator"),
 	MFD_CELL_NAME("88pm886-rtc"),

-- 
2.51.0


