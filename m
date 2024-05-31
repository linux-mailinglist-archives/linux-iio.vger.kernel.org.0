Return-Path: <linux-iio+bounces-5533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA558D5EA0
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E94D1F23E1F
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB37136657;
	Fri, 31 May 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1chlbH/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5EA135A65
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148523; cv=none; b=LZe5PVBhcpXMY9qkSS77UWYid4t1ZrmbTBtgBXC3D3doJ1PYrcMEqtuWUyO/teE00szrdlV5PLJrSEPDW2o+WvuA5/KP5IsYaXUU0c04BCX01GLjrwOndWfEz4Q266/8ezlaEMxLsIY/A4Ep3hpOPTF3k7N6Stu+3TCCXHWP1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148523; c=relaxed/simple;
	bh=R3CwbVDWIO5pU2ln/yLqWT9OQjKOkcvucZEd/QgBnzI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NmSXPBYvTKu7MNlu3aQljAdMZqz4Jy3MrPn27kai4JWRmChAPVx+sWHkO6UdVQsQYjWHO2Gj13zraWq1u79RpzwkFR0QQEU9xF+kNfRnn7dfvdHWzPdoiKKSDeKjAKFojL0heBQySjx3pXe1iuaTYeUcWJh2EOBkMqGN8fBfT6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1chlbH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F23A4C32781;
	Fri, 31 May 2024 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148523;
	bh=R3CwbVDWIO5pU2ln/yLqWT9OQjKOkcvucZEd/QgBnzI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=k1chlbH/rO3tSqwoqraD4sGhAkxLJyTNQ4Ns0/pYtopSVo5mh4WRYitcOdLeNF/bp
	 Sk9eTVZRX8HNLoGixrl6MkmvfedFbj4NyrATJwXwzyXN15gQsPuFWUPFDD8m9aCG8S
	 ElCC++1F9KCHmZ6QNWzJyXabyuWKFwQfcUb/aFNUpdrsYv179pr4knEPO999FWa5YK
	 FCK0LTvLqlLHrz90ZSq65mbEDUlx0eXU77SWxU4VH+up6PdXqkgInJO77yyYxPVrsh
	 xBWVG2DaFn9muLniaxwKt8L1YwNpwSlPsIRG4QBTuAnW+WbgCDb8FyM3STEgWsXyJQ
	 IasNQp4CFcEzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB74C27C44;
	Fri, 31 May 2024 09:42:02 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/2] iio: adc: adi-axi-adc: make sure DRP is locked on
 enable
Date: Fri, 31 May 2024 11:41:53 +0200
Message-Id: <20240531-dev-axi-adc-drp-v3-0-e3fa79447c67@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGGbWWYC/3XNQQ6CMBCF4auYrh3TFijUlfcwLoZ2gCZKSWsaD
 OHuFlYa4/J/yXyzsEjBUWTnw8ICJRedH3MUxwMzA449gbO5meSy5BVXYCkBzg7QGrBhAiTVWm0
 LqUTN8tUUqHPzLl5vuQcXnz689gdJbOt/KwkQ0FiFTaU6zTVdcMS770/GP9iGJfkBSPkLyAy0q
 jC61hzLBr+AdV3fAiTUp/AAAAA=
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717148521; l=674;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=R3CwbVDWIO5pU2ln/yLqWT9OQjKOkcvucZEd/QgBnzI=;
 b=xHcm4gO66Se4fcL0Gk7rnBcOqPtV6p51F/+WhW4qwQbq7GFFlZgcetFKWoFpmxmhctlxaco8f
 q1y1NQz+892Au758izc1KNxSnVWvyrbfZptonvkZSGTPvoztP7yofkf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi Jonathan,

Here it goes my v3. Just splits the fix (with a proper tag)  in it's own patch.

---
Changes in v3:
- Patch 1
  * New patch.
- Patch 2
  * No changes.
- Link to v2: https://lore.kernel.org/r/20240522-dev-axi-adc-drp-v2-1-b63c9790a48a@analog.com

---
Nuno Sa (2):
      iio: adc: adi-axi-adc: don't allow concurrent enable/disable calls
      iio: adc: adi-axi-adc: make sure DRP is locked on enable

 drivers/iio/adc/adi-axi-adc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)
---
base-commit: 5e3c5871138da700796587aa5f096d39135f9d36
change-id: 20240506-dev-axi-adc-drp-ae6bd9d32617
--

Thanks!
- Nuno Sá



