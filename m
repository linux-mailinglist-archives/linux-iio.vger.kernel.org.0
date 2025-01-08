Return-Path: <linux-iio+bounces-14015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0ACA05BFE
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 13:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B2D1888D2F
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 12:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65D1F9A80;
	Wed,  8 Jan 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="THSWOCdq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E01F8F14
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340587; cv=none; b=ulbYeF1AdXJTN1kNEHl2PIOYTqf8/of23gRzJRur7qJSsBO/rQTC2Mk0zNFVSJ+PJgD2dVRFGnSdhPO826v+ydYl5Mfa8GQb5PHVpnn5RlfFqcufWjOrz4ixnhg9Lwkwc0ya8X51V61TbIMw81LhnoIvludHVZAu0W+ZoSXBag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340587; c=relaxed/simple;
	bh=KmGydHgNNLZRZ14xArcryaDxetquTR6NLcfmO0s4HBk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I1tWb4kL3ynk6GIgY34IV9NZc64ai3F8q1R3CveGvykd0FEqt8c7sp6pSnQoa5kfMOl1Cndc2DAvOekLPEB1hgu054xcLz9JQu0S4ArsqIIskQHKJWVIMznqrq0ohWsCE1kavzgGj1a2t17HzPQhLQ1QcsgsklB7XYhhwn/gSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=THSWOCdq; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso8802482f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736340583; x=1736945383; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTPRHlVS1liPDPiJyJ4YA3l7fo0hLRRppQlZFlUkkhI=;
        b=THSWOCdqTN2GT162hlTYP4HGhcmUJrDQPK8bYWzWzB0a/pEwqye0tbZac6PMragmA2
         oCGiaIVJpZJ6XCVriCt+8YGoTk8n6suojogGkaK6VBplhRCMga3NUQA+ui+WsUx+F7Bj
         otskIZx93q2kdLGZsFACoSi3AUR9dbMapurV2lxv2cViKhj0DcURbbGJ4EYb3yXdQfqs
         KQmFu9NftRbLrIkfSjdLCdLvnoxYUYuxCmyGK5ueF+jr/GYXFSw0PoEP8vVe7WH+b/Qp
         a3PZU1s2WtwgZMd94cgOzyeOa/+OxRp98QkdWk6oa60Xkne77oevVAgBpJkqSXa1eyuR
         fZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340583; x=1736945383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTPRHlVS1liPDPiJyJ4YA3l7fo0hLRRppQlZFlUkkhI=;
        b=nQDPsXX1bCmPMaf87iXXO9Yo01/qQkCXU28rIC9eH/Q4+FQT9LzeonixL0OIEhobPV
         Zw23nDS62MGGMJ8NH6IcRQaxX0ezCVHPI0wXoP51AAvFCbn1TXanxl7w8QcTYVeH8kIY
         SZqN5lw2No4HRs3mA2Nbt8vIu2Ymr7OtOamGyhMuJ9LTBGBILMergawbTqMEzBPudg8l
         WkLgVD3wfoJ5872OHwtwFsrDTyl3AOh8AsnoJtf9W35Kq7bRhpcu5N4A8H7aHz33nP0P
         7pB9FtMdeI1keOGrzkZ/m1/ri9m4BAxSZtsIYr7Oe6pHZrxvyIC2R/b/a2E9Oe/9JWpc
         avLg==
X-Gm-Message-State: AOJu0YwCmRVPErs4UX3IE/PiINu6G9+qdlBQ2aEL/fWQOxYGqhrhVsWA
	mhDeAr2DJOdQcIke2J6Tmaq5LfIA0dL8zbkU1p56k6oUBL+pktsHhG32/VDsaeE=
X-Gm-Gg: ASbGncuKykNJdGrzoadgU9kw7WdRWJE1eDeIo/BjrO3p/wg4RLC5o4aHN/S8g9Ggabd
	kBnMV7dkUZODF033udtd27E5sL4m2fN4qr5201EDnxlzVC+hHkgJ1bCPcsHHUdLOIRf1XtD8MOe
	cAmosGbQWqDO3EdCR6xd9YoIQgjDxXj3FRP/z9uSYp3/sZkN5XO5paLX06E7SiiJtUqnSui/VvX
	grM1DPfDFNcS0jOBOmlATpiK21lbJjAhQgOWiZILLM5kfFBxRd0uzdcI80vElYriucXX36zNaBw
	qQfzMoVG7vsKNSDTTSkBajGdt3iGJr1kJ7IaCFAZl6auSIgNrlVgrA==
X-Google-Smtp-Source: AGHT+IH2/6ZUjBDO77lZA0i6ON5WHfOGrSu5OgNDrSVHzUtHNMDrY0bgyO6kLF9SSUphC3YN0b80/Q==
X-Received: by 2002:a05:6000:4a0c:b0:386:33e8:20f4 with SMTP id ffacd0b85a97d-38a8731b9c1mr1951004f8f.59.1736340582772;
        Wed, 08 Jan 2025 04:49:42 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da63eesm19846805e9.3.2025.01.08.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:49:42 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v4 0/5] iio: adc: ad7380: add alert support
Date: Wed, 08 Jan 2025 13:49:32 +0100
Message-Id: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFx0fmcC/43N3YrCMBAF4FeRXG9k8tMm9cr3EC+SzFQDrq1JW
 xTpuxsVEZZFvDqcgfnOlWVKkTJbLa4s0RRz7I6l6J8FC3t33BGPWDqTILUA2XCHRlkogdwdKA0
 8j33fldQIiHUgZwOy8t4nauP5QW+2z57oNJaF4X3cxzx06fKYn8T9+sXSJLjgCKpqNAhvrF17d
 zlEn2gZul92dyf5tqTUHyzJgZtgGy99a4JX/1jqZVUgwHywVLF8IAGuxbqq/R9rnucbcfLqinA
 BAAA=
X-Change-ID: 20241029-ad7380-add-alert-support-4d0dd6cea8cd
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Hello,

The ad738x family includes a built-in alert mechanism for early
detection of out-of-bounds conversion results. This series introduces
this functionality to the ad7380 family.

This is the first non RFC version of the series (RFC available at [1] and [2]).

Given the fact that the main use case is to hardwire the interrupt line
and according to discussions in V2 about interrupts, I think the best is
to not generate events, at least while we don't have a reasonable way to
correctly and efficiently handle interrupts.

Events attributes are still populated to allow user to set a threshold
and enable alert detection, so alert pin can be hardwired.

Userspace event can still be added later if needed.

[1]: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com
[2]: https://lore.kernel.org/r/20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v4:
- docs: fix some nitpicks from David Lechner
- driver: fix some nitpicks from David Lechner and use helper functions
  to get/set the thresholds
- driver: fix reading the low threshold value
- add Reviewed-by tag from David Lechner
- Link to v3: https://lore.kernel.org/r/20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com

Changes in v3:
- split regmap cache commit in two
- remove interrupt handling completely, updating commit messages,
  driver, and doc
- fix minor comments from v2 review
- improve commit message for iio_device_claim_direct_scoped removal
- Link to v2: https://lore.kernel.org/r/20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com

Changes in v2:
- fix read/write high/low thresholds
- add reset_timeout mechanism for buffered reads
- implement regcache
- add cleanup patch to remove iio_device_claim_direct_scoped calls
- add alert section in the Documentation page
- Link to v1: https://lore.kernel.org/r/20241029-ad7380-add-aleyyrt-support-v1-1-d0359401b788@baylibre.com

---
Julien Stephan (5):
      iio: adc: ad7380: do not use iio_device_claim_direct_scoped anymore
      iio: adc: ad7380: enable regmap cache
      iio: adc: ad7380: do not store osr in private data structure
      iio: adc: ad7380: add alert support
      docs: iio: ad7380: add alert support

 Documentation/iio/ad7380.rst |  33 +++-
 drivers/iio/adc/ad7380.c     | 402 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 378 insertions(+), 57 deletions(-)
---
base-commit: 5ab39233382c621d3271cc274d1534e1b687f4d3
change-id: 20241029-ad7380-add-alert-support-4d0dd6cea8cd

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


