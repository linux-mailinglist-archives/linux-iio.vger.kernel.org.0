Return-Path: <linux-iio+bounces-8095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D241942EB6
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 14:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B715E1F26892
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 12:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5001B0105;
	Wed, 31 Jul 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOeOvseS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D331A8BED;
	Wed, 31 Jul 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429451; cv=none; b=PF6Thtz1F2pV1Gr1kG8eCM6Tq5FZyiFMe4q1FVoRTlOgdC4Ia0TSYoRGfh9ydbnrZZdBpDDY4XqEjChFNsWNvSH8yURxUBrT9gVaRQ6Vs3rOCCnDXI/EZpszVrEwj6368FtZLbOSW+wTiQBShVB0/tX7hrCAZG54IO4Dw2voLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429451; c=relaxed/simple;
	bh=pAZDjeecp6rsXv/22TRVi6mFQYwYZQxzVZ7EkKQ7Log=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfYl7/t75OYveWdvEqM4gpqSCLvc1qQ1BUsa38rS2VKG1+Y9hNVkyLYt6yPlSXmibPGIsnl9JdOcGZ/sDTDEHyRsMlkri2eUdpnLB6IQ1Vs/5tGhy2AsX/iz7GSPlc0MNJS8KL6YgDWzJqzojWRIJeRzo8xaCopQQtMW2abtrEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOeOvseS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428141be2ddso36651545e9.2;
        Wed, 31 Jul 2024 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722429448; x=1723034248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzcBX9trXfq2k2br88kZQvGfopQSzgfszubMVwGQIRc=;
        b=FOeOvseSJc4GZeg5tCfraZYUwbIwucWtp/PF8vYYlAqJ6Iu6I3mYIlhiGXDdwA8zgF
         zaQWdmPq1xsUlELcy4R7Au965FDa43o/fUzCY1DlbXlLIeMlyCE5K/dH5cCqzvh6biTk
         yUxlu3yFbETJb2MhGtz1KwmC1cojabXhDvEBAXt9rVfh2FnQFSLfFWczuWs51lbw5UrG
         dL1w0kfwGHvSHZCV3BqXBr+ax3ijD6cl79qxINPWw7jBaZ8BJt0p3r4rKaOhTgJwZX2v
         3yoEprhjw/tifICXqoK3X6oWTJAJshv0lEiS15sPJZvythlDxV5CHHcAsTCzRUxWELhn
         nsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429448; x=1723034248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzcBX9trXfq2k2br88kZQvGfopQSzgfszubMVwGQIRc=;
        b=HR7+IkuoQAq/N3+aexpx0Uu3CJ83FbtvAtHhAQXBUX9Rbz0gvQiPmNvJe88ymlTGrp
         NbW9PKQNnHIPlG8oTA3i8/SXgiKsikaakH83nWdYn5jR3gikDozg7Bz+19euA0NOOYda
         9CxOMpdSonv4grsV8rOJcm+/VtQNJz5/dfnvNuFCA58MWY5INz1Hex01LmKaaX1q5voD
         4EClyqfCpLmDKaRvjJ+hNZpq6VmeBLq4WgwM9q5sTPlHg3MMyGcD/vPZbQX+jyg/dtZw
         gjPXJl5JrV2JifwiP+MG7W9qiouEr89hz4uWySNuDz+mOe0ZeO8DC/d0HSK/L/NZ9v4B
         5xmg==
X-Forwarded-Encrypted: i=1; AJvYcCW+hdr7q75agwltriNYLEvtDeymJoDjkU7MxCGibWOQ9b4ZBHCTKQvmYCRKRpV/VQ4QwvY36gsV/42fD90Oz+Ay8nXlD1OetBae5c8oZVazq/oekSg/7ipb7MSRToSls5TfFQyKmbKs
X-Gm-Message-State: AOJu0YxgsKqwD4yZOhJT2mRnUDqUEtMAFGWttSIODNinUq6HYDrdITZZ
	szVv6S0PFnhUf3MtW0JQoln1bAX5FduAzgQIYPc4nSRCejXCUUu8
X-Google-Smtp-Source: AGHT+IGwbo9oOCC1QRNLV5d8AI5Ecfn5RWDJx4Hj1H3F0ZUHZ0lL9y4KhWxPenwUj6t+Y93jkskEVw==
X-Received: by 2002:a05:600c:1390:b0:426:5e91:3ff1 with SMTP id 5b1f17b1804b1-42811dcd2f9mr96458665e9.24.1722429447841;
        Wed, 31 Jul 2024 05:37:27 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64755sm20600465e9.36.2024.07.31.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:37:27 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Date: Wed, 31 Jul 2024 15:37:22 +0300
Subject: [PATCH 1/4] iio: adc: ad7124: fix chip ID mismatch
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7124-fix-v1-1-46a76aa4b9be@analog.com>
References: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
In-Reply-To: <20240731-ad7124-fix-v1-0-46a76aa4b9be@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Stefan Popa <stefan.popa@analog.com>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722429445; l=1054;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=pAZDjeecp6rsXv/22TRVi6mFQYwYZQxzVZ7EkKQ7Log=;
 b=NeEEZRkVw4/ZYL9IfEvfTbPWR4tgG/MXAaeWn1+ZjSGidF2KnEovqinKaPEhp1y/DPdH+Crve
 uBU3sga4qM2DvGxMP9c4yyxmwm1kHeFXW5bfG61ea9DPXqZtVxw68g3
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=

The ad7124_soft_reset() function has the assumption that the chip will
assert the "power-on reset" bit in the STATUS register after a software
reset without any delay. The POR bit =0 is used to check if the chip
initialization is done.

A chip ID mismatch probe error appears intermittently when the probe
continues too soon and the ID register does not contain the expected
value.

Fix by adding a 200us delay after the software reset command is issued.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7124.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index e7b1d517d3de..54d4c5597696 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -762,6 +762,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	if (ret < 0)
 		return ret;
 
+	fsleep(200);
 	timeout = 100;
 	do {
 		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);

-- 
2.43.0


