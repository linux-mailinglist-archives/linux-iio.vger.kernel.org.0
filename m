Return-Path: <linux-iio+bounces-10017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3A998EA7F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 09:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4E82854F3
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142512CDBA;
	Thu,  3 Oct 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUcZIKmD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C053363;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941075; cv=none; b=REVCckcFt+zvC8IHHl/pZPBUhKFAIPygvMPhYZGG0Cyms6WgoyB05AXVKm3jQosYWoPBGGAdFuMPgIDLJVZmuN4KfsDjs3VKyyXcIDWh68/DLaM81Iepi3Fvm/zIOPhsz8h1Ndq5uNqewEySdy75dg0BttO3YLjEkKRLYv8hN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941075; c=relaxed/simple;
	bh=kZh0SRdfxAr2VKYXWGtlFIDhd3Qqw+b7Z9aotoWwKmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SiLkMj+h8l5AoFO0rY/hd9pYekjOiX7+2KkxAoIRYwykbYV6thmaoPAdWCEvGa1AvQjjBLRahYto48rWyQyUzc6CNc4MaRtaF9+Pha8KT3HsSmU4Wea1qDnX28S/5ty2iKd9fMqHMOqABuKLKVxdCNJ2d4gzX0J5U0Xaij8h6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUcZIKmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8A9FC4CEC7;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727941074;
	bh=kZh0SRdfxAr2VKYXWGtlFIDhd3Qqw+b7Z9aotoWwKmc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WUcZIKmDeDCRM5RoSGDOD6ADmuM12U6tlRozJtPa21UvC+UIP8rP39OLnvO7JcwzF
	 Vq72p0p2/eWDHmYBXvUH6BT+3pAEKAcBlCIohftTpVHa0wK0bnLQPICtOxumWoRPSu
	 43S5HeizmlpDmhYR5/Xka9yMEtq1q5pp565Vz+EFIWC3WQ3Exdev3469CY6o3hcFVN
	 ++8EhxwOh9R0Zq4FtnrbSACWw1E6SGFTdG6oYP6IVfXtswEe6LYI9WxcvrdZeGaRho
	 0jYcwHUEY74Aazxh1WDtvetI7nUQLbPW2hxsc582r0ReGy8ubDNMOZ8c6nqZuF7NHe
	 cgUVTnJJL+IYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B02CF31A2;
	Thu,  3 Oct 2024 07:37:54 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH 0/3] Update email addresses and add missing MAINTAINERS
 entry
Date: Thu, 03 Oct 2024 09:37:44 +0200
Message-Id: <20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhJ/mYC/x3MQQqDMBBG4avIrB3QGCh6leIijb92QKeS2FAQ7
 97BxVt8m3dSRhJkGqqTEopk+aihrSuK76ALWCYzucb5pncdixblLYgeFlJmGFb+7lM4wCG6Vxc
 fHn5uyR57wiy/+/8cr+sPJy34xm8AAAA=
X-Change-ID: 20240923-invn-maintainers-email-update-ac2b3c74e4f1
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727941073; l=907;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=kZh0SRdfxAr2VKYXWGtlFIDhd3Qqw+b7Z9aotoWwKmc=;
 b=K7GuIhgN7YfUjiIW3DJnziiuO2nmJwyKGioZf7wJ4GrMwPXHSDy8t1G1W7T0VmZJ7s2e8mozE
 MZxn+m6a8HEBBy0/rEwPv9pTsQ+NSYYjf78NR1afnJ0A1o8/WJUkok6
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

Migrate invensense email addresses to TDK domain. Add missing entry
for iio inv_mpu6050 driver.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
Jean-Baptiste Maneyrol (3):
      MAINTAINERS: iio: migrate invensense email address to tdk domain
      dt-bindings: iio: imu: migrate InvenSense email to TDK group domain
      MAINAINERS: iio: imu: add entry for InvenSense MPU-6050 driver

 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml       |  2 +-
 .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml        |  2 +-
 MAINTAINERS                                                    | 10 +++++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: 550aaa170cd9176655382364308d2ff54623b30b
change-id: 20240923-invn-maintainers-email-update-ac2b3c74e4f1

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



