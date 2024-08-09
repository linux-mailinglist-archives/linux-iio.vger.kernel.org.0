Return-Path: <linux-iio+bounces-8384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3CD94D80A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 22:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C91C21FF6
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2003A168490;
	Fri,  9 Aug 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BDGThdQT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC533D1;
	Fri,  9 Aug 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723235184; cv=none; b=nWhLLyneS9yBhnW3gBi+vrPlv1TG0hZIvZZt19ndTQfQzJWOQLcdk6ipMr2/0edaplrZGTXxbzhPEcEqACQvQfibAxZsBa0w4tNsnf2TYQFp4/qw6gbX4GwMdN+CJ8gCryK/EqGuACw3M4QLr5z+TVB1R7X5sAN+AS2uWLbIiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723235184; c=relaxed/simple;
	bh=QMZ+Egj6QHysGltqaO5TUZmxEurLkahrkTu6mGb0M10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgE62DSIBra2zFzwKzaJfE92EcC7gWYmReTk5J6eGGiCGVANLaN/7r+3rZR1i6tiglGc03kcx22ikgLzCaOhx8EmPh8gUnADwix7DbFihCH9UaCCBf4er0ZWbEns8PVHtlFqFliDmmtDGgyZoEIazwf8xuNFn/ai9Mr9vdyAeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BDGThdQT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.130] (BC2494A8.dsl.pool.telekom.hu [188.36.148.168])
	by mail.mainlining.org (Postfix) with ESMTPSA id 13347E450E;
	Fri,  9 Aug 2024 20:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723235175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX/uwe7gLLyhX5BxAiwn6XJyiK3NfzZANsu7iXkai5w=;
	b=BDGThdQTT4kkbf2Z4H1duKaGEG0mHmoX4aGQHP6QLqGFzCO7oaxwtpcNiJLvBudlmCl2Hp
	tdFJ82B2hwXPyVX2hGrAYj2Y5dJG5NkcOFn/i8agXmmmHWf88r9WowmFLcO52qdSai34L4
	w+rxsjxfvEe2k0vicgVrezEqul+2jtKDWu7iuTKpSwq2GH+xrg7bi0CxwHbdiTWzOo25kx
	Niw8gOYEe7s1g75yyndCjAHMPVKbNUAJmNK6qs73h0mIQLVCqjr9vWUTLEKHb8Vv0MbKqV
	l4AOZO5L9L09um7hH4j1G/Wxt1pwnxUmDttkRGToxKCo9p9Iih3LK9UQsda2AQ==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 09 Aug 2024 22:25:39 +0200
Subject: [PATCH v3 1/4] iio: magnetometer: ak8975: Relax failure on unknown
 id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240809-ak09918-v3-1-6b036db4d5ec@mainlining.org>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
In-Reply-To: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723235174; l=830;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=QMZ+Egj6QHysGltqaO5TUZmxEurLkahrkTu6mGb0M10=;
 b=ubxpzePyF5EI6ezZzym39xHwTJ5ZZSmT3T6d9XYWTe5vdUURBSTI8ZDrh/AJD787UqyPvi5Ab
 8ONuk9j4U3GCLJCpwaQRrl5t9fWTHu/MIlIrPANquoDvqd8qWi26I1K
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

Relax failure when driver gets an unknown device id for
allow probe for register compatible devices.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 drivers/iio/magnetometer/ak8975.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index dd466c5fa621..6357666edd34 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -484,10 +484,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
 		if (wia_val[1] == AK09916_DEVICE_ID)
 			return 0;
 		break;
-	default:
-		dev_err(&client->dev, "Type %d unknown\n", type);
 	}
-	return -ENODEV;
+
+	dev_info(&client->dev, "Device ID %x is unknown.\n", wia_val[1]);
+	return 0;
 }
 
 /*

-- 
2.46.0


