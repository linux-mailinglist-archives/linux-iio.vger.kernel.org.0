Return-Path: <linux-iio+bounces-16192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6365AA49B94
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C704C174AF2
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726926E636;
	Fri, 28 Feb 2025 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/K73CCH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B3224CC;
	Fri, 28 Feb 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752029; cv=none; b=WEd8HGv6O6HG/IqZ5+9yhpgcByCLU56s8WlRJXeSj37sghPQJTOqkkBA9PmlIKtwa+ssy0DIOJY8A5turfKMoKwVQNLbnL3BpmYhjzs25jIosBn0E3HYfipN0JZG1HKsSOjelvBLuKC6f+9Va9+gmdFsYy0FT4Tc9AQt/L5/Tyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752029; c=relaxed/simple;
	bh=DS9lNSlSUT0C/7J3bhO6ql9F4IaKHAWpwJcIXQMPUwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dz9/N5lQAslWdUIj8soXvWeHSBuD2Gc9xq0Ih0iT08lY9cvhTvWvn9dyIPdv5HHughsOGe2WgRNOoM1w4w7/qIANbySkpSkdW2yn7JFgAxrBu+wRVE9wcJkfIbdbD7Msn8Qk9e7eOpEAPZNQ5WCp0JInkZueVCwp4SqjNNl5mQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/K73CCH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f406e9f80so1795271f8f.2;
        Fri, 28 Feb 2025 06:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740752026; x=1741356826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPI7LcBBqRRfAvkgIxPa1PSmhrVdmlme+LZlSUACjhI=;
        b=F/K73CCH0KtdH0xQ5DdxgmREfBvMhp0zkSELcvtYk7W6n9+u9DqbVVDAGLxq3Oe8FO
         xReaTTqcfJko+DG3JpDwDO4izBLvxu3NHi6V+wd1h6O14l6DUszA3FoZR9WGtKMJ9mDY
         QzNFUTN2qtIPFVHzCpuQ0D7i+WIvkxdtOsDq1PO+KLDeGQin/YoWw4bAxngZUU1SNOtw
         tzj4KhFJGR8xyZn0b0z+Mm6eLzvjia/OeYbv84dWlMes2LQwQ2aAlIMc14KqSVY5gfG5
         k/Q48sewSW6VtGu1ameI6aLQfRKQTQRJnA5c1Jmht3KHu3SCB5PMzOug7iZtXSA36p4B
         +P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752026; x=1741356826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPI7LcBBqRRfAvkgIxPa1PSmhrVdmlme+LZlSUACjhI=;
        b=vEbta+AR+MVcskeaX1xDIpGdYx/sDpBh4zQQj+vVbCp+4392blMt4lDANGSeeWCtrF
         tHL7/nus7aHOLKhRMjtQvG+MOqXviYAfYxq23nPC+2vftJuXYhVRRZ1+JbUAIt15g5jh
         9v+9pkMxuoOwVJQtfoaCDkEgABRKexdz1sQMko7hAqd42MSryzvZYO1CBa1kFmnx7oW0
         wEGfGxmMNKNQXbqrtnzcGETpSYuOb0nXhxK1DB6FDu2eRBxLroUmmfPKEIZzqhuP3Uz2
         fUCs7iJ7QlfzNRGhsguT8hEhBAidiL316w+WtZUgX5SYZUol316ODlPPmFT0lVryy2dc
         KGQg==
X-Forwarded-Encrypted: i=1; AJvYcCUNtSq41QxKnSEVNABFaO3SscsYT6V7+IaHS2QfurpzNWlh6dKTEryjd1J8E9/J5bgDOsVFGzFt30Vb@vger.kernel.org, AJvYcCWdso+TWBJWzz3qKmJEPQ6x9sYNxAT4QcgR62/FCioxl8TCiSp3mCRWQzCuZt58+kzsS+r8t2acp2Hj@vger.kernel.org, AJvYcCX+1cH97Mh3I/sM8YaycW4Sf0Ho0NqILT60AHrw9tfoBs223+iVyoXivswCQt9ico4cIVJ116NSTMtv@vger.kernel.org, AJvYcCX2LN8prwE48YO9hnMang7tlMERDl/+Q542eBGUcI9LE6thEDKeF3NJEy2wkiUAzv0rNYYhmPXhL7eOTAsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/3gVOaK/FOuYC2ypuEi0U3IZ3CA/l2kzNHy1mAQ4/zPaVAz9
	YU+Q2r5tDMP2j+Iq3miTRmRg1Ama24ZJ50LOEcNeDYOaVoWZ4DQy
X-Gm-Gg: ASbGncvsMOJPDJ7ibtSYWqMg9SXomQjSKVVgW5hMHy3e3lKjuotKq7amK5U9D4ypyJ9
	sg5NRMBLVaTdiFV2M/RdLI4J6DMAT85F7soSm0YJ6c2YXvqa87ZqMDxBSO6lcC6E2Gl63fWYQ6H
	8URmpTLGjJyWZXpl9LFGSW0nEGnUHLMeedE5+rExQ4NQSzFr1KPbTBt75WcWNLf9T4WJ/ENJbN+
	ORzDERMq+7+05TaHraC4Eo2FV73LmOlIIuexGBJ0/zgS6yK2xT1ncn+D00HKpBH/hNDPz2PwY9P
	dNrCh2VOKVgxKJJAEnDftw==
X-Google-Smtp-Source: AGHT+IFo6/kl/0UF8PFBsaOFCeaXmGGkLjQhcakzf+SIxM2CsnhCId7Z2dyDHtiPThZ8uNy/+ZWO/Q==
X-Received: by 2002:a05:6000:2cd:b0:390:ebfb:ab62 with SMTP id ffacd0b85a97d-390ec7ca2cdmr2423106f8f.4.1740752025924;
        Fri, 28 Feb 2025 06:13:45 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75c6sm58221645e9.1.2025.02.28.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:13:45 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v6 0/3] Add support for AD7191
Date: Fri, 28 Feb 2025 16:05:59 +0200
Message-ID: <20250228141327.262488-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


v5: https://lore.kernel.org/all/20250226115451.249361-1-alisa.roman@analog.com/

v5 -> v6:
	- use GPL-2.0-only
	- remove kernel.h
	- remove unused macros
	- initialize local indexes
	- check number of gpio pins
	- use bitmap
	- inverse if condition and remove continue in 2 places
	- fit .compatible initialization in one line
	- change MODULE_IMPORT_NS() content to string
	- use iio_device_claim_direct()
	- refactor heading levels in docs

v4: https://lore.kernel.org/all/20250203133254.313106-1-alisa.roman@analog.com/

v4 -> v5:
	- use static arrays in the ad7191_config_setup function, instead of keeping
them in the state structure
	- added error checking for devicetree parsing of pga-value and odr-value
	- for now, it doesn't return error when the index corresponding to pga-value
or odr-value doesn't match, since index is initialized to 0, so it will use the
first value in this case (the bindings constrain the possbile values for these
2 properties, so I thought it's ok like this)
	- use gpiod_multi_set_value_cansleep()
	- move sampling frequency attribute to mask separate (the avail unmodified)
	- removed unused argument form ad7191_setup()
	- removed 2 redundant sections from docs, and renamed one to Devicetree
	- add ad7191.rst to MAINTAINERS

v3: https://lore.kernel.org/all/20250129143054.225322-1-alisa.roman@analog.com/

v3 -> v4:
	- addressed all replies for v3
	- refactored the scale and sampling frequencies configurations to use 2
different arrays for gpio case vs pinstrap case

v2: https://lore.kernel.org/all/20250122132821.126600-1-alisa.roman@analog.com/

v2 -> v3:
	- correct binding title
	- remove clksel_state and clksel_gpio, assume the clksel pin is always
pinstrapped
	- rephrase clocks description accordingly
	- simplify binding constraints
	- specify in binding description that PDOWN must be connected to SPI's
controller's CS
	- add minItems for gpios in bindings
	- make scope explicit for mutex guard
	- remove spi irq check
	- add id_table to spi_driver struct
	- changed comments as suggested
	- use spi_message_init_with_transfers()
	- default returns an error in ad7191_set_mode()
	- replace hard-coded 2 with st->pga_gpios->ndescs
	- use gpiod_set_array_value_cansleep()
	- change .storagebits to 32
	- check return value for ad_sd_init()
	- change to adi,odr-value and adi,pga-value, which now accepts the value as
suggested
	- modify variables names and refactor the setup of odr and pga gpios,
indexes and available arrays into ad7191_config_setup(), since they are all
related
	- add ad7191.rst

v1: https://lore.kernel.org/all/20241221155926.81954-1-alisa.roman@analog.com/

v1 -> v2:
	- removed patch adding function in ad_sigma_delta.h/.c
	- added a function set_cs() for asserting/deasserting the cs
	- handle pinstrapping cases
	- refactored all clock handling
	- updated bindings: corrected and added new things
	- -> address of the channels is used in set_channel()
	- addressed all the other changes


