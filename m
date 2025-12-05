Return-Path: <linux-iio+bounces-26809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B924CA9430
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 21:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D86C3066DBF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 20:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDC2DCF46;
	Fri,  5 Dec 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEnGdXUV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9752C17B3
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966494; cv=none; b=sHRl05EaPQXygaq72gkFuqM7tCENRkrrukBsH/REeMhdYiL9084Uoi4jAaUH04KIi8nCL5B8Hd96f0+TOsl4c8YWYU9+MXOCQOm7VfxwjJoCFW92ChFns4h4x8NfhiMTNpqiTqRORSCIaJDlHZTNmTYd+8RKKuAmA/xALP4Mw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966494; c=relaxed/simple;
	bh=EVOhk1HI6FciASKyQp7+FOie/7X+cAATsS5lmRg1qfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbpkJur92LQ/trh5+9k2UmBpRa/0oaeKKw6gSBtOOw3yBukCKoACFdVgd/6uFz4wn3qkmB9+OkVeU1AyaM3fFdVk6BOL0jMe6YMlOX2SKdfIWLcqyfawk4dDIMyZArOOqhATVDPcgzbR3QL2qK0S5pC0yWS3eSIdITXEDau7kAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEnGdXUV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2955623e6faso34664995ad.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 12:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764966492; x=1765571292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdEQYEeEhg+Pxb0AQxBFfKIUgC+j17YfvZoVKrA407E=;
        b=AEnGdXUVRhpew8isONlRzdg21vZAj8cfIOYo8LhLaevJJ7+LS5TEzepZUSFTEEK7WN
         0bB3FXitKY9sNTVM2OtoBu+zYPx8uoYyQgJ1kDeXyy14u3URPM9m5S3p/8tr697LhRsE
         hbvMebovHNnMUZaIO7DPPhKMaBiGSpF5uUjiZrYnRBT5EAzU0rnrIr1+AsAhDskAmLdl
         BbTpPZpFQ1CvEuSU3h69ma/jsLIrSM0Ut9l09A+yreBlObFObbe7fDOCGrb9S1/a2cDH
         yxWyD3ZjOImlMgp+962SqXbCDnzoXHq0k3eaGWtxd4Yxekk3ZCPNHGS2A6ZBmfjr4rWN
         h70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764966492; x=1765571292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdEQYEeEhg+Pxb0AQxBFfKIUgC+j17YfvZoVKrA407E=;
        b=GqQ5kayrq9PD1ld1UFTdchQ8xIKX0atHSdpwUXt3OSScTzfwivs0+qUKU2PMyy+XQV
         jeSorJxDn6wEjJAx1OHJQge6NpOiYJV9KysCUNz9onEWMo2Z/4GMUVBuHVHM63hv+qgT
         FoKr0wki3LMvxtAu2bor23ca414cTyYg4AJSe0koxNUzGdkm7Yo3ovxZ6himCxrlJd8p
         njt7TFJUuu84S455S9fAcRJq1bpHaHT/jssUpebgfvK/Osme4lZjV0vdvDsLOMsJlw0H
         IYOfUCkeVn04ELCTPJ7JSWwEenXN/ZeqGq2UfbF5wWDnbbxmMLZvhlmoRf7Sl8ogvDvk
         j9Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWdtSTrHhI2nSdK4VAYLVY4Oh9LaV/h+BNlBjXb7hvfMPMbXynGsJvnHq33gAgS9EFscfvmgIC3cFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRqrvXPwF9sctxcnXdrFZDzq72rElD9TDwuwtIoEVvuivydIx
	w3gwMMONZiA4CGq7xEEnUco0m5rioF6QiAhPdCjQMk0xG6MnBsnvqp7mJHG+9r78Ss8=
X-Gm-Gg: ASbGncv3F+E8tkZwmpTWCo43jWwHv1e8H4jEWwjheEhWO006FHC2U9QjvsJ/ut9NPml
	I6+0ChhNc9OZESMN2p8btjG5y3bpfatrA/Ti4EEBk4KPKtrV3qC8Flla7q1zCsVDbjpAexKKbuy
	wk/5L2szHoBI5YsAPG3znGDgmDuIsRdd/R8pIKSgvEmmm0y9ztgeu5eWdaKszkQkB8xNZraLMft
	0iS0hCCX67TyBnNnYgMI/VMTGOHsUZSFn5Rs70hZ0RumdE6m6jpSHqruASwy43LjCVlbK/em0Ch
	TBiFNDpaglL6B6pSA1Y0V+TnIns4JEJMtQ5FRKXXk6mjxywnM5JWcqrUEhxOZxwgX9rjltpnnZo
	5wRh0+Q+w+2eAxus1aBpJ8mCd/TnJ0Y2utOLHdQH32xkEhfxnsL661BkaGL40MNbs3ECwNQLO5g
	02xSIc7AhgflpDTDXpG6fdccjBTi7YOkP0gayMNZ2rjqKsYqwfVbycKmKO3IWJWFRGyQHsw465t
	TzGPFpqNuuYKR0kDEFx1dSvolw44tRKmY6O8mLJIpmJ1twFurodpp2u5c+kdtRFi3Pu56mR
X-Google-Smtp-Source: AGHT+IE7SZxJEEgg2GMHkTTXb7pxe8bAQ0ErqGaRLH8Fgf3Ui7YDuS3yTvPgzhY3cUjHgxCL6TCIsw==
X-Received: by 2002:a17:903:3510:b0:298:3a2f:2333 with SMTP id d9443c01a7336-29df610f3eamr2230825ad.31.1764966491847;
        Fri, 05 Dec 2025 12:28:11 -0800 (PST)
Received: from Lewboski.localdomain ([181.191.143.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99fa59sm57256845ad.58.2025.12.05.12.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 12:28:11 -0800 (PST)
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Tomas Borquez <tomasborquez13@gmail.com>
Subject: [RFC PATCH 0/3] ad9832: driver cleanup
Date: Fri,  5 Dec 2025 17:27:40 -0300
Message-ID: <20251205202743.10530-1-tomasborquez13@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a general cleanup of ad9832, with the purpose of 
graduating it from staging. The main changes are removing legacy 
platform_data support, converting to IIO channels with read/write_raw 
callbacks, and adding devicetree support.

I'm sending this as an RFC because I have some concerns about the ABI 
design and would appreciate guidance before putting more time into this.

Patch 1 removes the legacy platform_data support as suggested by
Jonathan [1]. The driver now initializes to a safe state and lets
userspace configure frequencies/phases via sysfs.

Patch 2 converts frequency and phase configuration from custom sysfs
attributes to proper IIO channels using read_raw/write_raw callbacks
(This is the main area where I'd like feedback).

Patch 3 adds devicetree bindings documentation.

Design Concerns:
1) Channel Organization and ABI Break

   The device has 2 frequency registers and 4 phase registers. Since both
   frequency and phase must use IIO_ALTVOLTAGE since there's no better fit
   (as far as I know), I've organized channels as:

     out_altvoltage0_frequency  (FREQ0)
     out_altvoltage1_frequency  (FREQ1)
     out_altvoltage2_phase      (PHASE0)
     out_altvoltage3_phase      (PHASE1)
     out_altvoltage4_phase      (PHASE2)
     out_altvoltage5_phase      (PHASE3)

   The old ABI used out_altvoltage0_frequency0, out_altvoltage0_frequency1,
   out_altvoltage0_phase0, etc. 

   The new approach felt cleaner but I'm open to alternatives and better 
   ways of mapping them. Is this channel mapping reasonable, or would a 
   different organization be preferred? And is the ABI break okay?

2) Scale Attributes

   The frequency scale is 1 Hz and phase scale is 2*PI/4096 radians.
   I cannot use info_mask_shared_by_type for IIO_CHAN_INFO_SCALE because
   all channels share IIO_ALTVOLTAGE.

   So instead I'm using IIO_CONST_ATTR for the scales:

     out_altvoltage_frequency_scale = "1"
     out_altvoltage_phase_scale = "0.0015339808"

   Is there a better approach here? Or should I just document the units and
   skip scale attributes entirely?

3) Remaining Custom Attributes

   Other controls remain as custom sysfs attributes:

     - out_altvoltage_frequencysymbol: select active frequency register
     - out_altvoltage_phasesymbol: select active phase register  
     - out_altvoltage_pincontrol_en: hardware pin control enable
     - out_altvoltage_out_enable: output enable

   I'm not sure if these map cleanly to IIO interfaces. Should these be
   documented in ABI or is there a preferred way to handle them?

4) Implementation Notes

   - read_raw uses explicit address switching rather than channel index
     arithmetic for clarity, though phase values could alternatively be
     accessed via st->phase[chan->channel - 2] and directly in freq with
     st->freq[chan->channel].
   - I'm unsure if mutex guards on cached reads are necessary.

Link: https://lore.kernel.org/linux-iio/20250628161040.3d21e2c4@jic23-huawei/ [1]
Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>

Tomas Borquez (3):
  staging: iio: ad9832: remove platform_data support
  staging: iio: ad9832: convert to iio channels
  dt-bindings: iio: add analog devices ad9832/ad9835

 .../bindings/iio/frequency/adi,ad9832.yaml    |  65 +++++
 drivers/staging/iio/frequency/ad9832.c        | 264 +++++++++++-------
 drivers/staging/iio/frequency/ad9832.h        |  33 ---
 3 files changed, 233 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
 delete mode 100644 drivers/staging/iio/frequency/ad9832.h

-- 
2.43.0


