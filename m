Return-Path: <linux-iio+bounces-708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C896B8087FF
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045091C21EF5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B23D0A7;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut/Igmne"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174B39ADB
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28A76C433C8;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952769;
	bh=wUA4Tq0B1/koCIeTJDDgCQRKEa6nZJuFEgep+ax7t/U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ut/Igmne6SWdcaOB2S6iZ4IqJ6nkHyh70lZNGB5hFbnRPl/RF5QXR0mrDM0f5Q9e8
	 mD88nBfRUZwXq0znGKceRw/laI3x5STGRfoChZWcsku/Y3Lj7UCPMI6NFsRpmAdPbk
	 Hod3EjwAU66b2xLR9rk4N88LYp3NV+teZ8yZ0LeZd+QE1B3DZe66aSSTtz5gLPT5M6
	 dCbJv8gVIXBO/ugDsyTHF+gUkMLFLgYyKj0eIHcOrN+ilvh0MOpWQDdFiINL7ZYTcT
	 r2pucK977tzUDxvSqSlL4lSE6QkY8pUQBzxg6wpmT3sg+5xp+eAndoGcentJyrcHmc
	 qfDLn97aZt7kA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6FC4167B;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/8] iio: ad9467 and axi-adc cleanups
Date: Thu, 07 Dec 2023 13:39:23 +0100
Message-Id: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPy8cWUC/32NQQ6CMBBFr0Jm7Zi2IIIr72FYlHaAidqS1jQa0
 rtbOYDL95L//gaRAlOES7VBoMSRvSugDhWYRbuZkG1hUELVUokTMnsctbmTs7gGWrGxfUtT3Ta
 iE1BmRU783pO3ofDC8eXDZ39I8mf/xJJEgWfTj0Z2tpVqvGqnH34+Gv+EIef8BZqpNUWxAAAA
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701952767; l=1795;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=wUA4Tq0B1/koCIeTJDDgCQRKEa6nZJuFEgep+ax7t/U=;
 b=W31xjp6xn74qnSOMDzP3WHkqJyfdNJY4Zfj4fGgEcA53RKoA0ldbFHej3t5zvVjvI3qfitYFj
 +oAg/JFddggBL1XWBLw8VK+7215+DH/n77X50ljjwttO63oL3b1iOzo
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

As requested in [1], this is a preparatory series with some basic cleanups for
the ad9467 and adi-axi-adc drivers.

This means that the iio backend series [2] will depend on this one but
hopefully we'll quickly get this one in.

[1]: https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#ma7ed8a58d747e78e1ff2273c2d6cdd11de22f177
[2]: https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff

---
Changes in v2:
- Patch 1.
  * Use IS_ERR_OR_NULL() and PTR_ERR_OR_ZERO();
  * Improved commit message (mention it's inverted polarity).
- Patch 4:
  * Properly allocate enough memory for the scale array;
  * Use devm_kmalloc_array() as we don't need to zero initialize it;
  * Don't multiple by 2 in the for() loop. We just want to go over the
    rows.
 
- Link to v1: https://lore.kernel.org/r/20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com

---
Nuno Sa (8):
      iio: adc: ad9467: fix reset gpio handling
      iio: adc: ad9467: don't ignore error codes
      iio: adc: ad9467: add mutex to struct ad9467_state
      iio: adc: ad9467: fix scale setting
      iio: adc: ad9467: use spi_get_device_match_data()
      iio: adc: ad9467: use chip_info variables instead of array
      iio: adc: ad9467: use the more common !val NULL check
      iio: adc: adi-axi-adc: convert to regmap

 drivers/iio/adc/ad9467.c            | 207 +++++++++++++++++++++++-------------
 drivers/iio/adc/adi-axi-adc.c       | 159 ++++++++++++---------------
 include/linux/iio/adc/adi-axi-adc.h |   4 +
 3 files changed, 204 insertions(+), 166 deletions(-)
---
base-commit: 5c8f90655a7bdb6232b2cea6503df16367b11a53
change-id: 20231205-iio-backend-prep-4d96ef364080
--

Thanks!
- Nuno Sá


