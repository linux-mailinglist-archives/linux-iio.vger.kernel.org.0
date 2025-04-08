Return-Path: <linux-iio+bounces-17838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85560A8172C
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 22:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6591B8729C
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16330254AEE;
	Tue,  8 Apr 2025 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="H4VBnPeS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8199253331
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145449; cv=none; b=YP4AiWbHJAUbdOoqMHr09z73BqBpY8BgRWvD0//a4Esne0af5xWrrJpXllD2pZ7jAKP7dIZwCEx9lV/tHrqIhwoOWGL12zy2L9T7OL1smvckul8hGx78x/QBc44N1T1sy9WyVC+xwO4fTLVXs5B5PDU2FiyHfZoG/gHw/KjqJB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145449; c=relaxed/simple;
	bh=u6I5ChrGSsaC0BcEBjsNrdJcdIq+wMAYxy5QhBHr4rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EF+dTZFu5wGyKa6yGuwiZD153M8gQzczwJQ+uJ9kx5lNPu1fFDl2C0pkNyp3sOIutEE3OHv13YcNppmV/jwuQs6rQt0wZT8y2b1h3T+B1nYR6YXeHuIa4s3PUzXL+QtXtxWa41quaaqLKc9YmrKLijpGxbC2pJ+Jtzjc/idIqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=H4VBnPeS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso49833f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744145446; x=1744750246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PwO7TFjGXlLsI1pbG0l9bXuBqPlwUh0ZLM72PzotzQ=;
        b=H4VBnPeSybdUl23PWSPNo6QvilBDE1e0pqyu8pcci4zOwQnerZ8I0RzzhFBjt7pxDJ
         4A94yMEZf4NWG8K6TmBRkFeOFNJFFJYmiXzzc+1ADYBdwrLUzbeO00WfXftGJ4beLtPe
         ClVpd4MxEkxZ0aL/+WAjjTNcQxSwrvMO0SIHPCYWJxpNBO3oT5PQ1Fi5zxvQgBmOZSLV
         ClDfTJw0wiNXNQ9W7/RpMn7bt6q8gTQbLz79nd8cKeg5BXv52Gq0+WbL0Eib/waokuX6
         Rke/iY6AQmO7csSOAAAqRssD+lVYkiR1UMSHioNBO+nY9IRbu/hqOusQBsrFlXZwENxu
         X6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145446; x=1744750246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PwO7TFjGXlLsI1pbG0l9bXuBqPlwUh0ZLM72PzotzQ=;
        b=txlK/lPv3CmoGTWWtrEqFgGiC3Q4rpp5Y8NCcMSyL6hwW93VPhxlzU4oIgtniA0OqP
         rA4MtoK+tQi36PgaeG2UCgQBcItWOrp21neqSfOQf3HZkRmIrrVO++9fSAtYgdwLjK/Q
         l5gM7700r6JtnaIv7KADYwVoyuoA3HikpNXx/qCupcPDh+PknvY/lS4zjb3o5aGTV+iR
         wJCG71VbyCL5ff/Wmw5tDtPJ18RRkIaDGpK/hFNS5Ow7U1rJU0WAMkGCL0RwifUFEcxy
         aZVvIdTomLcpCFqR2T4QP3xKGuiMbhq2Y4ueOKUFmd1+kQNMLs56cQbS+K8U92y4OjfB
         YPCg==
X-Gm-Message-State: AOJu0YxnZyhZ6igOjA++qTGjdZd9/W2sdJZTQkPX6NsJrheDNEa4u7SB
	etvqqtN53DOrD4F26wbK7HoqYVHwLMI4wtd6xBGNSMgA/0HKM4inUgnnc8BrW5Y=
X-Gm-Gg: ASbGncv7QPzZQacVTy+t9pN3xHEaUICOmqDL1jy9tp/ikVhonWIHlqlPEUpa6AW6rBi
	MpJvnxM1Fv9k7xag6UDqiVbuhueXoDuBVf1CFWpKeKgd1DKNNQ4Pn22nL3R9gn142yLcWGa00Tx
	GRCYYWNA+Rq971FyMPYuFstUd6SxZrPpcekGsT20dGEDxvjOffUeVKOC3X6VMgFU/NmHXdIhJ4x
	O7frenMT0JUpsFB4amPWm9AN/uMf6Tm45biIuy2CBWmFaLJc/028xMeJbG6q0JjRO+/2kIbBccx
	Wxx3z1k0KGIwl+Zy9NJIlfE5AaniEX6TGAP5FI20UVPwXw5ZgwF+HGJ3W16Si6g960Lm1/a55HZ
	Howquc9YuvIU3bCtKK0fY5w==
X-Google-Smtp-Source: AGHT+IEYxqvRXJ2S4Gl2VcSiuafn5XShzbd30+YcZCFT7BH83PBXNJjmg0XOVZRu0H0lq0AcWvjg6g==
X-Received: by 2002:a05:6000:144b:b0:391:21e2:ec3b with SMTP id ffacd0b85a97d-39d87e84c8cmr353155f8f.3.1744145446022;
        Tue, 08 Apr 2025 13:50:46 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226da7sm16367156f8f.98.2025.04.08.13.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:50:45 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Apr 2025 22:49:01 +0200
Subject: [PATCH 2/2] iio: dac: adi-axi-dac: fix bus read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-ad3552r-fix-bus-read-v1-2-37add66aeb08@baylibre.com>
References: <20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com>
In-Reply-To: <20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com>
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=983;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=o6accVuWI6TL7qRXk6sJ34qloa1W0T8BNTkGAf2YT1s=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/2n3I/3ZmsH2Q4H2xfxuPHgvU/8HPm3Mz0VAl91Ok1
 fL+/LUvOkpZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAExkWjnDb/akY7tWCB8Sigpd
 8tp8znSb+5cDHX4KTJM607KiSodzIyMjwx7/kjseW/dtyXlbmrPZT8q791KXZMvc1kXvDuw+0ct
 fywAA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix bus read function.

Testing the driver, on a random basis, wrong reads was detected, mainly
by a wrong DAC chip ID read at first boot.
Before reading the expected value from the regmap, need always to wait
for busy flag to be cleared.

Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 91557aa6797a3478de3607e5733c162d7745a3b2..de959ab116e26f98385d5f5c259d6d1e01a448d9 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -780,6 +780,10 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	if (ret)
 		return ret;
 
+	ret = axi_dac_wait_bus_free(st);
+	if (ret)
+		return ret;
+
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 

-- 
2.49.0


