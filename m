Return-Path: <linux-iio+bounces-26744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4CCA43D5
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 16:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30AAE304D85C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A02D73A7;
	Thu,  4 Dec 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lys5Ls74"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7B2D4813
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861818; cv=none; b=HCp8qXQgY6oQ0YA4UGkKIu4O/mIpeXRxXbgxmj4/yOvg2cb6vrg241XWomrv7p0kwte4kBPrxF9xCEm376+uGPCq2jXb3MFUBbMEG37JKUZgGbqj94nNacDGoB8gQ3p62VwJ0xuGjPxK57jOouOoCne4bUhp8ohRgrrcwtsTxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861818; c=relaxed/simple;
	bh=F10jaYF8Tg9Y+5FGZpu9v2Se6DGRDlrFpYFnzeV2Vo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EnO11pTIr+QYNYoFGUMlhuMRKTuYlX/P6rxDwsEhFoP4F7ffY1aeB8OuksLsD0uqLH4tIQbjmqgSk9QQowlAvOC7yTcgrPYMREj8oE0Xkxc0DCotXtRXOc0VMp6LIwaWxJQmsa2zncJXLmSjnMwUB0x7LussxdmlKdHiMsxMM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lys5Ls74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A2CEC4CEFB;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764861818;
	bh=F10jaYF8Tg9Y+5FGZpu9v2Se6DGRDlrFpYFnzeV2Vo8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Lys5Ls74v6ba31TNOKTw2jshtRO6L8uXMLbhjrwq8kHi2ypg1KmtVKphC3zx03TrE
	 MBlDsNP4Jab3qOTATriygYXu1UHKPyiPmPbutTOyxgEf39kEfK48OdlvGuVOdMuJqi
	 s5oGxF+TwX2TMhwHackPCSqS0BIiVjLEfjHzA+mEuyFjQ2EimmD5TC0zIJrlHGPRj7
	 qHhLdafpMqu1siD4+1XxUnhc7cu8I7JJ27V4kcR6CEC0zJQBmtMotSRKL2JDNeVdy4
	 9T58KkQ2JzuEQgs08GWCpj+MUwGK9YIaTF6i1ikfE6/ANw7Up9ZDQwjCX1evQidFnc
	 LNvMgs1yx2q8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D360D206B5;
	Thu,  4 Dec 2025 15:23:38 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/3] iio: adc: adi-axi-adc: Minor cleanups
Date: Thu, 04 Dec 2025 15:24:16 +0000
Message-Id: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKCnMWkC/y2MQQqEMBAEvyJzdiAZWQx+RTyEONntg4kkIIL4d
 4PssaCqLqpaoJWm7qKiBypyamD7jsLPp68y1sYkRj5WzMBAZn+C/Rp4Q8qF/14UZ8NoxDh11PK
 9aMT5ruflvh9WSXd9agAAAA==
X-Change-ID: 20251203-iio-axi-adc-minor-change-f281c70208e8
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764861858; l=852;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=F10jaYF8Tg9Y+5FGZpu9v2Se6DGRDlrFpYFnzeV2Vo8=;
 b=PFNiArMfFnEyixMd+XaWpTpgJpQ37YUj0Do98L0cish9NyiWBgMu/OQywEQagLUeUzcMF3WMy
 Et+h0DYjxfuDVl+D1J4wwtzIx73Hql1NQks0bzSc/C8nTAbgGS/ROe+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Small series to use dev_err_probe() and turn dev_info() into dev_dbg().
It also simplifies axi_adc_create_platform_device() and makes it
consistent with what we have in the adi-axi-dac driver.

(I'm aware that the dev_err_probe() patch is not consistent with the
series on the axi-dac. I plan to also remove the braces in there as
David suggested).

---
Nuno Sá (3):
      iio: adc: adi-axi-adc: Make use of dev_err_probe()
      iio: adc: adi-axi-adc: Turn dev_info() into dev_dbg()
      iio: adc: adi-axi-adc: Slightly simplify axi_adc_create_platform_device()

 drivers/iio/adc/adi-axi-adc.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251203-iio-axi-adc-minor-change-f281c70208e8
--

Thanks!
- Nuno Sá



