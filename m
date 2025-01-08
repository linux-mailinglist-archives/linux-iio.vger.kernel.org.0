Return-Path: <linux-iio+bounces-14025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D649A06363
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0703A64C8
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E813F1FFC7B;
	Wed,  8 Jan 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PSGBGDZs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6015E5B8
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357434; cv=none; b=SEewRS2e+dyHkmFPaC397HGGSc+ow78Q695W5iKEkihCcO0gNzd8m8ZIk6XIRObPuRLJOBt9GZs8bK07tKTLFaMKy9AiGBs1EBg7pypjXc65fgCv10+b+fxRl5RE0vcjhrT8kCONR9/qGzZIXNF9+4bcfyRrEDfhlPMSWjXODsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357434; c=relaxed/simple;
	bh=fpVjiOzU0iD1XUlCDZIAr6EP5RIEX41K0YW3HJlP3cA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jOTPPrdC3fGWLoS9N9SvwPAanvC+oIXlds8X6I0UdAsCgFMrf5jjSxw85yeI0tfZsyan+usuq+jM/ShdhiLHfMFLetBHx1YmKa6/04B+O4DXIVVfIX4fh5TwxZCSx5+dAzc+zwE3O9eB2l1qZBwhDnz2pLoEN3plEsNY56cHFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PSGBGDZs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436345cc17bso763285e9.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357430; x=1736962230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/wzKM/x5FC36Smmof5rrr+iE96TzoFsYrHQXVew5QDM=;
        b=PSGBGDZs/ZmdqzPrEBcrI4XdOH959rUq/qUJd46bGubWm3j1xCegcUUJHmVHIIfqYq
         vT23Z3m3eO7mZLwg0tHzCoA2N4TC2A/ofnNmAmOlceWeWgRwyKjPXoaG4beoQB2sS8io
         flq7l2dQADLxmsrO2gT9Ygd/letC1E2xU+Jt7FdUPvRF5JM1yoELPIw1nLbUdRXbjbQh
         kDqkzT2vxuqJ0s2+hUKa1Gl4x3/SAfcq7mD75VCkymO6WcYhBgEOFr7oPE2WMk1nUb9s
         UMrvoLDYZB7Q+XDYYKvVLdJqM9tcqucSmCewnXe4f5irIJsCuUrJHkS2UVgAdk4rDuXm
         tIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357430; x=1736962230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wzKM/x5FC36Smmof5rrr+iE96TzoFsYrHQXVew5QDM=;
        b=XKWhtubSbrLpfbnE63Oodwx9dgagtP4n5EmK1t02n+PEqh89EKrMptuKJPb1hf38NQ
         4ysE+FxeYaRI5q2fgcGeGSJQOU/MyodKO4pqnwNF2C30jOP4wZ1Y/gXsO3qG158G4zAJ
         ljlKw4z40ENCvO9nq46NKxrInmrwjrNm3TuuUTff2b2b55jtaA/1BGuxcaaJtMVNKF7+
         /eCFoPDiqXPsBhqcxM5q6FYC0PIYcLh5lUX5HisB1nYrmDXq9iZ9VEYUPuK05VMZhOvE
         Zf1kvZzdtsFmQYpT/uNcsVx4E0UbGPJHZ1Fnk2zVBKse8AzrugHbZSeejY0M4GwuNsuB
         yzjw==
X-Forwarded-Encrypted: i=1; AJvYcCU09CClfaC4oMMgMzDN5+ycyEW9WUjCkx7Qon01CfFYY8QHwBl+0ix//BUTPnDeqHGE2kyeqr6F25Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2IKAkSMAywOyxmtKqNT2A8C+kx2HOiAtjQ9SY8HUV2nIeLr8h
	uuZ0/WGQ0/pEv50iJdnoJv0giHhkU1d8H7mgIuoobAgWvlGRzZ+SaYbx5raVEUtBClPLdJaBTaT
	3
X-Gm-Gg: ASbGncs9YYMSL3iZb6ontuMeoWY84A/bTUHcHD0eN6DwbWmdOIP9HpT8AmTnMOl+s8x
	Vd0l8IehEpAe8MnLjoCqArj9Ypdw/THR6k8dr019av+Sv/MkKLNa9K6H5+W7q5qfqohKJhs8RfQ
	mBgxNxhn+UREa1yzTFIHDAMdUNEfz0qTYxZAkuq2uvtzZHQHkO+Cc3HLF6pYa3YMhnOc0j4EUE2
	Ot4jm/hdmXOKUzJ+3ChUrtdWSUXEjNtpSzoMb8xXJkBIjxgJ9jB7XNGgM4=
X-Google-Smtp-Source: AGHT+IHe8vylys+BGl97wuXx+LlFfd8Yc14Q1Wcxl2p2whHVSZapDVOqdUyvFcx4+DIPqWDl2Cpg3g==
X-Received: by 2002:a05:6000:18ac:b0:385:ef39:6cd5 with SMTP id ffacd0b85a97d-38a872f6ed5mr3308004f8f.1.1736357430257;
        Wed, 08 Jan 2025 09:30:30 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:29 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v2 0/9] iio: ad3552r-hs: add support for ad3541/42r
Date: Wed, 08 Jan 2025 18:29:14 +0100
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOq1fmcC/x3NQQqDQAxA0atI1g2MKQPTXqV0ETXagMxIIlYQ7
 +7g8m3+P8DFVBzezQEmm7qWXEGPBvof50lQh2qgQDG0IeFfF+xm5OEZIxnyrrgFVC24iq+aJ+z
 Z5uL4GlmIu5S4Jai5xWTU/V59vud5AUjP5dR6AAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

This patchset add support for ad3541/42r, 16MUPS, respectively
single and dual channel DACs, together with some minor fixes.

The ad354xr connect through a DSPI bus (while ad355xr through
QSPI), so a new fpga HDL supporting bus mode switch has been
developed to support them.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- reproposing the patchset using platform data for bus mode
  change functionality,
- improve commit messages,
- add separate patch for instruction mode,
- add separate patch for sharing model data structures,
- remove error on wrong id,
- fix id detection info message in case of wrong id.

---
Angelo Dureghello (9):
      iio: dac: ad3552r-common: fix ad3541/2r ranges
      iio: dac: ad3552r-hs: clear reset status flag
      iio: dac: adi-axi-dac: modify stream enable
      iio: dac: adi-axi-dac: add bus mode setup
      iio: dac: ad3552r-hs: fix message on wrong chip id
      iio: dac: ad3552r-hs: use instruction mode for configuration
      iio: dac: ad3552r: share model data structures
      iio: dac: ad3552r-hs: add ad3541/2r support
      iio: dac: ad3552r-hs: update function name (non functional)

 drivers/iio/dac/ad3552r-common.c |  49 ++++++-
 drivers/iio/dac/ad3552r-hs.c     | 303 ++++++++++++++++++++++++++++++---------
 drivers/iio/dac/ad3552r-hs.h     |   8 ++
 drivers/iio/dac/ad3552r.c        |  36 -----
 drivers/iio/dac/ad3552r.h        |  16 ++-
 drivers/iio/dac/adi-axi-dac.c    |  37 ++++-
 6 files changed, 339 insertions(+), 110 deletions(-)
---
base-commit: 5f8c6f117400b7b21ad248959ae2cb6e0d634e97
change-id: 20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-9fae2ab88a12

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


