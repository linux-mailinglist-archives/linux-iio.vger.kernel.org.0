Return-Path: <linux-iio+bounces-20831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB4AE2B49
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 20:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEE63B101A
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9A267B00;
	Sat, 21 Jun 2025 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4TG6upD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24022036ED;
	Sat, 21 Jun 2025 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750531990; cv=none; b=gXf03W5WgLZxK4CClloeOfq2rEpK08Cm9+0RMYq3EaI5verDzqLZ9HnsNC3Nf85AzbX7ByVt7fvaVhtUPMsuDSXeLAZW+2FfVPMeHpuIzhtpPGWpGwQfIGwoZjuoYbLOZ1C+CoDuq7Kij2tHo84dO/HQpVSgpXZeepRintFdUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750531990; c=relaxed/simple;
	bh=YNKJd0VKgqr5yaVjjFu1/l5WHZ+8KFVf4/a2EGCCWuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToE5qd/Yv4Bev0fDaytFA64YQUI+E3VBY7D7tNOuioRP+4E0JqaPaMLTmHQXsTnNd1192OM7FjR6l2laa8KXWHcAU4OXWcJblLkScNCXcwVFjF6F5MC4J5ZogXMBOsT/TAMkxRbA4dAJPGVZjZQQ41LxGcVn7LlFvrf0mF/CsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4TG6upD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31d489a76dso2458479a12.1;
        Sat, 21 Jun 2025 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750531988; x=1751136788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5cZFNuGdSyl5svvXZPVc0fkJaaimEDabqtK2WLJV+k=;
        b=R4TG6upDMYE8Hx6BaPnco5VxR4r1U1JpcLogrn2bXvH1aU1/z/iFTKrNybCn7VUa6i
         7XHFogtiutwgTuzZDzX/7ZLFx9lhdUKIq/R6EuJAwidHr0QmxZ2IvR5I4jDx0PO8abB/
         83z25DT5Cjy5eqjijp2rAjg5BZgL2NKo3SCw2JvAdIkQkUt+Ngl0PJCzJ3SzYBM2zLHe
         umvE6gIRjxmkjAjOdJX9ep1Q4pcLKptbupvhgmS6TJJ1D209pQvolfcgm5K6xz2KkS3g
         j9Xhe/YtCnvd+Vt7rErdKseROoohzw1cc/UfTm03+uyCtH203u6T7jakK8CHxi/qD8L2
         z9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750531988; x=1751136788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5cZFNuGdSyl5svvXZPVc0fkJaaimEDabqtK2WLJV+k=;
        b=Nj9zUA5lNFxUMuSmZMY3j/AgotFelkaSPQlza0m0l5W6dBZX6iQL0xQRCjm775p2x5
         jnhOdFLDQOcupH/vTp/oU+FlyCiDXnK/70OEJoG8wyDD8PyPPw7d0OTgxnveR1tZjqBA
         hJ9gFNwjfkjVYHwIidS4OMNF3kO/4BmGgQbtclATTAQPlBOzHS0znBckR6LVOB4ToIeP
         KBMPkieggn1z9FGROUOjn7bnP0GSCsK5/K2gloo3s+sEDSlhH9miZpJuAbKeS6D5IPs/
         K2gTYfIY28/isW8U9T+ZtXOQpOKx3WL1oYSnoShz4nMnC73oaOx42QQVWSoFYatfCib8
         bnlA==
X-Forwarded-Encrypted: i=1; AJvYcCW9904oPgrWXeSbTxxZ0FVrY/tQg47Lw5fuXYgkIBndUVDgBSRThi98WNW8y21/CJYuTqpio6Nw7amC+J+a@vger.kernel.org, AJvYcCXnyXXSG8n54NXv6n1aUhROekSj7npYJjP7oc3zeGwHWN6ko4iwqQGe1f7Z/53lTPI9ojutmGXImIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvc6WudD4zG0potdCafCQP1xbRXV7zHx2801tf9HgaDgPauBY
	fRgHKE6t50F5464w+fG9ylXwhAvNLWf47fuPrChuAvHNtdRkO8tvAewM
X-Gm-Gg: ASbGncvWjg8loOFdswPD59/bCvKdA5WfY+wJyIxBygBhv1wZAE7vxfTE0+L5F+5C1ZA
	WdYM98x66BD2sqEeb/KOixN4/wbw4ZQVEJzwqfLTbJkS/Z43JVNCVAX1yKwzrJKE+eYh0lIuu8a
	Fp7szlJX9hx9uyQ7VHUrmvf6aAl4nqK+LNs+YtmlvqCJArkorYnlekeJfLeJ1maWLuK/8j4iOjk
	OFLYCvFkoYFZ4KtLKVav9VbiJ4kJ5w/AIG5ycYRys/jTVZSgbDAB3M8p6/rggn+prsCsHi3PYSt
	uYUNFxBtYYxq707G7lRZNjbeZiAYeUh5ZmJ6yHsqCoyAqAvQSM4dzawTM3qsBWYDHHfBUGOZAKv
	5ZCMC2zwwZA==
X-Google-Smtp-Source: AGHT+IG3qDiusxD+PSHaBKJnh1NwZDOcuLxH1zCfqUODtSQRJQxUNB8T2PUnSKnsGJjStsQ1IMmhfg==
X-Received: by 2002:a17:903:4b2b:b0:234:e0c3:8406 with SMTP id d9443c01a7336-237d9775527mr117117205ad.1.1750531988057;
        Sat, 21 Jun 2025 11:53:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8640c61sm46053545ad.141.2025.06.21.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 11:53:07 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	conor@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: spear_adc: mask SPEAR_ADC_STATUS_AVG_SAMPLE before setting register
Date: Sat, 21 Jun 2025 15:41:44 -0300
Message-ID: <20250621185301.9536-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPEAR_ADC_STATUS_AVG_SAMPLE info is a bit field coded inside the following
bits: 5,6,7 and 8 of a device status register. Since the value came from dt,
mask it in order to avoid touching other register bits.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
During the submission of patches related to the yaml creation of spear_adc [1],
there was a discussion about the average-samples value/dt property. It turns out
that the dt property value is direclty written to a device status register.
Considering some defines at the .c file, we have this:

#define SPEAR_ADC_STATUS_ADC_ENABLE		BIT(4)
#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
#define SPEAR_ADC_STATUS_VREF_INTERNAL		BIT(9)

SPEAR_ADC_STATUS_AVG_SAMPLE info is a bit field coded inside the following
bits: 5,6,7 and 8. The bit 9 is a different info, vref in this case.
Currently, there is no control if the average-samples is outside of allowed
range, which is 0x15 since the driver exists. There is no documentation about
how that information is managed by the device, but I`m suggesting to add a mask
with the max value for those bits before configuring the samples bits.

@Conor, I`m considering to add the "Suggested-by:" with your name here due [1].
Are you ok with that? If you agree, I can submit a v2 with that.
Tks and regards.

[1] https://lore.kernel.org/linux-devicetree/20250506-equivocal-snooper-8a7d1ce931c8@spud/#t
---
 drivers/iio/adc/spear_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index e3a865c79686..cf412ece90cf 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -37,6 +37,8 @@
 #define SPEAR_ADC_DATA_MASK		0x03ff
 #define SPEAR_ADC_DATA_BITS		10
 
+#define SPEAR_ADC_AVG_SAMPLE_MASK 0x01E0
+
 #define SPEAR_ADC_MOD_NAME "spear-adc"
 
 #define SPEAR_ADC_CHANNEL_NUM		8
@@ -158,7 +160,7 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&st->lock);
 
 		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
-			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
+			(SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) & SPEAR_ADC_AVG_SAMPLE_MASK) |
 			SPEAR_ADC_STATUS_START_CONVERSION |
 			SPEAR_ADC_STATUS_ADC_ENABLE;
 		if (st->vref_external == 0)
-- 
2.49.0


