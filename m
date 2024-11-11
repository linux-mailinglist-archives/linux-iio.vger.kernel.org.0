Return-Path: <linux-iio+bounces-12131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236C89C4148
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 15:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6141F2246E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179F71A0BD7;
	Mon, 11 Nov 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImUVFlnS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4871E481;
	Mon, 11 Nov 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336911; cv=none; b=Bi/XOY9kJuU4t9+XCACEPe9vm8B+xgC/ZqRAFCLPFdekp3Psau9EYEEWg9DTtLXFHWHbbjQnbtqS7NOjUrJqgGWmvPMr+CfMoylJadKj0EbpaPdVTnXvkKK916STMgjMP1yOM2zcNRWwzJ6cBoRsr5QeKSBhNrrWPDBwY+FHBd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336911; c=relaxed/simple;
	bh=II2BHEcC/u8xLBp3ClwUSeB/igExNBmR0NJxatWSy74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pWGEyPPNeiAoZj4kmBB07KwKwOwyWZSgHYr5C1e5lwNzA7Kp9LK6MAn3OpciXjcY9BJW/q3JOg4JFZ9+Mg+29izJjvlOCnlPgAjkGDO/AAx49KAZRmMusdNqtPz9DL7rLDY/KKvF6W7f5vB7yT4Tez/RAWjGg+RGW40IlrMPkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImUVFlnS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-723f37dd76cso4676250b3a.0;
        Mon, 11 Nov 2024 06:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731336909; x=1731941709; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WK4sa5rLsAlHTQmLVJ7TfENeLqcKiiMDO0eHStMPdhU=;
        b=ImUVFlnSlYY8f4muf9y04fBErZojIRFSIh0nDOZHcP95GmAJj3bn9yJTZg4RJzKWA4
         mMjbXsINL7En/o+W4cllVcjmIgaFx2g7kHTVnNyX1l3TC7MHcZWWJqDWn8i93XidIzW/
         9dLVhwl1h4QVIIHTE62W7aPBoiQ/ydksNlgXewySV+aBMLaN6oYPcTDD+CdXcVhobHYt
         3tahcR5rQ/48kkEG2KMYFdVlLUiok4g4yqYIs80Kt+15dWny/6f5bdtF4Uwy0RQMgacX
         Ca6NNrlkZkIXwXGD8b5SLtE2aIKl8gwNf48mMwzNx+RE7aRU0ye/NOfiw9MdaKXo1SKt
         NRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731336909; x=1731941709;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WK4sa5rLsAlHTQmLVJ7TfENeLqcKiiMDO0eHStMPdhU=;
        b=wUusdCA957bvuLng4u2o0uj7aKn6qhxAVdDVMFdgU3fmx79+oknTwLOUx8xPTPF7dm
         2LOa+xom1gkKAOtFdHdmp/txd9FtWAJRAO43hx5rWBxOE1NlIkUDj8O8HfDDm/6wlnlz
         0zk0aWF7tSBiFQkWm6LKc6WVGILmdCF2EVBIDILVZph+IXH3BJagfEwt8QRM5MFWCf48
         heOx91kZv4FJjEe74r3RGRqyV6KWxWobLY25ynGvnhBdQEaZi7NXI75MSCvhbBXpctDy
         AKHQ+0Q6suxdDwLNDQ4Js/hPYYiY1830QOJF04URBVMeOeTMrFn1w5lLGSOyTmptj5xL
         IMng==
X-Forwarded-Encrypted: i=1; AJvYcCWufZMQaG6jqhLVDhHoN+0hjO35nEhE2PPTC6VyJ1EFjjiHXjgC8TCNqJZ4zvldM5Dst9xj2qAfdul80SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2X7JHdTe2c+SPINydP4vvJmaIwNAZKAuBmGWm5DpFvDSXuYLm
	tSR/F0gwZxRwmTi2ctIDoo80BStblgPcyZJRyhaohuuq3M2Co+h8CurFEGTrrHc=
X-Google-Smtp-Source: AGHT+IHku2r2iIk02riIT8195NMqeN2zArBSm+pDBHA1njoJbfyyWNQ1Na2tgs9jqOjq/cHv+GuDYw==
X-Received: by 2002:a17:90b:1c8d:b0:2e2:7f8f:3ad7 with SMTP id 98e67ed59e1d1-2e9b166bbdbmr17662049a91.7.1731336909257;
        Mon, 11 Nov 2024 06:55:09 -0800 (PST)
Received: from Emma ([2401:4900:1c94:38cd:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f90ce5sm9734681a91.31.2024.11.11.06.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:55:08 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Mon, 11 Nov 2024 14:55:05 +0000
Subject: [PATCH] iio: dac: Fix converters spelling typo.
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-dackconfigcodespell-v1-1-2498567be34c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMgaMmcC/x2MywqAIBAAfyX2nJD2gPqV6LCsWy2JikIE0r8nz
 W0OMwUyJ+EMS1Mg8S1Zgq+i2wboRH+wElsdTGcGXVEW6aLgdzkoWM6RnVOG+hmRp1FjB7WMiXd
 5/uu6ve8HfuVm02UAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731336905; l=873;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=II2BHEcC/u8xLBp3ClwUSeB/igExNBmR0NJxatWSy74=;
 b=wu318pKFFAzPZZwRY44LYbUAOCWxrBZug97Fmi2iE7O75TLFWkgyfa4uWrWIzG4HjVcSKlYSc
 4SGd4CiU5tjAFQwO78RG0/yrXbgT9ueZbsr7ZQMDMWHt1Z1+yNqSMFW
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Correct the converters typo error

"convertors" => "converters"

Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 45e337c6d256..059994c7caa3 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -61,7 +61,7 @@ config AD5421
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5421 loop-powered
-	  digital-to-analog convertors (DAC).
+	  digital-to-analog converters (DAC).
 
 	  To compile this driver as module choose M here: the module will be called
 	  ad5421.

---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241111-dackconfigcodespell-2c39aae651a0

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


