Return-Path: <linux-iio+bounces-644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6716805AB1
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 18:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9671F218B7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912BA692A4;
	Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFBJcJZw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE369294
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C761BC433C7;
	Tue,  5 Dec 2023 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796005;
	bh=Z6m7V6uauT3XAM/m2JcBE3UhQDixSPX26LxJAiD6HYY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dFBJcJZwqP3uEkreMhqK8I1R6awiMNce1JRZN8u7XzXVKGruSLxQckMTVadv3QTxz
	 8xfgCNTkmec9CY3J8BEYYvz6MD6x4ZMBhkAA339oZ37iVt1tZ0jI+b0ltzQfrg9s/f
	 jit51ZHG+htWSeJQOmaGb8A2EaOxH+WxYaMAcvVZ7oPTYvZn3sm2EJzYhjwvvtd33n
	 VePRAV3KK0ta4rnbNU0/9sKUZmCaaTSZBljeNtagraztndwE5vDpCVEigKnP3upVkU
	 EVO1v/I0ZSzsyJYvx0zoQuglAelUrLIikLPUOp1OgoFyBLszJnT+IdFx9vCH82KT03
	 eXMDUczf2Xw4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE76C4167B;
	Tue,  5 Dec 2023 17:06:45 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/8] iio: ad9467 and axi-adc cleanups
Date: Tue, 05 Dec 2023 18:06:40 +0100
Message-Id: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKBYb2UC/x2MQQqAIBAAvyJ7bsHUovpKdLBcawlMFCKQ/p50n
 IGZApkSU4ZJFEh0c+YrVGgbAdthw07IrjIoqXSrZIfMF652Oyk4jIkiGjf25HVv5CChZlV6fv7
 lvLzvB35UaNNiAAAA
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701796004; l=1371;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Z6m7V6uauT3XAM/m2JcBE3UhQDixSPX26LxJAiD6HYY=;
 b=VlbZC4e6cgDtAp4q0MDk/dqHXshshs/cNj8qdEpMtpoJzXmuVqjvr/s+G8/aTfvnLn4kUNiiV
 L0nLfz5C8IbBR6HGjtkvu/3BqonarncV0zYPbgnRU+ioedDyoUwMuKN
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

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
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

 drivers/iio/adc/ad9467.c            | 209 +++++++++++++++++++++++-------------
 drivers/iio/adc/adi-axi-adc.c       | 159 ++++++++++++---------------
 include/linux/iio/adc/adi-axi-adc.h |   4 +
 3 files changed, 206 insertions(+), 166 deletions(-)
---
base-commit: 5c8f90655a7bdb6232b2cea6503df16367b11a53
change-id: 20231205-iio-backend-prep-4d96ef364080
--

Thanks!
- Nuno Sá


