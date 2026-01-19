Return-Path: <linux-iio+bounces-27949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B55D3A4DE
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8AE8300A515
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A552D060D;
	Mon, 19 Jan 2026 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IxEW5rUd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D952FF641
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818203; cv=none; b=dSXubuzohHvoo+0CdVjKcKg4583zGeX0Khvy/UICzeijQG1PehYjN7wEnVi23UQDn6JLnzSwgnsy2sD4DOIkB8xvMuHLwPfp2VLhWIB6vqTJK5coXoky9Vnl6DHVggmWabWw/sVo0Tj6zpybKVtV4/5aXA8Qjv5/tqz32fH5pmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818203; c=relaxed/simple;
	bh=b+ZyQVIas6VPm4FBmMWpHOQTnZTRtHnI8+5I56aAQss=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbWwn2J7wM9GKM7VKnQgKgQM9ZiKvpPfVLONtT1NVoQCZkaeJ1ACLDJSJEIqxwEIugvBIb09omW2VqxFhffsXdtnaPssdeduTmDFgoy0x7K3WW4hfCkXBfzYqVb8AplOJsb7eApS/ZQCi85LdArlo42aXKAvsIXfECjtKatVPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IxEW5rUd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8719aeebc8so723441266b.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768818200; x=1769423000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UYrTfACvfmfQSbbftCysBpcWH9BbAOUZt1KkI0uOVU=;
        b=IxEW5rUddT0KGrVF9mmpjuF9qhPqFe7NAqQWMekNUl2/z1ywKFc/opFqexvFpOK/uq
         uSLXOcyB9G+NZSCmYq+KqFqhpzp5r0ewZXVFgjRtT7RwPAmkB3N4O2DboxYXfri0mEEM
         LfxjcJwF33PZ2m8iAoBLy4f8OvLSao+xcEG1sYfFHsO/8a9a0VgS1Ew5WxAGSeee+yIE
         Vdcp4vWeEl5JIOoD1rwUCtfTeYcAyve4K4XDspmzRS8I7R36NeLrgIayjdp4VECT9juQ
         45J3AnAd0SxKnqw+WeiKrH+8RyQ6g0b82OB8yszWOQF/SqIR8P2jvBj41dWBUvBnzw/9
         uFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818200; x=1769423000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UYrTfACvfmfQSbbftCysBpcWH9BbAOUZt1KkI0uOVU=;
        b=GZVF4ki0lfqtmNvOll+C+DP7tsqqf5bzSzTfY14pyWvfhZ4rMHAXYkLtDnW53krx0q
         /HuqAJporuOFcYZkj0E61GrXZWlFI4YorulfuGI6WZd8OYAKUKSZUMPbRWKjRfErS9d7
         TmJwYd3+4O1Z/LyVs32NXUNWdf8XZiJYw1VI7SIxdzo3hLU82ex7YkUsopyzhE8gWAQ7
         syXRB733vYSEnh42+4vMrWUb32Uj6sEGc7hUQZlZ486Eyvgu2Y43poJ3VAPQWREMkw9d
         FbmRq0mdEjLa9JY3FZJWp6HPh4tvEWZikFxft+e83R7yZoTZp5yDmpSmByiA/nhCHBRv
         B7gg==
X-Forwarded-Encrypted: i=1; AJvYcCWhszVOP6lD3aJC0qOPdMDZJ50Nlfo19JUQg/msoYA1yr9Gak0eTIXDGkPfb2R3ZPKtQ0jW1HX7Vr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6Fxac+MfvJHoxmb3eE5P98gcP2tpngbESXr3mn6wo6nXlh+q
	poWWlNxpQRMeA37xF3s/FbYHjH4IPWN7nhKu4QDgMy0ENkAYYVgCyp/84uHeqxiz1E4=
X-Gm-Gg: AY/fxX5658N/Uiepyo4BHHSgGMcLX8Qu8+UvTtCFl2dc+aVekU6y6U+lfXNJKLIM9+2
	4TDWhDX/h/tJI1/uSdSb/j0hxXp/MimGxp3yb0sFDmAn7QPuVSdfWBBpDLBgVuO4S01jC6JHih8
	ACkXliU2b7wTITURriZtLehGpRutdcwaW15O1jjOcaOeJo2xIcBKPCV+2swDP4VGapR8gHNgR7j
	RLYq2rBMAxOTKM8gBfJsWo58RafBUB1r9RsLZ1omvqULc6VUc8hgISkoIMg0F472IaBlU5/xpBK
	8m8Lt2yqQczOcFo8RdwgwMGkOprS0wauj1RvIr58wWFvaFFVbXgJzn/CTrNXZVKWXKmBrrMtPMO
	IK1c7V0ertv36NXO94W1hvw+evUXdOAMP9w+dsJhZkKOuAJX9yFECeew=
X-Received: by 2002:a17:907:3e04:b0:b83:a6b6:ed74 with SMTP id a640c23a62f3a-b8792d59928mr807261666b.19.1768818199643;
        Mon, 19 Jan 2026 02:23:19 -0800 (PST)
Received: from localhost ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e72asm1082041366b.11.2026.01.19.02.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:23:19 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: accel: adxl380: Avoid reading more entries than present in FIFO
Date: Mon, 19 Jan 2026 11:23:16 +0100
Message-Id: <20260119102317.1565417-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260119102317.1565417-1-flavra@baylibre.com>
References: <20260119102317.1565417-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=flavra@baylibre.com; h=from:subject; bh=b+ZyQVIas6VPm4FBmMWpHOQTnZTRtHnI8+5I56aAQss=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpbgX9FkVZqlUNrnX4LtIpXBVJHXRIcY3Uiw5dN 8fSd/u8y3qJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaW4F/QAKCRDt8TtzzpQ2 X+qUC/9y8t4H8mzP+QWp13I8lR987Hrsa798RRcpruf8SdBOhpYnpwHp8ZHvqIT3kCe+dMcoEeN r3nOuzyCWtfyuKqR4eQgEwm+xPDqSJvuVYKEwCpS7sPEPSGP1bnHIp+dVwpldR1MxLkAvR36/40 SE0ZLge0hQo/H9fhtUtI/HXCRCXXyp6NLzuH37FDy8+tgjwwEm93nIvwc13dyiEPsAgN6MSiRUh aPRXqgH+Wly6X7RKt3wA+Wp0Mkyp12U04dYT/u49zgrnnASeo5tmPPVW06DcD1Kadgzpqs2a2CN L5rB5hCdkIhBVfOpoFNZbzic561Mg9cMIDUxE9PJ9dvp4nJHqdzkRPWZCGmtZnzwmy4QSpZwHkw Yr+/FJJitoE+jYuRHvEqHepkwZV/Nv4dRg5IvO8aGjvW6EczKEpXcVGsal5s7jIKejzb6M55kx+ ZHZV3/2LKQmS3tcU/yTCa3CSoBg43yWBLh7ncp5bOZyLZvGSGYMUclGxrNWrOwXVnOtHU=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The interrupt handler reads FIFO entries in batches of N samples, where N
is the number of scan elements that have been enabled. However, the sensor
fills the FIFO one sample at a time, even when more than one channel is
enabled. Therefore,the number of entries reported by the FIFO status
registers may not be a multiple of N; if this number is not a multiple, the
number of entries read from the FIFO may exceed the number of entries
actually present.

To fix the above issue, round down the number of FIFO entries read from the
status registers so that it is always a multiple of N.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index ac20fcfd4e22..650cdbffd4a7 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -964,6 +964,7 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 	if (ret)
 		return IRQ_HANDLED;
 
+	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
 	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
 		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
 					&st->fifo_buf[i],
-- 
2.39.5


