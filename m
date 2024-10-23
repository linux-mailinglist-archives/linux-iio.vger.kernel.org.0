Return-Path: <linux-iio+bounces-10970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45DE9AC3A6
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 11:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB695B2671D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A615B971;
	Wed, 23 Oct 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tHG9gSsz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF118194136
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675185; cv=none; b=FShY+3yCk8aWwO4lql3eHm10dpkhJ/YV5eaZ1paoHnhM2phdJJseZ/JKErcL5gN+ihVZlqf6LJzWQNhTAqEJxhGs8eJpdAaGrgAOnqXPDIJOGeKYxlR0S2UNP1W5m4wANip9/z1e0x/4VgZHZWkUAkVMN8q0Wh8tP2PRDb2BwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675185; c=relaxed/simple;
	bh=BdfWbCaw9dl2XW0U+tiiv8QYh2zros/EPRH9N3CaDNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V8+5WvKcAhZjEBPffLxLaTx6o+558LefiCLiuagtgjWm+YWuLZUrFesxYDUkbeEMvVcNRkIjts87skUr+B5k425q5M+Zdu8bWYiLCKXLOqZ9U8Ubvpg9lVJMj2siYT5NExooFUdBH/fMfppZwUCJ+OGcidTZtgichC7Mf7BJ7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tHG9gSsz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so67486045e9.1
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729675182; x=1730279982; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whOZh3OaEYNB1ifC1fGYleloMAZdgj5A+SfyxxABc6M=;
        b=tHG9gSszJROK/PCDrtHvCKAK9kUremr3bxxaI1moT4aYJtdcIn3cE5hVwte7mbKsbw
         0eYtgkPAjbKu/n0cbBL3s+IkE7xpVz4FDJjj42fxrHKLKGeTApLOehbRkbQxCZTgIy0K
         m2yBt8css0Q7JfVAZSMEXCyS+Au9GTb+kRtLp61FwOB3WDlp+avmVFNm8VawbEM93Fav
         wo+2oY4orBskVQIzhfIpNLBDoEChbv5iMAc8KRXl8IW2B4Sk6pd/J40nA9pvrsJsiQDh
         YAfKwHpJSh9hTPKWVi9OytR9wOEBxBmwPSOHz65IOE5m2lVToCDXjvae8ydBOkhYuvSz
         bS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675182; x=1730279982;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whOZh3OaEYNB1ifC1fGYleloMAZdgj5A+SfyxxABc6M=;
        b=k9IxvjIbCGyEelJZuPuPooxt98Db7UndHA2R09eBfZ/gLxouG9KPc44ypYSYc3BC6J
         BNtcuiC0Hpu2sCUwWUvYe8CcDpz/4J1cQgn0m1O2JRpzQoB4CW/PSmvKxmAamP45vsdO
         9PBN17O4EF335bcYboFCDxLY88wYUtws/CqBjlkv8bnzdjinvqCwG6HTYF/8IuHUTaD6
         W2f2vvn2CnijBEl68DlyVDNvE/1v9Apx/PCH8OC1fnuI7Ss64I6OAkZaoDq1BqvtVDFj
         EWI5vww0kLuq3nhDVafHkHoSV/S7ZeuTDO5MGayUHwM/LrmmMETzErieza3LoPG8XHzo
         y2Dg==
X-Gm-Message-State: AOJu0YwmYaDg0sPQvRzuD+cSUpA5byQR7QmXpY6reEGMRJUCEbN9h7mq
	n5VWMGdXWwdysJIHQwmwGYaYo1wt4EnnAlx5Zb6R3SkSMX+cAqsd6MAS75dKu18=
X-Google-Smtp-Source: AGHT+IHccO5uMEXbEwf90dp28rRacXB6W5xVZIJgnOL2Zbamy56vq3VWhyAeKkQjdkPvxbcgsaQ+tQ==
X-Received: by 2002:adf:e40b:0:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-37efcf1adb7mr1132526f8f.30.1729675182026;
        Wed, 23 Oct 2024 02:19:42 -0700 (PDT)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm8515796f8f.73.2024.10.23.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:19:41 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/4] ad7380: add adaq4370-4 and adaq4380-4 support
Date: Wed, 23 Oct 2024 11:19:32 +0200
Message-Id: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKS/GGcC/42Pu27DMAxFf8XQXBV6Roqn/keRgZKoRkASO5JjN
 Aj872UUFOjYgSAOh8tzH6xhLdjYODxYxbW0Ml0I1NvA4hEuX8hLImZKKCOFtByS017QSjRwNU8
 wvN3meaoLlyZF6TAKofaMMuaKuXz3/M/Diyteb/RmeR1ZgIY8TudzWcbBBwTtnQdppQwRIUWVQ
 1beBCFCjBYUEiX2V49su5wwv3L0shudqBnXO+f0zsbsAcZVs6fGsbRlqvfeepXd458FV8kFTwo
 l7G0OyviPAPdTCRXfqQQ7bNv2A/ItZLhUAQAA
X-Change-ID: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Hello,

This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
which are quad-channel precision data acquisition signal chain μModule
solutions compatible with the ad738x family, with the following differences:

- pin selectable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

This series depends on [1] which fix several supplies issues

[1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- fix commit messages and documentation about the gain: pin selectable
  gain instead of configurable gain
- add the enum of available gains inthe binding and array of available
  gains in the driver as ad4000 series
- in the bindings, remove item from channel reg property
- in the bindings, merge additional supplies and channel properties inside
  the same if branch for adaq devices
- fix comment as suggested by Jonathan in the driver

- Link to v1: https://lore.kernel.org/r/20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com

---
Julien Stephan (4):
      dt-bindings: iio: adc: ad7380: add adaq4370-4 and adaq4380-4 compatible parts
      iio: adc: ad7380: fix oversampling formula
      iio: adc: ad7380: add support for adaq4370-4 and adaq4380-4
      docs: iio: ad7380: add adaq4370-4 and adaq4380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 121 +++++++++++++++++
 Documentation/iio/ad7380.rst                       |  18 +++
 drivers/iio/adc/ad7380.c                           | 149 +++++++++++++++++++--
 3 files changed, 279 insertions(+), 9 deletions(-)
---
base-commit: 8bea3878a1511bceadc2fbf284b00bcc5a2ef28d
change-id: 20241015-ad7380-add-adaq4380-4-support-14dc17ec0029
prerequisite-change-id: 20241004-ad7380-fix-supplies-3677365cf8aa:v3
prerequisite-patch-id: 6127a52d3b14e82d1a6081c7e504d0e4eb323089
prerequisite-patch-id: 7dee57142d0d12682b0be3b62f1c16851aeac069
prerequisite-patch-id: f737e56a372cd91e5fac651a2063b06827f9aa21
prerequisite-patch-id: 7c8d5fbde82810057630b95e12bb2f6576da6980
prerequisite-patch-id: 972bdbf06bafa7c56f604dbe8eb7d236aadaad99

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


