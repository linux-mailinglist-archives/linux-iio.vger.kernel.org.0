Return-Path: <linux-iio+bounces-20261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA6BAD011A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 13:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026F016C035
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DDC2882A2;
	Fri,  6 Jun 2025 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GKuliRjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192419D880
	for <linux-iio@vger.kernel.org>; Fri,  6 Jun 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749208680; cv=none; b=JcoNgxf7w73SiNa3dUYPZymdi1/V/NBEtNs4NtENeEdxPUJYIIi9yaMUmW8aj5LGZxhm+mtmLaEeZLLkArGj1ZZ8cmein184Dn5QavdGtw/5M67g6z+3A6E1lHpJHz/SbEWVoJPxHUC+ti0bQX04/nCH+sCEAXXxLVliRdnR0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749208680; c=relaxed/simple;
	bh=xqceFklevNKHrB4ZeBPwo3lRayjsO/IEtbJhI2UtAgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/1CUO/WxYDJqHd0856h3W0vfmbEmq+Lr6UsPuTPMHJmbRSLt98zCMnq+ZxGC3W11RX7q6RuTt6ZD6W4uPVHfiUTCqFs99EEhcp9DP6XAKg4dj/DAj6f0ufn52XBaSdR5Mttw3GkS7bBilTqn+QMlTc5HPeIx2IML9wbi9+bBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GKuliRjh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-addcea380eeso300688866b.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749208677; x=1749813477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Do+QkiJD6NZpQLNVX8MWxR+5B4FmjG9ealql6MxkGsQ=;
        b=GKuliRjh/3XQYYGRR4O1FIoUa7x4jjtwAglDorwOy/82DyRUFU+vIAL+r/bcUtL7Fn
         o3xuR1836fE3oss3v/3J1qAJZon4UHZCazi0vfZtRo2C5iYX55uDuV0+2zOX8Y41rKlQ
         iU7C9VKz1HxQJo3Evfec/iRDbs7RUOkjBr5e9U4+dSgvL2awhD5MIFDcXwIByUshzBVb
         NrozqBNUi7igNkxzizL3+wOW+uQWlasOeDNG1O6LyaKUUXZoX2DK8+qCMn7CYPFYP6Jt
         +2U1rIW7Srsjd2HxJmLwzuy+Uzf3//hne1ChpqDtlgXfUryqDp+lFO8Vf756/eM3xKCE
         ffzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749208677; x=1749813477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Do+QkiJD6NZpQLNVX8MWxR+5B4FmjG9ealql6MxkGsQ=;
        b=r7gUI3tgmhQ+Bi7Tt47h97SMgXmI3Ofr5QMLbhqsstVFzqNJwzpZmC0BdnUlZqDGqr
         kBn/rlmqVPcUaqbtliozvIT/p0mx5WojOoKd5O2DF5iGShxKbmR4+UKsgc6tchjpC5Es
         3akOI4G1z8SrSGtFQyFTpMpeP7vcVBU2+63z+Hyqt7BGe42vG5taVu4X3pkBlOfhTlLE
         5VEOYzVWyGCqRdMiZTb+4EQ//te20SWS46S3RyytVtPEZbDI9css/grjDcQmZze4/tnW
         /WQOF/0xNhSrk+FA73NYYP9GXA0xd/RO4NqgC3wp1OiFGpnKBYMcUAe+wbKmuZmGx4W0
         JrZw==
X-Forwarded-Encrypted: i=1; AJvYcCUka0KdnAAkiHrtu9UrtkxTS+uJPnhE2a35LRJH+HwZU+uRmTsMST2omMQSTQhZTJNe97YIqK9d0c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHa7nayqwqfAcCDDrPHAzecBWuBODZLz8dt64PMub2fjhh8Q+V
	GBxFAn1rnWFonrjcoPeCMs+7mK02VcdD3Ed2l1l9spJOsKpHnvzSkQzvqO7dtVIWXxw=
X-Gm-Gg: ASbGncsrm8Lc/i9+alGU/APGakdM4ab5T7OGV9KyQ30Jv3YyYOIYo8+3dbVrFTsbFeJ
	kwkaDcZbkDjz2u/NwcIr058DPY3FNijU4QlhLIfDvLR/MOJWKAbGnk/rUCvVE3AmjXoqImRubd/
	IxRsNW04Ju6VGEwmW0GjcIvRV2cBtf7mNb6GOZ+pkO2K/jZ0vGMF2aszBhSB//6Snra02yexw99
	dGwRdF2LCMrUp91Ozjz7BO+KlRDbDMdNSn0egvphn7OY+kQ9ytd/xmNpxd83V9J4tKyJ0FtyTUR
	OGQw7KGh4x1ufervm8eUl8oZ1HZjXHcjmx1LUa+GsybUlWsXL96PPI2bktnKzPQUqXYxJ6wqELv
	X7JqSHkmNgL+8P1em
X-Google-Smtp-Source: AGHT+IHWDvzZ+cK5XGmhp46aq4fLVkiHMu9QfV5rZevpbF7hqhSG/HrvSR909QCTjWOMJuFnjrtBHw==
X-Received: by 2002:a17:906:c14f:b0:ad5:55db:e40d with SMTP id a640c23a62f3a-ade1a978c16mr236485566b.34.1749208677061;
        Fri, 06 Jun 2025 04:17:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7b566sm98704566b.164.2025.06.06.04.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:17:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	ulf.hansson@linaro.org,
	jic23@kernel.org,
	daniel.lezcano@linaro.org,
	dmitry.torokhov@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/2] PM: domains: add devm_pm_domain_attach()
Date: Fri,  6 Jun 2025 14:17:47 +0300
Message-ID: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

As a result of discussion at [1], series adds the devm_pm_domain_attach()
and uses it in platform bus probe.

Please provide your feedback.

Thank you,
Claudiu

[1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.renesas.com

Changes in v3:
- dropped the detach_power_off argument of devm_pm_domain_attach()
- use a single cleanup function
- fixed build warning

Changes in v2:
- add devm_pm_domain_attach()
- drop the devres grup open/close approach and use the newly added
  devm_pm_domain_attach()

Claudiu Beznea (2):
  PM: domains: Add devres variant for dev_pm_domain_attach()
  driver core: platform: Use devm_pm_domain_attach()

 drivers/base/platform.c     |  8 ++----
 drivers/base/power/common.c | 50 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  6 +++++
 3 files changed, 58 insertions(+), 6 deletions(-)

-- 
2.43.0


