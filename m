Return-Path: <linux-iio+bounces-22915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDCCB29DD5
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 11:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F069E1964106
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 09:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC30E30E85A;
	Mon, 18 Aug 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KndbGZR3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A730E842;
	Mon, 18 Aug 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509280; cv=none; b=rB12f32sxt+kuW14K2VWOF3XfVA+RMit2nqBpf29ISXYgrfvHd4BwGXM4M9Csy6rZgKSP+F+LGXncrhVGtRrQOfhCkXDb46Iipr6chlWodF+iEdDHqGWcKEAqGzpqt7fvIuwXvFPMCRyxih6tWzcLgNt2K83rZ5XAl6C3pCIrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509280; c=relaxed/simple;
	bh=cNmqpKBj1slJLrb+5OV5kG981wn13xEUaIe/6WOkbCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0pNgBkp153YNJc/kgrKRq3/p97GrcdQilwZqgK5n+VIVu1fmXA6C6dyuKY8kgTmnLSpw7FteKozobQS249TOozg8C+C4Axh8ZXX2oYj+DY/T1DABM8r+G2uzTwJEhLUv4oQbhAZ+pG7C/cBXT3QfF7kIEduOn0ZWlDe1LNSGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KndbGZR3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a25ce7978so8047675e9.3;
        Mon, 18 Aug 2025 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755509277; x=1756114077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRw+pAj8sfSuPQ+P3KBL1U5pvOOQDVuGVwznkOJYZfo=;
        b=KndbGZR35us+DLjt0j5aTCB2rBcRUJ7i97M2tLt7FqPdj2esL6SB2EEWybvilLHuVZ
         zNNZdpYAYMk4gx8QmENXriqNQ7Xqgvppm4vJN1+9zpkm12UWCYwPM4B2/uRH3S2Qb7Fb
         C1V1cSLzo0OlfglTcAQ29Y9GPvVOkX1VwPY3UChPAtPMcC2b4y0/thlubG7ZuM0EepcE
         qkcYwGBji/fD29G7o0aE6oIdPxvBI/jstIzGEw09nBdgT5S23chmMCD4G2tnKlsbB7hT
         46wJ16xdH2TEkDrZx5Tl+G1HdXsgcA0pGaE1aoVT2QDL60eU/Z5cZHNZ7Pc2N3ASOhHv
         BWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755509277; x=1756114077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRw+pAj8sfSuPQ+P3KBL1U5pvOOQDVuGVwznkOJYZfo=;
        b=SKNTt4YNHwW8Xml4lSYtXK2uOAUHP3U+idR2tkSKlpgdTxS7D6C1qJOehwGMi2aXz+
         alJ2m6fMvNFj5rUrD9Mk0bluVVJinrFfTVRwHZDdJme4IZunyyUSFGL7irDLyNzaiWhv
         4ZyoTzci1N5KPLdXHd7J/A1qcnobL6D8J+LobzXlCob1QXOJYS0EkPVlqRAstlFBNzv9
         clfUhUelWcKdrpqUMDODTiOBb4DksvSQK2ab2mWh0p3LeHhSJCMXdf9bR1GJBWqRdLTr
         PsnqHLBO7CahgqIjzoXl0/URAsP9WgksysgS07NvH/MnaTK3ScUyzCuqbh7zanhEPvJ6
         +sFA==
X-Forwarded-Encrypted: i=1; AJvYcCU3+CiuMkz4ireLMQ7BEd0PMWLQta9x8vV5UTkzonfMLGxvgIstMWXvZHQKxG4OZZFCf/hOaf7uZN6E2/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUpLeUQv03CXE88YT27o9EG8vARGXX9rVI0x/fy/tu0wbo2ht
	ZRlEkjMyOtWbzVfAhqDIGJxK0uUrIDbKnkh+k722w9B21nwRHi36Kutgn8WOTg==
X-Gm-Gg: ASbGncuKT7Od9vGuBfY9c/O+6NnqD/Ew1owjKd1pelUyUgIs7fd710FAq/sZpKy7gJj
	Y+fjdhqjeIOKYRyY7hN8sZo0ifiwV5m7B2/f9GVGzh/GKnFqAzqyN+S3aS9x2ryljAklNQbi4D9
	uaEtVdAJvb6ERAwosqMfQEuXA43cXe+uWyWHHQHxXR8r+/T57DLMEIw8ZPDFPiDjkGoQGyO2vrZ
	4m3RRZA+RujC+H5jp3L93y4lxejdexZmIHCmyWy7/UN7TOwPkwDWfOPQdnet1+CzBDAywwECsAS
	MvkZ2T7MgZcRX4DgE7ec/gBqT45pibA2X6QQQiGFKu6/SeZuKirLKxyxTSEx5wumu1lgutMuLr+
	xhfd2KxfGR7lqMnd6ZPFhgjmXUnXf/RCKGFE+Ev7ak3OEEr1TJBTmDMjo
X-Google-Smtp-Source: AGHT+IGS2JBy/YYF3bpAQNsAOgGAJJWB8tn2zwE1kYWtqIgjD2zA9xnW0j3EWiTP7RTx8FegbOXefw==
X-Received: by 2002:a05:600c:19d3:b0:458:c002:6888 with SMTP id 5b1f17b1804b1-45a218637a8mr76008515e9.32.1755509276629;
        Mon, 18 Aug 2025 02:27:56 -0700 (PDT)
Received: from localhost.localdomain ([165.51.41.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be10esm173793365e9.3.2025.08.18.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:27:56 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Markus.Elfring@web.de,
	salah.triki@gmail.com
Subject: [PATCH v4 3/3] iio: pressure: bmp280: Use gpiod_set_value_cansleep()
Date: Mon, 18 Aug 2025 10:27:32 +0100
Message-ID: <20250818092740.545379-4-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818092740.545379-1-salah.triki@gmail.com>
References: <20250818092740.545379-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to `gpiod_set_value_cansleep()`, which is safe to use in
sleepable contexts like the driver probe function.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 1f0852fc3414..656f6189c84c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3217,7 +3217,7 @@ int bmp280_common_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
 
 	/* Deassert the signal */
-	gpiod_set_value(gpiod, 0);
+	gpiod_set_value_cansleep(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.43.0


