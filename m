Return-Path: <linux-iio+bounces-9638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CF97C6E7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 11:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5141C21DE4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517B199944;
	Thu, 19 Sep 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d+PSUCJZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CC1DA23
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737699; cv=none; b=j8F2L8rvz45cpU2wYxSAUn29KSW50Onuelo53lRnqj4HSh1wh9Jy0+rn00VDwxOA4DP4p/VX5obvkQ3PsU6SD8PipmxGhza4mD8Q8+ExzwADSSgKlj41tQFB012iru2k7HJtYehGyoMS0IC2LiyYN5QrfXYQnm1causn4foupM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737699; c=relaxed/simple;
	bh=Ou8OfT+69WBiLVaYkprtWanFi5XHSO9mF882Eoasusg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOmPHFw8Aco6tI3JmJjDbYJPOx22nYRSOEtf3V2fLjjftPwIqpAs8BezeJbwFcucpHpjNe/0Cm4h5zNWQ483FgWyK2D9D5UPa/HQ8vxvv2oG6nedLE8h14mifW3pMA+vqiyDFuP21Myk3MelB02o67/Ls/aPUL3SXdg2yDF3dcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d+PSUCJZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so4703475e9.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 02:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737695; x=1727342495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm+PhgVISoshe6+u0cv75nF5vnnSUSz3FJSs7aa+aiE=;
        b=d+PSUCJZmYdEiWLJZUNUc81ViaYPdsnZBvvzWuLxB/8qJoBWNoW3xz5GT4ZJ/rzFHM
         arpzuFQ3sUwXzIQeLaBvJlBuHD+xQK8wgB90nrjVJwNo3GUnCiJ/gW3FyNpCPdLZlaV3
         ojUJ7EQXF7A9gK6qZLp+2ZvQs1TGitn6h5MaH36B43Tleu2JARY+jcx8TA7TVOIUEDSg
         ncs05gMPftiD3Pr6m/N8M+q72BRnYaRlmevyqQQmjmFw1h6XlL1DtoIHiIHR7p84gQrJ
         Q4qIeJpygube7gDVuWowf00VjauGlTxsDsgyhoKMOjCpbF8Es1z74YIg6CQWiSmF7nRl
         mYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737695; x=1727342495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm+PhgVISoshe6+u0cv75nF5vnnSUSz3FJSs7aa+aiE=;
        b=gXTocXsje2zgBnJlgXcWt15Z5G9bH8Q4pdRYzW4O3HzVS8eJfV9eTxotseqp1lNCHH
         bua8w/emiaHjC6NQ2ttDb6UAOIKYEDtcpd8gQV+GIS/U6TTMz/ZYw43SQwPHEBJi80OI
         eH+EIHt1loTJf1CIkPp5eOqiconBImCfx1vqAka2E1D8yK8ILt1Et7UuaH7TaCN+S8kD
         VeTkJypW6G7+gH+rFda0bc+X67+BmgMTbkZ46QafcQYEnnb92c25TWED0YZ4y93V87FB
         TNjgUmv3b5OWhTIxlM6rMZt8wBkwrGT9Y7Zrut9iwHS8JyRDeA3El3OE106rZC2CQ8YB
         Hxig==
X-Gm-Message-State: AOJu0Yys4+o+DHU7YvA9Phh9mmXgib2PIoO1dw6PT8mrqtatiZdr3OCq
	iSnwllvptCBlkqFXoI/PM841SdobYw1S0Sq7ycflDjuP2CcYkiTW1l6pIUZMSx+HZbrTHbPuZXI
	6
X-Google-Smtp-Source: AGHT+IFZL+BpyLS0ETVBklimnTddQLSVyt3UeGyl8jNbw4TKvjYFJ4jVSTQlrNtqaiCtdzx8j5Sv0g==
X-Received: by 2002:a05:600c:1c04:b0:426:6308:e2f0 with SMTP id 5b1f17b1804b1-42d964d8558mr144476935e9.26.1726737695103;
        Thu, 19 Sep 2024 02:21:35 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:34 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:19:57 +0200
Subject: [PATCH v3 01/10] iio: backend: adi-axi-dac: fix wrong register
 bitfield
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-1-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.

Both generic DAC and ad3552r DAC IPs docs are reporting
bit 5 for it.

https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0cb00f3bec04..b8b4171b8043 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -46,7 +46,7 @@
 #define AXI_DAC_REG_CNTRL_1		0x0044
 #define   AXI_DAC_SYNC			BIT(0)
 #define AXI_DAC_REG_CNTRL_2		0x0048
-#define	  ADI_DAC_R1_MODE		BIT(4)
+#define	  ADI_DAC_R1_MODE		BIT(5)
 #define AXI_DAC_DRP_STATUS		0x0074
 #define   AXI_DAC_DRP_LOCKED		BIT(17)
 /* DAC Channel controls */

-- 
2.45.0.rc1


