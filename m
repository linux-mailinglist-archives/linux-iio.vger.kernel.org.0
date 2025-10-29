Return-Path: <linux-iio+bounces-25607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80622C18CA6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 536CF4F2F0C
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E7B30DD33;
	Wed, 29 Oct 2025 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWAuAwou"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347020C037
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724316; cv=none; b=EoyxAVUVsW6W5cMyVBdi+BpiMGYoICQIe6CAS42rDmLG+3PMpcTdqoYF6utb9YlzlRGH3Su/ujnkhQZsXaWtZXKHNVd5mxHMsfCqu8sL2vvO3UFp6B6cM6vQa98O3lapStfYhEshkF2t6KistHKPieTK4XJ3bsbcW9YSTNADaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724316; c=relaxed/simple;
	bh=R//xgOGffUTe+9aSDmu6b6N2JOiXux9JodaCX1BCJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUc2poqw/yp4Aw1i7x/Bs94q3f5GbXa84cP8UyJUg2fhL3XMSMaF5ZCtX233P4f2c4snf9nF5T4iAHC07p/dKPCrZk46ZftLl5kxNopUoncbnXl+f7RYJ+D7ar6upxwOAw5w87RB2ApxACLfxOOLEZkiTodHI4drBeHHumHNZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWAuAwou; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eec33b737so98803925ad.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724314; x=1762329114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KFgF36l2HyFre4LmabzRtUo8eP+DInseCp8ECHz06WE=;
        b=QWAuAwouKaesOCq/mxceRzf5VQFVfR7t/u8GmVsAWOZIcbVieAcBmsjTbl9tAdRiSR
         EbxzuYqDQ9QVDExkkKofI0TKafS+BQVxDu6JT2iPbCTaCK4YyJC5taPrKMQtvVO0Fnvy
         6PTd/JuBW8WnKXFScf+tHDVg2t/uPlZKWSEjhd44jmGo1HywCEYFfvRZ6P5pD/Vyyo7v
         NmBb8AlFvd1yZ4TW6MK/lkXav/AhitrEOd1OdBbqSGt73Ocrses3Vmg1dLIk9R93pBtS
         TJQzHEK3Wwj5tCMa9YPUO9lqtHT6PQ+3Ms0aoZuxmMLWDld9RSh4iZ4d0+Jr2Ek8vBMx
         aMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724314; x=1762329114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFgF36l2HyFre4LmabzRtUo8eP+DInseCp8ECHz06WE=;
        b=NJgMs2f0IzrS+dRICPSIKGcrO85mkkPoNuVmjDNDVYPZai7YOMxcRcH0yPA9bWSF+O
         OfCGWJPcIjVWKSrHJBkT0Wi7rMYNWVVvqBUDz5+WAHWP74fY5KfwbVNtJjUhB2gTiF6B
         ehcHKNzen7GjU8PSd7NWTz1G4QvdsSOOvNEH9+iEiqWM7K4mV8SRbJsadI5VNu/BaiZ7
         rUZk7IQ3mHG1RM2U90g/mEYaZm4rcVMrJUp/26OLOaZZRu8iC45Eo51/vAI5Z135H9Oj
         QYvoB1bE42U+ErlwlFoEwGB8aFVOeEhnH7hiruwQUcHAJdF6Jz5H5f86+T4kOnc4o946
         IyUg==
X-Forwarded-Encrypted: i=1; AJvYcCX86PPg+/xgTSZQ3pcza2Ao3XSg757DRl6zja4pgXgTqmA+LKBAP54y4ON+NnpWGHF0snkKDx8uCLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygaha47Zp6kXFZjnxVtoAOSJCLoJmZwYjLthADEWRSJlRSwrJQ
	Rzgdnp8QtWhbz4u3yb9Nm+nuxRnPA5exCl9ZS3ui/9AMjlDz+67p5IC5F0lCM6i5fyQw/SHj
X-Gm-Gg: ASbGncsVZaQhZQA393btjMAqtoZYrE8AvrhiOQENSSxehEGX2muk0rqXSphBUQCcmy8
	g+82SZOgtIw87qCzrkt+IqyY8DDwZfBP/LWrwkJZGkbIAgAB0uBhYVBzEG5sMT10sUJlPN7zLeJ
	XBe4UfK1tEKAy84E6CzuOGPGAK7ytyMECJubSfRP+PasSvLhV8qnvn0+O0mC8dAU5V0wdAkBcjf
	Jo52BP5fr3ZsLnSZeyhDtw44tZaRDA3OIb/XId2Iw0gKHmiJlf0/4dZyoSedh7w7ZnFOiJfOU/n
	Nrol/haghC/gFhDJlxEuhEzqkQJ544CZulpeyWq4J6aPHxpyBmUY8Y/DR7+Oh+VH13pcGVRu/Mg
	UGjEXSaZD4ctpG4Sluq1d+1HeDWET8UdVoFh41zITy/7JJ1kmfkKBa3Ugm9+AIBWxB6wthfAmeT
	vrz4l5
X-Google-Smtp-Source: AGHT+IGZomJoLjP5COyqxCSaKhN2NqGWDmMGxh6UCXMB4fEdvmiwFvN+wWcXQr3P3Jjcl6bBGDvOiw==
X-Received: by 2002:a17:903:1a43:b0:26f:f489:bba6 with SMTP id d9443c01a7336-294def00e7emr24838525ad.50.1761724313711;
        Wed, 29 Oct 2025 00:51:53 -0700 (PDT)
Received: from hsukr3.. ([2405:201:d019:4872:4680:8a:2bce:378c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm140868435ad.24.2025.10.29.00.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:51:53 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	linux-iio@vger.kernel.org (open list:IIO BACKEND FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] iio: backend: document @chan in iio_backend_oversampling_ratio_set kernel-doc comment
Date: Wed, 29 Oct 2025 13:21:16 +0530
Message-ID: <20251029075117.104758-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buidling with W=1 reports:
Warning: drivers/iio/industrialio-backend.c:727 function parameter 'chan'
not described in 'iio_backend_oversampling_ratio_set'

The @chan parameter was added when iio_backend_oversampling_ratio_set() was
updated so the contexts could specify the channel, but the parameter was
never documented. Document @chan to silence this warning.

Fixes: 97e6882ed1a1 ("iio: backend: update iio_backend_oversampling_ratio_set")
Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/iio/industrialio-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 23760652a046..937f4ef38e1e 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -717,6 +717,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
 /**
  * iio_backend_oversampling_ratio_set - set the oversampling ratio
  * @back: Backend device
+ * @chan: Channel number
  * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
  *
  * Return:
-- 
2.43.0


