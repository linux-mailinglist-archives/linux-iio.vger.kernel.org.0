Return-Path: <linux-iio+bounces-11610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE899B6478
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC9B281E57
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97961EF92C;
	Wed, 30 Oct 2024 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t3+Hv9JA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A31EB9F6
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295884; cv=none; b=pdFnwbTsvsNvKjCAIdOB23M/m82WyoB076CA0r309t1WLpyrl8Rh8Nly0Z9L36B8GCYMxJfi/7NFtyNnstui7pfnLdo6P2AGcgD07aWlHrwU9/SeuPDTcYn+iklLgjAFfpoOVU6GiFgXTdb/3F99ikveWaF3FUso1Ve1oU2hQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295884; c=relaxed/simple;
	bh=GWJqVI/iDilEQvlonvyO4sifazW5TTd5oM98ekzbBAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mPJPZTixFbyDTa5iw+/z0KHZF8INSlIcADjnzxeYMEsuPrE6gfFh+xrFLWQkHaxW14QOkEmgj84DWQ/VamtaDwzf5ZHX8qfFLXxr7GxfqhhqvQTKhFmoBLHoRSYRGzQ73iga2pqXDRwFozuDxhIUeehQhySPAv5wAw3j7ICnswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t3+Hv9JA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso64511755e9.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730295878; x=1730900678; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLjctguBHNZi72pE4FjnNOCTerHeFfzbTHz+mVkOm/k=;
        b=t3+Hv9JAwpxcq7b/FOgVK3IZMIeoLDUu8xFjf/wqp6smXlX8U6po+2P8uFcgPAg84R
         pNQGVQAO6H8moqfw3fmuTULJUgNJXdJRX/jDfJff6XJI8d+mxS+3rCjNd5eF5WhbLJru
         xSbgD2xzPB+YQkFDGnDNCOTIjEWknqG8BrL5hU++EHQC5cEiNT7/hOXK9azuPRxLpCv6
         nKTTdq5ZOw7yR417XEXCHuxjVxrhGn9jxgd2BHm3+Fea9M1dEW0DN3cwtDIGphcpB/RS
         IfJKrZlCZULahnOMtf/fdg4GCFswnR4tJLdcBy1QpJ5+wZGTSUeDjsN94YbWEL61ijqb
         S4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730295878; x=1730900678;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLjctguBHNZi72pE4FjnNOCTerHeFfzbTHz+mVkOm/k=;
        b=ELH9kti2wLj+h2HqNBfVS3PmKglYA5LIcNYECVGcjWRkgWO/zSU9Ty/qbhoq8u5tAf
         ArJc3trpY2JrkLSb82WOJ3dSbJU5WoBk049fHBhG/J3iyQMyNBm2MaT7JI2Doh2H6a6V
         WKd43ypCOFBHkBnUjC6oUpcluPX9Dk3ZJyTD7oWY+hQs59n1f5bO20ZarakfJK/gSL30
         BCMrHkDCvBHO95lclrc6zENt/M/36ImniQQTEQKCKObb+KPxCzSl+6aUB3h0A7ilbnss
         8VnBRxXxaI7UoAfnsdZiINxYtuzx6ToUH4fvKrIdEvc/wa/5s6BP/ggiYWAnqV7YjY07
         xkpw==
X-Gm-Message-State: AOJu0YzxUl45Dbz9lLKY+e1Xz0XVCY5pX0C/vk2aXqo7RrA/HNlaJAoP
	tW8IwklsRMgTksz0jTt2yGzPwmdDXpH4QC/Xq73NeokuknxXfkuX6ZMsepctanyxnDTmkK1hUQe
	cNvg=
X-Google-Smtp-Source: AGHT+IFXxritnGOAkQy9nNZHfdEtaUI6ECg0r1jyvwI+ZBJUClRm1YR6NclS2yRbCJXEAwaU8aoddw==
X-Received: by 2002:a05:600c:4ecb:b0:42d:a024:d6bb with SMTP id 5b1f17b1804b1-4319acb8145mr113091665e9.20.1730295877841;
        Wed, 30 Oct 2024 06:44:37 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d693sm22135175e9.24.2024.10.30.06.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:44:37 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v4 0/5] ad7380: add adaq4370-4 and adaq4380-4 support
Date: Wed, 30 Oct 2024 14:44:24 +0100
Message-Id: <20241030-ad7380-add-adaq4380-4-support-v4-0-864ff02babae@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADg4ImcC/42Py2rDMBBFf8VoXRU9I9mr/kfpYiSNGkESO5JjG
 oL/vbJNwZRCuhiGO4sz5z5IwZywkK55kIxTKqm/1KBeGuKPcPlEmkLNRDChOOOaQjDSsrpCHbi
 qJShabsPQ55FyFTw36BkTLamMIWNMXyv//WPLGa+3+mbcjsRBQer78zmNXWMdgrTGAtecO48Qv
 IguCqscY857DQJrCmSv1zWbHFM/cvXlanSqzag8GCMP2kcL0E2SLBrHVMY+39fWE189/llw4pT
 RIJBDq6MTyr45uJ+Sy/haS6zwSeyAQj4DigWodYRa3WGIfwDlHqieAWUFHkC0LrBo2gC/gPM8f
 wMLrwKp9gEAAA==
X-Change-ID: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

Hello,

This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
which are quad-channel precision data acquisition signal chain μModule
solutions compatible with the ad738x family, with the following differences:

- pin selectable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

This series depends on [1] which fix several supplies issues

[1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v4:
- Adding a new patch to pull out a local "dev" variable to shorten some
  long lines
- Fix few minor comment from Jonathan Cameron and David Lechner
- Link to v3: https://lore.kernel.org/r/20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com

Changes in v3:
bindings:
  - remove item from channel reg property (should be part of V2, but get
    lost during rebase)
  - remove unnecessary () for channel property
  - keep consistent quotes

- Link to v2: https://lore.kernel.org/r/20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com

Changes in v2:
- fix commit messages and documentation about the gain: pin selectable
  gain instead of configurable gain
- add the enum of available gains inthe binding and array of available
  gains in the driver as ad4000 series
- in the bindings, remove item from channel reg property
- in the bindings, merge additional supplies and channel properties inside
  the same if branch for adaq devices
- fix comment as suggested by Jonathan in the driver

- Link to v1: https://lore.kernel.org/r/20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com

---
Julien Stephan (5):
      dt-bindings: iio: adc: ad7380: add adaq4370-4 and adaq4380-4 compatible parts
      iio: adc: ad7380: fix oversampling formula
      iio: adc: ad7380: use local dev variable to shorten long lines
      iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4
      docs: iio: ad7380: add adaq4370-4 and adaq4380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 120 ++++++++++++++
 Documentation/iio/ad7380.rst                       |  16 ++
 drivers/iio/adc/ad7380.c                           | 178 ++++++++++++++++++---
 3 files changed, 290 insertions(+), 24 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
prerequisite-change-id: 20241004-ad7380-fix-supplies-3677365cf8aa:v3
prerequisite-patch-id: 6127a52d3b14e82d1a6081c7e504d0e4eb323089
prerequisite-patch-id: 7dee57142d0d12682b0be3b62f1c16851aeac069
prerequisite-patch-id: f737e56a372cd91e5fac651a2063b06827f9aa21
prerequisite-patch-id: 7c8d5fbde82810057630b95e12bb2f6576da6980
prerequisite-patch-id: 972bdbf06bafa7c56f604dbe8eb7d236aadaad99

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


