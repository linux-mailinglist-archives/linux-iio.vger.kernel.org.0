Return-Path: <linux-iio+bounces-9838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339BF98903C
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78F21F21961
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35B54673;
	Sat, 28 Sep 2024 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i66GFkyw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882B22089;
	Sat, 28 Sep 2024 16:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539938; cv=none; b=sfloFvFfJV883U0/tllh90+6O7RcTfiTrYKeYExUQk/PgtqMm9WOsDNEs74/qVno5l3ouvVXYM2+aRdHJzPtDBkOfZGtlnQNXhkV6Kq1vsv7y0AY+LlB7Y2UWFruj02lu+33deqzTlJgL3BWtbfKaY8ZyWHaxwe+bevg+sOx9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539938; c=relaxed/simple;
	bh=TBCSobR2WSgApP5zbamJaa3KII6CFnPUU4CFuJ3T5b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Apse2YByRSuED4kvALfGjr6qSfIwAWzlAAiuqVSsbQw9vpM8WARzZslWUZ38rvk7KKyx1uJhfOvtKSz2jNLxerD1Y+coZrYM78mqHY/klbL++54qF0rhjlMgyYB1ZbVqAP3VlRiQpjev0S8gs6Xx0inKVi7HelyYv13i5tX58PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i66GFkyw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e0afd945d4so1843472a91.0;
        Sat, 28 Sep 2024 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727539935; x=1728144735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyrcqApW95Q2aWx98qWljKFWpxGj2v/UkzKAGl15Gc8=;
        b=i66GFkywJUlMTfP7fJx1tS4vstxmex30n/+e1DsIhSqE7SW7CVI1B11+3VgyDpzH7T
         dwct06WuM0rMzm+D9sy8b3dqd6fsFTDKZW6mwpUtk7eQYv7oRv7c+luZaQmD0Jr1c+tP
         EzLE6ygPYgEeq71j7FQvsnxBNwQwYLlFTlW2wGdkXk+TC+w08rxN7G5sfTln28tC4b39
         lfcknQpsHGczt0b0nTLby9+Ncd4KP0q/zBqPTfjDGUTmdDUIZ2B+Wio2HNymk7GKpLvf
         TkYqwYX2ER0N14A4pYG1UEC1qbDjkv9X+3vQNPE8lzwtm+AII48Q+lKIZLR8RbSK1CYx
         q9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727539935; x=1728144735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyrcqApW95Q2aWx98qWljKFWpxGj2v/UkzKAGl15Gc8=;
        b=BtJKv8jxSZUuSiTsbdcMa2JLsDtVjsAogNB3vFwi4d1gbJk5fRQH+yj8PIDWqPzRDR
         tZUpJLxXieZ8wzQUtZQwaNag/KoNe0HUqZD3dgZ9tqh7sFwaTApS0c/Bab9R0BbxIJJx
         QYBeEAu2KA7+CSEawNtcn8ZHdCxo/zt3o1S+NS1Xr32ZoDqywPwFs8YIT/nVUuYWMxTm
         Rdb//vLfC814s1XJy0Sx0zopQ25PtOHOZn14msmtq5n9RP1d5o/pYZzurTcRFcGrs5jh
         eEts94gj6lortvOMmUWnwEu4AvPPHs+JVDjQh54NKjKc7sh2HTWf5H5MxefWDs0eROk8
         PPDg==
X-Forwarded-Encrypted: i=1; AJvYcCVfIr3VL8J+P5PBpKS1zYmvr4zw5YDcd4tq/jwimTBQ4v49oFtFfmMfZ5NAbu7sW6yJkpyZUOkECkjwDkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmgOepM9X8h2FoaRZzl8zWmehYTXa4FpDTVh0nedfum+DSILR
	YI80Uscy/muSrcBW3KQd/5MuIC3Te1kEAgKgAZZaS1cnxFSjl8HGNzHsOQisYlYoAA==
X-Google-Smtp-Source: AGHT+IHTqVx49maAhen143fo0jfg0pGCcGEiZZtqePeA/hEG7RnqvaBiKcmHwsik88zG99isUcDKOQ==
X-Received: by 2002:a17:90a:de92:b0:2e0:9fe3:346e with SMTP id 98e67ed59e1d1-2e0b89ad30emr8197450a91.2.1727539935323;
        Sat, 28 Sep 2024 09:12:15 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e1073feb9bsm216693a91.47.2024.09.28.09.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 09:12:14 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	matthias.bgg@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] iio: adc: mt6360-adc: Converted to use get_unaligned_be16()
Date: Sat, 28 Sep 2024 21:41:08 +0530
Message-ID: <20240928161108.163647-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changed the manual shifting and adding of bytes to use
get_unaligned_be16() api instead.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/adc/mt6360-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 3710473e5..91befe2cd 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -124,7 +124,7 @@ static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int
 		usleep_range(ADC_LOOP_TIME_US / 2, ADC_LOOP_TIME_US);
 	}
 
-	*val = rpt[1] << 8 | rpt[2];
+	*val = get_unaligned_be16(&rpt[1]);
 	ret = IIO_VAL_INT;
 
 out_adc_conv:
-- 
2.43.0


