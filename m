Return-Path: <linux-iio+bounces-8381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998894D672
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1657E1F22747
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 18:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8117A1607B9;
	Fri,  9 Aug 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ttDxVcG2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D4155C9E
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228881; cv=none; b=Nx1iIDJliGT5oO9NWxr600i/xchWZQB2ogJRHYRh0E1CsMA4znQxoa3J9krENntvTFNR9IcC2xuOT8NzFdotcFuPa2d+HDz7ILJnrh+gAsgacEDc6MpIq7aH0Qj5kCZlmDXd1XVqeTwBv53Qt9xk+zzxvoUUg0eQjj+Y94NDMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228881; c=relaxed/simple;
	bh=499uChQw/H8tuwVB852PCytBsZoBNg9ljrsRouyxw8c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YIeVjUA/5of/MhGg8A5eIwe7YxZQSuMgzSZhkzLG4bWMp/xp8AIIqjPvYlAi9hHtRqBJpqu9JsOBJcOtNfIlXec0BKikAXIz7578l1JnB0B99fU3tZFu0HPHLk7WChwG6QHeLXMvJBB/LhDxfdPV8oik9dcyuzNEJnJJU3pz4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ttDxVcG2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fdde0c8dcso13334421cf.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Aug 2024 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723228875; x=1723833675; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FfdQAnQ8Z8ZT/AgYzgbksuN7QqG5prioZPiURB3vxSI=;
        b=ttDxVcG21/QSAd19ve0zcb01CcKUd/9a2sISaBrM+SqjyvPV0Z7Umrl8NiO5C06VvL
         zLXCB6wxKc55L8MZsB9LYvWhjaBjxl8K/EBwugdjVyAe57LKaMdIJzikAGfHtF0LDDr1
         4yVGUs8QWSSZw6JIqZW06FAl2mZf/3x0jjg/vW8NSU+PB2334+3kM4d/5zG3XpKxmVf0
         ErhXGabXarIL5ouwhWSc67YmqY3SCiIJHEv4VtAPHeW31XVSVsKe0n2nnzHORbXd0IK3
         9BzIr86wg8FbGAJJ5Qz+Ik7a9HcX4hXdcM6vf9+//yKF0zm3oXTKY3GdWIKZQVSluu9D
         gmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228875; x=1723833675;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfdQAnQ8Z8ZT/AgYzgbksuN7QqG5prioZPiURB3vxSI=;
        b=DeDcquxM7tSio2SHcjencfntenv0kTWEp0VySJe273qygdrCI1asSyk5SaAWfWadB3
         gWPuOpWLnTwfZ+U/VstUzkdWwLEUChG75iK30c9bxeqi9gPM95KKVZAzeIRbG5Rr9H6n
         jHNBiwo7gm4jci8DKshLAzQ5hAhC5ExieEpgEhqCfUaPZoLlNI8FbPutJCuAs223MGGr
         8J1Y/fGgPPKnkhthQ2uAEupH/WZknMi+JO4un7mMxUezVBe4tRJnstbT7cnGc5ZEi9Dk
         z1FlMMA1HoIexE3ZK+k5T4DGDX9vNWojW0SITEywtju16GYA/YrBEKuulDCVEzVSQHpv
         q4cg==
X-Gm-Message-State: AOJu0Yy/HGwPn6j/PLbM+v8vwnckE5sW1bKWzRzRTDoN8TJ+3GNnGDrN
	TJ2V7DpAWKpFmwNCNaUucwyS7gezA6EJJiKxCkWtoPlPaygmfaC7B0YpC3gkUhE=
X-Google-Smtp-Source: AGHT+IHP1porj01E9X+XteR4M7jFvXiDPMNfBNz5d1BFpsYIHU4rO8j8xtRYIo0yw4U4FtD5jEb1ZA==
X-Received: by 2002:a05:622a:4d95:b0:43f:ee9d:c2ce with SMTP id d75a77b69052e-453126b9003mr24455131cf.45.1723228875400;
        Fri, 09 Aug 2024 11:41:15 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1d723asm370381cf.44.2024.08.09.11.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:41:14 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 0/3] iio: adc: add new ad7625 driver
Date: Fri, 09 Aug 2024 14:41:07 -0400
Message-Id: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMNitmYC/03M0QrCIBTG8VcZ5zpDLefWVe8RI3Qe24GaoSGN4
 btng6DL/8fHb4WEkTDBqVkhYqZEYa4hdw2Mk5lvyMjVBsnlkesDZ8bpVqprFKzlTmg0sutVB/X
 /jOjpvVmXofZE6RXistFZfNefIv6ULFhFBXr0ykhj+7M1y51sxP0YHjCUUj7WbplfpQAAAA==
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

 .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 175 ++++++
 Documentation/iio/ad7625.rst                       |  91 +++
 MAINTAINERS                                        |  11 +
 drivers/iio/adc/Kconfig                            |  15 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7625.c                           | 688 +++++++++++++++++++++
 6 files changed, 981 insertions(+)
---
base-commit: ac6a258892793f0a255fe7084ec2b612131c67fc
change-id: 20240730-ad7625_r1-60d17ea28958

Best regards,
-- 
Trevor Gamblin <tgamblin@baylibre.com>


