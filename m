Return-Path: <linux-iio+bounces-3950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FBB892CB2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C1D1F22769
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6A3FB8D;
	Sat, 30 Mar 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onY0+uGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3123D0D2
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825744; cv=none; b=DtLPpyOftlQSxj+ZVZBF5R05CSUBqhUiIMDN/FOxWVY96TH2nPpDVFUr3VK0qLNDyQ1RK3W51xncwY75QqhNXRWOATCV1qykxNgg+AYn9sGsy4a0hncYeQ0qmSR2Kodd0+A8AFplzVqWVhISP/MqPRL/Q0TYaqBRFqbuEUqh184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825744; c=relaxed/simple;
	bh=yRTBcwVXckJQ8yXbbcqo8uEk/JD9wgwpQLVNHdF9TwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6IOcPTUkPthy9bPNufCSCwJwBPmUmDf9iKoj8lMCsHyjt0vP63Bbqrm4bYRRoEa40SfIcgFbhBs/LVEPkwYeT2vsQgvLkHME0nhcfHSvhmkEkS/1EdLbDPxD3+09F3dRVZ/xNWhpemGyU+OufIcsJUbBvMIC/IyZUc5YA0s99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onY0+uGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A08CC433C7;
	Sat, 30 Mar 2024 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825743;
	bh=yRTBcwVXckJQ8yXbbcqo8uEk/JD9wgwpQLVNHdF9TwE=;
	h=From:To:Cc:Subject:Date:From;
	b=onY0+uGtxAXcum5O/xi/IgNuuF1QXz+/IUu4BF47TPFAtaT5kPvPtde36ft2IFzSV
	 m3MKyzSD0eiGU3WkAG00grQ3tVEcmsXBEwpslKIZbGLv/Ss8i4Aka7SFddD+bs/AJI
	 qJYuOCJaIwVysGcuDsTJxqEfjxH/o7H08VNpz129NQEXViu99GMIT+Zl2fOX74m1al
	 q6ET+Qe4pfpJomzp7oDZwUN9oIimk9JuKL+zmIumPMZFKwq7xpTP1QqYRGs066Qy9T
	 WZ4Dtw+9HgZpfsQYYu93OROkl2m35NGssFb0cCEFu1Sv8Fw8AG32mniMAYDdcUH3XK
	 +8q7Cyb1V7puQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] IIO: More use of device_for_each_child_node_scoped() and __free()
Date: Sat, 30 Mar 2024 19:08:41 +0000
Message-ID: <20240330190849.1321065-1-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Mixture of new code that entered in parallel with the original conversion
set to use this new scoped cleanup and cases I missed.  Note the
relevant code didn't make the 6.9 merge window but is queued up for
6.10 in the togreg branch of iio.git and linux-next.

Includes allowing easier building of the ab8500-gpadc driver to enable
testing the changes. Seems a sensible change to make in general.

This series is making us of the automated cleanup introduced in
linux/cleanup.h and new device_for_each_child_node_scoped() to avoid
the need to remember to call fwnode_handle_put() in early exits from
loops over the child nodes. This can also be used for simple scope
based cleanup as seen in the ad3552 patch. In general this makes it
easier to avoid a common class of bug.

Jonathan Cameron (8):
  iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
  iio: adc: ab8500-gpadc: Fix kernel-doc parameter names.
  iio: adc: ab8500-gpadc: Use device_for_each_child_node_scoped() to
    simplify erorr paths.
  iio: adc: ad4130: Use device_for_each_child_node_scoped() to simplify
    error paths.
  iio: adc: ad7173: Use device_for_each_child_node_scoped() to simplify
    error paths.
  iio: frequency: admfm2000: Use device_for_each_child_node_scoped() to
    simplify error paths.
  iio: dac: ad3552: Use __free(fwnode_handle) to simplify error
    handling.
  iio: adc: pac1934: Use device_for_each_available_child_node_scoped()
    to simplify error handling.

 drivers/iio/adc/Kconfig           |  2 +-
 drivers/iio/adc/ab8500-gpadc.c    |  8 ++--
 drivers/iio/adc/ad4130.c          |  7 +--
 drivers/iio/adc/ad7173.c          | 24 +++-------
 drivers/iio/adc/pac1934.c         | 77 +++++++++++++------------------
 drivers/iio/dac/ad3552r.c         | 59 +++++++++--------------
 drivers/iio/frequency/admfm2000.c | 24 +++-------
 7 files changed, 73 insertions(+), 128 deletions(-)

-- 
2.44.0


