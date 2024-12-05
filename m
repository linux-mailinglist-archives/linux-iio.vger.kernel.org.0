Return-Path: <linux-iio+bounces-13116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E876F9E5CA2
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE7E16B57B
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A222576B;
	Thu,  5 Dec 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIZyJkJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAC224AEF;
	Thu,  5 Dec 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418833; cv=none; b=J6Bzvb5X4cQOPTaVXapxpVhg78fPQBLvm2W7ytw65/usg+48cF7MGt0EZcrvTyeprhCOHVtdmMLOVP6AZzGwYMjTwD8ot763PPibFyi75clSR0uA85co8NNOhsZu1HAy9VN73PiC4lquALcXxQnN8K6lwXqrw7KTERXSyr14ANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418833; c=relaxed/simple;
	bh=TocBcIzh0TEIAvJBYzZUsFPIvVCRg/BYMCDTs4mbFVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGgnNAT0lM0dWYZDtcI6t3Fy1m5Y6zyVFWMEOhsE6Nw5UIUSkAPKkEWzJ6btuZC3yEN0wPlwaJz7vfs/IpVop7qvkgkg9/jM2M4RPdUP2zybYxtQZ7s/b2sEzBC+WAJ9dy/TGVcxkEZw9J5S3qL90fp0hM1ERsJOoJl6J9gmWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIZyJkJi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0bdb7ea5cso154861a12.0;
        Thu, 05 Dec 2024 09:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418830; x=1734023630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xOEBy5Kj8Gz9VwS48fPoYMyC1ZjP/g4WXgCxdhJIM4=;
        b=hIZyJkJi2rXdB7w/uMJuw80vbryRY5iBSdBv17LKAV0aENmvqpufkmt2htb+cL6m9h
         5SKNyHzAH5IZ+oi8y012UWhvaY97egU7N5A/pNJx8ZjMDllGgBHU8qTkI8MT3q9tPFnw
         LwaZaBl1A8WKIrGQrNBayTLWoyA6ei2ew9oKt7r3bzw5tghLF23mD5UqCUpLIh3/BF8Q
         F4UlNE3z7LzP0H/v+FB+kaWl+Epp1u5I6e6HAW46TUN9XJzHvuJw8DunEYdBdNOAhfWQ
         nosCD1z6O+WqMIC5cPMuO6C9vFRCaTpZOU9+gwIUo+UZwoA8F61V2N5PxlVhhPk3am7x
         6zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418830; x=1734023630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xOEBy5Kj8Gz9VwS48fPoYMyC1ZjP/g4WXgCxdhJIM4=;
        b=uE9WFJYHBz5QIDUio9t5ODYChLTF68c63WuTdx4sO00DufPHnybZXgToPh7aVViwoh
         ofnP6BLYUMrF95beXKpczRDcsND6C17xG+0xP7sYgBOZcGtYdSt6W1szVODE5l39jy/f
         vEwcSvgBLwuBul/KYPYFSXeq7F7miGXKgo3RVjgQW9wBTRShQDJO5H5/8w01XmtDiZZm
         mAZ9xz1kFzhuHII/ef3r5OmgccFMNPoGn0tl/7luM/wqgkNOlMdRxZnNsuvz4YDebGWd
         3XefbtLpNGtgFLo6mE4Ts3DHfploYQxhonWeAj97UUjiSDX3C2WYtuRZlhRer+igKDnZ
         XTMw==
X-Forwarded-Encrypted: i=1; AJvYcCUvF5oCFBJ0Z3nAxwXAVzxHX0nsQ2UP/alCDTkNTTBxu5d2rR6+Vzk2iECUvvuj67jjMRgcWWb54bMO2yEj@vger.kernel.org, AJvYcCX5sIMZY/cNMTEqFObOTNV0pKLeulAbQYlFG6kbXMwrUGg6+VANjpVIGT59AXreukWIfsmBeXUt6Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8YoaLjoeLyaNDGknL8qYumNtNeaFcvwgtoNS0o2z/Fzl9/mk
	1OJI82dg0p24xaf0KTSzF36k9qIgEqvs7UlhBY527c5vmFOneut5
X-Gm-Gg: ASbGnctBkD2NjLXD8EJa9+6lZl7teT/F2DklEokoOc2ppu/4+4ep8KPKIhd1YicngNe
	Few7noZ0MrxNg8729mgY3iacCGrhjAFQmjm81H8eNIXnHWuoqwWnvEDEutFrplC6ESa1KFTbBus
	wCuXPZhOr7uJM5zd7Rh5H24XiBr9zesWRh3YX7Tm8VGPIRIbxN4kcpNbw1s2fUb39eVJuL4V/SF
	KLVbz4FC85d9w5DOA43A84+5FQPA6KIkzJLhcaGkmH88ajcIjR1DwPNSkQuyNzmVnSMu7MuqlpK
	wXf6rXZufei14Y966G6JQV9cffLV
X-Google-Smtp-Source: AGHT+IHzqcVvWs3zfN/JxUmuj2hBqFiTE/hZf/62jaaNY028BmBR0tQUfbLNUAie1SG5XYLWvp/QfA==
X-Received: by 2002:a05:6402:354d:b0:5cf:f39f:3410 with SMTP id 4fb4d7f45d1cf-5d10cb4e183mr4027584a12.2.1733418830027;
        Thu, 05 Dec 2024 09:13:50 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48a38sm1026078a12.23.2024.12.05.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:49 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 00/10] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Thu,  5 Dec 2024 17:13:33 +0000
Message-Id: <20241205171343.308963-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adxl345 sensor offers several features. Most of them are based on
using the hardware FIFO and reacting on events coming in on an interrupt
line. Add access to configure and read out the FIFO, handling of interrupts
and configuration and application of the watermark feature on that FIFO.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
Although I tried to implement most of the requested changes, now the code
is simplified and clearer, I still encounter some issues.

1) Unsure if my way reading out the FIFO elements with a regmap_noinc_read()
   is supposed to be like that. TBH, isn't there a better way, say, to
   configure the channel correctly and this is handled by the iio API
   internally? As I understood from v2 there might be a way using
   available data, also in iio_info I see now as buffer attributes an
   available data field. Where can I find information how to use it or
   did I get this wrong?

2) Overrun handling: I'm trying to reset the FIFO and registers. Unsure,
   if this is the correct dealing here.

3) I can see the IRQs coming in, and with a `watch -n 0.1 iio_info` I can
   see the correct fields changing. I tried the follwoing down below,
   but the iio_readdev shows me the following result. I don't quite
   understand if I still have an issue here, or if this is a calibration
   thing?

# iio_info 
Library version: 0.23 (git tag: v0.23)
Compiled with backends: local xml ip usb
IIO context created with local backend.
Backend version: 0.23 (git tag: v0.23)
Backend description string: Linux dut1138 6.6.21-lothar02 #3 SMP PREEMPT Wed Nov  6 21:21:14 UTC 2024 aarch64
IIO context has 2 attributes:
	local,kernel: 6.6.21-lothar02
	uri: local:
IIO context has 1 devices:
	iio:device0: adxl345 (buffer capable)
		3 channels found:
			accel_x:  (input, index: 0, format: le:s13/16>>0)
			4 channel-specific attributes found:
				attr  0: calibbias value: 0
				attr  1: raw value: -14                          <--- CHANGES
				attr  2: sampling_frequency value: 100.000000000
				attr  3: scale value: 0.038300
			accel_y:  (input, index: 1, format: le:s13/16>>0)
			4 channel-specific attributes found:
				attr  0: calibbias value: 0
				attr  1: raw value: 6                            <--- CHANGES
				attr  2: sampling_frequency value: 100.000000000
				attr  3: scale value: 0.038300
			accel_z:  (input, index: 2, format: le:s13/16>>0)
			4 channel-specific attributes found:
				attr  0: calibbias value: 0
				attr  1: raw value: 247                          <--- CHANGES
				attr  2: sampling_frequency value: 100.000000000
				attr  3: scale value: 0.038300
		2 device-specific attributes found:
				attr  0: sampling_frequency_available value: 0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200
				attr  1: waiting_for_supplier value: 0
		3 buffer-specific attributes found:
				attr  0: data_available value: 13
				attr  1: direction value: in
				attr  2: watermark value: 15
		No trigger on this device

  Above I marked what keeps changing with "CHANGES", that's what I expect. Then with readdev
  I obtain the following result.

# iio_attr -c adxl345
dev 'adxl345', channel 'accel_x' (input, index: 0, format: le:s13/16>>0), found 4 channel-specific attributes
dev 'adxl345', channel 'accel_y' (input, index: 1, format: le:s13/16>>0), found 4 channel-specific attributes
dev 'adxl345', channel 'accel_z' (input, index: 2, format: le:s13/16>>0), found 4 channel-specific attributes
# echo 1 > ./scan_elements/in_accel_x_en
# echo 1 > ./scan_elements/in_accel_y_en
# echo 1 > ./scan_elements/in_accel_z_en
# echo 32 > ./buffer0/length
# echo 15 > ./buffer0/watermark
# echo 1 > ./buffer0/enable
# iio_readdev -b 16 -s 21 adxl345 > samples.dat
# hexdump -d ./samples.dat 
0000000   65523   00006   00248   65523   00005   00235   65522   00006
0000010   00248   65522   00006   00248   65521   00005   00247   65522
0000020   00007   00249   65523   00005   00249   65521   00006   00248
0000030   65522   00006   00248   65522   00006   00250   65522   00006
0000040   00249   65522   00005   00248   65523   00005   00248   65521
0000050   00007   00248   65521   00006   00250   65522   00005   00248
0000060   65521   00006   00248   65522   00007   00247   65522   00006
0000070   00248   65522   00006   00248   65521   00004   00250        
000007e

  Am I doing this actually correctly?

---
v4 -> v5:
- fix dt-binding for enum array of INT1 and INT2
v3 -> v4:
- fix dt-binding indention 
v2 -> v3:
- reorganize commits, merge the watermark handling
- INT lines are defined by binding
- kfifo is prepared by devm_iio_kfifo_buffer_setup()
- event handler is registered w/ devm_request_threaded_irq()
v1 -> v2:
Fix comments according to Documentation/doc-guide/kernel-doc.rst
and missing static declaration of function.
---
Lothar Rubusch (10):
  iio: accel: adxl345: refrase comment on probe
  iio: accel: adxl345: rename variable data to st
  iio: accel: adxl345: measure right-justified
  iio: accel: adxl345: add function to switch measuring mode
  iio: accel: adxl345: complete list of defines
  dt-bindings: iio: accel: add interrupt-names
  iio: accel: adxl345: introduce interrupt handling
  iio: accel: adxl345: initialize FIFO delay value for SPI
  iio: accel: adxl345: prepare channel for scan_index
  iio: accel: adxl345: add FIFO with watermark events

 .../bindings/iio/accel/adi,adxl345.yaml       |   7 +
 drivers/iio/accel/adxl345.h                   |  90 +++-
 drivers/iio/accel/adxl345_core.c              | 427 ++++++++++++++++--
 drivers/iio/accel/adxl345_i2c.c               |   2 +-
 drivers/iio/accel/adxl345_spi.c               |   7 +-
 5 files changed, 478 insertions(+), 55 deletions(-)

-- 
2.39.2


