Return-Path: <linux-iio+bounces-17615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E173DA7C0F3
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B923BB12D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886721F582A;
	Fri,  4 Apr 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWM0w+9n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E491282EB;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781930; cv=none; b=o23HYfD1R1gxk+AtqGcysZ0ZxzzPxk7Lt0iNgOlhnG0MCXLAX23I0zZ60+unLqEC1vuVn2KaWplzrsasRtThocULc2fwgZPJ3ScprsnkzJMsRKlHVctfROLg/m7jgkVaETSXbcMaM/ISAWAziISeYTmYpL8g4nM2UPyG0G+/AbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781930; c=relaxed/simple;
	bh=g4Iysgwpe8lGdu8CwXjRXHZRqni06iQGyaV8tJgj1mw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nanykjT1LHqT5bXKEIZNLB/jW17ojfjO9iU3mpv/FNtUI9PSn69NzCkBvAo7cmK7EzJzqprQDJcvjyXY+WW8cx1UMlrtzMKR4t2Pu/1NMdKcnmwRYrRlvlc6XmqBSNdc/yR4yv1iRcBKI5Tm8xd73tpi52UV6/09k7fVBR5kvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWM0w+9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A26CEC4CEDD;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743781929;
	bh=g4Iysgwpe8lGdu8CwXjRXHZRqni06iQGyaV8tJgj1mw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IWM0w+9n1mJzwuTylNJzmBUUiLekMIoCRiVa4GNEeexutWetJISjSaElQqzRMPXj/
	 q0vUUWYR++aIX5QQPmFNllRtv3YrU9bs6q9L1F6eEuf9IHTGchcSolmrceb+jAtP2R
	 XD15ALHk7cSrnlxZIeQV83DNrH3tUZeDkvn/UNQh7Kf9YwLMgHLxNAucpiE0fQTnNw
	 tTrDVtoLQRdX40tq+Np3iHF9F1yGDUvQX1mFsZnZ3yQJpjhpPO/ve53pG09jF1WMcA
	 pu/1AOFxohcdaQyVwjtFaaLP4QQS6wKe4d95HVAabPlfZZE5X6II5iip2/0lKjgUjA
	 XLkZbjBNUeH1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBECC36010;
	Fri,  4 Apr 2025 15:52:09 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH 0/2] iio: imu: inv_icm42600: switch to use generic name irq
 get
Date: Fri, 04 Apr 2025 17:52:01 +0200
Message-Id: <20250404-iio-imu-inv-icm42600-rework-interrupt-using-names-v1-0-72ed5100da14@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIA8GcC/x2NwQ6CMBAFf4Xs2U1qK6L+CvGAZcUX05ZsKZoQ/
 t3G48xhZqMsCsl0azZSWZGRYoXjoSH/GuIkjLEyWWNb42zLQGKEwogrw4eTPRvDKp+k7+oWUS3
 zwiUjThyHIJkf7tp5GTt7cS3V7qzyxPf/7O/7/gOFo0kXgwAAAA==
X-Change-ID: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743781928; l=1064;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=g4Iysgwpe8lGdu8CwXjRXHZRqni06iQGyaV8tJgj1mw=;
 b=TIiNFxaOUvvI94XEv0fEIFpl7os48WSsLvDqHC/Y90wC0sNKrGzsJaKW8hxSY8oFarfIY5Xfo
 rAQy4lJtgEQASAfcS6FPC21sCgXoPcukzntnHP5rYY9dO9NdD6t50CO
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

The purpose of this series is to switch to fwnode_irq_get_by_name()
in the core module instead of using irq from the bus parsing.
Add interrupt naming and support only INT1.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Jean-Baptiste Maneyrol (2):
      dt-bindings: iio: imu: icm42600: add interrupt naming support
      iio: imu: inv_icm42600: switch to use generic name irq get

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml    |  8 ++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600.h                 |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c            | 13 +++++++++++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c             |  2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c             |  2 +-
 5 files changed, 22 insertions(+), 5 deletions(-)
---
base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
change-id: 20250325-iio-imu-inv-icm42600-rework-interrupt-using-names-b397ced72835

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



