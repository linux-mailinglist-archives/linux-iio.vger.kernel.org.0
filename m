Return-Path: <linux-iio+bounces-10418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8A999415
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9394D1F25835
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5951E4928;
	Thu, 10 Oct 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An+87Pix"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92ED1E32C5;
	Thu, 10 Oct 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594045; cv=none; b=UcMubBfS0wayQ/wbiVos7939BszwHlay3+dRAUKGURUzEKzTXosZS9BAtCEmXso4dYQMN1BQh5qmEuWbgmXtdUPKnNudTCigoqbQkwrKbxFj1aRxYygvaqHk9rs3L9F+auQmK42relB9+4ujAfqC4R3d2hLlXp+jeBH56xJkcq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594045; c=relaxed/simple;
	bh=iKTRy0aDM408uDEmw7iLMEgjvmH3/uZ18u6w+pTuA74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLvCguMOcZa9m53Wx/VupM/7J1FURE/2/rmErU+braDCx8XuHBWwzGAnQ7din1rqcO8UyKHCHjyLD3tcRGbmDuvn7M0T8bJ56Mr+IPAPZ3ufS/+iZYuPMEBIioNlZh/oMdxu95BA9jceKeIewi/yyJu26ClTF6U5hI+ewOpu8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=An+87Pix; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa086b077so191636866b.0;
        Thu, 10 Oct 2024 14:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594042; x=1729198842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj9FEguQeIhPDoauA44sn2NVEjEECXnJNgAQD1U0eNc=;
        b=An+87Pixt9xoDu9pnHlMtGqjEPvEE9XEL2XzXAJKMdvjty88ZHpMGgxr7y9aVf1KX5
         KBRrYKAV49pps418EwAS5pH0I17srlkJciCCg+Ga/fX1aBfLD8xhmOTX3ejmllpmvXWe
         eUXAxTj0O3un8rXJHVx7qhvQPcdtDJsJfdaj4J6e4R29VIYqIdjsGdKmZjyo5YAt2EFW
         wvLCQRR+FlQcsPY5GhyZMIFZlFX0MwIgEiFZwp14EEQNoP+zKVLy6cI1lqb73WK/c5ep
         bHRbrmPj02TOt9rIj6qZAP19hy78EDluHS6TTFEJCHpgZYCK444HoC2gGZ2vVBVvtU8W
         CzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594042; x=1729198842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj9FEguQeIhPDoauA44sn2NVEjEECXnJNgAQD1U0eNc=;
        b=lXj5Ewrj79Yu9+/+UdLYohThAQ3vz8HCKA8tAOTuC1uJXm32ZbnH7MJeaatBXGrUzX
         Zh3n4GjjHssoCS/ySYYZsfKcdPWmSv9vJApbdkCzayS/Fx8NPueiQ3HVFeadima32PMl
         jUsS9LiGiTUhPl2iWaPEc1u1EDCd7EzUJwjiLxCE/wMGNgqkvu1nxY9PS5qDJO7l7LMJ
         1NhSCoK9xgNeGrV2Ur85dp6uQ96Yrqf6Y83m2xga8YLD6MXETEI130j0qsZNZ9QNkvlt
         Qy1qfISHJCQltQod7yaHFyYBCgF+KnX2/EkpHjHW+/xu+ErYpuuSupb2K8NGBaPHBTis
         nhlA==
X-Forwarded-Encrypted: i=1; AJvYcCUoBkpO0aILGbEyfY5VkZWHedM5DqzQ0TnsrNR26xOC3UYpEko6AmKh874ZBLSYgAtAcfcvLkNDC2o5C0lH@vger.kernel.org, AJvYcCW5hR2r2DK65m6H3FEdgEZ/MvEZlg7SHUrf2PAKX6I9mg/Wq+uVwoWgG0RAWyZ4u2vqExNqsgful7/3@vger.kernel.org, AJvYcCXyPViBfM1uaRYTwZsbcTsIJu3uLMLnapMlr6lENeGwsBJF8A5c6mixWcyYyFmb0lMa9KciIjZn8uJz@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHJdMO2dFeSAOSObTcDQS3OFiiVUY9ed9D/hfY6tbjPpnpD5H
	OGG3h4WkiGr/TKPov3DDV+psSI8bAQu1beW7vZyguJi8F6UKYLqm
X-Google-Smtp-Source: AGHT+IHhc3zwF7g4i1T1QHEyvjDNcxiXcznQTAy1FhhK0dZOSLvzXSBukZcPWKZeGYK0IHISNFvntg==
X-Received: by 2002:a17:907:7ea1:b0:a99:7959:8137 with SMTP id a640c23a62f3a-a99b93071acmr29628066b.2.1728594041986;
        Thu, 10 Oct 2024 14:00:41 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:41 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/13] iio: chemical: bme680: avoid using camel case
Date: Thu, 10 Oct 2024 23:00:19 +0200
Message-ID: <20241010210030.33309-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Rename camel case variable, as checkpatch.pl complains.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 95a667d56527..3b4431998ca4 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -437,7 +437,7 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
 	u32 calc_gas_res;
 
 	/* Look up table for the possible gas range values */
-	static const u32 lookupTable[16] = {2147483647u, 2147483647u,
+	static const u32 lookup_table[16] = {2147483647u, 2147483647u,
 				2147483647u, 2147483647u, 2147483647u,
 				2126008810u, 2147483647u, 2130303777u,
 				2147483647u, 2147483647u, 2143188679u,
@@ -445,7 +445,7 @@ static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
 				2147483647u, 2147483647u};
 
 	var1 = ((1340 + (5 * (s64)calib->range_sw_err)) *
-			((s64)lookupTable[gas_range])) >> 16;
+			((s64)lookup_table[gas_range])) >> 16;
 	var2 = ((gas_res_adc << 15) - 16777216) + var1;
 	var3 = ((125000 << (15 - gas_range)) * var1) >> 9;
 	var3 += (var2 >> 1);
-- 
2.43.0


