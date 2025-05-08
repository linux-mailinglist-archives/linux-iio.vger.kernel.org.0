Return-Path: <linux-iio+bounces-19286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49882AAF958
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4969C410B
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BD2224AE4;
	Thu,  8 May 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhmy93RK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFD211299;
	Thu,  8 May 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706113; cv=none; b=B8KUY2itHShYyCimiI6ahLyHzEIoQpZcnY8Q/2VF/COzEPosqpc11CFZqpmzqSu2AGJMPE39nqSbwr5WoURTVMTR2/Vtp3Fhym8gna8FYv60dm8RVUhezLAwjdBFVjQqdeTlxtYMJyLs/OCZxKm/2AldOZKWZWu4kRIcOBkH4dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706113; c=relaxed/simple;
	bh=oHtkdjxDgK6TVWT/yqF4Chd3hXrisjppZ1qS0Nc7Oag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tvdjHtV2uOb+xeR6GpUAGhsXu1K44/eSOlWFj3eB1HV3YV6ZAnWGh/BbrhcMj2hdqng2M0fZtts2TjFx4zpqEDaalBjFzGV5Fwuv6S0Co4G5ZRifPH5o0JHwKDsJTXFkPkVnyk1ZufJDR/yawszlKfkts/W7tW3nWm4d9Y2ki+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhmy93RK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so1903109b3a.0;
        Thu, 08 May 2025 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746706111; x=1747310911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHtkdjxDgK6TVWT/yqF4Chd3hXrisjppZ1qS0Nc7Oag=;
        b=Xhmy93RKVoCjHieHlhIC9FTVjTRKjVrB3zHSoMNET5Pjex9HdTl2L7TEremdwvcM6k
         DoaXW2Kgftd3rMHB0QYVi/CmDhlSe09n3sOvZJdghdci1ITANpgJGtOd6gMetbyjE2bM
         o7v99oiVe2HpWqkfIiy+ej0n0x9Ios3r5b5Hf8UJ0slce6zPuWZKL/1UdNUgI8R9L9rp
         YmzMKhnjMEw/U251lrvDIbjGamvycEspaDE2FG0rgqBB6romciaa8++84Bpno//94dSN
         ZN/5uxtcXB3qGnpeTMBRrWQJTrHDhEY+daUzLKRvVNBsSA9AgWQ7YjK9X7AO6kPdLcpq
         bm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706111; x=1747310911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHtkdjxDgK6TVWT/yqF4Chd3hXrisjppZ1qS0Nc7Oag=;
        b=K5LNYNHKENQkbuGogSfYR6kcD5mvenLPi4lQAQtASC52AHRzm5dK5qqxPoC7zf6opT
         jJ3uoZit6nJ7fw5EX1RnlNsmdP+suwFj8McPxx7hzYBdqAp+XG2CTDdhdQFVtoD3vtLY
         ZebBBsAa1OqFhsz6elYjTNAjtqcFSbsz4MxG/LcsV8HkIeQureR3M6Xia4gYllHpAQdD
         QH764XW8PyUiiW30TbbEh1FbZLrUJ5+Ktn8g8GQ9jq873d3S1kwJbopTJpj0rzge8x9x
         zDYrLOuiiGF2pIoqw6yyn74mGDkLcxf8EuwU9yhMapemwsPHRtLrN+HSgTAFzbpSgpGY
         K1Og==
X-Forwarded-Encrypted: i=1; AJvYcCUpL2/lgEG5Oe6uGS5J02ERYjQzH+v4GsLDhUgsCDXBphLJVNiiqunw00QfjnB8IpyfAknv1XKBhqU=@vger.kernel.org, AJvYcCWy0CL1aEdxnkVH2/cYjX6JRhdgtz/kmu4Hlf7PUsI0e6DT4U5+5pkCPCEx/kWugkwPuXwhataeHRTeovSk@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWu4Kv1O+TBdDg7lTBF2kaGVUs2VkS05daNx84OhxAL3PFIc7
	H0dbvaH4vY1Ped+5cGalNJvPFH8G0eFlLOhq+JabqOlRj+BYy9gc
X-Gm-Gg: ASbGncsBqHj8+ZjoSSp7UfPhDq2oD15Egw7mvg+z9HRjDv8OXtHaf1PEvtQXC9Wdgqe
	C29PxO2tSglwlLtMvOZzCEay65JoOw3ErITmPbRzleV4XbtwBQjlRoWcZZRETZuvpmTP/jbAq24
	EwpHM7zj6UYx8vIVwAghN1MYUPsUsGSTyze2e/TZYZ9kWE/69qKJ02QM6Ov9zYrwyYGeoQGEKo0
	rZZAw/jfGL4nOZMH8e2fUCNCnprUIENEQZ6qLDdt6oTDhcLDwwIS5+pnnrtN2Z8hTkMJ164V5d7
	TTlaExHypDAnk7JYamOlTQXUs0r7bM4CquAjvdphJ4l8rr1xoKHwE2/60NB8
X-Google-Smtp-Source: AGHT+IGA+n10sLwJnUU1sYloDcc67Hb3+yHrhPRytIfgGwk0DJIPCcVZFNF/4KfwBPAygGFhtmrH5Q==
X-Received: by 2002:a05:6a21:c8c:b0:1f5:8cf7:de4b with SMTP id adf61e73a8af0-2159a03a172mr4696389637.16.1746706110797;
        Thu, 08 May 2025 05:08:30 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7415d1114e6sm572188b3a.37.2025.05.08.05.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:08:30 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v2 0/5] iio: magnetometer: Add QMC5883L driver support
Date: Thu,  8 May 2025 13:08:22 +0100
Message-Id: <20250508120822.114060-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces support for the QST QMC5883L 3-axis magnetometer,
a magnetic sensor with I2C interface.

The implementation follows standard IIO conventions and includes:

Patch 1/5: dt-bindings: vendor-prefixes
- Adds 'qst' prefix for QST Corporation

Patch 2/5: dt-bindings: iio: magnetometer - Adds QMC5883L bindings
- Adds compatible string and required properties
- Includes example device tree node

Patch 3/5: iio: magnetometer - Base driver implementation
- Basic register access via regmap
- X/Y/Z axis and temperature readings
- Triggered buffer support
- Initialization and core functionality

Patch 4/5: Extended sysfs attributes and configuration
- ODR (10-200Hz) and FSR (±2G/±8G) control
- Mode selection (standby/continuous)
- Oversampling ratio configuration (512-64)
- Status monitoring (DRDY/OVL flags)
- Available scale and sampling frequency attributes

Patch 5/5: Advanced features and power management
- Mount matrix support for orientation compensation
- Power management (suspend/resume)
- Control register features (soft reset, pointer rollover)

The driver has been tested on a Raspberry Pi 5 and all features have been verified.

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>

