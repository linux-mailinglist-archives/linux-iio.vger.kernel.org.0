Return-Path: <linux-iio+bounces-22510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EF6B1F9F0
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722C83BA640
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457124886C;
	Sun, 10 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M20Az2Rn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718175680
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754829217; cv=none; b=adAaEdW8/mdTwP9uO+uB1W8aYCtl8BLkXX6aBaL82NeuxR1wOcVL65fyWTxWRaJb5CN1RRzz6e4+g62FdMFKLw4f/KJd3S30hFMWH15Ja1g9s7dKj1JCWXCsKme9N8pP/YWmlTZVXT3k4gzsOvaJ+fvosHfu/2G6AfsaCCR6SD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754829217; c=relaxed/simple;
	bh=3nf59Q9AGWpmOg4VMUuCwsRS1MPEIrcUFh0ePKk2Wb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOtG463Bc+mXVbgjzvfMYMum8pEMC26FsRKm1PcpYc3WEOcGap5RGePiSFP+5m55ozbGg0PLZ9lwwz3ytSFGPJ+LKp9VcfWPh3dLL4WRt9wLMPCiuEN8pTL7iwX0xkDBGqIReWacLfiaiwjIS/PHp65gZImvcud21lhsK2zkYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M20Az2Rn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af90fd52147so529920866b.3
        for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754829213; x=1755434013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/vk1HAe6XwhvBH/Z6ZCTNjAcCh+NxJHs2NAijcEcZs=;
        b=M20Az2RnVwhQS+Anv8XdgRkgg/mPpUkrezFO6MotAUluwduq1InIqUiBq59IKSdFk9
         DoQHEexmg03qSGnHA21XpYIJ9bCizx7bXIZphMaqZtDyRrZ42YxXUYQZqYZBvywpT9c2
         3gy+efh871G3HLy/WNZlwXqCtbbgwzDuqVrXANBiq3EX0+rGVoN1tSDwzH7RkR7iI49G
         qyX276O+1ot2JPMy1n3RF21k0hWz1b9oAKquYInWFc0ahLFzS9EuE8WvYf2TtRZqNnyM
         5LYd61r60BgJ2vH0Cb+VUYSA6c+pER/zXyoTQMGecnVDJNEscjGwHTzC8eKVN7ia/vgQ
         hrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754829213; x=1755434013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/vk1HAe6XwhvBH/Z6ZCTNjAcCh+NxJHs2NAijcEcZs=;
        b=v3Wa4unDfT5V4WQpdyHjNKdiRH2tEkPlrpHx71uOjTtrUr0lO9aTocSpWp6sSnoNTB
         dEzSf//s1WUSnquOLnpNQ1c2SsH/sJLvLQFP0VX4Y8wF82I48NVW3a0S9mlPMnnkrFc0
         9+jZQunQ7O0Szed8GerRFWOHlQTy2TVLDcCJ+wro8A3gHxyHlB0tOnYXCLYOfnBWZDYi
         PmWBsqWzKmii5oszepSwUs51gjvMxtNk6DCOd83nSuMydnLjz4pvdeDVkK1gDtnON9Na
         byw3Px0tlOzK2mbJqJssCnlsiyVWns5gglx72HcwhsdBtBUkTdndBImodVsRfW7k6O2G
         Kg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsxP20ylIO8dn4XrZipr07LkhWvvYfZxQvEJC0FGRU21ds7AM8VbPJa/fYgpfDIUrITTfkcy7gYYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8uEujq0aXcUD1VZh309yp8Jopyiw+jEBbZjbtWY7Zdq9f3bb
	IgtgzP3unhmCduJFbcKfybyvGSd4YDJaQvFNbvAM6hG5d93ufPwVz8dGTGfdwj3QzU0=
X-Gm-Gg: ASbGncvw7BHfH+H+htGQT773fyDNNVY78HcysBMCezW4mg6RK624lQ2iv8uI4V2TR1y
	knVAwqSppHz0AdOYNyRPkEqKtSdNW7kYbkcIS/v/hjjbJ4QY7AGSVIeR80EWxVSATx7rztWRxga
	G3esp/RoAmm4oZN8MMr1nXv1wtxuPh/IIRbdOoXBE3ZGP91FBwv89S1YekjqRA2XZe+Dtn6UM3l
	4LsIKBNchWvwGQ3zeBHVeKmWXhtOKaPi7E1qMvd9ENAiGOjwB4AhW/FE/WazoPvSFtpp350euTn
	aYXc541EiyuMkYSQawlAMgxogjIIH6dQ27JOmW34YySMmQmQT8TiWqKNw1WI/B/Z6/6ymRzFbkN
	mzHxX/kreh8GCr7eXVifUyfqBuM09K5pPqStoD+BIFWPRjmBerk8G
X-Google-Smtp-Source: AGHT+IFu5S+xpfZ42LBfBM2LxULYyH7yrjzISc4HpHnHIpHtS77Eg10O7wraMX8ZzVEZ8pKVCi0TWg==
X-Received: by 2002:a17:907:971b:b0:af9:3116:e0ff with SMTP id a640c23a62f3a-af9c653f538mr968527366b.52.1754829212827;
        Sun, 10 Aug 2025 05:33:32 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a2437desm1852203366b.127.2025.08.10.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:33:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Sun, 10 Aug 2025 15:33:26 +0300
Message-ID: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
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
- dropped patch "iio: adc: rzg2l_adc: Open a devres group" as it is
  now fixed by [1]
- added patch "iio: adc: rzg2l_adc: Set driver data before enabling runtime PM"

[1] https://lore.kernel.org/all/20250703112708.1621607-1-claudiu.beznea.uj@bp.renesas.com/

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
  iio: adc: rzg2l: Cleanup suspend/resume path
  iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

 drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

-- 
2.43.0


