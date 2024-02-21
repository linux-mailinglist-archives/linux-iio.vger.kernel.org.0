Return-Path: <linux-iio+bounces-2870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8285DA56
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DA01C21597
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978F80C06;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3+tvsOn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACF80BEE
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522017; cv=none; b=N9O5d618DTfwI8GmjBEjenew+QEJ85T7tEiGN0pyOSs92IBZjQTgpzbeoisYCfjp5o0VC3dzYRZb06ZCYqSsxe39KQh7CWN9v4YvnK+4Kcz5p+KS4fxrS9OPljeamB1jIHK2BEmISBmQeqtlnzXeMRZNrb/UPMTgmh1V02CnosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522017; c=relaxed/simple;
	bh=biPceoEZ/pR8Xvp5/lPe0+nInLOTnUmJdiVykHTBK1w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zl0EGoDsHL/uPJ0w3sXgtxjdcG8oFXskyvmSfIPGqokrqYr6ZYgeMJ18dNSZe8BHEqHitZG0vZaQXS5E74F27HepGO9urrAqHICeJMTk+DHpiHqMbcdNND0HXRvfycRoWUuM+zWLb/SLDWJ8Xn3Cko/YD8LJsrGbugGZBT4UNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3+tvsOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D482DC43330;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522016;
	bh=biPceoEZ/pR8Xvp5/lPe0+nInLOTnUmJdiVykHTBK1w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=H3+tvsOnP2QbWBBKNexbvJcAnT4RfZhkTyhn4yE8MKeZH1jwiz9rZPehcATwuA5KO
	 ouQwrHyqHnIjUkPlafb4UcAnAWsGpYiimd1N0Uh0ARDQn+2FYrbfmqVUa5VJhEx7aU
	 +iPsiXZrR1ssJhFvOUtZmPI7SvnpiLR38L339IzDCVJCXDqTfU/ii7B8ySI7Nrlsbr
	 E/RoZP8pCnEqEadam47K3Z8khmTS7B+vD9j6sPZR/jD7kBRakJ8tKFNPiNuntOinps
	 RAGJoc4dBbR/GlJd/BtNHrivg9HjPvzZ11dwdoWKZ0PdU3H63AYtQMTfOevcwwEIlf
	 yKnRhzS+jltaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8109C48BC3;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/5] iio: move IIO to the cleanup.h magic
Date: Wed, 21 Feb 2024 14:26:51 +0100
Message-Id: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABv61WUC/x3MQQqAIBBA0avErBvQIYS6SrQwG2ugNJQikO6et
 HyL/wtkTsIZhqZA4luyxFCh2wbcZsPKKEs1kKJOkTYoEvHKjG5nG64TD7uKQ+q9M8ZY3dEMtT0
 Te3n+7zi97wdLImL0ZwAAAA==
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708522015; l=1716;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=biPceoEZ/pR8Xvp5/lPe0+nInLOTnUmJdiVykHTBK1w=;
 b=AUaQQPhJDVV4uNENBLF+EKn+PL4QP1S428oUWvtL458297kN79a0df7Udu8l3Cz60OM1fsoM+
 EpPGSQMElCSAkBtul2u4Zv9sV8CI42wpoDs6gOyUp3SNFKzW9EkpBM/
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

This series moves the main IIO core files to the new cleanup.h
macros for acquiring and automatically releasing mutexes. This results (in
some cases) in way simpler code paths.

I think the overall result is fairly neat (mainly in inkern.c).

One thing to mention is in the iio_event_getfd() function. We might be
changing the return code. Before we directly returned the error code
returned by mutex_lock_interruptible(). Now we return -EINTR. And this
is something visible by userspace so it might mean an ABI breakage.

Having said the above, looking at the mutex_lock_interruptible() docs it
seems we either return 0 or -EINTR. Not sure if that is really truth
(but it does makes sense). On top of that, I would also say it's very
unlikely for someone to be relying on an error code return by a locking
function but who knows... Anyways, this is something worth mentioning.

Next goal is to convert the code under iio/buffer/

---
Nuno Sa (5):
      iio: core: move to cleanup.h magic
      iio: events: move to the cleanup.h magic
      iio: trigger: move to the cleanup.h magic
      iio: buffer: iio: core: move to the cleanup.h magic
      iio: inkern: move to the cleanup.h magic

 drivers/iio/industrialio-buffer.c  | 105 +++++++----------
 drivers/iio/industrialio-core.c    |  52 ++++-----
 drivers/iio/industrialio-event.c   |  42 +++----
 drivers/iio/industrialio-trigger.c |  64 +++++------
 drivers/iio/inkern.c               | 224 ++++++++++++-------------------------
 5 files changed, 172 insertions(+), 315 deletions(-)
---
base-commit: bd2f1ed8873d4bbb2798151bbe28c86565251cfb
change-id: 20240216-iio-use-cleanup-magic-29fc666a142b
--

Thanks!
- Nuno Sá


