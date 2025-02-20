Return-Path: <linux-iio+bounces-15895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A93A3E61A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 21:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229A6421C30
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C052641C4;
	Thu, 20 Feb 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d20dvHb2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0C85C5E;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084733; cv=none; b=F/vF65F693VfZzpjGXm9gz0093A6eCvNzB2epqGEHbJ0QD5GmwlSDAVJX+r1RIY7HzysTAsviS+TnFO3UoFy1EQXzzRnCa7F6BX81xM0XnOtpRKkgVQ5DDrLO7eQ3b0PcG1F25MYhho1v/VSs+ZpBIu0/8HQAuvSe1iZwejMY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084733; c=relaxed/simple;
	bh=5IZYGAvISNec6ODnHDxlFeQmX0TyNdXxPLzJQ8d2UkY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CjUp1AKv4rMqpbq9U/E4C4u6BFba8Ln9PxZwIMBNsHmt8pC6KaFnKxXobwpXosPBagKzNpVTmXhZiuCsYkHy216Nom24co6gG7LAOmy0T8ElPGnhH3G596MOLeQJgxQR+csAY3AgcsMdBZJdEYOCJLhImfc2vvXwpjVT2RsCJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d20dvHb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2460EC4CED1;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740084733;
	bh=5IZYGAvISNec6ODnHDxlFeQmX0TyNdXxPLzJQ8d2UkY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d20dvHb24rymrtrb/OGhq6E5OjRAQLYvfYqPQ2IILSHfOO5xW41GdFDsOMeUR2lka
	 GeUiumF4ahPsfO47/aGRqV/JI8IVKy7xgJOWmZIiRiUsORy/kZ0DlDNXac5s+fdzaO
	 y8Y0rEk9FR5Xte3v0Idi+kOCU99XFKzET0Qz1PFHkiD5QMvl69fgxTf7N2GW3+TLCL
	 3T4NccFHyy2833S5w2ROw6KqGa4cKM4bAqrRo3EV+pb8Bzhb0j67jrnOOTYaEQOQk2
	 96d5aEEcKBMsgHnXievWtJyqpAKEMht2USN0QDP9NMHb+dpGt8CGde1HgcncTEfNVD
	 NP+asryEqvnkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05639C021B2;
	Thu, 20 Feb 2025 20:52:13 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH 0/2] Add support for WoM (Wake-on-Motion) feature
Date: Thu, 20 Feb 2025 21:52:05 +0100
Message-Id: <20250220-losd-3-inv-icm42600-add-wom-support-v1-0-9b937f986954@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPWVt2cC/x3NQQrCQAxA0auUrA3EVAt6FXFRm4wNtDPDRGuh9
 O4dXL7N/xu4FlOHe7NB0cXcUqw4nxoYxj6+FU2qgYmvxEw4JRds0eKCNswX7oiwF8FfmtG/Oaf
 yQeqYgoabvLiFWspFg63/y+O57wfxvdgRdQAAAA==
X-Change-ID: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740084731; l=1287;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=5IZYGAvISNec6ODnHDxlFeQmX0TyNdXxPLzJQ8d2UkY=;
 b=zsq5ZXe7IAk9rkJgMfcmnCVKRGLV6umI9+L708Hwc+Tc4B+y47mJA50KuBbjP6Yk9VZ48SWW+
 TGccw6K36AGAaxPCtbUYCGfQd71VGEudpShLkPs9IpLHJbjOB19Vfl1
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

Similar to feature present in older chip, it compares the magnitude of
the last 2 accel samples against a threshold and returns an interrupt
even if the value is higher.

WoM maps best to accel x|y|z ROC event. This series add system wakeup
functionality if WoM is on and wakeup is enabled when system suspends.

This series also prepare the driver for supporting further APEX
features like pedometer, tilt, ... It introduces an apex structure that
will hold all APEX settings and track the enable state.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Jean-Baptiste Maneyrol (2):
      iio: imu: inv_icm42600: add WoM support
      iio: imu: inv_icm42600: add wakeup functionality for Wake-on-Motion

 drivers/iio/imu/inv_icm42600/inv_icm42600.h        |  49 +++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 267 ++++++++++++++++++++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c |   2 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 125 ++++++++--
 4 files changed, 416 insertions(+), 27 deletions(-)
---
base-commit: c0f115a8d97599623294c8e9ec28530e19c1e85b
change-id: 20250220-losd-3-inv-icm42600-add-wom-support-0620fef9db23

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



