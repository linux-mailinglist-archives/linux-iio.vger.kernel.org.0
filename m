Return-Path: <linux-iio+bounces-10064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E4D98F51D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D35282F17
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990751AB50C;
	Thu,  3 Oct 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vjet38v0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C71AAE05
	for <linux-iio@vger.kernel.org>; Thu,  3 Oct 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976636; cv=none; b=r1oV1pC5MV7fgBMBRcV1o/XypphYOl3iTbuu3WuvlcJR99+3bEYQ2VC4fQqe1jvrNY/9l+3JUZuXwRmaUeK2I2KO6g7W81Rk0HwaleFUvGllt48mHRIN5A/rEaTIkNObgfYGwpxleq5ORzmRjx+gZR889DwmX69GNTpZWgKN/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976636; c=relaxed/simple;
	bh=ihhpFjUDpjWSP9xUe2YFTNyCZ1MIy1MculheVKZ3RO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NreRjA3zCUYeRTzX9OEjLi/AqUq1VmCPmuw/IUznbDZxnc5ejXx7Iu3knk548mKPWj65vLCRPKjZER0iv7q1ap1E3Oa8EuKtoX7pjXCb5rL23gkhPApHwHx5RBFNkWBf955DMr8pTA4ynOBy7+Y+I108p4Srs8oQmzX8iqjMxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vjet38v0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so15951585e9.0
        for <linux-iio@vger.kernel.org>; Thu, 03 Oct 2024 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727976632; x=1728581432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLQKFRGVRLB5wNCdHe638TIyk00NcVzcYgqYROMVHnw=;
        b=vjet38v07ZqnbNJNMk/axySBH0yanA/mgyxSo8A98aKZGTp6JLXCXPEUhjqg4FQPXC
         Hw6XiI2KyTVqRckJ/Al0L0jiTfPiL/9XLPvDn7tZ/QEGCYI4mxkxUQw91jC6wGgsVH4o
         wO0CoTYNpl4A1oG3DFNBfoNHgToGD8EZuTHlQltBNpqr0xLhSfLmWIp3+c0mk+eiyUjC
         EMhIc2sp21AbtAtHYaQ7NFNLBUtcffa8DvKqsMuOwoOVerW3KfmR/8mP8WKdv6BZapdg
         E5OkBnqHBC4MHk2gk1KKM9cr9cLP/wc1gHWjjZR80vspz+ZsJbyQ0dTvQUPlsA4fhPB4
         N9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976632; x=1728581432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLQKFRGVRLB5wNCdHe638TIyk00NcVzcYgqYROMVHnw=;
        b=r8+FyRw0+FMWyjFGsZRr80X4EeoLFUXflaVKkAOmdCQsnhptOIfL/LLUwZEBtrHx/f
         3YSXkangoP4TXFkGCnIcOI58W0FfGM6WHpwzlpMW0iQlSdGBkFd2+MxzapLE7I9PjwRA
         wBb7xCeuaBsP7/BfZ1EaI/8QSkgjAHA78iEKiNT1+3/fEHZyNf0sjmbqHew7lTUsah2o
         T6NqMNTTNBwZc7+WstxapchGeUA4G4pMJC3zdgwJRr7vuRlpRsIwElNUdcOvdYzhVPTh
         qYE5f5gqrlnrrmbGm0nRZr5Q+dRrEaPJbVUsX7ACo5jaJb3/vH97a7XENXHJFr4hQzf6
         sCgg==
X-Gm-Message-State: AOJu0Yw4yJ+SLSGW+uRGkMSUmfhm5z1zR1qk33pCM3+WBy5y6jcxPHpI
	BooQnyxLiG/K0zl8lYKg9FZrFvs+JLDkW9rB+WmBtKwGz9raEHDSB5jpQtgyTZU=
X-Google-Smtp-Source: AGHT+IFBsnV/xOcFvpi339XI//daMVpJcx6Ux44iTDxP7j8FPxX8FLqNCES+eOyaPGI+yvtk2lxYLg==
X-Received: by 2002:a05:6000:1a50:b0:37c:cfa4:d998 with SMTP id ffacd0b85a97d-37d0e8f1022mr106269f8f.49.1727976631697;
        Thu, 03 Oct 2024 10:30:31 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d116asm1703735f8f.90.2024.10.03.10.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:30:30 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 03 Oct 2024 19:28:59 +0200
Subject: [PATCH v4 02/11] iio: dac: adi-axi-dac: fix wrong register
 bitfield
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-2-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.

Both generic DAC and ad3552r DAC IPs docs are reporting
bit 5 for it.

Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index e83f70465b46..04193a98616e 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -46,7 +46,7 @@
 #define AXI_DAC_CNTRL_1_REG			0x0044
 #define   AXI_DAC_CNTRL_1_SYNC			BIT(0)
 #define AXI_DAC_CNTRL_2_REG			0x0048
-#define   ADI_DAC_CNTRL_2_R1_MODE		BIT(4)
+#define   ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
 #define AXI_DAC_DRP_STATUS_REG			0x0074
 #define   AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
 

-- 
2.45.0.rc1


