Return-Path: <linux-iio+bounces-20098-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C72AC9F7F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A9B17170A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6881EB18E;
	Sun,  1 Jun 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoAXjKFo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F14437C;
	Sun,  1 Jun 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798513; cv=none; b=eVHPC6mrsumtn1NIIcEaEzcWa8DnOyZBKMJGeE7KkY5CMlhPdGC7RfPF6sMhhisL0p04KP0n8fmrttDvglweqBzL/RAGk8e2/wN6z7TacSVkahOXor0frhc+CEoh+aYCb5XDml/q+bsV31zQhZDqsZPkxLW+jn5kfN1SqzkiJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798513; c=relaxed/simple;
	bh=cKE0WSkFCIF9Brh/SnNokfm5fFpy6Et8C8/qKo9CJEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KkIdG+aZWhXwN3woqxSxJC+izG2YCpzpq0LhJRK20qqAQAs6F0P9VfVZlMJa80LaSwuzGmsAjRLhvH+2YFCrJfFlHcpA/hop5hWvNc50Ed9w5RW80Q0nCrICe0RKjxOIsBZqvoiGSmiX4zNqPNsYV8mU61/2WxNb/5m52aCkKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoAXjKFo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4f7865b22so391140f8f.0;
        Sun, 01 Jun 2025 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798510; x=1749403310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=IoAXjKFoFx9NlooSN5LfXb6QEfcWLP+MO3NzIM0Kef/GetvG+MaNbZr0WRqoAKhklT
         YtoXFCxUrw+mdC/Jju/iNMCd4waDXzLPcpO3u3u861ESkUGMOZcprbdX49rw3G7m3Rla
         1oXOwv+vIYZMwzfihhgQ9r81HGD8dd7NIq8dxu3lQ2XjqzUR9o6LeG4mWK+4MLx51I41
         5gzMO6sjAO4seD6BjTN3aXKZaPoOwAYRCZ2XhfLuIl7jO//7CKOgg9RHNGjx7N6paIvm
         J7rnXjhT6Wj3Zo6VBQrA6R9Zp0wXiLo+CvNUv4cvg+dtle3P7TDUTYrdtvde8cAoRyRs
         IlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798510; x=1749403310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=DkVC/D8b/a6XESYvqLGfAdQi0aUEbCGo0/rIMEKqHQMPEwxy9PNYCuU38djcoS1CZ2
         A9ytYxAW+Jsp5dLIJdc5+FrfZRdFA+FaNxn3AGDzk3nY51lSkOgbUmu9Kgb4Y8mAbvcC
         6qLqcBLEAB8QcGsVJfQ8tIUt6VIVkjx5SkpEvwzfByubtdhCcdQZvLyt66JzpYDHwJnO
         kPnIR1ABDaei4YEXDZJa8KWSM2jx1j5SIgxQbR9lPxUCD1+muQlCETLDhzATRvRJIuvG
         uYUHcFFWufA9CkxveYAyp2QY3BtoRlqyxyBHsqvttXb4pqqgceG4zE8Yi+KhA1BBZ8oT
         SqUA==
X-Forwarded-Encrypted: i=1; AJvYcCUPCfHDKZiaPj0U51vpw2G0swMoQx+YY0q+ANYX9vDPyVQWiNtlmtR8YNNnEIqfcLTfKH+pGAR303g=@vger.kernel.org, AJvYcCUSGBhODq/eSi0jzO9MrHABaPrSJtxN6cmb5lg2EQvAP86t3GCbhE6J0RnH/EeehBe4BEUE0RizBWWc@vger.kernel.org, AJvYcCVnXyjDjmZ4rjW/pcYkTnASyc0hZVzhC1FHJb82kWTK1oZTonan1yyTVGmIYRBCdirAXbZHVd7W8h4zF++C@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHlLIle4QV+2N1sdxzw6yuy3lowcC56pmqzxWIWUhkWB4vjGF
	JSPYh+ZzjcFcVoMjdUVHgQ33hbdk0lvml60ODTTWHZOBDl1yIhV8MBdB
X-Gm-Gg: ASbGncsXTTb2rfyxFwtjiCESf35DU7EYl7BLHBnupk+QlTLKN+EAD3/BuPvy7yxZf0C
	fDb+09ZliWBAmP4GhuLrJ5UzZjAUFD6Ld96o3Khr1jjZcYjLzh7aBA8RJgSyQvaTLezI4XWVYKM
	6NBg3/lEY6cFlXoXYHPgSdOjVDyONgxy1O+glpWgaxZaRjHQC+8m9E0zNSpLVKyXCIkfMFgOH3h
	OakJn/K6HuwoOuevP74yWWmLgT7/3lQrii5YG453qJOZ+10YvSf8htnHzzP1+wOuTaPcwwHiuql
	QZFzZS9Q17yZvnfUcdT2fZQOerGFt2Bc4oMSkq6LSRyGotU4R1J9lL1fuoKApLMPaB1m7IBy4+5
	/YOwXZuE8WGfvpzr48zE77Q==
X-Google-Smtp-Source: AGHT+IHbetBQOQhpBX6BXtD//MtmozuLRi+eqXCmjws/whkFRmCPljcO8Jf/IxUtNarEKFitZpR4fw==
X-Received: by 2002:a05:6000:2c12:b0:3a4:dc42:a09e with SMTP id ffacd0b85a97d-3a4f8961347mr2639870f8f.5.1748798509699;
        Sun, 01 Jun 2025 10:21:49 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:49 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] iio: accel: adxl313: add debug register
Date: Sun,  1 Jun 2025 17:21:29 +0000
Message-Id: <20250601172139.59156-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iio debug register for general sensor debugging.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 4de0a41bd679..2f26da5857d4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -321,10 +321,21 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.debugfs_reg_access = &adxl313_reg_access,
 };
 
 static int adxl313_setup(struct device *dev, struct adxl313_data *data,
-- 
2.39.5


