Return-Path: <linux-iio+bounces-24795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 733FBBC0489
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 07:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A396189E091
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DBF23D283;
	Tue,  7 Oct 2025 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw7CWrtv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9C23D7C7
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816556; cv=none; b=qAmftb/MGu5iRzKnL9xdEWPADLM+harbPFxyBUwhg6Y2RUKtOTWCeYzu9xaqprWz7qAUSuQzGdmiXwuK628KTYoUptHzU26/bAZMdfLcfyp2xs/9Zk9Iw7ee5YxUIPtE/ujnHLsi6/D4yNZDcyEpUeqpDG72kD7aY0ddgrXZikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816556; c=relaxed/simple;
	bh=w5Dx5aQDOiYbAA5Gt08UwsESWokWabq7fndMaReOSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNFRWAMFe0NvaTgxMoHD8cWCjaNDAVT6qOpw2Ma1vX0FJPY1LhK3JeyltHC2igqxGkfNX4IUGXzfuX5UeGhMyfIYh/47ZQ1fPeZXbcKI0JI0WCG3vcf8AQFECYEuVx40P5DXhQuFo3TdVZXmCrmprshgVXSEeG+AfRXMkkYfSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw7CWrtv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so5512520a91.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 22:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816554; x=1760421354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug8n5s9iNQfFCXhW68LT+padmCh+3CgLtza9G1u1odc=;
        b=aw7CWrtvQ6r6l19naYGuSs7YcpSq1UZ9PQ+TCQBubwYiUrUKrBhhWuUL3Lzsj7JP6V
         Le3qEOAdCcN0ORmPzOGZlPlqOvfhReoeBgmnijnsT6cnG9RmtaCZwinqJeqX0rexx0P7
         FPqIvGYeWHV7I2Z5kjTxujNny9h8h+kUNZZd46ckGpIKkPeCDIqynAmMz6f1G5XcPXTs
         Ou8d+cfaTZdZqS4bSQ7kNzJsUIZWlOh41fysGtAkiLS2DJYX6lM+HeHQG92I8dUM5Tne
         2/Nz1eYikWt3dcivhPhR9q7zuB4S93YwdbUc8qTbKHbB3/cDYN7Oh0OyIhBBuCyG1K1J
         npMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816554; x=1760421354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug8n5s9iNQfFCXhW68LT+padmCh+3CgLtza9G1u1odc=;
        b=lBYC0ldjs85a9iO/GX/EW9Pw8J66Xt546QUxp53iNLwHvGKKPJK1Fd3X5JhejkKxJz
         8NN0gGsKCgKVBY0WkwnmaAZayhWsjUYtFscfwHP7+1DRnmx/mlOQHxT7tdk4dLvlrmJv
         KS6gtHTAXTnkWF5Ul9MDjMlC6Q2yJMhu4CFk4utU6BFR/dLy0qtmpmnmdNHKUOaknO14
         EGE38JCWavxnV3G5EcE05hNX7MAqG0Otw3rljLmbwp4/2MG+ZlBS00JkL4fUcSVFBlrf
         mNPXcNKzfnqcg+LzKqfJ6IEyQ7fb/5sC6bPFEm5DzNxV1EHZ+cv/r7HAuRTau6EuzzFV
         ueOg==
X-Forwarded-Encrypted: i=1; AJvYcCVgJk5wk+L71T7e28ihiiFr0g9PfptWnBoJ+ooj6QrcM6SXaTa5CdTtZK89Qcn2/bq1PlevRg7Kj78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrG3r4LC20XEdu1rhZe3ABafImPExMpk3eg1vjgib2INe+3sHn
	VGtyvDKijFTQYZvFvC2IPhDJ/AU9andWZ/TK3hh+gkn+1+CLmeEggweCTjFprA==
X-Gm-Gg: ASbGnctusSltBd76rHEXqET97fjcm/HiXWPZgyWS/RHd56LoKCCPnLDX6AC0cLK1HAW
	nf5DBGaJJGANsYHs/OguxmTsZAJ1MvNC4yfupfMl73muWpFRu197UEohLcDlX3j1513cEnOXVGd
	lSAXHkEqwIyZK+lHabZRYvMYAgg+Qb6uUBcrWSyD1hWzE3kdRYzVtoXWfGkVIGxSE62KW7OhfLI
	+J36NE/JpalX0zTyB0SrKrxeAeun9vd1oBAcDyDRXViU1K3Gbl/l4BjDMVeDesHc3btsWK3I4VP
	t0BpajbfzrAX5idVGl0njXtiJ2a95jQZ5gfKr2OaZEPtjAU6s4HP7c/6yR++pzE7O9+7UNA92yV
	dKKLi0ae53eE6gMN3jGbB8w5Dy6N7CCyKbB4IvbtuH1HhbztrYRPsTvGbunkCkRvU1dg=
X-Google-Smtp-Source: AGHT+IERCfgtjRUaQBMD0KBknY+xzV3Iu/Li7bGycfY5eWzpW/y9WlGITA+yMPag9fx+AvTtiDypuw==
X-Received: by 2002:a17:90b:3b50:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-339c278e512mr17819240a91.21.1759816554339;
        Mon, 06 Oct 2025 22:55:54 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:53 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] iio: accel: bma400: Add detail to comments in GEN INTR configuration
Date: Tue,  7 Oct 2025 11:25:06 +0530
Message-ID: <20251007055511.108984-7-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Append additional information to existing comments in the generic
interrupt configuration code to provide more context.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 1900965a1048..cf7d3951462e 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1208,7 +1208,10 @@ static int bma400_generic_event_en(struct bma400_data *data,
 	detect_criterion = bma400_genintr->detect_mode;
 	intrmask = bma400_genintr->intrmask;
 
-	/* Enabling all axis for interrupt evaluation */
+	/*
+	 * Enabling all axis for interrupt evaluation
+	 * Acc_filt2 is recommended as data source in datasheet (Section 4.7)
+	 */
 	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
 			   BMA400_GENINT_CONFIG0_X_EN_MASK |
 			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
@@ -1226,7 +1229,10 @@ static int bma400_generic_event_en(struct bma400_data *data,
 	if (ret)
 		return ret;
 
-	/* Initial value to avoid interrupts while enabling*/
+	/*
+	 * Initial value to avoid interrupts while enabling
+	 * Value is in units of 8mg/lsb, i.e. effective val is val * 8mg/lsb
+	 */
 	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 2), 0x0A);
 	if (ret)
 		return ret;
-- 
2.43.0


