Return-Path: <linux-iio+bounces-14138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B49A0A5D3
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 21:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BEE1888D50
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515C71B87DD;
	Sat, 11 Jan 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evAEig2W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20621B6CEF;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736626270; cv=none; b=b+YDRy1+3wm/MJJMJRHyzDzupWqSNeIDm4Prxmr0xgCCIdpSJ984IVC8zj9t+tCrIjQ5zN1OZIxl+/zDy0BiTLr6iAGDdLyyI7Q1GhghLYkOAQ1T30X0d3l1Qij8dRtIKvPY3g4w3/9acVK49qbF9uwt3uQO00kTTVZXRMWRmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736626270; c=relaxed/simple;
	bh=t8rO8WUD6uhO20YWVe+sw/4QjdoLdy6VBKrhGozu+zQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mLHVxNmU6LwaPDjZTaW743LANxDt19E3/PlqlzSgABZLqArYWagGcMYOcLj+gsQhxv2C52gjGRzDON6sN2wXTQrSCflQCdXBrNfedJdVBqWmyHJ3gdPuXM9hIkOYlUkGsVEPvDuzrXREEa3C6u5g3V+P9FKmtF4EeKpVoYffgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evAEig2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F8C3C4CED2;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736626269;
	bh=t8rO8WUD6uhO20YWVe+sw/4QjdoLdy6VBKrhGozu+zQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=evAEig2WABXHhW7x40jo7tla+kl0bnSt3QZn7wB0fonv6WDx89HQK8W+o8OR9L4kJ
	 tkImizryCwygbdUm00zx4nYVL9dRcfbex+y5jDjFD3iWed2qcCpM9mX9yRLF0wxnPe
	 Cjk4LcjKi4gCRzHbQ5MDLIhvEFrIGXvSiOJqnBT8Hig6BU1/iB2RYFYmILRGLKlkii
	 syyqy34h+ZXMGUULggZOCqiw9i5gjqoeg9/acyRyOtzSSUz7rW69PtPjANUGNE5s7j
	 TV+8jBTGNkzm4YzDsqaUHYold3cdDOikY8sn6rpTPU2QPMPO+IR58ke0djhPVxzFU/
	 dElPgMezaHq0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74844E7719A;
	Sat, 11 Jan 2025 20:11:09 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Subject: [PATCH 0/4] iio: accel: mc3230: add mount matrix, of match and
 mc3510c support
Date: Sat, 11 Jan 2025 23:11:05 +0300
Message-Id: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnQgmcC/x3MQQqAIBBA0avErBMcy4quEi3MphqoKRQikO6et
 HyL/xNECkwR+iJBoJsjn5KBZQF+c7KS4jkbjDZWI6I6HMvOwrKqw1cWtVe2qVttlsnVXQs5vAI
 t/PzTYXzfDyS0haxkAAAA
X-Change-ID: 20250111-mainlining-mc3510c-564702fba487
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=836;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=t8rO8WUD6uhO20YWVe+sw/4QjdoLdy6VBKrhGozu+zQ=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbLkTb/1qydZrOWtN789QCfqot4Ta/sfgky/0711Iks
 0tETTUiOkpZGMS4GGTFFFlsNnrMFssPl5w07akCzBxWJpAhDFycAjAR/g+MDAedVfNX+j3V+neK
 6Zh72ka+GvvaCWIzf71T27pY6w2X+mmG/4Gz2bt4OezdXdzsmbs0dv+8Urv37SRt3TNGOYKpf1+
 XMwEA
X-Developer-Key: i=nekodevelopper@gmail.com; a=openpgp;
 fpr=3CB1489B166F57199296E520B7BE22D44474A582
X-Endpoint-Received: by B4 Relay for nekodevelopper@gmail.com/default with
 auth_id=314
X-Original-From: Vasiliy Doylov <nekodevelopper@gmail.com>
Reply-To: nekodevelopper@gmail.com

Changes includes:
- Add mount matrix handling
- Add match table to work with DT
- Add MC3510C support

MC3510C use same registors as MC3230, but different value scale.

Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
---
Vasiliy Doylov (4):
      iio: accel: mc3230: add mount matrix support
      iio: accel: mc3230: add OF match table
      iio: accel: mc3230: add mc3510c support
      dt-bindings: iio: accel: mc3230: document mc3510c

 .../devicetree/bindings/trivial-devices.yaml       |  2 +
 drivers/iio/accel/mc3230.c                         | 88 ++++++++++++++++++----
 2 files changed, 76 insertions(+), 14 deletions(-)
---
base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
change-id: 20250111-mainlining-mc3510c-564702fba487

Best regards,
-- 
Vasiliy Doylov <nekodevelopper@gmail.com>



