Return-Path: <linux-iio+bounces-17923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB559A84AA7
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 19:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78FB1BA052F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747CE1EF0B0;
	Thu, 10 Apr 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d16KlI5L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5C1EE00B;
	Thu, 10 Apr 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304734; cv=none; b=t/CdM0YsW5uuvAB18CbUf3HZB4Y54NVEQ2acNBUwS56yvft15JIiMblBcbZegATbUSkyrObu0jmTi80YXDY8+ylUJ++kg8QCG+0/DTdjtCbLYoWtjOsvd68dAGINLyYLHHVAZ4Lspy8faVf3FWpHSsM0Pft9w5JFtRtSkWB9JmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304734; c=relaxed/simple;
	bh=UKqAD+1b+uYTBCaerg8T4ADYWz9oQCPjqRNvCJOF7kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mfS7+Lg8oSPHujQ07BfMU4sgAN72pZbNhZ30pBj3RlWHlgMu1dBn681T5a6KWIiZQbiupzcFIKKhFZKcb3XG00fmo7FPFYT6N4+kEa7uiV6OiKY19yBmCxjsTEt1pr+bHjy9V/ZE/n8peI6yMs+pXSIiV0cLtD6u145yW+LuNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d16KlI5L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224341bbc1dso10567805ad.3;
        Thu, 10 Apr 2025 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744304732; x=1744909532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3NYJscvaaIgL0Codhfj0KoDXXxj/ASiWbyMHaHDh8Y=;
        b=d16KlI5Lo3QUAnGy7he0FHpSdM1xAWmaKu5OPsV0TevjdItgDxEZLJR0w8b6JS50wd
         Wo4MwXRwZCdJOJtcz9B8OkiJtfJPlIKLQyylTPlHk4MPV9bUVYzCoiCFiPMuQpknI81T
         NGAL59M5rAxNFjj/+OjZlf80vzW41pcIu8BmMpc35NjSGLdPCUxTZ8vpHb3b1YQqdk0F
         kDXqu1IiaPjl04VJ+TF+JaxfgoHwxT2IfqIw/AMhCsWaG9/FNaoAxR+/xGnDxSLc35aQ
         tohOwkyOM5rp9AABp8B+BcsG4y3MbLTP9jfpHUWDXgIsNXL8IzXSXvnzAk0S+mO7YMx+
         aO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744304732; x=1744909532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3NYJscvaaIgL0Codhfj0KoDXXxj/ASiWbyMHaHDh8Y=;
        b=d3cVkQAS5o86GJTwYdMpovAxW8qwo3No2vgSNuIoyMtNgZR5Ijuw3PfKWsgJsvQkYm
         77TO+44HkErKqXOY/ybfX8Bh6yih/tjeKx7xMm1CuysQyLanBWWbTADa0Vucmr2GIpaB
         He5h7QQYCov2F9BAcbCLmDcy48yOh+ld+lQ8h1+XpysITa6uJbx+YaVUz3RI1UfWjgCH
         BBvpjd7fszlglySrWIApfennX2ispQUHQO05xGzD+3C/SckSRURLnGBzmz70xkrFWiD6
         mhmQrohRtiFWCqpp2g9i6DQ3rW3U2bShRF9lwrSe9YSGr7qwLQC//QVruzKMsLB/GsSj
         lrGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEEWGtlLsYKz2eWKtKOETjk0i+zK2a6OtQsmQDhXtFvFkma8H1ZPuY+q0D9HM3tJU0RzenmVW1kBVmvRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfWKSS3OxuTRVMfS61VQBU0OrGYtvIHWMHYc2PoxxQE6t4LHb
	m+0jNyNVtm75SrEJGO6/KtVx93biW9Rkz2fwVVZfGGT6SJ3AxMxS
X-Gm-Gg: ASbGncv77cIbp3CmaAdVD9wKzflwCcd6fnpIdCqgPkk0xzCQT5Fnpnfcp1nfLyiHD2d
	Kk7uPVdDG4/1WeU4ftVf1/hEfwIrfE0C73I4n/aGQ5RuZdCm1smKJZ7YyuyyqVF8ZOcmEFWo1Ly
	GF41OamEyolcTMY/rnTNfyMzV5Nm0YlzAZBOo5TDq8LTITwTsvYZZ6Y4yaj1Pa+8D4nqYjYtWf/
	kbj+aCKb3qgaZ3BIuc31ZfL/QobOSueDxhFiJXGsF2wSlghT7LKfxDiRHC8E7tbeg11SiFK06UT
	KG3Fz9T/v6rEY809EEox6/6R5UbAQrWBsxbn87sVSeY2hBTfRPak6uveiDCvK7Icd545XE8YStQ
	=
X-Google-Smtp-Source: AGHT+IGIgfnN+QEBNVAOETkhxfzYmuEyHXqTT8hN1gKBhfJ4DlciiBtFoaPj/ha5jHspXs3TjUWvMQ==
X-Received: by 2002:a17:902:e743:b0:220:c066:94eb with SMTP id d9443c01a7336-22b2ede9536mr48603165ad.25.1744304731978;
        Thu, 10 Apr 2025 10:05:31 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:204:a537:70f5:9c3d:61d0:62b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95cc6sm33106735ad.122.2025.04.10.10.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:05:31 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v2] iio: adc: ad_sigma_delta: Fix use of uninitialized status_pos
Date: Thu, 10 Apr 2025 22:34:08 +0530
Message-Id: <20250410170408.8585-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected issue:
drivers/iio/adc/ad_sigma_delta.c:604 ad_sd_trigger_handler() error:
uninitialized symbol 'status_pos'.

The variable `status_pos` was only initialized in specific switch cases
(1, 2, 3, 4), which could leave it uninitialized if `reg_size` had an
unexpected value.

Fix by adding a default case to the switch block to catch unexpected
values of `reg_size`. Use `dev_err_ratelimited()` for error logging and
`goto irq_handled` instead of returning early.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/20250409200151.201327-1-purvayeshi550@gmail.com/
V2 - Moved the reg_size validation inside the switch statement using a default case,
replaced dev_err() with dev_err_ratelimited(), and replaced return IRQ_HANDLED
with goto irq_handled;

 drivers/iio/adc/ad_sigma_delta.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 6c37f8e21120..4c5f8d29a559 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -587,6 +587,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		 * byte set to zero. */
 		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
 		break;
+
+	default:
+		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
+		goto irq_handled;
 	}
 
 	/*
-- 
2.34.1


