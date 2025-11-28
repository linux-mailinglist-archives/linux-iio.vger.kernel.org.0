Return-Path: <linux-iio+bounces-26541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84870C92395
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 15:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EE13A6F9C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB430FC08;
	Fri, 28 Nov 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="czRC5pyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674071A704B
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338851; cv=none; b=NadWftAbIp2svwSmmNPVkqBulm/njYyzG5MqX9TplLvcb3LgUGpMOUIudjtcPAqYzUcWkx2yzFEsenu35lEyEMT8SSh1KC52Zg2dKNHMso75LJBgeNZp+MVsF1+BK7Eh4OqPmg+ttPXRhPpojCEijS6adD2es5dvJywFvDjIFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338851; c=relaxed/simple;
	bh=vjqzu0v5tt4StnoNCNyDfpspBqrmYEbumM18/wP+DIw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tFfTOEj3eCi5xnUFFD6r8Ln68uTscBKkpIVle2pyHr+dp5eFVz2T3WT2OGKtR6XpbGlB/2FM8ilNMbteJiEn52f2/MlcaMhlBU7tAGZM7FREVrYZ/LIK2Cs1ZsjcRpHLUXtO66JVhgbOIGksyq7oS74WsX1KOEDlEjNNns5QtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=czRC5pyx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b72b495aa81so272348666b.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764338848; x=1764943648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5UkpRiCGPKFpdbyArFO0PBT1m32KDDzxjeHksi7UAU=;
        b=czRC5pyxnapaDmpyKyKKFZARwQ6QKRC1xPpjlovWRTytNVfX71jwyxs78u3wp2PQje
         b6YdLLFPcbIizltIpGvc69p6psG53TYrdnGoMMOLfgMtvwkpgyMUi+gNZY0BXEpS5t68
         UqjJsmz8DksZnHY2CbHYGeamUyAjUEIYgNO9fXU2ERiY/9ZClOmZzRUUfVWAt2rdlggN
         NSp/Z9Z01XXTXglmoJkl8h+ZmxNDt+OYuScBzgGI11xEYZPSjkOeQvAm5GsCzONJwi9l
         qfS194DeOfeVPl3LOoTwqztfoKlx9nepPincgV8IN2qNWhRqsPujdpA/cy+FZD3DIVZb
         h9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764338848; x=1764943648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5UkpRiCGPKFpdbyArFO0PBT1m32KDDzxjeHksi7UAU=;
        b=BUoWDvAKz5ETHsEeXmCmH/q2PgxS0Ut3cex6IqrgiRTZNLE9i8wGjupabS2zPZWPxh
         FpzBW2d8cJ3orn+BExcIfLGOko7fdVnvsICEYlAzo+gQfqdvMpz1KnsaIl357QuILU4f
         Q2MIR8WFrP6nAS+3GG335i99EqKK5aula5o0NrmTeVvR7uBhmpfQAx9PvYfCeHSDV4/B
         PC2BEyVtBWjLHjPNUqrbgEVGt+ob/dtwGl91rHJCWQ1u1iaq/UQ1f/ivxMJNXsVTUElQ
         FWkHpHaeIFOPB7AgVvWpRqTo4Sl6LFt5YpIGaFQfFMgJ3Tg0LhpCVXeq2MOS0q82zB01
         9Jew==
X-Forwarded-Encrypted: i=1; AJvYcCUhU9IVgIUT2xDb5GO3skXfjMhRiyczPZi/1edcGcSCFRnmufzWOowxmxKTg88pcxZf8hSD2yNnGH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMR6ZQMGulA+JbnEic0z9MbpgVh58aS2LZjpnLCQxUIqvnGjXA
	5AGEw190Opn8/VbuWzCwMJd8uw6+5srIJGuIndCvsFjxIm1+uNBuPvJrfXF2RMUnKfvzAn3IuqR
	nMkbm
X-Gm-Gg: ASbGncvJTdxnM1VpiQw1JmRVAPY0KUnvsCigYyb1j03kik2feusfe+YmEjc4ArTa7qi
	Bx8FiSJJf6e94HGbVnIfn9/k1oRNnGIQjK3YL1d7wGNOSLEEtx0GANkzh9pOMuKApYQVs46x+vs
	e7zRjKXfUTTfHdqduIsGBlg77JPjLjxM1qlhKPMSuoqC3yn5PZmAwd0WQ8PVd35qRX7Bih9PN6x
	9xZ0HnnJ/MqwSJ7tpqH9xb5pGnfuL6ycr7Pv6C+9RzVVwBlpKlzweJqtKfwQNODDGZKZIRIahOf
	fCXliSoTqQz9OFdTNlLtqGBbTO2IxiuETvV/IzOzxaZ25YhENgcoC5kyQQQZvniXqmFQVZeuPGD
	i/VZes48Le2rDfe7x7c9io8nxnmQXfctjTFTjVCucvz0IpVHxILCyQWE=
X-Google-Smtp-Source: AGHT+IG45TBirRRhOufXyUAcMPpJm+/2+FaTXjwpfqwTtKl5tMUJWjKyJNtPojzh3B9KX0C38NUwhA==
X-Received: by 2002:a17:907:3e8d:b0:b6d:7f84:633 with SMTP id a640c23a62f3a-b76c53c0c18mr1810608266b.20.1764338847643;
        Fri, 28 Nov 2025 06:07:27 -0800 (PST)
Received: from localhost ([151.35.132.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a25fcasm450704566b.61.2025.11.28.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:07:27 -0800 (PST)
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
Subject: [PATCH v2] iio: accel: adxl380: fix handling of unavailable "INT1" interrupt
Date: Fri, 28 Nov 2025 15:07:26 +0100
Message-Id: <20251128140726.243005-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=flavra@baylibre.com; h=from:subject; bh=vjqzu0v5tt4StnoNCNyDfpspBqrmYEbumM18/wP+DIw=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpKaxOgCnzAOCy8YlUOCZrY1cg46ufw0G0wRKYT 16RlLBo5euJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSmsTgAKCRDt8TtzzpQ2 X1N9C/9/1LxIOLM3dRKqdJGAN6vW6+Xnu2lIl+6V9WWjO75dLu6XpP0MLx//0cGwz6DtMgKvMiX jDmOrEtsjl9meb4mo1EgmX9PYokk/ZRPtDdD7MmTKQYvPmuqzAl0jSfjfdkdfXk9GuaYXMM9hiN 1rLjOIrbi/3KFL8qFVj36AiMyp27sM7KoAFN5OAOW59HOaGoYp+UMuTGCJz/AcB+x/8lMxCzp2Y 4HdGZ6Pfd4QNW8IJEmpfYfoxzBuffpScCFD2z4f/H7FjQLxZK6DJnF2WffYrG2rmV3cpxyu6GGw XQ8/a4+8VAPXune9F4tm4Kr9efmb9V9n2KjP17iXHvrkeKPSpNDKoQMcE4iY0Wc9kHjrPrEjTey j0qeIQ55p6f4wvVELdnGrYAicxnKzYIkSnLv8utxu5RAxDXiSLhHZ9kcFwWG5VM6cqVGev/qHul F2VDUXRnZ5IYQcfJZ3q3Ek+Np7wsfQnpiIt+lqRCryJ85Fr9uWVQviZX9xyeuiIpo5GeI=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

fwnode_irq_get_byname() returns a negative value on failure; if a negative
value is returned, use it as `err` argument for dev_err_probe().

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>

---

Changes from v1 [1]:
- added fix to `err` argument passed to dev_err_probe() (Andy)

[1] https://lore.kernel.org/linux-iio/aSdDT4upO9shVq0S@smile.fi.intel.com/T/
---
 drivers/iio/accel/adxl380.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 0cf3c6815829..19253aae7f0c 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1728,8 +1728,8 @@ static int adxl380_config_irq(struct iio_dev *indio_dev)
 		st->int_map[1] = ADXL380_INT0_MAP1_REG;
 	} else {
 		st->irq = fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
-		if (st->irq > 0)
-			return dev_err_probe(st->dev, -ENODEV,
+		if (st->irq < 0)
+			return dev_err_probe(st->dev, st->irq,
 					     "no interrupt name specified");
 		st->int_map[0] = ADXL380_INT1_MAP0_REG;
 		st->int_map[1] = ADXL380_INT1_MAP1_REG;
-- 
2.39.5


