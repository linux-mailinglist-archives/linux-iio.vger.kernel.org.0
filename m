Return-Path: <linux-iio+bounces-23807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10388B46326
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 21:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05A3AA04F4
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A461271A94;
	Fri,  5 Sep 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YNZ2vfPU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79711315D5E
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099204; cv=none; b=CEagMdUfAONQtjpH4eatN1B4E3BFzOsZD5RCHtU6ZxM8ygnkUex4FwQUqbIqsonuxP8WvUy8er1AMaORlOYw8H/RWNNv3JhVGj9HuPvsveqXQ8dHH9qlBPkQ3wGESoVbQsnVjMiOZthqWi/BSIhJ1XCU3l/6no1gIpmkILYDqvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099204; c=relaxed/simple;
	bh=Oz5yDzgQI8awDA1imkucYa+mL2QojOG0Fc1fuxu/aJ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C2ZBtQLyb8bWvnDYY24r6Q9P6qAMT2m15ADOwMs8eG2xd/ShW+fMhLSy99pnN98gtfZ2yg4NLIjuUMcu9LkZaMfe8T5UmNlgtgkgCKpjXlcDEqu6ZtHMwnnaKfe70G3SifWsUCsRcuY1Y2msuJVMhC4vqV+u9YJJHgxUVqd6PX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YNZ2vfPU; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4381cdb6100so241391b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757099200; x=1757704000; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=etsxjyg4YfsF136YzaCNVjjN75F0ELAgmQtnre7usq8=;
        b=YNZ2vfPU+9WNHOLocIvgTpnkXTaX5I7qhHP8rJiCQjWyq/gTrWKwQp7EFrskhEqdOR
         MB8l9+vlx11dwaLYIwW4uxWNoPsEPww/WN3WQ8P0UYa0nW4QTk3j2f9a1ZC18oLCqcBA
         467Czs4INLFpj29DkUuu2KERP1LMiau+3K4dvFwFGOK3hnHlcGeYRrXch2F9R2Gjyabl
         JA08wC0UNUeK/kI+mYbdkkW2L+86WZPalZIjNHy2o5GSbx9cOKBGs2ek3t/vZQWrJghr
         t+4F3HseqxstHwKux8AdfsCiC431BqsM7OrL1GVyantMDhnCNrSGBA6eg3SxXnwh1t2a
         6Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099200; x=1757704000;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etsxjyg4YfsF136YzaCNVjjN75F0ELAgmQtnre7usq8=;
        b=U1g+E0zaC9LAyQ2ZZDwvjU5CL6JQa13ePdjZJ9i8srcVlmLkCE95G7DGZh8kG7yhvU
         dq2h3Sxcgoa4QfZXSaNOPOOS+7kVmOumzJzjz2+qwQoS5hd14uBVajEECwJzBeZoqu0e
         He4useqnbVJWUyzCSxsWuLpQxWZ0aZCXWtkdfpeCyxFXfnvAT6KdgoiwAxXdwEi73/zA
         bKJzDuTYSwSMFVCiTtMGBqzN7gydFoJGtunWfMMkKT53kBvdYp2kvSECMpVNS5ua+A1P
         F2MmANOGPD1S5MjmmzPtafeZvPOep37XFDczLcA6/ngZolRAg53WJKY9E9Eo3XKiRxFu
         evTQ==
X-Gm-Message-State: AOJu0YyK1QGeOMK5mfpt/JyImhl1Ovu0SL2OpqW91A5HN72GS/XERX2s
	VPBeBaYKKFfqxfuoDVaP00IRYhYKzZV08iMRqqdC66/mJVIAECt6k3+kw3APd/OQgqI=
X-Gm-Gg: ASbGncvuGXm52f73q6HAhedYcm3Gdxvg/geJSr9X5dE4BfBAADvE0A1g6DkMNG++XCN
	Tr/tiCRrHGqGeRLXGgPWzScyrsbQeG5+ZOfb3GyKNj+9uollRvclNdIv4HuQYfdn+pcWL1uHovc
	zzL+BLw7MtwM2jpPV7ZK+aSUNyNRQyQ8E43sitAkuix0nw2in3kFKqrKKaR7RqyDkDjtfwjDrjH
	nUzHznQi+dOme9jMTcO3LNyKjitKbVrazOuLTJE7DoqHR4lnyaB0ZgNGGFuPTnh5TLAAVFUF4a6
	M6foWrx8agn8Mt/rpaBzUE3ozjhNBj32eCc9wCBFFHLGpGqTPbtLewlohcLP/WERS5xSutQ/Knf
	q80zkzmgp+079URVU0bp4qC/+rQ8V6OSX1TmzOQ==
X-Google-Smtp-Source: AGHT+IGb2wPJ87GBn5tZFfPrsJ5SE9jzXrr8X2eXRsXMsEyQczk8Kq0+HLyMFMXmoPvldHEQl3ByVQ==
X-Received: by 2002:a05:6808:48d4:b0:437:e5d6:8c2d with SMTP id 5614622812f47-437f7d20d05mr11191216b6e.2.1757099200370;
        Fri, 05 Sep 2025 12:06:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cdea4sm4474018a34.39.2025.09.05.12.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:06:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] media: pci: mfb4: iio trigger improvements
Date: Fri, 05 Sep 2025 14:06:18 -0500
Message-Id: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKo0u2gC/x3NTQqDMBRF4a1Ixn0QU4XarZQO1FzTO8gPLyIFc
 e8NHX6Tc05ToUQ1z+40ioOVOTX0t86snzkFCH2zcdaNdrKjRHjOUlZK3JZByCy7MgSoMBbNByL
 SXmWCc3c8Btv7xbRaUWz8/k+v93X9AHU3OgB5AAAA
X-Change-ID: 20250905-media-pci-mfb4-iio-trigger-improvements-9e223e8401db
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=538; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Oz5yDzgQI8awDA1imkucYa+mL2QojOG0Fc1fuxu/aJ4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouzSsMhuA2T7Rd2KLgFjqVh8RHlIQ9HroD7RTo
 9zWX9M/26iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLs0rAAKCRDCzCAB/wGP
 wN07B/9aoidv/luxO5+2nSwYfZqdQIx0hMvAPa8IY/Fq6zuk6JiRGh+/JYuiFmmC5OqEMXvZufB
 sKkLsSsBJlS5lGVBG5PImh1SIzTMgqMZ+kgFV8tR4PvJzZianRyLPz8IhBHoQbS8TBEJ++vALFQ
 jF3gkH0Ftq5hKvUmlp/XmyeJQ78UG59IouM3n3l+pcwkhz1GVm26Up1hkEUYSHhNM0ZSkFvsnI1
 5Kq7loObvRTDOASrz7pdYWBIPSelxq4MUf7ct+PW6cR7E/kCOAa19AX11PzI6NorowPCEDoLgLw
 6hGIvI811zFuQ36dDJj/kmBKEqiIimjK9cnSd0whdfa7oxDO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This follows up on a couple of suggestions from Jonathan Cameron for
improving the IIO part of the MGB4 driver.

---
David Lechner (2):
      media: pci: mg4b: use aligned_s64
      media: pci: mg4b: use iio_push_to_buffers_with_ts()

 drivers/media/pci/mgb4/mgb4_trigger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250905-media-pci-mfb4-iio-trigger-improvements-9e223e8401db

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


