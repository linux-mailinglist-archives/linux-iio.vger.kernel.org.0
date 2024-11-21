Return-Path: <linux-iio+bounces-12453-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB829D4A99
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 11:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A39F1F228DE
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C551CBEB9;
	Thu, 21 Nov 2024 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CE5VMrST"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BC1CB32D
	for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184310; cv=none; b=mbZjS9FgV6VEvxx5aOo4SOOmVCH0P7unn5/pIAVJQtHTiOaXWOuGznZABbfOjqLvIjNKODZKlZbFnVbZu81eMxu5bVxfM06CugiCeXjod8fF/BeReb2byyjqQv682KJP4RCjmiMl9mEUcnkms1q02m+5BLeHGdX07A77b/mfSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184310; c=relaxed/simple;
	bh=50fDtCwdlLAXgTUvQCXPWs2a7JSngg3l2XnXQKureNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PsHwbkhuIQMoYvtM+i4PjwTgrbSXIRMJPrNTuKO8xDnwHXj7aOqFhyT9hZH1Wj8eRJlW4/137eE82Z9947cTerab1MalXkM3K8oyrVOB8fD/jTT/kP58zYngFrz7N0JCvgp1JGDy6rb/fWazMpvhnqOuXrSuwRorYd64vk+YJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CE5VMrST; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43161c0068bso5949455e9.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 02:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732184306; x=1732789106; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vhg//+9gK9skfAKoRMQAk1PtzxhM2yRzEZGGXcWEoo=;
        b=CE5VMrSTG+/uUm/xP0LY+WJDCS1LCVDE+uMoYJCL8rHtaPXp5S0qIajHKxyn5YyQqS
         /nsnKgPz0jv7S6Ya0PZilsHGBCA5Esuz8NRYGBu4+7+UIdBZDWQcwxyxRPj4cVGjcMCA
         033eZDdHiam9gshJu8r1qhpzTRTno1wLxKq061lIIUaGNx8/A5tNEX5vN4Sm3O6eYSSD
         UbCVEC0TAUBi/+EbFU5uyw769y62d0MXiUpuSz9zXvqYS8ZuKRrgUNgryr419iB5mjEq
         H8rB7nUYv6cTdgN5lZjZoq/mxHE7jQtgFBK5/DSBjQtIjzx/UIkIcOjzTd8Pm6NZMXIh
         sFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184306; x=1732789106;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vhg//+9gK9skfAKoRMQAk1PtzxhM2yRzEZGGXcWEoo=;
        b=FvTxL44WR3IkDH3SQwlCTNnLH/r85jDqS5elPNMI70TQhlgye0AkQH0qojKsd1BoRS
         MpeARtt+9J/BLNPRRJBSnB5/+Zlyq1GtIDvsqOO8yTtQJ2PE20s5Tp8vzTSY9Q6p+75r
         RyuLO0/v8ifGLe8dlk/M58LtLhwBWcAnae23GLg2wOaf994Q4nGZ5NQ1z/wSe2Jb6ivU
         l1t95V9N/k1LvvFiHaPqSVhNlWUT6vgnFFOtlY99limpm5V1PNO2TOr72xTEMMImdnRw
         DoJ+UxazEaI6maQPxj18s5bSGpkzv2vhVUpHQW5I4OabteO6plwgb3C1viUl6hd4Agv+
         Dj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXYombgPeUIORXdJALRTlrLXr0I+jpQLXKJe3bcdhuZUKFrf8O97f6gOaZUGB9SLixQe8thINQBvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5U/0IZV+MrG254kwKCF9SDTJxHnFD20l5R24cCEke45az3ec0
	0PAnQyMIUv684S6kmifoqJE41tKw2N8CC7bc7cKrdWQvdbRJwXkrohxqqqkyFnQ=
X-Google-Smtp-Source: AGHT+IGBW7L660mzuPSTV297VS/czb6kj0Q0yR8PtJ9nj19x1enKRAJUUVHucWAHQnMBQx+HVW4jjQ==
X-Received: by 2002:a05:6000:796:b0:382:372a:5722 with SMTP id ffacd0b85a97d-38254b0e452mr4741387f8f.37.1732184305578;
        Thu, 21 Nov 2024 02:18:25 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm4598065f8f.47.2024.11.21.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 02:18:25 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Subject: [PATCH 0/9] Add support for Software mode on AD7606's iio backend
 driver
Date: Thu, 21 Nov 2024 10:18:22 +0000
Message-Id: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO4IP2cC/yWNyw6DIBAAf8XsuTQIFqO/0hiC7NJuGsWCfSTGf
 y+px5nDzAaZElOGvtog0Zszx7lAfarA3918I8FYGJRUTS1lJxy2RhrrEC1ztKPzD5rR5hjWj0t
 kp4gkLqbFzutOqUZDSS2JAn//m+twcKLnq9zWQ8LoMgkfp4nXviphEWIS5lzrEYZ9/wEgiwSDp
 wAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732184304; l=1846;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=50fDtCwdlLAXgTUvQCXPWs2a7JSngg3l2XnXQKureNw=;
 b=JtEIB3cy6xUpkjoNi88WS64a1EN36dL1aR81+1h2XpI2/dFQNvx51GRJLAOVh3RlKZkDoO4P7
 H9PblPCK032BEA1KIvh7ou+qvGBbf6Sm5uPKkUqAz87McSJ/eyzkQtw
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

This series adds the support for software mode when the ADC is used in
iio_backend mode.
The bus access is based on Angelo's ad3552 implementation, that is we
have a particular compatible for the backend (here axi-adc) version
supporting the ad7606's register writing, and the ad7606 is defined as a
child node of the backend in the devicetree.
Small changes are added to make the code a bit more straightforward to
understand, and more compact.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
Guillaume Stols (9):
      iio: adc: ad7606: Fix hardcoded offset in the ADC channels
      dt-bindings: iio: dac: adi-axi-adc: Add ad7606 variant
      iio:adc: ad7606: Move the software mode configuration
      iio: adc: ad7606: Move software functions into common file
      iio: adc: adi-axi-adc: Add platform children support
      iio: adc: adi-axi-adc: Add support for AD7606 register writing
      iio: adc: ad7606: change r/w_register signature
      iio: adc: ad7606: Simplify channel macros
      iio: adc: ad7606: Add support for writing registers when using backend

 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |   7 +
 drivers/iio/adc/ad7606.c                           | 202 +++++++++++++++++----
 drivers/iio/adc/ad7606.h                           | 113 ++++++++----
 drivers/iio/adc/ad7606_bi.h                        |  16 ++
 drivers/iio/adc/ad7606_par.c                       |  58 +++++-
 drivers/iio/adc/ad7606_spi.c                       | 141 +-------------
 drivers/iio/adc/adi-axi-adc.c                      | 178 +++++++++++++++++-
 7 files changed, 500 insertions(+), 215 deletions(-)
---
base-commit: 33d38f912d5ca05501c9bbfe14e0150da9ca85b6
change-id: 20241009-ad7606_add_iio_backend_software_mode-567d9c392243

Best regards,
--
Guillaume Stols <gstols@baylibre.com>


