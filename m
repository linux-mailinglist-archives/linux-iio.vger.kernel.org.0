Return-Path: <linux-iio+bounces-9260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA53D970060
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 08:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DF91F2374B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52414884C;
	Sat,  7 Sep 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MArLBWK3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910013D53A
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691853; cv=none; b=Bx90wyDIHYeekCqtwjxzaBrB7axUJ+Y5o3pnYDbwr/gXG7eBpvpEBkS99AhOkjvV8nMqS2T3cPVdEskVHfLqdvVi3jpSZrx1VBvzugAtbq8R4ieHGKNnqzE44moZv0/XV6bTJhYvueWM5vMB2gpJ6zbptrRQJN49nTSBlRtu/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691853; c=relaxed/simple;
	bh=leWSQje+ukEc8agXDt91UFlYTYx+/7CTkDdZc0d+tPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpawDaX9WNpE/l/80/iAEOkKx4GECXz9kV3a1uVLsgxFnOBZOhZ7J+Pf06EEgg/iT0hQmN6e6t7FBOlhRgUTvk6N7oJ/9rpKmDeQwTaol1qffdFwlCczvvsAT9KabsHEJOQzgwq51ifN0gXDJQ6emcWXy1k2gZpHcKX2L639++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MArLBWK3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53660856a21so114905e87.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 23:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725691849; x=1726296649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JqF7PWi3iax7JPq5MD9TNOmdUBUg/2y2TKvAmNZk64=;
        b=MArLBWK31xi+jHODwAmflN4qWltATI6c6Efn93n0U7+2AfQWB8fuTYXx1EBexF8dYD
         ECdLh5YfPKYHW/lW1lM5Gs5uJ6g6Z0ri2Thu0lqjlgG6LCmVZbi//P8Q54f+NuJioVlp
         PiSQICvF3zaGJyfCP64uYqekmlySc/KXZwsHEkNn4caEWb1fVU2zJ3HuLkv9jkJhrahI
         1ED2hg9+Nug/wk/4J/6gjSz/J92oJAeCr6cmTYd9G9h8nO3AJ+I15XlqMlcQNClSDP+h
         LD61u57UPlvA/xoxkR4d/mQ4WVIlMWLJTWy2hLSSro5mHZOgflb+W3+zudwo4OVe3aeW
         adzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725691849; x=1726296649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JqF7PWi3iax7JPq5MD9TNOmdUBUg/2y2TKvAmNZk64=;
        b=J6dHenQLP/s8lHyUtjbFcd61FpaHLowCjw2Wxd9OGFAFLTT5TGRFdK0Msbd7FA2qpF
         Zu4psIWXGnlQ5Q8sh9l1It9aP12Yg0tC66a3Y02ooFw4CtVcHPlyjh1h8PohpoAEdWh0
         EwQWcBk4P5oPAWhztYKtqqi77ULEejPz6XuANkGqT0sApDlOIhrMruXHyeO2+qDGnfCX
         T1kGi3f2263BIXn4ORSF+9cp0p4GvAjjMiIH7Zl/tcKVSmZPwrJGbJPiIz3m5MC9/Csc
         PMDXsF3wJpmzN8DL+LFsHSdkncua3zcUtImDe1FBZNPORK/2aOlYzjXQT2shg52t/NX6
         rgqg==
X-Gm-Message-State: AOJu0YzX/ms2Sy0JL0gXznvh4wgFsjGjhgH9JQNOEYGXfhQ4Gth22alz
	Tc3INzMoXL8jyQs/YQqGiFnBFotftE8bOwYoEwpW+LamHvETBjomyB+pNCKIDuoeXNEAatTBQKa
	bJrs=
X-Google-Smtp-Source: AGHT+IGaZymJr/vP+UZobOPpVdjUAMoict+okKsDPTRXN5mqf7+99tIgikuVmr+VFtqEKMj2jmBtdQ==
X-Received: by 2002:a05:6512:1191:b0:536:5515:e9bc with SMTP id 2adb3069b0e04-536587fc7a7mr2720792e87.46.1725691847823;
        Fri, 06 Sep 2024 23:50:47 -0700 (PDT)
Received: from localhost.localdomain ([188.27.130.242])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835a76sm36539266b.39.2024.09.06.23.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 23:50:47 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v5 0/9] iio: adc: ad7606: add support for AD7606C-{16,18} parts
Date: Sat,  7 Sep 2024 09:50:33 +0300
Message-ID: <20240907065043.771364-1-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
The main difference between AD7606C-16 & AD7606C-18 is the precision in
bits (16 vs 18).
Because of that, some scales need to be defined for the 18-bit variants, as
they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).

Because the AD7606C-16,18 also supports bipolar & differential channels,
for SW-mode, the default range of 10 V or ±10V should be set at probe.
On reset, the default range (in the registers) is set to value 0x3 which
corresponds to '±10 V single-ended range', regardless of bipolar or
differential configuration.

Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.

This changeset, does a bit of rework to the existing ad7606 driver and then
adds support for the AD7606C-16 & AD7606C-18 parts.

Datasheet links:
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf

Changelog v4 -> v5:
  - v4: https://lore.kernel.org/linux-iio/20240905082404.119022-1-aardelean@baylibre.com/
  - Not all topics from v4 have been fully resolved; but I created a v5 in
    case it helps to spot other (new) topics
  - Added patch 'iio: adc: ad7606: remove frstdata check for serial mode'
    - This is from the 'fixes-togreg' branch
    - It should be ignored
    - Should help with a bit of context for this series
  - For patch 'iio: adc: ad7606: add 'bits' parameter to channels macros'
    - Added '.storagebits = (bits) > 16 ? 32 : 16'
    - Reduces the final patch a bit
      - i.e. 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
  - For patch 'iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct() '
    - Added 'Reviewed-by: David Lechner <dlechner@baylibre.com>'
  - For patch 'iio: adc: ad7606: rework available attributes for SW channels'
    - Added '.storagebits = (bits) > 16 ? 32 : 16'
    - Reduces the final patch a bit
      - i.e. 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
  - For patch 'dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts'
    - Added '"^channel@[1-8]$": false' if not 'adi,sw-mode'
    - Added 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'
    - Given the change, I would need confirmation that the Krzysztof's
      Reviewed-by tag is still valid
    - There is still an open topic about using
      'oneOf:required:{diff-channels,bipolar}' vs 
      'if:required: [diff-channels]then:required: [bipolar]'
      - I'm leaning towards 'oneOf:required:{diff-channels,bipolar}'
      - Let's see what a discussio will yield
  - For patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - In 'ad7606_spi_read_block18to32()' fixed 
       '.len = count * sizeof(uint32_t)' in 'struct spi_transfer xfer'
    - In 'ad7606_read_samples()' changed 'u16 *data = st->data;' to
      'void *data = st->data.d16;' ; both would compile though ;
      converting 'data' to 'void *' may show that it's not just 16 bits
    - In ad7606c_18_chan_setup() & ad7606c_16_chan_setup()
      - Added explicit 'cs->reg_offset = 0;'
    - In 'ad7606c_sw_mode_setup_channels()' :
      - If pins are specified incorrectly, an error is triggered (vs
        ignoring it before)
      - Updated comment about why 'st->bops->sw_mode_config()' is called
        first

Changelog v3 -> v4:
  - v3: https://lore.kernel.org/linux-iio/20240904072718.1143440-1-aardelean@baylibre.com/
  - For patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - Added 'Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>'
  - Renamed patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    to 'dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts'
    - Updated based on notes from Krzysztof Kozlowski (from v3)
      - Dropped ()
      - Re-ordered the patternProperties:oneOf:required specification
      - Unified match-pattern to '^channel@[1-8]$'

Changelog v2 -> v3:
  - v2: https://lore.kernel.org/linux-iio/20240902103638.686039-1-aardelean@baylibre.com/
  - Applied checkpatch.pl changes
  - Managed to setup and run 'make dt_binding_check DT_SCHEMA_FILES=adi,ad7606.yaml'
    - Found the winning combination for this setup
    - David Lechner also helped
  - For patch 'iio: adc: ad7606: rework available attributes for SW channels'
    - Removed an extra space that checkpatch found
  - For patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - Removed 'the the' stutter (that I did in writing)
  - For patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    - Updated binding with some description for 'diff-channels' & 'bipolar'
      properties
    - Channel definitions are counted from 1 to 8 to match datasheet
    - Added more bindings rules for 'diff-channels' & 'bipolar' for AD7606C
      - Adapted some ideas from adi,ad7192.yaml
  - For patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Updated 'diff-channels' property with channel numbers (from 1 to 8)
      handling

Changelog v1 -> v2:
  - v1: https://lore.kernel.org/linux-iio/20240819064721.91494-1-aardelean@baylibre.com/
  - Fixed description in 'iio: adc: ad7606: add 'bits' parameter to channels macros'
  - Added patch 'dt-bindings: iio: adc: document diff-channels corner case
    for some ADCs'
    - diff-channels = <reg reg> can be used to define differential channels
      with dedicated positive + negative pins
  - Re-worked patch 'dt-bindings: iio: adc: add adi,ad7606c-{16,18} compatible strings'
    - Using standard 'diff-channels' & 'bipolar' properties from adc.yaml
  - Re-worked patch 'iio: adc: ad7606: add support for AD7606C-{16,18} parts'
    - Reading 18-bit samples now relies on SPI controllers being able to
      pad 18-bits to 32-bits.
    - Implemented 'diff-channels = <reg reg>' setting
    - Removed some bad/left-over channel configuration code which I forgot
      during development and rebasing.

Alexandru Ardelean (8):
  iio: adc: ad7606: add 'bits' parameter to channels macros
  iio: adc: ad7606: move 'val' pointer to ad7606_scan_direct()
  iio: adc: ad7606: split a 'ad7606_sw_mode_setup()' from probe
  iio: adc: ad7606: wrap channel ranges & scales into struct
  iio: adc: ad7606: rework available attributes for SW channels
  dt-bindings: iio: adc: document diff-channels corner case for some
    ADCs
  dt-bindings: iio: adc: add docs for AD7606C-{16,18} parts
  iio: adc: ad7606: add support for AD7606C-{16,18} parts

Guillaume Stols (1):
  iio: adc: ad7606: remove frstdata check for serial mode

 .../devicetree/bindings/iio/adc/adc.yaml      |   4 +
 .../bindings/iio/adc/adi,ad7606.yaml          | 117 +++++
 drivers/iio/adc/ad7606.c                      | 432 ++++++++++++++----
 drivers/iio/adc/ad7606.h                      |  80 +++-
 drivers/iio/adc/ad7606_par.c                  |  48 +-
 drivers/iio/adc/ad7606_spi.c                  |  71 ++-
 6 files changed, 633 insertions(+), 119 deletions(-)

-- 
2.46.0


