Return-Path: <linux-iio+bounces-17598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C260DA7A7CA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156261891A1B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 16:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C118251788;
	Thu,  3 Apr 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aN1cneoN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D642505A4
	for <linux-iio@vger.kernel.org>; Thu,  3 Apr 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697231; cv=none; b=DA+/Nr113UDtsy4QUhYqWCC1TX2CprI8DSYeqbSTJ3hTvknQTnm72Y3UxD4s4Jve4lPq7veuZD1GBP+52PULLUGval9w28+Fy4ycjetM/a9C1BnaYaqDTOM3URGdheB+wDXqot/LfXsEltw2CQXssYwiAL39BZuzdTHh66V30Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697231; c=relaxed/simple;
	bh=1iOywepJB9D1Cs5fFJUAHOEJHl07Klqnogg9LfO9XxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gv654PIodW9telwvmj4wzCioeMdbuwiTW5PuFvB4SKId02H1N4pDytKEMosM/ny99Pn8S9i/SgHDVwrh2B8/Fiq3kOM89pTuA8dgTv83ue2KaqyYcOK9P3CTXQy2TWLncX4jpnGbxEB6qsGQEagpluAtFqJPz5Uz8CRZ9HBWaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aN1cneoN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso852758f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Apr 2025 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743697226; x=1744302026; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBVhL7yTpzF4aCvVs+zDC3x7gXGoHrEnyJnBgzx0lPI=;
        b=aN1cneoN4fAGjeNete/43fsr05bCaB9UZ//8VKbsomTvqXPUU+ivTk6AnZXcw1KCFP
         askYWR7CGm8DFTPCSAxRiBCHPVK0ynEDymmz4hR3MkEVU36WYY7U9GYnBQV3okcHN+ho
         u/eqSR1dSWPmO95JK5D9lDOTAS6q6AxWwZKafvYP3o+iORT5OVKotQn3y3znQD0ZHB5j
         Uw2/EMugWItXYH55T48AUCBk0z44FHgnPD3NdUgaxK65n3EUAVRICeDrCktmbMKvST5O
         iThSNX13BaOmMiXn3Oj8ggclNyptogjmoM79YTNhttjwZJuI0m6HIMjSED4vWSo3wZDf
         Z8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743697226; x=1744302026;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBVhL7yTpzF4aCvVs+zDC3x7gXGoHrEnyJnBgzx0lPI=;
        b=KlQuDYY3hl1ZTfissOFbaHgOT8f000zkSrOj/W1o3faQm4ZflD1bSCWcZnEMdFnPB7
         +f8vy9oSiyQn6/zgZTbvF5fgDIZZtHfmFzlNAa9r9u4ZweMBj+WA105hW7VUh6brUZhm
         I2I4iWVsLn7GdchGgAn25IvIdQlJBVQPgD0aAaTItfSMZJw9Dwifc96wnzSSI26ZHwD7
         3JoA4Ms74Nn1n79HjBR/b7WwwFGr2DtrCzfAaZ65HwunONmtpn9QZGvzWUi+z547A+/0
         5MR1PnI10ZPJg0Zm6HatibmcOClYR0HccmRqER5PvSZWFUePlWYpwS9fHEpGUzoSYNFe
         F7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUTqgfNXunbUpd/YQk6/UQge84d8ieDy2vP2GkCgQyhoZEXIHiDWsmMs3kZeTRtbzZy7tFmJVNXMUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOszWoKNG6ZKiMBHHhITa/wguiPZYvToEu39HrvVHIlHmQEIVB
	eY27kyYcOkCye4zuqTcNPDXkeIpIiYOKwL3uUdbbJAGk2da4N3kEjIn4YvW6ywQ=
X-Gm-Gg: ASbGncu3wdpIaaUm9LNTZaxrwF/auGuGn8GyHHbaSPOo7ad4eRSvDGL6w6ora0/L7Fg
	zG8OhtZ14id/O3CkfGXtjiLUS8WraCV4yX2+OuVa23PygZGUTM8BEeX4IwYJYxR8qlTHMBeNdJl
	Vkg5f3LA1RiVNUKxFct4TTDmzrq3yj17aXoTMzpqPNsRvFqxLPH8HmUtMyN1CtIiFWYqYuKPy4T
	RI0MnHIoEEZkafKlVxmE5ofqdvi0YLWnjb+xCHgHhVYGxxFtgjTOmAEBnDb10znsluuctOax1RR
	H1id7NOu8h98Dm/6JR1KvHFblzQff8Vnav4neKz0DNkFJMo11BeiNxB7SqLzJ4PaITQwslWVIM5
	EAwKfa0ZKkT7GAa/DTabpng==
X-Google-Smtp-Source: AGHT+IGJDhMx8oCC7Tp11JFpxULIlT3VQCaTVwlQL+bVnYZZqD0E+NDnAZopToyMwMZDTLy+RipN5g==
X-Received: by 2002:a05:6000:402b:b0:391:ab2:9e71 with SMTP id ffacd0b85a97d-39c2975188dmr6368451f8f.20.1743697225664;
        Thu, 03 Apr 2025 09:20:25 -0700 (PDT)
Received: from [192.168.0.2] (host-79-30-116-65.retail.telecomitalia.it. [79.30.116.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d68esm2197657f8f.67.2025.04.03.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:20:25 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/3] iio: ad7606: add SPI offload support
Date: Thu, 03 Apr 2025 18:19:03 +0200
Message-Id: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPe07mcC/x3MQQqDMBBA0avIrDuQRk1rryIuYmZiB4IJCagg3
 t3g8i3+P6FwFi7wa07IvEmRuFa8Xw24v10XRqFq0Er3qlMt7pJwDliSYPQ+REto6WOUQedpGDT
 pr7Ed1D5l9nI873G6rhsqmluEawAAAA==
X-Change-ID: 20250403-wip-bl-spi-offload-ad7606-cfd992d286a4
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=1iOywepJB9D1Cs5fFJUAHOEJHl07Klqnogg9LfO9XxY=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkh/t5XxyIyq2Z9+3MsNaDwlUKCz5WuTZU6c5d+tlRu/W
 c34UfXMoqOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBE/EwY/tnq7rt2g8v7o9eW
 D3Psb20S0j39u/xx2oL1ATOCpxgzcS5k+Ct+VvX4JbVNfBoNVduPz2IrrFhqW3z0mnfw0qxzrH8
 /xrMCAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Add SPI offload support for the ad7606 ADC.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Angelo Dureghello (3):
      dt-bindings: iio: adc: adi,ad7606: add SPI offload properties
      doc: iio: ad7606: describe offload support
      iio: adc: ad7606: add SPI offload support

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   8 +
 Documentation/iio/ad7606.rst                       |  45 +++++
 drivers/iio/adc/Kconfig                            |   2 +
 drivers/iio/adc/ad7606.c                           |  50 ++++-
 drivers/iio/adc/ad7606.h                           |  12 ++
 drivers/iio/adc/ad7606_spi.c                       | 210 +++++++++++++++++++++
 include/dt-bindings/iio/adc/adi,ad7606.h           |   9 +
 7 files changed, 326 insertions(+), 10 deletions(-)
---
base-commit: 8f159ea5a253d40682e041daec007933d6caf01b
change-id: 20250403-wip-bl-spi-offload-ad7606-cfd992d286a4

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


