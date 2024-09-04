Return-Path: <linux-iio+bounces-9152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BC96C73B
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673F81C25159
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C71E4939;
	Wed,  4 Sep 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ryUyajmQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AD61E491A
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 19:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477265; cv=none; b=PjtKgfOKThj/RRKykoM61VznABEWcPV7UMznVTzaPcImgBpvN6IQEt5jhpKzljYjoKUKVplMoOtM8048W3O6VpPAhIFYIPWfq8h1KfprMDmOehjEy7Iu4KJ3UT7TxSY5vM6oyMHOZJXblzdPFuk1jAKTIOEv4OaOkgHQM/6kouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477265; c=relaxed/simple;
	bh=Vtten7PC1xqHnHPuVTSUmBPwlkryC6zBmnXV+zy4KR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y8ZdIh+u10npTweSg0IxljQIHfuh27nxHPX2sdiTCDWhH8zeagdHxVQTHc4DLnVR8Z54RjIESKJ8v27N9/BXHa88Rbv7Iba0wskgjs3sjfAW3OkvxO04pbG1pLgFjMIqfdy2nua7iuCUIllwzgAqJUloCnLwo0Jvm4CmX70FS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ryUyajmQ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-277c28fac92so429fac.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725477262; x=1726082062; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=icxQYjZ5lhVTHRZxV1n+KW9S/3qh7ut35wj8uDEJc2Y=;
        b=ryUyajmQc7l7hy5gXHPISS2rwADV9Be29M6OIoQWgDQT4nRJRIpCcMzfpUvtZtvNRQ
         vGbLWV+4Ov4G89ThR3bguw0Lqx4T+NvlpMNFILIkcMf/ERGsV+bACPTbMxytgqu0kxxi
         yBKTxGG+YS34Jk0dTvp1k2vhOT7Gj8sTDuTL7dlx2rqdGwZdnNhz1G2gr4KUJRdqYyRw
         Yn7Q9gCGcejQusTw2BnemXPe6pEQFazjMl/0zsOt1nEbFtmg0tOnmTbpRJLXhahxQB1m
         yYO573CAvL/GylY/cc+luRApdFLfWQ3b3BBtvjXjJPJAF2d5i3y05aWGh4BvW1N19/8q
         qQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477262; x=1726082062;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icxQYjZ5lhVTHRZxV1n+KW9S/3qh7ut35wj8uDEJc2Y=;
        b=FOw+gLI7U+HrWw6dMWc1kI8lBo90CxldzO4I171/Ugr6nv+w8w8ZAGmilqXst6V/u4
         6d06rfoC4mnd2FDyt8VWG5L5ckBbN0NVg378u5WyDzWFRxoGKHWM7UbWx5eFrr3h/SKA
         E/GHPjnege4EElk7JuvROXcZhOeXMDQVkQdJNCV8GPagmyqibx484Vbof6yP/xJsQmwN
         riz5aoO5Liza3eaCL/nUSo81s2GznTfmVNd8OMnzTi2zadu/QxelQ81sUU8jrYYvUo0f
         Uuia0hyV3R+2yYagxQtK2K0YiIIJUlVPH0W564KPacm+ix0rLrdDSFTxRYZRqfpBwcu9
         IRnw==
X-Gm-Message-State: AOJu0YysWnd21BZ1QXxGvmc/dsP/hkiD+AkZIJ9yD4NJZyDMfXkZTQ37
	hR4zJPVR7B79E4Rj++Z06PlrKidSoC2IN7ooBXUBi3guCQPYWlD/rafZEtx8HVk=
X-Google-Smtp-Source: AGHT+IESzRKYSh7VbzJurKo07781IgfN0d2D3CHqQv4yUKjlusFL4WO3+KU5g7ujtYaN/T6E8/7FeQ==
X-Received: by 2002:a05:6870:910a:b0:278:8fe:6293 with SMTP id 586e51a60fabf-27810b246c2mr9305971fac.1.1725477261565;
        Wed, 04 Sep 2024 12:14:21 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f026caesm8861085a.135.2024.09.04.12.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:14:21 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v4 0/3] iio: adc: add new ad7625 driver
Date: Wed, 04 Sep 2024 15:14:17 -0400
Message-Id: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAImx2GYC/23M3wqCMBTH8VeJXWfsTI+bXfUeEbE/xxyUxhaSi
 O/eFCKLLn+H8/mOLFLwFNl+M7JAvY++a9MothtmG91eKPMubSa4KLjMeaadLAWeA2QldyBJC1W
 hYun/Hqj2z6V1PKXd+PjowrCke5iv7wqsKj1kKQpUU41aaFMdjB6u3gTa2e7G5lAvPljxao1Fw
 rVCktqqHJD/wfkKwxfOE5boUIC0sjT4g6dpegHD+Oj7HwEAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>, 
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

This series adds a new driver for the Analog Devices Inc. AD7625,
AD7626, AD7960, and AD7961. These chips are part of a family of
LVDS-based SAR ADCs. The initial driver implementation does not support
the devices' self-clocked mode, although that can be added later.

The devices make use of two offset PWM signals, one to trigger
conversions and the other as a burst signal for transferring data to the
host. These rely on the new PWM waveform functionality being
reviewed in [1] and also available at [2].

This work is being done by BayLibre and on behalf of Analog Devices
Inc., hence the maintainers are @analog.com.

Special thanks to David Lechner for his guidance and reviews.

[1]: https://lore.kernel.org/linux-pwm/cover.1722261050.git.u.kleine-koenig@baylibre.com
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/chardev

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
Changes in v4:
- Link to v3: https://lore.kernel.org/r/20240819-ad7625_r1-v3-0-75d5217c76b5@baylibre.com
- Rebase on top of latest pwm/chardev branch at:
  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/chardev

  [PATCH 1/3]
  - No change

  [PATCH 2/3]
  - Add 'depends on PWM' under 'CONFIG AD7625' in
    drivers/iio/adc/Kconfig, based on v3 discussions
  - Cleanup whitespace usage in Kconfig, bandwidth logic to match
    Jonathan's suggestions

  [PATCH 3/3]
  - No change

Changes in v3:
- Link to v2: https://lore.kernel.org/r/20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com
  
  [PATCH 1/3]
  - Add gpio bindings header, en0-gpios and en1-gpios to binding example
  - Remove unnecessary comments

  [PATCH 2/3]
  - No change

  [PATCH 3/3]
  - No change

Changes in v2:
- Link to v1 (marked as RFC): https://lore.kernel.org/r/20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com
- Include link to required PWM patch series in cover letter (missing before)
- Include new link to the pwm/chardev branch of Uwe's kernel tree
  
  [PATCH 1/3]
  - Rework dt bindings to be compliant using make dt_binding_check
  - Add "adi,no-dco" flag to address indication of how DCO lines are
    configured
  - Fix binding patch message
  - Remove chip packaging info from binding description
  - Move comments around to be clearer

  [PATCH 2/3]
  - Remove ad7625_pwm_disable(), call pwm_disable() directly
  - Add ad7625_buffer_preenable() and ad7625_buffer_postdisable()
    functions
  - Add devm_ad7625_regulator_setup() function, move all regulator logic
    to it, consolidate the comment blocks related to it above
  - Add have_refin flag in ad7625_state struct
  - Add pwm_waveform structs to ad7625_state struct for storing
    requested waveform characteristics
  - Refactor ad7625_set_sampling_freq() to set the pwm_waveform struct
    values in ad7625_state, limiting PWM enable/disable to
    preenable/postdisable functions
  - Remove redundant dev_err_probe() after devm_ad7625_pwm_get()
  - Use device_property_read_bool() instead of device_property_present()
  - General alignment and line wrapping fixes

  [PATCH 3/3]
  - No change

---
Trevor Gamblin (3):
      dt-bindings: iio: adc: add AD762x/AD796x ADCs
      iio: adc: ad7625: add driver
      docs: iio: new docs for ad7625 driver

 .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 ++++++
 Documentation/iio/ad7625.rst                       |  91 +++
 MAINTAINERS                                        |  11 +
 drivers/iio/adc/Kconfig                            |  16 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7625.c                           | 684 +++++++++++++++++++++
 6 files changed, 979 insertions(+)
---
base-commit: 1ebd3850421749eb44bd040b249bd4db88d35b33
change-id: 20240730-ad7625_r1-60d17ea28958

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


