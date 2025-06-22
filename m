Return-Path: <linux-iio+bounces-20848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF8BAE2FD4
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E5B3B33B2
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BAC1E0E1A;
	Sun, 22 Jun 2025 12:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaZGbM8o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99AA1D5CED;
	Sun, 22 Jun 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595385; cv=none; b=erB2ND6suFaOlp+g34kfLqxv3A92wsDUYz6d39cT5qk/ImSaE6OXR3uz1S2nkgarXCQEwteu2OvNj1WYR3zT1QqgntaAGXr640o7ftXUHsBOLm2crY6waeND50LVCEQDiWZux3ayY2elmsN2zclvQqS0JB9iuux/YH9tTw5p/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595385; c=relaxed/simple;
	bh=O22e0I+KqmR2wuxwAZjnNfk/NrC/KI65TYxMZgHFPXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K+J3D4D/vuEgm5dcgehYtf8gzJfCnhmPxoZSHiMkbBxsBV1lLnkN5A4n7MjeIFQpZ6T/BZe2UNQMye6LeS228ottdle3ZZAeCclGs4syvvji65uNPLbWkCqcW9eIC2ksaSSiVYlPfvVNc3ZiPAhYvdC9A/Sj/3j9bmsrRihSe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaZGbM8o; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60bbfe9e864so32538a12.1;
        Sun, 22 Jun 2025 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595381; x=1751200181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzVc4ZpcUw7jfE1X+GxxwIF1e2i7Mcig36GXVPCosW4=;
        b=RaZGbM8oV1WQ/l/QqEZxpTRDey0mdzFCo+Jxvan6/9XMfTEGENUTAfgaZ6nOFWNMX2
         X9Ew/pNWJXAGSpOzStPeS0gYTLpDn+DrKETkiLamh+c1zLx9ik1+n5u1OdeK+SxdPqhZ
         4Eu02koAuk3k38jdd93/yw/VYenOoK0T7QIDhpQgFp08A+SXmRlduA3m8osfQtdfAY+q
         p40LuwgwIi/yGLRy1L9s2Pv4CzLuK3DBFisJb7LWlgl1D/j1lcK1KSey8GlivqwCroe8
         seY1YaDh6ynuqW2fQI7mc3gR7Wc9pLLjj3C2Mof1gbo47F16g6Vo7TMvYcvzbxKRHzWs
         lEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595381; x=1751200181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzVc4ZpcUw7jfE1X+GxxwIF1e2i7Mcig36GXVPCosW4=;
        b=scnsw7o5HHNr8MZom+PKITSw/NYhrnBhx2qmeFJN+8Kmd/DLSYVcOMYC/bnVtUD3sK
         mNV8aM6ceyhoY/Kf3vJY2RHZneCdpj/EIi5hVkoyldUwfnnvdmB7/VFmQG4+XTxbwAJ1
         A65NIFJ74AvpTrPNQrtsS7djo9CfCnzrHD3WILhPNjkYCUcJHg7+Wl4Nl+OHIYQj8bVc
         UCO2rZDZH9KVvv+bqqORqGUD5iSpHVFAQRQwqghS/hLU/pW9I/R64h5WxhhnAYtpcewe
         kHYdLSjeK5HzqnPjQWpdi89BGoLNC6V7CDMN/KW4QBOE8FANMXWmHrCGotdZjb46PBo5
         D8aw==
X-Forwarded-Encrypted: i=1; AJvYcCUEYad8A6I9hp/5+pFawV6x3BMSqjntmf64pa9Z9ipyyUhlpW+Q2FLV3AQJXTKmwEehbeuR0IHMLccuKiHE@vger.kernel.org, AJvYcCUtImUy9DKKP2fteUEuB5s8Gg0YSY/uV5vW/58cDj4HnFvAiYBEC09oESIoQNhV3Ia6j9MKzEieafs=@vger.kernel.org, AJvYcCXCqwT9oTUv/Vn6G3QtVrL9LS1hwVcCBaZEHTv9HQeEbZ7RVd2GD8UBjM0k2vH/3NZK+hCOkO3IQ+Wu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5gfcmxDWzs7F06ARc1QuV3DDNNA4ToihsboaG42IXLMIyXvhB
	5X041PQ428zZvnotmFRkdUVbZeRdDrGDiL3NTqyKNQTCIzUQvk/JRZ9W
X-Gm-Gg: ASbGncugYbZOh338bZ7c/mP4EB1PD4dnmGDbua2JzrbxLQUGW+ow33StSmJxYjxMAC1
	YRytMK72UGfw0QJC2jDj6cy6ikIdGaiB9QUd8TLrfvSBR3LrCInFYrLzVIcdRTUs3hIA/JDMTOr
	x8K5hSeH21PnNyBnQj6OJ3iYy0EpJfek61VU/YhgE4D2xkLiWbMo0GcYi0aYTcUNXON6kCMcZcR
	wfpwtthlU8dyu4id6OQcZUFs+GKECk5yvmRwkyHmTUXtTmmfBM+GDRNKQfSCESuYb8WJH97E7il
	0e11DLhUCQgTEUoBLVyn96AjEhOl2FoCQvATxmr/44EX2EpoPn7ur0lyGf882Xm74yWhDKIKTlr
	NTxT0I9laMU8qbP/bqgevLINZ7mmLe1CAUiAoXGovss8=
X-Google-Smtp-Source: AGHT+IF0vTdgcThvJJqdnhWEAMv/9xhAJaf1tt1XP8Yek0ZX//wi2b4gVmRyQiJxSK8NG1YUxkMB4A==
X-Received: by 2002:a17:907:c24:b0:adb:1331:a508 with SMTP id a640c23a62f3a-ae0578fbb18mr300662666b.5.1750595380864;
        Sun, 22 Jun 2025 05:29:40 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:40 -0700 (PDT)
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
Subject: [PATCH v6 0/8] iio: accel: adxl313: add power-save on activity/inactivity
Date: Sun, 22 Jun 2025 12:29:29 +0000
Message-Id: <20250622122937.156930-1-l.rubusch@gmail.com>
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

Sorry for the fuzz: when I was about to rebase for submitting I
noticed Jonathan actually already applied parts of this. I'd recommend
to consider v6 rather over v5.

Since activity and inactivity here are implemented covering all axis, I
assumed x&y&z and x|y|z, respectively. Thus the driver uses a fake
channel for activity/inactiviy. AC-coupling is similar to other Analog Device
accelerometers, so MAG_ADAPTIVE events are chosen. Combinations are
documented and functionality tested and verified working.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v5 -> v6:
- `adxl313_core_probe()`: change conditional logic for evaluation of
  `int_line`
- `adxl313_core_probe()`: add helper function `_get_int_type()` to simplify
  logic
- `adxl313_is_act_inact_en()`: remove blank line; make variable `axis_en` a
  bool
- `adxl313_is_act_inact_ac()`: removal of ',' in comment
- `adxl313_set_act_inact_linkbit()`: regroup logic expressions
- `adxl313_set_act_inact_en()`: change comment style, and rephrase
- `adxl313_read/write_mag_config()`, `adxl313_read/write_mag_value()` and
  `_adxl313_read/write_mag_value()`: avoid nested switch/case statements,
  add helper functions from start and populate them incrementallay
- `adxl313_set_act_inact_ac()`: move AC-coupling code into a separate
  helper
- [PATCH v5 1/8], [PATCH v5 2/8], [PATCH v5 6/8] and [PATCH v5 8/8]: set
  "Reviewed-by:.."

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
 drivers/iio/accel/adxl313_core.c | 937 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl313_i2c.c  |   6 +
 drivers/iio/accel/adxl313_spi.c  |   6 +
 6 files changed, 1261 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/iio/adxl313.rst


base-commit: d1584d12ec8c35534172882c1713947110564e4c
prerequisite-patch-id: 263cdbf28524f1edc96717db1461d7a4be2319c2
-- 
2.39.5


