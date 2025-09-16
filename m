Return-Path: <linux-iio+bounces-24126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44490B58DB4
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 07:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B591B21533
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 05:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5ED2222B4;
	Tue, 16 Sep 2025 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXg8ZZ/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F124678F
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998864; cv=none; b=pBZO2w3Ls3EQpRDTHHNLhV6th9NvgOiyyO7SGL0lvFut2WoDucGxQNwSMLv/W4RCa0U2YQhnjamFoZTtDzVwWCUDUCuCPTnPcFaoEDFKbKGBHC+UpI2rjSqThFwYxPXsTL5vfzOOqC8jjzDW92v8XHG1QUgmpVxX05H0IFnOuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998864; c=relaxed/simple;
	bh=4ZKfcZcOQvmqB/WXxImyKXEXiqrMooD2CPqrBlij5PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VS3BrwBaM45F4M/5kf5HXojyptCnpLzsc2lh5qLRHaaAbgJjITmcPdTKBdVvSgWdH0WFcpwf/CoNF2vLFFksR8UZaFxW2pVkvnbN3fa8dQEfAa0kqaqOBj4aoF2+cP8bojDjFj+NvesmyPWcA/XcUP6/yWFU6h9Uj2KWmLaFFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXg8ZZ/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A1FC4CEEB;
	Tue, 16 Sep 2025 05:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757998864;
	bh=4ZKfcZcOQvmqB/WXxImyKXEXiqrMooD2CPqrBlij5PY=;
	h=From:To:Cc:Subject:Date:From;
	b=FXg8ZZ/nsE5PvF8sovcujjKX9WbPkcdGdoP+2/MaSUyT+LlkAkr0eFDTWRb12ZvOe
	 +pI7yCrzk/UhqwDplR8RRJOtxu0vMn7odiWk0fBZiPwy1caffD3OWBSTBEfGDWqOWy
	 zwp+CsxEaoEytKoup9FGYcF81AVxHERXILzLFaJ/Zl+JtMO+0IQlHzSGaaLqwjd+H/
	 gDPnqJEJZcglwim4SQiUXtQ7yavf5t7VXGB4DFbA6eid0HGPgJI9B6M7m2UHLQ5rMs
	 /NhymGNiD6CPF9rALIQUbp7OuFpsSp/ECk9TkMTZZrbGGVAlOXZqEmq/43aG0/tpij
	 eKlgajajHlpJA==
From: William Breathitt Gray <wbg@kernel.org>
To: gregkh@linuxfoundation.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [GIT PULL] Counter updates for 6.18
Date: Tue, 16 Sep 2025 14:00:53 +0900
Message-ID: <20250916050056.1399921-1-wbg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=wbg@kernel.org; h=from:subject; bh=MDtfzuuAg5/wr3chp/CoK9tz5wKvIzd3BKPDBBx4/D0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBkn3n3sCJn6NsNqSyrf28sLPi2PvpagbG4Y/eW+q7/8Y 6Pk73qtHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBErogz/Gbj6n6WFLvaQKsq 6k1WWcvH8IPaXrsaZdiX+1xN7tjxfjrDH75Qc9WfTDaOEv+Zclk+LnRxY19ywV3ulbas4eFD29R +MAIA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.18

for you to fetch changes up to 51548c36b37d0e84bd43a5f20bcbc36f70e61c5a:

  counter: ti-ecap-capture: Use devm_pm_runtime_enable() (2025-08-24 17:02:03 +0900)

----------------------------------------------------------------
Counter updates for 6.18

Includes a cleanup of the Counter subsystem sysfs attributes
documentation component_id list to alphabetical order, and replaces
superfluous error handling code in ecap_cnt_probe() with a call to
device-managed devm_pm_runtime_enable().

----------------------------------------------------------------
Waqar Hameed (1):
      counter: ti-ecap-capture: Use devm_pm_runtime_enable()

William Breathitt Gray (1):
      counter: Alphabetize component_id sysfs attributes Documentation list

 Documentation/ABI/testing/sysfs-bus-counter |  8 ++++----
 drivers/counter/ti-ecap-capture.c           | 12 ++----------
 2 files changed, 6 insertions(+), 14 deletions(-)

