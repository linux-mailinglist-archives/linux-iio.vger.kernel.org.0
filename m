Return-Path: <linux-iio+bounces-9719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98A97E48A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 03:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B6B1F20FE2
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF011C2E;
	Mon, 23 Sep 2024 01:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqouwM4E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF00624;
	Mon, 23 Sep 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054350; cv=none; b=tj9/YD4JgyN8OKDblu/nyo5vU6cXj1VPLgPccUPqQXbZQLi5Z9avMpicHEekfunfTR2Ct2k2uH2Zwf+7l0DpkC/ULPf1deC9fxMZs8qu9AczxmMkr+gMLZxs/xa6d88EzZZrUi+PlkOvkoD4V3VGtUscTIPlcjkjEGqv17Cvp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054350; c=relaxed/simple;
	bh=Jwr025/qUgs/LMxPLsqIgUhRpbA3frCNzlT8tBNoFOw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UrZcgdVoviBfTyqG6EzVYCJjdrf+Q6opgbivXzCDfezUa8CRDjEkQzFQAubltn7vL+Ka6pnBPJ2OPmnZhkZLMHNJLvFxBy4R2TuHfvFGqbcXBKTtHiliMuD8UbWQPUAhzSqQiAZboIzRs6phbWwQSx5HjRbGF4rhJ/CE+sDLZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqouwM4E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2055a524017so2172975ad.1;
        Sun, 22 Sep 2024 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727054347; x=1727659147; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBqObcMlz70tKe3cTglKMmMCQr1xEdAZC0tejq/Q7zg=;
        b=DqouwM4EyfP8xVWPXjQXkDmOmOeFPH0opqQLxsbnIz0gvwhKMMn3qSlK+o3dHBRaKo
         eI6i/eX1HXPrKBXv8XsalZMHTt/7qCTO20M1RxUtvYUfHRMVO1iF+fDsjCl2fBPCr6NO
         TyGabKF6yOp8aYjFX3TknyGvHW5X8+AZ6Uor2cjrWz1uObkZybiRKNPh+rqkyXI+umlk
         aO6mEEuq5MmSNEKt+mzouE3OcTYuc+nonqXUd6+cmxGrHHmRVTwx6MWCM1G83a6jsmB2
         vTP5Iu/WFXsHONxka9PiYNY6AClu1VE88VaFng5mNuZtTTmUH+jGy++/smw/eDdPKnYp
         51Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727054347; x=1727659147;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBqObcMlz70tKe3cTglKMmMCQr1xEdAZC0tejq/Q7zg=;
        b=AXFdMYmzGQ/x7vaR7J0FI5eMpktC0gpXrsY42cG4+RYPVSorcPA5ozJMvY3LAgcV9Q
         6GOykwDx+vZTTcH1WmzyGnrYmFgnUlnIUUWSiacwSmQQhb5B9rPOB9eGPFXNv3vJDsem
         GaLgOgQlQiZeTyjkz/Es7upre9GZ1OPiWhuWy8BvybdUqVok6B9PZL2iJR/RTwipzF8R
         NQg4Tnu6a4JclLxRGxRa1AIsjv9191GjzUtSshPajlJbyeEoW2UEHGdB8Ky1mWHiBFli
         dje8cbZC4gphnBEM1E0djq/2mFGTXS6Y2GTnFP2GG+qWX+EhSuSG/tUYN3XMT8H7H5DF
         batQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYjTDqtehfQxBwRbhsbsSujuGCNtqgc9REofW527NGspPsiPK3zqRRyFI0ItGwR1CTb10XFCBEbfx2@vger.kernel.org, AJvYcCVVqISw6cwcczvIk9uemEnxjpL5cp4h2ZSemK78+m8/dd2Nkug4DpHSgeh31aBv0FD8QUtkEhsWEjl2qtC3@vger.kernel.org
X-Gm-Message-State: AOJu0YxVckLRGw60SEznc4vfX9k6JTvh+dIkV7SDaP35qIEMGiXrKogW
	+XewPzD2ne5Zjw5H2HCWnOE6NmJxZ//De91bwRigPYtOQ3yZvwBrWcQV5xJY
X-Google-Smtp-Source: AGHT+IGR5fxE8/UV+yJoktV+ptXe3LQJTfZ3S9Ac5NCddrTXRKGPcGBaxU/8XH9gNU9+NZklr/I3TQ==
X-Received: by 2002:a17:902:f2d2:b0:205:40f5:d1a with SMTP id d9443c01a7336-208d83c811fmr60688865ad.6.1727054347164;
        Sun, 22 Sep 2024 18:19:07 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49920497sm14408888a12.45.2024.09.22.18.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 18:19:06 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH 0/2] iio: proximity: hx9023s: Add performance tuning
 function
Date: Mon, 23 Sep 2024 09:16:09 +0800
Message-Id: <20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnB8GYC/x3NQQqDMBBG4avIrDsQUxHaq5QuQvInzsKJTLQUx
 Ls3dPk23zupwQSNnsNJho80qdpjvA0Ul6AFLKk3eecn9/B3DinxBsvV1qARvB8qWjhWzVIOC3s
 HGN6NM6Y0w3nq1GbI8v1vXu/r+gGGm/3RdgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=712; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=Jwr025/qUgs/LMxPLsqIgUhRpbA3frCNzlT8tBNoFOw=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDGkfDt67c0baaediuSSL5D9zjjZ5LLvYoOEQ/+xTtfO3M
 3vbpqvs7ChlYRDkYJAVU2Q58/oNa77qwz3Bv10zYOawMoEMYeDiFICJnDrK8D/86ZpAUev1H0Te
 yKz8aaL7rXJCgrScwLfc7v6/78yeiE5j+F9nKfy9POhgR2HCwc4Iw7q8yi77H6//Tyozbn1lZOJ
 cZAIA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Yasin Lee (2):
      dt-bindings: iio: tyhx,hx9023s: Add performance tuning configuration
      iio: proximity: hx9023s: Add performance tuning function

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 14 ++++++++
 drivers/iio/proximity/hx9023s.c                    | 37 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)
---
base-commit: 7f6f44a9e58cd19093b544423bc04e1d668ec341
change-id: 20240923-add-performance-tuning-configuration-e2016e4d6e02

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


