Return-Path: <linux-iio+bounces-9498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7257B9780EA
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5781F222E3
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D51DA639;
	Fri, 13 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBKB0LoB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FF1DA2FF;
	Fri, 13 Sep 2024 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233558; cv=none; b=M3Wgxgnr8M6sLpiga86EL9nST98QoqSJBj0HO2XTow60xh4lX0eef0sWbuuUw9EXd5xImrRYDuYzJu1W+2vw7IOCBUVf/4lEtT44aOe8nfiIkBJl1RDfriaIrBVA4UD6jzsmZN6uY1+9FJYB7wtLG1r8E9pSnDytJkHAhf3JIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233558; c=relaxed/simple;
	bh=4q/8N6O8ffI72x/9iTUFiRqxpi/mE0XbxqrQO5oMoWM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HEBiWvQLSTZFPP+aCgeANLthpMLjJ9rf5evyn0ouolmK7/1GdocAYeFZqEIiZ+sPw1icOB/uc/5vuh4O+j5Ci066+UvX6h0IPxOXZ3vVMfgo/6As36wdBwEcYDUq9xSc5sXX56KX9R8XinTuMjFhsCIf64jjU0fSqNwdK4TCysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBKB0LoB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365aa568ceso1202316e87.0;
        Fri, 13 Sep 2024 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233555; x=1726838355; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnZBXkdG1OqmFjnngLoBqqNkjebYkNRY5cB09E7/o7A=;
        b=YBKB0LoBg7DxZbkSoO0yLAsR44a/nCALzXKpXoEpkGsy8G10bABYlfEbl92zhs91BJ
         0M3yJYNfb+cC9ZYWGmtu1y/4Gq+9PqmmVoWhW7+gXVvbKUjinijYEF7NveKtR6kZux6A
         iYRF2F8c2M3jJa1NEP4uQ4ywmSnSCoAgCp++rBEtzQcd/rnU2Rz6Ho4M0A5NG0a/QA2C
         6ilnW2Be/7wzWLvJH2Y2K6/lMPkMziweug5kUCGg1VPWNnouiOaBc9FMmt+HF7ud8EyP
         Fg4OEwdWkndD6zmxU0U50VXPHEIbA3TlPp9OcjNGO3+kF252pPtfm79zj/WIolCr5nfI
         0mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233555; x=1726838355;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnZBXkdG1OqmFjnngLoBqqNkjebYkNRY5cB09E7/o7A=;
        b=VjDhoxNZ152VZapEejH4ly7HUIprVmaLya3ud3tOFamfQOAgDXMifG7Wj+xLEbUa1/
         RKXaEAvkSP/qJOmaH9WKz/gWpAoeYq9/vPWx6U5Ke+5pSKb/MPpXANFVJ0bmnhIinwpk
         iNy9PMtYvo8WgbFyLeAfFyjP+CewGRuTsBoDnQc/w/IBMBVfyUMOEKyuWnlmAjesDLGO
         /PCuKf1LQ8S8Mz8DYk+Pd2Bn5MMOSsXukEdpZOEXLBhUbv/3HL/sZMC1wc1s3O7G/FYv
         pAG7BLHTks1yXcS4BcWhNqoTAn8GJqHO1zborxWmh6nACTesnPm330btiWXDSbmv2cL9
         kJag==
X-Forwarded-Encrypted: i=1; AJvYcCUqH8bmb0JPZzsP9uoTdT3e7ZHpwsbNMF4dd1utiZ8jPmJmtY07pxyvfzquGLatJ2pM75wmwJWSU8Jh@vger.kernel.org, AJvYcCWW+XGePhTecTsGh0V4YLVWunbCGzYwgGAv2TbqR9f4XFtrnTit2L/AkQoFA3xiekowClQPWSCS@vger.kernel.org, AJvYcCXJ+tl4TfMLo8x3VMuRvcocOJ4feioHqOXv9WlTvGBzchN1wssn8x18gujBFuymSnrhIy1MhDf5m2nreZio@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYJqYClbfdkFH+sC2m0M4Fq1fZ7lLfqyEsasZWqr5Y64mffog
	D34gxsASKfe7s8FzjsGrDZq9YktlwmoMtkYSokOl+RZJqhqBaFy/
X-Google-Smtp-Source: AGHT+IHLOctH/seZi9U2ROlC0Paog572OIeyF1WDBW/pyJ+Rgfnrhh7rDUxEq6zeapMoNF+4zLw9ZQ==
X-Received: by 2002:a05:6512:3e29:b0:52e:936e:a237 with SMTP id 2adb3069b0e04-5367fec8cb1mr2509991e87.16.1726233554670;
        Fri, 13 Sep 2024 06:19:14 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:14 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/7] iio: light: veml6030: fix issues and add support for
 veml6035
Date: Fri, 13 Sep 2024 15:18:55 +0200
Message-Id: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL875GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNj3bLU3BwzA2NTXfNES8OkZAMLi2SzNCWg8oKi1LTMCrBR0bG1tQC
 dd0DYWgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=1792;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=4q/8N6O8ffI72x/9iTUFiRqxpi/mE0XbxqrQO5oMoWM=;
 b=4KjytU33ZjXrLgrm2P1Kf/9UjwbWMq1EApvzJscdq7sGzb52I9BXebT/4H7SeFW+hMPe10/Lf
 cfnvYuMHvxkDlXQkTNQKjJ9vpGw8/UGr4bvJEjyVMtOjYhZngvBCy/m
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series updates the driver for the veml6030 ALS and adds support for
the veml6035, which shares most of its functionality with the former.

The most relevant updates for the veml6030 are the resolution correction
to meet the datasheet update that took place with Rev 1.7, 28-Nov-2023,
and a fix to avoid a segmentation fault when reading the
in_illuminance_period_available attribute.

Vishay does not host the Product Information Notification where the
resolution correction was introduced, but it can still be found
online[1], and the corrected value is the one listed on the latest
version of the datasheet[2] (Rev. 1.7, 28-Nov-2023) and application
note[3] (Rev. 17-Jan-2024).

Link: https://www.farnell.com/datasheets/4379688.pdf [1]
Link: https://www.vishay.com/docs/84366/veml6030.pdf [2]
Link: https://www.vishay.com/docs/84367/designingveml6030.pdf [3]

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (7):
      dt-bindings: iio: light: veml6030: rename to add manufacturer
      dt-bindings: iio: light: veml6030: add veml6035
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: light: veml6030: make use of regmap_set_bits()
      iio: light: veml6030: update sensor resolution
      iio: light: veml6030: add set up delay after any power on sequence
      iio: light: veml6030: add support for veml6035

 .../light/{veml6030.yaml => vishay,veml6030.yaml}  |  42 ++-
 drivers/iio/light/veml6030.c                       | 323 ++++++++++++++++++---
 2 files changed, 319 insertions(+), 46 deletions(-)
---
base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
change-id: 20240903-veml6035-7a91bc088c6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


