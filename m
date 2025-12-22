Return-Path: <linux-iio+bounces-27316-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6E8CD642D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 599033016A1A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76C733F8B7;
	Mon, 22 Dec 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2PWyVhR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7518A238C2A
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766411246; cv=none; b=cmD6gCLsP2DRWp8SWgEY43iAp4D5J0lQ7uZpHly781+Cb1DwPVb6GxLFGQlDNjJjUl7OGQ6nN/6DOZB9ghLAfV64ZPoCqXXmopq47c/BGqKh1+f525o2Tl9h/HkNG+rAPAPTibZgMoTFOeLzcLPTMNzzHTD1SthtSZI7C/hqvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766411246; c=relaxed/simple;
	bh=O3tzWFV3hU8gAqQTMrh5Kjjke5lNsISbR9xd5iSHpAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UVVoSi386xBQnpXkTM1W7wIfGxcFpxro6l96B1N/Hhz5NevvV7HkfMOE5m+D1A0413nlu0qEiFG2dZRoT6lqvQo5sYl4jTuvtV5DxiCH/5vMkOs7wy4KIXT6DZr1usFmC6QJ3M9+LmoSfdsW7AMJEeHAgSgdxGBYXiwkbM+LP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2PWyVhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E904C4CEF1;
	Mon, 22 Dec 2025 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766411246;
	bh=O3tzWFV3hU8gAqQTMrh5Kjjke5lNsISbR9xd5iSHpAY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=l2PWyVhRlx/kwRjTJK5rbOwViOGv2p0Av/oJkTiNPS48ecMp/yHdH3UOGeUzhIzuZ
	 JVBozhSKar2f8bzT0Xc51vGs4E1chNJt05Dt5VW7d83X+AMb0Wm77qxu/4sJYQNzBF
	 3d9pQzNt5BOinMYHlp6D181YUax8tKXuebGx81un8UfGJOaYW213mvHpgCuNYfzaYL
	 Iq/jfiCCYDO1GVw39u5pWwxGDrkdtQonbYlipgDOMD7LE+BfMzRCx/UufhCbFI3sZY
	 3chV83wl9e8FS/yRGcz9HVu1cdj8YWWw8b55/Ak32GHeVZ0RHDsw5sEkfn6fdShncn
	 9z2IXh8nZ+5lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F48D711D5;
	Mon, 22 Dec 2025 13:47:25 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/2] iio: dac: adi-axi-dac: Minor cleanups
Date: Mon, 22 Dec 2025 13:48:00 +0000
Message-Id: <20251222-iio-axi-dac-minor-changes-v3-0-29199f239d9c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABBMSWkC/43NzQrCMAzA8VeRno30YxXqyfcQD22XbgHXSitjM
 vbudvOiF/H4D8kvMyuYCQs77WaWcaRCKdZQ+x3zvY0dArW1meRSC8kVECWwE0FrPQwUU4b3XgH
 T6GB1kCjQsXp/zxho2uzLtXZP5ZHyc3s1inX6jzoK4OB0c9TcO3RKnW20t9QdfBrYyo7ygxLmF
 yVBAJrgvefCOC6+qGVZXhbw7dAOAQAA
X-Change-ID: 20251203-iio-axi-dac-minor-changes-945fa5f2e1eb
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766411287; l=634;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=O3tzWFV3hU8gAqQTMrh5Kjjke5lNsISbR9xd5iSHpAY=;
 b=VNHgMtgdsdb0y9i0aZo4JPWapkaaswaRFWavmdIR9/5+MS8c7GiDXquPKB3j2Our4ViwkLrEU
 oSXSlzTFStZCtfRb99lcD/FWIsjSO83H3VzTL7VGJvO+5a4TJMNKF4F
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Here it's v3 with the patch split in two.

---
Changes in v3:
- Patch 1:
  * New patch.
- Link to v2: https://lore.kernel.org/r/20251219-iio-axi-dac-minor-changes-v2-1-e9fccc019b01@analog.com

---
Nuno Sá (2):
      iio: dac: adi-axi-dac: Make use of a local struct device variable
      iio: dac: adi-axi-dac: Make use of dev_err_probe()

 drivers/iio/dac/adi-axi-dac.c | 66 ++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 35 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251203-iio-axi-dac-minor-changes-945fa5f2e1eb
--

Thanks!
- Nuno Sá



