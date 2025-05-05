Return-Path: <linux-iio+bounces-19078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A94AA8D78
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 09:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D6B3A997D
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1B1DF733;
	Mon,  5 May 2025 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXMaXPJz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CA01C861D;
	Mon,  5 May 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431588; cv=none; b=oVy35bUuFzM2rVQM16ylj389tBrdI1QhZyrtQ+lD9ZcDtRTQkcZQmKIMhbJwNRcyQmpJMlH6e7lyKiMqnULuFlUTw6vJFfqEgSquVAKeS+pOTByGah1Ejy1u4+u3lb/2WRn2ut6Wi5PwWAtWBxawMzDO1i6jrkFImUdubTVMmCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431588; c=relaxed/simple;
	bh=HoVwgT0i6eQ5F0/UMVrAUgnAI8MgPO+NzAAD51dIqnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S93j33cSaZ5wJCHXueEiPnMHkGkJrS3wqLOMuM03ZciXuLg/VssJa/rueaF70XEp5HUaEG0iDXCi3fhldTMdWruoM7yfTtRafSqkrgYAQ54qWrhDkNir+xd1bZ3/3kXaTkz9Jn1aWgiLw6om/DWMLsu/83golZCclzbSXn/KNDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXMaXPJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E60FC4CEE9;
	Mon,  5 May 2025 07:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746431587;
	bh=HoVwgT0i6eQ5F0/UMVrAUgnAI8MgPO+NzAAD51dIqnU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=WXMaXPJz25YYfeytdlV9ehWiLJg/fsbp4CPlYZGBOh9F3vIO1IciY9NkBbJKlS1VD
	 lgRIyklbKfLAwdL0bzWWziqJcRteRZhS+LKVqgvEI55/jYBppQD8Z0LICnOiCQf46w
	 k7Z1hz9RUGKEj00VwC2rTbulxmIZDep74stPQ8cr0Bq1BzqGNyNFn7N12/9FJjNZdY
	 0yZDC8EGULw51bKKZ8u2fvmK53Jy9a1e3v709647BStBFKQzl7OPAPWJIrwAiHMoUN
	 2fqOEaavsKydPz9UphLUFVlSch+w9P0tktZFuWdFyQoNXjRg9wpj2And2FWww5SUsB
	 cAQWnXkgem5Iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C6C3ABB0;
	Mon,  5 May 2025 07:53:07 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] Add support for the DFRobot SEN0322 oxygen sensor
Date: Mon, 05 May 2025 09:52:57 +0200
Message-Id: <20250505-iio-chemical-sen0322-v2-0-217473983b42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFluGGgC/4WNTQ6CMBBGr0Jm7Zh2+BFdeQ/DgtYpTAItaQ3RE
 O5u5QIu30u+922QOAonuBUbRF4lSfAZ6FSAHXs/MMozM5CiWlXUokhAO/Istp8wsVclEVrXOmM
 MX+qqgTxdIjt5H9lHl3mU9Arxc7ys+mf/BFeNCq9Gt2VTOscV3Ye5l+lswwzdvu9fIFMUBbgAA
 AA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746431586; l=1057;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=HoVwgT0i6eQ5F0/UMVrAUgnAI8MgPO+NzAAD51dIqnU=;
 b=XO542HNnKgid7hj9NoQ+7o+FzzeC5MmDo6ymU7S/zh5narQlm6FOtiUtWlvP7SwqEbdGKljGa
 giu/oVLF0aDDmfU3ACwuNKlTSBu2+/vmVthiVtgXhDk6IVour77yTg5
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
Changes in v2:
- Add SEN0322 to trivial-devices.
- Use _RAW and _SCALE instead of fixed-point math.
- Refactor based on reviewer's suggestions.
- Link to v1: https://lore.kernel.org/r/20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com

---
Tóth János (2):
      dt-bindings: trivial-devices: Document SEN0322
      iio: chemical: Add driver for SEN0322

 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 MAINTAINERS                                        |   6 +
 drivers/iio/chemical/Kconfig                       |  10 ++
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/sen0322.c                     | 167 +++++++++++++++++++++
 5 files changed, 186 insertions(+)
---
base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
change-id: 20250428-iio-chemical-sen0322-cf8fbbbe7546

Best regards,
-- 
Tóth János <gomba007@gmail.com>



