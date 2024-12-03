Return-Path: <linux-iio+bounces-12989-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD39E16F5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 10:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FAB282E2C
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E311DED62;
	Tue,  3 Dec 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwCD0uGS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677091DDC25;
	Tue,  3 Dec 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217372; cv=none; b=LyUE7yaM+8SeGopo4foBJNa0GVMVToLPgirHYCwGisMiCEYPm+8xd7gYuRWWH12T4ly42o9McwRSXQCWS+MX/antCGay5WJK86ZKNN2fKTVlI4+16+IZPkEMUTRKESVpfPE+fqRLx39W/2vcCGUm6rRf850Vi2TLnlJs1exVOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217372; c=relaxed/simple;
	bh=wbgqDVMWXhMwWUq+ARw0MJ/wP5rnkKhrCkyNoFwkv38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZkiEpChTzqjwoPo+fzeKt+cITL8mm0QYzPIwNHHJv/z1NXOBapobPc3Yafx071mYw1DPVzZqkWkxXkrwbYlb0RXtYMBGWQ5e/9K7un/KqbUuBeJihLb41rVqOwGZTCmHts7mm9V1t5prmnKStsTeWKMqmkhoI4dNRdXoUK/CmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwCD0uGS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso1477812a91.3;
        Tue, 03 Dec 2024 01:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733217371; x=1733822171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SiiyDRalD5xASi8k9BJDefjshvIVg9c+UxPMRyISNM=;
        b=JwCD0uGSjI2XrV2FRpncQzMWdWnYEa4JMnvsQLidZi4X/QwU6H105UQwzhkyezg5ex
         34slFGCWthrjdqXSqjQiMBGduxs4vjzt+cX5GcFhiZPwPwrTSfBeJZMJWEo7cmIeM+cv
         KGVM5vKM48/bmyzzb49jtM284wCa+7AmZRvIcrCQ6zlB3UFWyvOg2Fh/WVqyL6iGRaDN
         1URwFHy+aks8OR1c6TMQhzUekjSXAYS2A4tLdiOp4ylo+y5OcpTbDaUdZUEd7OBZzpJt
         D7F9nelo/zxLUxZBNZwtmzH6QfvrNJhWwgZys/+lXKjSZbEiEOnak9ZVdHBEMEQQzTeZ
         sbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217371; x=1733822171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SiiyDRalD5xASi8k9BJDefjshvIVg9c+UxPMRyISNM=;
        b=aoIaLd1O4XxKVnqb94NvH4hYD3DiYYFVHM0PqkW8oYGoLHS0OIkf30L4r01PmUQBFJ
         7iCaQXMCVX/gyTlGeE1DQUBTtLsa3y8BY6kFLM4fOQKwFF4zs3QWwVD2o4v2w7LcdEUA
         KaQ0J13u6XDT8azV1f6/i186167M2UmmKsGPlKCdGetKaB8/x3Z307A9PzqodaewSznP
         vQbGfPh/v61RqcgZpBeEsSnTjnjMA1DraoIRd/Sig70QKrEATeRB/N6AwxY9Dn1wDIPi
         B3t1/TuXko4CGv+2VTEMYPtQmcEF9ej0EJREgxzZEsDC4WV22j696j5W9lFFLuLGUREe
         bFfg==
X-Forwarded-Encrypted: i=1; AJvYcCUOFLicJWBRCDjDA/2EkQ2Llve/bD7sSgDBY4VIV5bkyKyrKoSDBMsFxNFpcaxb6YLZQ2GGQ6T7zemP@vger.kernel.org, AJvYcCWCDR3bHcLKCrD40Y4JScQnVewzJ0aDXHQKvFc8O0C0sMXteQfA8jGNBKHfLObTW2TnaG4L3Xv6SZnleH5U@vger.kernel.org, AJvYcCWv3Q3sJxwr5lkUM3+sJl5u7D3sndNrmOkoe3l3Y/hfykTWuJUKnRFykVyrtZNk10JEqUxFWs7CszhG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5+4Sc1AfQDu6/+Rsn2gUelGMbMkVEIHtNX3Mn82mrNrbSDFS
	BqJ0ip59akO+mhpjW0CVJWCdKwkco4V7mPa8fMby3G6j+DWy14hr
X-Gm-Gg: ASbGncuBov/OobOcOa+ePWHGupAvy9giShbAr3DCSCOK8QxxFajnhk2cieFNboP60QR
	j5QRoE2vOOzzYyjnF90zIWyH+yToX0lVocUNmpXbpx6EtntWhECbB5P4GnPTyoRT04HYyDJMZnH
	t71zP/SkppEdWKqqeIVzoNQKn66uZh9scDZu1XnwTsBAPWS3GqFkiKzasSJk7bB8qwd2yJqvbb/
	05n+WQPR6IvL0TFtx0B4rBg2JKVxvO7y+qk8ICDb4A3rlgt6QpqvIyHsQJzr7HLSrq44/3n030a
	rcI7Y387bDpuzz0=
X-Google-Smtp-Source: AGHT+IFgGhE5SLC27Oi1AeRF0rRV8UEqlKW6VpIhPrFpWYx1U5vcw6NF5lfHTg/4SdLEXzNIxiC6eQ==
X-Received: by 2002:a17:90b:3a85:b0:2ee:e961:303d with SMTP id 98e67ed59e1d1-2ef01275c7dmr2455939a91.35.1733217370567;
        Tue, 03 Dec 2024 01:16:10 -0800 (PST)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee566a9a34sm7713069a91.51.2024.12.03.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:16:09 -0800 (PST)
From: Eason Yang <j2anfernee@gmail.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	andriy.shevchenko@linux.intel.com,
	marcelo.schmitt@analog.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com,
	mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: add Nuvoton NCT720x ADC driver
Date: Tue,  3 Dec 2024 17:15:38 +0800
Message-Id: <20241203091540.3695650-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since version 2:
 - Remvoe read-vin-data-size property, default use read word vin data
 - Use regmap instead of i2c smbus API
 - IIO should be IIO_CHAN_INFO_RAW and _SCALE not _PROCESSED
 - Use dev_xxx_probe in probe function and dev_xxx in other functions
 - Use devm_iio_device_register replace of iio_device_register
 - Use guard(mutex) replace of mutex_lock
 - Use get_unaligned_le16 conversion API
 - Add delay 25 msecs for registers ready

Changes since version 1:
 - Add new property in iio:adc binding document
 - Add new driver for Nuvoton NCT720x driver

Eason Yang (2):
  dt-bindings: iio: adc: Add binding for Nuvoton NCT720x ADCs
  iio: adc: add Nuvoton NCT720x ADC driver

 .../bindings/iio/adc/nuvoton,nct720x.yaml     |  40 ++
 MAINTAINERS                                   |   2 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/nct720x.c                     | 533 ++++++++++++++++++
 5 files changed, 586 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
 create mode 100644 drivers/iio/adc/nct720x.c

-- 
2.34.1


