Return-Path: <linux-iio+bounces-16184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D082A49859
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5A43B99E7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0DC23E34B;
	Fri, 28 Feb 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4w4V2Sn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B601C3BE3;
	Fri, 28 Feb 2025 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740742390; cv=none; b=ieymkr30z8JJlRohRuwNOnutBj+WXWd4QvYNOk14FeO90Hubgw86mYOhccNyj2CSOzMaqpU3DVS1HHGKXvwfjRsTbd/tEbkd59AQxEwQAAo1TH0vo3IktU8intsePvv/OvMGzbmqckTP0sZ7v66LQ0doRd2HvWGdC979j38xFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740742390; c=relaxed/simple;
	bh=Wk3NLoeyNebR1iWWK4A0do2AqVIQvT0KlwiOC64vi/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R42lKJQogo+SzMZYt2RjHSP8EUjUhFJysCs8cEZ8dETDkHlzScGZMJuOVG5qKr7bwiPC7Xqw2LPEx5x5KhgM5r6NXA7xp7h60ufK1R7Mlcfeb0UMqqXl+ROf6Pb0Ghf8dmdvWWhsPZbmz6Fac0GE7ZGByMXwPHOnCAQwY8qZa+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4w4V2Sn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso2738151a91.1;
        Fri, 28 Feb 2025 03:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740742388; x=1741347188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk3NLoeyNebR1iWWK4A0do2AqVIQvT0KlwiOC64vi/c=;
        b=B4w4V2Sn/iPpIWocsW1rstmLgVa7qiQPUwPKNiY/YyxQ0IWrWwYDuG7lk/x5CBeTzo
         +uq4IDb3IYYDKBJNO5zWB+S1N+AxF9AlDXTUJQeemqFWuRITDeSes1kcj0Hjkaaq3hLG
         NMa110BS8BDyikMaNnM3c8daprvEB270WChtyXwr05NyX/3/zvtkOMgAHwbnlHKPeFRl
         +Ql/9ChnRhoq6OOADE5fpamhaZgOaFC0xL1R3cXlkrMxwgEToj3hsOTpwtHi6uGU1iSD
         m82lV82P2Cd5bwp19h5qzkC+azKXOGB6vr0vhuHvlaqOARHWVfbX7zhSvtj2gm/9rDjt
         OQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740742388; x=1741347188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wk3NLoeyNebR1iWWK4A0do2AqVIQvT0KlwiOC64vi/c=;
        b=bYlfZJqoPJk4RrfuBSRzyVDfM/LVPHhGu9AJDZsi9Wi2hKtJNe5unrubkN9EFLWc8C
         Q8mQ70JE9JDKowg5a35JI9H0vpBTzHUuC87/0bajs9DkFbDxkG2duzVft+5Qt1oD5SEH
         JgEJgHnUnpiuqBzWhL+niJlbxFDtGH3fLU6FwuvkO89UQEOxjjsUsDNx6GegWDq6OIRc
         LXJS4frUez4CF5YE3mCTx6aMZPW0e4Fz1ZhAPUPAoQdxbCuuUFCBIcIzAObwpolSE81X
         5GqmLjBxo9vOsyORDIwSsN6H1fcEoB/gJkq19SXsqlvWIRnXerRPeh0INh+81k0ljDj+
         rjBg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9d+wDMnVrRfU0UlzI5SFRWCsp2sHKomuJWiGA2R6ujPflndCbwrZahQueXwO1rPLlA1rgFpgkvk=@vger.kernel.org, AJvYcCXqF/oajePyYCYiMBWNvPvpOA4i3s8KRND2JwBf+nVpK/p/GGxXNSyYZy6MO+TuRC7XIaB6bQTZ3aaYJWwI@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCjoXqm0XT0rreMMQ1z5LWCdUm8Aq9S6Zqn6HDadIMpzTorOJ
	IzcfHklmK2oGTRZVf3ObYuLEIOGeUp3dDpKjoN4llD3jmNa+HirDP8eP+4Fy
X-Gm-Gg: ASbGncvi2vz3rm6WbXgB5yah355JGfArlYaQ0Bj6TR3klVLIA8Hxlu8qDRpgVR9Mf7B
	v3O/fJ8jtkZUphyeJjifWxW6Q1/9/aG/FJ/0ULaI+xdN9hzSpfzVLwmTC0YYrC4U+LmVm3mxjWv
	sUsBv1sgKE2EAqyRV8a2ySyuOOj7xYIJuO7qkp7cTEVKFUjFH+EHCT3ceqf7N53bbZhpPWVGr4P
	Xo2SnVrCWh/PT8Q84WotSKp6bLF+GRj8xLw7+5Px9njNZNRtW4NTRaO8eQI8cZalJC4h7MDVq/J
	l/wsW7oduDtD2PpsrvVrzb4zqbI=
X-Google-Smtp-Source: AGHT+IGDl4zxony+vYh3k80V1xozG9YGu1GqiUZd7l8fXP020W+OVECvysFg8dVqbuBRl3s4lyI/yg==
X-Received: by 2002:a17:90b:3d0a:b0:2f6:be57:49d2 with SMTP id 98e67ed59e1d1-2febab7459bmr5822436a91.17.1740742388119;
        Fri, 28 Feb 2025 03:33:08 -0800 (PST)
Received: from danascape.. ([2402:e280:218d:2e5:568f:475:2d46:5965])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c37sm30704655ad.133.2025.02.28.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 03:33:07 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: marcelo.schmitt@analog.com
Cc: dragos.bogdan@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: GSoC Proposal 2025
Date: Fri, 28 Feb 2025 17:03:04 +0530
Message-Id: <20250228113304.63160-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone, I am Saalim Quadri an undergrad student at Dayananda Sagar College of Engineering, pursuing Electronics and Communications.
I wish to participate in the GSoC 2025 as a part of the Linux Foundation, IIO Project.

I have been contributing to the Linux Kernel and have more than 10 accepted patches.
I have also worked with Android Linux Ecosystem in the past years, and have worked on several subsystems, backports and fixes.

I started looking into https://wiki.linuxfoundation.org/gsoc/2025-gsoc-iio-driver and Analog Devices Inc. and I am interested in writing
the driver for ADE9113 ADC.

In that sense, I would like to know if anyone in the IIO community could provide with some suggestions for my proposal, and a positive impact.
Any suggestion or hint is appreciated!

Sincerely,
Saalim Quadri

