Return-Path: <linux-iio+bounces-22024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30354B129E9
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 11:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B1543A13
	for <lists+linux-iio@lfdr.de>; Sat, 26 Jul 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB130225765;
	Sat, 26 Jul 2025 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe4jMlYp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422A121A454;
	Sat, 26 Jul 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753522647; cv=none; b=OMsB2TX0aPo95SGGGNA1gYk51u8r2JW3EFAw5Kk+zUVf0/TakHygUnTZuuo+1adQL7YSug8BKhUVoFngBZUE9JnlbLXERDXsQUq5uQqljIeEhqdZHl5PeH/ww9zH/WhsbyycEwcHUJlfeZS7z7U9t6TvDEoUnlczR9DHInnGV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753522647; c=relaxed/simple;
	bh=HZJItFO5v1KTeDFfBPFn9NFFCpaHpHGdOuQEO5QgCIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TgTt7Q/IywbvSr0natweP+tIJeYP1M4m2AsiAICG6pv14vQIFGqwBX9haS6E7tjr54t4uE7S0EBK4U75MEcFr5s7HiTqPwY9p1PQsjiFF/eyDKwvvBUOdb9cDUqS9yOh2HKN7ve4k7YXksH8l+7TritjdepZQQPWcu4gIBiVUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe4jMlYp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dc5bcf49eso38740525ad.2;
        Sat, 26 Jul 2025 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753522645; x=1754127445; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+2Wli+If3WVdydm2CsANzBSUuyS4c3jgEWOpEwtWgc=;
        b=Qe4jMlYpStHPbZA1bhh3B2Z7Wii8VYg1LfVwcmOv+c+4fSPnM1iqQUL7i8TNj+IE4U
         Ass7TT0lDLJM9jCa84YjB+QD9jAqBlhjF/cD7xO2dhHcCBeS5T6JkOGHsv1Tne7Ig8lc
         Cr0WWTl1TBmJ3tkaLz5CQBMU2zW8G7JWrHpygJ6JjzYGV08HWBqFvqpYweuno1gy/iIt
         eHCgKk1Yy2NrqVNr4nEZAe5Idtwc+1WLhuJYVdtgo91tbb+5fcYMdJTJNQ8OGsHUf+Bj
         LxzjI9BU2/U/WhTAwnyj598NycSN5OVQsFFUpsBy7k7rCt4uKNgjhW1AdP8dg9hN2bnZ
         DfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753522645; x=1754127445;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+2Wli+If3WVdydm2CsANzBSUuyS4c3jgEWOpEwtWgc=;
        b=bw3oE0WPlsO9mYRPtq/CjVXUdVTmJ1qbl4zNHnJf3SakVxyAq9QD8KJvOFbuDKbtr2
         lGKsgGYSpa6gUFX+aW8XhVZQ3E0piLfqvOjUwjQIKvPOvPQidYDeCVZYS+sPZ/8cKNeq
         xCG55gks51IRJBypOz4vFk4JL3Ig+WdneJdKXkV9ukBhY4RFeI2VSeZVfSP9heXqvg8t
         5sbOCVKixHpmJibfVZV/svOpR0IjXIDpgU97ucjvOK9ZUmvL4oJwj63vLMXHNNrr80YU
         2pQN8XQOvRC/F50mgUNQqCuOzY2nynzyFUoeY/E8HLwwMWGp6yAak5U/OOULMM4ImFBi
         b3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUVKa+u3PQH3KONlhVbl11napDMuPwgoM2EddZOMfVbHK/hh9ZZ2gnljQSO1cZVfAFRj/ugBbjsooxQ@vger.kernel.org, AJvYcCXml9XHTrRobWuuuiCp4qWd8rUNTq4tcuJDkAFAJuhCw5q2pc21vworApswLKrCs9e2XoCC7FRmJNMv@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuaKICImSgaakmWb/FSlVeT4FGfSIGQZHbkxlLgQHMkkHAjbV
	5L9dF3AkD8Mxar/qvBxYsHakQbASIYvEUme+9bNIaOTUozC9WdvTFBLjz3WcVVQx
X-Gm-Gg: ASbGncvy49KfAFutfV/qUUqx1CoF9LoD6xdHjLi4B2OA+RyEylzGn405T9DOvMfk3BV
	9EhGPuNMMluFtSNlM+zipJKc2CeF2RFq8fqQfVCPjg1kUgXmNSuYJ0DeDmh4Xpc5zDmoOAAnV0Z
	XYYegyABNFXqsjKFYCWSULnweOdDFO32aK2WFTV9XyEAqAWrNsT0PYIAouYXTaebu6KyDqTDz51
	3wP3ANzENPLkqQDnUoRncHfPQIiz1rbu97dUAY3aVk+cr9DL3Gny/U6nMFnH7RL59oVuCZIKeFJ
	yrZfrYV1lxku4yVndOEu/ZfbXIOhe4KhpJfffyxfVYcwW8+mwRqcIjkeyvy6SO4rwAXM5n/uP76
	fizjbTbYGiL/InbNqFRbsLfVnVqmSLXw=
X-Google-Smtp-Source: AGHT+IGuIPHUxlOttJhaYN8o4ugM+H6lr7gNk5jl8cpgvUz+RhW/97dYRiuLbXAsuZbVilNF0TcQxA==
X-Received: by 2002:a17:902:c950:b0:23d:ce98:6110 with SMTP id d9443c01a7336-23fb30657f9mr81987075ad.10.1753522645241;
        Sat, 26 Jul 2025 02:37:25 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c7e:9097:1e31:2e60:cd61:c2c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30ff62sm14038745ad.38.2025.07.26.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 02:37:24 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Subject: [PATCH 0/2] iio: magnetometer: add support for Infineon TLV493D 3D
 Magnetic Sensor
Date: Sat, 26 Jul 2025 15:07:00 +0530
Message-Id: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALyhhGgC/x3M0QqDMAxA0V+RPC/QxtnO/coQ2Wp0gVFHMoog/
 rtlj+fh3h2MVdjg3uygXMRkzRX+0kB6P/PCKFM1kKPORQr4+5Rr305onG1VLGH0ATV16G8penJ
 9+6IINf8qz7L914/hOE58/WhdagAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753522640; l=2089;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=HZJItFO5v1KTeDFfBPFn9NFFCpaHpHGdOuQEO5QgCIA=;
 b=X2QH3zxxnRRQX1eMit44OA/5Ls+vR/KfuEecqmhqA1WvnR0jAFMHOFThkPsVMKuQ14hxCmdQr
 usQzeDK184aA1qlAIUdrPzrjXOgQeEnL1JrtTOYz/ItsPTBz4vZ6Tty
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
applications includes joysticks, control elements (white goods,
multifunction knops), or electric meters (anti tampering) and any
other application that requires accurate angular measurements at
low power consumptions.

The Sensor is configured over I2C, and as part of Sensor measurement
data it provides 3-Axis magnetic fields and temperature core measurement.

The driver supports raw value read and buffered input via external trigger
to allow streaming values with the same sensing timestamp.

The device can be configured in to different operating modes by optional
device-tree "mode" property. Also, the temperature sensing part requires
raw offset captured at 25°C and that can be specified by "temp-offset"
optional device-tree property.

While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
configurations interrupt(INT) is not recommended, unless timing constraints
between I2C data transfers and interrupt pulses are monitored and aligned.

The Sensor's I2C register map and mode information is described in product
User Manual[1].

Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
[1] https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
Dixit Parmar (2):
      iio: magnetometer: add support for Infineon TLV493D 3D Magentic sensor
      dt-bindings: iio: magnetometer: document Infineon TLV493D 3D Magnetic sensor

 .../iio/magnetometer/infineon,tlv493d.yaml         |  57 ++
 drivers/iio/magnetometer/Kconfig                   |  14 +
 drivers/iio/magnetometer/Makefile                  |   2 +
 drivers/iio/magnetometer/tlv493d.c                 | 606 +++++++++++++++++++++
 4 files changed, 679 insertions(+)
---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250726-tlv493d-sensor-v6_16-rc5-18c712093b27

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


