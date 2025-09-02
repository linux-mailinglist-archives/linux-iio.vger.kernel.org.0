Return-Path: <linux-iio+bounces-23640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA6BB4025F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2231B20CCE
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889703009EE;
	Tue,  2 Sep 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm1X+raz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6673002D7;
	Tue,  2 Sep 2025 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818944; cv=none; b=AzoUwfrP2WUnEKTaakutNTdeSA2iqj9Ynk8ZPIe5XFLMvjJL3sjs6CeisilApvdtEpbuTz+smVtlu65SRlO07958LK6i6tmq1m1u5laOYWg4mwXO8YBJAUwohU8S6T5gwnh2IQ3LVUgT1/JrP9sc2VzPTPIYev8HYdwCEmbq02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818944; c=relaxed/simple;
	bh=ztgLBSMDBFH/NfDqoN8XI5dCzKqff6wHVIL7v1u+0jI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q4dt5AQhbk13E5uyKIikFyh33GDkiOlMEtk2ww7IEia+fpmfHp/vxQ88QJcei4y4A/KWBa7S8Rj7YvUU9FwvtMe5mWb8FlOUIOGcCXRJafb2LXgA2aOu8XVOqi9KE8y3bHS1cd4X+CeMEfJA+p5cuoUvghWCsdXdfIXvV4fpWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm1X+raz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24457f581aeso49438425ad.0;
        Tue, 02 Sep 2025 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756818941; x=1757423741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNZsl58PvCfPstuNsgLSDaFhV+BtUsYO95KUUiejAeQ=;
        b=Lm1X+razSn/gnLhkakKeMVPpdn0iIbvhuuLpRj9tjfNXSSbD8mvw7rfWJ/Q0323+5y
         rkopSpjy+wBiuz5V8NUymfVyAbTx/SNphYchhQT27rws7EMWUVcPKsx7qf+5M62mgW63
         25QRphUcJGPa1Wdv2bL4U8PQVWlC6k+SBq1xpvZ7+Yk0Nsi/JBpwcxhBFH8OY71NRNNv
         gVeS8WwrbTRPJEM0gt36J8ASGt2jfzh5+SugrFuENDetzZqYAFmxJC1ai/erUrqaX0qV
         kr5p+RmjZG8nxxHpXGLu5hW0VJ0iTZErtGYLQ0gHHSJi31j0GANzAF+Rb6enZTD1xJxl
         Rl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818941; x=1757423741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNZsl58PvCfPstuNsgLSDaFhV+BtUsYO95KUUiejAeQ=;
        b=h8maSRbYuvYTzZkIbHBnGf2WDF8fYDIhatu0n7KeVi4dX4mOzQ5quf5N5w5GQ1nQZ/
         g9125EMdloQBjAXucQmT9iip1SZnntWHpQMjcGvhVufPPL3i2+GWhkBGUNEJNQgHfWaX
         0jURLy101cVbBBBGv9PAec9thOuW7/oadh/SJI+YDpA8Rdqbw8tRldvknOd3jG1b3neh
         vwo17p82pFnnAikpOED6iUaYxW5GebNEIJkfZPXqMCUkWs9QRT/aMqd2n8D+5QPlbxru
         Kt0gz7gj2JTRvBfwHttMgAYRvTimqETBIwW4Zy9kO803CNHdPj9Rp4lL6bsghtd/pBGk
         PBhw==
X-Forwarded-Encrypted: i=1; AJvYcCUA7XOHRV7zDmHTFnh2zNczqpanFgleq7uDqCTBJ8ufyfUaZuXiRpv7S0hRshXER0NZRK5RZkm3veAg2Agp@vger.kernel.org, AJvYcCXrcw/u7APis1v/Red8i7IYym8f9qjUUiG68b4fGslgbsig0SB1WypGU3Nu5Jz9FuIWbMv2fGm+O0zH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzjikyp7IVzA05j0emKbTFexQ8jV5avgw/4TexEBrEwRGfwBCj
	53VbFym7ch4kPMnHIS7z2IyP/NhBSgkymAe3Cc8cc1THHMUyqixjEI09mYZolewspuU8Yg==
X-Gm-Gg: ASbGncuvZb3d4B/pXTaBmzckgmervjpf5KuGztSd4vfKolk7/3KrwF94TrYUDIUjNKX
	BdElXKS1zj4T6TybIT2NAVeInFzr996jE6Yg74mzMMZLfNk8O6aBcqbBiVHqBLiyNnlBnsFU6Jq
	iCYoEaM/6t5yAT8tTRfZ+Yznruxi+LbK1jo/YjyTxFQtwckNdjiV9uDfzpoUiBSbMCz6g/1Vk3N
	Vo2sdaRYssUNWmBoxoGKUooY09X3YC1bzAtHzMaqueKRL9VPLj/DVApj5+Pbx3CaG9EyemyLTNq
	TYdKc8fhdxPTiSrsHRd/ShJ4NIzBTdkgl1dFCQ3JWxgud9jEa7A6ZqcqzvyYuFUBw+QarjLIE3l
	BdDe3FohutyXb5+TRS+7eJCGP9Po5qhF7LuQ7SLYMEO69
X-Google-Smtp-Source: AGHT+IHVnGMjOLn8pJNcVq7jmxqNTU4XuXIpfk1DNWBYLWSKmRPo4B3uQKgLKkdyi4hI9q2Hksu6QQ==
X-Received: by 2002:a17:903:28c:b0:248:fbec:7c99 with SMTP id d9443c01a7336-24944a7728bmr150182145ad.26.1756818941234;
        Tue, 02 Sep 2025 06:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:bc66:1b1c:d88:2aac:2997])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da4d44sm133710355ad.83.2025.09.02.06.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:15:40 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v10 0/2] Add MAX14001/MAX14002 support
Date: Tue,  2 Sep 2025 10:14:39 -0300
Message-Id: <cover.1756816682.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

Thank you for your input on how to handle the situation with the driver code. 
Kim, I also apologize for the unexpected situation involving your previous 
code.

Based on the suggestions, I applied my v1 code changes to v9 of Kim’s code, 
resulting in this v10 version that combines both. 
Compared to v9, the updates are:

- Added support for max14002.
- Added a function to write a single register, since the write enable 
register must be updated before writing to any others and updated again 
afterward.
- Renamed the init function to better reflect its purpose, which is to 
disable the memory verification fault. I also replaced the one-by-one 
handling of registers verification values with a loop, since they are in 
sequential ascending order.
- Replaced the old regulator APIs with the new ones.
- Updated the device tree documentation to align with the datasheet 
nomenclature for voltage suppliers.
- Used IIO_CHAN_INFO_AVERAGE_RAW to return the filtered average of ADC 
readings.

One of the reviews I received about my v1 version suggested using a custom 
regmap. I attempted to implement that, but I feel that most of the default 
regmap functions (e.g., regmap_update_bits) would need to be overridden 
because of the unique way this device handles communication, such as 
inverting bits before sending a message, updating the write enable register 
before writing any other register, and updating it again afterward. However, 
as I am still new to the IIO kernel code, I may be missing something. If you 
could provide further explanation or an example, I would be grateful.

Regarding locking, Kim’s original code implemented it, and it remains in 
the driver.

I still have a question about using _mean_raw (IIO_CHAN_INFO_AVERAGE_RAW) 
to read the register containing the latest filtered average ADC readings. 
Should I create a v11 version with a patch to include in_voltageY_mean_raw 
in the file /linux/Documentation/ABI/testing/sysfs-bus-iio? 
The idea is to use in_voltageY_mean_raw to return the filtered average and 
also to set how many ADC readings (0, 2, 4, or 8) are included in the mean 
calculation. Any feedback on using IIO_CHAN_INFO_AVERAGE_RAW this way would 
be appreciated.

The v10 changes were tested on a Raspberry Pi 5 using a modified kernel 
(rpi-6.12). The MAX14001PMB evaluation board, which contains two MAX14001 
devices, was used for testing. One device measures current, and the other 
measures voltage. The evaluation board introduces an offset to allow 
measuring negative values. These board-specific characteristics were not 
included in the driver code (neither the offset nor the current channel 
capability), but they were considered in the calculation of the values read 
by the devices. Should the code that applies these board configuration 
parameters be added as an additional driver file inside the IIO subsystem, 
or should it remain only in a user application?

I plan to continue sending patches to cover all the features of the device. 
This includes adding interrupt handling for faults and for when the signal 
exceeds the upper or lower threshold, implementing the inrush current 
feature, and completing the filtered average reading functionality by 
adding the ability to set the number of readings used in the mean 
calculation.

And I would like to thank again my GSoC mentors Marcelo Schmitt, Ceclan 
Dumitru, Jonathan Santos and Dragos Bogdan for their help with the code.

Thank you for your time,
Best regards,
Marilene Andrade Garcia.

Marilene Andrade Garcia (2):
  dt-bindings: iio: adc: add max14001
  iio: adc: max14001: New driver

 .../bindings/iio/adc/adi,max14001.yaml        |  79 ++++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max14001.c                    | 355 ++++++++++++++++++
 5 files changed, 454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
 create mode 100644 drivers/iio/adc/max14001.c


base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
-- 
2.34.1


