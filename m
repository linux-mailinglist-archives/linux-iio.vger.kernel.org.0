Return-Path: <linux-iio+bounces-2244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1084B5DF
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 14:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBDC1F23A8F
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5F130E32;
	Tue,  6 Feb 2024 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="HlA0d/X5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D013174D
	for <linux-iio@vger.kernel.org>; Tue,  6 Feb 2024 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224483; cv=none; b=CeX/0iCc34Q2AutFIFULORhfdTxArbp/uMqjoee3H9OJkOSlz/NXArG6oU7OYS+o96VbL+McTcaM8Scj8GEv6mpUNSZF+Fsek5fH83SKVW9R3JoNaUrDedZtbxB3+d2WpdTeQ6KzUgkfuB6ubCJVB7V/eKM9R9hc+abhlBm41kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224483; c=relaxed/simple;
	bh=lQXA3whtFGndqBJ+W38lPtZ3yGQ5+Hlm/9LV6dvwNI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SJd4T7cQy4HK9ep+/1Mz0LNIg2/8fj2fZIG9lq9RZhvy9b7+PWLcsTZkP+tZH05Za5ltLbwdTx5NCZWDWRUZ3+8pB9wrSB7VuNuvI8Sap6wB21XVZm+1uY96W1kNrZVuQy834/AjlUyXXa7eQM4pDwAWP3MPgGUvR2cNRditpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=HlA0d/X5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29080973530so4541428a91.1
        for <linux-iio@vger.kernel.org>; Tue, 06 Feb 2024 05:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707224481; x=1707829281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwuOrU+QhGdqY/THguCCrdFISX4fEOqvHfqpDmjiBhI=;
        b=HlA0d/X5cLRgaDfR3BgDZa1aTgcyo+7kBkDPwOE6Cbw5qppnxVtubmkOHMvuzwL0L1
         qbfiJkc9fLusQw/NuUoFo1Ve0osyNQ/0YU0VEbAWXCRqZKv1T6yIYq3ct1OxOuWeyIqU
         kvPMvGOl/2wOpXPYQyVRUud/5ZzhEhQrIqcX6DdOJW9E8xi3FE8d8kqaly2NAdpYRNWE
         KBeS66GYBztWagAKafa69YugWYILoBxu6R26jWVWApHRN24GJozSWbRxapr8AUBs8rBZ
         IjIpKSwibqhLfNuofi2YYfVyUZTzR24UzMuf4vD1hQrqPwzDUdY8Xxo8jeG7BOOWSHNH
         ekGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224481; x=1707829281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwuOrU+QhGdqY/THguCCrdFISX4fEOqvHfqpDmjiBhI=;
        b=FuRdQMd1Wo+qLHVgO9i0kto3WxLoGzXq9/e/+mRoPaK4Sw4sCgL0TwpgK+h/YCdWZP
         AF0pZMfryajSnH6EO/+amPpCgrc2PxRpU8uLC4xNZ1wQY79HhFHQNFqS/ChtyhhprJdI
         DXoHftm9HUQQOXRWhCjyBaII2rBKhzvj5FD6kpWv8XEhwskPe4TVUgNtCkqCbFDXUxnP
         ntOqFqr0gdPwSojXxZFJ+/tIwy0SKMdCOULV1bHy2Obld7Czn9k7D28ZdjeMlm4u+N+W
         nFj09uLwNIvDDrkOAAei8NPE6bHWgG7koKVK+NHVksjmaQO0kw8QtMyorg+g2xx6AvO0
         OtAQ==
X-Gm-Message-State: AOJu0YxB03iyqPYNq0u7QVyHAx81dKdb1jTc3hCUFczNX1s/U4v8/Qdb
	Byx6zbDkXh+82GJQ+yKltnHG9Im1AjRP7Yj/YQgDQwbIWMW5xLHqvwzjkYlkOdM=
X-Google-Smtp-Source: AGHT+IEGuDUqKlo1NsUcbxztEO1rvCaX7Dupb6AfmrixT2PmzLurRPyS1Wtd8Bz6mS6bY223mxbdVw==
X-Received: by 2002:a17:90b:ecc:b0:296:3489:6d6b with SMTP id gz12-20020a17090b0ecc00b0029634896d6bmr2199517pjb.42.1707224481257;
        Tue, 06 Feb 2024 05:01:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXI6T/McMbE9ioeYgmIZz7zJlE8VZO90i8SeZF9O0xujvc7xtVgS+83kM13DpBTsGf0lJ4ZjWMjlllP22iDy92xzf1sxStm8QKlFFIb3e+vlZvcDPuG7aNVMyLtuvRCC0j1izCzwUhk5gbajQ3OvB6lxA8KHEIGVyCnWiWgXY/PNIBqdocSN0tzkJGT9nxD+gwmppUv9OMsFiDcr8dRfxwhMx4NQ38TFfnp6KFIWajMmmGxAEwY/cZd0YFV1+eb8UMPMd+e2zjzZJ+/M5gfZtRSD92bSOZF0igLS1nYx2MQOY10afv3+whFZ/2k6MOmgjoUAgNkHBIOzrpDF9OWxMNiPX72F2dKG9Bf9IDNdc1NFB/3s2GVw066r7bc+ISJ7x5oN6Cy3NpK7g/EiQv1vY7QSvDBa/wv4rdf0kEpaVWrFAXNlpM9hQNkNNPcjoXc1v312c9uR43GmEtDYyEU187iL+HLb4bafefZUWos+wu3vcV/z3n6tn3C/uFbaVrAbNDlZWyOMa/AhucEh7hXKhb15WkXpw==
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001d958f8ab2bsm1782167plg.107.2024.02.06.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:01:20 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] dt-bindings: iio: light: Avago APDS9306
Date: Tue,  6 Feb 2024 23:30:16 +1030
Message-Id: <20240206130017.7839-5-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
Extend avago,apds9300.yaml schema file to support apds9306 device.

this patch depends on patch:
"dt-bindings: iio: light: adps9300: Update interrupt definitions"

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v5 -> v6:
 - Write proper commit messages
 - Add vdd-supply in a separate commit
 - Add Interrupt macro in a separate commit
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/
   
v2 -> v5:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index e07a074f6acf..b750096530bc 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -12,11 +12,13 @@ maintainers:
 description: |
   Datasheet: https://www.avagotech.com/docs/AV02-1077EN
   Datasheet: https://www.avagotech.com/docs/AV02-4191EN
+  Datasheet: https://www.avagotech.com/docs/AV02-4755EN
 
 properties:
   compatible:
     enum:
       - avago,apds9300
+      - avago,apds9306
       - avago,apds9960
 
   reg:
-- 
2.34.1


