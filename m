Return-Path: <linux-iio+bounces-24881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCBBCA91B
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 20:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751EB483823
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9EE25785A;
	Thu,  9 Oct 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O14X+IOm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CE24DCFD
	for <linux-iio@vger.kernel.org>; Thu,  9 Oct 2025 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034407; cv=none; b=EMRwu7S+RU4rmTKOU151ZKDn65WNpCrSdJZBSERfpekdYji6Svu5DpziJmRkS8YIxTGqGmPwIR2/LZhFkoejXCBWvGDcTB9IslKKMYLMj37jFi8uGh4a58ZV3JbXur9GRO9m76gJJUcNU77a5QyYJM01+MhmJUNL8ugdYEZ//pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034407; c=relaxed/simple;
	bh=237M16hLaQn2JCG4h/A7XmTUyEvItNKJH55VLSMGMHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPyninaSajAzl2UrY9qGOlJL1VUui9/QzA/08W1EDlNS0a7De7KRxBMi1PuKJ1B9eUgPx39gdDaj9u5LlQVyOHXgzYY6U5QzwdMb+LSfmkPIu57R8DinWoZLNpR4spKkGA3w+GBa2yJ/fSHpVskrgSXdoB8dX6h7NY3iILf3VBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O14X+IOm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so1264169b3a.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Oct 2025 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760034405; x=1760639205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnuN2daj+bpyYUC9QgFJubkekwCMN3rl5K8+XDophh4=;
        b=O14X+IOm+qCsehQh1DXiXhxhQMCictyZB12C0hIThXr1PI5muS2GWdLVXETIZKdhPy
         unjSSJwLB/7SyIRgxMxx2a22x2C8zADPxV8tVK3EC3AERt7msJCiWkvSiqUoetCRBZUZ
         iAwdjaNea6hNy8LAzaZ/PLgH7YcKOnq7spnhzRib+gwOB9PB9XxPAPFbq6f0NuVYnfpA
         hAg1CbMjmoSqBdgnzOhMFmreQhUoyk2CQcRBxuj210WB3dCzKD856WNtXhRXFuPu8Mun
         1GRR6tk0kBTS2gAaOdRl71BPkUW1577xheWlPdue+zXw44M35GxMqrlwLkoWzy8NjvjF
         CCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760034405; x=1760639205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnuN2daj+bpyYUC9QgFJubkekwCMN3rl5K8+XDophh4=;
        b=RsOnhK5uYD81Gc7T13dbdTsruM5mVfUV+Pf9DN376BA/uxs6b1Xp//XPg9snHzXSOk
         CV4rIEcQUIlHv4Z3Gfxp043QE4mWAs7vqavnN2CXzbzjSi1CU5prfTHOTt0SQVrPgfas
         OMfbz4vmk2bSEtwAf66i/PKuKMSKTU57bVDzG124X5+l9S7jZ5p+/+AGyD7oHSHROEE6
         8/yf2LHhstput8vend02s4R9xYh/XbOOvGhuHdMicx+fH6eDNv43Kabxe5rxvgie4WSL
         SXUoWXfLKYs4NXHY64V9F6I4CU71CnWID54V+7gD20B3qvla143mDA7SXGuE1LAvxilI
         xAXA==
X-Forwarded-Encrypted: i=1; AJvYcCXG0CkBK4KlH7wU3mRulwrDu6hjfcvu8s6gR8WcRhmk86wUvoNCoCUJPRjLtNeKiVi8cZ9m5yY184M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6C1wrJDnSWW5psgRY5acjl0d2pg65Hl/ktAJYiBLYXFRVyx6
	jTLhV8/YwBMiX5i18nt+6ozNuTbMOfH+5Ryc3mfVIx/DRI4HwKxAw2rq
X-Gm-Gg: ASbGncstn6FXexLVnc8/JJ5iaRx9ElFHjMVWznHl5g9OxNie3dnarMMwFS+W7XurLkT
	L8dDyItxiJa57FyWK1ldbyQwscrrl3e0ThQkSw3koTTw47g7ragaX6agW9359zKpSV4Wm74FSXw
	pipCXH8cDA57kCVpVsgCt4I81qP8UFi/GPU4aA6JGCVioLWtG6dS0GkafHdr54nGfj2JRBvLygc
	FryqhugRBKyvJ2Mzf/8IsQxS9IQE3C/cmvsAVflxH5U2jJ5wbnoIdwimvvLOLZ2fYTAzdCEnGoX
	+rz4sCCqnuT4JDacG2vjG2W9Iui9b73OgT/rBayNiIumirr+4z9Qq9o7P6XZOj9OXtySzAJQ9VW
	P6rezf78fbOVPzOSCQxNLL60ufuWFSDKAXIlrrmB3085sRSQ3r+SCR7TP2lFkX4VFYT4pmao+zB
	hawL/SKxQ9yGy41g==
X-Google-Smtp-Source: AGHT+IGkpwuR19BRN76AnIQiP1T8EgOPydPx2sxZcmkWljIzYZHCtXpBlxd/whDBnWNmct33+wvTOQ==
X-Received: by 2002:a17:90b:4a4e:b0:32a:34d8:33d3 with SMTP id 98e67ed59e1d1-33b50f608d4mr10347238a91.0.1760034404753;
        Thu, 09 Oct 2025 11:26:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:860f:cf8e:9902:97e:45e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f2409sm2735066a91.6.2025.10.09.11.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 11:26:44 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: spear_adc: cleans up and sorts the existing includes
Date: Thu,  9 Oct 2025 15:24:20 -0300
Message-ID: <20251009182636.187026-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused includes and sort the remaining ones.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
At [1] it was suggested to sort and remove some unused includes,
that is the reason for this patch. Removed the following includes
due not being used or because some of them, like device.h/kernel.h
are included indirectly from another .h file. What was removed:

#include <linux/device.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/err.h>
#include <linux/iio/sysfs.h>

Also ordered them alphabetically as other adc/iio drivers.
Tks and regards.

[1] https://lore.kernel.org/linux-iio/e748d82b-43c7-48e6-b441-cef464f189e6@baylibre.com/#t
---
 drivers/iio/adc/spear_adc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 50b0a607baeb..6d974e58637a 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -5,22 +5,17 @@
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
 
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/bitfield.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/completion.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 /* SPEAR registers definitions */
 #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
-- 
2.48.1


