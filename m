Return-Path: <linux-iio+bounces-26689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF394CA0EE5
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 19:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B171B342CFB3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41DA33343E;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cId9Xp0w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295E332EB7
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777177; cv=none; b=FPoWPxYCYjOxsoRXQBtYuixCgMnpHMCY8uu16MFdotGVlb0LkmAKfaF+HAUIIY06NcRyjpMmV4deBOUuKqQCdhvQKeb0o9CNk38OQd4nwa0QKdiqvf7ipkeoShogAF3WUezO8XcDn3AG8gRtWf2SiqpsXrfqRemm4XEb0JCmTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777177; c=relaxed/simple;
	bh=2AHFe2w84lGFKnqTr1gFzttLc8+02i8mtrCuH+ghiPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BGcYpZPpkPoYoDt4sq1BnkqJVUHMzSiPMAD10Hdwf0dytTOElFHOrmJMd370lm6z8GRquhuJ8/tAyxb/ymc/vxc8ZGJVx7BnHO7H7sTG/YnIQx3LsULvPS4xzPPJYCeik8oLLTGZb6qu2pm8ozSWTQvcv8FRBGEMNz9U2+ZxZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cId9Xp0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40469C116B1;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764777177;
	bh=2AHFe2w84lGFKnqTr1gFzttLc8+02i8mtrCuH+ghiPk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cId9Xp0wDVg37xhAupd5ShFtKjKvVLNimtAR41un/Ri+dbTL0EtNtqgpqQzSOU81b
	 vF1EqSAcUzmguNF966I+CSU8WTPpylM8kzDGJBFce5szAaY0Y9qaAO9QdjddUHedjY
	 UZjwGL8pwR7KIpxrWoT0ZnxnM544QXqj+9KL++AYVGF5e8P4xNTJCTvFOmaUqQkLIh
	 ZuRa7Tqv6GFopPOS9OqRdrN7x9ItYB37LrEpjtFtKFkbCYjsU7PnEDVKLiUx6EJJGG
	 cO/gRNY8bfkjzGKWEym++nsczcCtmD5OgSu2uAspclFus5LykESl19NmwP+rbyhWl/
	 eH1v1OsvV9EZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847CD12D7A;
	Wed,  3 Dec 2025 15:52:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/2] iio: dac: adi-axi-dac: Minor cleanups
Date: Wed, 03 Dec 2025 15:53:35 +0000
Message-Id: <20251203-iio-axi-dac-minor-changes-v1-0-b54650cbeb33@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAP9cMGkC/yWMQQqAIBQFrxJ/3Ye0XNRVooXVt94iDYUIpLsnt
 RyYmUxJIiTRUGWKciEh+AKqrmjZrd+EsRYm3WijdNMyENje4NUufMCHyL+XuO+Ms8ZpUTJT6c8
 oDvf3HqfneQFkKzA9awAAAA==
X-Change-ID: 20251203-iio-axi-dac-minor-changes-945fa5f2e1eb
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764777217; l=480;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2AHFe2w84lGFKnqTr1gFzttLc8+02i8mtrCuH+ghiPk=;
 b=SzlRm2vupn+/WEUI+CdieEBLI5MV8CvrUuIZflaGGVBxeZ0RrIGOnuL7UDHNqUHXv3CqxrugA
 ZHVHaYTM3ZTCGaVnSmmRQ0M9CohrVtP6Tw0lQ+BelzfB+Vx9v1lA7DW
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Small series to use dev_err_probe() and turn dev_info() into dev_dbg()

---
Nuno Sá (2):
      iio: dac: adi-axi-dac: Make use of dev_err_probe()
      iio: dac: adi-axi-dac: Turn dev_info() into dev_dbg()

 drivers/iio/dac/adi-axi-dac.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251203-iio-axi-dac-minor-changes-945fa5f2e1eb
--

Thanks!
- Nuno Sá



