Return-Path: <linux-iio+bounces-16086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4824A45DE8
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 12:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C46164BB9
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DE8218AC8;
	Wed, 26 Feb 2025 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkHk6KHt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98A2153F5;
	Wed, 26 Feb 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570919; cv=none; b=IaGc+uwsEyiIAg0yqLUrNOtc3oju1tiZ+qg0WX6bENED63soTJXWlamy5oZDNAWNwspFRwK/NfdG0X3EWDn2d7+fnvph0kQnWF/P+0vkowxxJJB5erlUnKv0RiIxyxZHV9h/LpdQG4esrPNJfqAr7Bxh+e5KTLqYnB1QWLFZIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570919; c=relaxed/simple;
	bh=RYUNTFtx5d0vJ8M91zRbSV93JGEEumEcL7oebwAoRSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EZuAU7lbLGmLa+iRmr3k5YCpgZeb2gCaMpzJQp8WVheRYERo9yDf32k7Y7FweYOZn/I641trPmMx0NlslsGfzUJDPk58PQeARG5nfu6M4Zbf5inpq5dGXc2FLNdbpzsAW1+pcy2atvsUp5xQltXAtQIuGmuEXdYOx7IdmP+oKN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkHk6KHt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abec8c122e4so376771466b.1;
        Wed, 26 Feb 2025 03:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740570915; x=1741175715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqjVCAFTYNlvEyZWFVVY2wWa31+InyULkfvt8ZauBJY=;
        b=NkHk6KHtzC5w81Wb6AKZ90MYGzBt2kfSmgdby3E1n7ZcL/hm7/AnRqztiIu5f9Y1bM
         1+MVekMPj8ImOGmhjod2Zo0qdywTUn12fOZtirxs6cHBj8s916JHrw2zj/bAJh0fQFS4
         X6MZJBDEeSuznOW8mmqe9fUdeUBCpYJQXe69wTKI16d67L6yd98w0wpSFp799dzThnMU
         hjmXncNiFhgip8L+om74yupqFndbP4LzqEmkNqnzWs7aKZSHLRQIof+SO9OZOQjvL2sE
         n2sin6YaLr/f7Lq36/wAGq90WXeND/lW9K5j7hj/3+FQH5l3/ihpz7hGIis+R/Dmp8Zi
         epPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570915; x=1741175715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqjVCAFTYNlvEyZWFVVY2wWa31+InyULkfvt8ZauBJY=;
        b=dC+rdJpuW1kn/l7laNg4Ecg+0pD6WOzX2ZFo4UrpKDt83fEa1uU0Wv61JlmQcDC7dq
         8CHbhOAFeW/+L6twBkZcwxFddBWwQLT+rx0pgqAZgRolV2aPSeV7zEp4gQlqOKFl/qtv
         IaeL4dCxdjO74mOVUK+/EcIribDZa6W5Wc6JGJ46hhMNtZ6PZ57tz59+Ji1SbPbzuZHk
         9v2vZb+m8WSdqdd371hTazrGb8ZMULEey0s7Q8WGOCxdKlfoQop57xsqa1dhD5eb3QAk
         o5AkR09+ausYnvRTzojOZi9pOJpSXgc94gG235tPBDSbWCuoAJSKHhm29nz1aXSOLGc+
         I+3A==
X-Forwarded-Encrypted: i=1; AJvYcCUft0+9sTk9AlnVwSQ8/d++cgHFSOTlhB06seT6+mv/5hCtUmUERPOBCtzh5XUXIGsanysILhdrOxeDxSpb@vger.kernel.org, AJvYcCXim81xN9MsHSbTpXpnMHLqcvB/cBxI/xmxug/mTpnFn+BNeRf8TH2XJrVRi6PbBox6WxI3zHKwoQVy@vger.kernel.org, AJvYcCXnGYCc2GXo1v4CnVgwVG/9fRdN62ngMYeb15V/xqe6JJAJ38jBjw3n7Gcx7YIIVlCKNyEGf7AAI3C6@vger.kernel.org, AJvYcCXzXK44qlIgFiQf1nv7LYVe6lD0okgfrWKPHQJQWt2z1NflNTUp1ya4628taTO7KPbK2k1fDjvGSi6h@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ktchCNpzxI2Ke54SAIWHBtahYivafibETXY4xp+Gl8eYCi+Z
	u6WRDWdRMtb/h3hsW9rO97tSXvf17mkAhp/XxtsbBjN+KZgrnkQc
X-Gm-Gg: ASbGncvTENbqf1u9Lv/kQVntDjR9XfSZfVOwXxPwFM9PSS/X8kSrMfqZMchJG7slFBr
	hrgmzenkBSgDOcefq7UDf+o+jyIP6P6fy8sF4TIiiO3cHTlRLyEzUptwCsY4OwKfdPN33LjWFsf
	ZmmBOthDHFr9VNa1SDHOXlp9iRFkShm3C6cNK0GwaHho6Hsrd+i5cuAh9anmXqXx27GyKSzzSWN
	H7HRlyqFJ0nZYHEaqAnoZzXA4w5gnb/slBf6pvaX2STKd/4W0wR6LzBzxFSghsW+A/18PI2SbMH
	bN5SFa5fCXGHadtQ9qtEuA==
X-Google-Smtp-Source: AGHT+IFXRcdFx0WWrJDXV5o3lCu3jZvdZNKcl+ClAB48ZOpSp4/f7xVCRmpg1SB14Ft/Ri4NJSoCuQ==
X-Received: by 2002:a17:907:c0f:b0:ab7:87ec:79fa with SMTP id a640c23a62f3a-abeeef706c6mr316437566b.51.1740570914334;
        Wed, 26 Feb 2025 03:55:14 -0800 (PST)
Received: from spiri.. ([82.77.155.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed205e53fsm307822366b.159.2025.02.26.03.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:55:13 -0800 (PST)
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
Subject: [PATCH v5 0/3] Add support for AD7191
Date: Wed, 26 Feb 2025 13:53:39 +0200
Message-ID: <20250226115451.249361-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Thank you all for your feedback! Here is the updated series of patches!

Kind regards,
Alisa-Dariana Roman.

---

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


