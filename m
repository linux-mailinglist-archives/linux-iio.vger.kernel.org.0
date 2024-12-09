Return-Path: <linux-iio+bounces-13289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D99E9DE9
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 19:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25C1281F40
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B53155725;
	Mon,  9 Dec 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXRi6jEz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B372114A4DF
	for <linux-iio@vger.kernel.org>; Mon,  9 Dec 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768194; cv=none; b=P+CmD7sK0b7uV9k4QJ+VcGHfOUhi1wj4Md/k+ZL9OmbxAdzBMRWjujvmE/buOpqfBK71EF8afZ8+4B7tRBfAfKv1Hx2gvfkO+J28gmYDYbsc6K2xwzkBu2g0pBACuqaCMeUXRNLEUtlWs3ZZYiC1SXEgRz1KUvuk0Sd+FiJJi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768194; c=relaxed/simple;
	bh=24MYQkgoTlfiw7sVHuJRnCAiuPe7BCFczr5XN0cKi0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IEEoijOMcUw9tlad/50xel2H5+j8FSdpgIEEl+eXmg7EMc0WBdb/KACZ7s5jKaTeJs009WpNcYcGlmCwrzkdw55H6IPxXsecGedOgcU+/j1U008SHJPW8bKMia42CwKSGY6h9g9eZui6B+LXYX5OaCp+JAbf2nmxDRHN3y0AQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXRi6jEz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so3370123a91.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Dec 2024 10:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733768192; x=1734372992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idDl2QpN1q2PXBdTp5bkYstZnU1gkBY3E9FwRyuIGkY=;
        b=AXRi6jEzWGdHiN4Llv0NfW4Z2QPMn74tkPcT1FpFA9dC5arVY66a2OptXM76cuGDBL
         kU1X5+rWEAswvTxbK+/SbjVDq17Lb1/a4uaXSx1eZwL3TyQ78PJ/0No/i8I8/XtPNo8u
         gycWi0L/qHBmou5+KMkIpgtEW8+3FDCufVx1mvkJDmASP6Xc89PxYOOXJRWrzCrFzFye
         Oqq9EFCTiXo1PeH3UM9eDa6G20GYU1jYmi1tctejDT65z6X5l4lN6alssvPDUzP7UjTE
         7O9QCxGsHAqMSd2tnskryfGwjfLw5J61qq10gmb6rNw71o3s3bHykf9Iqi3KT/rdUrTN
         f6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733768192; x=1734372992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idDl2QpN1q2PXBdTp5bkYstZnU1gkBY3E9FwRyuIGkY=;
        b=GNzs7B9N/Hxj6/McnGn0LSI3YHB4S5mUJnsNPJtpZorWu1Xvy/95V02uV05foWo/Zk
         hveyaBm1p2gc/jWLrJdCvLD702KX5UFn5YXA0BQ5bAXW2qxRxMU+LVUyjFriAExIpL4B
         SK+Ru6bmUZqMpxKBh+BaYu6ex+pc2vqi5/7L4mz9/Jso6Qka4B67LxQRQXGymR3T/dCr
         ffxnQMQITSBkC4MP3p5KNEGtZDCChjvEsG45XVdYavF7mN6OngGl7PVtwkYt1ZYw+kq+
         KdY3M+c4MvbB6478IYG6fZw3JMullkT9XUq3ZQMi/WKNfIbnoGZerosTi2kfnaz7dfdK
         z0/w==
X-Gm-Message-State: AOJu0YzFIlh3eqmO18qiBuag1h2/B5yUA5PzAtc5iku5biIhBsBg954o
	FrTX+N+GHs9EiWZKkT0GsX4sFSstyXwHg5vpYfT2Bh3CAD/eQPegwf5dKA==
X-Gm-Gg: ASbGnctte0wNaouiiL7SLdB9FCqcAEPPAAB3mnQhnyGUIh4pnAHd703CY3XsEOCX9xw
	5mlXKg0Z8xUnaEQu1W7VnwNAfzts1eIU3tpAk01CYRJjpUjQstKARpzgRofXH4+2UTl3Wn5WNRs
	+u5K9108CZqA2QUQxNLgt3KsqUFzpmHn0BlIv7jGOPHoZDNCWCnvk/7bAnv6aaoG8IG9itXgrNS
	y0j/3i229W0RwC0Cwa/gCPA9mnpekpc8MxiDTXV13Z+4xQoQMtiQ5vGCMOszcOxaCp/
X-Google-Smtp-Source: AGHT+IG6WGwNIxE/bToatG2u+NjqjDudGtYrKaT1dwO9riqkyIp2zJ1EyKOGIbrNtZPL3FIBOU6HaA==
X-Received: by 2002:a17:90b:33c7:b0:2ea:a7c7:1b8d with SMTP id 98e67ed59e1d1-2ef6955f93emr19978878a91.1.1733768191821;
        Mon, 09 Dec 2024 10:16:31 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fdbe:460b:c250:a651])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600ead7sm8226575a91.53.2024.12.09.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:16:31 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	andriy.shevchenko@intel.com,
	Fabio Estevam <festevam@denx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] iio: adc: ti-ads124s08: Switch to fsleep()
Date: Mon,  9 Dec 2024 15:16:24 -0300
Message-Id: <20241209181624.1260868-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

According to Documentation/timers/delay_sleep_functions.rst,
fsleep() is the preferred delay function to be used in non-atomic
context, so switch to it accordingly.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Use andriy.shevchenko@linux.intel.com in the Suggested-by tag.
- Add Reviewed-by.

 drivers/iio/adc/ti-ads124s08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index f452f57f11c9..77c299bb4ebc 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -184,7 +184,7 @@ static int ads124s_reset(struct iio_dev *indio_dev)
 
 	if (priv->reset_gpio) {
 		gpiod_set_value_cansleep(priv->reset_gpio, 0);
-		udelay(200);
+		fsleep(200);
 		gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	} else {
 		return ads124s_write_cmd(indio_dev, ADS124S08_CMD_RESET);
-- 
2.34.1


