Return-Path: <linux-iio+bounces-13044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E709E2DC0
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B519B35DCC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F062207A0F;
	Tue,  3 Dec 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URHxfmWO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961931B21AA;
	Tue,  3 Dec 2024 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259186; cv=none; b=BWD1M4dditj/lfnk+/HBmNAPMbzORWEUrcYLXOrnSZ+MkoODhfWgme+n9NlcLi52ouqYIxgkOOqj4D0JmSCFrMOxY45x1nhO2oSqxXDZi7Yyn7oUoQ1D9bVI1Yvq/LIJE4pyfHkX9rE+jOiJTyLxEo8+Nf+s1G3lx0g6VXOgB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259186; c=relaxed/simple;
	bh=Xh1HrFRQCcFhnCOCpCoeW+y2e4KcVSimwHdorrZTCF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QmgNCuJuFISB130lBBByL6fZiEnSc7vdgljCktFCwcgiNdpbrKWRX6mUVxdrR+ZbgNw4DCBU5tOVwhpu7bPmw3H2ur5wGNm7L1kBYpPpittdUhQMDJmSecm3OM5jRAhLfn+GisiPgSSYdLglPP2YNXMkuip7AVuBEzMOLs7phWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URHxfmWO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a0300d4cso5194665e9.3;
        Tue, 03 Dec 2024 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259183; x=1733863983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRV2TZX4MygrN+eP9YLgKwtwVCNWhxIUfzSzBMdRIzw=;
        b=URHxfmWOkcK8q36RTn9Z8iTokNqV5jAJ/XFuNgOeHurKiRt2ar9P1g70l6o00/cA8U
         /NrvWg/9E/xI+xMbt8ySPIOG7wEeoPT4c9RnQZZO8vcel+Vir0OuS7QEWzsQFrZiRfU1
         5RLkx+WOpHATzZaxQw3lkaW+GeTowfL/ZENxIhNF6PbTiM7mu99tJSxGK9yZsu5MXwCB
         Lrs/GPsGvNJFk9ZYYooIThxMpjYIklXewFiT4HIJkpHQaXHsUoQgEAs4ngwcetsIFfHJ
         HiC0WhCyEOKexujK1NK0Y6701jA41/zrEgH2j440/5QhAnJwgZmaeRM1tWPS6Vr0CE0Y
         oM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259183; x=1733863983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRV2TZX4MygrN+eP9YLgKwtwVCNWhxIUfzSzBMdRIzw=;
        b=avMGaIaRB2EyQsUFyRg2ao0jBCjCVAgp2s6gdECb2Je1oBGHFvd/cxrX6L/qMdR35W
         cFRg/6/B9g2Oi/cVLyG0ntCa+tBeDRPaDusnU5Ebg5eidXpHthhgMtw1vHNIYspi2Ywe
         2EEFWVMnLlS9b3lB/Lahh8HUkIINlJH7J2BIOCeT/DTtEjfdcWKfstu7HbAQQntzIvCI
         ouNZ4ynXUuj6D8llmQUgJCkksfp9lKYjT30y9kNqXl8rqBUfjMdWlAYv3pV4lJR7Zcv4
         jc0fzKfW/2jthV/yw56YUUBU+icV7BHrDMsYiSV0sQtLlKtNErYIScA6Q7nNO1B0i+kL
         7wiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzfqq76J9M6UeCcXZCWRSoS3aaDz6jJV5u/V+wNXeMErygKxrUPtjViKQuCWDO3T5hXXnNMrzGLvvx2zip@vger.kernel.org, AJvYcCW10dcVuPHq2Amh25EzKSE8hVRnLUfIhafWl6AjDoA1qWO1d/3SXoS7BajRpJs5fbNXMUZDltF8oNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNjQTD+pWn+UgZ3fnvzfeqASrVbo7gMvb9rCf9hbj1X0Y1kLN
	onHljwY+3cek2GQLGbTprjt3y8PM0rSuUDXlySJhqbGJKBznNvvJ8KFhHQ==
X-Gm-Gg: ASbGncsa4io/lUoDUXSzfChkB8StX7UNM73Sj82nHfVsJHkKvWI9vkAuDXKUTiFhDqM
	ZecaAvYBFhQBFVZet1jbUs5/bEhLzh397vIvZWCgIbZ/eqatx1Jqdsn0vAqdKfrAJNlZnz+9Lbg
	Xi3BMJFD2Y1Sz6a7GCnhmiNLTpzwBiLxcVIJbxSrzs2lqytKzJT+IaDsS62uGOt9+UB0bPf90/f
	CdKNGtAF7yhO26G/ZoATKp/KpUYRB2JOQUPhQGh5vYTpf722AnpGki2W5tE6Ku+mUL3yaTg9SJc
	ftiVf8EDvidUjd56AmKYdWkzF1xC
X-Google-Smtp-Source: AGHT+IFmd1HUA0v5RCa8SB5947dub215Ycyw9+q2q0pwAKi2vW9Vp2IIDTrDE+GdMXDAsEAnNeV+pQ==
X-Received: by 2002:a05:600c:1d16:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-434d11d0d28mr14167285e9.8.1733259182553;
        Tue, 03 Dec 2024 12:53:02 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:01 -0800 (PST)
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
Subject: [PATCH v3 00/10] iio: accel: adxl345: add FIFO operating with IRQ triggered watermark events
Date: Tue,  3 Dec 2024 20:52:31 +0000
Message-Id: <20241203205241.48077-1-l.rubusch@gmail.com>
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

 .../bindings/iio/accel/adi,adxl345.yaml       |  13 +
 drivers/iio/accel/adxl345.h                   |  90 +++-
 drivers/iio/accel/adxl345_core.c              | 427 ++++++++++++++++--
 drivers/iio/accel/adxl345_i2c.c               |   2 +-
 drivers/iio/accel/adxl345_spi.c               |   7 +-
 5 files changed, 484 insertions(+), 55 deletions(-)

-- 
2.39.5


