Return-Path: <linux-iio+bounces-4607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0F28B4DAD
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 21:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10621C20940
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9413745FD;
	Sun, 28 Apr 2024 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="REZZLWVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A94745E4
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714333458; cv=none; b=i6IoC6mxJv5G1xEL6PCN62eSBUpm9UbaGHZ7InW7sWId0zKAglkAQQs/swXps8pZsDt3Kb1iB/B9RCUn0RV7g6CAJzIVTaRuTjD1fUpUy5TLSBAgYHieXmDF1eL/BRuLvOF5bYZ6ysRie9mJi/PnftjfKdxIjVG0O2Pd/j9g6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714333458; c=relaxed/simple;
	bh=811te4jalqhlAcpMRzxMNmHHpuACJOxE+5yG5CZ5VKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbGJJF8c9XvBA01qsV0IDIK8WQbdOtnK0lH3RCIjyn2PeNFvTt0lJTDenh2VFY2Qz+dqplKrCjMwo4rQfMWtRrIrBoEk+L0gLxBh00uhB0BtxUyV9klrr9U40RWisZW+TbpdOTgArellsNrbJ8d3emocJZVrQkHM7iYo/UgU6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=REZZLWVJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so31608885ad.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714333455; x=1714938255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95Ext5T8XeQ4NwII5w6xxgHcQxHIGHc3RjuE+Z3fol0=;
        b=REZZLWVJ/iNIr8HJhPc4KfxnGu+nNcsdkxi9mi4UIINDYwbrQwm8X5f+goo6pXCM3X
         vLfk6eFG4m5/qfpkQbuP+/pxKOvFhdIw1O/IMH0NSbbg34CDwx7JGqFVQ2P3hwzRdpkP
         +ppsArfi5YM+C1v7Hur2Vfq6vqzkFvE46SXxIF517NklY/THTPfPXSH0tKStjPP3Im3F
         ogfdWloq7rSiaPSLouO53/eZaVgFGN/we3cpycedCozVoH4t3OP5rXJIY5b/iZAJbayi
         NwvZbOCcqZbl5NXlnR+H1MS3Vw5wt3FkzdSbde8JRC3o+JLS8mkmCTD0F0a2hDRQFr5U
         OKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714333455; x=1714938255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95Ext5T8XeQ4NwII5w6xxgHcQxHIGHc3RjuE+Z3fol0=;
        b=YHAtZvULtwgJ+mp/WdySuf33QZyX0RmHGjfHDIvKHpBeKz+4lZ8Ikch8IBFciFbA3e
         /I7Bo32oheumS/nC1gtTcTZQWs6elO5sDH8QkAD9xMG/MAQ48HWUJkCetyKiBfV0l4Us
         0o0pZbOCokQJZgUKAKUGmVQhx2+nZ2edtL3KbNCilqTcMfSNkd1w+LWkDYsKnVmACAvB
         33f8+716Wu1X4WOhVTHvP91PYnhWm1a/1TvMIhjYdfn88MV36ofo2aW9AJlNjRXQgntH
         usMSOuTozvjvriamaDLDfttlj2IyZe1Lp6YFtvbI71iTFHk9VnS0gsBqn7r5T2aDDdcw
         9PGw==
X-Forwarded-Encrypted: i=1; AJvYcCWCrb8HUJnDZVd8+500w3SfKFM0CnUqO6yp8facu5inh/noa84WJ6LzzMDCVwRc4Awg/kuJ7sZ8UH3HYYAIIgVeTiycZEYHsRg4
X-Gm-Message-State: AOJu0YwMZjr4fv2e8NpWlZClBXsy6v82ZHRHupIpEl9dtdzPJ7cGqzpt
	wm4JtqEV5AvvQOrUaLnLdAScFF2KiQioV6bQKXZtBUhIjqFMYfQBldr7Pw0+MSA=
X-Google-Smtp-Source: AGHT+IF8Gb3FbhJMc1opjcNmveeXitx/Funeb+MbXTQSZdluh/oI6MXbOmXjE05lUB2Ak4sJrltR9A==
X-Received: by 2002:a17:902:684d:b0:1eb:3d24:3fc3 with SMTP id f13-20020a170902684d00b001eb3d243fc3mr5074584pln.47.1714333455216;
        Sun, 28 Apr 2024 12:44:15 -0700 (PDT)
Received: from ASUSLaptop-X513EAN.. ([2804:14c:81:903a:a3f3:f05c:11d1:1d76])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903120f00b001e45b3539dbsm18826374plh.41.2024.04.28.12.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 12:44:14 -0700 (PDT)
From: ogustavo@usp.br
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: Gustavo Rodrigues <ogustavo@usp.br>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bruna Lopes <brunaafl@usp.br>
Subject: [PATCH 2/3] iio: adc: ad799x: add blank line to avoid warning messages
Date: Sun, 28 Apr 2024 16:43:25 -0300
Message-Id: <20240428194326.2836387-3-ogustavo@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428194326.2836387-1-ogustavo@usp.br>
References: <20240428194326.2836387-1-ogustavo@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gustavo Rodrigues <ogustavo@usp.br>

Add a blank line before if statement to avoid warning messages pointed by
checkpatch.

Co-developed-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Bruna Lopes <brunaafl@usp.br>
Signed-off-by: Gustavo Rodrigues <ogustavo@usp.br>
---
 drivers/iio/adc/ad799x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 3040575793a2..9a12e562c259 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -335,6 +335,7 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 	struct ad799x_state *st = iio_priv(indio_dev);
 
 	int ret = i2c_smbus_read_byte_data(st->client, AD7998_CYCLE_TMR_REG);
+
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1


