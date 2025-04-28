Return-Path: <linux-iio+bounces-18799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B512CA9FD10
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 00:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124D9462FAB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 22:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13161DF269;
	Mon, 28 Apr 2025 22:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be7fCaUc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C915687D
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745879728; cv=none; b=DbiBXWmrwYfx7RcDwqwLOfFl7B0oIUfC0R/dfEOiERseIXYcJ8OMHiYGrkjAuVSVqNNhZ4bAO53XvoGfWbQa4lIlQHBMA5Nww8TbmJC6kiNB+iSM+FU2IvWvHMyhESxrWa+qaJvdQGqd1YmEZi8rKontLEWFWgWiE1FoR1hQCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745879728; c=relaxed/simple;
	bh=Ab+g7lHAqBOCgD8T2Nu/AlswTSFyrgcBU8GcHWZBVeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9VpYgshxW4XmfUjWxEXszLA7nuMgEkfw+9AsZOTY7aBgJddz5z167Y7u0WOAFLAbUOScm2WPQh7mBVr/SjEtqfd1/g2vbMabIHkfYCRSedccxiKRzzauOiTeab91X8eGsIsypJV2gSaI84x58oVBmxCXVrtQTvUsbvLGHOSZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be7fCaUc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fd44daf8so10841235ad.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745879726; x=1746484526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUrhpYgeWF3L9eHf1TCLFIUbnIEuKj4fszbceaUeAo8=;
        b=Be7fCaUc8Io9722AovjIynWHRcqCdyQd+8LSRTwl4q5vm3o0YVxEOctFCCHuq/XKCI
         BhGsSZBJ4FarZKnT+aurDXY42r6ej2yTUMtfo/E8FUWdqzjsVG+DW0R5VKyjpMyd2+49
         xlpHIbh7GYbvitfQKjiaem6na72Q0iiB10QWuM6icMgGWSVdvRYU2TpOiJFptFECw+If
         lOU4Is4VIOIZa6GSe+jjnf8JHx0VmIR0ZbGCJm32QazUichyaYkbvIfLHLLZ1aObBTEu
         VDwLvFC4/R9hqiEzzZ1sjDzFjB128MSZ0fqLbrIPqVq688yY4NaZOgcHLNxcwZyv/R3l
         fPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745879726; x=1746484526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUrhpYgeWF3L9eHf1TCLFIUbnIEuKj4fszbceaUeAo8=;
        b=u98zE1ULgx54Ucfe6fLBC/8joKTpQmUnyQMF0gKqeaPJ6AE+KnhwiF6LR9WnCWHUf8
         V2I5uyVk7/Do9/Ux0K9ZSSkxMNDJ8CubSBOP3EOfEwNX9r1zKVem8DCoTOx3xv5pjS9J
         lr59+zsS3foHLBBSSqg1EvIYK0kxbk5YlAaqx1Xr/3REHkyycEGTkUCdu+RLQzngWyfv
         /b2TFEpWhHxQzS/Ijvs3c0iv3B3sOtgFDBnfBhDZLd9QsebEHt3fTl9uhGyYzoHW1+KM
         snpF9sfAsfDxmVeIFW+UJruJ7co4PHOX842jM6NO4UCUyOmjWcOmGOJ4kwqoj3cxX51n
         eIHA==
X-Gm-Message-State: AOJu0YyzOEghLthq9rfKbNOwJvKRmSL+bbXlmtJI123aVTvvujBmsg9s
	i/weP7m/NOSO5/dTMOr+UBki5ahtOUfR5JnJC3OuhqOL6LzWKyEVXrXmojZuP5A=
X-Gm-Gg: ASbGncuLqSLRDh1szUTeRBi7H1S3QfaR5gjWJ/pu6SEOXmHg+sXZhhjMKRTqSZrSJtJ
	BTR6HvfL8ey3hsbLv6P6YBR5pmn1mpnCbSPA1liUNeqZ2PepLSl75G5XEeg40hvMJcdvee0B/gR
	yV6H04SPAAEeHTt9/+eCQ2ZCC9af1cDH2/IR0SvT/LElBhy4QDDq+Q7jTZx2v69uQ0lYLZ7nfND
	ODzDfN5qKnGRuGrgYx8u/3GANw4qeIUDf1avKMlV3Y5AEnXis2y34ZiwhYqI7vR15z36Pyq4KAj
	rnDshdDvK43MAtAUU4egRu8upGoWCYOhoFeFuQOdOrj99sA=
X-Google-Smtp-Source: AGHT+IGwu4VQLnlJFs6GzKMJbAn+zsbelXeJOEHQ7ZYF07CobpFLXmQe5OvyS8qq/3NrifHYogJSdw==
X-Received: by 2002:a17:903:1aaf:b0:223:4b53:7349 with SMTP id d9443c01a7336-22de6ee2991mr4555745ad.11.1745879726339;
        Mon, 28 Apr 2025 15:35:26 -0700 (PDT)
Received: from arthur.. ([2804:7f0:b342:76b1:6820:db67:8f54:473e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f84a2f19sm7853589a12.39.2025.04.28.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:35:26 -0700 (PDT)
From: r2.arthur.prince@gmail.com
To: linux-iio@vger.kernel.org
Cc: arthur.prince@ime.usp.br,
	Arthur-Prince <r2.arthur.prince@gmail.com>,
	=?UTF-8?q?Mariana=20Val=C3=A9rio?= <mariana.valerio2@hotmail.com>
Subject: [PATCH v2] iio: adc: Kconfig: fix undefined kfifo symbol in ti-ads1298 module build
Date: Mon, 28 Apr 2025 19:32:45 -0300
Message-ID: <20250428223520.1100832-1-r2.arthur.prince@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arthur-Prince <r2.arthur.prince@gmail.com>

Add dependency to Kconfig’s ti-ads1298 because compiling it as a module
failed with an undefined kfifo symbol. 

Signed-off-by: Arthur-Prince <r2.arthur.prince@gmail.com>
Co-developed-by: Mariana Valério <mariana.valerio2@hotmail.com>
Signed-off-by: Mariana Valério <mariana.valerio2@hotmail.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..513f2238fdee 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1492,6 +1492,7 @@ config TI_ADS1298
 	tristate "Texas Instruments ADS1298"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  If you say yes here you get support for Texas Instruments ADS1298
 	  medical ADC chips
-- 
2.45.2


