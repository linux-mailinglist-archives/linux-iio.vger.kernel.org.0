Return-Path: <linux-iio+bounces-18610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89EA9BBA3
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 02:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0E21B687B8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 00:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1E81E;
	Fri, 25 Apr 2025 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZwR6dVP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47923748F;
	Fri, 25 Apr 2025 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540098; cv=none; b=lEfYYNgoZOd79lEh15tE1sRKzp2ml+FW5Qg3e+PtS/pChLBpmDP/tvm6/QySM7M30GwFtHVQ3c8/Ys68ABsFuWp3GwlsIdg5t0VPj9e1nFGn6YRiOqlx4lnrb1nOL4pJ5MSFWUw7+Qm4A9+FTySfJ6ghy6PWH8LpLBQYeGE9HQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540098; c=relaxed/simple;
	bh=CoEPTIATxfGm6/ospC3WvWVyiWwjXysbcgPQFi8ViSo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jru1xSwbte+SCWMIIFwLvrVEewO+1MFvDNILRLUAEFc/iL9o67ROyE7j9ynVfhFqqebFooy1dGfwVWCtWYWW/NOrwQZGPYvetmqorxnTA+a7EV3JqKCO5W1995oCBM9Ex4MiXv9FlZ6eSx8WY5jqZ8eqODT+SKqcVy5LSn1ZcvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZwR6dVP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227a8cdd241so22654095ad.3;
        Thu, 24 Apr 2025 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540096; x=1746144896; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mlGba7pFFT/RzOIVC6cM7hCjpsJp+0aTxjK3ENj03PQ=;
        b=NZwR6dVPRrIGpYj822WiwC6DYSuoQEjdx7/rhMqKCOfIqFjvZrj3JlbXXYWPTioKnV
         LHokMt6YaAPmZAvcYhdjWNoyei9wZZXMPWInhU9/+4OL4h9tZOAdfsnTrUni1pUIe4Zh
         0UogI0KPD1Eg8v1OKqqxQYgh70cVfXZhXkCQN+DDsysNWOr4o/8367TPXWqWV6gHDOVR
         4ZiAzey/fRuxjAYnrYCnZVTsAqUyGA79M0csUzPGKf3O6WtGh5PqxfDnQsYd3i0J1LMC
         mMx4f4jD9LaLX/RyGQRwL+nr+vS5cRl+t/muCblVxvJIi+UtpWNXI+o2dztHBUlTRjWX
         uhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540096; x=1746144896;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlGba7pFFT/RzOIVC6cM7hCjpsJp+0aTxjK3ENj03PQ=;
        b=sdugqbFv0ZYGSISui5gECd98F3TsN/HK5plUOa9578GgOSu09qzrgGXT6MeLcctelg
         gNPbOtXsHUqKZ3gTyX1e0Sxs68XWdVCULSEsiorFJsL9bHmeqf2Nn5UZNoGUJjftbvJ2
         04vvuO/vjLCUX9uI7qhWElo3W9o0dIitOLJhookR0YMVZ++kh6IyjRibfA4cZadHAs4k
         swRUIRDFH1VONs4MNXmC3avIJWr+1TctoKEbykyq7pKEQjp3ZUMXyoIvqbAmqci6qcS+
         m3g55nax0wqlWStjQpI7VNg879T9S5J5Hn0JaHwB5tUJfesixg4qkxf1pO1JnWXUZSI6
         ab3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuOyNOOA56KsE3THYXjDqJaTAfMBm0jjTiEHnwwa/Fv9VuiKa5e3hU8AcHfMYAZbXDoTkhsbrEZPkjo6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5gwkHZmT6VS2uVv9wda78y4lXYodbtSi6oUMaaBwF3ciBC5f6
	MJTHSOVCX8nIsE3wlh3LnfEog5rM+Cau2MHid326ciZo830eOQBL/l2Deghi
X-Gm-Gg: ASbGncu9kf0BwzqEVXjWq5Ri2z5XYwj2PIMSABl5d9jZ1Ep1X2pLWJPl61rWxe+bFxg
	tWZDwR69PDSyLwK1gjED3HiWWwBd5VGosu42ddHtMC36jhsNWeE24TEAutCUo8fMIj5+jFq0lIN
	JNzhg/pFMYVhQ+fK8hrpn+KhIJ//yA0iPL1t3b0bD4iuPNQJ4I8aoMFPsTdvaALI9l6t4X/HtTK
	r0zWK3fDf58HYYKIt+TWkKJiQGUsnSdk/Qwnbc5GzgtC2yhpONXmDo1dPUnHQOujRzbPcfZyNbZ
	Xg1eqoBk47dneNPs9tFVOv5fMYsSd6BDqn7nQR7zL+dMSFeJ/lk=
X-Google-Smtp-Source: AGHT+IGH6mnt84oPU0reFGj1i8tWcThJ/AaFjNZWkwx8vtkBdghBBLiLAhYpjWdoMZFdlSWihaT5Fg==
X-Received: by 2002:a17:903:114:b0:224:256e:5e3f with SMTP id d9443c01a7336-22dbf5efe71mr3602415ad.25.1745540096330;
        Thu, 24 Apr 2025 17:14:56 -0700 (PDT)
Received: from [192.168.0.110] ([189.101.161.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbdf7bsm20035165ad.87.2025.04.24.17.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 17:14:56 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Subject: [PATCH 0/3] BMI270: Add support for step counter and motion events
Date: Thu, 24 Apr 2025 21:14:49 -0300
Message-Id: <20250424-bmi270-events-v1-0-a6c722673e5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPnTCmgC/x2MQQqAIBAAvxJ7TrBNE/pKdChbaw9ZaEgg/j3pO
 AwzGSIFpghjkyFQ4siXr9C1Ddhj8TsJ3ioDStRSoRLryWikoET+icIoO5DTrpoeanMHcvz+v2k
 u5QPgLwn7XwAAAA==
X-Change-ID: 20250424-bmi270-events-74c6ef5f4243
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745540093; l=866;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=CoEPTIATxfGm6/ospC3WvWVyiWwjXysbcgPQFi8ViSo=;
 b=+1sW7BadGStHyJ3p8QaCG3efxQp5AeIH6GRAa55MnnKyEqvlvAlVw16mL1wolUcVaJ9tCv3QU
 WFciEPY1xW5DP6PL6qvxfwTVe/6ByFrZxvjVHeMK4B54gGBAfcaBd6J
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

This series adds support for step counter and motion events using
interrupts in the BMI270 driver.

The step counter can be enabled, disabled, and configured with a
watermark, all from userspace.

Any-motion and no-motion events are generated by detecting changes
in the acceleration slope on each axis.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Gustavo Silva (3):
      iio: imu: bmi270: add channel for step counter
      iio: imu: bmi270: add step counter watermark event
      iio: imu: bmi270: add support for motion events

 drivers/iio/imu/bmi270/bmi270_core.c | 523 ++++++++++++++++++++++++++++++++++-
 1 file changed, 520 insertions(+), 3 deletions(-)
---
base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
change-id: 20250424-bmi270-events-74c6ef5f4243

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


