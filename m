Return-Path: <linux-iio+bounces-16362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0FA4E4C3
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591EF888123
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7ED27C879;
	Tue,  4 Mar 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MdNMkUkU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A38277035
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102055; cv=none; b=kCXsi7MQryL4fLFO0o3g4WIlKi0bRfu8jSoC4bNpf/tGkqolNE9Zs0vXAtp9+HWztz+vGWDjPWnEvGfCdvabpis322lpEkvHTw+Kzp8JJmX6A/kFQlesd5vk3lp/IAYiPE5I0NGmuYGlus82CV2+/M4dqLW7e1YaI1Y2OVg9rvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102055; c=relaxed/simple;
	bh=QzL/6Jwrk5+OEZqUr5nej/Vdup/WUPqimuxioOMsDnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tl8JWIG0EMQZfca/yw8Fr431KfHYMax3uG1RnNU6IRbAUEuA33qEZwegQh+Oj8ydmyqjQPmszRapmyCG2WvwvrGRGaQcbE04DqZaGACjkAxSKE8MCgl5zu96cnR4PARPEUDT4G7RCffE2unNBqTPH6masql/XB7qqhBln96cyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MdNMkUkU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so4068641f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2025 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741102051; x=1741706851; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BLge0yQ5Ly7QiVOr8wvQ/f7AlfV4bu5713ouH8WzHU=;
        b=MdNMkUkUEt/CwfLUwMJNIKqKddQ/68vhhcSh6COrPzb8CbFHpLtlDhrd1MZZuc8NTj
         pRoY/J5d/1Y3X9G/jHzJFFz2Eoivjk3NecXbn3JvlKotLYslwrReEd9jgtv8CmpcPg4W
         5i0GfLDwxkThMngsi91P+FWKUaLGPbVjqyrmife9sRUE+U01EuufS5kO/krE80caF2wl
         g+Y5JeIrznFBQ+dLL5nBRDrHc+lqhgShVyFlcb9fNrA/SvB7+JbbQF09FmvL3P/PKkQ7
         hXlnyAvOK55Y7Ymy5QQJgl+2FHziXeLYfY4+MpVKhJt/pGoEpixcmuOtvDRGxkHGQvY7
         NFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102051; x=1741706851;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BLge0yQ5Ly7QiVOr8wvQ/f7AlfV4bu5713ouH8WzHU=;
        b=ZaLQWxq/ks4ujCaF8NiR7jpU1A2xofptq2lmwmFLcIitLFjY0AME35HD47eKxC8mc0
         GcxFr+Q06A+cPUQ8q5hD7kd6mPIgLDQ8HOYY+Yc9pw/gXiz6p4bthcggOqAekg1KM7oD
         vttOKvGsMhfCOMVjmw7SkxYJArIc9KLPiAp3Yh103LOfamxJp+xLyGoFOOuj2xY735kb
         sI4BDlMBma2qlc/epgvf/F2B91ChjYkqLBUl23eOpqd5xGGo87slpXMXg6WyZXwyN7gB
         hGUkWVu3UCfZXP+8FJXvt79bX6V2KHkywNUHzodtZhhJg+yE3l6PMLWrf1R5iIx3yGDu
         d9dg==
X-Gm-Message-State: AOJu0YwAIhTk4e/VakQt4wfOK9w7HymApj5DL5tv/iMPJcNLuME4nntN
	vXPz1dfS3/Sr2AVjkNhHC58h5t0yT+vGy0gFvSw0QNjjnLEiPiotCiSAlQIaeOU=
X-Gm-Gg: ASbGnctf6CdR8dBWizSQoImJzCroG6DolJ9ZcYciupJ/u6sgd5emZUf8EtLYXMpL3bi
	VGUP8FZznNfGR7LCmEyQHw09y1pU0C0X1tRSao26EqNyF+Q5td4sjzf9R8WS79IKq30ciaI1HMN
	oqjkVJ/q2W14JVc+350RW1xGRkRc7B7QysX8XN/pEaAgsGGt3wmUAgZRGQekzl0K3UmWOmJcRuR
	/mTPZOKpoL9o3/ZLjfYuXmUEc7mo3OU5hZ2AnU6i+ArBXs52RmZj4E4jC6sDxXPLnWkMDVClext
	JxcuySaQh/fY5Kw0CEgsUcyafrZ3LQPjz20FXr8Utj3hzX30i2BBggzfiQtf5iu+b/hKeBmicZT
	3nStBS0sPUs2AaGbGEBSc0MI1CBHgyMoNlQ==
X-Google-Smtp-Source: AGHT+IHXqIP8MbjkxEqvoAMHolj2v2rUB0Dn2DUpOMoOaxKJaJO9yJDenmATL1r7UA1nkYXV308fzw==
X-Received: by 2002:a05:6000:156d:b0:38d:e3db:9058 with SMTP id ffacd0b85a97d-390ec7cb945mr14176368f8f.12.1741102051464;
        Tue, 04 Mar 2025 07:27:31 -0800 (PST)
Received: from [10.2.5.157] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm18245580f8f.55.2025.03.04.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:27:31 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v3 0/2] iio: ad7380: add SPI offload support
Date: Tue, 04 Mar 2025 16:25:43 +0100
Message-Id: <20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHcbx2cC/42NQQ6CMBBFr0Jm7ZhxsGBceQ/DooWOTIKUtAYlh
 LtbOYGrn/eT//4KyUf1Ca7FCtHPmjSMGcpDAW1vx4dH7TIDExsq6YxvndANmCbFIDIE26Ht6vJ
 COaraCFsW00LeT9GLfnb3vcnca3qFuOxXM//af6wzIyGJl+okXBmyN2eXQV30xzY8odm27Qt1g
 yMVxQAAAA==
X-Change-ID: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Add SPI offload support for the ad7380 ADC. 

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- fix return value on offload probe,
- add documentation patch 2/2.

Changes in v3:
- fix tabs erroneously added,
- fix documentation syntax error,
- add a note for the 4 channels ADC variants.
- Link to v2: https://lore.kernel.org/r/20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com

---
Angelo Dureghello (2):
      iio: ad7380: add support for SPI offload
      docs: iio: ad7380: add SPI offload support

 Documentation/iio/ad7380.rst |  36 +++
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7380.c     | 509 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 511 insertions(+), 36 deletions(-)
---
base-commit: b7508a5a672275694c2a1b09a5f491ca2a56bbcf
change-id: 20250304-wip-bl-spi-offload-ad7380-ad675f2a2f5c

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


