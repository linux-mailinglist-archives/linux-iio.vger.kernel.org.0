Return-Path: <linux-iio+bounces-20685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB5DADA44E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC8716782F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C716264A65;
	Sun, 15 Jun 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQof0RXo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339A8528E;
	Sun, 15 Jun 2025 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026189; cv=none; b=I6Tsusbf4d27xYRHddaN5pZI8rnKhD3iAbs12ubGsY8dbaj2PXRSivyTzxqYNndq2XTph5gWzVUVxgNVlX9ES4uGTRdRaTo34StKnRs8Iw0QFccoR9w0fmYmHOO7aBlQJED6Hlz9NRI/69Fjr2b1Tq+pUGYZfqwmk/ulUMf0R78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026189; c=relaxed/simple;
	bh=BiYLwg7GOzrUbMiMWe4c9II22h27xKH5Jh7QKC8N47c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F4KdqzsQNHTpo97do97mGeZ3t5r2Jqa1iW0uU4ioJ51+o9ZiJVWNUURF4fVrE1z2XreajSgUxr9qPRK9V3dlJQQknPZxET+KeNliz1LXTCcPUStyMS9pm3WyjQ/b32ph+v1o5KBlMybv+2QXjPCkvodA6w8SRj4C7BnA8dBQGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQof0RXo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606c6bb1d03so761270a12.1;
        Sun, 15 Jun 2025 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026186; x=1750630986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XtyJXPdbyk3m15J9f63pmVkZH5KN8VEtVibfDetgPU=;
        b=aQof0RXot+ql1pL0G6CEcKx84Lw+EAQdqb+iELrlhT4lTI+G+KASAq6FfQVPfOjGFI
         0+KJNmrH2Yqzjsg+b4gyHeLIyNB9hLF3XJUixAc2725vL+9MvtvfLeAI3ku3sMIBI1Ha
         nlRMWQ/pUKBk5Y9Os/bZNJMSsw2NhoHgUtvQ/fxjxJsoOJW7Xms7sk0QoS3v6aVr9rkg
         K6SuxwILPghVHZAbWDLX6s/4gXfvnSqprlEPt2zsfbWg+rcSCEb1XYMoEBvgzwNsgcRm
         Y0X37ZTbiNcJhiMC6PFkHe3v7XGtrZB6ZAsl1PiDahD+SLFzlNFt/IUsvY9HPcpXDUNh
         xdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026186; x=1750630986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XtyJXPdbyk3m15J9f63pmVkZH5KN8VEtVibfDetgPU=;
        b=YaWZ93ubJ8mz4uu9WCxAapxHIRFqdzGgGlWWRTP/J+kxbQEZe5suE6P/sH53GUiG0M
         N6LpzSnXpqCZcKRLFToGTqhkQOdnZj65BxX7+Vfo8M+l7ZL4szcCVpd/Uh3qxDRpxr58
         NB+hLbkJGYP38bXp9SJuDMsKh/dAWKHcZDmmNxvF0qq8QYFzt+QVXrNsVKD5E/q7k/gy
         7HCwIWjJcBJngS6SelqyN6P+Am5kjo5BWk0KY9D9tc62ktkgRgOS+Yoo8a7jKhKThVQG
         lh3U8vejHHfPWTv5jhQzld2zC3QIMvAg6wCl1a7rKwLAFA3Vh2zdsXVKtz8fRg03bJqO
         hmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYlmQQ78jmEfVRDFOiIg6NFcQgyvzzLLW8v8+J/lGAkG/s5lM1ap6xTTknNyRzk8Iwv6RgIjbbAop6@vger.kernel.org, AJvYcCWUdJlEVyrZR64I6WSdfW8DKRjDrnrCyBWZ5GU8CY75Oxj9D4ZTywASGIxCaUVdgzA7QbAa42QdrE0=@vger.kernel.org, AJvYcCXPAuI8BjjPJmWNrx/1NxFwIm+r4UX3tbE9HkNSbkGO9qNKzPd2FgUcEjKONppYS2VSg53CQi7HJm/b/o0I@vger.kernel.org
X-Gm-Message-State: AOJu0YyjqGl6ARCvHmccJC6xUtE03stEl6DjaBhW3TTAqKUC2Cgj+Z0k
	BaSPvTwq9U47pNp+nMdLgQYDBBJSTQhghU4svehRJpqqoB338BYm003G
X-Gm-Gg: ASbGncuoasC4UL6X2yuSF/1XN9UzF2ZiA8M2iEhEgs21cO+FjHmTRzxL071OFrBPMx9
	U577L3OeF4ewEDsuYWM6E2xMUjNCWz90dMjLkK4kqS1zE0pjrDRDE1R98+be5prFdBoUxD58M7w
	Mi9TeOWiKtJS2oBmwKwqDOhrte3qSOvnQ6XCw+iNA20wrfHn54eFgOPaUhX/8A221N5sIExomgT
	qhcEnYOHP8a5TYNShZE7aCAh+MOpeydZtqyFyoX5gP/E/t5HB5R4dHIAXuiL0Y9HdIFrV9EyoCu
	FANojEGTwkrMoWiwsiu3qZXEnWjyHesntEKgZ6vvmHbPjWSE8va0AZ+oJ+qgicX7RAMyq8q8D7T
	KreOVLHMpZwMXgajW+Vsq7GuB0Spclg3Q
X-Google-Smtp-Source: AGHT+IEDe/nyOJM8IFzjQRoyy9S8at2/MW4/MVWrTQKfv6mUISRFRqiYVDRkm049C+yF/3/E1Qrgsw==
X-Received: by 2002:a17:907:dab:b0:ad8:ac7f:2490 with SMTP id a640c23a62f3a-adfad500c2dmr242774466b.12.1750026185564;
        Sun, 15 Jun 2025 15:23:05 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:05 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] iio: accel: adxl313: add power-save on activity/inactivity
Date: Sun, 15 Jun 2025 22:22:50 +0000
Message-Id: <20250615222258.117771-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch set covers the following topics:
- add debug register and regmap cache
- prepare iio channel scan_type and scan_index
- prepare interrupt handling
- implement fifo with watermark
- add activity/inactivity together with auto-sleep with link bit
- add ac coupled activity/inactivity, integrate with auto-sleep and link bit
- documentation

Since activity and inactivity here are implemented covering all axis, I
assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
channel for activity/inactiviy. AC-coupling is similar to other Analog Device
accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
documented and functionality tested and verified working.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v4 -> v5:
- [v4 01/11]: applied - debug register                                          
- [v4 03/11]: applied w/ changed commit message - regmap cache                  
- refrase all commit messages                                                   
- merge patches [v4 02/11] [v4 05/11] and [v4 06/11]                            
- add ADXL313_REG_INT_SOURCE to the initial regmap cache definition             
- `adxl313_set_watermark()`: replace plain hex numbers by defined bit masks     
- `adxl313_set_watermark()`: replace `regmap_update_bits()` by
  `regmap_set_bits()`
- `adxl313_get_samples()`: remove initialization of variable `samples`          
- `adxl313_buffer_postenable()`: add comment on turning off measurment          
- `adxl313_push_event()`: move WATERMARK separate out, focus on pushing events  
- `adxl313_irq_handler()`: add comment on draining the FIFO                     
- `adxl313_push_event()`: remove missleading comment on return statement        
- `adxl313_is_act_inact_en()`: If it's false, it will be false anyway -
  simplified now
- change order in multiplication with unit: `val * MICRO` which is read
  more naturally
- `adxl313_is_act_inact_en()`: remove check for ADXL313_ACTIVITY in the
  activity patch
- `adxl313_write_event_value()`: remove the general turning off measurement mode
- `adxl313_set_inact_time_s()`: replace plain number 255 by U8_MAX              
- `adxl313_read/write_event_config()`: encapsulate duplicate code into
  `adxl313_read/write_mag_config()`
- `adxl313_read/write_event_value()`: encapsulate duplicate code into
  `adxl313_read/write_mag_value()`
- `adxl313_is_act_inact_en()`: apply switch/case rather than if/else for
  readability; factor out variable `coupling`; convert all remaining `_en`
  variables there to bool, such that a negative error is evaluated from a
  `ret`, and     logic operates with `_en` variables
- `adxl313_set_act_inact_en()`: major rework due to issues discovered by
  automated testing (also affects related functions)
- fix kernel-doc issues 

v3 -> v4:
- squash patches [v3 02/12 + 03/12]: buffer usage into the patch that adds buffered support
- squash patches [v3 07/12 + 08/12]: interrupt handler with watermark implementation
- add patch: (in)activity / AC coupled as `MAG_ADAPTIVE` event
- `ADXL313_MEASUREMENT_MODE`: adjust commit message on removal of define and adding measurement enable function
- remove irq variable from driver data struct, make it a local variable
- `adxl313_core_probe()`: flip logic to condition `int_line != ADXL313_INT_NONE`
- `adxl313_core_probe()`: change mapping interrupts from 0xff to an explicit local mask
- `adxl313_core_probe()`: add comment on FIFO bypass mode
- reduce odd selection of headers to add [`adxl313_core.c`]
- `adxl313_set_fifo()`: this function was turning measurement off/on before changing `fifo_mode`,
   called in postenable and predisable this firstly excluded setting of interrupts, and secondly
   still configured watermark where unnecessary, this function was thus removed (covers unhandled
   return value, and refactoring of function parameters)
- `adxl313_fifo_transfer()`: simplify computation of `sizeof(i*count/2)`
- `adxl313_irq_handler()`: make call of `adxl313_reset_fifo()` conditional to OVERRUN one patch earlier
- includes: rework adding included headers
- activity: change to work with or'd axis and related changes to the fake channel and arrays
- `adxl313_set_act_inact_en()`: generally turn off measurement when adjusting config
  activity/inactivity related config registers, turn measurement on after
- doc: adjust code block highlighting and remove links

v2 -> v3:
- verify keeping trailing comma when it's multi-line assignment [v1 02/12]
- `adxl313_set_fifo()`: verify have two on one line to make it easier to read [v1 07/12]
- `adxl313_fifo_transfer()`: verify removal of useless initialization of ret [v1 07/12]
- `adxl313_fifo_transfer()`: verify usage of array_size() from overflow.h [v1 07/12]
- `adxl313_fifo_transfer()`: verify return 0 here [v1 07/12]
- `adxl313_irq_handler()`: verify "Why do we need the label?" / moving the call under the conditional [v1 07/12]
- verify reorganization of half condition for Activity [v1 09/12] and Inactivity [v1 10/12]
- verify usage of MICRO instead of 1000000
- `adxl313_is_act_inact_en()`: restructure according to return logic value, or negative error
- `adxl313_set_act_inact_en()`: restructure function, use regmap_assign_bits()
- `adxl313_set_act_inact_en()`: verify makeing it a logical split [v1 11/12]
- `adxl313_fifo_transfer()`: change iterator variable type from int to unsigned int [v2 07/12]
- `adxl313_fifo_reset()`: add comment on why reset status registers does not do error check ("At least comment...") [v2 07/12]
- `adxl313_fifo_push()`: change iterator variable from int to unsigned int [v2 08/12]
- `adxl313_fifo_push()`: remove duplicate check for samples being <0 [v2 08/12]
- apply `regmap_assign_bits()` in several places to replace regmap_update_bits() depending on bools
- `adxl313_set_watermark()`: rename mask variable to make it more comprehensive
- removal of duplicate blanks in various places (sry, my keyboard died) [v1 07/12]

v1 -> v2:
- usage of units.h
- simplify approach for return values
---

Lothar Rubusch (8):
  iio: accel: adxl313: make use of regmap cache
  iio: accel: adxl313: add function to enable measurement
  iio: accel: adxl313: add buffered FIFO watermark with interrupt
    handling
  iio: accel: adxl313: add activity sensing
  iio: accel: adxl313: add inactivity sensing
  iio: accel: adxl313: implement power-save on inactivity
  iio: accel: adxl313: add AC coupled activity/inactivity events
  docs: iio: add ADXL313 accelerometer

 Documentation/iio/adxl313.rst    | 289 ++++++++++
 Documentation/iio/index.rst      |   1 +
 drivers/iio/accel/adxl313.h      |  33 +-
 drivers/iio/accel/adxl313_core.c | 896 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl313_i2c.c  |   6 +
 drivers/iio/accel/adxl313_spi.c  |   6 +
 6 files changed, 1220 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/iio/adxl313.rst


base-commit: 7461179e080df770240850a126cc7dbffad195c8
prerequisite-patch-id: 263cdbf28524f1edc96717db1461d7a4be2319c2
-- 
2.39.5


