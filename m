Return-Path: <linux-iio+bounces-2494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16656852275
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 00:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AF3281A89
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 23:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8533B50248;
	Mon, 12 Feb 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MzkgzzL3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6794F5EA
	for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780478; cv=none; b=gG3VXegxT5O4D7UjSjzBXsIwa7gHu7Or9YIUndqtYU3NsvxLJ4B7GjBFnniYniStyuyY7Av9cEa2bh+gBzOjRKMK6dYkU/D+hEyRpjDrrzFnRIXAvbzoO5rCE+BR7DmA8pg7nBMIhxrSTX36Q432UaWfhRToO9IGgMMWNlRf1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780478; c=relaxed/simple;
	bh=wQOLAzpAqdTMxbzgxQagsub1MlQcJ776NbBb/5ZmX74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhS0NP2fYXieI0DAJbWRM2agJc1bV8RslimLUmiIoyN4OISjuAJWhVAefDGr9OwnTpuP1yEBctFFp0/YxHYWBGxPV4170Qb6H1P2EWIpWxX/3HvJeS869jkRWxVSUjB+Fo7H9ca38mDfER6bEdmLGWKgHum56m5ihp397Ka/fRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MzkgzzL3; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204f50f305cso3076429fac.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Feb 2024 15:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707780474; x=1708385274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+egtMFSB5wP/JnRwyX/FLjZ4VS6y7AaGO4xFQVkuUk=;
        b=MzkgzzL35sh2Hd+HStux+3lGfZoFx7BkilNaOUALWkvWugwmOYoS+6P5/MfIdtzwLr
         ehKLKlttNTDbLLxsqJMJt4c4fuJKu3RayyfQgcocUWMvtTjSN/i9xXGldsBtTBFEa8UY
         3Sp8WFg7OhoUlZ0dppHfWFLshzgxwsJU7rqfRyF7uR+7J1oSHBIChuiMXaPqCtH6b2ni
         FTPmicM8416vHwfK6s0L2b7ru3nF0eOtA5TemYDxy2Yj3/1VT2jrX7m7H2g8p+ITL+ie
         873w6fL2sG6YOZ5odZn17r2CGHxBZOSlO5Zlsjs24qKoRBqH0wn6SMlp00w0jdjfkqUf
         85Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780474; x=1708385274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+egtMFSB5wP/JnRwyX/FLjZ4VS6y7AaGO4xFQVkuUk=;
        b=paegWIf7QhGy4lOVqNxA1AHW7K8U9meeXYzl8znwNVN/Uj/OsbXwC9g6nbMpVsqQ44
         zncZ0XLGYvP7LSstqqJdlP17RoHhJez/ZLYt+sjkmUwlxwhxsuJiBswnf9Fn3TtDlW7X
         Jjedn8RT6OtTcIknOwyIJvNQZKr2b7n8WB21e7VxaG0Yn+FU/GeoCjFK9Ka4enHSyKU3
         wPIlAc55MNFZPmWhcqOUoLrAOfIUGay40bQAum3hv2oW4BJ8MR/JsW250PR3lKewlifX
         HrVTuOqIqTBzAohabN7fGm9wJJ+jyUmPl46/g5woKW+eO7hNIjTmWZyYztSJaSnUE6yB
         dMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXXoyB2XOpr0P7+X+sp4EaXps6LsLJ4rLbnpvCgCNIvpkCo4ibj88Q0ZwQTREgWZqCTIih8rM77mxDuOiwzmys2Gafgep/QAyqy
X-Gm-Message-State: AOJu0YxO1IXq7m0MhKLG5kaMwDGoFps0nykOeuy3MF0V2QhGToMJexzm
	jvgUFBLs7NHRd9e1UVipOSkzCQ2cSvZTkclpYeNsZZPNyltaE5PU23kintt+jXA=
X-Google-Smtp-Source: AGHT+IEnqNuLs+L+SkljOkSHhq48382/YhpcidnWFKrPiXnIR0zV1wGkfWPgAvmmTXxR3uMFQYBdTw==
X-Received: by 2002:a05:6871:80f:b0:218:55c9:bb20 with SMTP id q15-20020a056871080f00b0021855c9bb20mr9748766oap.21.1707780473886;
        Mon, 12 Feb 2024 15:27:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVBCLWzInzImFpjlEde3du9xxWbJtlsO+FIOwVJCqeIGb3XUsPpgQL9MqOSJhqdb/VUAjFuoxvugBtbTKi0LRU+DEKsVET+S1y2BKftd8n6uHN7eeWchHaIuejP1qVpCOCqRjZ3rAXp+AA2CHyMY/eGgTU4nz9PpqD+iqlOeB3kH1N1kKZ7mEr1PH+lJ7gWJDxlmsPqZZHS0DxgHZpOfGcmKawoi/MFfiLH+0ce4Kbn6Y+/gewTIz+E2ZdUOnbXW1TGZMKrbwASINXfQwv80bKsZ5NIf94Sw9NEVO3RBB/IIoXmP0ie0xeGEHT8UiIrqoS8kPntNLX8W8Hcdi3VobfLuV7GLDGv12WG9ityJo9cjFG26LHR7rP6t7f1S7xMAubULcG9BWN44pTpMGAE0FbXXrXzpPbX/+lBsk/NXOlX9/U2dLT7WeQc4mc9RSWZikiWe/v1k16bK24UkDKgHCLfm156oNu0rmFechfXGHcU4GPpxjnzd2n/gMlEIuV8Ejo2/TY2z3/Ue/fUm1amIh69Ij5EeMw=
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pk17-20020a0568704c1100b0021a7a45e0b1sm330141oab.35.2024.02.12.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:27:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/5] spi: add support for pre-cooking messages
Date: Mon, 12 Feb 2024 17:26:40 -0600
Message-ID: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This is a follow-up to [1] where it was suggested to break down the
proposed SPI offload support into smaller series.

This takes on the first suggested task of introducing an API to
"pre-cook" SPI messages. This idea was first discussed extensively in
2013 [2][3] and revisited more briefly 2022 [4].

The goal here is to be able to improve performance (higher throughput,
and reduced CPU usage) by allowing peripheral drivers that use the
same struct spi_message repeatedly to "pre-cook" the message once to
avoid repeating the same validation, and possibly other operations each
time the message is sent.

This series includes __spi_validate() and the automatic splitting of
xfers in the optimizations. Another frequently suggested optimization
is doing DMA mapping only once. This is not included in this series, but
can be added later (preferably by someone with a real use case for it).

To show how this all works and get some real-world measurements, this
series includes the core changes, optimization of a SPI controller
driver, and optimization of an ADC driver. This test case was only able
to take advantage of the single validation optimization, since it didn't
require splitting transfers. With these changes, CPU usage of the
threaded interrupt handler, which calls spi_sync(), was reduced from
83% to 73% while at the same time the sample rate (frequency of SPI
xfers) was increased from 20kHz to 25kHz.

Finally, there has been quite a bit of discussion on the naming of the
API already. The most natural suggestion of spi_message_[un]prepare()
conflicts with the existing prepare_message controller callback which
does something a bit different. I've so far stuck with [un]optimize()
from [3], but am not partial to it. Maybe [un]cook() would makes more
sense to people? Or maybe we could rename the existing prepare_message
callback to free up the name?

[1]: https://lore.kernel.org/linux-spi/20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com/T/
[2]: https://lore.kernel.org/linux-spi/E81F4810-48DD-41EE-B110-D0D848B8A510@martin.sperl.org/T/
[3]: https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@martin.sperl.org/T/
[4]: https://lore.kernel.org/linux-spi/20220525163946.48ea40c9@erd992/T/

---
David Lechner (5):
      spi: add spi_optimize_message() APIs
      spi: move splitting transfers to spi_optimize_message()
      spi: stm32: move splitting transfers to optimize_message
      spi: axi-spi-engine: move message compile to optimize_message
      iio: adc: ad7380: use spi_optimize_message()

 drivers/iio/adc/ad7380.c         |  52 ++++++--
 drivers/spi/spi-axi-spi-engine.c |  40 +++----
 drivers/spi/spi-stm32.c          |  28 +++--
 drivers/spi/spi.c                | 253 ++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h          |  19 +++
 5 files changed, 305 insertions(+), 87 deletions(-)
---
base-commit: 5111fd347aee731964993fc021e428f8cf46a076
prerequisite-patch-id: 844c06b6caf25a2724e130dfa7999dc90dd26fde
change-id: 20240208-mainline-spi-precook-message-189b2f08ba7f

