Return-Path: <linux-iio+bounces-14393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163D1A13B4A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 14:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9209161451
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF04C22ACDF;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQzKq55M"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6021E1DDC35;
	Thu, 16 Jan 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035613; cv=none; b=jRiZzAL3j/hn8RQvrZ2dLLB2oGNlx1LZfim0HelKS/SqIDohF6wJiHF+ScpkTSeptFjTPb1VYay6mJxzQD99dJyWMyQdi43bcQrErF5x5xpIWtn+QNSF8dvhmwh9TefhOcGHPTqX+Ce6KIFO1K6Va+3zKXUtV4WnPUjFPW+nKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035613; c=relaxed/simple;
	bh=zJGJo69lBvaa7jyTghcNGFOtdhlAd60prLEiVMAUezY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d07i+FAdxYAlP1pU2KvWPvnfEPWhq6yEYLrmFIttfuOg03ml9GTWgWAEKzhmyAsTiNexNGCihGH4XtExNEifzG2LLboYCevgTYD4SsnKbmjmJGIv/gh9ncSk6QYNAsb3nCm6XmyoxmxmKYQBoakI4nMyauUaxu5kSMCG8MDimKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQzKq55M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAA13C4CED6;
	Thu, 16 Jan 2025 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035613;
	bh=zJGJo69lBvaa7jyTghcNGFOtdhlAd60prLEiVMAUezY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=sQzKq55MWYXIPWW2iorIwYm66VN0EYsNG4t+Buxhu4aG4Y1Aoixr9K9mIEOck/lBJ
	 kNcv6cEM4zRW27cm2xSMxxxqr4W6vT/nWv4Q9cdKWN9xnf9z9RavXz+9aYEnC5A+Zb
	 Lx0kMi9arqqzusxCLVocRYjCSY09MoHWbjSZMj6TxBsun3N/jqGnyLOF8Jw5l1MIWa
	 T73ph+DI5esLIlh+H6T8oGpzRxqEDYU3l8QlaztC++ZDRyuzGONRtfjLxhVth9WNuC
	 RreohOvcZPPDEB+foco6IsvMeOaWXmULM5pgVOAny/zboDlmVXNz8huuvFyNqsROyw
	 xkEhv8QfIMEqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65B4C02183;
	Thu, 16 Jan 2025 13:53:32 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Subject: [PATCH RESEND v4 0/5] iio: accel: mc3230: add mount matrix, of
 match and mc3510c support
Date: Thu, 16 Jan 2025 16:52:41 +0300
Message-Id: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=zJGJo69lBvaa7jyTghcNGFOtdhlAd60prLEiVMAUezY=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNI7+SOXVjnvblV5p7ST9egzHS3ffOOpdhz+03h+7A25H
 NuQGaTcUcLCIMbFICumyGKz0WO2WH645KRpTxVg5rAygQxh4OIUgImILmD4cayVn8832yZvUnzD
 2akrDpd4Tav1al97+9Umef3+hMy9DP801kXxGci8uNr8enFP5u0zXR5su481rikTq3PpaFnq7MM
 HAA==
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
Changes in v4:
- Fixed commit messages
- Added const modificator to chip_infos
- Return name->chip_id->product_code->scale order
- `{}` replaced by `{ }` (with space)
- Link to v3: https://lore.kernel.org/r/20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com

Changes in v2:
- Ordered commits
- Fixed comment style
- Ordered struct members
- Fixed device table
- MC5310C commit splitted
- Link to v1: https://lore.kernel.org/r/20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com

Changes in v3:
- Fixed patch (poped stash)
- Link to v2: https://lore.kernel.org/all/20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com

---
Vasiliy Doylov (5):
      dt-bindings: iio: accel: mc3230: document mc3510c
      iio: accel: mc3230: add mount matrix support
      iio: accel: mc3230: add OF match table
      iio: accel: mc3230: add multiple devices support
      iio: accel: mc3230: add mc3510c support

 .../devicetree/bindings/trivial-devices.yaml       |  2 +
 drivers/iio/accel/mc3230.c                         | 95 ++++++++++++++++++----
 2 files changed, 80 insertions(+), 17 deletions(-)
---
base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
change-id: 20250111-mainlining-mc3510c-564702fba487

Best regards,
-- 
Vasiliy Doylov <nekodevelopper@gmail.com>



