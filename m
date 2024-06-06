Return-Path: <linux-iio+bounces-5964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A18FF6D1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CBD1C25806
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0AF19FA6A;
	Thu,  6 Jun 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un8alcrf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283C19EEA5;
	Thu,  6 Jun 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709056; cv=none; b=DkbqT0g4eLwq+rnM7iKYCLw9DDQSKupBa+oXy+eKOac3WAQfonnKQGUss11wCSWBMxWYFeN9hbY5+uYIisI+eUgeMtbwcDQCCFMA3OVvDRQDM3BQ0VaSvTx/dd5oHrtCHjnCr4Vp0NnqZT57nVP9LyUNkDBKBeki04ACPMaxeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709056; c=relaxed/simple;
	bh=zo/4rmTE9JoBy/xm1cXklprKxVVRnH90QBq8FbaD39U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RblOS0ac2xlnjpUTaOFP/BfbTR/FASZCNI+RbyfLP+y6b3ZMVZIXDbOMp/G7O8gnU2jKfXbHtRz3ZC4NWzzrMQeshl5ncktzEK441bIxpcDweRgVv8ReyVuH+yNNoK8BIx8tHbsrzbIqR2gEnGLzGWN1r5aKI6vej/0lGzyF1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un8alcrf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a691bbb7031so195152166b.1;
        Thu, 06 Jun 2024 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709053; x=1718313853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+d36K7Pb2rbska6Wsex45QWSR6532jz+nmimETbFxU=;
        b=Un8alcrfqdZvBlHQBmac8VnuAzbLVxOxrKxDuIoTVIbxwunZU4dSXryV+EsXcuTYtC
         Tuz3okfYhV9DFiBnpHTPyao09W6PwC25tsl7aobZPxUNOXCErNH+zl1vbWHkUsHbCx0H
         7t2V0a0uI8xiu1TpgzO4QY6Xd8Z5zRtfQjOyc5BSTmwwR7QL1jrypRqkAP2OlgazVXbb
         wB14b4f5SHaloLDW4fzwVpNwM6j7/7D9jJ3buJ570NyK/zz4SmpKQgzpLtUBRDF6kpP+
         BCy7L/4nU63FBMx7DKCvciVtB8mWBRfy7XSDCmR1kJSDJIQJXxAW2oMGHdS+LcxdRkbj
         mb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709053; x=1718313853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+d36K7Pb2rbska6Wsex45QWSR6532jz+nmimETbFxU=;
        b=dUkbs1m1WUfHcIYYpjWG3+cyQGNOVbCpGp2UpstOZHtLQBQpqPwAZ1slS2QSm7ubU8
         8L/zby0jSmJGFNux7kDVdahZtGwP54ndFtlsu06NSUYRGkl0kOo0lYK1iVlUwPtxaU/G
         aOkP3LP0RQ/TW80IrpfNXQT+9V1PvI/T9vjqK3DiBSUPsxNx2yhfO+C0wTRICNzjqx25
         yYl7I7PNe994mS8NxRdlpcOokMSP733Su7peBKxvw41AcYGwpnMEH9mICBAsLTQ10aP6
         pTXWIJaXWlT2CfQrVvSdB2jDp3x/bAhjIHcuMiMsx4mWmVGftCUTabLZ7T7CJaKLNF5r
         eLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfEe5SBrDetIN9s58GuOrEcUvbSxpzeSyHogYbaHlBOEPYSpdXbexDOMMvpwZphe3HkFepZhsf3CYtlqxglbXwe0vPV+7z5EiDdpyjDVygw/bVdjCzcXDKt9o4cfYAmO26E5P+adUX
X-Gm-Message-State: AOJu0Yz9C4P1ax6qV5+VlLz+ZTxZmcl2+TvzOvd7NESPptcsDGXcih8P
	M9gcQ1UMDDwvb0HkYrsSc+mnHMKANmEXOdihY1JatXATbdTpfwe8
X-Google-Smtp-Source: AGHT+IHLSilt/A2r/qFKJ8H4jU95U4ZCru2WdtC4ojVnavbqazHbrNUmAv+w2m0RymJeUDzPWVKk6g==
X-Received: by 2002:a17:906:3b87:b0:a5c:e372:222e with SMTP id a640c23a62f3a-a6cdaa07a0cmr49452566b.60.1717709053060;
        Thu, 06 Jun 2024 14:24:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 17/19] iio: chemical: bme680: Remove redundant gas configuration
Date: Thu,  6 Jun 2024 23:23:11 +0200
Message-Id: <20240606212313.207550-20-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to explicitly configure the gas measurement
registers every time a gas measurement takes place. These are
initial configurations which are written in the beginning and
they are not changed throughout the lifetime of the driver.

If in the future, the device starts to support multiple
configuration profiles with variable heater duration and
heater temperature, then they could become members of
the ->read_avail().

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 1cf375904b8d..76b96993120f 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -683,13 +683,6 @@ static int bme680_read_gas(struct bme680_data *data,
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
-	/* Set heater settings */
-	ret = bme680_gas_config(data);
-	if (ret < 0) {
-		dev_err(dev, "failed to set gas config\n");
-		return ret;
-	}
-
 	/* set forced mode to trigger measurement */
 	ret = bme680_set_mode(data, true);
 	if (ret < 0)
-- 
2.25.1


