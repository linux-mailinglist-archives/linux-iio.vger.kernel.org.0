Return-Path: <linux-iio+bounces-24675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E3BB5113
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 22:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5754E4AD7
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246127B326;
	Thu,  2 Oct 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHY80pDr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FECF27A904
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435356; cv=none; b=N/yhxY8+uydCC9X/ZzdPewHeYvkke56Ri4OdGxCQtD+LDyrbGL22zeARYct+b/bx4UFKeSVpwXEKUi9Zc3a1CgFV3cJIKBQxHwcFWcKKX0S2ssxDPpn6ds3riMn4hd207H1tvwYbsQ9DwNS+N5xMg3gmLxcn5EhzPS/c1VeDMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435356; c=relaxed/simple;
	bh=xVF6uBTsNOuoncIDY4GGFCtpkZNheofPiI9IZgBwSts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SGHaUC2WSzCyZGFY2YZFzWXeRAnZqXVmdqmeY7IZKblX7KcLAIjLP+w5GG5T5rrv321xXpcArEP2+O3nArJ1ssitGaa4+XQJpEujoaD06o0OzCYzcomkkNNOF0vvyRdpAxhNF3PucbIONTdcCXqSEFXhjz+Y4b1fY1HoAU2obxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHY80pDr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b463f986f80so326210166b.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759435353; x=1760040153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVyNI0gXBFUjZBPH919ULvwbDTjaxSZgjrVkrWiBCU4=;
        b=UHY80pDrDCwlbI0e9ZJXhyYejJnxyz0vDEBcfK/RaYq8zhZrBMucgKbfNVnUpPQj7c
         GUNFAGctI5HTSJRyiw558dTuWA+NTgLxDYHtWpFqPJgs4fN3OKhwyJPqZJN5VzNIQr22
         ZDQZQKKTQi2DX8DLjDRgwBls79ymfc5bG7AiYg8OQhXtu6Ah8u7Ln1X4x7KpHaBvcA81
         h3pZ8gMAHFgmaFOHw0SLXlZCygk4oDJBaGQG377+6iwc8chwk8RR5d273jejIORu2Kp1
         Mm/Fe8tpTy0JW/YCYJ5B9q9nfAkq6FXTuTNX2xE1LHWS7g5wFDQoxjxwu1BkUpScqY5k
         I/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435353; x=1760040153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVyNI0gXBFUjZBPH919ULvwbDTjaxSZgjrVkrWiBCU4=;
        b=k0TksSFrkCxGyW71zFsDljLYV8P4Rap4a94YQJyrmKBvim2+00oOnehuWL3GnHi9to
         Y05PSMkCeIbvXkl4bQ/9qGj2LViuWvVrCzS2lpXBzswbzvqjl/BX+jC9BBkUiYpBP8WM
         YsmrGspguIBzDXgj8PRBb7aB0cE76u4mo4I9a2TQ5McLmc+t70AOgwz7mwErH+r2H0HK
         c4b1Ad/+3dUvJLiZjcZK8TBWttkcI8+DOFuRROlayg0fhaf9jZwHk0kJw8YsVVgIBXre
         cEhXu+sIbFxoUPKT1WZ8xGEPklwydPsj83jxaPkAvCVu/eohnZNad1c4ttNbSp0gMq/y
         5Drw==
X-Forwarded-Encrypted: i=1; AJvYcCXEokTA4SlCXXW8GYbBUmVjkE3DhCCOygLwko2Oh0phwXFde0IuojSjY5A8MBdFgv7/J/AzbwAn+zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ovXZnOov0tspRgW87r4gEKHuTa6LYREflLEqULxVOQvO+j7e
	Wv/DEvp4r8LJTvZxvBczgituOMXHgPKmFUpa7qv7aBNd09wK1k/WEzOK
X-Gm-Gg: ASbGnctr3i+lhItA6AOeBhtmqnGRpT7LKXKzYbXQKBk6ZK6qDPdA2BQojSjf0Khrzrb
	EoT+SKg7v8VcJxirlrSXGycdfeuv3dBYPf/pOzKmkLumD3QsVUmg278vEzzLW4XzWHGkVm1y/t+
	GX3BsVsbEsqeL4DFXZRj7GwnpsYqXsbjT7/lURzQiLrWwxZJAvG8U2W41GJ2s7hTwE7sDfgodqb
	KS+bQ6N0ZjHfUyFqjgnk6A3HRSkcuS+cM7MgHFhrWz59uWBUM/zo0OBMT3pFmFBc9kpgMdqsgyl
	d/fu90p/RwMR/5HR6gsmwpa+bWQXBCHgnkgeCB40GgkSlBapyph+lb17yjYC3C3Ac+y6jM1RCz+
	TivbzKVyZh6BzPC+s6tX0yzUzEAjYtNje56FK0v07WfMC
X-Google-Smtp-Source: AGHT+IGVdY7eibZkSuG0Fh9kUKdLddQgXSM6mCGIcobCn5pLW2B3OieE/FE1HPUgxC3t+DCYqrLqbg==
X-Received: by 2002:a17:907:7293:b0:b04:25e6:2ddc with SMTP id a640c23a62f3a-b49c038f7bfmr77117766b.8.1759435352310;
        Thu, 02 Oct 2025 13:02:32 -0700 (PDT)
Received: from localhost.localdomain ([78.212.167.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm270880466b.78.2025.10.02.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:02:31 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 0/5] iio: mpl3115: add support for DRDY interrupt
Date: Thu,  2 Oct 2025 22:02:01 +0200
Message-Id: <20251002200206.59824-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This set of patches adds support for the DRDY interrupt in the MPL3115
pressure sensor. The device has 2 interrupt lines, hence the new
binding. I also added support for the sampling frequency which
determines the time interval between subsequent measurements (in the
continuous measurements mode) so it's obiously tied to the DRDY
interrupt feature.

Kind regards,
Antoni Pokusinski

---
Changes since v3:
* P2: created mpl3115_fill_trig_buffer
* P2: trigger_handler: replaced scoped_guard with mutex_lock
* P2: includes: removed linux/cleanup.h

* P3: new patch: renamed MPL3115_CTRL_* macros to MPL3115_CTRL1_*

* P4: extracted the MPL3115_CTRL_* renames into a separate patch (P3 now)
* P4: trigger_probe: placed devm_request_threaded_irq() call before
                     devm_iio_trigger_register()
* P4: trigger_probe: removed switch(irq_cfg_flags) together with the
                     enum mpl3115_irq_type and added 2 separate
                     variables to handle interrupt setup logic 
* P4: set_trigger_state: factored out the CTRL_REG1 and CTRL_REG4 writes 
                         into a separate function mpl3115_config_interrupt

* P5: samp_freq_table: added spaces before "},"

Changes since v2:
* P4: included linux/bitfield.h

Changes since v1:
* P1: add `vdd-supply` and `vddio-supply`

* P2: new patch: use guards from cleanup.h   

* P3: change macros of control register bits to convention
      MPL3115_CTRLX_NAME
* P3: MPL3115_PT_DATA_EVENT_ALL: use GENMASK
* P3: trigger_probe: do not fail if dev_fwnode() returns NULL
* P3: trigger_probe: use devm_iio_trigger_register()
* P3: trigger_probe: introduced enum mpl3115_irq_type and 
      changed IRQ setup logic accordingly

* P4: MPL3115_CTRL2_ST: use GENMASK
* P4: read_raw: samp_freq: use FIELD_GET
* P4: write_raw: samp_freq: use FIELD_PREP
---

Antoni Pokusinski (5):
  dt-bindings: iio: pressure: add binding for mpl3115
  iio: mpl3115: add separate function for triggered buffer data
    collection
  iio: mpl3115: rename CTRL_REG1 field macros
  iio: mpl3115: add support for DRDY interrupt
  iio: mpl3115: add support for sampling frequency

 .../bindings/iio/pressure/fsl,mpl3115.yaml    |  71 ++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/pressure/mpl3115.c                | 331 ++++++++++++++++--
 3 files changed, 364 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

-- 
2.25.1


