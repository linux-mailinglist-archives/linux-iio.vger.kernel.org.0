Return-Path: <linux-iio+bounces-17315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 999C0A74FB1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 18:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE97D188CB55
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B226F1D54D6;
	Fri, 28 Mar 2025 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="FG80R3/X"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2611C8FB4;
	Fri, 28 Mar 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184138; cv=none; b=t0Uq3BQe7WRfowgzEzAWvR02TbniEeJVGHwLJ7axKm1Qa8ar23x9TDITHro9Ao+WKE6kWMROLuuZI8T/M8/FPUGHexdJfheySeIW3ZQbsx4YSuNhAodY8xwYwJDpYKxcp0Dr2Fz1+HQ9cF8M6fScFcwDCh/5+8QeuqBGLrnBItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184138; c=relaxed/simple;
	bh=xOhwYyFo9ZXlh9ZVDAow9mou4lmje9CvxJMegBfgmyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQ6LIG4uedpEDY+Hwz8ZGmRkGs5IT+yoVDUYG/lw+YSpAWwbNp8aDnmE1eN+lXXfIajFLyapWO/CcUlK7QTopwJOQF4VB5e0ZOm09SxrpXk5Bp14Ap/9gZGitHoZ5A2D+NOq3+8WgrevhBicdRhg3b5BkNJqVtTMRm20n6S6Tvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=FG80R3/X; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPSgp3gfXz3xFV;
	Fri, 28 Mar 2025 17:48:54 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPSgp2y4lz2Sd0W;
	Fri, 28 Mar 2025 13:48:54 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4ZPSgp1Vk4z3hhTs;
	Fri, 28 Mar 2025 13:48:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743184134;
	bh=xOhwYyFo9ZXlh9ZVDAow9mou4lmje9CvxJMegBfgmyA=;
	h=From:To:Cc:Subject:Date:From;
	b=FG80R3/XAGtTrcUwkymPKbx4VPv9sbenK4k4GjUM6HPgC7pNdoYtXfNg5i+FfFPvt
	 Lw5dMC63MN7xteP83WfvvV7UzJNdST3SLNWINwbQ4Q22xcpkmLjmFiwpU8bWIFjMqA
	 T+xEv2WQLJGBYhoDHkWykptGrn1eK5sYuA7a1EahmV0/PxprQj+PPFtQA/1yfPkaZp
	 xSG9e8Y3FNAXUMXEF1/ke+0PFZdo9HgmbZXkrtcPSXX55Ygc0L4xEPfZ6o0E19OzvW
	 vNQyTs0McpjZ9xbYN1bApAEPGYd/dWH+xP6AWQmlhfD2T8IygJ3Z5o/Le/NYyWwtL9
	 LqMv/IkEsG58w==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 13:48:39 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	sam.winchenbach@framepointer.org,
	bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: [PATCH v8 0/6] Update auto corner freq calculation
Date: Fri, 28 Mar 2025 13:48:25 -0400
Message-ID: <20250328174831.227202-1-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

v1: Initial submission
v2: Cleaned up wording of commit message
v3: Add DTS properties to control corner frequency margins
v4: Fixed wrapping
    Added maintainers to CC
v5: Remove magic numbers
    Break out patches into features
    Small coding style fixes
v6: Converted dts property from hz to mhz
    Removed blank lines in dts binding documentation
v7: Updated author/sign-off address
    fixed patch path description
v8: Added missing Reviewed-By tag in v7

Brian Pellegrino (1):
  iio: filter: admv8818: Support frequencies >= 2^32

Sam Winchenbach (5):
  dt-bindings: iio: filter: Add lpf/hpf freq margins
  iio: filter: admv8818: fix band 4, state 15
  iio: filter: admv8818: fix integer overflow
  iio: filter: admv8818: fix range calculation
  iio: core: Add support for writing 64 bit attrs

 .../bindings/iio/filter/adi,admv8818.yaml     |  20 ++
 drivers/iio/filter/admv8818.c                 | 224 +++++++++++++-----
 drivers/iio/industrialio-core.c               |  12 +
 3 files changed, 202 insertions(+), 54 deletions(-)

-- 
2.49.0


