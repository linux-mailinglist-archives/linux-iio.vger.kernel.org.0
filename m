Return-Path: <linux-iio+bounces-10843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72679A60E5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F112283A75
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 10:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE641E47AC;
	Mon, 21 Oct 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dBG9Xv+R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17331974F4
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504817; cv=none; b=IL3HqX8OrGjfQ5a2aO2ssmKLbmiKLYpOFrpkdhB/XlS6Db2LnmtToKqPwtXXIinI19PteVRYGMgcd05vzGBdxuXAda0ueYQebqKWiYpV/Ka0wG2ztnsTvrSF8xhRUZam67rd/EoYa7xL+fbobndENUHwbwa6gCY3KWdXRGQVT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504817; c=relaxed/simple;
	bh=LG9mv9A5S7JtcUZ3x3v5Oc4S0zx/0RbcU0WFxYrah0A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oFB0s/kKZ6ZSkWOSAS2H+Mr9uK0KzjwpJbgT2e06AtDVerWV8A3WaPvlOpLn9ND+yi6ct2tGydklv4wc/aLvFGGQPOcQbJWxjITwP7Z+vhA5UQHI9uJt7pd9TCbLPgQxNn1e0dFcuc+JGaXA63f2ITk9AOp0ErgMRa7vy8sIr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dBG9Xv+R; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43155afca99so30052315e9.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729504812; x=1730109612; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEQgoXWurslujnhmekbXopxUBMb8xPqnpQko+0aaeq0=;
        b=dBG9Xv+RzsRWR16DwlYq1DSmf2KajQBA8eX2iit0E3zCUaU4++rMb2gbc6zFxPncTX
         +CWHmVIlayO6GJ776jgzkj9gQGqWoppjrxTVXQsBIQ4+WUgn1KPXqmzDR3CBuDY6ECtC
         d1h5LTYQyinvIGUaKGHmgbh1f2wJPhiFMbfEBOa5N0vQk2brqaDo7Q6GKfkjWNNQtagv
         75XZfgmqUFLqlqhF3GgZQ71EmWRTwCtjsanykVjFIS4GJ54Wxs4oHE7ys/+XBZ6w3iNv
         ZJvXGvwhpSEvgCOGTVFi294HlZCENAGaLCie+r+vdHzajBYo5F9jSWDedjXTY3AswIQr
         J+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504812; x=1730109612;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEQgoXWurslujnhmekbXopxUBMb8xPqnpQko+0aaeq0=;
        b=AFeznd3hxxbifhpeGBDgZRwf1bKie3d+K54Tab0Hk+eppDWsLOvronOvEerJL7x9+I
         SH1anp5O7qp1GhLMXVctTtXOdO+I8nuK982mQTGqFedEJLG1RC882J6PzmGwSc/te0E6
         6J00ihmsTL5pE0loaRERernWr0ObdrKcc7mqToZ/6y8mtZgKH2w1EiMjdrxoBMwVjcJR
         V0zzyL/XWFUbJFUulKkQ8Lbra8y4XaAUdMbPvZukDCArqbZRicWFwK2q01dawkd86Zyk
         k2F1P8V6w32xaxO7pTTtINbBP5cRAeZRnKdpo/pKtdi0/isRJoWT+sXafhMM/69LaAgt
         E/xA==
X-Gm-Message-State: AOJu0YwUyjRqtFxzqGtNY1Q6LVFL2O39M8l7ucLAhn62Ps8pvBIxKUTE
	hUhvQT4F6hzk2eCC5u8bZUej+9oiWHZB+cM5TISOxuJsyPKDns3Me9u4QG5YX7k=
X-Google-Smtp-Source: AGHT+IERELLrHoxhs+BrqkBuHWu/+dVs+uiy2dyn6XFdwv/PzU/E0Nv+i8bR/x6sYA9bUHowK6vwQA==
X-Received: by 2002:a05:600c:4e12:b0:42c:b98d:b993 with SMTP id 5b1f17b1804b1-4316161db92mr57044745e9.2.1729504812233;
        Mon, 21 Oct 2024 03:00:12 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58bbaasm52375995e9.23.2024.10.21.03.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:00:11 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/5] iio: adc: ad7380: fix several supplies issues
Date: Mon, 21 Oct 2024 12:00:08 +0200
Message-Id: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgmFmcC/22NwQ6CMBBEf4Xs2TUtRQqc/A/DoS1FNkFoWiUSw
 r+7knjz+GYybzZIPpJP0GQbRL9QonliyE8ZuMFMd4/UMUMu8kIKUaDptKoE9vTG9Aph5DGqUmt
 VXlxfGQO8DNFzf1hvLfNA6TnH9ThZ5Df9+fRf3yJRoDUdC6Vyta2v1qwj2ejPbn5Au+/7B1jbS
 gK5AAAA
X-Change-ID: 20241004-ad7380-fix-supplies-3677365cf8aa
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Hello,

This series tries to fix several issues found on the ad7380 driver about
supplies:

- vcc and vlogic are required, but are not retrieved and enabled in the
probe function
- ad7380-4 is the only device from the family that does not have internal
reference and uses REFIN instead of REFIO for external reference.

driver, bindings, and doc are fixed accordingly

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Fix kernel test robot warning about variable uninitialized when used [1]
- drop commit removing supply description in bindings
- after discussion on [2] we decided to add refin supply here, as it
  will be needed in the futur

- Link to v1: https://lore.kernel.org/r/20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com

[1] https://lore.kernel.org/oe-kbuild-all/202410081608.ZxEPPZ0u-lkp@intel.com/
[2] https://lore.kernel.org/all/20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com/:warning

---
Julien Stephan (5):
      dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
      iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7380: add missing supplies
      iio: adc: ad7380: fix supplies for ad7380-4
      docs: iio: ad7380: fix supply for ad7380-4

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  21 ++++
 Documentation/iio/ad7380.rst                       |  13 +-
 drivers/iio/adc/ad7380.c                           | 136 ++++++++++++---------
 3 files changed, 110 insertions(+), 60 deletions(-)
---
base-commit: 1a8b58362f6a6fef975032f7fceb7c4b80d20d60
change-id: 20241004-ad7380-fix-supplies-3677365cf8aa

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


