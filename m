Return-Path: <linux-iio+bounces-4897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14B8C0249
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7537B2226A
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0187490;
	Wed,  8 May 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeYbhoIF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60485DF71;
	Wed,  8 May 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187141; cv=none; b=kpfFuALHwJXxuB/hbbG5Ge3MoTZhTfgSVcXOJrVB5ob4Yw4d+hKIVlfdhY5HHghbCWEhwRaVq5ey/ElO7K1af84WRGTanQ5RxE8WVmAvB+MrXYllasY+ASQAnYxz1aGDd3UYBNIMkatPUY+Dk9pbLrcWRlhVr97huoVgaMmvMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187141; c=relaxed/simple;
	bh=ZVL3/MG0rZEnSqZZx+fQFCsOx8hc7Z3x4BXaFHPnmOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CcSimePYQXvw/L20DguNNeC9Voy21XbuBq6CxTk+RNu5usmjDzmRpS+1qfwwqMvWpqriJDO4pO+7mVtS9oK3ZL12Gr5c4W9JV5+TWYljChmwYIxg8jL3hZ7h4150gx28e5OUxtx3G9ofm/zzbrRg+QW+bzRlEhVJnNClBW21j50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeYbhoIF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a0e4b773so1115772266b.2;
        Wed, 08 May 2024 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187138; x=1715791938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5imMJ1pENLTMxpFPbQowWfgZ+ECh5zrp5U/cewMTooU=;
        b=aeYbhoIFHwl6SCK0Kjsb63FwvQYPw4j9Revb5AKYvy6E/BJ6sjb2o3FL2TR+DAxqC7
         9u2uGjf1PhzWCrn3oA4Yi9BBGkyr64esOuFrx74nFMWYyQC0Ba93Y/maVP56fI6VbOiM
         z4pZS7xLvAzyZ34gz7yiprMW7D+UUdk+WR+errcC5r8xPsqWm/dDBO7kfb9Hi+agJbXb
         cBP9TiHndnF28Z5GB0WqNX0Hvy43U3mxlZ1qS/tyaJ5oB0p0nR/D8Dorhb8S7x1MNyBI
         bGxbRqVJNXPDV8QvEcNs41QNL4wb+kBeraavNFMWa9myp8kOqb7RUU3H9LcrwHu2PXbX
         NsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187138; x=1715791938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5imMJ1pENLTMxpFPbQowWfgZ+ECh5zrp5U/cewMTooU=;
        b=qJTyARzT5kxv5zsEUC6wRQoD2qF78p3NcaRuXZSZXSwQeSZkOrNR4HIrlocaisKijz
         199QBhhsSKEhNTG98T8MLsZ3Xgv0j9j5moPVS2rMORNXey1WZqMm8jKSRks0liMEXPru
         WyvL+4PzCgyDjX+OEg0IU7DZIY3WRXQw1EfVHeoTzXCdmcDczcr+PR4n/1mS8kKlza88
         37g11XFnIrp65IpaSIMlhLoF9667SCe4/zwStp5qbCIl2KMA4krzYvkpRiUY7ZohQXUl
         kwWBe2h/ZD6YNF4b0aDtySkYQs9j+RjsJZx1WctmU1tdI+hK2pLvFck1C7JaOcHBoiG5
         y/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO3m9thIuadf6SjK1jYCumCI6ALhXHGhjNEWwTQJP5/SLOdeMR5UTsG61gj5Y/i6UBDNzNIbbkx+R2XHQQNB4hOLuO4PN+DMur6mDBvXdkGG5swYDNVcal7DfCguF1w/++jo+vJj+P
X-Gm-Message-State: AOJu0YzBHgLX1n/M/g1SgCHDyecK1S+0pxk9xLXyQciP8rNe71YFKR0K
	0kjPhjrQq8lfQXNz+pF70GP/4F+Ki81dM5wKIwkmCZ2Cq126vXBK
X-Google-Smtp-Source: AGHT+IGSHD1wQ+NJAY7/b8q/KC8j7bsyL/YecCweYZ482UhU02A44cKbsWzzAPqoubC2tMBfmrtR0g==
X-Received: by 2002:a17:906:3488:b0:a59:ab55:a4f with SMTP id a640c23a62f3a-a59fb9555e5mr181193266b.20.1715187137578;
        Wed, 08 May 2024 09:52:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00a59a8212c8esm5648010ejc.42.2024.05.08.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:52:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v6 0/9] iio: pressure: bmp280: Add triggered buffer support and
Date: Wed,  8 May 2024 18:51:58 +0200
Message-Id: <20240508165207.145554-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on upstream master with the previous patches of this series applied
as well.

IMPORTANT NOTE: There is a fix queued up for this driver here [1]. It is going
to conflict with PATCH [7-9/9]. The previous patches should be fine. The
solution should be quite trivial with minor changes in all 3 PATCH [7-9/9].
When it is deemed necessary I can resubmit the patches or help with resolving
the issue.

Changes in v6:

PATCH [1-3/9]: new:
	- split of PATCH [5/10] of v5 according to proposal here [2].

PATCH [4/9]: new:
	- split of PATCH [6/10] of v5 according to proposal here [3].

PATCH [6/9]:
	- Removed mutex_lock() and added guard(mutex) to
	  bmp580_nvmem_{read/write}() functions as well.

PATCH [9/9]:
	- In the buffer handlers, add 'goto out;' instead of just returning the
	  error because iio_trigger_notify_done() wouldn't be called in case of
	  error.

[1]: https://lore.kernel.org/linux-iio/043f2be49df3c11152aaf32fc5467ed43fd59faa.camel@gmail.com/
[2]: https://lore.kernel.org/linux-iio/20240505200818.1e70c664@jic23-huawei/
[3]: https://lore.kernel.org/linux-iio/20240505202106.1c780044@jic23-huawei/

Previous versions:

[v5]: https://lore.kernel.org/linux-iio/20240429190046.24252-1-vassilisamir@gmail.com/
[v4]: https://lore.kernel.org/linux-iio/20240407172920.264282-1-vassilisamir@gmail.com/
[v3]: https://lore.kernel.org/linux-iio/20240319002925.2121016-1-vassilisamir@gmail.com/
[v2]: https://lore.kernel.org/linux-iio/20240313174007.1934983-1-vassilisamir@gmail.com/
[v1]: https://lore.kernel.org/linux-iio/20240303165300.468011-1-vassilisamir@gmail.com/

P.S: I messed up before and I sent the patches without versioning. The wrong
thread is here: https://lore.kernel.org/linux-iio/20240508163425.143831-1-vassilisamir@gmail.com

Vasileios Amoiridis (9):
  iio: pressure: bmp280: Remove dead error checks
  iio: pressure: bmp280: Remove, add and update error messages
  iio: pressure: bmp280: Make error checks consistent
  iio: pressure: bmp280: Use unsigned data types for raw sensor data
  iio: pressure: bmp280: Refactorize reading functions
  iio: pressure: bmp280: Introduce new cleanup routines
  iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
  iio: pressure: bmp280: Add SCALE, RAW values in channels and
    refactorize them
  iio: pressure: bmp280: Add triggered buffer support

 drivers/iio/pressure/Kconfig       |    2 +
 drivers/iio/pressure/bmp280-core.c | 1130 ++++++++++++++++++++--------
 drivers/iio/pressure/bmp280-spi.c  |    8 +-
 drivers/iio/pressure/bmp280.h      |   34 +-
 4 files changed, 844 insertions(+), 330 deletions(-)


base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 
2.25.1


