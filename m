Return-Path: <linux-iio+bounces-8275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BEC9491A4
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A258C1C234CB
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC2C1D2F75;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8tDtya9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FF1D2782
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951307; cv=none; b=crKg35BNhhygA3/wJVkSdgEj5Myp34w4tnZR+ZAu4bS6RnMxDNo0zspbRfoeZa2P1dsIim92o/OzLmhjapvdtjJFkCGErAo/VRzDBhisv/FuGap6X+DC1r3RkTJ9t1ghFwULS8xllbL1+b6EZ04LOUD8Xemit9yGihAQwGqMOS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951307; c=relaxed/simple;
	bh=1hhfQ+rPODIJTgb/WtLEuPJO6Ig3OVI+VHjhVBlk+lo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C3BQCAvCn06nB2iNh2VR0fA28z+BRjfGmOU4J+kS0Q8flOm4TubQI/KVyu4jk9DSs5bg0+4KWcZdxGTQQtQnC4rIX1NbInhf1pFp5JKpZ2XK7b1IlEQh0B1fPxvE8NCYmOdBKvtsULF9nl6EL8TFl3TOoPfX89YBBLG2XM6hitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8tDtya9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 392F8C4AF0C;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951307;
	bh=1hhfQ+rPODIJTgb/WtLEuPJO6Ig3OVI+VHjhVBlk+lo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Q8tDtya9vE9+Xm0EMz5sT0nw8EqQG+kgQL5jw1syEZcaRT40ubngGPfF90PjEFsRf
	 o/qN1jCQlRESnJI/sxerveC2q0tGwiuSVwbDmiz99jg3uhZ0byTJYE9gTKQb7mEet5
	 xn8+wu2tjuEyGsxGsjRsfA0L/hY0pc5G7WGhrb9kZzYqUz4XICVNKI3+6FqPdPWw9Y
	 GJtgIhEIFcvNC/+W/qilcd+bY9xl/zCOp4VYywJNZhls/eQlnDOyM7JNPeblbfQNwP
	 9K95bgJodl/WxNcIf4obh7gpG3KYivut8jcZye5oiNj/pN6GVUcjLg6pR5xinsp83o
	 NKnGn2PrG3wpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C610C49EA1;
	Tue,  6 Aug 2024 13:35:07 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] iio: dac: add backend debugfs direct_reg_access
Date: Tue, 06 Aug 2024 15:35:05 +0200
Message-Id: <20240806-dev-backend-dac-direct-reg-access-v1-0-b84a6e8ee8a0@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIkmsmYC/x3NQQrCQAxG4auUrA2M01LUq4iLMflbgzBKIqVQe
 neHLr/NexsF3BB06zZyLBb2qQ3nU0fyKnUGmzZTTnlIlzSyYuFnkTeqshZhNYf82DFzEUEEp37
 Kek39WJCpdb6OydbjcX/s+x8OWFCgcwAAAA==
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722951306; l=614;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1hhfQ+rPODIJTgb/WtLEuPJO6Ig3OVI+VHjhVBlk+lo=;
 b=DqUtGStWqNt0UrPF91SeiPaN5ZpHmk1EBnU/9GFU1xHmWVukQomBgBnlQTK0+sXNNrw9Et94h
 pp0Ee/EdkqWCy4z+EzFnSDTokgomh22T7kxSVMKQBD79kVEme7M5ODK
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Implement the direct_reg_access callback in the axi-dac backend driver.
On the ad9739a frontend, call iio_backend_debugfs_add() to add the
backend debugfs interface.

---
Nuno Sa (2):
      iio: dac: adi-axi-dac: support debugfs direct_reg_access
      iio: dac: ad9739a: add backend debugfs interface

 drivers/iio/dac/ad9739a.c     |  8 +++++++-
 drivers/iio/dac/adi-axi-dac.c | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
---
base-commit: 593737c18ae789dc6e4b493510a0c00977972e2e
change-id: 20240806-dev-backend-dac-direct-reg-access-03f2d9036ae2
--

Thanks!
- Nuno Sá



