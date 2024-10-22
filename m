Return-Path: <linux-iio+bounces-10926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B87999AA2F6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47590B21DAD
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C560A19E96D;
	Tue, 22 Oct 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ej/602ZD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BA19E7FA
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603364; cv=none; b=vABZGxa4socBDoUUGJ826dEzJVpFP24qsficVYkbOI4qBaqe+OjGKChlMYf9E87zx7/IhoxwKbwGNHen5t+nLnk4j4uNFMAZk/yUrDojSyWim7p69sO7PwNl9mJjbCp4IwgCMeyWMSzQ+UjcRn/B5gdIUwD8J5qi5KSWnso5fow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603364; c=relaxed/simple;
	bh=8ZXY++sczqiX9uMbT4vUgqAb6YUuuxo60CIRxsXCS5Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aji1nwuw/sEy1d6FzlnRgAlRf7xt6hFzYb4rysqLQuzEnhl4u/OCJv0LuLSrvdESO6v29IEAIB/6ZlaXFvDU2AqP5nrSSaPrZzqryvsfAAWvzVWQC3UVoDnYVEFfm3dsKABgutP5npKOsDkTHDkQfpno4ViKsvs2Ms3YaFgHyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ej/602ZD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso87297391fa.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729603360; x=1730208160; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfqSeJ9XLIfUJ11D1pRhbSM/QaFSnTxK9h/wuyBvkLQ=;
        b=Ej/602ZDeWAVt2b8F4oHW8Nduy8YagTmo2KN97rJPCzf56fn1A1eiQtUiBL38R0/54
         Mxo42basLZvoQ6JFrwMsx8qw1V83Zq7W+XP0IH/voq/hYSK8ptkHzMJtNlVW08bU6X7w
         cGUvrrJcbNdxp0iApgJDZUv+cIshq3ekPJV/r68oNs9cvKV3pf3zC4L22W5EIUU4KSjB
         6o7yF7ZbxTn4L1mymahiHXCr6R+lUbzkWhmNpsTehecvVjVTv78oHtBXCSRz2MjkjW5y
         uedAO2XpD8Ovq+IyuDDb6NbUYcBPJSbbWpgrERMHbfeQo4ylE8PJjaTeIcJ1CBBHdYWC
         pHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603360; x=1730208160;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfqSeJ9XLIfUJ11D1pRhbSM/QaFSnTxK9h/wuyBvkLQ=;
        b=OMaCMgZB+150qat96oZpV8IjNDtJK6jkQcUMAetJyRROnwSFe/Oep2HRncyhrFqj4i
         w4Gb7XRwQobVnALeKm7vZ5+QdoLxg9K77AxODOn+TwWd3RfCRv3ENnc/hKLoZzWdZWmm
         fSFrEItmv/0vasvLulbZaghusHzLUhznS5N4YA48FbRNpJKQzQ+ssztcFA1/3UxIpeBb
         zjuseuNwL3nIcWXyX+V+T855gfyyoCDi6zGlm+3reOoivoyVjPKpm0iC5sa2uaUeaT9+
         d2SKYVV2SgrUtldp8FPNBJClbAoBdc0jPnwPcYOiDL2shWxYKt9DyFCneBNDDVCDvfH7
         fv2Q==
X-Gm-Message-State: AOJu0YwVx/ysmsz5sF5lhsazD9ah0NWYQGm/ZY8vUOWb6nUd7iTkJLPW
	9H7gLbC+r+RhxTJmUJi1HrZ0M/sRxhtkQNfqRhb9PE3qP2zcbgSkVqRYvWVNIsE=
X-Google-Smtp-Source: AGHT+IGF20MNQnrfkIa6RUxQDdxll7fwLfR/qIaL9fRFIM4On88xwZNFbh3IKY4n74ZANHygrXqjsQ==
X-Received: by 2002:a2e:9fca:0:b0:2fb:5bd:8ff2 with SMTP id 38308e7fff4ca-2fb82ea1dcdmr85657021fa.16.1729603360433;
        Tue, 22 Oct 2024 06:22:40 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c737c4sm3109496a12.96.2024.10.22.06.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:22:40 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v3 0/5] iio: adc: ad7380: fix several supplies issues
Date: Tue, 22 Oct 2024 15:22:35 +0200
Message-Id: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABunF2cC/23NTQqDMBAF4KtI1k3JjzHqqvcoXUxirAGrkrShI
 t69o1AoxeV7w/tmIdEF7yKps4UEl3z044BBnjJiOxjujvoGMxFM5JyxnEKjZclo6980vqapxzG
 VhdayULYtAQgup+DwvqvXG+bOx+cY5v1J4lv79fShlzhl1ECDIJe2MtXFwNx7E9zZjg+ykUn8M
 IIfMwIZYUEpbqRUAv6YdV0/AgZ60wABAAA=
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
Changes in v3:
- Use fsleep instead of msleep
- Add all trailers from review
- Link to v2: https://lore.kernel.org/r/20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com

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


