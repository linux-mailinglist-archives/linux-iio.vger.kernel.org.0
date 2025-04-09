Return-Path: <linux-iio+bounces-17845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E08C6A81B3D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 04:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8859F4204DB
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 02:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F93A19D087;
	Wed,  9 Apr 2025 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GouUchpU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BA5D477;
	Wed,  9 Apr 2025 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166693; cv=none; b=b8U3dy74uPBpx1VybbDWP8lqTddLN3aS1HcUTXhnWaaIlY9NDWw6bH4oDNSfk/F5uaGwNyENsCi7QZ1shWFdSzsO44aFZu4SaW80cHy7Q5rE9JglESpfFOCVIgczLiDmWTt3sKil4Ko9k+SX/9dqGUVVF6EOqK5otZuKD66fnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166693; c=relaxed/simple;
	bh=wFOkiMLspFALPjSpgFRnQQzkDzABkgmIBO4EFc5XGtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9KdXcfNqHdhRO3WymuPFKzTMpgm0Ui2IaPvM1/Vo1wSwoGoNoa3Ms3tXEhdg3lKXEpxqyX2rmBwO4+93hf339US/+krgSckCoUc7e4SDfssgL7HmcZDw4cdPkcCCU0Q/CMMWg4d1YrIGE2xrGblZt/wsvfRhnSGPfFwvytR0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GouUchpU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af19b9f4c8cso4160658a12.2;
        Tue, 08 Apr 2025 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744166691; x=1744771491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NB1yrEv/gd13pBKMjpod5v8tFI+oBcUScr50TkD56M=;
        b=GouUchpU5laVZj6WeQeiIBLxYVjMdbOiTCXqoa5/UIMghcoeWFr8Qnrz1G5WBuFA40
         J50xoTzFTGEyGgrUaVPpVnKXv5cM+kcbOpkzj3YRnk38OSx1MkkF6gNezsA/He+cFK0i
         LmTP1CNMLhyzGEQGEhziJ5mvSPJg+XCK79YMjyQ/IA9JU6PKSz4SAAXEyMChd4btjsaz
         xrgshUatAo41u7BwGWs9+DulYFuXnLw4Dtcgx5YIMgv7qv2dluhBv53l2qA9N8H3698m
         GiBc0NXc5dA9Prj7i9bnuv2tp0Wz6IiTQNITTcmAZAW3AGLArvcC4PETNm8nTMtWKKii
         dQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744166691; x=1744771491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NB1yrEv/gd13pBKMjpod5v8tFI+oBcUScr50TkD56M=;
        b=PhIECwogWEtsHPpb/U8cPJwhnnNl4hejUC74aqD9luZbv8YoegAN3tdcbm7upU0Y9f
         oxlVTOgbJHWOXLJFlh6bnacuRjqrLOYC+dDCeZN+DEEGj3GizCCswR1nRk/Cj5gJVF9M
         XAWzY7rOLcSOBXh5ZYpRvBgIAgPVK9ZyyM0V7YSQwv6sTZIq8ha6NWxgbf/hw9CHnGxe
         7hdrYKBYrOwfGciBk2Cso+lO9ydlvySRdU3SBAQdD+M0ApiU2EghUiO8xKVMXY8Icmkx
         p1nRydzAhPnDqGtMj4C/tgtUkl6nyNj6UUqP3zsQ+7Okyusg84k6r0/dQyCkcs9bxlMW
         g4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjq1Z/r3ICym/v3UJ4YqPNWDPKJBApd9xEzrzmabEFvt1fXXhjgXJaImX7EkGQnLQdHm4c5L38EUkc@vger.kernel.org, AJvYcCXVz38nE//NfjwpFrcThrJmMzAkgi50hwIS20GTIRaPFwbYWAR2l04nYMWCK3jSZJ2X5B/nPqKzMi2i@vger.kernel.org
X-Gm-Message-State: AOJu0YxwoKs7iSPk1nDCPw5+eNiOVVs8bWnuRAauEj+9gu5h5DEuqhCo
	ivIZnrD9L/ViQhYHReZBxjvy4kfBNC+m/e7xIMj155kNLu5r1Ivo
X-Gm-Gg: ASbGncuoDsSpY9ec7CgelrL01wUXwUfEvBOhAJt6vcJPX/v9UBctR9AB+8mB3tp4EFD
	Emx2jFGmnVNC42DQIn4fx2J9/hytPJMBFCVKXDqZvIFZE3Ojl0BaWTDrWRJD+GooA25trbAVo97
	ccBYf8oEgCoLP9EbstUV10GB3IuBWrPZp1nfly6imL8eR7g2K69SFE3rH9Z3ALY0CYWBhNUzsFv
	B0A0oqIVp1OiV3nZHKesKFkYJvsPwFM6Kl63AMoB3nX92wIeh6E6ZkP3fbQroQoy5r/qUSChRFP
	L4N3ENLs76UEJSzNANWtbl+8B+V8D526voSYRdyF515nwzBgww==
X-Google-Smtp-Source: AGHT+IG81vtRZW6gNEJIwfJmmnOA4zymBL3+/Adw2I7j+74IVWjCfoldlLo7bVYU+V9E4kpyOLdg0A==
X-Received: by 2002:a05:6a20:d818:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-2015914c97bmr1855599637.8.1744166690983;
        Tue, 08 Apr 2025 19:44:50 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b02a2d3abffsm114028a12.48.2025.04.08.19.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:44:50 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v3 0/4] add support for winsen MHZ19B CO2 sensor
Date: Wed,  9 Apr 2025 11:43:07 +0900
Message-Id: <20250409024311.19466-2-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409024311.19466-1-gye976@gmail.com>
References: <20250409024311.19466-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Datasheet:
https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf

v3:
 - Add vin supply regulator.
 - Drop custom ABI.
 - Drop unnecessary mutex.

v2:
 - Add ABI doc.
 - Add complete struct to receive UART transmission successfully.
 - Add undersigned as a maintainer for the WINSEN MHZ19B.
 - Modify to comply with the IIO subsystem ABI as much as possible.
 - Revise the coding style overall.

Gyeyoung Baek (4):
  dt-bindings: add winsen to the vendor prefixes
  dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
  iio: chemical: add support for winsen MHZ19B CO2 sensor
  MAINTAINERS: Add WINSEN MHZ19B

 .../bindings/iio/chemical/winsen,mhz19b.yaml  |  33 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/mhz19b.c                 | 347 ++++++++++++++++++
 6 files changed, 399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
 create mode 100644 drivers/iio/chemical/mhz19b.c

--
2.34.1


