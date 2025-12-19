Return-Path: <linux-iio+bounces-27223-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB77ACD0902
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EBE23070F13
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03331326955;
	Fri, 19 Dec 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jkt5eFqE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D333191D0
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158798; cv=none; b=K1jU5yIsUPRpt0aHgPv36gR66qvWRmR5mcjrgQpFcTnsun95Ha6U0KiDecVioRTTH/l6LgCPaBSHIXvTbqyv6HGQdWWYpsABeimW1llC8/DNCc6MlReckMGnk+T3TqIlhAwwmgGRxVirX3MKAlKuMNFrAwNEKZ24k9AqeiMkwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158798; c=relaxed/simple;
	bh=ov2yq43gUNo/inTJOGNOxiikI1eeNqjNvjRwoEmE+qk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZHGOJ7KMou5thlJ4O+slz5Pd79TN+jHqE4PCkVObeGS32i3y83zbSAX3FeUDNYtnYeVKgkSSakcqf6ndgbAuB4a5Yk69QqFqLJQThgTPzEZew2ur0Ikdn4VIunBROehwhIUDlOayqSRQP/TtrDX3ixBOJw/pbXRGW2aio2dnLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jkt5eFqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 343B6C4CEF1;
	Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158798;
	bh=ov2yq43gUNo/inTJOGNOxiikI1eeNqjNvjRwoEmE+qk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Jkt5eFqE+VcXKEsZzxxqzirUFh17s3T6qpWMDEMNp/LKFx++8P9hGfomytDBDUEqy
	 /1zXZQv2V/dtGCeSsDEritC6QN9fdnBNjtYAhbga+AvUHbkZjUhYGKkPBUIOVIyx8V
	 56QsNdmET/DIPbVoJuV+bEWirMID/OzHy0pqPKg2I7P/QvD24j8A6d8TKr1E0k2nup
	 xG05zeXhg4qhL2X9/dXpwtJWCR1s0MLe37hiiI32icCC0Do1AmDrH3EYfml707Qeg5
	 pJQ5+rkF4ez6sPKg8pMLK1dz0rs/NFp/6fvycKNFqZPt15pz8Cse1Juko5+fMcXlrp
	 +rT73UGgJ4FGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB74D7878C;
	Fri, 19 Dec 2025 15:39:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/2] iio: adc: adi-axi-adc: Minor cleanups
Date: Fri, 19 Dec 2025 15:40:37 +0000
Message-Id: <20251219-iio-axi-adc-minor-change-v2-0-9d8e7270d19a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPVxRWkC/3WNwQ6CMBBEf4Xs2TXtSpF48j8Mh9oW2ERa0hqCI
 f13K9GjxzeZebNBcpFdgku1QXQLJw6+AB0qMKP2g0O2hYEEKUnihMwB9cqorcGJfYj47fXUSnM
 WJFrXQpnP0fW87upbV3jk9AzxtT8t8pP+pPV/6SJRINm6lrYx6t6oq/b6EYajCRN0Oec3hJUhH
 cEAAAA=
X-Change-ID: 20251203-iio-axi-adc-minor-change-f281c70208e8
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158839; l=1067;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ov2yq43gUNo/inTJOGNOxiikI1eeNqjNvjRwoEmE+qk=;
 b=cFP2KEtGJZBSddQ4YMK1saKc90sTZ/oEfHbcoxF16vZ3sZMXUMNiMIo9JfHjv/Iy/sa2JQQ9F
 qGV6tviaV+hBehabBbT5QjqgInkAnxYYNoUr+yVOAagiN5519yn3nz+
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

I ended up dropping the patch that turned dev_info -> dev_dbg()

---
Changes in v2:
- Patch 1
   * Added helper struct device variable as suggested by Andy.
- Link to v1: https://lore.kernel.org/r/20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com

---
Nuno Sá (2):
      iio: adc: adi-axi-adc: Make use of dev_err_probe()
      iio: adc: adi-axi-adc: Slightly simplify axi_adc_create_platform_device()

 drivers/iio/adc/adi-axi-adc.c | 62 ++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251203-iio-axi-adc-minor-change-f281c70208e8
--

Thanks!
- Nuno Sá



