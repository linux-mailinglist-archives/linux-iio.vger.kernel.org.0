Return-Path: <linux-iio+bounces-18211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D408A92320
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEF619E7B7E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225ED256C62;
	Thu, 17 Apr 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTs9TNN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7982566D4
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908831; cv=none; b=XSe8f5weEKHy7JC0jIX+/yBvhOvtbzSTVtH8oOf40k2G0V7ZN5qvG2CZtU3n9HmgxC4Gn9Qz9r1rurRqdy6+JctoXjvGRIYDARTfei66kW/2D/d/GAyaeCJPzhkESscO4dBJmzyJvPiMJdBFUVuAJPkkUBu2BKxfWHQdUGpod9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908831; c=relaxed/simple;
	bh=dt+1gVnXlBpBf9G5BqjNbQcFysZQg2dzjajvzJ7EGVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R4qMK1sdCv2gs5burG/xc2KO4/FQVozmbO/9Rn1e9RhvI1rABJXpH+TQAPOlceubBs5pJ3Ia25aYdXslGQJmGFhuJJEgzm1eWynsYroB94CV376AOSYCx85H5rMJ0v6S4a0THYgOutOuu3oGn2JVQliFvw8Z90X/3a5VMTZAUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dTs9TNN/; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-601ad30bc0cso1257725eaf.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908829; x=1745513629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IMlCG6dKgbc70WZaRCp+xgycYGsZNZ1T+JeRrzHG38=;
        b=dTs9TNN/wwrhsuPAHIeX+ejJVco8w5Ms4EGHhT4lkiqmal9O3mBR5ak9qYgbWIfTVO
         w9wx12YFUF11d5tbkjuAiOFHOQzLBRLcUFkXGGHMnD5mhhYzUxkEDAtmZcVdBZqOwVsh
         NzskD+kijJTk6dkRGN+KFjDCq1ACrlNzVhAUCT4hZtznaGEs5NYhTJgkGLo2RAsO2lAU
         cyHka21kYLmJ15+Li8oWGW1FWB63BFiSoUB0D5j3a5trusP8apgb/JcsLI6+vqmB+RuE
         U8r9d90mVTP90a5gIsxW17QW7DMU4YJXIP1/a8UD7Lh2xjy1zIrcisU/p6UNtl7bHH5I
         Z/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908829; x=1745513629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IMlCG6dKgbc70WZaRCp+xgycYGsZNZ1T+JeRrzHG38=;
        b=VqEfF5uAvAO+CfXuiaPvdWEaGOBYurdW1bguZ73QRZvRzx6gC7IU5ytEmNUbpv1J+9
         fNMn7cS6sYD54QqXjkZHLOd/Aaqv/mDaQyTBzcXgAXKuWInA52nRx8BRYe9jsZAtU/Ss
         4J0cAxLXFqYFlL+mfm4ihwWYL62cvk1GZrwNSV17cTDyR48InlKdGst1p40K1f/CqxCZ
         ogQ0orFhhsLRgpsjij9rBMiJspK8U/kUZGNj8igOt1YC3J80aLmC8RA3krz2KIFdivh5
         q4TpNJ5/QwXtsSsbBLTrRLLeLXO5a4sphlWsCMDSbr4uiLzqn6QI2kmtFq7uJpnqyfPo
         vwzg==
X-Gm-Message-State: AOJu0Yw0vDZsfBIxU8cDT+HtGZYrU+i2gAQBoap3C5qsAHaeJlTWsO0t
	g4Iof7vzjL93tJ2V23SK8Jq5xwodYtwkrwC75Yy9QYJ6l6PNPe84mhFeaBcP4I94/3WIyF66Pu6
	JKbA=
X-Gm-Gg: ASbGncv69So1XNYBezJ7m7n5irUqqGZz6C1J+moOKVumS4M9cz2LORrPquMWQ7h/6SW
	6p24LII79L1cDhgx5beMed5qE/7zMdI0BqKKRc2HLNcvXPkGQDfUQ6GJFN38ybAE/n8GTHSHIs2
	mv4YjRgumc/ILJm9h/d5Lb6rr1fJFpOfjNso4Ef8HvAIi/vSTmpMcSTVo5A6Lb9gXLbeESjPJ9m
	1tD0qmYFVh20nk84rKGvp2hIX/5z6UU/Izdes9QwDC+zx7wf5uKX78GdyP903qezM19tYu0DqYx
	z7XfLgXcaPvNLMHr6QbBbqv9OK98fVZZoR8i5YleZgQEOtw=
X-Google-Smtp-Source: AGHT+IHWDVE2JOtKPQU7CbidZGVyB/2fs79a+6FRXoQ5Jm7PUZX3WMp/oUPBswy6Dx17VQWL+Mf4bQ==
X-Received: by 2002:a05:6870:af85:b0:2d4:f247:3675 with SMTP id 586e51a60fabf-2d51d858794mr378775fac.5.1744908829446;
        Thu, 17 Apr 2025 09:53:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:40 -0500
Subject: [PATCH 8/8] iio: pressure: mprls0025pa: use aligned_s64 for
 timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-iio-more-timestamp-alignment-v1-8-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Tomasz Duszynski <tduszyns@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=706; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dt+1gVnXlBpBf9G5BqjNbQcFysZQg2dzjajvzJ7EGVY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATIHV4NNNWvRCnxHGqKpmu/bY2WH0c2xw0wRI
 MBr9oYxE/SJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEyBwAKCRDCzCAB/wGP
 wJxmB/998v8PSB/5F3IVjQ/L03FccQbQvgcinddv5IhMAvKwG+4u3ZgXoVkpfQEc1Oi/TyFXTry
 D/3jb/fsR53axXk54ddIaElK0Oird/9HbVfsLw0KOvACbrty85JS48EvTq3UCyt9nHyQHCVsd5W
 8TLc1kECCNVsf6x1LB7DxLrQNsd6VvA2FuLb1a5VribVYxR+okowWqAAmjEu3F4CnAGZWvZXljZ
 iQ1hjfWdxslpauWfw7HRAqmVqLoLhxznPLLpFpGysSKe4XAe3wlvC/jYIVlZRMVKlT2fn7r55tV
 o3psJa48e65bIp8T0K9RY7/W/+GEVn6tymZGuZlaKtYyIGFE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure the struct itself it also 8-byte aligned.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/mprls0025pa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index 9d5c30afa9d69a6a606662aa7906a76347329cef..9fe9eb35e79d992b2a576e5d0af71113c6c47400 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -41,7 +41,7 @@ struct mpr_ops;
  */
 struct mpr_chan {
 	s32 pres;
-	s64 ts;
+	aligned_s64 ts;
 };
 
 enum mpr_func_id {

-- 
2.43.0


