Return-Path: <linux-iio+bounces-17896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1318A83193
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 22:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D33E44700B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B3F20CCD8;
	Wed,  9 Apr 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWj2P+fr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682B1E25E8;
	Wed,  9 Apr 2025 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744228931; cv=none; b=ZhCVXI+1hrI+7ULR3amCjtihETbEIzYVqxHOquL4oGBR5ugUD5lPElreNz9wUYVAYmq4ha8MmWXBxMIKjG4JzF2gTU+d8nJVNinC1P5VTQ+xYm+ANY22XU6YPiB4F+Ztn3GRXJP0ciKaci4SCRkkD6+jok83huU+S+deBPVtqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744228931; c=relaxed/simple;
	bh=RivJtlJPjlvJu05CKyc/0RdCV3vLGzeW8/E4YZH4UJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KnotR9AFJTvpcJfzQeOjzZ8DiilDYBsXlA2NKEnBup8fb+1qML3uJ7+L6+i5MzSGlMq24ZoOW8cjltVAEl/PN5FTbhLuiVjPc4K0RWHg+BlDATJ4vLAtqGyObJ+swYe3xmQI+gmunhcsqfzaMcsAtpg5W8M53Ybezud6PCKia18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWj2P+fr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so111165a12.0;
        Wed, 09 Apr 2025 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744228929; x=1744833729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KblXmZbPmAj/AGHKtjspI0A8P37Ek5VsUHaWencyHUI=;
        b=jWj2P+frn7k1ITmQx116vaYhhp65iLTrSCY1cW2n63h3z3Z4xAJv0Lq0tM6dW6nZYU
         80cyUX2XdW5vUg7iwALAHeV+I4VZ27QrXI4lodb6+XN2oM7wbdmzv9+GJ7upwCCGoMVC
         hhLO69fmAr4oSl9ZMnHWVQJCUv0jPDbpbmWydfYel9CNNRhYcg9C8bxrEA/1/97bW35w
         9iPaJqggLWVJtiv3b7wLOZabdl48vEtNxvdoCaQ2dbMzR2f1s29YC8v7O5sEqw+wfSyP
         vFX3e0351TmL4m1z9bsn+oiOEFBOVJDS13pvA+c7mWWjchU6QP1jT//iVo3dtZ2cQpkf
         5mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744228929; x=1744833729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KblXmZbPmAj/AGHKtjspI0A8P37Ek5VsUHaWencyHUI=;
        b=vP8/yPDy8+dL/P2MSY2LqRtQSmnxpoQ3KzJjGB4N0S/vxf1lmDVz8JrC/nW26IMxaw
         Gd0MkWbHC29rBpd9kC9cHplJmTaSjwy3AbkYI5j9r0kJ+VnpLlAm8W0jWxsAYggi8GeQ
         RgWcC+Lm3FN/Iy7JCXAJ1lf7Z/TxRnuZEEKefIWW/I9IhV2o5TYj7R30srxGKw0A8CXX
         FXXCIJ6SJiVV68EQYLO017zU7uw9Khr7edW5j72DCR139E39ImVe9X2+dGsTe1A3k26H
         uXifZl1hK88lO5cKv1XZgshY9deYaZnTfwTjnjYSev+EjIJkohgIeP1MDjXtqR5jpfx+
         7NxA==
X-Forwarded-Encrypted: i=1; AJvYcCXLK3tdtESB6U0MDcSOmgLrwiDJgwUDjSVgkPjqKQsumtzbloIVDZuypnZ7NasPxX1mQuZQsuFANui5lMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP435X9xmyyFBoxCjmQRO8LmZcoe7hu7L6GC1UNrBKl5I6vr+B
	R7znMhZGIihN2JqFnVGHv4xuR6dPSIgO/TsWFiQplT3CRG9w+5cE
X-Gm-Gg: ASbGncug0OY2dWmazxwVQ1Zgn/Jd3i3QXUMD36lXtG2Wjn/8Uqf3r+TVkpRLh4P4yUo
	q/ya3zIEtZMZSOqeRTgEz9WabMq7VZyK8hF9ATNCHz7sXm3+BokUzYIvhDR85M+ec1AS9abd1Ac
	a9DA3mQhAbIoqmQRekdcRK5eJ0YFz+Cw38byvugnahAu4Ef7Nm0RBSe4uqcvqCnt1d6z/dKJwS0
	Rsvmia8T3sQsyOCXTUiqhErNpQakBVmUTwlbokLSNi0c70CSmc9J5jyriJDJC2n/EtI63bCs22i
	j8gH78PJcw1tL7f2DTh5NgoXlcRSFmFWYmNhuknHgP7d/pgQxS3EdQayn8Crb2PqCpwq5xJfUru
	9fblrF8Xr
X-Google-Smtp-Source: AGHT+IG0jkHgEAisMOI/scsZfAGy2hm+fGVsFv8etcJZn4BDMVILIzirSxsWFk3PdHh1d08IJRRidg==
X-Received: by 2002:a05:6a20:6f02:b0:1f5:80a3:b008 with SMTP id adf61e73a8af0-201695cd5a4mr528866637.32.1744228929442;
        Wed, 09 Apr 2025 13:02:09 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:204:a537:9312:7e1:b2cb:ef99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a3221832sm1652173a12.70.2025.04.09.13.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 13:02:09 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] iio: adc: ad_sigma_delta: Fix use of uninitialized variable status_pos
Date: Thu, 10 Apr 2025 01:31:51 +0530
Message-Id: <20250409200151.201327-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
drivers/iio/adc/ad_sigma_delta.c:604 ad_sd_trigger_handler() error:
uninitialized symbol 'status_pos'.

The variable `status_pos` was only initialized in specific switch cases
(1, 2, 3, 4), which could leave it uninitialized if `reg_size` had an
unexpected value.

Fix by validating `reg_size` before the switch block. If it’s not
one of the expected values, return early and log an error. This ensures
`status_pos` is always initialized before use and prevents undefined
behavior.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 6c37f8e21120..d3b59d90b728 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -568,6 +568,11 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	else
 		transfer_size = reg_size;
 
+	if (reg_size != 1 && reg_size != 2 && reg_size != 3 && reg_size != 4) {
+		dev_err(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
+		return IRQ_HANDLED;
+	}
+
 	switch (reg_size) {
 	case 4:
 	case 2:
-- 
2.34.1


