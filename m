Return-Path: <linux-iio+bounces-5378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2708D0A09
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF851C21774
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B79168C25;
	Mon, 27 May 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsGLLUZo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C26A167DA0;
	Mon, 27 May 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835110; cv=none; b=ajGDqUbLraT65OL8qAVruahH0XrB1mJ+jRO4lVES5r0gsOiwNqE4cc2V7sKFlNiCgV2MJkzejYHjWeG4+MflN/PzT0QP2CSUOyvRx25UQxuG4A7A5JxeKpEWmJg6PkiAJ50Zsz8rB1E0mYpW+pBDo3PZISDVpsfC1pXCxaMUh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835110; c=relaxed/simple;
	bh=07ieVIzyDj0NiEB/B7poc8uFFqzs0xmcNVnn7RCMamk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLWG+WYphBdgS/uPFGZlYRShYz25NonJecfpoiv2Im7PzWsQUsdD1VHCUOIpZ6u4GwlByEG+q9StbYcgigFy/oaMtF7YyMuUXXXU1RMxA+ItSwf7KeSSioticb3SMm9LxoyXqIRj15cgCWfvlYdxNeu99HSLhxx+sG1nQUorO7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsGLLUZo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so10284966b.0;
        Mon, 27 May 2024 11:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835107; x=1717439907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ewZ9drzmQCFjZnBVwS6fu3g7oZgLJYSUNUhMXTXoqM=;
        b=lsGLLUZo3dyssiMbqpo59W5Ep/d1HpDF93C4Q1Yw8S8IsfoOiHNV2wtcuOVAPfQB41
         GdT48Z5HfjKS5FbbASmAyOQVAqqEBAf4AXFvStfoKAmiSTxw9njAbCD2YQiMzVi/g7Sh
         +/ANDXR//mQJiMrlgru73g5SSQrZMEcnTp6qnkA8OpfQ0npQMVUO3F04BAA/fhLHsy2Y
         wjZy5/WDgn4fqkcvs7GcK8K6AE6teQgLvOhA2EifPTmNu/4eQrtQ8ikQ8s8pgyaM1ei6
         3IYG+ToKTpQbC0r6o6n/Vaksb6nto9IsbL0/1mJ+SlCRdCs20m9YUbE+telRe+ByPnvX
         LbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835107; x=1717439907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ewZ9drzmQCFjZnBVwS6fu3g7oZgLJYSUNUhMXTXoqM=;
        b=hSIA/2oHX7V1/N4hmcy1Biq4BibrSMjWmLbxuPj4awnBtFa2fOVQxw3k6+eAIuENiy
         KTh+McqioJzY80d95vFvJllOXZ/vIqp9wsINCnk4yTTVxwH6pm5xFHSpBOEWf3O3OsGT
         l2b1bWccyuUU13A01N1gwHUyibnp/J59YFsyr/Xhy/pC4cIGFL+G+EsWWiizwvbYHOSu
         HpoxcV/dlUsYP0KhDBOjVRrONJhQm1IZjRu2d7ln7tpKc6LVzzogAQb7OF11o122l5X2
         7mr2myfC+lSES8RjcYhWO0Shs8EknVsB+PpLjyftwedB3SvTkWyBTjAEU2StQzND/UNa
         j4yw==
X-Forwarded-Encrypted: i=1; AJvYcCXkuXTanRVxJ1OUGpWH+90K+e9SmzUWh2+h5QwAMVqibDEPdhloevVcyYOII4ufxnGquW2JdOUUKKCl+7F+wQdaSovMGmJtEwp01RGTrCpjyeuM/ISG9vCpj2zh7QmY/dayzcxYbI2K
X-Gm-Message-State: AOJu0YxGMVQYA12To4sU1WM7wWxJelh/LxqXCjlVbMOec1xs3KHunisP
	rPvUZ5JHH3zAR+V6vwJqOfzaN7fODIvA5d3TtRiX00+a+qkxM41m
X-Google-Smtp-Source: AGHT+IH3zMh39TGvtLPwdJYWm8/FOulO4cYYbbf2Ks7QcuH0MevnMQnKRqSHgmzPrGL92Bn4QpXFOw==
X-Received: by 2002:a17:906:13c4:b0:a59:c39b:6bc3 with SMTP id a640c23a62f3a-a6264f0e4d6mr675934866b.49.1716835106799;
        Mon, 27 May 2024 11:38:26 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:26 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 15/17] iio: chemical: bme680: Remove redundant gas configuration
Date: Mon, 27 May 2024 20:38:03 +0200
Message-Id: <20240527183805.311501-16-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to explicitly configure the gas measurement
registers every time a gas measurement takes place. These are
initial configurations which are written in the beginning and
they are not changed throughout the lifetime of the driver.

If in the future, the device starts to support multiple
configuration profiles with variable heater duration and
heater temperature, then they could become members of
the ->read_avail().

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index afaa43ec3241..a91b15626ec8 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -669,13 +669,6 @@ static int bme680_read_gas(struct bme680_data *data,
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
-	/* Set heater settings */
-	ret = bme680_gas_config(data);
-	if (ret < 0) {
-		dev_err(dev, "failed to set gas config\n");
-		return ret;
-	}
-
 	/* set forced mode to trigger measurement */
 	ret = bme680_set_mode(data, true);
 	if (ret < 0)
-- 
2.25.1


