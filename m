Return-Path: <linux-iio+bounces-9975-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036198C6B2
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492E41C2293C
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1861CDFD6;
	Tue,  1 Oct 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dto9pyM+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5861CC89D;
	Tue,  1 Oct 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814098; cv=none; b=G0HbMcIKYpAF0pUVUBhikEmA8k5mqToW286l+QI6pATvcRhEcyo4+cPYcbwThxYnidU2CvtF35sZ7Ci7B4SC+P/SxwEaK+re3eWzdRRw3iZKX9YQZZUU3gSfQDRHofnItrH9YUFiJAAS5Kj6SiHkzn+TOxtEgJ67oKtq+P43Tso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814098; c=relaxed/simple;
	bh=3/6AywqbMoREor1VLfM6r2TGX4RIOD19Lfz6xkPyMd8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VA/9UwXprYmGHd9t6wLGxBVNkDur57M732VzxokJeimIQCaWZisAt+zeaBp8J3jikix8TMOA8OaWCPNoEjYsN7hzih2vQFlsRFGL+0O3RiAPf3X/0FbfwLMhsLsoB/vQxOGpUEoMtLixXg7ThlXkTcRD7naaId1rzmvguvxh17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dto9pyM+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so52792305e9.0;
        Tue, 01 Oct 2024 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814094; x=1728418894; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezelZ2eO4cZycqa2Hz7OZT6UPWymQRpDpvxqv9rlmw4=;
        b=Dto9pyM+8E+enigipH92PDUM1XkBTDG/kcqan7c2KskZ849VzEquUtjbx6fBtjh7PA
         UX8wrN+I/609mc6cmG6VpPHJNYEsb5MlXeyChwu9GGO9AF3B4hbkC4ifYI4m3JdYNwHc
         cFDD8XNkx7gXYEgzFnNSuAmoargLpy38AyVux0yQ1PXdVuTD8rgWOl/UVlx9D95RaXqA
         f+IdsZryW47wPno59+nwkUPiIID/4xZzCIhNYKXhK3ZWoQoU+97Al83c7tVQ/mm63YFf
         DgqgLcQuYHXuLJCzJyBJPFpIPUxV2xtOxqLLNyo5v+Kfj4CN1UGcqbPYIN/u6jwd0mPt
         vx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814094; x=1728418894;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezelZ2eO4cZycqa2Hz7OZT6UPWymQRpDpvxqv9rlmw4=;
        b=WNUgc8NZCvuX0P3wgAgZLZny2+O17G5tgxA6AM/Usnjh5PSWErh+kkVhlTgzzYTCoG
         2pu7wS+yKR7u9mAIC2s/V0MxoyH+a6AAm8T1CXYB/2T9GTGa4J/zNphrq5v55Rut4vsz
         OhkhHUdbt0tA+wUv3X4RarJszSZ1BcZYPIfVJY4jb3djhOEh4T2VRxXPPBQUPLReDbdG
         kvfXgcKwS0Z73jBOjxxgm5gYsjYYUg/a6fHCYJfbvfgqWmugh8Sfg2MuPc83/heZjOlO
         S/w5O8g7ZpmgbPrcvgBPufT5HGu0qchYkD3Ak1jc0V0asmmaOf4FflxN0QFrlQiWy3aV
         PBVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbNobRnXrXQSVk2AStMbJ+IL9CviYeY3iZ1ifVBDmTrfQ95P4s24le9k+3lk/KHqigIfcEzVMzJwo2@vger.kernel.org, AJvYcCX+LVg+pGhdokx/StLNbyAXHKghVQRy5i4odWtU9J+uiLpNhBad7t6QmJAsbAgLeWTOEsggHNB9TxAWoDpk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7rgikK/Qg+s4rO9GQp1KfIUP3UmfOhs+IbVfo26HVh1S1AlRA
	ToZAP1DlLhv7yq6rXNalSBAKmc1rh95EYmwztZr7uUvlmgSToKdzkSj+mCSr
X-Google-Smtp-Source: AGHT+IEvffhBEodDezCJvvs4iUAAViG3bD29jQq3rkRFXkVY0yFD2jJ0xvnZdcEgwq1NLX5D39awGg==
X-Received: by 2002:a05:600c:4454:b0:42c:bc04:58a5 with SMTP id 5b1f17b1804b1-42f778fdf7amr4931845e9.33.1727814093349;
        Tue, 01 Oct 2024 13:21:33 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:30 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/9] iio: light: veml6030: fix issues and add support
 for veml6035
Date: Tue, 01 Oct 2024 22:21:13 +0200
Message-Id: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALlZ/GYC/02Myw7CIBBFf6WZtZgB+gBX/odxQae0JenDgCGap
 v8ubVywPDf3nA2C9c4GuBUbeBtdcOuSQF4KoNEsg2WuSwwCRYkaJYt2nmqUFWuM5i2hUlT3kO4
 vb3v3OVOPZ+LRhffqv2c58mP9R3gWiZwhwxY1IWksuboPs3HTldYZjkgUmShyUSSxUtQIg10vO
 eXivu8/Dk9wE9kAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=2214;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=3/6AywqbMoREor1VLfM6r2TGX4RIOD19Lfz6xkPyMd8=;
 b=RMsJ5riHq4FHk65ArXrsSl1MB1qm+4vCAMH8WOtmlIZ/GhobEQsVDqFRL86hU77SYQon9tZlf
 BewpsC4SwffAmv2gYCOf/ACtZYo44xJLa8JNXQq+//6pqOXBnmLsHFM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series updates the driver for the veml6030 ALS and adds support for
the veml6035, which shares most of its functionality with the former.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- drop applied patch [1/10] (fixes-togreg).
- Fix indentation of the vdd-supply property and make it required.
- Fix formatting (double space).
- Fix array formatting (space after {, space before }).
- Move action to hw_init function and add dev as an argument.
- Link to v2: https://lore.kernel.org/r/20240923-veml6035-v2-0-58c72a0df31c@gmail.com

Changes in v2:
- Rebase to iio/testing, dropping applied patches [1/7], [4/7].
- Drop [3/7] (applied to iio/fixes-togreg).
- Add patch to use dev_err_probe() in probe error paths.
- Add patch to use read_avail() for available attributes.
- Add patches to use to support a regulator.
- Add patch to ensure that the device is powered off in error paths
  after powering it on.
- Add patch to drop processed values from the WHITE channel.
- Use fsleep() instead of usleep_range() in veml6030_als_pwr_on()
- Link to v1: https://lore.kernel.org/r/20240913-veml6035-v1-0-0b09c0c90418@gmail.com

---
Javier Carrasco (9):
      iio: light: veml6030: add set up delay after any power on sequence
      iio: light: veml6030: use dev_err_probe()
      dt-bindings: iio: light: veml6030: add vdd-supply property
      iio: light: veml6030: add support for a regulator
      iio: light: veml6030: use read_avail() for available attributes
      iio: light: veml6030: drop processed info for white channel
      iio: light: veml6030: power off device in probe error paths
      dt-bindings: iio: light: veml6030: add veml6035
      iio: light: veml6030: add support for veml6035

 .../bindings/iio/light/vishay,veml6030.yaml        |  44 +-
 drivers/iio/light/Kconfig                          |   4 +-
 drivers/iio/light/veml6030.c                       | 464 ++++++++++++++++-----
 3 files changed, 387 insertions(+), 125 deletions(-)
---
base-commit: 19332fe4bd4659b2e3988f17b4d5dc59a86c266d
change-id: 20240903-veml6035-7a91bc088c6f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


