Return-Path: <linux-iio+bounces-19930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4032EAC3D97
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3641897B77
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C71F4C96;
	Mon, 26 May 2025 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M4g5Y3nW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F91F4262
	for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253885; cv=none; b=hADKa7lDKEUGtrGZ0wXsCNIxmQGV0ZAVdn7Pc1ss50iIkqwRlKET7W50Lh7NvSF9T9K3arpL9xB3pTi9gI4zNqKXWNwQBaNrtwngctiOuimY08Yc3uO8eTq/OF5rdca7ZfRfDkBHbo3m6eTxLFSw5QGmdiWOVSNZxWviaKYdyoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253885; c=relaxed/simple;
	bh=eSK6YZcLQNcfWyBCA5lDtS+FZisIhv1cZBflT0atmTw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fB3qbr7wVW/rm24w8siUumaO428scfaq42Sm2ZyegdaCC/tjdRcv0n/wn/Yt+9MZe0M/6f2me+qHEyqbxj4Is91OS2poOzdjQavSMMTZyiYJlc4CfBqrA7cgCRxKkdGE6KYZE3WooMu2oP2KxLWAmrG2oFbyJGAG6/u+YO1DZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=M4g5Y3nW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a375d758a0so1791023f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 26 May 2025 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748253881; x=1748858681; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DV2U6idgVojBbiD7oQDIMDL4s90BH7rw7O7YWkBzKdA=;
        b=M4g5Y3nWO370Zacw7hWSenWJoRdKlSf5imPCM1zFvWuGmSlfBnFhsLCsjhgWaxe+6l
         BqXEwDXDgZnvLvpJwuKgaw6FbgdwM6U9qrFQKkTD8rAzWxjQjbx7JfJ7Y1To/StghCxo
         NjViCAm54A2x8uET7VOUcZrn0HDsrD8X1EFZhTid+kiwzHYDdULrc1AlpiRDzxIoi7UZ
         Efdh+9nR+ue9obvZKdwKzzgiBDOeKaH50NT7kPcSGpN2nxHZDQNo6PSy0qN9uY547vMU
         gIbapzhdR7KDDWHeFLRFCylRiwbykkTAOd1Lod9ZtufiakAdYmsentReXYr9ybU9R/Cg
         2RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253881; x=1748858681;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DV2U6idgVojBbiD7oQDIMDL4s90BH7rw7O7YWkBzKdA=;
        b=hhfZnOR3oTYpOhly0ZvlCsWM7yPxEI/xTuustzpv/iP9uCjUVEqX/HPpTuV+VQ79mM
         2ZQnbWBG76e0fplYgZw+nlByNjLc7Fb1GqckAgaN6epdXRTN9cZq3EqnRjD9+DTZhLPQ
         INGJCo1vVakueUpW4KY0+WWntsRY/i8q/18mMH2lNmcIpQy+7IiU2W4PPn++auouULTK
         kXxZySlmTqEkdtaf5PE6ezyuwz6IBNrampWwWB4YhrHRWSuM4M/TGthgIxdbh2E3MqkW
         XwfzfhZOiZNrWH1S0Sb/l+zwzoxyfZmD3n3xvRk/NsH3uUV33xDDIxlng7HZnTdbBlzR
         5Jqg==
X-Gm-Message-State: AOJu0YzkARJFv2ARau+kh2x0r9EGCx1RQpPhS1u8vtYMVPaejM240oMI
	nwxfNAdKvhv6u4mbU+jJCN0JuRYNYKN31bd+2BeCm8m9UwlfX/A17SZDj38Hl3IVFD8=
X-Gm-Gg: ASbGncuMtIqWK7wgjCWQjVfhvv4ODjibMqtbV9k4SYibErETI9xX/1GTN/Fv4JIpk8o
	1jgLOwXczeLe7VkkEzYoXZpV7k+2dBcu6tvh4yH7cVwARXmfkPs13euia1ID0dsaPnqUen1Ievl
	Q1WIa6u7Oolbm5F2p83e4YEp7J/Kca4VczWvU3RBBTBttA32i17/f7hZBwA885/8X+E1mMDZOI3
	x9sedowkxd34bB3i9soRXJm091j3/doKfgAoFLd7Bows9AAOphebWINFpgxKoHOX19UHhtk0WTo
	6irGEy1JF4104Rd8dqSnmYE3xpzbf2zr7Cx8lrod8zcQRH3lnL6XltbThzewfnaNIDdKweUvmBn
	QKDsMIN0dNtfwjovcL0sQoEDDPwGeKqE=
X-Google-Smtp-Source: AGHT+IGPPusAGdBj+JyaVRhQQ6sAZOIsx4vzH7PAiLud1ABGfWxc4dBci9VDUB4fBJQIrwDdRYc/Uw==
X-Received: by 2002:a05:6000:4027:b0:39c:1f02:5409 with SMTP id ffacd0b85a97d-3a4cb4619camr5820777f8f.9.1748253880831;
        Mon, 26 May 2025 03:04:40 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca888fcsm36141834f8f.78.2025.05.26.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:04:40 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v7 0/6] iio: adc: add ad7606 calibration support
Date: Mon, 26 May 2025 12:03:15 +0200
Message-Id: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGM8NGgC/43QzWrDMAwH8FcpPs9Dlvy5095j7GDH9mromuKUb
 KXk3ef0sjCC2fEvoZ+E7mxKtaSJvRzurKa5TGU8t2CeDmw4+vNH4iW2zBBQgUTHv8qFhxP30Wj
 QfPCnEqq/timO4Mlpr4EUsjZ/qSmX74f99t7ysUzXsd4eq2axVv+jzoIDT0FGaVEEYfA1+NvaT
 s/D+MlWeMZfTAH2MGyYMDJE8BmsCDsYbTHdw6hhOgUTdDJIYHYwucVsD5MNc8JTRksm6b3L1AY
 T3Z+phklQMg9mcJniDqY3GHZ/plfMmuBAEkUPf7BlWX4Azz2OqUYCAAA=
X-Change-ID: 20250429-wip-bl-ad7606-calibration-20a396a60352
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3377;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=eSK6YZcLQNcfWyBCA5lDtS+FZisIhv1cZBflT0atmTw=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgwscnecHDetTezxVZkrj1a5fzq4urwyu/tLLxO7rM6J
 /AKt15r7yhlYRDjYpAVU2SpS4wwCb0dKqW8gHE2zBxWJpAhDFycAjCR93sZGRqnrNb48dpgVo3/
 lfVHs5X/xu9dsGhCepHFk/TM03fst71m+O/p8O+j6uzzthb7Dt4+HxfQ26UtefSJM5fMH6bbe9h
 qJnIDAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Add gain, offset and phase (as a delay) calibration support, for
ad7606b, ad7606c16 and ad7606c18.

Calibration is available for devices with software mode capability. 

Offset and phase calibration is configurable by sysfs attributes, while
gain calibration value in ohms must match the external RFilter value,
when an external RFilter is available, so implemented through a specific
devicetree "adi,rfilter-ohms" property.

This patchset depends on:
https://lore.kernel.org/linux-iio/20250505131544.0a7477a2@jic23-huawei/

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v7:
- Fix each wrong commit desc. occurence related to convdelay.
- Fix ABI documentation with better words.
- Fix wrong comments in driver source code.
- Add r_gain default before reading the fdt value.
- Link to v6: https://lore.kernel.org/r/20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com

Changes in v6:
- exit for error in case of fdt that breaks the dt_schema,
- add (5/6) patch to fix the above on older code too, 
- Link to v5: https://lore.kernel.org/r/20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com

Changes in v5:
- fix tab/spaces wrong formatting on ABI doc (1/5),
- fix description in ABI doc (1/5),
- fix code multiline alignments (3/5),
- fix calibration offset calculation as oneliner expression (3/5), 
- Link to v4: https://lore.kernel.org/r/20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com

Changes in v4:
- fix ad7606_chan_calib_gain_setup appropriately to be called once.
- Link to v3: https://lore.kernel.org/r/20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com

Changes in v3:
- fix dt_bindings,
- change sysfs calib_delay to convdelay,
- fix sysfs documentation accordingly,
- used u32 for reg and r_gain,
- used DIV_ROUND_CLOSEST for setting r_gain,
- minor syntax fixes,
- Link to v2: https://lore.kernel.org/r/20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com

Changes in v2:
- change phase_delay to calib_delay,
- fix dt_bindings,
- fix gain calibarion fdt parsing,
- fix ad7606c-18 calib offset range,
- fix calib offset calculation,
- fix calib gain range,
- Link to v1: https://lore.kernel.org/r/20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com

---
Angelo Dureghello (6):
      Documentation: ABI: IIO: add calibconv_delay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: exit for invalid fdt dt_schema properties
      iio: adc: ad7606: add gain calibration support

 Documentation/ABI/testing/sysfs-bus-iio            |  24 +++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  29 +++
 drivers/iio/adc/ad7606.c                           | 218 ++++++++++++++++++++-
 drivers/iio/adc/ad7606.h                           |  12 ++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 6 files changed, 279 insertions(+), 6 deletions(-)
---
base-commit: 789fd0b1a017f1582fee73effb5cfa740ad6569b
change-id: 20250429-wip-bl-ad7606-calibration-20a396a60352

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


