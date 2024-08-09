Return-Path: <linux-iio+bounces-8342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9BF94CD27
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 11:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 660B5B20511
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC537174EE7;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juJWN+3N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D318C93C
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195074; cv=none; b=njb5Zxc127WaW2x5sLj5fXSmvJy2LigTYw5kkw0PGOjXkoD4DdQD3IrK9vYt1GfxHFvQpQl6o4HSAnmCVoawZwIJRJaZt80rG5dzfCJ5Oka2MSSwS3B3EOlIok0RK6JNAYrvwU3UKmm+/PeOq6riY1Agr9urCN0q499cxJm2vO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195074; c=relaxed/simple;
	bh=nM1XhDBT2YBFAoOcyi44cvXhc/mFm7v09j5HLSuGW40=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WR2jL+7mXwV9FNxg5PYzwtjduLUq2sauV3mal95O603oTdYlSL61zT1Yb7188qSI0pFKfKyXBTMwlxshXWVRFNjeWAu+f3WLs2yqrYd1GLqcku6aRtLHvJfapkLnq5XhtmO/kQ3S+NH4vv9bntAlViztnTOcLZRXz7C7/vuqzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juJWN+3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 563CBC32782;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723195074;
	bh=nM1XhDBT2YBFAoOcyi44cvXhc/mFm7v09j5HLSuGW40=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=juJWN+3NkRni6cTJNZYA/nCDT3iXRIaeCb6fp1uJa8IX8zN7cSjt3qQdqswlT7rfZ
	 JbAOt1roWQykb30nmQDW/z2Y6/+B3dl6T9n6aWEFlp4d9BzO3VRZh3yEgZoA4yCZy7
	 vhHMZTM2I+iJurI502OahHR7WBMZWBkHRNYFQVP/rzYZjJ/IVoadRSEie6ITIw/+Su
	 FpMX+7bCK1XNGnlUa8Eynxnu9x0JkaI6PZHneuWipGElrrHOZjcxivOFlHXDhlkwaS
	 7TDfSDITFDxsDtexShrEdqRDN4B+OHqZKeelphDt6c7v88GCO39LvJRBbUFMv334pR
	 EFSPobErUlAbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A91C52D71;
	Fri,  9 Aug 2024 09:17:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/4] iio: imu: drop #ifdef around CONFIG_DEBUG_FS
Date: Fri, 09 Aug 2024 11:17:05 +0200
Message-Id: <20240809-dev-adis-debugfs-improv-v1-0-d3adb6996518@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJHetWYC/x2MSQqAMAwAvyI5G4jF/SviQW1ac3ChwSKIf7d4m
 znMPKAchBX67IHAUVSOPUmRZ7Cs0+4ZxSYHQ6akljq0HHGyognmyztF2c5wRGSipmq6uTK1gVS
 fgZ3c/3kY3/cDhkHfHmkAAAA=
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723195072; l=860;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=nM1XhDBT2YBFAoOcyi44cvXhc/mFm7v09j5HLSuGW40=;
 b=JxszYtrjNT5amQMOEQmdVDKK7txdVB8/CHbVp5fbpXQ6c9Us9aCBjN+JDSAi+e633buajXk98
 5nqkgqx+pdYA1YxMcwieAJC4PZyCRRSM2RUfolJ5p5ia1vvlY3MtE98
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi,

Small series to make the IMUs debugfs code a bit neater. As mentioned in
the commit message, let's allow the compiler to drop any unused instead
of guarding it with #ifdefs.

---
Nuno Sa (4):
      iio: imu: adis16475: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16480: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16400: drop ifdef around CONFIG_DEBUG_FS
      iio: imu: adis16460: drop ifdef around CONFIG_DEBUG_FS

 drivers/iio/imu/adis16400.c | 18 ++++--------------
 drivers/iio/imu/adis16460.c | 18 ++++--------------
 drivers/iio/imu/adis16475.c |  9 +++------
 drivers/iio/imu/adis16480.c | 18 ++++--------------
 4 files changed, 15 insertions(+), 48 deletions(-)
---
base-commit: 7cad163c39cb642ed587d3eeb37a5637ee02740f
change-id: 20240809-dev-adis-debugfs-improv-e007579b5262
--

Thanks!
- Nuno Sá



