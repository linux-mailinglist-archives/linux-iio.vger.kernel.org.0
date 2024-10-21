Return-Path: <linux-iio+bounces-10892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD59A9039
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB5A1C22A13
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D91CF291;
	Mon, 21 Oct 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar40kziH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E21C68AC;
	Mon, 21 Oct 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540404; cv=none; b=fSRQOrQ3n/LItAqFeE/6HpLqvOWiiOPdo1TZkk9c9UpMns7JVlp0Gnh5ljYG/DH/2wwpFjAnug/l+tSOU8ZdHNKW9bSaQh4jUoVVwwvEZQk25O8dZo1n4+tR0QU9Nxm1pb2003prRNYSLOl6MKAGYSsM4KTnKJ5KZTOZXGNzTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540404; c=relaxed/simple;
	bh=1ODOQKyatQ9aosi/Ebuhj+1MZLUlp4wf/eNSuDHF7nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PWe8axWbOHwLQ/JuhvJyI4rpUBw6IhDbO2CmOx7DR9gS5oXzb+NaTtMJyAaZjhFVt51s7wFWrHaAL08OKC1U1n6evu38mrWj70mLMS5mz6UwtdaXo544ssx0Zk3TNPzn899QDW13V9xPK4PVcoYyWNA00upLVxUp+HAsYqads5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar40kziH; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so48597761fa.3;
        Mon, 21 Oct 2024 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540401; x=1730145201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+IFLjRjd7myM3ODT1z2z8w2/OGdry3PTB9Rc7SaXbE=;
        b=Ar40kziHcvjYoZ4Ou6DGWbYX/+wg2Zo4ih4B0NtroQDyU60gw21wVw7xzMNI0UK8l1
         tFEop6ZTgQaEauZCmwtNFdPmRRmLQSexjOrUt3SkV0rBxKYwb+vlYAXYrLEXSkiF+fKz
         ykfFxqRAQKM05kPABLNcWlYeTttd3q0SYzuNy6rZtHLL3ORkDgoQm8I42qA3oOF6XGyU
         w1P56elv3peDCsHc/5JVvsQN2v3XJtqii53Trskd0PwxPjS53+07l7Z7KfjyVF49wDPX
         XswYaJTaKfkFJdVBvUzLPDqQqWfUwngUEEyo8Bc/E6FdO0Xyu1np3ul8zWXnxgamlqMi
         IWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540401; x=1730145201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+IFLjRjd7myM3ODT1z2z8w2/OGdry3PTB9Rc7SaXbE=;
        b=bqUe3JpFKiVnWmFfiuywi6W0pPZZDwDappv8QoGlRKSSUXbdVxgAEJ4WQc4WeXvuaL
         CKGTYA5fvuq3R7Fhvo4ThtXo6KwAznNWvMfc2VtV8267wPo2CzhY4YS/4oJx/TMHdpTc
         yF5/NNdBxkoSwbW+CPxx+0fszAHFYTFwyMWfo7fYYqL6L7h8M+QjfFu71dUPeKaQC3R8
         Dyj25BQn4GC+eToUI3ZprkVoh9jLlOg0LU41SDN42HEKFHP0r1CF3hRuy/qnb1AEZE0k
         QrqIwgnD0Ic0EpEXDve0R+UJJi+DCtJJHKCRp9cmsd12MVqa23OGzQoogMHaxbi4CFPq
         aidA==
X-Forwarded-Encrypted: i=1; AJvYcCULjzCa5TBYCixsQU0/y9P+TM9+nRvCJubLbE3cE0mqOkRPrY36Fcofxh/eQWWjtgoO2bcbhqDPvUHzyva+@vger.kernel.org, AJvYcCWdcM8gVSRfxUFkaT6jGprE/knDt0SCLDRMM0Pmwg6jM6WCnGt1dQYe0wqw/1WXv5aDCvn30Q45tfOB@vger.kernel.org, AJvYcCXBkMqdDyZpvzgZMFE9cGFoV9ydpAFPm6LTBQX9ZQyZ/dXPhUmFBs0LbBbmGn85CMOnqlXkyc8v33Gi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mD6rFkboJ7rx2BGZ2BreYhy5PmZ9sv5FDbaL/PESYv/pwx3y
	uTO5YIrApkCyXDep1GBhQqp7PDz8SfSgL5Mo/3HBJjRaCWmOeZMz
X-Google-Smtp-Source: AGHT+IE5reZAV5HNrGraupO5HA/2bG4D0HTEshCdhsCl4g3s/5Hw4xu5N6fZx2zPUx7gvwc21Cp2fA==
X-Received: by 2002:a2e:b8c6:0:b0:2fb:3c44:7f8b with SMTP id 38308e7fff4ca-2fb83226eb4mr57448761fa.43.1729540401091;
        Mon, 21 Oct 2024 12:53:21 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:19 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/13]: chemical: bme680: 2nd set of cleanup
Date: Mon, 21 Oct 2024 21:53:03 +0200
Message-ID: <20241021195316.58911-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

Generally, the patches were rearranged according to comments from Andy
in previous version in order to be more consistent. The refactoring of
the ambient temperature was dropped for now because it was a bit more
complicated than I thought and this series is already heavy enough.

[PATCH v2 01/13]:
	- New patch

[PATCH v2 02/13]:
	- v1 1/13
	- used "optimized" in commit message to not prompt for a fix.
	- added documentation of where this sleep comes from

[PATCH v2 03/13]:
	- v1 2/13
	- Fix indentation of array and removed extra whitespace.

[PATCH v2 04/13]:
	- v1 5/13
	- removed extra check inside the set_mode() function.

[PATCH v2 06/13]:
	- v1 1/13
	- removed indentation fixes which are fixed later since code is
	  changed in those lines in later commits.

[PATCH v2 09/13]:
	- v1 12/13
	- removed unnecessary debug messages
	- Used struture instead of buffer to push data to userspace

[PATCH v2 10/13]:
	- v1 13/13
	- used better naming
	- made channel index to -1

[PATCH v2 11/13]:
	- v1 06/13
	- removed device from trivial-devices

[PATCH v2 12/13]:
	- v1 07/13
	- use devm_regulator_bulk_get_enable()

[PATCH v2 13/13]:
	- v1 08/13
	- removed internal usage of dev structure
	- added missing header in both bme680_core.c and bme680.h
	- used devm_pm_runtime_enable

---
v1: https://lore.kernel.org/linux-iio/20241010210030.33309-1-vassilisamir@gmail.com

This patch series is continuing the work that started on [1] by
improving some small issues of the driver in the commits 1,2,3.

Commits 4,5 are refactorizing existing code.

Commits 6,7,8 are adding DT, regulator and PM support.

Commit 9 is refactorizing one macro to attribute.

Commit 10,11,12 are refactorizing the read/compensate functions
to become generic and add triggered buffer support.

Finally, commit 13 adds support for an *output* channel of type
IIO_CURRENT in order to preheat the plate that is used to measure the
quality of the air.

This and the previous series [1] started with the idea to add support
for the new bme688 device but due to the structure of the driver I
decided that it is better to restructure and improve some things before
adding extra funcitonalities.

[1]: https://lore.kernel.org/linux-iio/20240609233826.330516-1-vassilisamir@gmail.com

Vasileios Amoiridis (13):
  iio: chemical: bme680: Fix missing header
  iio: chemical: bme680: optimize startup time
  iio: chemical: bme680: avoid using camel case
  iio: chemical: bme680: refactorize set_mode() mode
  iio: chemical: bme680: move to fsleep()
  iio: chemical: bme680: Fix indentation and unnecessary spaces
  iio: chemical: bme680: generalize read_*() functions
  iio: chemical: bme680: Add SCALE and RAW channels
  iio: chemical: bme680: Add triggered buffer support
  iio: chemical: bme680: Add support for preheat current
  dt-bindings: iio: add binding for BME680 driver
  iio: chemical: bme680: add regulators
  iio: chemical: bme680: add power management

 .../bindings/iio/chemical/bosch,bme680.yaml   |  64 +++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/chemical/Kconfig                  |   2 +
 drivers/iio/chemical/bme680.h                 |  11 +-
 drivers/iio/chemical/bme680_core.c            | 505 +++++++++++++++---
 5 files changed, 508 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml

-- 
2.43.0


