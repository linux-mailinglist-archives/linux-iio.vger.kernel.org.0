Return-Path: <linux-iio+bounces-5233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606478CD95F
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 19:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918D81C217DB
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8A37143;
	Thu, 23 May 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqpxedMq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E017C77;
	Thu, 23 May 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486465; cv=none; b=dUknUFGfEofK8QUPnqzjKdZgGjrz0n51cEhjt8ObVAS0erMfcStvxIPsYHtpaDATG0DeBaXf1MS+l1fQ9XEbO6l5qDPNS0m9Lsvn+3BWWG4FAxg4h/JYK6X6456U5BEaAaKtT6rSmxqZ3LXoCEddGAZaJc/0/vFhxEkkkygQNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486465; c=relaxed/simple;
	bh=slY4SgOx4OIxxz4lg+EAWhkgbjVkVKJTiJ5tB3eKEmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eo5X3ysS+oPTfsSV7GYRiU/ZKkdgJj5VyVcZ7nfeBjydFX9LMYBo6r+nvnTIrku+AeuG/gR6v8JhyZqWF/Wtdm1Y80hTgXwdUpdk2DBQwppMc2rgpaiTeRUL7Ib4sruGIgDCVKQf6YcB1zmsmSZolD7LUQcp6+mwk7BUnzyBZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqpxedMq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420180b59b7so21366565e9.0;
        Thu, 23 May 2024 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486462; x=1717091262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofuZQhrtoe5ox5SQsJkB8ZI1CSvQVt+Cbdr+QsHVi+g=;
        b=aqpxedMqcGH5NOuozpv2tmCxEemPTeMBX4Q9E0TmIGJsKdFfJOI8hSzg+jmtftdWmA
         dQM63NTYKef8B+lCEoX5pI5SrdapJAKAc+x1YcNSsBvx/bZpp9vAE3wU52ZNZZmhNW3W
         Dxtj4f/MtdY+9WXw6BUQbvyrM6GOX9bKLxslGTqKnd+TJZ1/gryeRgKmTuX4XcpDGdxL
         +daAvHcrPrzENJUVzB1SHyFymHVtBSiVioCgDYdc0w8WlDZhs5yq62WO2Lmvjqj1F+P0
         T0EA+9iLLjcPXMt/ParFpGREH1oehRb+xwdJF+RbvUz3A6pYf+ZKXblgju8lC6DNF9mQ
         TbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486462; x=1717091262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofuZQhrtoe5ox5SQsJkB8ZI1CSvQVt+Cbdr+QsHVi+g=;
        b=Wgd4osypzumHiGlG5m7C1N94GRwCsaMVuDj25c7ptDewomKaq7Yw99dM/XhtLDMENV
         M6Zgokoi7til8hrnzyGP0vd7ZVTkLJ/cL8WVnW1V41vfmctVF7gdNYvTuzuCzVxHbwjf
         xlts27DKKYCRlW3CmyizxQC5CAIwggGVeHcDqdDLtpt3wiSk1wvFFl3/GXmTh43QRMVS
         nmtjCy8iAtH/4OZqEDtwl3U3xl3GIUZSGz9bn2S90Q81gU6dgnNQdBxc8rJ4p55yrQEf
         TS8ypNSwRoOpiCjJQQvWPfqnK+A1Ppmwfm9adSvaI5TdM97fLLbQ/2H55iSUFVgHKqln
         RXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz9bJ1gNEi3F8pww/Yavh6DHXKEPYIxRZvnygdQ3jPrVXTG4oXAl/YIJSv9pxcz71QG5DxuooNrWZyPCo7JYdWTJdKTT2suucHd8XOODNB826XftSL7xgv1wjvbtNjm4NCpNd3RCJn
X-Gm-Message-State: AOJu0YyB5Zpx0s4UUveTr7Y62woNOtnk5C/I62en0j/iklCQnq29vRo6
	k7LurxZeyGq22NXY7mAkqhBxbxZEOieVoTvMJbhtyIixnyrE9qKA
X-Google-Smtp-Source: AGHT+IGHrecArT5ySkyykW7zuBYv+0c1WmgeKm5Uu3uVLpJ3ByWeHzOnJtSVelZIFJo6pMOqF8OMaw==
X-Received: by 2002:a05:600c:3109:b0:41a:a521:9699 with SMTP id 5b1f17b1804b1-420fd2f16e3mr49448725e9.4.1716486462126;
        Thu, 23 May 2024 10:47:42 -0700 (PDT)
Received: from localhost.localdomain ([176.206.88.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1410csm31103855e9.15.2024.05.23.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:47:41 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Luke D . Jones" <luke@ljones.dev>,
	Jonathan LoBue <jlobue10@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] iio: imu: bmi323: Use the new shared iio_read_acpi_mount_matrix() helper
Date: Thu, 23 May 2024 19:47:35 +0200
Message-ID: <20240523174736.16692-1-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default mount matrix (identity matrix) for the Asus RC71L is wrong: the correct one is defined in the ACPI ROTM object.

The introduction of the iio_read_acpi_mount_matrix() helper was originally meant to share a good implementation among two devices:
one of those is the bmc150 device. As pointed out previously the bmi323 is defined in the same way as the bmc150 on the ACPI,
where ROTM can also be found.

I have confirmed this patch loads the correct mount matrix on my testing device.

Denis Benato (1):
  iio: imu: bmi323: Use iio read_acpi_mount_matrix() helper

 drivers/iio/imu/bmi323/bmi323_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.44.0


