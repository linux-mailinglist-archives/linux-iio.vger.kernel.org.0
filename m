Return-Path: <linux-iio+bounces-1971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24D83F525
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC291F21383
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86951EB4B;
	Sun, 28 Jan 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoIZaCRj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600551DA44;
	Sun, 28 Jan 2024 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706441181; cv=none; b=jR75tDguJqqc1wyUqbY6/6rvjT9B+Ky9GeQ7XvAziQNZJBYpgSjbZt8ZyMo1TvXhMcx+Sf9vkFOj+S0BWcD40eZf1BG68dTsK4Kf8SlfLDCvayuBrLKRMjEedptCXgMMHNShDIWiosbrZxQl5jtRhNi6ANjVqCUPAKyEep9OnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706441181; c=relaxed/simple;
	bh=+LrAqFqxD4U74s0cllRjZWSHjE8v3ePL5h7QatYrAzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxXEb/D6q0Qwnz/CU6BromaInFiI4kC7suG7Rhld5TrrZLDXabF6Y497A2uvaTwLQGD1/ZKH8QVClim8IRGqkjXc03DvKt+AW9y0eqw6xNXxVg3gEXZ0+bxePIO7B7Zvscixe8ScRBKqnnREq6BcapQSUC/TiKWzkV5/h/2fn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoIZaCRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496EFC433F1;
	Sun, 28 Jan 2024 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706441180;
	bh=+LrAqFqxD4U74s0cllRjZWSHjE8v3ePL5h7QatYrAzU=;
	h=From:To:Cc:Subject:Date:From;
	b=YoIZaCRjnDVXmr7OyMxIi95Qa0HHUQN028xlo6xF/fOCvv3B0ykRUG6yL7j99p3nM
	 rYwYvKuFMpYr6s9DOxVROXZfS9gNJRBjSMvcrcSy6lC4zCR0Go8LRzi+P+PyLUh3+5
	 iOizLpujGIX74mV22rOIGaNKd9VKQskOUNmPbBAFa2akyluEUNK0SeKrWybKrphHC6
	 xW3GQ/LKo0IefzuVFf7OhsolpWO9bQ9r/ph7QWufa+mcNkYdiecU0Ndhg+t5f/W/0+
	 /8ACOper5woYsVsNW1n+eNs8JWA3dLcTFbcNh/Jv8PdFww8TJDwPKxL1NrEAfECslX
	 Zgrc42UG+yUzw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 0/3] add support for ASM330LHHXG1
Date: Sun, 28 Jan 2024 12:25:42 +0100
Message-ID: <cover.1706441008.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ASM330LHHXG1 IMU automotive mems sensor
https://www.st.com/resource/en/datasheet/asm330lhhxg1.pdf

Changes since v1:
- add patch 1/3 to improve kernel docs and comments

Lorenzo Bianconi (3):
  iio: imu: st_lsm6dsx: improve kernel docs and comments
  iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
  dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1

 .../bindings/iio/imu/st,lsm6dsx.yaml          |  3 ++
 drivers/iio/imu/st_lsm6dsx/Kconfig            | 31 ++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 ++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 28 ++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 33 +++++++++++++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 +++
 7 files changed, 93 insertions(+), 14 deletions(-)

-- 
2.43.0


