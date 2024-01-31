Return-Path: <linux-iio+bounces-2063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E302D843A86
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 10:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F40F1C26914
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297D0605D8;
	Wed, 31 Jan 2024 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESvBbWOS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F1604D5;
	Wed, 31 Jan 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692317; cv=none; b=rnEf9znzAC+6/UHDLAM4bMDxa3Vhq91RscrPTgs21iTnGLpGmCUaSoxhZnhTbC0mslDdLQ+fLyKo7w1KBH4G/Gfi9Hy1DAM9Xow7t+z1LHXYCn6ZO2kfdvLYMHZMWYt5MHELZUmRDMeK5B/drhpL0VaDlDy/OFytH24H5opjtK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692317; c=relaxed/simple;
	bh=62Fq/hgRa8jo76QOqL6sZRVTmmJ4n2SAovfgOv53/O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDstzRKh3GPqfgJE+MKMPCnvzzcgcUj+AiyVRgyKb65AWTqQMv69b1XrluLgNG86pGeLQgl6EeBCgG8NJS3EvZMV1qxPArxX548wOJUdVaTYKlIHOpOhZybiM7dhW3TBngZq9cm9bGVsj3d6DGQ3Vc1mDmgKRbeLtugip0+1jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESvBbWOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB38BC433F1;
	Wed, 31 Jan 2024 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706692316;
	bh=62Fq/hgRa8jo76QOqL6sZRVTmmJ4n2SAovfgOv53/O4=;
	h=From:To:Cc:Subject:Date:From;
	b=ESvBbWOSmmc3f+qbvDyn6A5uLJCAg/s3/ukhHD/QTm9OOnYlsCOQD0GYRlWEcRnR9
	 Nqa2ZT8w7r2c/059xpbwjkNPIlYF9kzdY+lK/OE6ppoAMTzyrr1rN8FFYNjcMYy7Ny
	 l1kSxFTkarrVX7ypifAWAl/m1SSYT5CRXv0A8oYC3KXtaFOj2PF4OGT4F0cbSxmAhF
	 lNfnjpybUpBZ63Af39WxxG63ZHL/3y4NFazdpVCK/0+5IDDb5dmyGgG4DlpTqyAnBA
	 T+TFUGFRaAKLylNuP3m57FtT3vJSYVOVjMn13oBXFXd85XKsmpq0aQDe6PUlIFSdxj
	 VbgzKU1RLqlJw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3 0/3] add support for ASM330LHHXG1
Date: Wed, 31 Jan 2024 10:11:28 +0100
Message-ID: <cover.1706692153.git.lorenzo@kernel.org>
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

Changes since v2:
- use lsm6dsr as fallback device
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


