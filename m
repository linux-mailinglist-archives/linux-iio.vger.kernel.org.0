Return-Path: <linux-iio+bounces-21756-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E053B096DC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 00:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399124A202E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC6A1F7580;
	Thu, 17 Jul 2025 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THmdG1AG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9270A94F;
	Thu, 17 Jul 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790571; cv=none; b=BEnGBRqymx+x1/Uym38eYxYTtn3uPXQP9SdA+V2QG5iCU3bDJ9O+kRCTC0U5belxgJCvQ8gNUCvpCDOY0RXc1SPbW5UKbwhC/C5aQL177bpj06KPnduEMAdolXqvOp/Z10blBr/qgE5r3I/TWaSreHgF+LswO/R3mYtlzxi58Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790571; c=relaxed/simple;
	bh=DO98KKk6TkBbtWw9sdDFD5hP6OvEG4vWlUK8no64o20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dT+MmEsx3bLSWwckK6YmSKGGe0AXpnsHxvIkiT2nOtO6VRqUlPuP3olaOpCx/z2UPcGzr0pLp8N50Q0ColHAZU6QExNqRXkePGye0uk7ydaNdtoW7DNZn3WIPr/iB77YggPVn6OAp3JdDDYlX5XpbxZe8qa5klTlmQUzoQB8LHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THmdG1AG; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-87ec9aee6dbso673128241.0;
        Thu, 17 Jul 2025 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752790569; x=1753395369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/KvuAqmb5OJh7sVkKdwX8BdncFtM9CZANV2dMSOP0M=;
        b=THmdG1AGKERASXcOnZ++dTPlIKOLtT4FOrerrfAFZh13ByQ8uNXTaBH8txa17+BUV+
         myMhmEwOSRNMlQ8Ki+ewi5JMPJsf64m89P49Rt5nQzOu+GMNYMmfF/bY3rdW9wZlpMsL
         L1uBfPZKyt6GNW/Vf8osg88fWEIyzMbB7KpzDn3PXYWlmPTyk1Apvhh4YoXLiB5N3wWS
         A5l55QkzGk38NgvPHETGq/LhksAyIAKaTW+eldprXtF0+ggKB49QeCyEmKgLVemc6kCe
         BzFBxj6nO3LLH7XzV2m1r7n4b5zmb9wnsqNpyN+9RDenItkz1tbqdoy5u4F4MvzJTLjg
         hKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752790569; x=1753395369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/KvuAqmb5OJh7sVkKdwX8BdncFtM9CZANV2dMSOP0M=;
        b=jOcwSX5PoVziRfWxxN5h01dfI3OecnIKkydgymd1uWTUfz0MaN2lUX/iab9/Br+ebG
         FPXEMqsb6UJVegGepIg2jsohNe86rz5rJicaiF/i2rqqdbovN1uxnXSTOzPnwWXjowwl
         GAQQoJtUhByYnwmBmmGME5YG4uccthx3Nr8hFzASjsR9SamndzdhzcS4SaB+jxT8ejTk
         uPxd+5EcDTXlRqQ3uwpDLukn7KjomQVCYrIR/a+lXtzBUSxaKo1ln8ykz3Kg6rq4EzsI
         ktFMhzg1PZuFpo6o47sbjIiDL713gO3HEcCz+pwileFGUwNpW8/GhBbNA+GUd+c9S7xS
         MOsA==
X-Forwarded-Encrypted: i=1; AJvYcCXXDMmeC2Cf2Qur5vz2XJ7u/AePxx3OeAhHk8OTOEsCwlV9xj3sGK4KUJVeezmdtRhWlHj7AnSFQ5TFmcfb@vger.kernel.org, AJvYcCXfbE7O5g+4lZgBPCJDI1jUJGazMP0vGmmc3Sbaay27Qe/wfdocZry8WupQDv44QyN2M67Sc1C+RTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEfE+9etpi1Q8r34V9NOvLCSctnV3yHQPC7bV4g9hvsiuoOZA
	tipGwIhe7awEU9+9DJv+Eh+p2k1Xk3/YXT0Bb+BPSk5t3nYJiPYS2OnT
X-Gm-Gg: ASbGncvRfwJy+3Acpy6wocS9v3UFgNZc2fA/y4TFLsV9qSU7Y00pnfGglir6bvKBZyT
	HCCZVa96MiBMoOC6cDNLRMc0iK7MUR35PLyJO23/Sh1Oy8u5Rpb5C3ZCQXEHoe1+c418tTcHDec
	TfVshFdizct1Ckj76bbn3iNqg8k91bPqk6Mz8EjGjHIxj/PoDxDh0Upzp99Wb44PvkNf4toqo7B
	JVduyZHMbjUg2M+uvP20J2olL3kg7Ts3y4GpzMCu052xSH20NiwH3egsuAujxWfG75IIghwkDnJ
	aTdssMB8SybTUxgJktqNoHJByrz3Of0MAhMkt2bfsU95r9r9crYYKiIeFwdoCbiVNODshW8Od/O
	ha8FnncM/qcrksEt/3REfDPupEX1kbRfmsD9REGgcl2YW6g==
X-Google-Smtp-Source: AGHT+IFes/nnGXol1/Z3tej2VuhPLC9FlnKxXQigHmxf5UGIdZ9xXSMEdykwPPerMz4W8eJxsY9KWg==
X-Received: by 2002:a05:6102:3f8e:b0:4e6:e126:6238 with SMTP id ada2fe7eead31-4f8900e56e4mr5333890137.3.1752790568564;
        Thu, 17 Jul 2025 15:16:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:4133:553c:dd2c:6469])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4f9acdec3f1sm15754137.8.2025.07.17.15.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 15:16:07 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and avg sample before setting register
Date: Thu, 17 Jul 2025 19:13:49 -0300
Message-ID: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avg sample info is a bit field coded inside the following
bits: 5,6,7 and 8 of a device status register.

channel num info the same, but over bits: 1, 2 and 3.

mask both values in order to avoid touching other register bits,
since the first info (avg sample), came from dt.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
About @David comment at v2:

> For bonus points, a separate patch that cleans up and sorts the existing
> includes would be appreciated.

I`ll change that in a later moment.
Tks and regards.

Changelog:
v3: moving up include; fix indentation;
v2: https://lore.kernel.org/linux-iio/20250701213728.32064-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/linux-iio/20250621185301.9536-1-rodrigo.gobbi.7@gmail.com/#t
---
 drivers/iio/adc/spear_adc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index e3a865c79686..0acc65c74221 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/completion.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -29,9 +30,9 @@
 
 /* Bit definitions for SPEAR_ADC_STATUS */
 #define SPEAR_ADC_STATUS_START_CONVERSION	BIT(0)
-#define SPEAR_ADC_STATUS_CHANNEL_NUM(x)		((x) << 1)
+#define SPEAR_ADC_STATUS_CHANNEL_NUM_MASK	GENMASK(3, 1)
 #define SPEAR_ADC_STATUS_ADC_ENABLE		BIT(4)
-#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
+#define SPEAR_ADC_STATUS_AVG_SAMPLE_MASK	GENMASK(8, 5)
 #define SPEAR_ADC_STATUS_VREF_INTERNAL		BIT(9)
 
 #define SPEAR_ADC_DATA_MASK		0x03ff
@@ -157,8 +158,8 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
 
-		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
-			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
+		status = FIELD_PREP(SPEAR_ADC_STATUS_CHANNEL_NUM_MASK, chan->channel) |
+			FIELD_PREP(SPEAR_ADC_STATUS_AVG_SAMPLE_MASK, st->avg_samples) |
 			SPEAR_ADC_STATUS_START_CONVERSION |
 			SPEAR_ADC_STATUS_ADC_ENABLE;
 		if (st->vref_external == 0)
-- 
2.48.1


