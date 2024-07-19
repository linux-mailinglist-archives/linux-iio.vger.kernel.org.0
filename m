Return-Path: <linux-iio+bounces-7708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A19377FB
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 14:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9139B217DE
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F74D13D53F;
	Fri, 19 Jul 2024 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="a24pV2PV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489C8002A
	for <linux-iio@vger.kernel.org>; Fri, 19 Jul 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721393465; cv=none; b=e0TpvG4wQ/c7qd8/axTLnCxxi9bZtIHE9blyYzhvwlEOtE/lxzdY6zS671gZ9SD+QLjfQC4JAQxvkKAvEPygHmEzRQ6BF/vZM6qBMYShAAgdfJ8noWumEjz/r/1jgYPd0s6iWtBotoc332KQxBoCDTQ7T9AkuYFFSD43Hr6W3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721393465; c=relaxed/simple;
	bh=xXt0N6VYWW8YPDnvrImicbI1rr1ol5K85y/byXpzfDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H51Vku/GvzIN5HWpqGVyK+uV88e6myUI6FxZbgeow7UcqJ+lMaejiek5+WFpXQO2VIsB0Gn3eeNql/GCLpBZrSGL0M6iPDOSOmm+oFtOeaZkPHnts5i6FYTPsLxi93nINM3DPgjiqDIl78FcZKhZmLSOOxjDSLAJjUECMvVKmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=a24pV2PV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so289544f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jul 2024 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1721393460; x=1721998260; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnW+QtOY6ZtIr/UeldkQWe3PjOOS9VeTPtLph4J8Lws=;
        b=a24pV2PVV+UXvd+8TSIIAwN2n6BzSq+hS2kY7FYcuo45sq1Lw7l2foOI+k70cUzJjC
         gixjDRUymUVa/F8GQFcxMVJ6RNrzRDccDw3EX3fNGSGTv85MomSSNRMfCMnXKBdbdGJ9
         WizVISKmBC7UNJNrAuPv7EYYDC9KnpIIV3zYmyAMF1mjF5zmq4FgyJH35+Sun7Me6xdK
         hURoj9YSWZzKfk/MjcMpQYPjfuHJXM3GWiyMtFHj72uHooQxyiKNULkECMESxv7+5mvV
         Ksgokq48qSYyxwnJ4wWAi+OmsxE1vPHrk2pp5zVGehd3QM9NEcxdGgSKsMWBsI91+Svp
         9ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721393460; x=1721998260;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnW+QtOY6ZtIr/UeldkQWe3PjOOS9VeTPtLph4J8Lws=;
        b=AThNW9Hx5VKizL7g9zwJZ8dQFk3YzWt2F7tDjVc2KSsadQ2oNMP+gZa7+RSChwn9yq
         Xloi3IgQiZxrBnjY671mcKk7meerBQN0TqrZyuek8s4Aj999L978npsnzbAZL2i6f/k9
         VuKuvSZAgAplwvZrq1Ha4JMvZVahX1xE7HrB1y9WOG2KHdjI+MfW8H2k3SYMDSWEudNU
         3SijZjC7QbUOhmf2yv2w/XvfmAwzN28Bp5rwKnM53szbtaPg03QXFYF4N87JB8uZBvHy
         MCwpd2o0k/ldtURiK9wBmlPokLN9UCLhYM1LXqlUkSx15ildzGwBDZnLGvk6mxmLH3Oq
         Pi3g==
X-Gm-Message-State: AOJu0Yz56eWsRQ7k5JxMx4CO4vse9Gyceq2khXutO6j4PcgyZ1G4RD3P
	GHmIm3eiTE7WEf8IIe/ASvT65CLMnRpZI+Dw6qIE4jKt3HMVkEOUSVOI1rAQvAI=
X-Google-Smtp-Source: AGHT+IFtGBLg+/5tPGgRE0///9QUX0tULII5KY2w4QbcK+acLl1/ohPlPdg1KivOMZFgPNhfWnb1xQ==
X-Received: by 2002:a5d:4a4a:0:b0:368:504d:c3a4 with SMTP id ffacd0b85a97d-368504dc3e8mr3502992f8f.17.1721393460404;
        Fri, 19 Jul 2024 05:51:00 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2911486sm21217445e9.0.2024.07.19.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 05:51:00 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH v4 0/2] iio: humidity: Add support for en210 sensor family
Date: Fri, 19 Jul 2024 13:50:52 +0100
Message-Id: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxhmmYC/3WOyw6DIBBFf8WwLgYHWx+r/kfTheKApBEsoLEx/
 nupprt2Nbk3J+fOSjw6jZ7UyUocztpra2LITwkRfWMUUt3FTIBBzgpWUTQesoWWEs6cVZd4kUR
 4dCj1sotu9yM7fE7RF46StI1HKuww6FAnwSqHinzIXvtg3Wv/YIYdPcYy9h2bgTLa8EIAsKxsm
 biGHpW13YhGTdqkwqbTY7fN/LeBR0OOXLZCQlPI9o9h27Y33ls3BhMBAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721393458; l=2884;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=xXt0N6VYWW8YPDnvrImicbI1rr1ol5K85y/byXpzfDs=;
 b=g76wwo273v1rT/N4jDr1SzfoGlzmpqfRcCocFBorbKggtLml3otPxVQCEqMA2N0OTgsnF7KHO
 BwZ6bckW/WvDlgEFzXvgAhlw51QYYVm+dFqeRyeNytUzN4N/1qS4VGU
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

This patch series adds support for the
ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215 temperature and humidity
sensors.

Patch 1 adds the required device tree bindings.

Patch 2 adds the driver, providing the probe and read functions.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>

changelog v1 -> v2:
sciosense,ens21x.yaml: Add supply to documentation
sciosense,ens21x.yaml: Add fallback to compatible strings
ens21x.c: Move i2c_device_id next to of_device_id
ens21x.c: Use i2c_of_match_device() instead of of_match_device()

Many thanks for taking the time to review my patch.

Thanks,
Josh

---
changelog v2 -> v3:
sciosense,ens21x.yaml: Update yaml to match dt_binding_check

- Link to V1: https://lore.kernel.org/all/20240709-ens21x-v1-2-678521433cdd@thegoodpenguin.co.uk/
- Link to v2: https://lore.kernel.org/r/20240710-ens21x-v2-0-a37c22018b0c@thegoodpenguin.co.uk

---
Many thanks for the feedback on the driver.

Changes in v4:
- rename ens21x.c -> ens210.c
- rename sciosense,ens21x.yaml -> sciosense,ens210.yaml
- General: Changed wildcard ens21x to ens210 to avoid wildcards
- Kconfig: added crc7 as a dependency
- Kconfig: remove extra blank lines
- ens210.c: Moved constants to inline
- ens210.c: Created ens210 chip info to handle chip specific conversion
- ens210.c: Added documentation for mutex
- ens210.c: Fixed sparse complaints from kernel bot
- ens210.c: Changed htonl to cpu_to_be32
- ens210.c: Renamed dev_data -> ens210_data
- ens210.c: changed of_match to i2c
- ens210.c: Added return check for i2c write
- ens210.c: Removed switch for conversion check, use chip_info instead
- ens210.c: Removed unnecessary retry loop
- ens210.c: Convert read to u8[3] type
- ens210.c: Ensure 'correct' path is inline, use early returns to break
    for errors
- ens210.c: Changed mutex to scoped_guard
- ens210.c: Changed part id mismatch to dev_info from dev_err and removed
    return
- ens210.c: Moved name from id->name to chip_info
- ens210.c: Changed data field to be chip_info rather than enum
- ens210.c: Formatting fixes (consistent spacing, extra line break at end
    removed)

- Link to v3: https://lore.kernel.org/r/20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk

---
Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS210 sensor family
      iio: humidity: Add support for ENS210

 .../bindings/iio/humidity/sciosense,ens210.yaml    |  55 ++++
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/ens210.c                      | 341 +++++++++++++++++++++
 4 files changed, 408 insertions(+)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240709-ens21x-8f2530968f2e

Best regards,
-- 
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>


