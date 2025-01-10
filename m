Return-Path: <linux-iio+bounces-14087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06BA08DDF
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B8E168531
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E620B205;
	Fri, 10 Jan 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OaJTyceF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10620A5F5
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504751; cv=none; b=t0bVOau1HkQUoe9UeWso5lmuIiptctNG/KFi66zW9wt9eg/7nUTbOAK5h2wlrEO8vpR+3lFj0ETvzEdnG+k6RPt3FWDXF4D7w2u9QwxDnWAo5z+U4imwZc7XTbC7P1zl8p1dKcLnXv4tUzELMgk1X7cNZjho9Hsxvmj/GU6jjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504751; c=relaxed/simple;
	bh=sVfWZSQy0F56Mfsuut0OZR9bDyTRjsLVFDSPSIa+ARQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jqTMCcPpdV+nQvgwjQFWDZp00ArcqB6LUIiWUHWv+Cy3Gh5eCDUWVz83q+p7V+pjezqmPAzApN5mVq2CsHvDjC3T9AjJK9zFbQz0eJBUX9G6nzI1hyFt7koUJVVwHCdaFggSkmX6g0IB71ZcLpB0uu5VepG7bQjQ0GR/CPJKTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OaJTyceF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862d161947so1007714f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504747; x=1737109547; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UECsGP3Mv75ke3tvqynHvh+LOPh6IFE2LejgP0lD1Ao=;
        b=OaJTyceFFVyA8hmdmx0j444TWg4KBRMmeO5UZZjbvZ+DNe7SIgz4zE2Wd5SRYg/vv7
         xZmBtgaLM76ZAQ0H+3JqbqfOqS41RINAYQDqAvoGFmytO2zokBM+EcuuH94dIvtZawkU
         pn8QY2NhIImjvpKOs18PNZuPuuw3MeOP2Gs8e1iA+ivx0402Sw9Em9/O1jBHoYVAudOI
         8y4be0m681gbSV4gdUSaE2mGhC5LVKDb8hjM2L6K4SGD8WAlzezAcN0IQ/d5y56rqP49
         9uAEX9SSZnVx3qB+Rj4k+9ffZDAPL19ddG3wjmmRwD0IZ4SYPNX2oqaFayO0wym3hOC+
         06kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504747; x=1737109547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UECsGP3Mv75ke3tvqynHvh+LOPh6IFE2LejgP0lD1Ao=;
        b=Ds4b6zCy8Cw9/qQ+kZ2z6F/uKeB5jX9JUYmVH5vmYo3mG+uYg10wf2/oGJqKlNLRUF
         fnfFeBIsjBQXlfZNjjf/mjPzhDPzl/SAmek51lOYVqJbQiE0V1yc5VHAjOBYZEnxXbBW
         HZHR2yZJvC3haqjlOlOv8axBsV+SqVBlAsHPD6HIJ9SZTZFOCTri2PfnCjGV4nB2KH+3
         voskc3hz2IiDmJIiZHPNtuTiR+IWa/cl6s3f0Vca7DDUKvoU+neZB2ZFJCSRnfZT0rdI
         hJ7HSKDM2NM/2XdyY3wEMxhtqNMPT2Ts4u6ADweXnwksBEpBD7rzJskfCOH/1bwlH16F
         jU5g==
X-Forwarded-Encrypted: i=1; AJvYcCV0pICCF8y7JUT4rCZ4SPh6iK23LU0+dsmMuvnSW/14u38UOaUtDQ02tyDctOa5P5mYqFoxTcjiD6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3JjfuMHU4tuKtf72jcBOmfNQCNbWneHSsgByCf/WukYqYLdF
	afkkUrgGKDAobTGHsyUbE6Y2+ba0bDcCcUhgcR7WiVikbCICI1cJkk7tiQxe6PV/9CoH1l1f91I
	W
X-Gm-Gg: ASbGncvDqj8R/Oe4/NfzptLldoO+pdJMnYXS0KmreRcy0+5+WTaUNC0+1eOirKsYsnt
	NzsOyyk7acaOw5wqfdvr8niXRhaHrzXw+NDkAvqkNcqZCzB0y6/gjBHzj1uBvKLh7WDBor5CWtV
	Xab+SoNumvTo+PwhSbBNoDd4M+kaAh/jjK7Y5l765OFWlPbXUOb/VMvncByObVx68/tPVYn4x69
	hk4kU+TUgFmzl2NORtdk7jE9WHD1YoB736DlTJeL2AGP4gTzSOvl73lEbo=
X-Google-Smtp-Source: AGHT+IHfyfGSS5ST9eTPg+dmxJWK7peeAx6l8OwSQ0RxJh/CCLNyidtWzXuf/62KwynAIXntPd6pZQ==
X-Received: by 2002:a05:6000:156c:b0:382:5aae:87c7 with SMTP id ffacd0b85a97d-38a87312d17mr10106942f8f.31.1736504746746;
        Fri, 10 Jan 2025 02:25:46 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:46 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v3 0/9] iio: ad3552r-hs: add support for ad3541/42r Angelo
 Dureghello
Date: Fri, 10 Jan 2025 11:24:12 +0100
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEz1gGcC/x3NwQqDMAyA4VeRnBeord3YXmXsENvMBaSVRJwgv
 vvKjt/l/w8wVmGDR3eA8iYmtTSESwfpQ2VilNwM3vno+t7hVxYcZ6QcYvSKtAtuDkUqrmyrlAk
 T6VwN83gNabgNie4MLbcov2X/r56v8/wBIQrVYnoAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
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

Changes in v3:
- improve commit messages,
- removed some not useful dev_err, 
- comment syntax fixes,
- add lock guards for bus mode change,
- remove externs for range tables.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

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

 drivers/iio/dac/ad3552r-common.c |  55 +++++++-
 drivers/iio/dac/ad3552r-hs.c     | 296 ++++++++++++++++++++++++++++++---------
 drivers/iio/dac/ad3552r-hs.h     |   8 ++
 drivers/iio/dac/ad3552r.c        |  36 -----
 drivers/iio/dac/ad3552r.h        |  17 ++-
 drivers/iio/dac/adi-axi-dac.c    |  30 +++-
 6 files changed, 326 insertions(+), 116 deletions(-)
---
base-commit: 74022f59b0a17567c0d7bad8f197977d24d06525
change-id: 20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-db63c474ca9e

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


