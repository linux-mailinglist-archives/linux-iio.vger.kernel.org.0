Return-Path: <linux-iio+bounces-14282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0160A0B8F1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C413F1887332
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA52397B5;
	Mon, 13 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGc5/U4S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9DC8C5;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776923; cv=none; b=t70CSBvrpAXxEyPYtl9ARPnv5jnCf/OVVl/4f7mMdmcPPVc9uIJHW21hTNkyk1DTN6Ay4/GeuovmITKfoeRKafZgLaHGFQ04ePsDpLDyOFkPYQD61jwNXRp7gtmADgF25ZQYQgYfkd+1/ZlHx764/qVl7KZS+kBvWIyPit6jFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776923; c=relaxed/simple;
	bh=1foJnlFwecgiLjbQ89yCo3+34DlcoroFVnAhT5nYOlo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lXLHWWyli32fRuvCT7o2aQc//IcaNiLUoRTYQKwkkrOBlHFaatfhMz+m+Se17UsGUWxRQRengsa6IZfMeQVEgorBBgadh9yXslvPkjScQGIXJ/M6B+TE9zZXKHg00bGKsPPVT/CdI5SKDz8C13J5rmmIdmNBnmiAoYe9hQPjaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGc5/U4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B81AEC4CED6;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736776922;
	bh=1foJnlFwecgiLjbQ89yCo3+34DlcoroFVnAhT5nYOlo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DGc5/U4SgR9C5eYTCBLHxy1pkLOmx0IMFOg+hQNY97QXYcobYSHBH3SiL4mkKqhBw
	 cJ6vLTgDWnV/WYzcp+Z1Ohhe5Agn2AEe+SHqBxvHUfGitYjYzwkEFSudsVrF/w7yRs
	 YQVxflu/6mcV11s237+hyXbhISU1SthVahuvOs8v2mmIS4dKfYqt2EJpkqeP/IFnqR
	 yDJmkvvsPkORz9JT8IpvXXwygOE3O5XyKIdFxqdz2+dWnypOXpNtMUMetxMt+WCJRp
	 X2QUIGrDErm41jG91O6HS+2qh3hWxmfBwP2t8apxQxCArf4qMjDl9i1WjWRRZA7aOF
	 JO7TfEsUhqkcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B6E7719F;
	Mon, 13 Jan 2025 14:02:02 +0000 (UTC)
From: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Subject: [PATCH v4 0/5] iio: accel: mc3230: add mount matrix, of match and
 mc3510c support
Date: Mon, 13 Jan 2025 17:01:59 +0300
Message-Id: <20250113-mainlining-mc3510c-v4-0-4118411ef569@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANcchWcC/33NwQ6CMAyA4VchOzvTbQzQk+9hPIytQBMYZjOLh
 vDuDk4cjMe/ab8uLGIgjOxaLCxgokizz1GeCmYH43vk5HIzCVKDEIJPhvxInnzPJ6u0AMt1VdY
 gu9aUTc3y4TNgR+8dvT9yDxRfc/jsP5LYpn+5JDhwXbeoQRnnuubW563xbOeJbVxSR0L+JFQmL
 oiVlmDa6uKOxLquX52cR2j3AAAA
X-Change-ID: 20250111-mainlining-mc3510c-564702fba487
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vasiliy Doylov <nekodevelopper@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547;
 i=nekodevelopper@gmail.com; h=from:subject:message-id;
 bh=1foJnlFwecgiLjbQ89yCo3+34DlcoroFVnAhT5nYOlo=;
 b=owGbwMvMwCW2fZ/SFZeSpU2Mp9WSGNJbZW6wb7LS5r60MVjST+OXyXPOHXotl3+wu1iUqO5oL
 LI7HKLWUcrCIMbFICumyGKz0WO2WH645KRpTxVg5rAygQxh4OIUgIk03mP4X7xoS/90dY7cG6pz
 zi+ceekeP8+F0hPPnXkPilmeym5cpsnwT8fv454HW89F3D7xWqnIh9FRTIXlfkDdj/jPm/eYXHh
 0jw0A
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



