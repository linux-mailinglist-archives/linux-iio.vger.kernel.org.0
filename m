Return-Path: <linux-iio+bounces-2113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD384856A
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 13:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C33C1C20EDD
	for <lists+linux-iio@lfdr.de>; Sat,  3 Feb 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927DD5D8EA;
	Sat,  3 Feb 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5MLyNes"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28335DF0C;
	Sat,  3 Feb 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706961728; cv=none; b=EMzcaExgslhwTLkXHt+xlzs6hhJX1o4heumhtQ4ZghdRFhC0xdqK9qtHlOPsf/zHVZndBzY0/kIlJZbOIH5nEmtmpHC8LRmjH4iGqknKol++rQEiib3qTbTbjX5oNFpHmln5Dt5eGh6KCTUBE/qBH8qYPbilG7WAa7nbVLL6GKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706961728; c=relaxed/simple;
	bh=QYjGCW4DhEn0eFaWNi5vETz4aFaIIi+kwk52IX3f9CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QCyMRMcrnm5dBhY7d8g3/8XhQ+X1F9zA8BAEyaP6PEZrc+Mshlpx9CarY5ajtTEf62hgDPSFjfTcM1WLzNqZ8g02VwKm1eiHo3iSXkrNrK0RDDsBJ9aAiNTRDXWV3Duihc+IkEBPKQgmrd908hznDYvDSJUfvgbTrMBILb2Sxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5MLyNes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0479CC433F1;
	Sat,  3 Feb 2024 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706961728;
	bh=QYjGCW4DhEn0eFaWNi5vETz4aFaIIi+kwk52IX3f9CM=;
	h=From:To:Cc:Subject:Date:From;
	b=I5MLyNesuW+haKCP/L9DGLAKpgLYJZJ1vlV9ZnG+7YR0jOLgMRpz96B023nEYVEQ1
	 mZhfnKPDArDYA3Flx326ka8oOaeoZI+xScNhDIiQ2hiKbeYwuSa7QVyFBuV8D1CPSK
	 GsTnYtWU/DOhWnaqYYa/irNYy8iUmG507kLG06eZIPwJ589zp2dDQeIQelIyxGT14r
	 BfRe/lVeL/jkoSRKTJkuNsXcRse+4AD6BGtchDJqDQUEJQbBrABLT1D8gFwGK2G4Zm
	 Pk0Mw1lDNUN1Zzyc5zaEDqBQoB3WdMW+YCT4dcFpecZFLRIuEIwbh3HoQOPhRPgSeF
	 rT4dzRY5Rot0A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Subject: [PATCH v4 0/3] add support for ASM330LHHXG1
Date: Sat,  3 Feb 2024 13:01:35 +0100
Message-ID: <cover.1706961432.git.lorenzo@kernel.org>
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

Changes since v3:
- fix commit log
- use lsm6dsr/asm330lhhx as fallback device
Changes since v2:
- use lsm6dsr as fallback device
Changes since v1:
- add patch 1/3 to improve kernel docs and comments

Lorenzo Bianconi (3):
  iio: imu: st_lsm6dsx: improve kernel docs and comments
  iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
  dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1

 .../bindings/iio/imu/st,lsm6dsx.yaml          |  4 ++-
 drivers/iio/imu/st_lsm6dsx/Kconfig            | 31 ++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 ++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 28 ++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 33 +++++++++++++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 +++
 7 files changed, 93 insertions(+), 15 deletions(-)

-- 
2.43.0


