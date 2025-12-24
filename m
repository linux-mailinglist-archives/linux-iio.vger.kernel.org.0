Return-Path: <linux-iio+bounces-27348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28238CDB6B8
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 06:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32B63304A8D6
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 05:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C0C329E72;
	Wed, 24 Dec 2025 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcEuPmUk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB7320A04
	for <linux-iio@vger.kernel.org>; Wed, 24 Dec 2025 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554648; cv=none; b=P+mbaQIuAbxYr1qqxRW2YhVY3tQCRCW3icGXOgpt7OTOZ342B20WBKymcvnCztSIy0oZjss0KBIVh/I2kbNVOl48is9gk5WzkBcDZvuPxQy9tl9+7Y1Seai9RMuXcQrzHEoWvsalcbg+T8HRpfnw+eK7nauNBircbx6U73cVbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554648; c=relaxed/simple;
	bh=S8OEpcXpBEONfmjqfR3syMAXK/IV6W+U/9C5wzdJYO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evkxM/Xg+Nnxf10vIRLZBWd5uXusiDaRSrJ2RhUs6Glj/lC7k93rj9IVzO57qXQFP1cclAhAEnxIljncqhxxZV1seQeic4V9sneYOHlDmMVqwMtpMfEKJOLjcU4ZcQoJM4UbNw5q4OjL/3OaHeKbhyJdYRgzHOjF+U3nsHUQOu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcEuPmUk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5702115b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 21:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766554646; x=1767159446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKre85fWvMpDGBSufwyT7PttY316kDFDWNTXYHvVPt4=;
        b=HcEuPmUkuIoh4VnebskKdbCuJkBoeMw9TSsHqb7LjJl6OX8e+HBA6kMOA662thuk3K
         2GBgtGWoYtOI+aI9hoZZJJaY3dsNbENmz4upKczbqGGFOwEWDDAihxJ/hT8iEQwtnPh7
         6RTYMZykJMS/nAuJicKIzzrvOpZy7ZnalkH/RMIi1w1wyoIogLUr3bihDRgqUS926bWH
         hCV2nVjeW4PaASFOyGG4Ekw4AORnwzGooKoFG8/BiUrbytg4mP00ja+g8CrPZUydtD+s
         DnbofxMV6RmrtBWm37ct7ZOHtwdTzwviLEpN+tSTcvh3Ixg8tjiw3fhbuIayxYZ46zJn
         CKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766554646; x=1767159446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKre85fWvMpDGBSufwyT7PttY316kDFDWNTXYHvVPt4=;
        b=i3RClg9hfVqGTwPy/0duZSHz4GvV49BpucITOV8ifW/5Hf2en5dv9zjsxhGAvNF4MD
         CrqyNkharJcvs4pC+DW/9tbIFE5lGK5V8yYfcHzNYRjljyy7mWcEQbRStZzOTkcw7ce6
         mXOzY2ckGuE1IMAeU57ctPWG0VKUEiZ4qEDW1IzNEeev9yQ4yYPMLhQPli7l2KX8uRTS
         5J+4sshP+e9PL7ev0yK9AhQZk5Imfn9zU/vaKB2GNvYJp1JdZrXX+YQ2rhI52fF5JRzi
         1EAuvZ+vX3o2gc+4RgYknf5arsfbkLCLVl1/t8gu4oLPXVewd2WZKnI2ejuPhD+TpDZG
         R87A==
X-Forwarded-Encrypted: i=1; AJvYcCXrhM5nWytLMOcyRSrZLlo6Bw9wLtnkNuJWVqg6VdAYXCilO8LLZW/K9G2x0qNDvsAXQ3q5KF7JDtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1pokU1oVynVNRMLv1PS2ZObViH0lM4a5aGK97qbgQ75x31uk
	BrDVpO/Ms7vVlJVE9s9opPbZ+V5nMV9teJtYXO+FV5fa6173ptafGpoh
X-Gm-Gg: AY/fxX4WdlZt58VFS5KptVPnoLl6OJUHkThOoVJQ8Vl+cfpFhDANI5DDL7Dx8f7l/BC
	yQnCVF/kUzZ18gIU+Xc37UqO+AVMRgbEvbeqx56WHiQY9MYov9e/1kDnjG9Sm8Kn3XIDAW4dSDq
	1dtablgemzunugF5224A0VcyIti8mPXmg8e+eeqkJhfBYyc2GJU+rbY7lZu4DyouZRV147tiDph
	GZts37rbz0UN4GdkquhA9s5e4l/2VANEutuXsjGQTMC8paIkXsf9JT26Khk0sNX5jLlesUNxuXt
	r33V0L7lZXPkVMyiWqmzIHZhNNLpCLkgZE3uZwRtfLKE7rLrBjYySo5ADSN1xo2pFMjg3Kl246L
	AIZ6EtPmgWjAUCO+vqhewnTyiLgdJf3/76Lhj6QbPTA6fbqJJsNkpnCbFE5xr1heymBdM8v2uJ5
	FiLNk9WsYLqMGdhrCcG3Wdlo9R7CTCoYNOWaSaHVBiiQ9d6RHvT0E2X8k2jqGd4Q==
X-Google-Smtp-Source: AGHT+IE0YVTtk2SgE9YXmPr6Wu77YgrOKdJ0ETc2l2CSc8FkQap/ObHyWSek4HenW73EJBJ92pDfcQ==
X-Received: by 2002:a05:6a00:450c:b0:7e8:450c:61d2 with SMTP id d2e1a72fcca58-7ff66d5fd00mr14124818b3a.66.1766554645924;
        Tue, 23 Dec 2025 21:37:25 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e588a30sm15540214b3a.55.2025.12.23.21.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 21:37:25 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 24 Dec 2025 13:37:14 +0800
Subject: [PATCH v2 1/2] dt-bindings: adc: ltc2497: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251224-add_ltc2305_driver-v2-1-061f78cf45a3@gmail.com>
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
In-Reply-To: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=S8OEpcXpBEONfmjqfR3syMAXK/IV6W+U/9C5wzdJYO0=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpS3wQJld+NbDFA9N5+0S/qidJcVTdqVfpI0vh7
 pLlCQzdaheJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUt8EAAKCRClg0K3CVbE
 gXZDCACaqRqK3eRMByrJF31BiZ8dGooh9ilGWPCYdC6hM5CrdyCxXuH5HKXU8oVNW1XMPIiqhjH
 i/7Q88MBczxAZOVkA2tixYiLHacTOZ7Uso+3wjL5C5liKbioinDg287QPUs0AUVVpHT98RjHxfa
 1SDFLMLEJDYTFjvWSlMNgSURUJML6kJE9JOn1s1wHXxpxgpo03Xud+A53teWkzRUcgvUAMm+1ih
 SVYbNR+Ez1IxB9Xbznq3bELRYbI//yjbBgrPl68rnZw5bywWNFl5y3qsCwNvMt6mdOAtiORAvto
 gTnP3mhIKiNv4VRZF0A1X7LR6ev7VboYQTkckjimpR7LShL8
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add documentation for the 2-channel LTC2305 ADC in the
existing ltc2497 binding.
This enables automatic device tree matching for LTC2305
while using the LTC2309 driver (drivers/iio/adc/ltc2309.c),
since both ADCs share the same I2C interface and 12-bit SAR architecture.
The main difference is the number of channels (LTC2305: 2, LTC2309: 8).

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 5cc6a9684077..c884b6e03767 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -11,6 +11,12 @@ maintainers:
   - Liam Beguin <liambeguin@gmail.com>
 
 description: |
+  LTC2305:
+    low noise, low power, 2-channel, 12-bit successive approximation ADC with an
+    I2C compatible serial interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
+
   LTC2309:
     low noise, low power, 8-channel, 12-bit successive approximation ADC with an
     I2C compatible serial interface.
@@ -28,6 +34,7 @@ description: |
 properties:
   compatible:
     enum:
+      - lltc,ltc2305
       - lltc,ltc2309
       - lltc,ltc2497
       - lltc,ltc2499

-- 
2.34.1


