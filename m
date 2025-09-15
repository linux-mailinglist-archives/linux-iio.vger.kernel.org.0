Return-Path: <linux-iio+bounces-24120-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260DEB58745
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 00:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23C12A360C
	for <lists+linux-iio@lfdr.de>; Mon, 15 Sep 2025 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55F02C028C;
	Mon, 15 Sep 2025 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POPGjKy/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9B269806
	for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974566; cv=none; b=rTqNAPwNF7n3rKe0cGRlo7Nfbcf4W3XPO0HQml5mPXUg2+Eu6eRsN5wZ3WU+VZ9Sc5ZE46LxIHNw+G0zK4rxvX6VJ9RQEClMDfUiK1+0G+btN5PiMBM2LfcWKUkGqZzJ53mc7g2o+KsiBPPf4sFTf5ZjmYyqVMUj440jgQDl2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974566; c=relaxed/simple;
	bh=2TwRQ7Odl35bnTVmkNbaQpjTJrpwNpSaEORP0ZdqABY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bvBi/37KV07QzcRupypekkEax+eawIVakqd93e12SFqqECfrYNEHBoqONxcgqHvyozJ8M6wxsoe6u95sP6xi5LXm82BZoP6tRQnPzkQm2X8le+E4nRPzlACSPbnvXEOv49h0gS8KsCytYXUC8ean0/xYsMDfyK0Os4qwIfO6rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POPGjKy/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so3725094b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Sep 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757974564; x=1758579364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EANtiW8Fhtl5LLMmH+RNqU0cOM8cX8a+UX3kfhq2t0=;
        b=POPGjKy/82FA8/nOaDwBMi/sWkxXVtUJMrxWz6tLgqLJXDMA35IJ9QJyd8yDAE6xV4
         4d68AR88U/3cIdWaXWKBitcJKSh/P3scD1s9NA75wcLcn7nS2aGKXN9MBKvWcYMLXZs1
         /A1Go8oZwgQxTS0E+y8nilHUB/xo/QHwlwMNJGD+7SviBHNvZj53nNMgrZYrEaSh5IlZ
         THRerBG0hDqq/0PdkhSdkqHo/H2AvNgUY18hOyyrCxNg2pm+uLejMLI5aVWqukWcmGrk
         7IKffJ0Zr3XZAUrQXKQf+m3cOiw0Mm08odYi/ObdwWH5HbCfU5SG1UdSFS/h1kvbKfgE
         ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974564; x=1758579364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EANtiW8Fhtl5LLMmH+RNqU0cOM8cX8a+UX3kfhq2t0=;
        b=olFm0plouZ0ttdYw4/a3GJ8X51Z/8LykudVu9mAzGhfIrWhgLLrvDnd7+8PjqhuXKP
         Ys/Fy5CjUq9HX12ntRlFiShj6f2XnJJTVniPdGX3Ck0FZT37ScOkjMMLs0YE+Kk1GZLQ
         BOQ8L6vpht/Fi73WvivPb7LtsX6chwFYt69U8HsjEXSNAddvDd5/grnel6soNL41ekfd
         Takf/R6HWedFZW3gv/YCf3uf0U9aWrXjQzGywnafutI/DRUFR/5EyXJgstDClHtS3Ich
         LQMcuwkJjm+8azee8ZHPcvXrKNUBBLdd/jHMzffHT0jzlj0mxSCJ+UZyRhqeGL7LmOBB
         h9EA==
X-Gm-Message-State: AOJu0YwJ5vcHrACB3RL0SKDgIMcUhh3NeCEjZinRF7+HpSmkmkSPxq3Q
	A2y/bRJ7G4NCf5wKGr1YkJg4vpQrLnY76WbCQkTIMoRIy2tfFev1QaQRXdfiQxEOcyc=
X-Gm-Gg: ASbGncvFKw5KUyVoySdx5fh/pkXRziqSIuIKPibTTivUd9thpDq3vQe/wv0j3mGPflm
	iuXtF2iwsKoSm0NS9dQCRiTzQNSJPIBikMnP1EQ/jcsPRGiqcmPMMNAKHeg0NAYcKiUE+joSm2S
	M8KUy/BIIV8vlZmagETAy4v6lnIwx9TW1KXUgLTEnJhNF2lbCqLTLDhL/kfAy+Q7Y93mnd4FITb
	6IxsddjJwTcooDVMFCgKARkK0LaIh/fVKbq8KI+2Bpp0uHfwaCHrv2gMY9YLvaWOIVpCppwHO5L
	U4ifLbn3l5xcq8Y04tQnzrlVhLMyDDuKnQPS81kkQb6X23CAJub8wE4al+TC+q9Bdp+GPutxUgX
	VNUfZfFtirUEImmL75eXg6rJNlI/9t9FJaFNjXBJ43gUqVA==
X-Google-Smtp-Source: AGHT+IFh76HLO/YT0qIt7A0bFAgD4JcYWE6WuL5ntYDbwnY3Rk2Yc7swyytB/kjQnM8Lx4/O+5VEeA==
X-Received: by 2002:a05:6a20:ea0:b0:262:66d2:825f with SMTP id adf61e73a8af0-26266d28b6emr9412871637.16.1757974564051;
        Mon, 15 Sep 2025 15:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:d43e:6485:d878:c0c4:abbd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c472ccsm14573518b3a.98.2025.09.15.15.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:16:03 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v11 0/3] Add MAX14001/MAX14002 support
Date: Mon, 15 Sep 2025 19:14:39 -0300
Message-Id: <cover.1757971454.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello maintainers,

Thank you for reviewing v10, for your suggestions, and for answering
my questions.

I believe I’ve addressed most of the requested code changes. There was only
one that I haven’t fixed, I’ve included the reasons in the patch message.

I’d also like to use this cover letter to address some of the remaining
questions from previous cover letters.

Regarding regmap: thank you, David, for your response. I’ve implemented it,
and the code seems to be working fine. I tested it on the Raspberry Pi
modified kernel version rpi-6.12 with Raspberry Pi 5 hardware, using the 
MAX14001PMB evaluation board.

As for in_Y_mean_raw, the issue is that I don’t have the file
/sys/bus/iio/devices/iio:device0/in_0_mean_raw; instead, I have
/sys/bus/iio/devices/iio:device0/in_voltage0_mean_raw. I was thinking of 
adding in_voltageY_mean_raw to the documentation, so I am submitting a
patch with this change in the current patch set.

Thank you also for the explanations about the extra analog frontend
circuitry. I plan to study this further and send a dedicated patch to cover
it in the future.

Thank you Jonathan for the two possible solutions to set the number of ADC
readings used in the mean calculation. I’ll study both approaches and send
a dedicated patch to implement one of them in the next steps.

I intend to continue sending patches to implement all the features of the
MAX14001/MAX14002. Since I mostly work on weekends, I’ll be submitting
patches at a low frequency, but consistently.

Thank you for your time.
Best regards,
Marilene Andrade Garcia


Marilene Andrade Garcia (3):
  dt-bindings: iio: adc: add max14001
  iio: adc: max14001: New driver
  iio: ABI: Add voltage mean raw attribute

 Documentation/ABI/testing/sysfs-bus-iio       |   1 +
 .../bindings/iio/adc/adi,max14001.yaml        |  87 +++++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max14001.c                    | 356 ++++++++++++++++++
 6 files changed, 464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
 create mode 100644 drivers/iio/adc/max14001.c


base-commit: 671b9b6d7f4fe17a174c410397e72253877ca64e
-- 
2.34.1


