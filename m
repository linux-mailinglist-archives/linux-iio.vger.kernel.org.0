Return-Path: <linux-iio+bounces-9775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B459864FD
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 18:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA781F25BCB
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2024 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BE861FDF;
	Wed, 25 Sep 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfsacRvG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E312CD96;
	Wed, 25 Sep 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282452; cv=none; b=AxGFcALiG5vzJ2CpKRcOuGQZQ7j2MIxlSEHfPgXIn1GiBMH4InJzKE2HfMcNqtZDKqHe3W4hAgz2vWf9Fl6dpcZRvV6ym5SKH+/XJTp0z5FmJpHK6j1cnJrGlYdYNEi7NIIXPUCBmYRLwmA6BWtyxRTbybP4SHKQ9W0DtY68dts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282452; c=relaxed/simple;
	bh=dKUY+NDdPBarA9rG2rN224nqbqNSGCUQmvf/6by1y3E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LjNhjwDS/nv+hrllomCTAP99SDzK5LdHeG+ZYFP4BV3gsFPF0CIm0o3bG06JHph22DcHUpt1tdDllcGY9pAvSSjTwvatDqB85XdgBa5nFa7laAmkCtIYrMBIPrsAre9bcL5oRTLEadkmkccaxuaBgLh1kHQYVudLU5cx3YzhjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfsacRvG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b1134a6b0so761835ad.2;
        Wed, 25 Sep 2024 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727282450; x=1727887250; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgjCKc70CkRB5QqKgf3dogwF/9emlO9ivUw8bHZSVvU=;
        b=XfsacRvGoztpNjckdQgoFhS8LLzElHod69GtTuuD64zmld2HInYr6UYwzcXFj5SmHU
         T3GV+2m9vG12JVbiktHnrmdvWgB5zj28+ypIqM9kqQOfFoS0ztgRexZ9nMZi3PUwWybQ
         cA0Gu+1b583bKFwWLSrVVAnVrvlA6L2YrSllzqjaFEPfjanONWYIksCXztBbHYxKDm1l
         O4Qbj7JvPIew/4/NG2uO7ZQiOzb2vfZYqmjTC74rwPJwAJAF5+Zof3Htw6kKzH3qD+vf
         VydvKk7zjVBz1XLbV2+o49DtUdL4PqGg2nQQkTLbTmL0Z/OSX2uEawWu2iRR4c29FGGq
         +wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282450; x=1727887250;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgjCKc70CkRB5QqKgf3dogwF/9emlO9ivUw8bHZSVvU=;
        b=PO6jX8JkXasZyOUfLN6cpuRdOGEhJQpyM9VqyMwWO4d+NBXJfkVI+co1xGQFFj3+cA
         uHG0Ok0iWi52j4PkKcj+1O/JPHvlYN8nntZ6GK9jD+HxrUy4uIOPbz3AJ9lE2/2UhKdU
         Qvi41X4WsIlYn3JmmZoLRTixJA/fyjhTEsDEJiovHySaYhY5f2za0rRLyvqd83Y4kKBh
         BN5hcSGcbT0zf4cDhORJImp0rBtviPmUJ9mTJ1f1whaNlKfXrIQY8ydanAWYfJ/XGLX1
         SxzYLNAHZ+G2J9AzZabuVFGD8XZAABGDn35rrTjmAXX5JYlVjgssmLMviAb40hRtE95O
         +ryg==
X-Forwarded-Encrypted: i=1; AJvYcCU4PA2fWnRq08J19nrbWdAB90SHMhkfy+zrdWFBzkHj5quMSzWTOLZ2suPgI1pqu662qDfrDNIJo6pz@vger.kernel.org, AJvYcCVATyezU4NkQon0pLwU87TtDElv6tGxcFoVivoS4lwitOwjGM/uR+EU9dSzsGktKX8HUjj7O4l4G/feBdek@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3+lD7RaX4tEuFPUNgQJ5gVkg4Mf5WGtA5f+7TSgWuNaStwHN
	Zhq5US2Psh5xQ0aIfzobjze1/Gp3CIAacz/tqN0gtLR2bD0yCAlBQDeb4ara
X-Google-Smtp-Source: AGHT+IFvtGCBdQP+Jbfz2R4VcD8SNUmIqhtygqkDNkasIPNjZSjubb+oyDU0kMLkWYmG2x6CDg+tYw==
X-Received: by 2002:a17:902:ce89:b0:207:4734:2ca6 with SMTP id d9443c01a7336-20b1abfd200mr27575ad.10.1727282450077;
        Wed, 25 Sep 2024 09:40:50 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2bbecasm1726346a91.46.2024.09.25.09.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:40:49 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v2 0/2] iio: proximity: hx9023s: Add performance tuning
 function
Date: Thu, 26 Sep 2024 00:40:16 +0800
Message-Id: <20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPA89GYC/5WNQQ6CMBAAv0J6dk1ZEZGT/zAcmnYpm0hLtkA0h
 L9b+YHHmcPMphIJU1JtsSmhlRPHkAFPhbKDCZ6AXWaFGit9xwsY52Ai6aOMJliCeQkcPNgYeva
 LmDkHgFCXNVWuJo0qpyahnt/H5tllHjjNUT7HdS1/9s/BWoKGa3ND1LYxZOnhR8Ovs42j6vZ9/
 wJsMmQX2AAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=dKUY+NDdPBarA9rG2rN224nqbqNSGCUQmvf/6by1y3E=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDGlfbJlbK99ftNolk/3NwekK/8af7r/5Cw2mvs3tvlJrK
 Vyp4ri0o5SFQZCDQVZMkeXM6zes+aoP9wT/ds2AmcPKBDKEgYtTACYi/4+R4cjZ0kn2k5y3pAob
 HV256tK9M/eMHOVLuN2m5z1lKNjalsLwh7N3nvsFUfGzH0768p3/8/iJSnz8DiaPQtcrp/6JJ4v
 23QUA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v2:
- In the YAML file, boundary constraints have been applied to the `tyhx,performance-tuning` property, requiring the number of elements to be between 2 and 512. The description also informs users that the number of elements must be a multiple of 2.
- In the function implementation, boundary checks have been added for this property, ensuring that the number of elements is even.
- Link to v1: https://lore.kernel.org/r/20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com

---
Yasin Lee (2):
      dt-bindings: iio: tyhx,hx9023s: Add performance tuning configuration
      iio: proximity: hx9023s: Add performance tuning function

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 19 +++++++++
 drivers/iio/proximity/hx9023s.c                    | 45 ++++++++++++++++++++++
 2 files changed, 64 insertions(+)
---
base-commit: 7f6f44a9e58cd19093b544423bc04e1d668ec341
change-id: 20240923-add-performance-tuning-configuration-e2016e4d6e02

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


