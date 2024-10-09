Return-Path: <linux-iio+bounces-10371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D9996D69
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 16:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D782B285FDC
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DB19DF66;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM3EvqLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E71925BB
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483405; cv=none; b=aXD6bed+g5fOLHYsz4X9Dri6COdoxl9ID2VAGxwVHdXHZ7ervEc8toUlSLVL1/9puIW/uZqz78UWaYu30w+kJ0NkPlnrLQI5JoiaOGRBsa+ShIQTeXl23PMx+nXB9iZnsurIIi7bkpZ3htbGRptlDZKnJFBhnAIXiaH5UzO28W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483405; c=relaxed/simple;
	bh=6iYbHzhTYiF+evAJ/CrJLAYhxN+1XjEyn9X2cWlcS28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AfbWlM2JvoD1bdVzymmmjpmwH2dTpSkWKvxv5l97otz+ogS5z09Q8pJbXzCbMQ5DIiiRCxFDlT4wbxX8lpKYA0/40L0rfp03JLDzHxTuewJI+rU4gq6ykOq0MkfLaJJB2oi8YarkkStpJYEoI/Ap9Ghkh8sxkudhPrT4U6F1BCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM3EvqLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C53B6C4CEC3;
	Wed,  9 Oct 2024 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728483404;
	bh=6iYbHzhTYiF+evAJ/CrJLAYhxN+1XjEyn9X2cWlcS28=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LM3EvqLJ67YP9WJZwHZ/1ZDyBiK7/rh8t63NOuqTPr3eTc+een+q7d+3vtkvGBPLQ
	 /EcydCtS0xkmYSY3n8ams9RllprPD2ETJGoLwJMenob5OBg6az01BZ1OVYWiC0JRT/
	 8a4rMzIAiY3Xd4lSL932zgBO8//NnRe9Sd0jpHTOx2z3OtSDUmmIyOe8ZUKCpnKAMt
	 yiFPnEYzy5Gp8gs5ph7feVHylCLOaIxMbm+AwtRLLuQMu9Oj3YWkp4/iBtK2lPtzJ0
	 MZCQFVI1EaMgcwZ57rEYNx6rVqDTbdwRowi4FVkPDO8wtNiSthz/EBlhRn44MT/9sK
	 kncK64hg9CDMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C2CEDD9D;
	Wed,  9 Oct 2024 14:16:44 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/4] iio: frequecy: adf4371: minor improvements
Date: Wed, 09 Oct 2024 16:16:42 +0200
Message-Id: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEqQBmcC/x3MMQqAMBAF0avI1i4kKopeRSyC+eoWJrKBIIh3N
 1i+YuahBBUkmqqHFFmSxFBg64rWw4UdLL6YGtN01piRPTI7v3XtYPmUEJXlvDRmxgD0Dq5FDyr
 5pdjk/tfz8r4fwm/O1moAAAA=
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728483403; l=596;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6iYbHzhTYiF+evAJ/CrJLAYhxN+1XjEyn9X2cWlcS28=;
 b=xHENApoV7M48S6XGMBjcpMZNwuXrocUYu6KUpxcM4YCR94O+M3onSFBoQELNYuadNzIkP7Hs1
 7aklNfcZTbrARy152RUwLB/NSGtLmPq7cSIJzDeTUAfxiQRt366GPbo
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Just some simple and minor cleanups.

---
Nuno Sa (4):
      iio: frequency: adf4371: make use of spi_get_device_match_data()
      iio: frequency: adf4371: drop spi_set_drvdata()
      iio: frequency: adf4371: drop clkin from struct adf4371_state
      iio: frequency: adf4371: make use of dev_err_probe()

 drivers/iio/frequency/adf4371.c | 63 +++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 31 deletions(-)
---
base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
change-id: 20241009-dev-adf4371-minor-improv-e7ee6aea3e6e
--

Thanks!
- Nuno Sá



