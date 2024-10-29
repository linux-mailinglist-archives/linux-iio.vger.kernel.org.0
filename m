Return-Path: <linux-iio+bounces-11564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF49B4BCC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80083B2352F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE719206E94;
	Tue, 29 Oct 2024 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKw1WogJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6663DBA2D
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211224; cv=none; b=kcwgfu9DJTjDzHFD6356/kvKOLD8lVk7QmE3iazb7e2GERgv1YSYDJJ+RpJqAOkQdtDgbTezARKl0/FcUXWZYO03gLI5luPsL78buk/syLK/vDpp8PeRmj6nr+W8Psy8jlNbA6SW9nT6mCBVgDfjMR8jNa2Z/Pzk0SKb3X8GF5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211224; c=relaxed/simple;
	bh=yIh3linMpn2cGg6hYf730Yb43InblY6sidZueyopoFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rmdhwk98R6UtYD2cLbnYBvcS4+mIiW1kIV/vJ97H5bE/RcQ+bwc+kpBVSOhfkps92M5CIJ949cSkkS+jUQfxpJUUxaCSs/C65rFGqQ9ft6uGaBBXl7ev1I0Z4S3sVghwBx1X9WXTQNPARveUNuuzl/pNAM9xAmGV1adFE13rEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hKw1WogJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314c452180so44952735e9.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730211221; x=1730816021; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksaYUHr4Hg4oiO/zJt22jBX/6s6CgE1RT2JSa/GYwt4=;
        b=hKw1WogJTw/2L37gXse31WtF/zAz7Shm/WiQdcL3I1S3onbSHfZ/lNr16b+dv1MzW5
         uEkE3ejz8CfAF/YHWOAvCJwhhxUTcy4mPnjaou5e0cTh+UoWfrcAOs7tnV+3iuvrOZKi
         PAWrINbdu5CpSlucI+rXZZlGgp9PICY6UXLl6+o11xby43yk8pH2RVKG95IXFgcUf799
         KrL8D6X7CDqa+bqFwyRhVIUNLoZMLrnC7VrWSVitu1Hddvkzkv5A6y+pwEG+IrJbMmFs
         gBakHxihWG1hdTfyb1HH4OBHiO6/J616vLwAWDPxPPOeRNz+JgyrGeG2ijkrH5/GPxJh
         Lw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211221; x=1730816021;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksaYUHr4Hg4oiO/zJt22jBX/6s6CgE1RT2JSa/GYwt4=;
        b=lMPRJ40XtLCCf36GXfkFexLEkPr2XuQkEeY5YQULz8FGf4J8dFl9BlD2ZA0nVJkflL
         FBGRvwwP1zOggjCHf7b3B/azx2hTybe82yTAnFAPdkeNs+0Cae5WGUnuezf753E0XGtB
         i+iX7Q2/lHqSPUE5iYmZqecbRFCrOAwzlw8q24n9Z1ZJwrdQBcm91TJCDD+O9YyLddIM
         1hQ1Kf9ewoEOSzmfHxcbnNIWpTSaaSBqLnfGnQVxPQDP/0EbaBNvoBNLXf05c1kdICbx
         UZUZvlSnXySU3G+vtDZDxEdvfsmz0Tut1aKzdzvG7sBFzvOmS2Xy3YwV58/IyxA2/yFU
         MTCA==
X-Forwarded-Encrypted: i=1; AJvYcCV3CtJgWfYUp20iFuEPsyy8t2AyQhF6L7MCE/uKcGQdTevSTuFbhqIFy2zZs1Dc6nTPqZKe4IT1p7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNaoB3+1uPFJXG+JCRyoKkJ1wFu4NlVZ/9eHAxNTqgqPkPgEx
	mljDvXAdYANDP8bkY3H1fHt7+HlT3FdwEignh258RxAvZhqsZ9Y4O2mmHhityAM=
X-Google-Smtp-Source: AGHT+IEt17fHHxi2ATOwstx2QtDAjiHkFCARbfdZAO6W0TOdwlAFve1qEDRGnOZcqD2HtPcmKX/HmQ==
X-Received: by 2002:adf:e742:0:b0:37d:4610:dca with SMTP id ffacd0b85a97d-38186a22c7dmr1910339f8f.31.1730211220805;
        Tue, 29 Oct 2024 07:13:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm12645871f8f.71.2024.10.29.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:13:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] iio: magnetometer: add support for the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Date: Tue, 29 Oct 2024 15:13:36 +0100
Message-Id: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJDtIGcC/4XNQQ6CMBCF4auYrq2ZDsUaV97DuBjqCJMoJS0QD
 eHuFhITXbn83+J7k0ochZM6biYVeZQkoc1RbDfKN9TWrOWaWyGgNQCo+9CJ19J2Q6+HLvWR6aH
 pngpTAGhPzoLlylIFKhtd5Js8V/98yd1I6kN8rXejWdaP7P7Io9Gg0aMFptJXzp3u0lIMuxBrt
 dAjfnFo/nGYuWJPFt2BSjzwDzfP8xttntSHGgEAAA==
X-Change-ID: 20241002-topic-input-upstream-als31300-ca7404eb4ab0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=yIh3linMpn2cGg6hYf730Yb43InblY6sidZueyopoFg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIO2Si78dP4iNywf+N+TZ3zZPJ2j8f9akOAzofoC/
 ACsxdFSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyDtkgAKCRB33NvayMhJ0Qf/D/
 0UJmW1ViFMrGq0dR6L0meqziBk+YaV+yAe8uzoExJO9VWNcrVxdLjOpHz8DmwjRU2ybso0pGYtbPOW
 WXaaLNrGYqV/hIog8fJpUG+tvZYO3psxqWwknBwzwgyXA6Sn3hKagKxX4FAxPzehRYlfNl9k1U33N5
 dnxkZLfufRPSWv1hNiz+J3/T+aWI6rUV4wD/SNY/eAUBDXTohIyAvHCwcx8ldLfvo1qPfwC6TZ0a5P
 G4Mtyw+dZfVMltndGqGTgHXD2Dp0fdlOMHnGv21gDRQ3aXEQCPn9cHbNBCVRsMlo7l52swMp7YKpPM
 rSIqATOUbGbxBSB63gO540FZS07TrG02IVzLDRZ9ElwuzIfI22q+S19tYmaCN+lYA4+wNGFRPvf3CC
 NJ6YvfQTsG7Qmh6KZWTkA/Y00zwz7hj1x6MAt/tAdJe+aQ0zuwGh+TNf8XuFNcXAEb2ojhBWjU7FX1
 MShIenlxNKoRYp6aYKNT/7D9V3II+cSpG9x74/6/ZvyWM5MftqovrP7d2y06Y4PJOW02F5qiaWhHJj
 PT6qz9I9mV/GpLOtcmALpjIrLEw9m+1Ev4I52P9xs27tTYQXPg10CCxUemBv/ITgqCAFvtbTWClJJR
 g6shxW0S5JPs4/p/TS86bXliDJCaFrvt5i8EiicIAp9rPZK1qbVfUrxU+FYA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
mainly used in 3D sensing applications for head-on motion.

The device is configured over I2C, and as part of the Sensor
data the temperature core is also provided.

While the device provides an IRQ gpio, it depends on a configuration
programmed into the internal EEPROM, thus only the default mode
is supported and buffered input via trigger is also supported
to allow streaming values with the same sensing timestamp.

The device can be configured with different sensitivities in factory,
but the sensitivity value used to calculate value into the Gauss
unit is not available from registers, thus the sensitivity is
provided by the compatible/device-id string which is based
on the part number as described in the datasheet page 2.
    
The datasheet is available on the product website at [1].

[1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Add missing includes
- Use read_poll_timeout() in als31300_get_measure()
- Use MILLI instead of 1000
- Remove __packed attribute
- Return 0 at the end of als31300_set_operating_mode()
- Use devm_mutex_init
- Use dev_err_probe() to handle devm_iio_triggered_buffer_setup() error
- Link to v2: https://lore.kernel.org/r/20241021-topic-input-upstream-als31300-v2-0-36a4278a528e@linaro.org

Changes in v2:
- Add rob's Ack on patch 1
- Fix commit message layout on patches 2 & 3
- Use Datasheet tag on patch 2
- Fix bindings file name, add options interrupts, fix example node name & compatible
- Fix driver with Jonathan's advices:
  - Reword top file comments
  - Reduce VOLATILE defines
  - Move registers values next to register define and add an indent
  - Use sign_extend32() to X/Y/Z macro, dtop cast on temperature macro
  - Add als31300_variant_info to pass to i2c/of device_id
  - Move scan buffer to irq function
  - Use guard(mutex)
  - Return fractional for millicelcius
  - switch to aligned_s64
  - use index 4 for IIO_CHAN_SOFT_TIMESTAMP
  - Add usleep after switching to ACTIVE state to avoid hitting read errors after wake up
  - simplify suspend/resume functions by returning als31300_set_operating_mode()
- Link to v1: https://lore.kernel.org/r/20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org

---
Neil Armstrong (3):
      dt-bindings: vendor-prefixes: Add Allegro MicroSystems, Inc
      dt-bindings: iio: magnetometer: document the Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
      iio: magnetometer: add Allegro MicroSystems ALS31300 3-D Linear Hall Effect driver

 .../iio/magnetometer/allegromicro,als31300.yaml    |  46 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/als31300.c                | 493 +++++++++++++++++++++
 5 files changed, 555 insertions(+)
---
base-commit: 57573ace0c1b142433dfe3d63ebf375269c80fc1
change-id: 20241002-topic-input-upstream-als31300-ca7404eb4ab0

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


