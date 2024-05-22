Return-Path: <linux-iio+bounces-5172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C64FE8CC1A0
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822F62835EB
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A38823D9;
	Wed, 22 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY8bp6q+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A9EC7
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382447; cv=none; b=Eqjv3MYKTjAJOSeTpkZCI3fj9sysh4zpdN/LiWqNE9gULfgezES7aXkii8h1BDfF/Rfgk3jZxQrqJvK8bZ19mih5AvVf2+Q9cesVtXbD8iyrowJWcJf8CCDIwuTCoBEp0uVDkumAqRmBkL1JIlPLWAIh8xgo+ErVyDjWpMRwAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382447; c=relaxed/simple;
	bh=kHj/TPFy35RtWhBWLYKooLoEmYZNgnP3Fqp7BjpqzfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iXl4571UtZ3pCYY/3MR39iqSgaT+dL8XNb2aujOM3jJft7A66yQBSKSYtRbH/cWtoCzHBHgCO7P26wAyE/1rtMUEQnoQ3ikXoUBbPkPLYpMq3H9mrVqyNm4pF38LuS18oFlA4PcLVeWxMP8nEyLJ3wssWizua/Q62iiiNmhbxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY8bp6q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8F4CC2BD11;
	Wed, 22 May 2024 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716382447;
	bh=kHj/TPFy35RtWhBWLYKooLoEmYZNgnP3Fqp7BjpqzfA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qY8bp6q+CzGlsplBWAVesOAV6DaKQ/3fXMbrEUBEDXi3jB9oCYg8HAgJeb1NZ1z8d
	 psrdxrd2O9FxR4jAIOPPIof5Yz7MB9KxSUXOpFgI1/K82KO8rpgSR8MU0uvmpIkyJd
	 7G+3br7zjnyK4Tz1YI30DoxRJrraB8WcDPa5IFcRwmf/pqVeqRIf1gxHYv0Y5jX3fR
	 fqGJcRY0aoWQaVnvtngmKyZom3C2ncEcqFI0s0skfW4kUhHZznE9V8InMRILl0yajL
	 pwiSEmhuL01wMzK0K83B829TC+RWNiHkzI04S3VNXG9mcGGAssS7GUq67NwX21chO9
	 QKbEW4dm20WEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DCDC25B7A;
	Wed, 22 May 2024 12:54:06 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/2] iio: adc: ad9467: use DMA safe buffer for spi
Date: Wed, 22 May 2024 14:54:04 +0200
Message-Id: <20240522-dev-ad9467-dma-v2-0-a37bec463632@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOzqTWYC/3XMQQ7CIBCF4as0s3YMQ2mrrryH6QJhaEksGDBE0
 /TuYvcu/5e8b4XMyXOGS7NC4uKzj6GGPDRgZh0mRm9rgxRSiU70aLmgtmfVD2gXjS2RctbKwZC
 Denomdv69g7ex9uzzK6bP7hf6rX+pQkjInWnprnrFJ3fVQT/idDRxgXHbti/9de8IrQAAAA==
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716382445; l=700;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=kHj/TPFy35RtWhBWLYKooLoEmYZNgnP3Fqp7BjpqzfA=;
 b=bLdWrJIze+rV2cn+D5fGS1FdipIVf5NjI+TG1XhUXLOwxUfC0GzYpqGf46Y2jJWPUQZqaX4rf
 mNfMyqgY4pxA2LRnDpfnvQz1iLzYayNh+qzgrGFJ1Sn+i8nyVHwTo/1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Added a new patch to "fix" the annoying tabs alignment on struct
members. 

---
Changes in v2:
- Patch 1
  * Don't use safe buffers for reads (uses spi_write_then_read()).
- Patch 1
  * New patch.
- Link to v1: https://lore.kernel.org/r/20240506-dev-ad9467-dma-v1-1-e5c31b464e8f@analog.com

---
Nuno Sa (2):
      iio: adc: ad9467: use DMA safe buffer for spi
      iio: adc: ad9467: change struct members padding

 drivers/iio/adc/ad9467.c | 103 +++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 53 deletions(-)
---
base-commit: 5e3c5871138da700796587aa5f096d39135f9d36
change-id: 20240506-dev-ad9467-dma-3114fdd27c1f
--

Thanks!
- Nuno Sá



