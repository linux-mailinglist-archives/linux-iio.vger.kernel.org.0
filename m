Return-Path: <linux-iio+bounces-12212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FD9C7958
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 17:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EE32823BE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083641DFE06;
	Wed, 13 Nov 2024 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EBHpjLZQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587BF16B38B
	for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516927; cv=none; b=MoBFhOGNWCznp0U63YH1mqbURm9uzzmDK+rFAIBz4xyGLyp5J5mX2j2ar8YEWscf+8dnHUPU0DP8aTcDgRzPCRkXaNmsXaGl+mEJ1ohaa+Y5EwoPDGD5i9yys6qllGXeagnnvLGLRUEdSdElZvF7jX5UNtWULbsYC4Ca/6YCh0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516927; c=relaxed/simple;
	bh=/Tjor6KKk4xz4p2UNnx1L3Hj+WRdCr3/2Kvmk9fys44=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hr70DdAUSBjfaaPi1o/HaJJFS7bm9Snjw3yij601QCzwYne5WB9lPrAiHaJldy64qjjpY9r4G/vJ4/dSTNYcPYHarnRfFm6k+N6LnCbKgC0+sOMPz8AHkEPIh2SJMN7gtI9NnQ2Z5X3gORkxB1dW6gd6aQckQmjz9Br/zoE8kXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EBHpjLZQ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-288d70788d6so3054697fac.1
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 08:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731516924; x=1732121724; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1zaQxPIwogRJjHGN9609O4s9HbrZpDwx8BCPdVZsJE=;
        b=EBHpjLZQXj+/e9GYrmZ4S9I0jW3osiycHkIQghrBVC7gZamF8+BeHKvn6J/5pWoV6p
         Ex7mFXp15e6Wnm7A680mbc0sv6oZB0yTP79m1S0YCEdVfhR+v8w6Bt79hTgTReYfGdWY
         s2QcizovsOdJTuyyQBiwau1UTV4fFkHhpCNu4snMETQtlVRX+/dYJpVuMHx1pQcbWhMf
         NNKOhaDDN+Vl6tB5XOnhUC00NZiwV/2Qo/s7qTLjsa+nipMDhigjeuVE5CuPqWYo3J+1
         T6Pua4rviHOwKCPWkWNvxLSIhKUyJGSGZggJW1NldJ1/BpUtsRtmCu7F6cHqSZw9Ovg5
         JCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516924; x=1732121724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1zaQxPIwogRJjHGN9609O4s9HbrZpDwx8BCPdVZsJE=;
        b=WM1t/yp+ia2QfPyM70ROttGsBcU8/qRfjLqARGg7nJoLjjQP6Njxgrje6fN6MWbbSN
         kKAygfkBuFwr48Lj57DAmX7/ycTyQMInsPgihxYL52Fmtk01mC+d5ElFj5V5ZHgqrjNW
         Xa0OBqNNqlt091EZnhIJFH74bpTQifTdlnwbEFM5xPcvhR4ec/XhfV76tYeMYT5s8Koy
         /vYZL33mKTlUr+VBpoVmebZNyfuxwFcqWsqtLUaJNEqbAhNHdg6IlgyklQM1LXEht8XA
         wMqPFPEdSeV2yUt6QusEifUdQkg43an99zVFNyt+Wjm8fJwKtWFzp1Lk4zb/vxZXK5av
         t9Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWpTMNZWeeDZ5So0PiHWFzSaj5YiHbYyT44G4z5F7DG7s4awoHPnAswF8WbWvXfvXtZ5n3bvdsZN68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lD0AAN3TaCzAYye29gacmpi9LfeAVZqP/xhtmbuugEs+K+cE
	ey9GNO5sx/LM9Wk6BejgGGTKKTDf/b8kozAa07n2v9wHRaA/D/ayDzltVQHZI6w=
X-Google-Smtp-Source: AGHT+IE1xuqZj09odVIcRE3lFsD/PKcU5+G/h9X7w5dwUoGWic8F3HSh6Ho0wCSYo0NNczzVP7u5Hg==
X-Received: by 2002:a05:6870:6107:b0:287:c014:c979 with SMTP id 586e51a60fabf-295600989c8mr17393653fac.13.1731516924484;
        Wed, 13 Nov 2024 08:55:24 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8fe5c61sm873432fac.23.2024.11.13.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:55:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad4695: move dt-bindings header
Date: Wed, 13 Nov 2024 10:55:18 -0600
Message-Id: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPbZNGcC/x2NwQqDMBAFf0X23IVuTBX7K6WH6K76DiYlKVIQ/
 73BwxzmMnNQsQwr9GwOyrajIMUqcmtoWkNcjKHVyd2dF5GWgcRBp4rvhgdvaTfWL4+IirgUXi2
 oZdZucM7mXqX1VGOfbDN+1+j1Ps8/vhsUhngAAAA=
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

During review, no one caught that the dt-bindings header was not in the
preferred location when the bindings were created. Move the header to
the correct location.

---
David Lechner (2):
      iio: adc: ad4695: move dt-bindings header
      dt-bindings: iio: adc: adi,ad4695: change include path

 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 7 ++++---
 Documentation/iio/ad4695.rst                              | 2 +-
 MAINTAINERS                                               | 2 +-
 drivers/iio/adc/ad4695.c                                  | 2 +-
 include/dt-bindings/iio/{ => adc}/adi,ad4695.h            | 0
 5 files changed, 7 insertions(+), 6 deletions(-)
---
base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
change-id: 20241113-iio-adc-ad4695-move-dt-bindings-header-d6922ef7d134

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


