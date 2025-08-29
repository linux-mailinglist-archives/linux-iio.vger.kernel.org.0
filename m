Return-Path: <linux-iio+bounces-23364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5156B3B9E8
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4A31893B0A
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D2313544;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueoDCQFX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B830FF2B
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466721; cv=none; b=Xv0SkL4maLcPXlGY2ajPaT6qGB4v+HIn3jHLIxGvSmU34SGbFVsZEawbjwkgHjpODzvvrDq5vk6GdkgChXIjSXxZLADcnIOXcsq5U/nbcl2a4qau7j4MSTx3/rx/OByZH/LOVv7MsP9sinb8Fm2nLp7lTlH9/6S/iXWbI3G5wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466721; c=relaxed/simple;
	bh=I9x5+JZP4lWupBgVDkivsnIqhBa0ffZvWtaGaAn8KY4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VISDBMRtAXhqtr1GlDNwvGIYxM6EWBI+W3WWfjtybvWUJVlHFsCNYYStD+quMvQyRuul12rtrsPHnMxubqg0gwUBtpXOo43OHtQ2byU0goO7/csG+ojI69FCrB3tDYJz1RT/rVC35OkFEzvavQQoeRu/JfjFhNPUC8CXHjn3R0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueoDCQFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F654C4CEF0;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756466721;
	bh=I9x5+JZP4lWupBgVDkivsnIqhBa0ffZvWtaGaAn8KY4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ueoDCQFXA88xJ+CaSdoxq6wiUyPSu6ZZFIGyl08h0JbbNY2vjuvaX1SZqI6NNi2sm
	 WIHC0cI8QoT0hyLA/wmqpH5phrLJnFzpcfPGIh9OjdyLkf+OnQwSt+z3M8PdYj1tsE
	 IzsUO0ESMNJgJx2H839uCSKm16bTkfSO3rcUMGtDrFjQ+FbHx5tYJ3vv0ADGRCHWDL
	 0D8Kn6I/PSbOVtkNj0zj96H9AQkKqJMcrZu9zkDTuHbHS/d11PM9C7ioyvhqox/Ti8
	 zQTx5u+YatLN3Vly91RW4AG/OvVj8NmWtW1eTuMAXIoBf+1LEWaeXJEv5H9xH9jtYx
	 XHqDP4RAkTdsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0DCA0FF0;
	Fri, 29 Aug 2025 11:25:21 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/2] iio_ frequency: adf4350: prescaler and register map
 fixes
Date: Fri, 29 Aug 2025 12:25:41 +0100
Message-Id: <20250829-adf4350-fix-v2-0-0bf543ba797d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADaOsWgC/22MQQ7CIBAAv9LsWcwCJaWe/IfpgcK2JVEwYIim4
 e9izx5nkpkdMiVPGS7dDomKzz6GBuLUgd1MWIl51xgECoUaNTNu6aVCtvg3k4TzOA9W9gKhFc9
 ETR+329R48/kV0+eYF/6z/z+FM86UJnLK4iDVeDXB3ON6tvEBU631CwFtY8unAAAA
X-Change-ID: 20250808-adf4350-fix-3e0b9b7c3420
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756466743; l=526;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=I9x5+JZP4lWupBgVDkivsnIqhBa0ffZvWtaGaAn8KY4=;
 b=CSm9UFnUNDt5dV/4rCYjFSxJ3fJL7DIN4oY6kiY3ndVZif4I6ZBof275VOwK/mKs2WwddgEy1
 n5ASdSyISY+DNhFHjZ9CoYe4+vStEMjd2FShUN2bAruhZajsY4HXVH5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Add some outstading fixes (that lived in ADI fork) for the ad4350 fixes.

---
Michael Hennerich (2):
      iio: frequency: adf4350: Fix prescaler usage.
      iio: frequency: adf4350: Fix ADF4350_REG3_12BIT_CLKDIV_MODE

 drivers/iio/frequency/adf4350.c       | 20 +++++++++++++-------
 include/linux/iio/frequency/adf4350.h |  2 +-
 2 files changed, 14 insertions(+), 8 deletions(-)
---
base-commit: 6408dba154079656d069a6a25fb3a8954959474c
change-id: 20250808-adf4350-fix-3e0b9b7c3420
--

Thanks!
- Nuno Sá



