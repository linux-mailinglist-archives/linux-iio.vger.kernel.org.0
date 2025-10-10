Return-Path: <linux-iio+bounces-24899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01529BCCBDD
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11D094F9E1B
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015C2EE274;
	Fri, 10 Oct 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="aG3Gy6mi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7324DCF9
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760095434; cv=none; b=IrJmvFaI9TV5ilcv2UR8rQhBORZQGRGVfpMurAXvXXI2tH3BJOod2WvuECKMWYrO7NzTxjTMRfPurBtBHdzuUpNZgOwPRNfXbNcHmcgd+KoKUkhAlkF3HUAsAL4w0A+3YimInnvvl/9eJBZy9e0XjcJ9TfP+ez3ddOuZ4XLWePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760095434; c=relaxed/simple;
	bh=H5LgljmnkNjvXD6n5IG7Ap4WWlw3CGfBh7hhGFd2RjQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bE8eRO5t+Be3ZzPp4BdHEIZ2Zv9VYhe0PzLfIO/g+TxBiLlTf0uPPNAxcClfDzmNiZas4ahA9JaYp5VpsyfDdEWlfInvXVOIH6kuX44kHxuTiU+vEboBnc4Qd74iAWoNC1pHn1e0QzITN9lXwtWqIXXSIlNN28ydlGDbMDRHc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=aG3Gy6mi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63a0375d7b6so3079238a12.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 04:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760095430; x=1760700230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+WH0817Ps1vnRuu5RpMwf3DsYHgJQPb6FKq+YW7fXM=;
        b=aG3Gy6mievSarLUblY8MnPhoFwA24TWyRie0zu0FDAw72b3CC3USj7pflnz8rmOoi7
         mJcxBfpQanJv0YRDLT+V9CkoIbF7yMt+rBME24l+T8OZkRWhGW5ciFY70rrXo5l5yQZe
         enCfzlLwok9bR9N66/5cwlodlNyvu35wyMiZ74c94v5Hvwem9h3daWgXiWErihs27qMm
         eLGwo8Qi8N9nUtqhKUGQqgEYl1GQe0Vfwiow6YX0UxYznpR9WMno93yOoa8T+urHQbI2
         Xo9hyd5Hv/4BHJwkdUYehe5nZj/nMv62ip/xqGijTdZ0WJ93gYyk55Zlrv22zezcYCLN
         PIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760095430; x=1760700230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+WH0817Ps1vnRuu5RpMwf3DsYHgJQPb6FKq+YW7fXM=;
        b=TR5+wT3dQYZhgkgkRmeFBvvda8xpUzVjpDT5Kqz/e9K7nLgYkGgWlVYBbSLN9fAcX+
         SpJy+W68mKySfidJJ4NE4xN4OV34WQJOW2KW1fm2TbFhWwyc6oEiq6R35myDMUP6203s
         3jK5SaI7W5+urMoGOC3Qtc3XgvD1o75k/c1CU7cfj+asQYLE5CEQGsdQb48zq7rp0b9/
         an2mPbh9IcO9fk9sBTohA1f6Bkop6rwavh8obWRYS2kLT+koHiVX8Oulj6wTerWQtKkj
         nVLFTLV9l0eU4icxIb8hdgzYHW1e9v58HdcEnviK7GQzxMLB7Jf0fd+CoOUuRiJiZjEh
         jx5g==
X-Forwarded-Encrypted: i=1; AJvYcCXRNSNw/ZtwLzl9KQBY/qKkiPoVKF/Yfx3GfrZYJzcsUJ9eFSvk8WIGYCTr0ZYtAuDdHewEci1NkDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZAI0pU6ZjAgj8YXzLMoK5fAw7dLgcluVZx1RvQltwbKMmXYfl
	Qid1Uh7sAc0+tHC+za0N5K/y4fY/53ou9Mm8XrUljfixAl33r3xdXUONV4eCYHm8pQo=
X-Gm-Gg: ASbGncuh4kIU/SLSp2VCu8DZK4YwFYf8au2iauX1iwiTMl8NdqzRK40eD4PArraUP2E
	Gsgz8caPB204Vm6pnEd/Eb1WA5P/RjRBB94iVhL8gkh26hG0I94hJKGJp3u7vm9evcras2j+dDq
	O78MEZ3oZqagoXQHh42MPhw1fmju2NWrq6MPAnm51JkQVRi1MA7/DlkDgiCsKNlc57GMAZq7m1D
	F+2Zo79jrTf2XO43kKjpp01FVL/4qHEFU+YNDqSz+8tRDWaQeSgtzmm4cjD9W6CMegK+I6Ao1jY
	t2jVdo6w7fGBPxIeGJSSmDNAIXd1BkV2FioHU/KEcOIANVeV3gfBF+PRyOjLdAAYhCZ3XVrxYhE
	ScOA+ODeA5WpeUGNvLmsY5ClPCF6XImDZxKL8PSQrulsFxvGRt37jgjG7BHryu7oThRxjXaGEfV
	kbkxnuG6dRj3Eh9s6ri1AYIdZrfxY02g==
X-Google-Smtp-Source: AGHT+IGElPVM7npd0iZwM5139p5UTz/fZNApktIfn5kuKF28780Gdo3rcyMkFKGp/gW1Ak6ZBaU1Dw==
X-Received: by 2002:a17:907:86a6:b0:b41:b5df:89bd with SMTP id a640c23a62f3a-b50a9d59b0amr1084043166b.6.1760095430130;
        Fri, 10 Oct 2025 04:23:50 -0700 (PDT)
Received: from [172.16.240.99] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900bf8csm209905766b.59.2025.10.10.04.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 04:23:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
Date: Fri, 10 Oct 2025 13:21:58 +0200
Message-Id: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbs6GgC/y2MQQ6CMBBFr9LM2jEtpopsSTyAW8OiUwadRQHbS
 kwId7dRl+//vLdC4iicoFErRF4kyTQWMDsF/uHGO6P0haHSlTXaaCSXMXOY0fUea3s406CptuS
 hKHPkQd7f3A2ulxa63xj5+Srp/H/IJUY/hSC5Uctxb07QbdsHiZxYBowAAAA=
X-Change-ID: 20251010-bat-temp-adc-8539bf0b85bc
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760095429; l=3344;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=H5LgljmnkNjvXD6n5IG7Ap4WWlw3CGfBh7hhGFd2RjQ=;
 b=KqE1fucyVBMu5pDrzDvyF2Qfx4PQfSPiXKQSTi2ahEjUJqOFT2+W5qVs5saLypTG4U/fyL7it
 zKBR8HeuueiAJt0bc/93C0oNwirkBkYPymSh2RKCm0IlwVpMQU3uPIs
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

This is an RFC which implements a potential solution to get battery
temperature readings working on for example smartphones with Qualcomm
SoCs.

The solution chosen in downstream Qualcomm kernels is exposing
ADC_BAT_THERM_PU* in the ADC driver as temperature channels with the
lookup table ("struct vadc_map_pt") for the specific NTC found in a
device's battery patched to adjust the lookup table.

The high level solution proposed here:
* ADC driver provides temperature channel in (milli)volt as IIO channel
* generic-adc-thermal driver converts voltage to temperature based on
  provided lookup table from DT (driver has one IIO channel input, one
  IIO channel output)
* The fuel gauge driver can use that temperature IIO channel to expose
  battery temperature via the power supply device

Variants/alternatives considered:

1. Do not implement IIO device in generic-adc-thermal

Without an IIO channel and using thermal zone directly it becomes more
difficult. You cannot get thermal zone by reference (e.g.
thermal-sensors = <&foo>;). The function thermal_zone_get_zone_by_name()
exists but lookup by name is kinda clunky. Adding by-phandle support
might be possible but is lots of work. It also doesn't really look like
thermal-sensor is really meant to be used by other drivers. E.g.
there's also no "thermal-sensor-names" property to designate passing
multiple thermal sensors. So I believe IIO is a better fitting API for
this.

2. Expose IIO channel as temperature in ADC driver

This would require passing in the temperature lookup table somehow to
the ADC driver via DT. I think this passes too many details about the
hardware that's connected into the ADC driver. While possible, at least
for Qcom ADC there's no precedent yet.

3. Add temperature-lookup-table as property to simple-battery

Since the NTC is a part of the battery pack, adding a
temperature-lookup-table property to simple-battery would make sense
instead of having this lookup table be standalone in the
generic-adc-thermal node. However being able to re-use the existing code
in generic-adc-thermal lead me to the current proposal.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (6):
      iio: adc: qcom-spmi-adc5: Add battery thermal channels
      dt-bindings: thermal: generic-adc: Document #io-channel-cells
      thermal/drivers/generic-adc: Register as IIO device
      thermal/drivers/generic-adc: Allow probe without TZ registration
      arm64: dts: qcom: pm7250b: Define battery temperature ADC channels
      arm64: dts: qcom: sm7225-fairphone-fp4: Add battery temperature node

 .../bindings/thermal/generic-adc-thermal.yaml      |  4 ++
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 24 +++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 83 ++++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c                   |  6 ++
 drivers/iio/adc/qcom-vadc-common.c                 | 16 +++++
 drivers/thermal/thermal-generic-adc.c              | 68 ++++++++++++++++--
 include/linux/iio/adc/qcom-vadc-common.h           |  3 +
 7 files changed, 198 insertions(+), 6 deletions(-)
---
base-commit: 6063257da111c7639d020c5f15bfb37fb839d8b6
change-id: 20251010-bat-temp-adc-8539bf0b85bc

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


