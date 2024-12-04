Return-Path: <linux-iio+bounces-13090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2509A9E4346
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EA5167573
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3B1A8F95;
	Wed,  4 Dec 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWZA9aG8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C01A8F94;
	Wed,  4 Dec 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336707; cv=none; b=fWJlBCNuiPzMjlpEg94BzSnSkxqD9wGZ8VHolZHjTHDTRVgvV6YkjN3EqSLi8MGbR6UxdKl5gPi3nSKSm3rdCJ/ATppoMSdzP8W8++48uRvD4Z55YDddqGD6tF1qEIw8A01QO24mrM9cP/6M6C+D9Y2yWYraSVQu3NJjJDY3VRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336707; c=relaxed/simple;
	bh=rCVMBqnStLY3qm4PnXf8uP4XjudT7deIC3HE1cIpCbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ommTj6W0oDBewS7Qr7VIzFW/x5eB4C8GktIhKSyro4aOg6Amk79eY31m1wcIkPjn+Hdba2KY9F6EFxvZ6g4YGsL7QMaXqVaDDQcCI4ZpGNw08sghP/UZCLXvV5PNsT9cTfMBxPRttW7rCSsUL9KW/8VXq0HS7Pc9tMrJLiUyI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWZA9aG8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434941aac88so81865e9.3;
        Wed, 04 Dec 2024 10:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336703; x=1733941503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSkc2gHIBCz0xgSC3qe6gBqIO9a+mdMV2HVXy8SlqeE=;
        b=QWZA9aG8cW20EbTU8Ij0u5SHlHi2KtxheNCy+Z5RhShpEYz5tE+QMXhu/UDiFxTCMT
         sNO2HM7l7hoxusI9EbrjfflSSkss2/32HMvxVL0HcJHbd11sveXwalrRibFjOMzlRhST
         dbBR8WaUF/e1Ni8Xml1qkSWHY62EaqQj7cXki07ItCB6xejpcquaRPPBZVTbE7ajzdcV
         Wgc+4X6NTRQjhvMr8Dtbp3Elzf0lSog/HoI9NBO/zib4mgKPx/ZgFVYcZ8DMtXxFyaFk
         +xPagXq1p5FToaaQThDpJjDbWBqQONv7FsauwRBiK830wo49Cb2ZbHeiLMJS0dNRQlXn
         vCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336703; x=1733941503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSkc2gHIBCz0xgSC3qe6gBqIO9a+mdMV2HVXy8SlqeE=;
        b=gdleBVbnzj8EozLMCdVWplrU74qRvPa71pVRY7KaoqrNGrwk0FBdT3rratAOhprKo3
         cxTEJzoZKx2ElDus0DJDpfduAK+57QcvqA7kx8owj+x+u6LCByyqdQTH76cSNzppLcN2
         b1A4diVgR2JbleZpuhWNdDJfmxLC9EzADdIh7+ZMmEPXyf3vkuylSDEaVNe3eDQQkN+9
         r5DPgSUYBqyLFx6HJOGfCd02NiWOYXYqkIvUAGamuRPhZb1KdDUd63/Zz4Duw7wO6H6u
         S5u/L3I+g1G1IIO3er7muAPGMi+qTqrV5raABshOOMTzFwKHfRsMPEWLSYK3+zz5YS16
         mw+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7BUbFT+TsHgCN7UrbMQj8ZcMqvfr8NQReeaT2raMKrqKJk3a84Wj/g2X+hcKujTugfaooJ9AX+B9ZfnxK@vger.kernel.org, AJvYcCVsq/Kx9P3sfFBnRGMb/Q0xYlQe5GwGa8tE0jznpeOQcskt19HBXPOM4xtIC/TtdZkErUUfbrYWRtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYVTSbB/eK/jihPYablSSSh2ZerX5PSAUO5OIaRd2CIGqQIfD
	KCZjVMEpcHDF55alUFngITxJcYnW8RycyFhNHgHYfBmyoHV3QPAD
X-Gm-Gg: ASbGnctxA0gYqAiaD4tLppeXGRz0FhZo4OeI/KVosoqsfbcasuai4M53Z+87kV2NSDZ
	EjQrwLxqL7z7rkDkO/6x8prjA8Glk1c5cVgM8lEu/bd51IJbV0FKOXuCSw/FW/sW5723b4wg7CT
	UC16F8gnF01NpnJoaxFuKiGqwdEnLjmtoMMGy4pQF3dRrQtM8IbFOn2l0uzVNJbIo8n9525JVbv
	fkHyNfGAHMveP5TQh/ynUi71pXADTdsnb7ENd/v53l8ctIUx9Ok/ppf+wDCKcmm1xQ4c37BFcgk
	8XBLhSBU7n62LNHWHZrNufHRS6cm
X-Google-Smtp-Source: AGHT+IFNcbLJSjmhpB6hkL+6qxzuReQCQM469QVqn9tbZH81b+OFd7Z5wbvAMU3zb359lkFeYdu48w==
X-Received: by 2002:a05:600c:450c:b0:431:5632:448d with SMTP id 5b1f17b1804b1-434d0a3568cmr27401665e9.9.1733336703095;
        Wed, 04 Dec 2024 10:25:03 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:02 -0800 (PST)
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
Subject: [PATCH v4 00/10] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Wed,  4 Dec 2024 18:24:41 +0000
Message-Id: <20241204182451.144381-1-l.rubusch@gmail.com>
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
v3 -> v4: fix kernel-doc warning; fix dt-binding indention
v2 -> v3: Implementation reworked and simplified
          - INT lines are defined by binding
          - kfifo is prepared by devm_iio_kfifo_buffer_setup()
          - event handler is registered w/ devm_request_threaded_irq()
v1 -> v2: Fix comments according to Documentation/doc-guide/kernel-doc.rst
          and missing static declaration of function.
---
Lothar Rubusch (10):
  iio: accel: adxl345: fix comment on probe
  iio: accel: adxl345: rename variable data to st
  iio: accel: adxl345: measure right-justified
  iio: accel: adxl345: add function to switch measuring
  iio: accel: adxl345: extend list of defines
  dt-bindings: iio: accel: add interrupt-names
  iio: accel: adxl345: initialize IRQ number
  iio: accel: adxl345: initialize FIFO delay value for SPI
  iio: accel: adxl345: prepare channel for scan_index
  iio: accel: adxl345: add kfifo with watermark

 .../bindings/iio/accel/adi,adxl345.yaml       |  11 +
 drivers/iio/accel/adxl345.h                   |  90 +++-
 drivers/iio/accel/adxl345_core.c              | 427 ++++++++++++++++--
 drivers/iio/accel/adxl345_i2c.c               |   2 +-
 drivers/iio/accel/adxl345_spi.c               |   7 +-
 5 files changed, 482 insertions(+), 55 deletions(-)

-- 
2.39.2


