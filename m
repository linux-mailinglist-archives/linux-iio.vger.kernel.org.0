Return-Path: <linux-iio+bounces-10419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9DD999418
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A20C1C25CA7
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E741E2849;
	Thu, 10 Oct 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUtByDHX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335911E47B0;
	Thu, 10 Oct 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594046; cv=none; b=FAslpjeyhozNeahYqksqftGQkLIq3Tqzor4aHYWCYjyuPNR+2+XQHJfVOOCSEXryCu5MhaCnfjIPforSBA2uHx5HRFKR7R7UiOzF+5XydOWfb4frpyedPBUsjjJZBhGEsK94KjJZKSOAV7DNl1GndRhoJeUVXC19F08oyPDdt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594046; c=relaxed/simple;
	bh=Atvk271s1uf9rHfU9zdJgtPZZlF+DI0XgO+2rmYv/Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LicPy3mN2sQRucQtnVdVAIpnmAc2mof2HKVA38Indy4XMXIJb5Id235N4dJ0U6u4tp9EJh4yEPIcQht+KSe3CojYcEx3b6G3lcySZ7msPgTBhEKgZuV1RHmQt7dG6qiIuOBeSCILJam1sfCVxwdgzlpljtCt3siflEUq/qZduqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUtByDHX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a999521d0c3so229807266b.1;
        Thu, 10 Oct 2024 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594043; x=1729198843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQCESS3HWEnQ/klZmdeVKbDR/Rh9U3qG2a1+qMswy3M=;
        b=fUtByDHX9aq5YUOT/fDaZZ8voRSjYAMeNnGFMgtQQAVFB08eWMJGN5iVE90ZR5ar3e
         JmG3KgKIwvItclYOQ6onYdgPoJUKcZQAIAT4c4UcExGdZYqRg2PtLM+5DAOr5Pm7k11r
         7Y2Dv9MZAL8qxhAzABn4NyjKFx9wfWo4I3s4lXBPmNuOQhNABdlVHYhzbTbK9gnPBBLq
         0x6Ue4dLPOxYNdsDda1K8UDhm7oH7gjPcRDg8nPfRKK6IHWveImqY7LuwOk7SKv14CtM
         fCqeZz/s8ClLPhnDzenvUI4wK6OotcCxKXku++uiLVuiZ1ITjZOuzJuGjpzVsIZSnOen
         S/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594043; x=1729198843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQCESS3HWEnQ/klZmdeVKbDR/Rh9U3qG2a1+qMswy3M=;
        b=U26++8xUY7OyKoYXU4AocnWllrmzS0Sr9Lebyv18zSOsjtZy+XzgHu6DHTnlrqBIlq
         5ofbPe60qGsbxOFF+mATUOjQHip+sHMT19eIDp5JDrfF/bwrKXoEgvvQxqMza68Zod5u
         EW35ko5C/jkPHTBPIGMeWSL486MRvzzaS3vWtPGCCW0DZfshRVHlvyVQCM9KgE3TBNyS
         pzJyohfKUds0VqiqD5LJfMsBr24PxRQMlLrlX/mrKXLcKrwvdk9O0lFKZULCAh0X90W5
         yuvhrbUOSHAF36VxKDvQdJGHQRgSt3frNfrJJKBpDAcb2PzMJHmmGhR0NRUbTPtcznpx
         4tyA==
X-Forwarded-Encrypted: i=1; AJvYcCU6tqR+re/5U+B1U9o56+d+HKX/pfG34XDgBTMY/m5eymzR1QRU+KO9FyTKMAo0LZvszqZcxuKnU4qV@vger.kernel.org, AJvYcCULgEzT8fQPGPpowV9fCN8j5Wxtk36M9UcMDCYk2H8ewd621i62LeART8X0yhCT+c65Ih3I9FtT3dsu@vger.kernel.org, AJvYcCXCLdH3SzjvpkbQbELgNDSlh8h86rUWb3eXoTo/szoI+Yvw+05xj/LFK9HVnqMk1hUyyzjrznZtuOfcNeV9@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqV9SEGcg7UIlC4kEisnEMj/wbORKe3JYXQfIFyHOlWy4axQJ
	jxJsP2hwib2Qy1Ule6DNXeX5k1dIpPOU4xwd86akXgnQSoJHZnWW
X-Google-Smtp-Source: AGHT+IGVF4ZA39rktwlsytewTYF4NDwOe2BprbzFbGpjmIRgWI0oVPdbNeSa3zkwu4n8w4YnTQZ3+Q==
X-Received: by 2002:a17:907:9484:b0:a99:59c6:3265 with SMTP id a640c23a62f3a-a99b93697cbmr23156666b.9.1728594043225;
        Thu, 10 Oct 2024 14:00:43 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:42 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/13] iio: chemical: bme680: fix startup time
Date: Thu, 10 Oct 2024 23:00:20 +0200
Message-ID: <20241010210030.33309-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

According to datasheet's Section 1.1, Table 1, the startup time for the
device is 2ms and not 5ms.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index b2c547ac8d34..e55a48982b3e 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -63,7 +63,7 @@
 
 #define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
 
-#define BME680_STARTUP_TIME_US			5000
+#define BME680_STARTUP_TIME_US			2000
 
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
-- 
2.43.0


