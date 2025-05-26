Return-Path: <linux-iio+bounces-19941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C714AAC3F3B
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 14:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF28176015
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9CA1FFC59;
	Mon, 26 May 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e4kzRv9X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E436124
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748262081; cv=none; b=hIFoYD3CK/0C0NVSdePW6iZude1z78vIPFAvEL6AzaVDWQL8BHiD6M9hEtdHFxW5hiXpcq4cgEaGaso6QhxZmFlsMG0BZ1C1ivMUFJSkXyL7DsyKmmnA1keMxU+9+0tiO8q6/0IdNW+Xns54ZjRhiBtzVb+YpkcvLFSaih9ny1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748262081; c=relaxed/simple;
	bh=OSjenUtGeUxY2QKIW0qhPspnf7oHuTj3PCtjTBlzbp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=be9JJbsZsMKnBgvcOtvJACmfD+ovSKgE3kVlkN66Kt5UYG+mBw3a8cl+wN6JR25U5g7U0QBfWWoF38/4LTCyoJI/iO1kX7zvgsPU7wxYmdYJptNotNRYgcCFy5BJiSTwgUOZqbjYeY0J1nvzLsyRnYn6ohrLxA8+Eu1d71nxijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e4kzRv9X; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-604bf67b515so1109999a12.0
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748262077; x=1748866877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=768zz3A5MyltBkQLlSbOf4oJniHEYxMfBQNxunlsy5M=;
        b=e4kzRv9X7YDuVP+psgZDvgW2JfxVPKQjZGqnHmZ9nazMd8PSdws/UwD7htHySuvzd9
         lDDDuEjaJD2+QeOhzmL+T0NmYGm1rPgIdsrqy/0VHiTGK8N7+F5UbKeRT/yulQjQq2f7
         g+1FZXOwttW2qWUoPZKlVmme8oF2sVrT93wJcmwJqdjuzS0LwiCW1T2EkGSDVjt1Ndfh
         RoLazqb5d+nnzkkhmKlotpWHeHFZLuWpvYk/w2+jumB/xaIYPq3WDTsZcxLNDZVeNEnD
         QXIpoptNMDiRNrXpQGhO3pqRJUmhZ9EWGqcVv/JIgDSBFdXLJ5SCbZOzPNMkBs/Kg11F
         iFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748262077; x=1748866877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=768zz3A5MyltBkQLlSbOf4oJniHEYxMfBQNxunlsy5M=;
        b=K4VZqEMcuJ/BRygD3+8li6eAU/DMsV0duXx5YYTq6PO5xUNFncDdGo/Azhw/jFvXW0
         LTt85oBraM7R8jGuttrtfZ0dsBT+jmoqDw6Ma+2cVVJu3FQeubOAJEPvPKCCfjTpBfrr
         azAboiuT7iXCzp94pUao8OlssfS47dOByOHZ3coj9QHuUEePtfTrM4dUZ+bCfOY/HcAz
         nqpLgrm5Paxxzm67QHiiimgBYQferbJ7Bm7LRfcXaBobS3XSG8mc1eRP9Cn8RvSrCka0
         goMwJ/jD/apJ3lFuIaMUOVpG3/0y8rTxpqLwB9/0vXRmX6IpWh+F9rKmCVapPYvhpz0j
         5Icw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Jq5qKn1TUNCwsEEDq7hAAJUl3gT3d8DGUsjAFv+b3wwaKe0iXBHEwOP619iuu6YQQXHKZWd7hhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkovHRDy/I045Nc+dOjCoiaEwofEYe5X6IoS7HnzaQ75EbO8P
	AiLtg6j9w2+sF6mhzzX9DIZodEnlry2ImPVCIcsZCafatUCahphGCB+PB/9JMHtivCY=
X-Gm-Gg: ASbGnct7Yjbe65ixeA8lCI7+DWcj65ZIuufbXClhw4pf55CqAGo8dkCg2IagwJQidWf
	JcDPYYqHEBcHm3HgCTW4lczPbO914F+J4R7s4zKlKxghlxWb+oZ21wgFfdCkf1LSFBR1eF01lwq
	hw0xuaE+gfdFGHboCpb2TYxb0vnlT2Iq6Ct7WKhq8kK+pNNSOOmjCSXuK2Hjk5DK8frND291QWZ
	UnkZQP0rZvMCXCAuBY7UQmRVUn710h7wFRifqVh4vpC5I70detNBeRJATw1NLZxkwsdGySWr6BA
	KozBLSrG7D9/+/ELfI7TEYiqHkbRqlVr7oL3mOJ4BVZn+CrA43YlrUZi2Mn72E8jPoWHi2Bpw/H
	ay/p7
X-Google-Smtp-Source: AGHT+IF/1QayFTF9qsFXVEeDjJ2ecvcZuUY2FjpmdnnRWet2lfUsBrEqZWoEsIXUVBdEMDGEtRJkAg==
X-Received: by 2002:a17:907:8dcb:b0:ad5:1fe4:4d0d with SMTP id a640c23a62f3a-ad85b2065d0mr729565366b.61.1748262077456;
        Mon, 26 May 2025 05:21:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d071c36sm1687630066b.64.2025.05.26.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 05:21:17 -0700 (PDT)
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
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	bhelgaas@google.com,
	geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/2] PM: domains: add devm_pm_domain_attach()
Date: Mon, 26 May 2025 15:20:52 +0300
Message-ID: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v2:
- add devm_pm_domain_attach()
- drop the devres grup open/close approach and use the newly added
  devm_pm_domain_attach()

Claudiu Beznea (2):
  PM: domains: Add devres variant for dev_pm_domain_attach()
  driver core: platform: Use devm_pm_domain_attach()

 drivers/base/platform.c     |  8 ++---
 drivers/base/power/common.c | 59 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  8 +++++
 3 files changed, 69 insertions(+), 6 deletions(-)

-- 
2.43.0


