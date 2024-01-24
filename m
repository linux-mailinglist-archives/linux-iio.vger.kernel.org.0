Return-Path: <linux-iio+bounces-1888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43483A739
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jan 2024 11:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182F61F241C9
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jan 2024 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A7E19478;
	Wed, 24 Jan 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDT4rjMM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49591AACD;
	Wed, 24 Jan 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706093561; cv=none; b=M8oll96KDSU9iC6LVMGC0I5a8F9cU6riyTkpOw6YUh23IDI3Fj/tYm4aDKoUh0JOfBVihO4EiaQweLJdiVIkY9EZ5JjvAbX+lHzhAWTNT4tmNW0oKKzFpr7XoKwHmtyGK7iCM5MEscIsJ5H3msFo2UWagMvPB1X3fbBb5zvxBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706093561; c=relaxed/simple;
	bh=eR7GeRgNBr4xJVLEQ/ipltqfY9Fz19RYQrjwBuo9I9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdlIyQfj4GiTBvrkbj+DqIRu202zJGHKajj6p1RdiSg6pDPKkKS6+22hcM7EkmH/Ycz48SsSeJMwXUBWuW3Z63nZIHz/198cjaqVsIyHEVk8xJGNA5cNCW55GLSxnQ4mhc8j6LLVg4iINOdw7cpI8hD5gO2oyFsV+bedOlycCtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDT4rjMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4C2C433F1;
	Wed, 24 Jan 2024 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706093561;
	bh=eR7GeRgNBr4xJVLEQ/ipltqfY9Fz19RYQrjwBuo9I9w=;
	h=From:To:Cc:Subject:Date:From;
	b=RDT4rjMMoKbujnEhh+kdlfZa44CJStDgltV4cYZOA8AswD001L7E9wx0sqEnQTV1f
	 asM80hgaZGNy2XyeYQ8PFFi5K8Ml897wVLpIZqqQbkpzeLYqJ0QvR7OKK/DTTVP+og
	 tyuZH24bXME8cZvkOjTuSDgZq/WD4CE9vcCKWiMdATXgcGPqeEIGYYtYye7RwWScFW
	 tLC2JqY+OJXqwOKp3S72k3Y+4I2FlyQrseVRd+GDtrR+Bir1flBLhzbzVv/W+sX/gv
	 Kb9Pxi1/QnKOe8snJekNeTTuXhgJUN7YUR+45B8MftzmMNhdJKX44dhd1Am+CyvLsk
	 4cQfvOj4MBOgg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 0/2] add support for ASM330LHHXG1
Date: Wed, 24 Jan 2024 11:52:32 +0100
Message-ID: <cover.1706093274.git.lorenzo@kernel.org>
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

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
  dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1

 .../bindings/iio/imu/st,lsm6dsx.yaml          |  3 ++
 drivers/iio/imu/st_lsm6dsx/Kconfig            |  4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 48 ++++++++++---------
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 ++
 7 files changed, 46 insertions(+), 27 deletions(-)

-- 
2.43.0


