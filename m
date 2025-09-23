Return-Path: <linux-iio+bounces-24366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12790B950A7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067AA44474D
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F292431DD97;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC/jOYqr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0E31DD88
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616888; cv=none; b=RmJO2Fh3XS1cGjouChZedW9PeNTEE6EZKJGkLaQ6wNdPtr2SGQgLe01AjoI67OkXYGylRDcironkEu338dkz1g0ZhqpGSjdNHldrUHpy17uykN1AwcTY1pZEEy2k7i4Hpbi/dk8k8yqTYTnZfI4cJ1uaJ900Py4/41p9mtJLCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616888; c=relaxed/simple;
	bh=sl+i70X/edd/QDfpVdgYIN8i9Z9A4Daw02aKDix/xYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HjlCJH23MJitXo/g99enouB+zculpb3Pd2OqyL6O5M5ceRhu7+nzzDB0Duc7k7ufkyFxKRdXZM/85yrmwq8usDfjdareZyWwjt44rbK7gMYMq99Z96TeD90BDtDrAe8kXTmXWfNWqDpibp1WFTKNHDEzxExabUE2f07HV7QLm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC/jOYqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A3DBC4CEF5;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758616888;
	bh=sl+i70X/edd/QDfpVdgYIN8i9Z9A4Daw02aKDix/xYs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=AC/jOYqrBuCJB9+o2D2UH9tL/tTWGUoYlusjICScEPERDJaDR76UOgxIjq/RjzBX7
	 P89m1QRjx9X1Z5B3LSuphJ/WbY4mv0qiRgEUCSRRiGgYJ/XtFrc5natruUfNjQp60P
	 5Vu5z2GLM2bskehvbmhlXPespFCRzhXzIFK+gZvf0+M5CPgm3lh/PNYXDXA1MqEce3
	 cHDAqduVPYk4i+LgDubjt30DOr1GGbxZvEbcMG2ZRPDpSmAUQdw5mnDJL9vPCM+aW6
	 Au/X0OD9/gFAO9PhW8/yRwsXksvr9AR3Ahd+f3X4Di0yylSWZcKqRZo0iXayY7nvzr
	 sUiqQWYBcTCEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41726CAC5B0;
	Tue, 23 Sep 2025 08:41:28 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] iio: dac: ltc2688: minor cleanups
Date: Tue, 23 Sep 2025 09:41:46 +0100
Message-Id: <20250923-dev-ltc2688-minor-v1-0-ef92c441dc42@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEpd0mgC/x3MQQqAIBBA0avIrBswI9GuEi0spxooCw0JorsnL
 d/i/wcSRaYEnXggUubERyioKwHT6sJCyL4YlFSttKpBTxm3a1LaGNw5HBGl04Zsq0dpDZTujDT
 z/T/74X0/UaN5KmMAAAA=
X-Change-ID: 20250923-dev-ltc2688-minor-0a68e956b098
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758616915; l=441;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=sl+i70X/edd/QDfpVdgYIN8i9Z9A4Daw02aKDix/xYs=;
 b=1faBrWwOjhbFNRihR+Fe5vHDqcTkEw78zzZiyhOQgBkmZx2hBTGGGLvKKU8/B9URc+qzr0mkd
 UkConcoKYsMDBA3Bb5BHJilHEnkmk5GU7UVj0gqfSss9qdCeKoQgcMr
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Simple series to improve locking and mutex initialization.

---
Nuno Sá (2):
      iio: dac: ltc2688: make use of devm_mutex_init()
      iio: dac: ltc2688: use the auto lock API

 drivers/iio/dac/ltc2688.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)
---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250923-dev-ltc2688-minor-0a68e956b098
--

Thanks!
- Nuno Sá



