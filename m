Return-Path: <linux-iio+bounces-24988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8EFBD0881
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D533BF94C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9538B2EDD6B;
	Sun, 12 Oct 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYJDlZOP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4061E7C19
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290253; cv=none; b=QfDjNohA95RUY5uy/NNHAf1ABDMYNtz+cW+nkmzUZJURd8VRwZDJjVy4z/IdNMprndwwkXY0Echg2U0wTyMV3hY5y5g5BIcI1mV82NhkmRbBGEoq7nF6Z9kBNwZ/vx+NKXEzA8ML1UkF0ykq7K3Q/iK7mtvlov6k+rHhSMxD2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290253; c=relaxed/simple;
	bh=gzP73eKDgJq0OXCIKtEvkLfNMbdAuUvkBODtFN2PhFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fe12t8HtgT16JBKtsjccYJTqWfa9OxwEVNip2DtVIDbZ5pY+T+qMq1y5iUZmS0FGOhjYWdXKW0WBDxgsvTYHL9FjQsOItJaQwEgIOwuDcsHS+jLlMQXHeRho8gYBpc1F68HfedKMVK5/doG/9TUVuX60IRFF7SIyxiviv+3eswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYJDlZOP; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so4606930a91.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760290251; x=1760895051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a66RlRrFvTTKMeb9fHGsG8vzY8MvLsI+lGOp/Fg2CSg=;
        b=HYJDlZOPN4QdWiAOpXErzJP9jSIL2IbDBb5UozjrECl19/1i8DsD8EjKXs1w0P2gfU
         cUrXtZ9iCHs14s04IaVBn10yWE92tmPffTLSbjiTykq2Fczf6UGZW67qx/dusxtevTpA
         wU+gaAwGaDVr9QcJ0YrqGEmm1jI5BUasuykJkgGll7Ihc6NPchx4w4UzTxhxB1ffONbN
         fckwQrZynkLhf7CfdqJzIt5Tlba5l52oY32H5K15BEpix9qGEpCK0WC5S4vTFV0zSDoV
         LX20bg3uF3xRTKgXjPIbVwnrqlrkGMhuk5tN6CSMFd5nnG8OOrAdIlq80TqARU95FxQq
         2PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760290251; x=1760895051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a66RlRrFvTTKMeb9fHGsG8vzY8MvLsI+lGOp/Fg2CSg=;
        b=Mm62mOXWx7a5JPt/3s5t/jfzoIu0BnCR8chtE/w5tER4mkAWX7w+Sh1BWeSIav2O7y
         rKlY26ZVdlKkolqkIaJvP2c0DITnZD0c1cwhbR19pcgyDy3dzqmD+ZYFQx26FVMSCXx7
         fM/z5rsgHqFIP/e1kIo1tkmhbesO6ZyyugLzPoLj13V46eT5bSSvm6y90FpQ2f5843ZX
         fP+R//dTQBJhoWBP1c1XwNSwmxHervJZD8oRWsw8hjubD+zhyQC4Y/AGIGtUYwqZGpaf
         FhRX0ZyKjb6YOlaXcLa/wVix+ksr1n8DL1yz/gs9LWY/oHQQgZpKI/MJ/7HJieqdpIOv
         m5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCULojJxoy3YDQCqQGkAnQ1NETKfB+o0iJhl/znQ7OYRKanj3GwiUAmmkg7qjG4Iw0hd3B19pEQzbHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO97VhiUssdiD8bmuRr/bQ/HwTzGHKC8ddMF6wXbyHV76tqwzH
	7AjYRjINpxTEKNnBFGHTUS80Gln0LUpuaQLhgmYwkLvh2uw6bqo0tgM4
X-Gm-Gg: ASbGncv7f3LizB1O16fS1APROklVMrzi7RPgIokxt7g0Ts4LKOdbcNxBCs8GqQ9iPbZ
	79cqYrjDSeaDmmlKgYMvaLqpxARtRs4+KwtXK+7ymFywYn3jj7V40CHfEtG79K4qaAuzDglSeR1
	9R9bv6W77DHCM2DOrGs7wd6PA2VX+m/D34S8gWgPxME+nztZU8sAkQYucfojNwvFUZyEg/2R/Ec
	DuioU++V82jTOIXFpvuyxrUffSj/xhoesjKVATE08WuBxENC5eCa6JB2Ql1iUMqpCxrOdnxbdAv
	LGBGMfVg1uhuWj/vKJAFTnlXCU1GY3RyF8v0ZRbA9K06XYpIRq0qlu+8lKdjlcjSCSPKgJaTomI
	AQF8fHY8xxqjDbartLqEURlnE5ocwGAuenB2RV4uMeW6x
X-Google-Smtp-Source: AGHT+IFWBRH6VbicjAATB63VVFZLQLGTV6p9y+k3koTCoCdtyT6rF2oBp0hHGijhX3XmV73xokjn1w==
X-Received: by 2002:a17:90b:3d87:b0:32e:d011:ea1c with SMTP id 98e67ed59e1d1-33b51112272mr28805345a91.15.1760290250919;
        Sun, 12 Oct 2025 10:30:50 -0700 (PDT)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09ace5sm9030616b3a.53.2025.10.12.10.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:30:50 -0700 (PDT)
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
Subject: [PATCH v3 0/2] iio: health: max30100: Add DT LED pulse-width support
Date: Sun, 12 Oct 2025 23:00:33 +0530
Message-ID: <20251012173035.12536-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Device Tree support for configuring the LED pulse-width of the MAX30100
sensor, and updates the driver to read and apply this property. 

Testing:
- Verify DT property read successfully in probe().
- Verify default fallback to 1600 us when DT property is omitted.
- Confirm SPO2_CONFIG register programmed correctly using regmap_read().
- Validate different DT pulse-width values (200, 400, 800, 1600 us)
  are applied correctly.
- Validate probe() failure for invalid LED pulse-width
- Tested-on: Raspberry Pi 3B + MAX30100 breakout board

Changelog:
Changes from v2:
- Fix DT binding schema errors
- Add default value
- Remove changelog from commit message
- Add missing header file

Shrikant Raskar (2):
  dt-bindings: iio: health: max30100: Add LED pulse-width property
  iio: health: max30100: Make LED pulse-width configurable via DT

 .../bindings/iio/health/maxim,max30100.yaml   |  8 ++++
 drivers/iio/health/max30100.c                 | 38 +++++++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)


base-commit: 8bd9238e511d02831022ff0270865c54ccc482d6
-- 
2.43.0


