Return-Path: <linux-iio+bounces-23891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED0B4A315
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC031792CE
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD6306D4D;
	Tue,  9 Sep 2025 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="A3nNHWXo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175113064A8;
	Tue,  9 Sep 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401895; cv=none; b=Cvup72FMu3lFZSzi7fFsBAHroumESs2lesB0kN97qyd66eDSrqQS9a6rO/e3Hl4nuFmVEHel5w9sAZvyeTMSJy/HditZ+aCH4j5UEjEC0PfZQr5ZATSQ159+Fzo94kmge4ik5CdqAmNMs4duLmOjCr0v5VFLhJU/IkU39tsi3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401895; c=relaxed/simple;
	bh=OX+8nctLubxm85gtheRJLeHFla34FZZyCJ8GRdbIEug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gk9Q4icCnHgVy6qiHv6qw0Owrk6If3bmuLmNjaveA7Nu++aV1DD+w1w/iL9cIRnYEmV7Z2Nb/H5qgWXWH0eQfDdbIuMk59w0fsYElvH6l/RydFIit27e8QPhZxKqpnmeA4Vk7zyodGG5+1uXEgbh7E8QTbmoI3qprx5pTeqEVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=A3nNHWXo; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1757401885; x=1757661085;
	bh=k3RFqLUt7EBVe7ElX+OXbwZrnbLLAyRZG+pz1IndmLY=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=A3nNHWXovN5o2Z8zSAKqJsGCKxV4m3Ul6CeJ+yTH+qjrJxkflfr3hjOvJjqph/Owa
	 0Z+BVqRS34v2XY/+MDl0fSg0d1KIi4OfcliHXkNPjeFzOBTf4ObSRGcnxHxEcp2l/g
	 PVpn6T6dYCZpJ7jEpgwXbS5tIDYR7rAb1dQdufGSG0fVLxJppCPYjPIdPTXq5JzPHd
	 tuyc7usTY6ehXj07zziP12Nqd2EHDRBTWvwNL6m5D5wgsNDQuwv6yK2Tkm7lEywtYF
	 jOEN5xvW0mN3VWw1opV8KlENrqGVjrjlFnfX3+LjsldorJFvdFtze7rJPd5cZY77Fl
	 +jijG98iIuoyw==
X-Pm-Submission-Id: 4cLZk36ZP8z1DDs1
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v4 0/5] iio: imu: inv_icm42600: pm_runtime fixes + various
 changes
Date: Tue, 09 Sep 2025 09:11:06 +0200
Message-Id: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAArTv2gC/2XOTQ6DIBCG4asY1qWBgQrTVe/RdGFxVBb+BBtiY
 7x70aSxpgsW3yTPG2Y2UvA0sms2s0DRj77v0tCnjLmm6GrivkybgYCLMMJy71oNQxuo5qBLmx4
 a6zRLYAhU+WmL3R9pN3589eG9taNcr98M/mai5IKrUpBB5RCfcKup6Px0dn3L1k6E3drjFyIkW
 2grwCAZA/LPqt2ikAerkqVKKpWDzjEXB7ssyweKljpDHQEAAA==
X-Change-ID: 20250708-icm42pmreg-24d824d978c4
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

This series was triggered by "Runtime PM usage count underflow!" when
unloading the module(s).
By testing the driver in various use cases and reading code it was
obvious that it could need some tiding up.

@Rafael:
Is checking pm_runtime_status_suspended() is a viable option?
To avoid calling regulator_disable 2x during remove()?

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v4:
- Corrected review comments from David in PATCH 5/5
- Link to v3: https://lore.kernel.org/r/20250901-icm42pmreg-v3-0-ef1336246960@geanix.com

Changes in v3:
- Return early if pm_runtime_status_suspended() is set.
- Fixed various comments from Andy in "use guard() to release mutexes" 
- Link to v2: https://lore.kernel.org/r/20250808-icm42pmreg-v2-0-a480279e7721@geanix.com

Changes in v2:
- Removed patch iio: imu: inv_icm42600: Use inv_icm42600_disable_vddio_reg()
- Moved changes from patch iio: imu: inv_icm42600: Remove redundant
  error msg on regulator_disable() into iio: imu: inv_icm42600: Simplify
  pm_runtime setup.
- Move associated sleep close to enabling of vdd
- Pass regulator as the parameter to inv_icm42600_disable_vddio_reg()
- Use devm_pm_runtime_set_active_enabled() to simplify even more
- Added a new commit that uses guard() to release mutexes
- Link to v1: https://lore.kernel.org/r/20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com

---
Sean Nyekjaer (5):
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended
      iio: imu: inv_icm42600: Use devm_regulator_get_enable() for vdd regulator
      iio: imu: inv_icm42600: use guard() to release mutexes

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  24 ++---
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |  41 ++++----
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 117 +++++++--------------
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  24 ++---
 5 files changed, 70 insertions(+), 137 deletions(-)
---
base-commit: dfbbee0907fb30a1dd31ff1a84e1bd34bd824369
change-id: 20250708-icm42pmreg-24d824d978c4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


