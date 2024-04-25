Return-Path: <linux-iio+bounces-4515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697A8B238D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591C81C209EB
	for <lists+linux-iio@lfdr.de>; Thu, 25 Apr 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349AB14A08A;
	Thu, 25 Apr 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mKpb3Fly"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD323171C2
	for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714054217; cv=none; b=DOgnVDtTAg34Y56D3W4K4CpDFoeRaTA6KduO6vzsEAG9G5h8qDGWazmeaIZxoalqwSIJKyeG6io3Gz87XWyNgBguxKTqRYW+Lj6rMeFyssPy9KeDUrrwKCeu18wJgr95+fE/qjCCNf1y8jasLCxk9ni0h0r4kp9uM7r9vjACmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714054217; c=relaxed/simple;
	bh=PMcrQr7vfTZSRSNcRmkCpyQp7LWBnFY770gK/C5SUSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YeK9m2ZeQpuc624eda7r0qZwSvv7kTDDfS56v/pI37rtsVsS81naswjKM6haShNUEbqYjX8K4/oLiP7j0MQQ/M9DTKP0MpwoYXZ804TfWYL582TOdIPJNCnFusJWtt44fjHj6vFAsARvUPZhP57/26xVnOFt4ftxaYsru5obaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mKpb3Fly; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23935d89261so478103fac.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Apr 2024 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714054213; x=1714659013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EIvcYkNNA7uNCHReQKx+DoUp53lMP7MDiBbZ5jB3G0=;
        b=mKpb3FlyRk44HMN9uezQae6MeQSwZ107oJt0ulYJ5nBVmj4A3A7lp0y0WaaRQyVObP
         Du/eHRzlA/hviFHvjSYTxzdhVFydjLZMlihRhCFMYFsnxfWu1c8UHTf/VgVA1LY4PxMT
         eqZARisR0YCl8o/E7fzS3WFnSO6gzS84fxv2jlVGADiEfBUF6njP7By8HVzHiR5cQG+6
         F3LNAT1kg6vAfuURYk8v8SFX4k6hKBwtF5cBFjS9mxv1fhrsTxjlPKjzZjhbIwia21Lu
         UDadC7YV2P13PUcbfgye4ZT78SOFcyTjAYetKIR7AW+06T8qX4x7010+NniHYdgBWh4C
         EPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714054213; x=1714659013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EIvcYkNNA7uNCHReQKx+DoUp53lMP7MDiBbZ5jB3G0=;
        b=Lb32PclBhuARZ9NNkDU7DCUxLdeGIrzlF/sZir0fvY6t4Y7EEP6K1OkNFas+D4ln06
         iBIofIelMvFvx4mmCu+x9YjdtO2FBfqApuSRY5RYcSIjDEJ/tq/pZOFpQPf05Ujg/Qro
         2ikuJAReFbNu2qBBQ9/R6fSSbY+AcGbGuE9Aza/QTjadV9rc0G9YpRnOXu4Pc+FB3AGX
         buBzqEzv3wIMqmmi2f63DVKdWZOEJ4S5NXUegWiIObSYzdPoVO88b+Ji0ey8khsUKXi1
         httPU+/ejsQ6Yg3tD/BDdr7qsBnELqyOqwU1Vu+HNPMEvmwxFOOhHW6aunEWqfATNDrB
         f1zw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ukF6b4HPGaFdieUk8LIkgRRaDYaWOweb4prrkv5hcw5gp58wZiDbBsYfe87YaqW0zewrhnNthltwYrBrCa8yGmCuiZbmaHc1
X-Gm-Message-State: AOJu0YwXiFfOPW/+0gh3cZKIhb56xu1259/M69mTpb9tMlLtq+qI9ZJp
	bx06nrjioCfMCVXRaWfEjEdXJ2yun0PU4cOMHdDhoHZMJhknIYM6NpAE5XcPYvk=
X-Google-Smtp-Source: AGHT+IGPh8BWqW4vel5Qzl3DF4uhNTmrKORgW/O0L3hxpcKmJ6L/waBufcrQ+V8+zzseyb0YDKubeg==
X-Received: by 2002:a05:6870:e408:b0:22e:b2b4:f00b with SMTP id n8-20020a056870e40800b0022eb2b4f00bmr6380665oag.39.1714054212707;
        Thu, 25 Apr 2024 07:10:12 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id pz8-20020a056871e48800b0023b5203fc58sm294786oac.37.2024.04.25.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:10:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/2] iio: adc: ad7944: implement chain mode support
Date: Thu, 25 Apr 2024 09:09:58 -0500
Message-ID: <20240425-iio-ad7944-chain-mode-v1-0-9d9220ff21e1@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This series adds support and documentation for the chain mode wiring
configuration to the ad7944 driver. In this configuration, multiple
chips are daisy-chained together in series via the SPI data lines.
So it appears on the SPI bus as a single device with multiple channels.

---
David Lechner (2):
      iio: adc: ad7944: add support for chain mode
      docs: iio: ad7944: add documentation for chain mode

 Documentation/iio/ad7944.rst |  30 ++++++-
 drivers/iio/adc/ad7944.c     | 186 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 204 insertions(+), 12 deletions(-)
---
base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
change-id: 20240424-iio-ad7944-chain-mode-f5c4e6a856f6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


