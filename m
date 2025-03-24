Return-Path: <linux-iio+bounces-17244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77985A6DA11
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324DB1894319
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9149425E838;
	Mon, 24 Mar 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TPUqGKdj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972625D908
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819204; cv=none; b=NXIGvZBuoD06yipheyzi6XfdOtsbvfYNZM/hflsXgadIDBiLNcsQ19MZwgMOzyltLCR4ezfDHiUOti6mTvj4gB1NUgNPWkylo62xwdH1s6O/ldiGB+rKNYuLhxd7Ps2EYUWj7/UoBPTkuKQ53QNJDiQDrdJ2LTluAURrszmHO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819204; c=relaxed/simple;
	bh=hzKJikXi8Sdam4B/PqIlud3Ck4EKL/r9ynDMwDVjci8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REcJHN44fJh9gsgcc2HMiRSgnznzJ8YLBPJ41qb/ZgBR8tK2ZrUI4RqebJuLYiSFGrEnY7Gkkr3Tfipgf+9RPkHS6SZiV8qZC4mgfaK5p3JORUfxEAcBhRPytqzyl/7sUEBGbrxu65/sr5YDO+OA+N2+JclDoE3s052gqsIgnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TPUqGKdj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-391342fc148so2922558f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742819200; x=1743424000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Phk711bqqwQtp/5ohR16dSgoW1rYqnvCMt8zHzDni7g=;
        b=TPUqGKdjygNWlcpTeLDimpy36254zyMMHrxh46im4G4Hmffkmwu1jtBrbfq7ktCC3C
         2CpL2RLHBN+kNk9Xyyk7y/020NqVIIvk4ZrC+6UeMF/9H9fJntFsrg9+kRPd2+8MLB3u
         Sq7nRCqLp1dlAzd2PkcdX0ID3p9QyKncuciI5lLqP0QH+GSvo7BXoZZ4em0dkmgbULvz
         Sg11lcZzqyJZ58CE327X9vibX+God7my9kMr6tWRPvgMngDWaIm2lZlhoW9LQcPOjVnJ
         qkrY6kNaL3ufKGDvqSx6md4W5CWuI9ClcqNLe7jcXSW1niOvufI8AKBWXVLteZrANrhg
         lMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819200; x=1743424000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Phk711bqqwQtp/5ohR16dSgoW1rYqnvCMt8zHzDni7g=;
        b=XOA38mhb9jSvoNBoq3SFwR8ZLC8k/2liBJdn5+R9XWfhmyJCKdkyO97urPzbryycXO
         RLkcuGSeABGrHqs6uG7NmoKEwTHvIY8BKEd8b1GegucTGDgkhsH7+0BfgFzhykAi5ZZi
         mpHUGra0ivHXRBVPjFP/1WKOJjS3P8RDrKSS+GFdgQnHPfcOLZIwf90A/NriIeEEkWO6
         cYDypSWoJUl9WYVGulaZdDsfPQ02k4f4KgM2uREfsxsI7Kdy6U63iH+fwBE2nNwS5sQW
         o5tS9yGSulLBu5/LZ9vlkIb+QWnikb6aiea8AvelYjuomU9mz/GE2/i3gyFgCPp1XezI
         jJbw==
X-Forwarded-Encrypted: i=1; AJvYcCX+WGkd8uNeSjPlsWqo3ZsF9G5lTzwoZt5pHcOInN4LYDjVQfJWDeXLRD/WbYsXKaYoPwEheS91w1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzipWjuUi0qVvde4syN2ugAdrJpoj9eQB54Geko02bbE32UUMlc
	NJQKWXD9BuZxffEKhZzhmqDjZ+dDq6nhJJ/RiOSknh/+jDpEkxL74b9Otkihcq8=
X-Gm-Gg: ASbGncsGJqrjSbBkXg/FiKTrafaWQJxsSwRg+LIQwLbSeEPjUgEjCSRw1ouKY3syL/a
	hgrefC79kAs0f9YK2lX1ekI0918z14Dsz8jRV5pyF8H/akfB/2+b1V7ZpoBotOdfY7YqqxeBBqK
	Ke8BsxLyi0Opwmyojkcn/3Hc+OY63xafVQrG8y3ti+4LH+fyx7KVDvf8KCUpV+rUDN9mFg9ZykR
	Ahzz9iI/VYDLkJ+vinUOJKrS59VKzbIgk0va0WqlRTAqRDSslzvwIaXzrkqCtofpQJQny3bNvGI
	RQ4F1FJjwMCNJFb+gMNhdY8bch9sjn2YCwNrE1lqMrLdZbj1cEULtKGWD1fRv7/hpk4RZDCIeA=
	=
X-Google-Smtp-Source: AGHT+IFyAHj/IByQ5z9fmeWSfg359IdFmkN1k1RzZoQFKjZ1j9affxNGuCzLwR/XkeM9MsmBLjG4aA==
X-Received: by 2002:a5d:5f46:0:b0:399:7918:541a with SMTP id ffacd0b85a97d-3997f8f5c13mr11994851f8f.10.1742819199656;
        Mon, 24 Mar 2025 05:26:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm10729080f8f.86.2025.03.24.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:26:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Mon, 24 Mar 2025 14:26:25 +0200
Message-ID: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
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

Series adds some cleanups for the RZ/G2L ADC driver after the support
for the RZ/G3S SoC.

Thank you,
Claudiu Beznea

Changes in v4:
- open the devres group in its own function and rename the
  rzg2l_adc_probe() to rzg2l_adc_probe_helper() to have simpler code
- collected tags

Changes in v3:
- in patch 2/2 use a devres group for all the devm resources
  acquired in the driver's probe

Changes in v2:
- updated cover letter
- collected tags
- updated patch 1/2 to drop devres APIs from the point the
  runtime PM is enabled

Claudiu Beznea (2):
  iio: adc: rzg2l_adc: Open a devres group
  iio: adc: rzg2l: Cleanup suspend/resume path

 drivers/iio/adc/rzg2l_adc.c | 67 +++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 22 deletions(-)

-- 
2.43.0


