Return-Path: <linux-iio+bounces-17844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8A3A81B39
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 04:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4F94C2F7E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D018B46E;
	Wed,  9 Apr 2025 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLA1yC6r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1635D477;
	Wed,  9 Apr 2025 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166690; cv=none; b=btu9Oi5KpK05Q/j9UG4Tof+on1iqBzKw2SH8ft6YNKOn6fQrEO6cx04Yj439u/BRZPK+9UNjUdzDUxUFpGg/VyEgRmJfrmmR/QsCdIMzLi0QjMIWfrglUvRVFomeZ3qqbEn26Y15HzILv+tuKss6o6VQsGSXW0LWwksjgM+C8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166690; c=relaxed/simple;
	bh=wFOkiMLspFALPjSpgFRnQQzkDzABkgmIBO4EFc5XGtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XgWrkMmlOTakrIhMOjOd9CpCKoq+zcLqRE8aU32WD6JcBCBQ+ltv9DlseYGE1lCXQH+L3zRkXJ467dMLVWtKxUTgThK7h2/Lr3B6SkkYqV60RYB3UDlVldNfkIS5plOxdestNERgRjhOEdgU7s3YsA04nLL1Yf9kDA6y07JFnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLA1yC6r; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af579e46b5dso4155798a12.3;
        Tue, 08 Apr 2025 19:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744166687; x=1744771487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NB1yrEv/gd13pBKMjpod5v8tFI+oBcUScr50TkD56M=;
        b=iLA1yC6r00YUk5mep2CrlTNHSrEgPHTK6PBxFPaZbqZf+waYjJH/wA9RR/xIm2nV6z
         AKvGdabOPUjYn6LuJcd2v0zc5LWyGlfhslhv6SeDsjcywxo14lGG5SyFUXFqfHQXNn31
         zeGg9/OhQxcWocgkKWyO+hNVKhVNv0XUfia/a6GhE4h3ULA6ubv5UWRZ3ZZfw+oQk2Bw
         tvPv9XS3GeBz8K02v3gkIinfmIwu1T60LOZ0JNB4tQh3X2BqXzGyrezFgcBYUIsZL0b5
         KgOorJtTPUPqSbdQB4vqD8fOZaC7TKDtks7KYZr5iyBBYlh1sS5Amrfa4D93EkTEfMDn
         U0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744166687; x=1744771487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NB1yrEv/gd13pBKMjpod5v8tFI+oBcUScr50TkD56M=;
        b=RfH6874dytgB/G8T97U4ax5vGTeOW4Uur1AessWGhuOVtIBhv0e1l/vBuVi5k/C7JU
         ceVP1a1JsR5mjqzBEtBVlmtVpkIqcIv3WBF9ptaBQhctcNPlaaPYNx1PKHsdrm2aieG6
         n4A0DeCr5WXs/kzflb/VHQAuH/EE4FzPK99C7LljjjeKgrJdo+cXQ34/xYR7q7f5+Zk5
         3gRJkjHIyE2sqH++jBg7aGif7HH7fqAY2DF+n1YSTFux5DYa6gsbxT7fxfjvzelxml7E
         IEfoZuVKo+01/F4pxQUmhZPosYeYuQnE9WiWxuqCnxvyv1+GkBthgbdeY9L5Fd8EuajG
         SIzA==
X-Forwarded-Encrypted: i=1; AJvYcCVY0xjBtz1RQ2VFpzgPvVrufs0AMg43JB6BEnixs2sGH7B6MdPzVGfKfufUy2ZAdQfDC/+0GlDAjS0B@vger.kernel.org, AJvYcCWCOPF6acBfAUJgXT+ysWUwiudpX4gzA6WxZMpu+vmiT8VWmnyGnlrersr7OeZc1C6Jqjz7SbMyfaQE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6JT7zbaZr+QtxeBghOfvBIZ/c6Tnf4onUmDbIWmFxFWZGoQy
	cJiIwg07vdqUBMKG0t+zMD3Atm088N3UFuUbJ0/Cw5UHPuNeId5I
X-Gm-Gg: ASbGncuTnecfJoVeTqu9LDLJamX5Zhg8xgZ8ZN1oAvrp+mEklpryiJg+LPG3dk9e2ws
	XfvloseVpXSsOSJD6qtlYXjPz0ERfYmA62prVlGWx0FdzmYC3UryjcwYFZLMx8hbZ0auPsiF/h/
	VoekUdyYxpBsNR+5P9q0KxfpQ+pp2kui3lJ9EGNAcuWY3/HZr1QR82asECKztMYx0zaPhNWQg9X
	og4J2TtdS8Q8TjMHi7qSm+yQJUYF4vgnGZoghJMhCmVnRrdgiFffE5XHpR/AXCg7g23/Q0bIc3E
	vxj1YW1WuoPrVwlqJ9glQGz5oZGBU+uIfURQkAvLlQR/9jRGCw==
X-Google-Smtp-Source: AGHT+IG56hyShGt4RxgroS75C1kgabEP8DvBwlC17oiVRM4kkVyHfYzX+g+4U9jw5k6GklU+S+5UrQ==
X-Received: by 2002:a05:6a20:12d2:b0:1f5:6f61:a0c2 with SMTP id adf61e73a8af0-201592af1bamr2111607637.34.1744166687514;
        Tue, 08 Apr 2025 19:44:47 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b02a2d3abffsm114028a12.48.2025.04.08.19.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:44:47 -0700 (PDT)
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
Date: Wed,  9 Apr 2025 11:43:06 +0900
Message-Id: <20250409024311.19466-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
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


