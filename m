Return-Path: <linux-iio+bounces-16330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C2A4DA9B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC553B3765
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA81FF7B5;
	Tue,  4 Mar 2025 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCEw2nDV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43E1FF614;
	Tue,  4 Mar 2025 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084160; cv=none; b=R8+GnPb0qUoUiZNuKlL6o0Y0m3Tw0c6+HdElZO7bF48/56NN/0KY+32A5kDpVhhRIYGCmIF35wDNGseeuSZBTgVesdOWJObcjhozeFoFSMFgo52xEg9ZkjcrBU17ozQj7gk/+GD+zqXajMkoGgVLPWUOA3LI3nidqj827Aw9HVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084160; c=relaxed/simple;
	bh=EplWlSoRJA83AmlqX8c2hMFGp2dhjVihkkYBWa3OdiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAs4udC6/mvihVmCtC3vaEuMm9MYa1zB55tdWktKQs8kn/G1seEAIIyiYza5xERH1udqTyss7rpWaYX3QqmTeraxrlXTYKNZzy9ZzTSrLUl209HKhftFkNcmbxs/7EAE99VwnwQJlZnikXxhYUAmY5T54JOYyI04wYvR/cykOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCEw2nDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A307AC4CEE5;
	Tue,  4 Mar 2025 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741084158;
	bh=EplWlSoRJA83AmlqX8c2hMFGp2dhjVihkkYBWa3OdiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCEw2nDVmaMxddk+m0CxK9txDxc76pc+CXngQjvGIXPsu0HykeXtCHepJ6nX9feIX
	 HKFp+zbC3ngQmgzo2RAbfhObvVm+KSGUal7pEeGi/hTkg44iiNaF90pfa4lIKS3x6o
	 Qvv0rxoRcAfLjQraZH4FMzphDqWSBACDQ6AULldtUPt69f+9gV7aeP+3fhHZsYsS2h
	 c6NDfUovmdiz1WiidYCZqJX/3OcC4dMtOix2g19bY8lLJUzGVYCTHEX7VW+ia8uRW+
	 JTA+GJ3zSWBKsQQ4UrA8ekhsTQF1nLIgFUqjXDZl4SoNAY7OPAqXNudJCEdAeF8hVF
	 /NmyTeDsE7c5A==
From: William Breathitt Gray <wbg@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	alexandre.torgue@foss.st.com,
	olivier.moysan@foss.st.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix error handling when enabling
Date: Tue,  4 Mar 2025 19:28:42 +0900
Message-ID: <174108402893.227977.9200776572329997415.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224170657.3368236-1-fabrice.gasnier@foss.st.com>
References: <20250224170657.3368236-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=wbg@kernel.org; h=from:subject:message-id; bh=voCn1RjNuoiczOEdMALQZ3vX+Eb+fDa/WmXmEaBSPz8=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOnHru6brC/xqmPi2tDZG2b0cfjqJiZluXM5y1dI3N1vp uKiV7Kro5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZjIqkmMDCear2b9vbU4Ikb1 hO1OrsO/Xhd1LJvO3pB5sfEPz+94s4eMDG9Osugv4eVMn6adcZt1R4JAkaitr2HlzADdaZnVCh4 eXAA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 24 Feb 2025 18:06:57 +0100, Fabrice Gasnier wrote:
> In case the stm32_lptim_set_enable_state() fails to update CMP and ARR,
> a timeout error is raised, by regmap_read_poll_timeout. It may happen,
> when the lptimer runs on a slow clock, and the clock is gated only
> few times during the polling.
> 
> Badly, when this happen, STM32_LPTIM_ENABLE in CR register has been set.
> So the 'enable' state in sysfs wrongly lies on the counter being
> correctly enabled, due to CR is read as one in stm32_lptim_is_enabled().
> 
> [...]

Applied, thanks!

[1/1] counter: stm32-lptimer-cnt: fix error handling when enabling
      commit: 8744dcd4fc7800de2eb9369410470bb2930d4c14

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

