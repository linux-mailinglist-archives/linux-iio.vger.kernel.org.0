Return-Path: <linux-iio+bounces-12415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31329D2E15
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8816F282FB6
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3A13D8A3;
	Tue, 19 Nov 2024 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K9H6raFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4A1D1E9C
	for <linux-iio@vger.kernel.org>; Tue, 19 Nov 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041382; cv=none; b=c4o0pHjkCV6HxgxGkHZp+dwpxmHq79iSHX0tmslzivR7wHZ9caZ42vRZRpgQM8r6TpBGHsNYZtmrzlwpg3hTBSALXwHllq5p0hqM2jvlKzKcLGpdJUChknbrGedyRDgtPpfoR47IEv/3eFhJj6bMOYgS2IUoLAKyV9HQk8uap8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041382; c=relaxed/simple;
	bh=vKBG+FKrCRwQV6JngEt7oXpXjZeHVmSkKvinGg9V5pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MocR/bZXKzPY/4OIQNBG43h+P6PsHWPafFeKH4z7VeDPHQHSKPhx7y2FUczmSxiGAPq6w51r3VTIWVkxEfyjP3S8Bhn+Wl2PWC8Vu4w6nypNdHYZ5EiBC+AEsdKVJS2fCs2M/AqYEZusKgq+YlzH6d2AKBZsS8UL+pYiVjm/zo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K9H6raFh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382442b7d9aso1138781f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 19 Nov 2024 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732041378; x=1732646178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Teob1VD78jBevdMNd0wD9XNNYvpDP1qDXQY8Pcb8gkU=;
        b=K9H6raFhF60VX1hWh9r9xHfZwWQ+3g4mc3KFcVRLdDqjE9OTnUVcjbBxNdUGF8abhC
         uXulyeCS3cOeLXfAiy5h5c6uiNXP5HIWQ6Ea/z7kvGKaFyyLsEP/JrmGlAdEG/JpvbS3
         4oOb2J7SHEUJeJhGAhmubffUWQKno1cWBPu9FQXTPrCRQHYOtoIvYO9pM1JIloeMxVnw
         umX8n8sk7/9v/Y6IiJ6i+IbgcI1qj65sZPp0PYUos2u3V4rKf5etuLdE6qOuH2dPM5KW
         GvH7lcfEa0o8E59GQ29bDcVAK84p7PSMfSV6ajzmEQdYUZH7AB0AFLroYxeQvXNcfY3P
         jN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041378; x=1732646178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Teob1VD78jBevdMNd0wD9XNNYvpDP1qDXQY8Pcb8gkU=;
        b=CLf2L3rwznsqSnWbWjo77v0OfJFeqlyOJVFSunVSghk6SvJDUPX61RWON5eNeqN7f3
         QviMRmiru1zoiYokPYylXuyrvUFXBTLnlzuJVF7AgBgQPGEiHIGVD3YqdZZ6dvR/jkTE
         hQo9cwS2oyAIjX8IxbvtewPs7pAVH8/tCsckmI/NqqpWW5x23WzHC+KUJhf8uKlpAGrh
         Ik6+GXBoxuAxwOrjVBogNYujiFd/+QA2kIsnpG9IshcgEpNIuQfhTZ9+8WcNGKbs/OQN
         XxkiYvXJGgq+gOkgvRdB1RI07JU5HQ9dlrTimKUOwXn/9I3dBN8lRq/wzZ0evkKetUpr
         bHPA==
X-Gm-Message-State: AOJu0Yxqcgpktyjb31cScbz13TARJVLeGRV+mc26XnTkuxwruTCA//jf
	DSe5k5qmqoNpgVVTigxUJKPrlGFVckOQLRkOSfeCASBflJtYtSC6P1aqMjZe4VW3+Gz7sPgDju6
	i
X-Google-Smtp-Source: AGHT+IGD+ANYWp31NN+SMQMKu5ptM4SuV8ubBEx445MetfLIm96XEUajJR3HO0EtH8kPpLiFbcJW7Q==
X-Received: by 2002:a5d:59af:0:b0:382:41ad:d8d1 with SMTP id ffacd0b85a97d-38241adda6emr6712558f8f.53.1732041378207;
        Tue, 19 Nov 2024 10:36:18 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38246b7db13sm7036926f8f.91.2024.11.19.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:36:17 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: ad_sigma_delta: Handle CS assertion as intended in ad_sd_read_reg_raw()
Date: Tue, 19 Nov 2024 19:36:11 +0100
Message-ID: <20241119183611.56820-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=vKBG+FKrCRwQV6JngEt7oXpXjZeHVmSkKvinGg9V5pQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnPNqbgOcBbP0r3+ylhtkEh5Ezkc6iSQV1piIvm EoEkPmhpZ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZzzamwAKCRCPgPtYfRL+ TumZB/kBEFWBIXzCnHIkKDkTxolDjeZ0NXdXvfgdt21/6v/ZmuSIgoFuAjUbFWJRo4IJJmFAJXj UD7ncQHWennBF9aX21Xa3sG4NmFsUvPDtY933EaNDaMe6qOvh4+cD9Jm0xU4rzoKlutm5MgXW2R 4rotzXcwB1j6K93r56U+1+67sfB4jx1Ik+427TCYxh2M1hmcXESxEu0gdNcZ7DPUvEJ5mGfv2LU JDgXbpN53ZqrMbGhEnHzab/C+bJ/u6k2Zq/9vX6l+Ws1wYZT3BC+VZp4tcZhfeOuIz7llEYpvUA uA6biFam/Kcwswx2WNiH65czZt2SxRnq+TdhuaQOBIZWgbpI
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When struct ad_sigma_delta::keep_cs_asserted was introduced only
register writing was adapted to honor this new flag. Also respect it
when reading a register.

Fixes: df1d80aee963 ("iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I didn't do extensive tests with that commit, but while working on
making the ad_sigma_delta stuff more robust I noticed this
inconsistency.

Review and testing welcome as I only have a single machine with a single
ADC that is using this code.

Best regards
Uwe

 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 2f3b61765055..4b81da8d3cf2 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -109,7 +109,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 		}, {
 			.rx_buf = val,
 			.len = size,
-			.cs_change = sigma_delta->bus_locked,
+			.cs_change = sigma_delta->keep_cs_asserted,
 		},
 	};
 	struct spi_message m;

base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
-- 
2.45.2


