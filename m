Return-Path: <linux-iio+bounces-19657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B66ABBACE
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 12:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10F53AF936
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE692749EA;
	Mon, 19 May 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CbAP2At6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271FF274646
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649735; cv=none; b=soyIOCJE5XLo/DhfiMUksV7NjZvjxcdepihDDjZq5xm0oE8BOahskV62QEbghaAPlxqJD8FwDTQW1VSSRcAxrFKnhgenEcC4eBNFM1zUFpJlqJJjQXZnFEMlazhIhHBiQ1exT12pnj03RPUje0jNgfbm/wsc3tqa/Qen7GKIH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649735; c=relaxed/simple;
	bh=81wMAJHRIrHMCayqIPjQjUtl0Nj/1hvPvhfNOZtFLms=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XlkqBGKn5W4b0f04vyzH+cvdJs+OHLtkxZmF3kbUarMmr9d8awUXDva8hiiQ0JBnW0+Cxpy0vjxWRxfjFC0CMkuTpPD1at+PiN1l+ksj+iaPcNTXIYPY0RDlGjxbXuq501LFtYhKOCDyaBi0RAFYf/GGjMGF/1Nf+vwm9wBmfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CbAP2At6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a361b8a664so2815688f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 03:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747649730; x=1748254530; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bL6XRK5W1eljgJJLaQTj6SKuAJ6xYPHv6VkT5/28cuc=;
        b=CbAP2At66Maba3Qlm9NjLzAczDQvLxshaFmeQEgqz7bf31E/7Txp6Oh5l8EL6KCSen
         eQO0kRI7heNgUanCgk6BZxci/mVsPUb/pQFrKnROBapfkJk/de4nuJt0B8wY9gKEQ4ug
         YBDj0FAvtYjCUn/Hw5ijrJkBOy7jMmAvoVInpuADenq0GMqfY0XIGplEC3kejwEO/+vr
         tgseqmesOCGHZx12KDlnV64Vez+jXdbQLjGeEAnos8CKJPBad2+17KkGI3z3AZpS+ed5
         VwbuJat/S096mTw536k6syj+MVvdexy3jkkTDXTWJSRjRB29nzHNLON2OSQdiCcayGa2
         WhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649730; x=1748254530;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bL6XRK5W1eljgJJLaQTj6SKuAJ6xYPHv6VkT5/28cuc=;
        b=Rnb0Zib2dG++DlH4A/rniv7fv6nm1Pi3O8IhRgfhQxK1o8ir9VxHYTGCSm6hkWw0zS
         mCrxwRGPOj5HJJUhfuH9JdwrXg/9Rb+q80k1/9LRvWkp5jZSWdCdrpSu3dBScDYgCQN9
         9FlcM9L1ggR3Hebyt/p/5T4lGhwTldYJq1vI+qnK8WyYyMewsbV5eKYX9Ry/LeSmdTXJ
         9uzxhWnV0I+ML9kJVzODESAVxV/B+aRO2NDidDD6c8oE76k5Y8fyVV/AGMX0F9hJkJn/
         mLtXKYBaDkavO4SlW+MkgSyPtbW8s6RSuNMFhMygfFXtU13LpG8NFE4bCfPvUsrbK3UZ
         QntA==
X-Gm-Message-State: AOJu0Yz0MAHGtg6IxBsTWVZR4R38lqRUCzWqOG1TWcr8cLbxuWOhzNzF
	WNuJfOGnQIyopw2z9FhISSr6ZsFJpqnZNdqpRD673HK5zdYA3zeHCKMOIc3Lrgz/DSg=
X-Gm-Gg: ASbGnct6jXnTwEvLfCLdKHyypGeUZmsHnjDhJnNMv69GndMiiSJtawc1wb+haFnkdSs
	rrGGi5g5MY4W5Lb80sCQFLw0NOYq5dj1F62vXkbYreT/NpGIi6MWICraw4fTk5oAg0MBvUqVhKY
	3JwlRdTSokW89S8uocVDaCxTs1/RxBiyKJLI8922OwoTMO75s6Qw9Kdbwfjl/quNtttoEG60U2v
	2RWqBkgHIw0nHjxLhWdTBS+jtDYBF2HInKQ3wMzv9kWHXU7fDTC6927sJWe6NY2DH8q1w2W8/4l
	1MvGej74UzsVTX1FLsUMZJHpsZny/C3+9uYjQzAm28tTBBmZEMVx/cHkCqsfvUaqxRsGORp1YwC
	KQGVuuj9nCq2OpW8rP2eE40y45CWwGULVeIsJbiaW/g==
X-Google-Smtp-Source: AGHT+IHMFdLeqsl1keutJvetsz/HQeuyO7zwQD9r8hsOkWyMELeJ+qBkrO9PQDT8yLNTYvW2Iak2rg==
X-Received: by 2002:a05:6000:4308:b0:3a3:7435:9a32 with SMTP id ffacd0b85a97d-3a374359cc1mr1362043f8f.40.1747649730398;
        Mon, 19 May 2025 03:15:30 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm12499021f8f.11.2025.05.19.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:15:29 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v5 0/5] iio: adc: add ad7606 calibration support
Date: Mon, 19 May 2025 12:13:37 +0200
Message-Id: <20250519-wip-bl-ad7606-calibration-v5-0-4054fc7c9f3d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFEEK2gC/43OQY7CMAwF0KugrAlynDRpWXEPNAu7dSES0CpFZ
 RDq3SdlMwihiuW39Z/9UIOkKIParh4qyRiH2F1yKNYrVR/pchAdm5wVAhbgsNK32Gs+aWqCB69
 rOkVOdM0tjUC28uTBFqhyv0/Sxt+nvf/J+RiHa5fuz1OjmaffqKPRoIVd40o0bALumO7zWjZ1d
 1YzPOI/VgAuYZgxExw3QC2Uhj9g9hXzS5jNmBcO7CWghfABc69YuYS5jFWGbIulDeLfP5um6Q+
 oxUFdrAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=81wMAJHRIrHMCayqIPjQjUtl0Nj/1hvPvhfNOZtFLms=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQZgle8X1+0EV+U5mgXSsnJCSf87vNLBGiucs60WVfE
 uc31r0fO0pZGMS4GGTFFFnqEiNMQm+HSikvYJwNM4eVCWQIAxenAEyklouR4Xi3/3POd45tvscy
 u+rkE+57VO7b6HhknkP7F7mp844JpDH8T3F4/lfPUN/Yo8vr6y3DdLkDVtPfLT52YR+ftPu0XZH
 fWAE=
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
Angelo Dureghello (5):
      Documentation: ABI: IIO: add calibconv_delay documentation
      iio: core: add ADC delay calibration definition
      iio: adc: ad7606: add offset and phase calibration support
      dt-bindings: iio: adc: adi,ad7606: add gain calibration support
      iio: adc: ad7606: add gain calibration support

 Documentation/ABI/testing/sysfs-bus-iio            |  24 +++
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  29 +++
 drivers/iio/adc/ad7606.c                           | 221 +++++++++++++++++++++
 drivers/iio/adc/ad7606.h                           |  12 ++
 drivers/iio/industrialio-core.c                    |   1 +
 include/linux/iio/types.h                          |   1 +
 6 files changed, 288 insertions(+)
---
base-commit: 7ad2a2f59802461dd18f641482e5da808c32180b
change-id: 20250429-wip-bl-ad7606-calibration-20a396a60352

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


