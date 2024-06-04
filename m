Return-Path: <linux-iio+bounces-5800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F25288FBF70
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9DA286A03
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647B14EC79;
	Tue,  4 Jun 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncADUrwD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2814EC69;
	Tue,  4 Jun 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541906; cv=none; b=peD7fwRZwJYJzxJiHbBHODoHJU+YO3DqwBCBiI/fptwfxOayrazI7OVmW0YE8dpaV/jzw5SdM2oi1cidmvIYi/+xPL+P8MTXWE/VGr7dz5L6mr0z7oqQ2ctwt94yfVd/lG+3ep2WRKKH/mpcvYjqxad+Gof6scZegyY5vvQKH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541906; c=relaxed/simple;
	bh=1HPHsVbVreRIstqrbeKaTP8EFP0/aLLOcaUwnO+ibPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8GUrW5NkJVTq/FCo0fGkWRa3GL0ixTECaUIHRmO21JI/Lohn/AtDuYptA5ZdYaBzQfQFbl7yafYOUPltEPyKWp9K8kv4o93futl/Kxy4lw5pRwupz2YfeGVtwo9aCgCgJWqE7YvMxb3b6wRYtw+raPWoAWEsvPcaoThS9toEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncADUrwD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70260814b2dso293057b3a.1;
        Tue, 04 Jun 2024 15:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541904; x=1718146704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+HE1jadcQymVFTGU3XZI2NR8MDGRn4CBzGuTw21Pfw=;
        b=ncADUrwDWcdSSFlfQLc2lZ5lZIUK9ZjcbBK1P3thDD4OHJDl2wfuG2gd2574WnePKG
         VD6IT+jOwJotOgejSykTV4nS16pIhvokb2An/Rm003dMfpXcKfYcNgQCLWhZ6o79a0gi
         2YdNtSb31yLrxmbRuGZB4FRZQO2r3RB+HTslSlArTXgZwFEb/ZuMmIfSM7CMtFcrLKne
         JyMKWKLynRKxs+vhtVamzvu6qeV5+fwc0aRyqKzgEknMcfkva2/VIyQNxb3oaxg3QQte
         DTdzVnYjcVKIG9oniG90I76/PO75uvCv9MJqB6N1ivgbkWVrBx7i9WlJvkq6yZ18Z5zx
         s8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541904; x=1718146704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+HE1jadcQymVFTGU3XZI2NR8MDGRn4CBzGuTw21Pfw=;
        b=us0823Ety9wcEU6/SKtFkEnafXfz2rGMwWN27WpREil06Xhc40PfEpFv6hlzEA/eya
         xeZ6M1OYiiw4es4WVbEID4f/qNU+epv9In35tx2Lbu/c7wpZbHLGoJzrzl5XZPTDs/1U
         FGv5tOVnM1jD1ZtqrxYLK21eDPxVLJ49PzjIZ1PxZGisB7iEbti8q7ak+mkg5aH64P1E
         KQUMty6y6ycuyYSdl8lcZ6DZnzm/Br1cpnpc0E26yCDMSUOU0GQF3suwNmmlgpwLexpe
         P2qBsG8GpuskYYlZACM/F5/KuE/hfB8ZnoKLaJ3cMq9DOxJ9o8tz21bCY5m8yJBWmO5w
         VLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYK0+wyhwsXpam2Fz385laJUow6mmbLxNP5W4IltZrUzIeu6qfGZkASLrXk9gIZgbYUObb4Y8CZ9lCvJTVdemSIyBlfyEBgG8dg+SeslkqQvAKlFJ/gbbz6ki+bmSYgHV87XK7l/DpKxMzP5oA1jWRwnuzy57O0UjfXYYaLYYM9JiF0Q==
X-Gm-Message-State: AOJu0YwUsPGUFY0ibl4WxGGS63Lu7L5QGEEzft/M1QqKqCiBB06pEhKl
	deDPAT1OxFg87aeg0mGW+9ZyTVmim4iRDbYJQIV50ONqvFaPTNDVqP46DdHU
X-Google-Smtp-Source: AGHT+IHG95txt/EEN2XtLksxrB5BLETOojV6B2WT0UsHubIgaPBuvKC3rhB06KSUv+Z0T/4QVBd0XA==
X-Received: by 2002:a05:6a00:928e:b0:703:ecde:fc00 with SMTP id d2e1a72fcca58-703ecdf1af9mr29567b3a.1.1717541904037;
        Tue, 04 Jun 2024 15:58:24 -0700 (PDT)
Received: from localhost.localdomain ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a955dd1sm5312125b3a.64.2024.06.04.15.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:58:23 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] MAINTAINERS: Add ScioSense ENS160
Date: Tue,  4 Jun 2024 19:57:30 -0300
Message-ID: <20240604225747.7212-7-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604225747.7212-1-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for ScioSense ENS160 multi-gas sensor driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 304429f9b..92a130c8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19660,6 +19660,14 @@ F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
 F:	kernel/sched/
 
+SCIOSENSE ENS160 MULTI-GAS SENSOR DRIVER
+M:	Gustavo Silva <gustavograzs@gmail.com>
+S:	Maintained
+F:	drivers/iio/chemical/ens160_core.c
+F:	drivers/iio/chemical/ens160_i2c.c
+F:	drivers/iio/chemical/ens160_spi.c
+F:	drivers/iio/chemical/ens160.h
+
 SCSI LIBSAS SUBSYSTEM
 R:	John Garry <john.g.garry@oracle.com>
 R:	Jason Yan <yanaijie@huawei.com>
-- 
2.45.1


