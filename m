Return-Path: <linux-iio+bounces-13168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0A9E7752
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89CC288563
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5132206BD;
	Fri,  6 Dec 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IXUJKBP3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86472206AB
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506156; cv=none; b=p4kW35QSdEaX2K2NOZ2/YJuRgWoz60Dig8U8mpW4PsDc4vfdzNoMm7fy31Fumj1JEtf3WYFV5ZMhcQp/usHLDVaeKnfBoCmmyLghCGO7ap4j69YKLbBjmZG+S6LQ6b+/DRK3S31/Cj3Xbn21+LofkOm+sJ9AOwagCOSaP/cJNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506156; c=relaxed/simple;
	bh=2xbDE1PbDdVgWJYB6ReEXxuxr3jQ0b0TaEMBrVs+jdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mo2JhqSX1kEvg6mzERWa56RErY+zD+u6cBVC+NBbE3Bm0uHOMyYG9gVJtKedDxGN6J6UnQBElyOJuUrYs8TzbNv4jcZKEOuqOybrA/F8lrGLRpfVadrJXEunDoHCYUBD3qqd4cGHY/agZTTNMJxbw3neNBKLCthVTLBq8OoqxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IXUJKBP3; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso22669065e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506151; x=1734110951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TiYyc9m6NtTx9PeXyVPAO3OLDZJxiiq5MwtoXBGn3hE=;
        b=IXUJKBP35EQaWn2v0DyeRLImRRsa7SDRcBynSOOTJSKVBjBSOFUKfgTYLjd5/DmAGI
         b0CXyDTVQ8lB3RsKPwvT5fXPkRvFcz7MyPoQd2f9zRrd11BQ4bObY+OTFQsZXULrO9oI
         S+QXpPiMk9gisqMr/CjPsD6FdWFqGjaaOP6hdsAIcihy69Ig/V0OJ17hk+L3Lk5IME+9
         JbailCZqCu9wXzoF41L7U5WFdJbikIm0cTAGqDWfbGmnS5werE6sW1/biwQdc9TEd2Ce
         jXsd+yD0UhoUceMyKw/tqpqGCVu0Nu0ODEVxhI4Fg+WNOamgjleKhni/DCa2JLevkLno
         9NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506151; x=1734110951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiYyc9m6NtTx9PeXyVPAO3OLDZJxiiq5MwtoXBGn3hE=;
        b=Gb+zlfJbuMEtkuU0GMpE6qI+G1phZqjg8nJJqLnjjtdXQ+AqrEGX6w5aCYPmqXHmOY
         pUGIop7Etnht4YcG0PRo6yHoAALqjrOKNPPp9PWA2GwNgr6aYNK5u9BqdrAGFNDe7LFA
         6YJeH5VObBRq3L0U+Zpf01SsB5VP3lZnXhXYpq5g6kxbvmRbjh25b7wcWWxR1kENFTBg
         SiMWecrj3xY15gNNd876BZVvEGdnfCFUaWayHbXgcrx4BrZkVycUNtDrHIq5PLmQFD7H
         bLTJFnT1SzrEPDi+AuFwBDP/ZAA9+2+cVjNQBhWjvv5IDdhaZFrddwDkx6yn50WVpIU0
         P+2A==
X-Forwarded-Encrypted: i=1; AJvYcCU/JdzgmiU3tXmnR0IabcjMsXCdz5gkneBUWZStorvgRBcVoDSVJAL6xBOdeN7IxOS1EQI7nURYCHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBEz1YCGTfZ0RzTZut936qVLRmIEbjMEM41xcbO8uOR3DI4Fo
	s90UoTGaTzZcez8dezDiHKYwqigcmzbc2jajrnfNUv/tFO6jEaRlbo3Z4hpExjA=
X-Gm-Gg: ASbGncuehJyTa43Eo67LRkjzA24THU1i/G6lW3upCAimE/gmdWSWbKFNRhnN6Lt5M2j
	FNT10xRJsUvWyT9dZOOwiqByUXsji4ZDHcKcnvJ8khLvFWyWssMEKRl1jcJVBXJLjTeX5G7eNoo
	MtBkpZ9HZDkbwPamRqsra1S2K4cVkrHiV7MKywizuFHuOQSzvH6ftyWeDbFguapfY3CDDDLapni
	cD7SEVeNaAiP1ITvmWOzhtyT2Aopkcd0sQu+9LYT+ICEhEptyww0AbOvF+mHkTFzL6hmQjaHQC4
	S0qh
X-Google-Smtp-Source: AGHT+IFPeopXVABL+gcCED+FdJRnGz6U9BSOO3c7pS2bzzaZitwZKrwJf1InH15LwnEl0AM/V8SgqQ==
X-Received: by 2002:a05:600c:3ca1:b0:431:5632:448b with SMTP id 5b1f17b1804b1-434dded66f6mr32193915e9.25.1733506151118;
        Fri, 06 Dec 2024 09:29:11 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da1197d0sm61694895e9.39.2024.12.06.09.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:10 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 00/10] iio: adc: ad7124: Various fixes
Date: Fri,  6 Dec 2024 18:28:32 +0100
Message-ID: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=2xbDE1PbDdVgWJYB6ReEXxuxr3jQ0b0TaEMBrVs+jdo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnUzRBgXEtImKK8QBAbf8kD1oSBPWciJcjo9JkF C6O1+eYsKWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ1M0QQAKCRCPgPtYfRL+ TnSUB/46lMr7a4iN4eZ4ShKWdDKbmntVCrcClruFqITiNwrRL96gpHux9iK9EbLEUYoNQXOGkGW IA+ZKtYouXUJZdT6xwooLurtKFBijvyAcmANX7VdHbofCKWF89YBEeHCqw8fa+yRNgJCcjOyHF1 8/DwdcDw0wIH6VpBnmsGBuyzOTnpsE8tf6rE8/9jsxvUWRLm6PxET3xgl5rxHyHfuWO9Hsa+IWH aAJC/ehujgcQwArP63Xh+4khoXjNwhIJk9UORuqmZ2qNamawSqZ9lhuDLVctZbt7fcCI+C0cc/0 tAGVlARWhAmdNI+nGBubO3XrITE8zBptNDnMMp33at9MWE9+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here comes v6 of this series. Compared to v5
(https://lore.kernel.org/linux-iio/20241203110019.1520071-12-u.kleine-koenig@baylibre.com)
the following things changed:

 - Rebased to v6.13-rc1 + 64612ec9b909. (No changes needed here.)

 - Add Ack from Conor to patch #3

 - Fixed how R̅D̅Y̅ is written. This was wrong before because the overline
   char must be added after the character that should get the overline,
   not before. I got that wrong because of
   https://bugs.debian.org/1089108. I would expect that now this is
   properly shown in most browsers, MUAs and editors.

   I guess Andy still doesn't agree to write it that way. Jonathan,
   would you decide here please? If you agree with Andy I suggest to
   replace it by #RDY. Andy suggested #RDY_N which I think is too far
   away from the original name. If you (also) like R̅D̅Y̅, just keep it as
   is.

 - Fix error handling in patch #8
   I just pasted "return ret" to all callers of
   ad_sigma_delta_clear_pending_event() before. Now the error handling
   matches the actual needs of the context.

 - s/irq controller's capabilities/irq controller capabilities/
   as suggested by Andy for patch #8

Best regards
Uwe

Uwe Kleine-König (10):
  iio: adc: ad7124: Don't create more channels than the driver can handle
  iio: adc: ad7124: Refuse invalid input specifiers
  dt-bindings: iio: adc: adi,ad7{124,173,192,780}: Allow specifications of a gpio for irq line
  iio: adc: ad_sigma_delta: Add support for reading irq status using a GPIO
  iio: adc: ad_sigma_delta: Handle CS assertion as intended in ad_sd_read_reg_raw()
  iio: adc: ad_sigma_delta: Fix a race condition
  iio: adc: ad_sigma_delta: Store information about reset sequence length
  iio: adc: ad_sigma_delta: Check for previous ready signals
  iio: adc: ad7124: Add error reporting during probe
  iio: adc: ad7124: Implement temperature measurement

 .../bindings/iio/adc/adi,ad7124.yaml          |  13 ++
 .../bindings/iio/adc/adi,ad7173.yaml          |  12 +
 .../bindings/iio/adc/adi,ad7192.yaml          |  15 ++
 .../bindings/iio/adc/adi,ad7780.yaml          |  11 +
 drivers/iio/adc/ad7124.c                      | 217 +++++++++++++-----
 drivers/iio/adc/ad7173.c                      |   1 +
 drivers/iio/adc/ad7192.c                      |   4 +-
 drivers/iio/adc/ad7791.c                      |   1 +
 drivers/iio/adc/ad7793.c                      |   3 +-
 drivers/iio/adc/ad_sigma_delta.c              | 194 +++++++++++++---
 include/linux/iio/adc/ad_sigma_delta.h        |   8 +-
 11 files changed, 390 insertions(+), 89 deletions(-)

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
prerequisite-patch-id: 617af17fc377a984762c61893b9f2a92ae62213a
-- 
2.45.2


