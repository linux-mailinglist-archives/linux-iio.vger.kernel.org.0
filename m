Return-Path: <linux-iio+bounces-24694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 025C5BB87F3
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 03:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C79314E3B27
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 01:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038021A447;
	Sat,  4 Oct 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coyUrBqa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE42163B2
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542997; cv=none; b=IQtTm1bpSmol6VD0uIWeDauooAswWzlbUl8AfPLFgRRS1/zhhOHTnWbzUWCjdAT1SYiI7fJnTSW6YoeZQ8MIM1GOJ53amYXpdVsJxaNZUJJ1fx8BOOyhIiQJg1SEvWidM8jOPCuhf3QC/sctQK7ancPS0u5lOfH57fsP3zEtD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542997; c=relaxed/simple;
	bh=hORoEnA4rNo9eZ2TnSKm6bO35jEMPOOzljSvUmmDcv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYzHL1DnWN+9IyNDRwohoIeksaofjEG5T5Yyszit43ea1nyaDfIKBoD6mLcn0T52yL25ESspBsIeOTbhuNsQpkJfs0ZZTzqtBTfjnnvLYMf3TmjHwAe3awIbFEa7Io6XUsuiRpWHbfihjT7cEhkg5zqTbcC1EgQgE1ax4MQLBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coyUrBqa; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-27d2c35c459so20304845ad.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Oct 2025 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759542996; x=1760147796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTEqLH7hif0P56GR/htRgCIrTJyGDU/Of++XnbDqejk=;
        b=coyUrBqapuTJexS7xn3g52pQ2K4nTdBao9aI7hgyXEBvxBzjbXPVYEPAiGkDDgmnFr
         Gj4obPiJ+uRwZUtTXaldiG4X+rsurHtUqdrb/uCZ153jMkHOB0gLvCgzT4BwNeC0IKxs
         ayKdB/OUwX42ILX/ON58RzDbMZ0gVoxf8TH+rnyzn+aDdQliK5aTFyXZ2AaehD4X7QMt
         Sou4Cb/aGyOvh30hb3OAqoLWh7RK45UhszORo/t4EDBuuaa8HL3uSTdowrwjGTG6K83o
         dg/1GmKic5Hfy1UP9LyJiFFk4IC45H9MmDQ6nfZNgZaQN0Of8cZvSqals0Y6SJCqldIF
         Oxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759542996; x=1760147796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTEqLH7hif0P56GR/htRgCIrTJyGDU/Of++XnbDqejk=;
        b=WAYDpf7GSlE73f7zEeAQbnLFyajDHLLB+v8LpPEFuZ590Mx8TOaotSf0NV1a9Uz5Wy
         2tZNJUaHiCn+KyPaUuOHRauvmuC9drk5kqaQVA3Y947NdEyEj7I5ZCRlI+BFKg09EIcM
         aPm+R2l5UZAGrrbbsRZe6rNi3FlYoFCV2t9KnZpuHF38GLr68QtWihxOlJ6OS+zDxzyv
         3g3dPbPIq1gxMwGUoALZ9gy5b815DEa3NqN+HQvYSLtEQivLYfX8ir/B/hltTPMsW1Rx
         wUgMk1uark5TthuS9axh1LtWheonJocCbcDPVT6lMXnNdI4kwX+TTZgO8y5dVSmkQ/i7
         afGw==
X-Forwarded-Encrypted: i=1; AJvYcCWStdU5crefA0GVQzk9ElQiXfHeB5tcX9vR1uQvb3abxUYyZMR+KYNYOMOC4KHzbiWIUUsiQEtyW2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0Cw4lEeAT2o1xwzGCkaMV6iecxC9FWVS8Bix8sY9Yy142R8h
	z81ohTJjBifFAaAYm7/tnA2odohh1zGL4jyN4baJihkJ6iWpqz70W26a
X-Gm-Gg: ASbGncs4ASLXkM3z2FMYiQJGE5W6aA0RheQdnqtckgDmLSj2IP0J3GVx9CZbsJhURCr
	bah1Yez0bZoSYv6by66qJWsO84LWQxOV4hh0qA1rfv91/L9xLfJm4pAH/ER3HocWhNBM2J+mIFI
	F2PIAh6QVZF2aG4caymr2+Mdpppg4ia5Lq26h0B3lrvutQtKRoGjXbd76hvXItJmdNkxBLIvJjs
	4h45cmUU1PSAM1cUTg4/h7+72fdr/GvJ/CIGoIeQmm1mS8FiIueGP6a+amFBYG3PLvuiDa5q8E1
	otzVSzYvg7zpPPt0GurtijBHSNglq6nIszSfwvr39KKAPPj5+1bMjlhMyMSD6TGD++hLy7EjBcj
	I1pmpbu5YAY7DBhhqLcqRWBo1dXsxsOXDRSfEeVFEJe0VTqF/lAnzbFc=
X-Google-Smtp-Source: AGHT+IFNiL0NAmoLijKiqKFOV1i/A4WOPLrh/tgGYP4tBcXBAwrLn0RbO3aVkg2rfnZrEJWChZJVIA==
X-Received: by 2002:a17:903:a86:b0:248:fc2d:3a21 with SMTP id d9443c01a7336-28e9a5cdd22mr51596345ad.4.1759542995628;
        Fri, 03 Oct 2025 18:56:35 -0700 (PDT)
Received: from Ubuntu24.. ([157.33.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d134859sm63197485ad.57.2025.10.03.18.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:56:35 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 0/2] iio: health: max30100: Add DT pulse-width support
Date: Sat,  4 Oct 2025 07:26:21 +0530
Message-ID: <20251004015623.7019-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree and driver support for configuring the MAX30100
pulse width, addressing a long-standing TODO in the driver.

Tested on Raspberry Pi 3B with MAX30100 breakout module.

Shrikant Raskar (2):
  dt-bindings: iio: max30100: Add pulse-width property
  iio: health: max30100: Add pulse-width configuration via DT

 .../bindings/iio/health/maxim,max30100.yaml   |  6 +++
 drivers/iio/health/max30100.c                 | 39 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.43.0


