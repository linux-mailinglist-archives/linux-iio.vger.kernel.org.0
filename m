Return-Path: <linux-iio+bounces-19786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7845FAC091B
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03928A272D0
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3BD287504;
	Thu, 22 May 2025 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RevpVodL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533018027;
	Thu, 22 May 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907637; cv=none; b=N/G4/r7M6YrYqjpU8FD20yfI5/lxevvC+ks8Uu6AsiPX+iB+z4cZKUHIroD8IfEagc1dV+ZBPV5lZG1UJHFa5UaJfkfMi49asQiR/98jA6Oqrn9v4lXJpwSTy3ROzFF5LC1KSRf2JylGSuZbDKKIoOnikg5TYhDz/jhcNkaq8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907637; c=relaxed/simple;
	bh=T0pbowsOjTPIPmPLHltgm1guTj5BuJMB/woFP9FHf2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUoja4TjZnwKd+/pxEC+QQN34e6LRZlGEapZnl+VTTt/bleImHF6z1PIDSj+N681QTtBX/R2CZkn9wN+oEJp8ryPVHoBG5iL/HupFNkaZXk0mK3fdOtSPbAzNzUITV6LLgEFDCjGz1WDHI+zKE3NM0CIyIY+XXDpBWtL9JZfixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RevpVodL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9711CC4CEE4;
	Thu, 22 May 2025 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747907636;
	bh=T0pbowsOjTPIPmPLHltgm1guTj5BuJMB/woFP9FHf2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RevpVodLJXvQ0wS4ohgmz+wxoibCLUyT1275uRa6QccMU+8LK1bt6ZpQjjvBEvKnf
	 c49Huy+IAD1uiDKI/VlGR1afy/itNlkQ7csiD2VnwOkHbzL3v0mCUBDsowNBIfuWAG
	 UC97AHv1x63ukf7b6uARgSKznbyJ2eG1o3lilPdqxmxSPfQmIWjeTjmgcuy4Qzscrm
	 ACtfsMnd/TMYzawjRjEnfr5Gp59D9f2seXtsEHfmiRvv2zYVCXSTaJ3bTxembmvJ3V
	 cw7G5l7JeN7yIIXXkX81T1iwgbLU7VmdisGZyKJxIjSFkceAp/rTDvxJ6vb4dGqxJa
	 ZrNJezcfwwrig==
From: William Breathitt Gray <wbg@kernel.org>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Dharma Balasubiramani <dharma.b@microchip.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] counter: microchip-tcb-capture: Add watch validation support
Date: Thu, 22 May 2025 18:53:43 +0900
Message-ID: <174790756290.777945.12152629166611050360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520-counter-tcb-v3-1-4631e2aff7ed@microchip.com>
References: <20250520-counter-tcb-v3-1-4631e2aff7ed@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=716; i=wbg@kernel.org; h=from:subject:message-id; bh=FyrqgtuhplOt4MO8YUx+XOl66iMHGL1vISika9BhmV0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBl6XwSC4tMesbNKbmq4G8K5PaLweNfJJUlXvz3ZJ9/E/ U9pusmJjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiUd6MDPP2X7u90yKySKzG S9BX4eQRwXv+Z1InrWmrTon//ZrdaDYjw4xpW36f85+7XvDyNDvmhYcatELPqh66OLnf/23qvXS hPn4A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Tue, 20 May 2025 20:51:46 +0530, Dharma Balasubiramani wrote:
> The Timer Counter Block (TCB) exposes several kinds of events to the
> Counter framework, but not every event is meaningful on every hardware
> channel. Add a `watch_validate()` callback so userspace may register only
> the combinations actually supported:
> 
> * Channel 0 (COUNTER_MCHP_EVCHN_CV, COUNTER_MCHP_EVCHN_RA)
>    - COUNTER_EVENT_CAPTURE
>    - COUNTER_EVENT_CHANGE_OF_STATE
>    - COUNTER_EVENT_OVERFLOW
> 
> [...]

Applied, thanks!

[1/1] counter: microchip-tcb-capture: Add watch validation support
      commit: ae3392c0f12f179b969ce17856ed18bf8d69a35e

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

