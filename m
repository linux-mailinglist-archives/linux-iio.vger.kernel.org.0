Return-Path: <linux-iio+bounces-21270-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB3AF65F0
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00A74A3377
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DCC23497B;
	Wed,  2 Jul 2025 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yjxi0rYG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AE2DE70C;
	Wed,  2 Jul 2025 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497707; cv=none; b=Y/sIxstAvagB8CnYTWDYGhPXWhxpJ3onx8oRBxBrnRETJt+e4t7zx7U5M3OTuJzyeudoG1Ee8ykhFDfPe2FT87eXsVjqpYGdK9JJQwv8SjF5jZiUnZqGIxSwVfZ9mVh7W1pvF3ozVAWEP+Of4I8zOKysEAsFp+Bgqj37Vlu6y84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497707; c=relaxed/simple;
	bh=c5o7wLli8Nx357iZcIuuM8ggKK057R4CpY1JvWU9ox8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fueCiSj8wDBtVb8BB+RZ4es9c/tOg+Ikqk3qy+0QmyhaFTTeCTjRghICSJlHsYs9OV2Hy2nKau+Uja453qzp8Z78sHQLXmrF+hyYU8olOGnDTa5TTmQTiaRnnjk9AXCmAFzOCDvagQNDKWvvOctsFlELHRpGfweamsxgTpnj/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yjxi0rYG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607247169c0so1551203a12.0;
        Wed, 02 Jul 2025 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497704; x=1752102504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfndfkTGTbAN90qGupO1+iWeXFwU6mFBr2NHqNq6LFM=;
        b=Yjxi0rYGjqOS4R6yiH8ZMj85h8F7Rd+HxvgzbT4z97nUAta7WBRq4h74tiJXBJK2ni
         /XTxCE1iUJkHMf6LjLhabQhDpkIW9bnyQdiVjD4puFoniNtKo2SW/3bQOy4W7XAySq38
         ZH6r3/dFyh85Ykujf/j9gRx9vIIWlQXm+Y4SvdnfzMOFXIgf/Fei5RznKBQiMSQIrNtw
         zFt8qThl1VdOQ0Ot0Q7U1V3PW067gp47ab4VuBcV2KQ2ps5I7tjmWkYIXf1lmf3Ie6Bs
         qD8q+YsK8QDv681WHXQ1NH0ZTTAEPi0ceW/yfoNZyNUFoMACq9K7QpSpR8X8jOtIna3t
         oFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497704; x=1752102504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfndfkTGTbAN90qGupO1+iWeXFwU6mFBr2NHqNq6LFM=;
        b=VgRNCRvZyhRG9eeBhRR2Il7LNX+3PgFPh2Hr7n0Km0e1pXtfb14QR6dtP9qYXcCfzB
         ilzVS1Ezlf3vZjVfoAKZF6eRhuw8oiWpPcTF0xJaUys62XrFKKS6uP9MVaLPC8sQoxTc
         8fgo3LAlYRXjS2BA4AAmhUbQ8rudOP2CfOmjKYtzjSEfva2pW1LVCxoaacC8MOi3k5Mr
         7StcGdJtFLU4h9R1PqY17vtrVzzCFAhX2rQYV1X/ZvZIxY02AMP3+rFcvIUSqw4f5LF8
         ep3TZQibOujNfJT2AXVBzcl2Fy59LKjm9SLQRRXgDKG7zDEzWrJ5u1RByE5LBWiSXwNp
         MBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+mOjhFU2Puw0jnGv2hy2cgPQ0UT920P5eFx/WFdSXG2N3nl5oJROUcHiYrJqXE0ZZTQqCpDFJFek=@vger.kernel.org, AJvYcCU6cJXbUJg8UikCHWTzmfixwEzzCLl2X6D1wd4SCIxdUserVC0GCflhlaiiQu3IEoZuA3UicNIivhJQ@vger.kernel.org, AJvYcCX3ey7IAplui3Qt/533rPo/YlMj0aYKOHUAx1CvE+u+M1CncScH+a5ujzpPhzGjGNwAvkQXbCK9grEZseNU@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8J4NVIMelnHgr2paDuS+DbpsvAFPsgg4vcLW4BR9xE1fO8Z5
	yg9K0WfkFBrXWZXR4FuxhXs5ckeC4c5bO7SkvFoHjPj9TMbnZDgWkEx+
X-Gm-Gg: ASbGnctui9c8kCkaEH3g1ShkE5XB7HnDdc34f9bsHTYVJ62deRmRKRkQH7jRrxwZtAp
	PqT0MK6+6mcaj/vDHBYEtSmF4FitCi7ptLV9DFuP6vBcll7DZy76yvOkKoiLeBcjAqOGvAlHjmS
	NrBPMhCzIsV/PxRdfukEt4WJiYApFB1T0Y/9P+grOn8CCvxD1Y/pP9Oa1QFgMnkTBu0rLtEegwK
	vlP9Ft4KGBWseNxtZVZKOCYK94R+VzGUcFTCwXxxNLTe18NLOg58ldekV37MeuWGKL5jxJyoxhN
	WfqYo1YPLCt4mIeTj6u0XS/Qch01m/FZ6xqsSfnIBX8Jw9ulxoZMlrv4+mfVWPkOox10yGqItRC
	+7Q7H0u9KBvxeMgZJSoL50YosMs3AQCRYo2uRn8ST+CI=
X-Google-Smtp-Source: AGHT+IFYsTWM+YFa15X/bWo7kzOjGKXZwi2Oo9Db9tOsMu2o9h7gzKFIKmHDeB1pJ6sF4KG8xTXgbw==
X-Received: by 2002:a17:906:4fca:b0:ad8:8200:ecf7 with SMTP id a640c23a62f3a-ae3c2aa01ffmr159219166b.4.1751497703355;
        Wed, 02 Jul 2025 16:08:23 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:22 -0700 (PDT)
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
Subject: [PATCH v7 0/8] iio: accel: adxl313: add power-save on activity/inactivity
Date: Wed,  2 Jul 2025 23:08:11 +0000
Message-Id: <20250702230819.19353-1-l.rubusch@gmail.com>
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
v6 -> v7:
- [PATCH v6 3/8]: prefix function `_get_int_type()`
- remove `_read/write_mag_value()`, move their code into calling function
  and allow one level of nested switch/case according to discussion with
  Jonathan
- rework switch/case separatation

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
 drivers/iio/accel/adxl313_core.c | 912 ++++++++++++++++++++++++++++++-
 drivers/iio/accel/adxl313_i2c.c  |   6 +
 drivers/iio/accel/adxl313_spi.c  |   6 +
 6 files changed, 1236 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/iio/adxl313.rst


base-commit: 42498420746a4db923f03d048a0ebc9bd2371f56
prerequisite-patch-id: efe11e81ad33f9728664108cf9670e2811d67e38
-- 
2.39.5


