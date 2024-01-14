Return-Path: <linux-iio+bounces-1646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F482D17D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E27D281F0C
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71BC5243;
	Sun, 14 Jan 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOMqwW2s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20F5231;
	Sun, 14 Jan 2024 16:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020B0C433F1;
	Sun, 14 Jan 2024 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705251254;
	bh=L64kBqVy7BVpsJklx5vCdLTNMdO9CGkU7p2hir9tTyU=;
	h=From:To:Cc:Subject:Date:From;
	b=BOMqwW2sLziHEcxJvu2n1yPPLtIg0KVpajoBwD6epRfOfMCCXPYFgesFiOXTbfPij
	 CIF8eB8Pz/7/lg1Z38lKI9fgkbHT0jdA6LNulQ1Hw9kqthaMtBWCSy2/82mzSQPeZS
	 yxUAAlWP8dxJDhnFgRZyrJ6uE+DCLCkwyMtGEqOBXmYXC5lhprakKsmNWZP628FmlB
	 rgZFNKLq2ZyL3ANpIcdwpSZ+DQZN/ziBjrZiCRUXN9OM3aDDbqulhaR2Y30+5WACZd
	 9sQZrEAaPkexzsPF6MOB9Jaccl6BYZt53csLkT5fWBFhQ9K3cj2HtI3kU7w7E7/T+c
	 +j5k2n+8wGuJg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/4] of: Automate handling of of_node_put()
Date: Sun, 14 Jan 2024 16:53:54 +0000
Message-ID: <20240114165358.119916-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since RFC: Thanks to Rob Herring for reviewing.
 - Patch description typo fixes
 - Add some info on the coccinelle script to patch 1. Primarily stating
   that we don't seem to cause false positives with this change and that
   any scripting to find cases to update like this can wait for now.
 - Note the if (_T) is left in place as general consensus from similar
   discussions on other cleanup.h use cases is that it can be helpful
   to let the compiler optimize out the call, even when the call would
   be safe with a NULL value.

Recent addition of scope based cleanup (linux/cleanup.h) allows us
to avoid a large number of places where error handlers and early
returns have to carefully deal with left over resources.
The need to call of_node_put() on breaking out of loops over child
nodes is one of these cases and this series is to address that.

A similar series has been posted for property.h equivalent case.
https://lore.kernel.org/linux-iio/20240101172611.694830-1-jic23@kernel.org/
(will be updates shortly).

If everyone is happy with this series, I'd propose an immutable branch
(either in iio.git or somewhere else) so that we can pull the first 2
patches into other trees without having to wait a whole cycle to start
making more use of this.

Jonathan Cameron (4):
  of: Add cleanup.h based auto release via __free(device_node) markings.
  of: unittest: Use __free(device_node)
  iio: adc: fsl-imx25-gcq: Use __free(device_node)
  iio: adc: rcar-gyroadc: use __free(device_node)

 drivers/iio/adc/fsl-imx25-gcq.c | 12 +++---------
 drivers/iio/adc/rcar-gyroadc.c  | 20 ++++++--------------
 drivers/of/unittest.c           | 10 +++-------
 include/linux/of.h              |  2 ++
 4 files changed, 14 insertions(+), 30 deletions(-)

-- 
2.43.0


