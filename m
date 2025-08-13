Return-Path: <linux-iio+bounces-22686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01820B25052
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B735A3D18
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF84291889;
	Wed, 13 Aug 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKNzH+lU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6428CF79;
	Wed, 13 Aug 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104092; cv=none; b=AX4cj0qzrYRAcKbQlX17NUDmLMeI/v+HgRnSm4oJCGFOwI319+GUEMWX1wq1yhBOaoJjKdLje6Whk5K3IVrKUulxeORnDZkNBped/ZTfD0tptVAPNRN1ApK+TnpYzPBcszZ0Jxcd00nfP8+3n+M12M5R1GxKZ6fiW0+LQuns/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104092; c=relaxed/simple;
	bh=CZw4GixnfHPXRK/UfOutcE7yqF1wjDJYoGAF9qyUGZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mw+RATT45CCC7KXOimjzrZThEK8aoP83+n/30TpW+Zeh5AaDUKJQtUxk/3YkHKXFaAYljvwdfonNkUGGVUx4IHJU0H3UgUk1dnLxVwuZ+qPRt57keDeCFV5xPQ/ZOP+oV5aOi5t+xzXgKLeWjYLlXLnANcTiXERygBzhyz+yJCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKNzH+lU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb79f659aso6218166b.2;
        Wed, 13 Aug 2025 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104089; x=1755708889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq3HEWYIpGIBcVWQoH8ungeMgw62nNqiay/iNYB/g28=;
        b=JKNzH+lU6vJ6bmSspcTcJJ2IUO7DbotTZBghbLv2Hx0Jcw8oLmZQkM9jXpL5lobTNj
         Alfp3HSidfZXx/SQuPodIPFdKKWLz7G9FkoJXNw+5oWAukLnXWed1ZOYZCtkEu6N0cxB
         5YhUY2rOxdrhzWzEhM8w6S5oEGx1XcCVmkBViLXhvnl5PRcmnpkwwuFxkPSm/WHKdsSI
         AVKS7E3Tc1CVz6z9iqq551gkPw0rwEpoycgQ+l9weHAg/e01HjKr0fwBPL7b/dMJUctp
         /oOaBnW6e5HeEAS8pntMNqRmh9FyHoJSCXoBmoFqqzvc060+/Lh++lwb7vcILUDgv/m0
         5GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104089; x=1755708889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq3HEWYIpGIBcVWQoH8ungeMgw62nNqiay/iNYB/g28=;
        b=LYt2n0nm5KifX1JXU+s8jjfyrHN/ut45F6LqVf/fe2TBq3eHZHVuyilaBtLrXasp1h
         SUcunFA7IWiqTgvpteisXZG2RSoNiT9fDJiL5kWy91XRq0X+I9Ycy1aA8PDFDC6sSgQo
         skDkzVzSwKsKStAw2CGTOYGjEMxp1vUAA9TgkHZ/7fXmzHFcWVl++r1kmRoUKYydy1uW
         vnJeJOarL31MyyEjG4ZDUMr4Z2dHErCrRcP8REqZwIBynwlVfk7J26gNQu0HxFJyAckx
         hSc72SNWuA4Qo7BuXU2uBmPZkYjY4uRpwaqGGRRi8CfLp2J/gjLCLhTwqZQPgcdZGmV1
         ia3A==
X-Forwarded-Encrypted: i=1; AJvYcCUmtAZWqGrwJxlZESxoiJDIMrn8YVCaGtaohVLnwSlFOn+e3/1VffMM/G5o32v6lwgkbrGQ9NMyLDdq@vger.kernel.org, AJvYcCX+CCv+dCa/PrRtkHfAtVX7gaDbHifmRFqC4yhRjkEIpQrKnYTLcY7x0I1dUl21eYC9XTaLl4nOOobyo6D0@vger.kernel.org, AJvYcCX+V0dGHQmpBFkuP5PgZ7GCFk1CM58yavfyX78uXwjVxREJYBK9jcK2AHrXY4W2BCYxFZZAoCUBSkd7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Qu3UUGb9Q0ne/O/ixd+NM68cinqiJGM1kJhK//TxHCzsMFoZ
	1smI+E8D34nBK8v8CDXDj9ksVayl/qT2cFLod7RbH5kH5dglFbD6vA+zDsroDQXm
X-Gm-Gg: ASbGnctfVjy9c7s+1Z4MtZDQpOMvKgxmh83Xq5xjlutTPbKWxg4VTLFNxSA2vp7czP0
	lVOfD2HGl6xXq/8SMjG7179VRsmo5KVZcM8rUrKS2YeH7w4XcwqthmTpz33mCjWvDCYvPdXCENh
	pC3FoSG3qzqIuYN5JOhtNXSGSQygqrnmGw3swgBIi5+ZRbbWYJt8FAFuN/rlCucye2WHKjnStDw
	VHOhJIJVTUroPH+KjR6RYLn8cOEQp7udrhWm2pWDqmAqJBtTn3yQ4vLJZPbxoewc0JUXfkij+Aq
	NpVv9XmiQlmGyZAev+SysbP0ffMgcmOduYlhr0t/b2Sd3fe6HRL0xbeIgCu88X1zwsWNZ3imrkQ
	+AHoU03Xve4eMST+49Nt6a0YZBaay
X-Google-Smtp-Source: AGHT+IGlA0y1/joQa4p3Sj2YnLVCr8yTrUFupxVTWZxxiSZya8P/pMzOoU4nYr2zSk0FwloEYs03Dw==
X-Received: by 2002:a17:907:7e9f:b0:afa:2772:68fd with SMTP id a640c23a62f3a-afca4e4a6ffmr314286866b.44.1755104089244;
        Wed, 13 Aug 2025 09:54:49 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm2428573766b.82.2025.08.13.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:54:48 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Wed, 13 Aug 2025 18:54:32 +0200
Subject: [PATCH v2 4/4] iio: adc: ltc2497: reorder ltc2497core_driverdata
 members to remove hole
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ltc2495-v2-4-bbaf20f6ba07@gmail.com>
References: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
In-Reply-To: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755104084; l=1105;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=CZw4GixnfHPXRK/UfOutcE7yqF1wjDJYoGAF9qyUGZQ=;
 b=C3vf+mOXfNf6r4q+oZtOpNnT6SL77d7lBwRiTccFjbBReSQcg9wS5dKzlwbjhpUdEEvVTYg8+
 9Qe0j3ESwKnBA3JHUZmBDkqOG9Mx1uHyLLedSRN6DB+VOPtJ/XgtRkL
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Reorder struct members from largest to smallest to eliminate a 7-byte
hole identified by the pahole tool, making the layout memory-optimal.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 7f53bf8b8469d2371bb7ae64ce90a61beadba9ba..578f55efc5c400980fe8bbd2b220aafb222d6f33 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -27,12 +27,12 @@ struct ltc2497_chip_info {
 struct ltc2497core_driverdata {
 	struct regulator *ref;
 	ktime_t	time_prev;
-	/* lock to protect against multiple access to the device */
-	struct mutex lock;
 	const struct ltc2497_chip_info	*chip_info;
-	u8 addr_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
+	/* lock to protect against multiple access to the device */
+	struct mutex lock;
+	u8 addr_prev;
 };
 
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev);

-- 
2.43.0


