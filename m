Return-Path: <linux-iio+bounces-10461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4E99A7F7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 17:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411101C24069
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B53195FE5;
	Fri, 11 Oct 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="P98Bo4tS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eURhFjgS"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF781946D0;
	Fri, 11 Oct 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661101; cv=none; b=IjuZdm4rJ92Ch0TszfPnDcjNVxzHH81yRxrPNKOLM4DZn9sm/xVfXqJsQ7lb5zmoUDtiRIPuoXeprgQB6OeGISFx1tLBgZCZ3vDL/2UfTM1roq7chPGER58ciOKxp86ZWWjghVPDRWXP00ms+EcCdNf/N89D+VMRXhIN8rQXmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661101; c=relaxed/simple;
	bh=tB04dcyu1p3tDuTO1UFKgPuXQnmgUJm92UfAhpG5oG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3Gwv79uQifd9Z0kBieg5hu9f3d7FLllDO/Yqy22lknZcvRPi+yKhNres1oI7aXyKH40CE3JqJCPGn7SvC8lrB4m6Bppa9/T2iRK6UAErI8RX2pwQT3FkLBx5wj20iq6wIKsAJCC86e8hy/elEMbNvbY2Yf3rjX47FrZswC1fz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=P98Bo4tS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eURhFjgS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C8AD2138021B;
	Fri, 11 Oct 2024 11:38:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 11 Oct 2024 11:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1728661097; x=1728747497; bh=Iv1bN6LPlU
	yed6AGnlaSdg/MCrJJV1U9vOCapSaRGQg=; b=P98Bo4tSGnaYyM8KiggBgcrvG4
	FPPP9F1d7zIp8T48Mx76wWx3qV1PrbAJKUXnyqZgYG+rWpAZM3JsF0+jAiu18xnd
	P3jhS0x+56jG/SVZMf8w7wi2zcFl6iI6VfPpmbRFtx7OHSuzPAvFwfWUJwR8zbtI
	lZirrvfOcwCg92Pvudc5sy/tzz4ioGu6wvB+Dh9vcVE9Z1pIRBueya0UTsVsqPhr
	gOmUH7/W50EytemcQuPqQU59zzTsXYr41X+D6uUYMxFGqKa+skA519cO6gCRURrs
	FI0i49duowglmQkK2r+1pf/ZG9bKE3uPY9+s7WKkQzQqHMWCuWzfFGQuxQDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728661097; x=1728747497; bh=Iv1bN6LPlUyed6AGnlaSdg/MCrJJ
	V1U9vOCapSaRGQg=; b=eURhFjgSmC3lKIVsQY2d5CKW8XLRraAhmZCYqD+f0paq
	dUkOPPWC0st+Q1kfvz7G8/XlrxtXJTuFa5XIYHwXr1yET5Z1mj3hevWZ8erT/Jlf
	RSIPtnFrl+XgsURCpbwwbLFJiShKProCofmTubIz3FAYcQfz4hfr++vqIcpV/i0R
	7nobzyQvAjk8TDz7b0nPyVuY/XS+6dseiUWWo+cPxlgpJeN0NkFbiJulYxNfITH6
	W/6O/k8ThbrjtXYKBEW//9k7XiYMjRkG4bqF+y92dcgDuQ0gt2hYi3cUNj1/Fh/Q
	vuQg2bxgvcVL0vHS8KB98OnV0ExtCXstqmiQ9XVXCw==
X-ME-Sender: <xms:aEYJZ47qEkGcR7qdMjp--aNV0UZG-GBfOcKJykFGpSxmciyF3nGz_w>
    <xme:aEYJZ56Op1pQihPqVfdKCEAlqDSmoahWFKhNMeykvI4om5CMICkL1YnCI_aFlTPW8
    fIuGuw3YZTSk0xokw>
X-ME-Received: <xmr:aEYJZ3cFgpg1Ar6b4FSiIqx4_dpL_j7jCrpEEfgXiwZFVbQfYkccnc9FkNNq3YVUol0-tAkaQHfzO94XVjtiTLoHIvp3jqQ-rSfSdBQnxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomheplfhushhtihhnucghvghishhsuceojhhushhtihhnsehjuhhsthhinhifvghish
    hsrdgtohhmqeenucggtffrrghtthgvrhhnpeehiefgffdvledvhedvtddugfeigeefleef
    udffveettdffueelheeuffejjeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrnh
    iirghnohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhitgdvfeeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvgdprhgtph
    htthhopehjuhhsthhinhesjhhushhtihhnfigvihhsshdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggv
    rhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hmsehmrghnjhgrrhhordhorhhg
X-ME-Proxy: <xmx:aEYJZ9Kp3ECm1en9mCVrM_mUqEuCXrzXiercx6g4jW_RdJrEuQScdQ>
    <xmx:aEYJZ8K-YsSNpQ6gINlQvY9RQhrYa3Mshve87HcyO2rrNzSs5udzHg>
    <xmx:aEYJZ-wgLO1iVervrtrbedv3Xwol0iPW6i6AIKQdqjLtwUKDVJIegQ>
    <xmx:aEYJZwKeixUbdd_A_5o3oaIQmvXRHDHnOQFtcMjnjFjbeh4-iV8ZCQ>
    <xmx:aUYJZ785qQ6Z6-XuaSRy3qv0rgWY4uQSqcjOwmoIrmPyrFkbBnddK7AM>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 11:38:15 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Justin Weiss <justin@justinweiss.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>
Subject: [PATCH 0/3] Add i2c driver for Bosch BMI260 IMU
Date: Fri, 11 Oct 2024 08:37:46 -0700
Message-ID: <20241011153751.65152-1-justin@justinweiss.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Bosch BMI260 IMU to the BMI270 device driver.

The BMI270 and BMI260 have nearly identical register maps, but have
different chip IDs and firmware.

The BMI260 is the IMU on a number of handheld PCs. Unfortunately,
these devices often misidentify it in ACPI as a BMI160 ("BMI0160," for
example), and it can only be correctly identified using the chip
ID. I've changed the driver to fail if the chip ID isn't recognized so
the firmware initialization data isn't sent to incompatible devices.

Also add triggered buffer and scale / sampling frequency attributes,
which the input tools commonly used on handheld PCs require to support
IMUs.

Like the BMI270, the BMI260 requires firmware to be provided.

Signed-off-by: Justin Weiss <justin@justinweiss.com>
---

Justin Weiss (3):
  iio: imu: Add i2c driver for bmi260 imu
  iio: imu: Add triggered buffer for Bosch BMI270 IMU
  iio: imu: Add scale and sampling frequency to BMI270 IMU

 drivers/iio/imu/bmi270/Kconfig       |   1 +
 drivers/iio/imu/bmi270/bmi270.h      |  24 +-
 drivers/iio/imu/bmi270/bmi270_core.c | 369 ++++++++++++++++++++++++++-
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  22 +-
 drivers/iio/imu/bmi270/bmi270_spi.c  |  11 +-
 5 files changed, 413 insertions(+), 14 deletions(-)


base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
-- 
2.47.0


