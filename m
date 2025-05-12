Return-Path: <linux-iio+bounces-19451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBC3AB31B0
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E94417869C
	for <lists+linux-iio@lfdr.de>; Mon, 12 May 2025 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9E62571AB;
	Mon, 12 May 2025 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKzqAtmY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24033194AD5;
	Mon, 12 May 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038728; cv=none; b=foox+hlRMp3vJiYfAJFzaNP7ovtLT3KRIyMh1AfD0sSVANcYZOcSlwXW2gP2PIGxWbDCJj6zLoGYJlBzdCiTp6dR5d1zzNoJpQj5RACozY8VCyOSxb27aEbdr56AnuYLTx105NnPqx8QFJ5kM/tcI6Rv9yIPvX1x+bFdPlbn0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038728; c=relaxed/simple;
	bh=tgkpiobekE7Cn7LJ4mWhcfMhTuOqb9sE4K63agvt3c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkQHkojsWMFPp8vc5T7ZAvIjKmJlkFoaOGxE86+5amGHuGZWcyslYJOf9WAKJ8yOxIT6o8VrOeHIpbK1ga8IiOMdo8yv0bjW2fF8DIGjFwltjDW/YLSSSu+acSl2siHBSpsyfyNwI9BAXLu+ry+0oJcgwYVJ/Dr44SVXcRMaYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKzqAtmY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-73972a54919so3992812b3a.3;
        Mon, 12 May 2025 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747038726; x=1747643526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRf34OhlthoCURRJkrNeUdtCiJjtjYzGmozcb5W06cc=;
        b=QKzqAtmYlDCk/45ryTU3aebdD9xk1oPLfql+GiCPSalnFL0vbbuVQNkuk/vNSdCHgM
         hpBHdKy9wApZMcTf9B3boOlbxI75mGZPLt1C6It2iaT2INaH18fbo5IaXfr053ngHjf8
         /2L4Z/fyoLPhlY2EduETlYxq2JTfQTMN9xiPilBodK0waJoZwSAjuxiuS7hOU+c4zhS6
         WZfh1UJnmZTDmu6TPhLI0gKxrppg86RHAVjQ3CiAzWT9FvXQxrsiT88ezOL3knIQ2O8g
         cFL1DMpyR+ZpF0K5M/ffE4UxkQrPgat9TWrfag/NomI+gzCcn3OG4ygrMal0Dd9KIGF3
         7jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747038726; x=1747643526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRf34OhlthoCURRJkrNeUdtCiJjtjYzGmozcb5W06cc=;
        b=bE7M/Sj6sUiGZz8BlVksJIxSl/ZG+ZItdHREtvLlLq3nGA81j2/8uarEMx8BQu5IR4
         3ibjJ1y6CfIeHkVGvBALWi8aDH+o4dQLWuiVTM4DDDPSzVFMz1sDrp0yGN9MvA2VzlDO
         5+wQozFDIgXMfeVvkgKRzi8HnJDH0KP4R7rPQHPzESTrLwBLBBC8Ay7TVjomVHfTvgJ4
         Qaz7uGjGwVtLQ2GgWrZWo9rF7dO50SHVn9i6ZZ1mv/D//n31Ir7gHrXY5E6aW8vo7N0/
         3i7OKijOLrtMjGE11TsPoHGL23JrMtRAj73JbxhYmrjE3qpqp0qyVRp7bhVChfzvZOq0
         AP9g==
X-Forwarded-Encrypted: i=1; AJvYcCUfJU/zxjnWQ0APxF7edwJVHgF5cbGE/PC1qSrgkq8HJavo74wLp/RnIDrbxcJ1t6715p/l8qanU6h6@vger.kernel.org, AJvYcCXbhVWE3BdSOVOTYZPSIf6I/gi5PEhY96WcOXm0mrsB4vqa0nK2VXIsJojuQYScTYd8zcFngONWYWiAqJ2w@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsxBJ0pS4h20zyNpRcumH1g+B3/gaYrp4NDy8dpveLq8I54Nf
	ZBeIYu50VV1d9XWVGAO3hS3SQJC5G3Epo24TpAnmd3M3SwMsEb+q
X-Gm-Gg: ASbGncu7Dgqm22LTLwyV7sFpjeFcHVR43xrEEixbHT9Y9S1BTA0Mdcwc81tlxPABoL5
	5oE2xEq3LGUEBwSTvaYBycwSAKv74Ja2USCW4Pm9y7Nw8t0tpF6atQf81pOAYSNq2rlvaR3odgc
	sCXoM2JAR10Ffbk0dTip3DVWlhCR3ki7qm1aWWG8IY0A7vw4AoSZed5hJBaXWRSeiCBekH98aUe
	1idCSpVnjiRs9rnEjjzJlLOusPgewkiKCRK2omjiqv72IuVMU1ysxSfb6Jrw61R2I8rZBwm5sKj
	5kFr4tjJT4h2tlOdbj//w9Ezh783MNLXHN1vKhugXMFgQlYFkGFB59yDG1iu2cNHSZx1jB/QShc
	1hdRW05Dla96YaELIqw==
X-Google-Smtp-Source: AGHT+IFLyw1+CeQAVbmtUz13q1ykyf1UFPus/S6f19r9WIbdnqk2dyGgz47b1uiYjFrRtbD324WHdw==
X-Received: by 2002:a05:6a21:9017:b0:1f5:7007:9eb8 with SMTP id adf61e73a8af0-215abb046dbmr15477846637.16.1747038726187;
        Mon, 12 May 2025 01:32:06 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772752csm5437232b3a.45.2025.05.12.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 01:32:05 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	andriy.shevchenko@linux.intel.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	olivier.moysan@foss.st.com,
	tgamblin@baylibre.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	stefan.popa@analog.com,
	angelogioacchino.delregno@collabora.com,
	marcelo.schmitt@analog.com,
	tobias.sperling@softing.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v10 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Mon, 12 May 2025 16:31:54 +0800
Message-Id: <20250512083156.3300006-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since version 10:
 - Fix comments
 - Add interrupt handler function to call iio_push_event()

Change since version 9:
 - Fix comments
 - Change vin_mask and mask from CPU-endian to little-endian
 - Fix access to restricted __le16

Change since version 8:
 - dev_err_probe(), move the definition from device.h to dev_printk.h
 - Use USEC_PER_MSEC rather than the hard coded value of 1000
 - Use one dev for both regmap and regmap16

Change since version 7:
 - Fix comments
 - Derive dev from the respective regmap
 - Generate the mask from the number of voltage input channels 

Change since version 6:
 - Fix comments
 - Add use_single_read in regmap_config
 - Remove unused definitions
 - Do not shadow the return code by -EIO and let regmap API caller to decide
 - Use simple English in all error messages
 - Use a local variable for the struct device pointers. This increases 
   code readability with shortened lines.
 - Use `fsleep` instead of `mdelay`
 - Use 16 bits type __le16 instead of u8 data[2]

Change since version 5:
 - Fix comments
 - Add NUVOTON NCT7201 IIO DRIVER section in MAINTAINERS
 - Add vdd-supply and vref-supply to the DT example
 - Remove mutex since the regmap should already have an internal lock
 - Remove redundant assigning values
 - Check errors on regmap_write

Change since version 4:
 - Fix comments
 - Add interrupts and reset-gpios to the DT example
 - Use the FIELD_PREP and FIELD_GET
 - Add use_single_write in regmap_config
 - Use regmap_access_table

Change since version 3:
 - Fix comments
 - Don't put nct720"x" in the name, just call it nct7201
 - Remove differential inputs until conversions are finished
 - Add NCT7201_ prefix in all macros and avoid the tables
 - Correct event threshold values in raw units
 - Add with and without interrupt callback function to have the event
   config part and one that doesn't
 - Remove print an error message if regmap_wirte failed case

Change since version 2:
 - Remvoe read-vin-data-size property, default use read word vin data
 - Use regmap instead of i2c smbus API
 - IIO should be IIO_CHAN_INFO_RAW and _SCALE not _PROCESSED
 - Use dev_xxx_probe in probe function and dev_xxx in other functions
 - Use devm_iio_device_register replace of iio_device_register
 - Use guard(mutex) replace of mutex_lock
 - Use get_unaligned_le16 conversion API

Changes since version 1:
 - Add new property in iio:adc binding document
 - Add new driver for Nuvoton NCT720x driver

Eason Yang (2):
  dt-bindings: iio: adc: add NCT7201 ADCs
  iio: adc: add support for Nuvoton NCT7201

 .../bindings/iio/adc/nuvoton,nct7201.yaml     |  70 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/nct7201.c                     | 501 ++++++++++++++++++
 5 files changed, 590 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 create mode 100644 drivers/iio/adc/nct7201.c

-- 
2.34.1


