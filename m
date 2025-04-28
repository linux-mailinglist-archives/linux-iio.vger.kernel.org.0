Return-Path: <linux-iio+bounces-18768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 597CFA9EE59
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19BC7A9242
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9981262FC2;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvwPhd8h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2E25F780;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837434; cv=none; b=RKq+9qBTbTLh1x/bkho5Y5XZapBxQhrdNDhEFXwkZcHq4eMwhnSYCoQ58FgCvqOHwq+C9SHiro589D3YMPPhbnE0OBE0ZD8S8Ta0Tv8Rj4HIQqF6Z0LAtUXFCUTp/kf+xVN/3872vMN0NGnZwhmij4mgBdi1fbaBwUOLwzetifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837434; c=relaxed/simple;
	bh=bYzWEyx7wF1a4iH6jkzQs6rTKgOzlRhswyhO+IHRbag=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nD/Qisxhjs1kJvCdBR9l6ot5sFov8VQhIJ53qedvmUdjl2q2WULZ+Zgvym8h/551vc5GZl0Ut69K79hoDzk7CHpuARCKv1jw7kvgY0GG7fi4BAeCxTmFDKHcMYRJYmE8Ujiz9YeHS/4gjTXgPJeISY9/efPibXKaQ/KSAElw5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvwPhd8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F4BAC4CEE4;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745837434;
	bh=bYzWEyx7wF1a4iH6jkzQs6rTKgOzlRhswyhO+IHRbag=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RvwPhd8hJjp1sWfflu6gENQP4CYuMhK4ip59pK1MC03JIZyMVOUxL5nC2kkhzlOOZ
	 DkZzYNsaChWD9CsnElKoFuPLDjZEiTZ2JsyC8r3pMZAh69kLys3UPyT2u0ZVMVIhJ/
	 SMH5l/1Gt7eeckpAM6GnELrdc/8UCn64Rj8jvlUzT1lldUxjcAlMr0wzbdTqVTSFj7
	 JAlPx3rjHGgKVL3/rvql+Roq+hNSZDVxr5cXyCmyoCmc4c+oKRxdDLNScKNCDfhHu6
	 Q73ABg5SJmloa3cQa+gtlEwWngYcoyfADZYhlThSRDRJir/n9Gd/rMiRf6Tnbgce39
	 EtIyz4rQMtKiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15212C369D9;
	Mon, 28 Apr 2025 10:50:34 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Subject: [PATCH 0/2] Add support for the DFRobot SEN0322 oxygen sensor
Date: Mon, 28 Apr 2025 12:50:12 +0200
Message-Id: <20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGRdD2gC/x3MQQqAIBBA0avErBuwSSu6SrRIG2ugLBQiiO6et
 HyL/x9IHIUT9MUDkS9JcoSMqizArVNYGGXOBlJklKYORQ50K+/ipg0TB1UTofOdt9Zya3QDOT0
 je7n/7TC+7wfFS4LRZgAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745837432; l=803;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=bYzWEyx7wF1a4iH6jkzQs6rTKgOzlRhswyhO+IHRbag=;
 b=FX53BKRvsPXfLu9zX6oIbWxnJrO3cEa7YLggqBsOhEtfUwHaoMjdIw5SrfKzq3Iyj6hfpsfeF
 KpvfqlNujtWAihX3N9vNXNLBKI8rxrhFNNIPCIfJTOxZIw3LZ1C9F4N
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

This patchset adds a driver and the documentation for the
DFRobot SEN0322 oxygen sensor.

Signed-off-by: Tóth János <gomba007@gmail.com>
---
Tóth János (2):
      dt-bindings: iio: chemical: Document SEN0322
      iio: chemical: Add driver for SEN0322

 .../bindings/iio/chemical/dfrobot,sen0322.yaml     |  41 ++++
 MAINTAINERS                                        |   6 +
 drivers/iio/chemical/Kconfig                       |  10 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/sen0322.c                     | 238 +++++++++++++++++++++
 5 files changed, 296 insertions(+)
---
base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
change-id: 20250428-iio-chemical-sen0322-cf8fbbbe7546

Best regards,
-- 
Tóth János <gomba007@gmail.com>



