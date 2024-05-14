Return-Path: <linux-iio+bounces-5038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE58C55A7
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 14:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB11F22E07
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 12:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F329D06;
	Tue, 14 May 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcgI53FU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3381E495;
	Tue, 14 May 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688185; cv=none; b=WDLJXgz/G/FRXMl1cNpoQhD4jn535Ws3NI1sQoCwuQCoj7PXmsKMeHaGiZBVgETIrW9NJctPL0+m3Bu9j9MnBZd8nCAInoc3FdbI/WNF0kH06dZGcuISByKxbkmH2n0ynkpxQyyPQiGw3mRWiR+N7vukadegcqHBDqWbl0BtHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688185; c=relaxed/simple;
	bh=wfB2mKHPuCWXD3WMqn1LnQDGPgLOMfvVFoA6sonOh7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WvA5aOXJhsKvv9JqfwbCnK4IiRgKTd5Ng1BI6q64QONdNsjRbI907m2c7vtdXp2dlEky0cFgJXZW8plIaAJPq/i7MGbC1GQNMI/l0LFt+Z8NInJAxpx5ar19TNaxhLWJXI2uuWGrp/KDEnXIqd9wdcuf+RkxVDAV7TZaq6p65Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcgI53FU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so3128150f8f.0;
        Tue, 14 May 2024 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715688182; x=1716292982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2KfUj4bYwfq/u5ssBZOFZbC05yNdBoV5Drtl5Y/vl0=;
        b=JcgI53FUGjuv3uIWeOZ0bXihKlpOvD141FmAW1p+23h6FGhV6Ps04OQAM/Tl4AA6oA
         y2hLQg13U4xbjMfGIGewihqlKykOKB1beZa9fi6YljeyuztALbDlsl4u8GvVlx/e9aTE
         ivOrkWWLvhmg0kj3fkHCBLhthA4698TB28Be9zcEJwXG2a4QZeqWJbWQuuNOeEzWFEZX
         9epJlvPCyL+qqV4D1mdOFZwV0rEGAY+vse4X8rY1uM32A82ZKnGiQ1wE6VOtWr2QZ5qc
         vOfO6QPpsX7tN1uUYRE8xLWlRjZ5Nl+UGQhSLISL8UmA5WLe4RpFtHCEFno8Xy8bH7sO
         hv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715688182; x=1716292982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2KfUj4bYwfq/u5ssBZOFZbC05yNdBoV5Drtl5Y/vl0=;
        b=tEhG9wlW9kWbkZ1nx9OWgih/SSiIvdYl+IyeFFRGshfHSTGKhH26lqZAquM0AyM1wB
         6XvWfgOFkmezNpW0z3jjgHTOWvJarery6KVVRnixfZiZtqbHt1kHZZItRJQzFwQK9o7R
         sQej53rwc4wTk9LYML4mdfeIUhoHbzl7OhTyazVQsq7Mao6G1eL14YAhOkErxIKtRMEI
         A3M+Q91+oPBowMjJJqw5YkEwdsd6Cjq5QWgS8Xb1oTPd4lBaYKon/lJrsvyzDObPpPJe
         wN29EX+TUvgGQR54mJ1Go/DH3yqP4KpkDMOkuL7gbME73WC2dlLI1xW0b32MykJtTzXI
         sD2A==
X-Forwarded-Encrypted: i=1; AJvYcCUpm16gdyxml8FBua1RkkqjcmwHTYynWvnTUZrJXbqO566nFFui7T829ZzNWfQl2ITsIfdSnGy6HSl4p0WVWzDwOe9s3tl2HQenQxRDrBnQevsRWlFkHO8N6669DaoIgBJFDYx3E0CeukTlYlupcK0IFZ2Fkjw3G4MQivtUwM3w8LXdSg==
X-Gm-Message-State: AOJu0Yzr2vE2U0hKqpCWV/9A2csjnBAmjvnwvVv+GJ1kIgHboQkpJTYJ
	5I7kFF0VhjEze50dSCXC51xvXNos4MCSPLcEoBSS0lFpZg/Fx0jA
X-Google-Smtp-Source: AGHT+IGPjeDgGY1ZUzEDiTDWKFp8huqXg7ba38Vr79bPmiDIa6TUTGAafUfs5ySqWC2iH4GG6/N5kA==
X-Received: by 2002:a05:6000:bc7:b0:34c:fd92:3359 with SMTP id ffacd0b85a97d-350499a97f1mr11260676f8f.21.1715688181942;
        Tue, 14 May 2024 05:03:01 -0700 (PDT)
Received: from spiri.. ([2a02:2f08:a105:8300:5179:8171:3530:3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896a06sm13593927f8f.27.2024.05.14.05.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:03:01 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	okan.sahin@analog.com,
	fr0st61te@gmail.com,
	alisa.roman@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: [PATCH v8 0/6] iio: adc: ad7192: Add AD7194 support
Date: Tue, 14 May 2024 15:02:16 +0300
Message-Id: <20240514120222.56488-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers,

Thank you all for the feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying in order.

Thank you!

v7 -> v8
  - patch3: use MILLI
  - patch3: add blank line before switch for readibility
  - patch3: add comment to clarify that aincom adds offset only to
    pseudo-differential inputs
  - patch4: single -> single-ended
  - patch4: reinforce requirements by binding
  - patch6: use device_for_each_child_node_scoped
  - patch6: channels templates for AD7194 are const now
  - patch6: remove update_scan_mode callback function for AD7194
  - patch6: add sigma_delta_info to chip_info (explanation in the commit 
    message)
  - patch6: use different macros for single-ended and differential channels

v6 -> v7
  - patch1: move mutex lock and unlock to protect whole switch statement
  - patch3: use NANO from units.h
  - patch3: add comment
  - patch3: use dev_err_probe
  - patch4: new patch to add single-channel property
  - patch5: modify maximum number of channels to include single-ended channels
  - patch5: add single-channel property to bindings for single-ended channels
  - patch5: modify example to include single-channel property
  - patch5: modify channel pattern to "^channel@[0-9a-f]+$"
  - patch5: modify required properties for channel node
  - patch6: add function to validate ain channel
  - patch6: remove function to parse one channel
  - patch6: single-ended channels are now also configured in the devicetree
  - patch6: modified some names to reflect the changes

v5 -> v6
  - protect ad7192_update_filter_freq_avail with lock
  - better bindings description for AINCOM
  - the pseudo-differential channels are no longer configured as differential
    when aincom supply is not present in devicetree, in this case the offset for
    the channels is set to 0
  - because of the above change, there is no longer a need for multiple channel
    options
  - correct channels regex in bindings
  - no need to move chip_info anymore
  - change names to ad7194_parse_channel/s
  - add else statement to highlight parse_channels effect

v4 -> v5
  - add aincom supply as discussed previously
    https://lore.kernel.org/all/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2khXnqA1cSdKpWHKWp0w@mail.gmail.com/#t
  - ad7194 differential channels are now dynamically configured in the
    devicetree

v3 -> v4
  - drop device properties patch, changes already applied to tree
  - change bindings and driver such that for AD7194 there are 16
    differential channels, by default set to AINx - AINCOM, which can be
    configured in devicetree however the user likes
  - corrected mistake regarding positive and negative channel macros:
    subtract 1 from the number corresponding to AIN input

v2 -> v3
  - add precursor patch to simply functions to only pass
    ad7192_state
  - add patch to replace custom attribute
  - bindings patch: correct use of allOf and some minor changes to
    the ad7194 example
  - add ad7194 patch:
    - use "ad7192 and similar"
    - ad7194 no longer needs attribute group
    - use callback function in chip_info to parse channels
    - move struct ad7192_chip_info
    - change position of parse functions
  - drop clock bindings patch

v1 -> v2
  - new commit with missing documentation for properties
  - add constraint for channels in binding
  - correct pattern for channels
  - correct commit message by adding "()" to functions
  - use in_range
  - use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (6):
  iio: adc: ad7192: Use standard attribute
  dt-bindings: iio: adc: ad7192: Add aincom supply
  iio: adc: ad7192: Add aincom supply
  dt-bindings: iio: adc: Add single-channel property
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../devicetree/bindings/iio/adc/adc.yaml      |  19 ++
 .../bindings/iio/adc/adi,ad7192.yaml          |  95 ++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 272 ++++++++++++++----
 4 files changed, 346 insertions(+), 51 deletions(-)

-- 
2.34.1


