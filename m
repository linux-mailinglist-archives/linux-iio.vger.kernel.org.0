Return-Path: <linux-iio+bounces-1033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2168161A3
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 19:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40FE1F21D5E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283445BFB;
	Sun, 17 Dec 2023 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cguza4eR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBD47F43;
	Sun, 17 Dec 2023 18:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9684EC433C7;
	Sun, 17 Dec 2023 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702838834;
	bh=0WiMr+EpBPy6ON0d1b9PZ4lky0p4EeKVusKd3t4UG9c=;
	h=From:To:Cc:Subject:Date:From;
	b=cguza4eRa/R8AH1aM5O9Lq214bVBxNY8cupK9NEAIio/kgLU7NrQhxwPeRCN/zuhf
	 HzABpRklYj0BRAtxHsxjJ8BiTeRW8UC4t7xaNSEMrUbMWmCHm8ZCOQ3/jVQKPp0162
	 mmj/iW+v3mE1pNMYgn75zHRKVNqb/U0E9vOogVn+73YRrJR+ieaT9i03a8PVzH1oWt
	 8I1BGe844cxii6jLz18hIshUpxKrIbaPHjWQLD0VA9apUfEtQYCR1sqXwUXFXtdaaC
	 HzS/2jzsOy1waFmifWghMdbSQ6Wm8yp5S8WG1BddynkMWN8u3JhDoyJyJJ2L1plgau
	 P9PQVDq5g/Nbg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 0/4] of: Automate handling of of_node_put()
Date: Sun, 17 Dec 2023 18:46:44 +0000
Message-ID: <20231217184648.185236-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Recent addition of scope based cleanup (linux/cleanup.h) allows us
to avoid a large number of places where error handlers and early
returns have to carefully deal with left over resources.
The need to call of_node_put() on breaking out of loops over child
nodes is one of these cases and this series is to address that.

I have a similar series for property.h which I'll send out shortly
if this one sees no show stoppers.

Jonathan

Jonathan Cameron (4):
  of: Add cleanup.h based autorelease via __free(device_node) markings.
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


