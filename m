Return-Path: <linux-iio+bounces-6692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34D91301C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 00:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D64280EFC
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1917C22E;
	Fri, 21 Jun 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mkhTHDQT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701FE16A943
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007925; cv=none; b=V4NHVzefrLI8c1I1XO+qrjHjcYVM4tp5/KXJnkrZTD2RyudEVjvCTcL6nBCzyoz8n32f5x6R08znNcv9AISJHVY7+cSUdjbzhf7+ZeLiqwGBcFOhJyo3yky2qS/vv3OTwPLkPgLnXGxNseU2ET6Vj0lpYWVx/YbAUoWeBVptksg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007925; c=relaxed/simple;
	bh=uKHdDd/8gHLqw6oteF8jTfFOKwU+UK2OngeHou2JMhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EcOk6YWTEwCqJjb4et/lWPf9JCHj8PIl4W3euaUAQsw4YoUCe9dDNRK92MsjtBD80cZtoo6Iote7Y4ysOLgFSLAUDcSDW+NLiA++3VCtxW4QdZxl4OxcHs5Pa1g6TA39BlGoIB8DTBCu6hFWCAdIiY0NYfk35Mj/AGvuE6AveQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mkhTHDQT; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5bfb24e338bso998855eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719007922; x=1719612722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cmzSXNP21R075UYu7ymlgDX9W/Dms83ZZmrfejrgjMM=;
        b=mkhTHDQTfy+Bpek6GorDj+YFKSUGIfjNS7PGXBDK5B3KgXe+brUKbp/R+uxiX1TYrZ
         1ZC5UIcLYYkp0UHGJ+bcVLDrj3hIy20w3tJAGY3MEMLtC/O3GNCgbUJc3O6UIkWmvl+H
         lZwjXA0Ri2JbW2Dzm/fh+UGErrT98blGI/rmAH2rSK1smhlKbca7pV75Oxs0NjPnMXdm
         x+h0hTEjQmYxuUnUMjZqxhdugJhYecbQ/i9ngvAnlsUYKU/jHvLTMxl2vontU4q9JEK6
         03W7KClgULpNoM8i1q+AXHUop4eCmr/+N4IS7We/MLwLMyhPj4maOtSKZf+o0RboYXwr
         XU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007922; x=1719612722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmzSXNP21R075UYu7ymlgDX9W/Dms83ZZmrfejrgjMM=;
        b=V4IU4VOBwM0UqA8Y6e3fmVtvJzfJrhl96OoELRAJbv0SQkC/NRPeaQ9Yzy0dOoUxZh
         M+z4TeuMc7qqVKY/zE4h8hLVu1XmT9e6j6H7wr/Lc7kGSOTUB6+Su2m+1kxxXDEXjI2n
         JnHhRgjOfms5x2LpWukVOGlWR3ttnuVGxBYQvhzr9CAxZcr8nmC2DJAZfyByCLbnsPi6
         nU2pBDR8TjAdnCLD3QSrbmjS4siSXBMetntGp3qz7+9agdoA/aFlctZ2q5ZncJnQjhh4
         Rd7OYyIpCefpknlulnI0OU1ptiPO8XRZIWk9/D9B/SDcdmgPu+HtVL3tVAg5t58GmQ8x
         q8BA==
X-Forwarded-Encrypted: i=1; AJvYcCVb0UiZyRKoj/9shN1j5GwjPLfxyDtXgAqk2acwobOSKxq1V6n1FeFzEtqER1ewhDKlLlOwM67QWMdQrB9iNzn8a6Agpt43wbaq
X-Gm-Message-State: AOJu0Yzzbrarj/P9yekrWTM/Til+JfaTTqzYwvGpDELLv44XOINo/YrD
	fLyTuZMCvBuc5FV9bsQ+WjVFq/mtmUi/nIU3iVE4B7aAIxOsjfHMYZj3HIo7yDc=
X-Google-Smtp-Source: AGHT+IGwLaxf3WWNTpwyB7Womx7K1+1kbrWpsLo0q6oK9vgQPFQAtCkWtcmH1xRg/3vOcNKhpv9pRA==
X-Received: by 2002:a4a:a584:0:b0:5ba:d785:cfe5 with SMTP id 006d021491bc7-5c1e2690485mr557577eaf.2.1719007922520;
        Fri, 21 Jun 2024 15:12:02 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c1d94fb2a4sm329837eaf.10.2024.06.21.15.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:12:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] iio: use devm_regulator_get_enable_read_voltage round 2
Date: Fri, 21 Jun 2024 17:11:47 -0500
Message-ID: <20240621-iio-regulator-refactor-round-2-v1-0-49e50cd0b99a@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This is the second round of patches making use of the new helper
devm_regulator_get_enable_read_voltage() to simplify drivers.

All of the changes in this round should be fairly straight forward.
And as a bonus, there are a few patches to get rid of driver .remove
callbacks.

---
David Lechner (10):
      iio: adc: aspeed_adc: use devm_regulator_get_enable_read_voltage()
      iio: adc: hx711: use devm_regulator_get_enable_read_voltage()
      iio: adc: hx711: remove hx711_remove()
      iio: adc: hx711: use dev_err_probe()
      iio: adc: ltc2309: use devm_regulator_get_enable_read_voltage()
      iio: adc: max1363: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-adc108s102: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads8688: use devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads8688: drop ads8688_remove()
      iio: dac: ad3552r: use devm_regulator_get_enable_read_voltage()

 drivers/iio/adc/aspeed_adc.c    | 30 +++++-----------
 drivers/iio/adc/hx711.c         | 78 ++++++++++-------------------------------
 drivers/iio/adc/ltc2309.c       | 43 ++++-------------------
 drivers/iio/adc/max1363.c       | 28 +++------------
 drivers/iio/adc/ti-adc108s102.c | 28 ++-------------
 drivers/iio/adc/ti-ads8688.c    | 59 ++++++-------------------------
 drivers/iio/dac/ad3552r.c       | 28 +++------------
 7 files changed, 53 insertions(+), 241 deletions(-)
---
base-commit: 7db8a847f98caae68c70bdab9ba92d1af38e5656
change-id: 20240621-iio-regulator-refactor-round-2-28a1e129a42d

