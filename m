Return-Path: <linux-iio+bounces-773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD9C80B3C8
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 11:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2EB1C20A36
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7FF134D8;
	Sat,  9 Dec 2023 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMh5BhGj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606ED122;
	Sat,  9 Dec 2023 02:52:31 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id e9e14a558f8ab-35d67599613so15421115ab.3;
        Sat, 09 Dec 2023 02:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702119151; x=1702723951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9jpQ1esf8wYzQRP1mhv9nZl5/4+nkS8aLHoZ3EEp1I=;
        b=HMh5BhGjKbjWse7ny0pobhZRQMx1LCwsHaFYESZmyP9aLP2MpJZlobmAWYYhoT8zzp
         1mpjK61U5B4Zikw2gf/csmdacoJ8HURlDq99q06UYprFJBQWqgOgm5Y5rmT8lWz141fK
         odgZFwxM8Koc7Kfg4sJQbwpZOm69eDcQVnWbhJO7PIXkgHzLgeue7jCm/d8T96M07yij
         RH7nSpNshNA8CLpISxwFWGgI2t1VPK8LosVt0om4HQbVwH6IN9w+VQYFvNKSUc6yeD5V
         1x1VHgFLUaEa+6oEB/j/RredK3KsPYUvHuNCoW4QgvSnfXD3Odtq9SQH5ZQjT3fAljMF
         qqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119151; x=1702723951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9jpQ1esf8wYzQRP1mhv9nZl5/4+nkS8aLHoZ3EEp1I=;
        b=CrWozlQcGI4e2KXatC02BCj6+0b99R184Xd7iYJCCLVMqvhexcm0ZL5+BJqjCMwK54
         vPSerCTeO1ld0oHGsSYgPptORTQ27yEx9VwVihbt58MImjNDmZrvyuVbYWvQycwq4ZdO
         zXw2A0e3rOYJ5GylNCNxEMlk+UzPHJPGTHyNnVAbMIvL0lHbDpHyT0r67H066ykhxdiw
         F3RWQbP4GSdUmOgd7NsekeKVLgnh85bKOUU2nWqRW7xdnFIYbaOkDYuOAJ+WF0lildNx
         o+EPAj02Cr6JjF6ycCXLsj4fBjJwCs32Gq1Y0YBvXJzR4+778GRZBnz2xtncZKhMdvW5
         Geeg==
X-Gm-Message-State: AOJu0Yz8FqmOTA2rPeY7WNzNAfu4yA7mb4QXRCSaVvXogqTo4BknKQdg
	wQ4LDvPmEkLJEg05S2XZtqIYhnlCjj/Vd9pk
X-Google-Smtp-Source: AGHT+IFBuNvY04UK5LOUw4CnTRtGbWsBdQbrc7vuxrwgfT6byHEuRUSajYbv4pxqSGsqUI87FLgH4A==
X-Received: by 2002:a05:6e02:1bc6:b0:35d:690d:9996 with SMTP id x6-20020a056e021bc600b0035d690d9996mr2038366ilv.3.1702119150365;
        Sat, 09 Dec 2023 02:52:30 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.111.112])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709027b8e00b001d0ced578aasm3153424pll.307.2023.12.09.02.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:52:29 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org
Cc: javier.carrasco.cruz@gmail.com,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Li peiyu <579lpy@gmail.com>
Subject: [PATCH v5 0/4] iio: humidity: Add driver for ti HDC302x humidity sensors
Date: Sat,  9 Dec 2023 18:52:17 +0800
Message-Id: <20231209105217.3630-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for HDC302x integrated capacitive based relative
humidity (RH) and temperature sensor.
This driver supports reading values, reading the maximum and
minimum of values and controlling the integrated heater of
the sensor.

Signed-off-by: Li peiyu <579lpy@gmail.com>
---
changes in v5:
	iio ABI:
	  - Document _TROUGH as an info element.
	sensor driver:
	  - Correct heater enable/disable commands
	  - Rearrang header files in alphabetical order.
	  - Change .info_mask_separate to BIT(IIO_CHAN_INFO_RAW). 
	  - Add details to mutex comment.
	  - Add error handling for chan->type in read_raw call.
	  - Remove error message for devm_iio_device_register.
changes in v4:
	iio core:
	  - Add an IIO_CHAN_INFO_TROUGH modifier for minimum values.
	iio ABI:
	  - Document the new _TROUGH modifier.
	sensor driver:
	  - Add MAINTAINERS.
	  - Use new IIO_CHAN_INFO_TROUGH modifier.
	  - Support the complete heater range.
	  - Remove measurement values from the data structure.
	  - Use guard(mutex)(...), make the code simpler
	  - Removed buffer mode and direct mode conversion code
	  - Minor coding-style fixes.
	dt-bindings:
	  - removed unnecessary example
	  - add vdd-supply to the example
changes in v3:
	sensor driver:
	  - Removed the custom ABI
	  - Give up calculating values in the driver
	  - Use read_avail callback to get available parameters
	  - Changed the scope of the lock to make the code more concise
	  - Fixed the code format issue
	dt-bindings:
	  - Use a fallback compatible
changes in v2:
	sensor driver:
	  - Added static modification to global variables
	  - change the methord to read peak value
	dt-bindings:
	  - change the maintainers to me.
	  - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
	  - change the node name to humidity-sensor.

---
Javier Carrasco (2):
      iio: core: introduce trough modifier for minimum values
      iio: ABI: document temperature and humidity peak/trough raw attributes

Li peiyu (2):
      dt-bindings: iio: humidity: Add TI HDC302x support
      iio: humidity: Add driver for TI HDC302x humidity sensors

 Documentation/ABI/testing/sysfs-bus-iio            |  13 +-
 .../bindings/iio/humidity/ti,hdc3020.yaml          |  55 +++
 MAINTAINERS                                        |   8 +
 drivers/iio/humidity/Kconfig                       |  12 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc3020.c                     | 470 +++++++++++++++++++++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 8 files changed, 560 insertions(+), 1 deletion(-)
 ---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a

Best regards,

