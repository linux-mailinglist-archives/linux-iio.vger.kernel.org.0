Return-Path: <linux-iio+bounces-23515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5278B3D222
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A9F3B1A33
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481E25485F;
	Sun, 31 Aug 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="E0KbgRZW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BFC245010;
	Sun, 31 Aug 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756636422; cv=none; b=i1Hqgc2tqK3opvwxz4WgK0X3GukzGY5FEHGVamLnaHbKQzNHhphPVYfYDJSrLexgc6/Rq8oqXEf5XpJfSVDYF4lxMunJtA51ZwecuM0Jp4HQEZINb8mssl/Lg3RJ18xMjpOYptm4XwzT7l4AtEA1LeUCWupnKtlWRIBX2ky7kxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756636422; c=relaxed/simple;
	bh=9JhG6l9aYXd0tr5rpMP/JH7+4zmVZlrSGb616SvhYjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Buc7kcXJwvIyC/2RBIlAFlTvfBOOilPn8oSyQ1qlobHtBfQTHUujXtq2HvK06TYDbBgqRMJT9kOY46w2yExz5TZ4wlLFXLjT9N+gScJagCKxUvKrmYtGia3j9nBFNtxQ/Z4O9xbwwoCrz0wap0GXZ6KCnBOETxz0XIDxWHdbHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=E0KbgRZW; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=rlGvPgM9RCjyuzqwy9Jz8R1zuOjSOwFc2U7uSTIgvLY=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756636411; v=1; x=1757068411;
 b=E0KbgRZW95vL1xuiXutYVE1TgT8oKdytvqGxh5eWODOhdzxV/KGK9njPALJJIyXqsHgW+80D
 LuR/IE3zfeYjOOcrgP3S+VX+JunHRiO9EPWEDJ4b+F1uPqW045qm3MnWqHT8C2/US6yKhE4rE5X
 9dBztiT32gyHChpQLpdpQ7b+1aYnDSr/3hSyL2scslNPKDCGIt0TOB0RpDpyKOzKhJZHUXvcqH1
 r3I+Ob3Yd6HhEUB+Nm8IZSe02/HVaLFXQVEjXS5GoVK4gltsv8vCv7jGD8gWfW/lYmnRWe21r7w
 Iww+w7BVcFpnriQXmDURH1zBqSGEPqmqt6ng07AlwW1FA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 02b68ab0; Sun, 31 Aug 2025 12:33:31 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Sun, 31 Aug 2025 12:33:06 +0200
Subject: [PATCH v2 3/3] mfd: 88pm886: Add GPADC cell
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250831-88pm886-gpadc-v2-3-759c1e14d95f@dujemihanovic.xyz>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
In-Reply-To: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
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
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlbVL5rXCz59eGsemH9ix7/Sk4zgykFW19dnXnl8E6lu
 4H7qvcqd5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBE/hkx/A8PvZ2nUKkqvFxO
 6p+aRfPWeLXbJxp0Jj/5/PzTrHLWRf8ZGV78+MPYEb44e8sDviNvHc1vxb5/udm7/fNzxzl+9qV
 TOTgB
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


