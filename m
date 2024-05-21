Return-Path: <linux-iio+bounces-5151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556E8CAA3A
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1024F2825CE
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2662D57881;
	Tue, 21 May 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPKtPo+N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C0535AF;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281186; cv=none; b=GTki7wN32NEfpzg1UcNaLo6GrChsz+yOEl7xxfm5GkUS3UwyGXgdhb+87IAcI9h/NuIZln+9DhwYb7o92yYmjrrCwa1sxbB3KxJ4d3FKAPCN6gHh/ONuOIswu6yKcr6VVrIbZIwiAtrZTFAmQ6fsc3SChGZt9gyrPVUsQYqHV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281186; c=relaxed/simple;
	bh=SiXMPzFyIkTEwRXRmeckMbEvLhH98lpRv9fx8PUHfMk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vw25HAqQH9sul6D9j0usamP2wpQgeTbkFCmzBZCIT2aw4bIHWWGuHZkKN6CHjwQe+FvblX51tMyd1OSIpBUx/sz2pgvbBwrLcOim8vbP7I4v2qae7ZlVJvAiGmhFprQgxb4i4wU0OgNnYTndG+X6XfOrFAHy2x5yGvZJ+dxDH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPKtPo+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A3D1C4AF07;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716281186;
	bh=SiXMPzFyIkTEwRXRmeckMbEvLhH98lpRv9fx8PUHfMk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DPKtPo+NQ6EiaAXn9qi3VobMhUCqq8vCW0ww6cQnhlpWrrcihfml3sBBJbe1YCZ/k
	 4spOMmeclpCAmyT2Wo20pOiZtu/PgUy35zJCHxPdDWYhe0CkU0qfI1wDPTUFiwl+we
	 ELNJf/vNLGc0LEMD+CEES6ddZg3S1LjqjLVyaui3HO51BgeTW+5QfkRjt+kGlO4meN
	 T15ZW6QLsFTU1XXHyP1tNIwmuoatbvf7yuXCT+wfO1o4ZhPmBodfEMGwDaaTV31y+U
	 BEqPFmd+c7sxCOgUtEmFI4Mef2qWd0Ckb01eW2df/012yUZA7KNh0RnAQXh57jSjOi
	 k6doOlg4+9ddw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D6EC25B78;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH 0/3] AD7173 fixes
Date: Tue, 21 May 2024 11:45:38 +0300
Message-Id: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJfTGYC/x3LQQqAIBBG4avErBN00oSuEi0kf2s2FgoRRHdPW
 n483kMVRVBp6h4quKTKkRtM39G6h7xBSWwm1my1Y6NC9MYPKsmNqiwYLujRIDG15Sz4Qzvm5X0
 /Vkpz3V4AAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716281184; l=743;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=SiXMPzFyIkTEwRXRmeckMbEvLhH98lpRv9fx8PUHfMk=;
 b=mbQ9Sc9j2q9NvpEcKkqyc2ZV88kcFbtvJ4v0Mzpc8nUEUSH8X9JiETPM2gregjT5H5N0Okut7
 ernOZyzGcYOBfoCpUAQEcIxKX+Xyi081We6W7WiBJEWO+tkb/uRldut
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

This patch series adds fixes for ad7173 driver that were originally
sent along AD411x series. To ensure that they are included in this
current rc cycle they are sent in a separate series with the Fixes tag.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
Dumitru Ceclan (3):
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: Add ad7173_device_info names
      iio: adc: ad7173: Remove index from temp channel

 drivers/iio/adc/ad7173.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)
---
base-commit: 5ab61121a34759eb2418977f0b3589b7edc57776
change-id: 20240521-ad7173-fixes-4e2e5a061ef2

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



