Return-Path: <linux-iio+bounces-14179-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDCA0A8F4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824EE3A718D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479DD1B219D;
	Sun, 12 Jan 2025 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq7iWNSD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1131AA7A6;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683565; cv=none; b=oPgWi+sgPMZ77Xz/WpPKLbUiIuBSg8TvsR5L1cpOr1mxcGFzduJb4tkvMwoqooD7IN+zdw/9yoHBRgWWVee38Y5hN6Q5+eqvfDGWLk0b2SneivSd0gulwtaMJERykk+b1ZRPOPzmw0VxhPAEOP3x5CfgpSHn9mrXxME+yqLLIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683565; c=relaxed/simple;
	bh=51UGbQJDkXeaZdgyZ5/k8YnnHoPQZujzOElYRCDV4aQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b8+0pfEmxjsuvJVvBZY5q32IpK8zPDNGNfFvaivzlZU9v5aHYNK3VAS3fNZATNLNsj9JlbhRIju2eu5DAWXX9BlUese6lQwyVcdzRh+cztQt0CiWl+rV9OFvtYwCbub00oLP6dWagAJRXXUKDViGesYO7q4reOxRoi0CrsD1Uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq7iWNSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F70CC4CEDF;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683564;
	bh=51UGbQJDkXeaZdgyZ5/k8YnnHoPQZujzOElYRCDV4aQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=aq7iWNSDekrm2cma3k4Xk5uYrDMaa78vT02AILG5Hfk42mrWebkVzgnCHWNotyvNg
	 DQkreP1YQcx48L2EcGFt817aiGQn14SPXDBuoA7Kc4hqgu7NvgcHmJxT4eP6STxD8c
	 a7SJuWyJowCF74O7BAEJxXp7aElQUnC9eNDkknhF/W+0geJSInb8bbx+v6ju2UTMPM
	 mcmzPcz0l+irz/XyNSA3Wd2JavhV1BFin3IhQYAi8xXqlWtTD5Sc0foJdQl8DdfqR0
	 qK9cMewgrJl7M9U3v4nXPVvWp31NMKxmUlqybFtA9XvkaeW255JSFAkUjSl1LvPd1d
	 wj6Dzed7Iu7YQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67242E7719C;
	Sun, 12 Jan 2025 12:06:04 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Subject: [PATCH v2 0/5] iio: accel: mc3230: improve driver, add mc3510c
Date: Sun, 12 Jan 2025 15:06:01 +0300
Message-Id: <20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACmwg2cC/32NTQrDIBSErxLeuhY1sYaueo+ShfEvD6IJWqQle
 PfaHKDLb5j55oBsE9oM9+6AZAtm3GIDfulALyp6S9A0Bk65oIwxEhTGFSNGT4LuBaOaiNsgKXe
 zGkYJbbgn6/B9Sp9T4wXza0uf86OwX/pXVxihRMjZCtorY9z48K21XvUWYKq1fgFmMScjtAAAA
 A==
X-Change-ID: 20250111-mainlining-mc3510c-564702fba487
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=51UGbQJDkXeaZdgyZ5/k8YnnHoPQZujzOElYRCDV4aQ=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNKbN2j1eUW1f1j4+A+Lo2r+744k09ajswWKXG2m6kQ9O
 LDSbLppRykLgxgXg6yYIovNRo/ZYvnhkpOmPVWAmcPKBDKEgYtTACbyah7D/7BNouoNp2/59XFm
 /JnRmaS19tLC1ud3j896VpL2Mermy1qGfxrHcs08JFlZwv7LVXefZHs8UcDPdJKzbO0ez59aFUc
 28gAA
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
Changes in v2:
- Ordered commits
- Fixed comment style
- Ordered struct members
- Fixed device table
- MC5310C commit splitted
- Link to v1: https://lore.kernel.org/r/20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com

---
Vasiliy Doylov (5):
      dt-bindings: iio: accel: mc3230: document mc3510c
      iio: accel: mc3230: add mount matrix support
      iio: accel: mc3230: add OF match table
      iio: accel: mc3230: add multiple devices support
      iio: accel: mc3230: add mc3510c support

 .../devicetree/bindings/trivial-devices.yaml       |  2 +
 drivers/iio/accel/mc3230.c                         | 93 ++++++++++++++++++----
 2 files changed, 79 insertions(+), 16 deletions(-)
---
base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
change-id: 20250111-mainlining-mc3510c-564702fba487

Best regards,
-- 
Vasiliy Doylov <nekodevelopper@gmail.com>



