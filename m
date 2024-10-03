Return-Path: <linux-iio+bounces-10042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF298F092
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 15:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEE328584A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C026C19CC3D;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuYBaakZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1B199386;
	Thu,  3 Oct 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962713; cv=none; b=a7SLT5DUw5448UrvuaC1WkrL2i4zWwN0Sb2PqcRetTIngmfFf3zCR2nfFfDg5GTB2EDoPF9JnVKqlgT70bOzbnmF8O5pdszI5aX43pNyqqYw/YBh+LYQXdXnISgdbEv13fiyJwNdViZD8CAxAO1vYquMhXZyy7gt41tmNLpA1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962713; c=relaxed/simple;
	bh=lxAM7uyaZBdyhQpXywYiWYh63qBKG5pCaT3tPPxElkA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Skxnx1DmgyYbWossE1bHwnaXFAB/DGtgI0K51bxl7ufehLxlkozbk6BZdHV2f7UQUQF1HmC5iP6s6NjscsgFKDlSKCBuvoITE9vbg59jegPvUOWWDcavoxh9SOwSnc1Nkzq6QW/PUWFNgCOP0TN2Exsxq9kLXrkoVSA2RwqvV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuYBaakZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 016EBC4CEC5;
	Thu,  3 Oct 2024 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962713;
	bh=lxAM7uyaZBdyhQpXywYiWYh63qBKG5pCaT3tPPxElkA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WuYBaakZXAH3KFYZ3/rW+OVLD/J3I9cpdcMGUdX6e/oYtD1Tz0NcieYhIMY+w5h5u
	 rUWnnpRw2kjWa1BL/tZvTs9D0hjHGJao92TAcGgIh3PQjmR0nE/EBUTdyxCA1fP7FF
	 XKsdYfobmaVPc/Eml9kU/xEzUvDGR+9L1FraNJ3GbJMjG3kZe12JeioFeHZs3bguS0
	 G+lT2IdaS3g9lo/UBROsEUWFdQWntcu6aC/O0YAiQNjTE/Za+jta4SamB5JwEX6Ufb
	 58gXk/lpYdMXOneWL4CbNZoCy2ll2XoXrK9UyONHXAo7qoiN+t0m0lkbrhLRKEk6ze
	 7WFJyJBQhfsQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1D5CF34AE;
	Thu,  3 Oct 2024 13:38:32 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Subject: [PATCH v2 0/3] Update email addresses and add missing MAINTAINERS
 entry
Date: Thu, 03 Oct 2024 15:38:21 +0200
Message-Id: <20241003-invn-maintainers-email-update-v2-0-ca5a4928eb22@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2e/mYC/4XNQQ6CMBCF4auQWTumLQ2oK+5hWNR2kIlSSFsbD
 eHuVi7gYhb/LL63QqTAFOFSrRAoc+TZl1CHCuxo/J2QXWlQQmlxVjWyzx4nwz6VoxCRSjzxtTi
 TCI1Vt9q2mvQgoRhLoIHfu3/tS48c0xw++1yWv+8uSyH+yVmiwJa0aJRxzckOXXKPo50n6Ldt+
 wLNRnPByAAAAA==
X-Change-ID: 20240923-invn-maintainers-email-update-ac2b3c74e4f1
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727962711; l=1063;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=lxAM7uyaZBdyhQpXywYiWYh63qBKG5pCaT3tPPxElkA=;
 b=Olhb3bULxIHPQl7WLsmehq+6FZgl/kzmzYgn4uCvXdBuyeijlTIqdrKTKSiFobJ+AMpUzvKb+
 0SFG7Rd0skSBLv0PQhRDUdrU8Xc9nyITTtHc2q/1unBWqTXecCFxJub
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
Changes in v2:
- Fix missing signed-off
- Link to v1: https://lore.kernel.org/r/20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com

---
Jean-Baptiste Maneyrol (3):
      MAINTAINERS: iio: migrate invensense email address to tdk domain
      dt-bindings: iio: imu: migrate InvenSense email to TDK group domain
      MAINTAINERS: iio: imu: add entry for InvenSense MPU-6050 driver

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



