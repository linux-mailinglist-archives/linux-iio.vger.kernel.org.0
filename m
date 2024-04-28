Return-Path: <linux-iio+bounces-4600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0841A8B4D4A
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC601F2130C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBA71B4B;
	Sun, 28 Apr 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9y2wLOg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B48F9D9
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714326034; cv=none; b=kYjNF0sT3fxHhF/Jf+HnPDb682aD9JkgBrr7+Y92ODmAkTeVHN5mZXjshmiZIWIWB/OdF4D5vXq+rV/pf+cLvTE6wkZwRKYZL/M7OmaX17Gr99UYuOafkCFxycOL75Z/jslVS/pspe22WCerJOKX/krhmbK/f1xsCR3WK0eKKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714326034; c=relaxed/simple;
	bh=A274JEKMTg/2SuGlBZY7dgZfX5BuRrHClDKENV2JsIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbDJ/ZZ5CBWlh0+MNfSXRA8a/ANgOEJAIIltZe67XHPTzbiJtWqBV2WrC0rTif/yDM64mfEDKj9Hq4OYzoGfWgt0rykgi7J/+3T2+Vpa+75fdKKan+DHWPfIrfG3JecOgkmxq2xtFHvFLTzerVeRLhaeqtg2NmdE5fj6mmlADBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9y2wLOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD957C113CC;
	Sun, 28 Apr 2024 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714326033;
	bh=A274JEKMTg/2SuGlBZY7dgZfX5BuRrHClDKENV2JsIQ=;
	h=From:To:Cc:Subject:Date:From;
	b=V9y2wLOgAQcwp5chKgZfkpR3/JswNr+MEt/4AX7oVatGWRZkG3jiwLrlszKgzH/Lf
	 2FAC1niCZHSM+uuptyfR3od646iNskSaNl9rg/fcvHocXwXkn5nDzlwWbNLP43JNzK
	 2IyP6M4lhYIeh0Q7/VVW5m38DCfa5Ixf+Hx/ETn3gRAtc7JaaoUK3pKbWD7+AMM8hw
	 sgnAFNOATURr3VlBvgLmXAJrwDKItmlyiQdiLlAIpRgM46XwMbRvqlRaDi1Metv/95
	 dbNTFIdvLBmTU/N2K81jN6LAS+VaP0PdiScFUlseMBlDkXqH58vkZvnGCpjE5UnrRq
	 D/qHIoju78HRQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH v6 0/2] IIO: Use device_for_each_child_scope()
Date: Sun, 28 Apr 2024 18:40:18 +0100
Message-ID: <20240428174020.1832825-1-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looking for review of these remaining patches from v6.
Chances since V6 (dropped the ones that I applied):

I'm slimming this series down by taking patches that have been reviewed
but nothing yet on these ones yet.  They are fairly simple so if anyone
has time to look that would be great.

Jonathan Cameron (2):
  iio: adc: mcp3564: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()

 drivers/iio/adc/mcp3564.c    | 16 +++++++---------
 drivers/iio/adc/ti-ads1015.c |  5 +----
 2 files changed, 8 insertions(+), 13 deletions(-)

-- 
2.44.0


