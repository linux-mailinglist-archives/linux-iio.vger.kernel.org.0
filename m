Return-Path: <linux-iio+bounces-10897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE99A9049
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88809B21F3C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BD1FCF72;
	Mon, 21 Oct 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfK1gCxm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F121FBCBA;
	Mon, 21 Oct 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540413; cv=none; b=AVcFPtx4BNuDvyoze94ILkR7n3v/U6kf+delNAjb5i2y2bMG3dPLGrRtRqnS9+vkO5THq0zyDC/saW6fFa0oYBfKwxJtHmzs4KRGV6DAPGfLsI2e5ojDYAfm55Ew6g3N1LHmQsv+KsOzRAY9Sh5Ulzo0G7mua5KB2Woa3Ju47Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540413; c=relaxed/simple;
	bh=exX1qSG4caqUNRqf+dLnNnBec8h90+RnI+CYsIY98zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kwe7A+tbtZHKGx/UqDnx3uswzdLA8r4gU7dRgxsqtrz5MD8FSwvk9J0GSpxExqifb5/d3kvI60rjBHENpDAE++Ds7Ulzpjy0c1ezovh8iePQpF1R4aZr3XZ5kjLehrIhXC9t1HPwve4JjuDY5uJaXOtk2ODfOYyX2KLnEtdh5g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfK1gCxm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb49510250so46133981fa.0;
        Mon, 21 Oct 2024 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540410; x=1730145210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaHW0AqwioA5ZdhItuYlJBN63Z60C9XMxnFZsCxv860=;
        b=MfK1gCxmlDmXJCTi1mlziViLeZrT0e40K2s+mhCkDpwF67/a07zkfPs/4l+wsOc5A0
         F6oCQm7k9kQhYC9gldPWNMJyhgAewBLG1PBgWDZkYswWTnS4PHJ6yihFx2UhzzHrJRxn
         jmvLL3CPTMhyVtOOXfwYyZJ+7FdfGNdyYV9laHIwWBwqKCG15MBU10QkpZ/Q3d30VC2B
         yFnq0gGcJDhcZAxDAoqvEVGMqbBEjcP28bbRspD10312AENdT+9mVH3oRavjPsWQiXJr
         eXnzrQYkgG9frBeicm5QeUmlA7UL5LwOlu1TKbRSdqusyz7YPC4rBTGCoJVai9UlEmLR
         hAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540410; x=1730145210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaHW0AqwioA5ZdhItuYlJBN63Z60C9XMxnFZsCxv860=;
        b=upldQVQ7UDtHQXOd76eJPuaNoNP3/lWbRzSDVEluC3vVUuDJHIwUVyspRHaEFvZ4bE
         sXy+wuwlUwIzZK5lKlpd01oaiIclaPxrFJlXF00uMiOFjwi4h2p5KoA1pqhlMYr5RFsp
         YU59+w0KUWSE4Vw97sR6dA3FRsZW/g4/Hx80977wLU9yKM0wFGETNhGUWAuhpAme6cSS
         t3mxxJxfm+b//majebTmhIpR/xBPaIX4y1CSSK5q87QhwHPYMX6BMefq88VsgmrVqGfv
         NEZ4btCL2nfAdvHgF9BaWnBpXjxIdOHczoK5+AG6UEUbXp8UbPpzdUbLH833n48c7XIu
         QBlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWXMzvmeTvkqjiIS1w6hbMDGckpV5qOC2Zo+FTDWwulDZynzindj1WgLaSMdIkSs0xNP1bhUuPTwtb@vger.kernel.org, AJvYcCXdfSRlGKNvPsu6oXExaioBHn5bANrSz9rs7eaJLpC0/ILsOPD1skVRZ7dj5MOOUDXKywk4Q8VUzsir@vger.kernel.org, AJvYcCXrSS7dO1PnWQuTSo0WQz7LP2bfzMmdyk++BUDVQYn9NQVXWrjWpRhwV+4lf+CNQ0h2+jyxmMfoq1KlKIk1@vger.kernel.org
X-Gm-Message-State: AOJu0YxDck+Oxh5o5jtvdy80avx0AOteO6T9CBxQzAHZDxXM/lwgbLvy
	qcR6PNNMXSumup2O2oGXMfdr6mCqBA6jW6uLArJCmqFSFsA7vAY/
X-Google-Smtp-Source: AGHT+IGFT6DDNdiZIELy/v2zHKXoBMFfgTn6HTeYIG+9H0aoQf7VvuAEKUmuL3GgwYvVJ5JpP+K8UQ==
X-Received: by 2002:a05:651c:1505:b0:2fb:6027:7c0a with SMTP id 38308e7fff4ca-2fc932e36aemr714101fa.8.1729540409447;
        Mon, 21 Oct 2024 12:53:29 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:29 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] iio: chemical: bme680: move to fsleep()
Date: Mon, 21 Oct 2024 21:53:08 +0200
Message-ID: <20241021195316.58911-6-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new fsleep() function in the remaining driver instances.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9002519d2c33..2ff85e29bfc1 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -544,7 +544,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 			   data->oversampling_humid) * 1936) + (477 * 4) +
 			   (477 * 5) + 1000 + (data->heater_dur * 1000);
 
-	usleep_range(wait_eoc_us, wait_eoc_us + 100);
+	fsleep(wait_eoc_us);
 
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
 	if (ret) {
@@ -890,7 +890,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to reset chip\n");
 
-	usleep_range(BME680_STARTUP_TIME_US, BME680_STARTUP_TIME_US + 1000);
+	fsleep(BME680_STARTUP_TIME_US);
 
 	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
 	if (ret < 0)
-- 
2.43.0


