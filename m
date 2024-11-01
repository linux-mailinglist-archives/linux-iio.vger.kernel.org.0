Return-Path: <linux-iio+bounces-11739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D139B8AC6
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 06:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843A31F226C5
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 05:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979314A092;
	Fri,  1 Nov 2024 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVh7VB2e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088F36B;
	Fri,  1 Nov 2024 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730440765; cv=none; b=CIjM47FwZQEuC5l3miRqtySz2132VNm5KiaXRsShdDBexWSKsOymXqW52RubnV/ZEJiWdYA+oSPj28uzSBUT5vdDd55poFGirgRAzQUiwPC5onNytuH66imC5KPxK2L65P5wJkBPamKjWHRVkYdIe7YMOWmTnzwRuOfJ+mtsfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730440765; c=relaxed/simple;
	bh=bsORacs+XRwGPNAegb+drBs5u+8UfBOTbC/pTO7y+6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVm/Hyc1ZWBOGRKMZ/tPAj8ogg7bma9fKPIKkYqVLIA0gKDsT9DOyuBMbbP3a+bJv+ssxLr+JdQ/0sZG8cdKA2Y3cw7HpMkYiWTFV35GNBXHOeLKiY7tBesxke985o3ns+NLVH5OVre/1e8woRh71F15+FkNY9qG/NbXWKAS2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVh7VB2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FBCC4CECD;
	Fri,  1 Nov 2024 05:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730440764;
	bh=bsORacs+XRwGPNAegb+drBs5u+8UfBOTbC/pTO7y+6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVh7VB2enHZJz2ft2TzPQ6heULNsJCk/uXeTpmnaSnRpCSLN3C+NK1iX/bEEpFt6h
	 2W87GxwcpSE6QV0JhzJLL4ZPyLIxWmPUk7IrZ91GhE+SvdErRpmR/bKPeYJBzVWBSF
	 5nmnuQ13mIjRxAt+KZj4/QkjkcQmspvZyLu7/XXJPbnJHrzicUmDx00kFnWxVUVJj4
	 LSTrz3fUPlaveJozHNHqe0b/UlpNOBQKepLyfu944Z3dH6lAnjZYmBry1ulIq0rRON
	 sLVHcMBAgmPa9jd5wnj5e9StQtSQNO+qIdFGgclPRPr1SvHWBeC6itjriO85bJDkOQ
	 tbuAf+2fGkghw==
From: William Breathitt Gray <wbg@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: fix device_node handling in probe_encoder()
Date: Fri,  1 Nov 2024 14:59:18 +0900
Message-ID: <173044055547.648361.10787383264184720457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241027-stm32-timer-cnt-of_node_put-v1-1-ebd903cdf7ac@gmail.com>
References: <20241027-stm32-timer-cnt-of_node_put-v1-1-ebd903cdf7ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=wbg@kernel.org; h=from:subject:message-id; bh=MbN8O+C+5FEujeJNUwaWgYqQSEexIAnJ9ZIqUSvRh8g=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOkquc+e8rirfDxrXaT1uHa6lYSF0KIjb/autf6fMKMth bvYJflDRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRdxMYGTamMhRzCfX8PB7v sq/R65r1lmq3+ZazZ4n3fSt9cnDGV1tGhpurmXXXnq+9fmCXyx7J5mUT/63wM+6aqJei7HLGaEV JIAsA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sun, 27 Oct 2024 13:26:49 +0100, Javier Carrasco wrote:
> Device nodes accessed via of_get_compatible_child() require
> of_node_put() to be called when the node is no longer required to avoid
> leaving a reference to the node behind, leaking the resource.
> 
> In this case, the usage of 'tnode' is straightforward and there are no
> error paths, allowing for a single of_node_put() when 'tnode' is no
> longer required.
> 
> [...]

Applied, thanks!

[1/1] counter: stm32-timer-cnt: fix device_node handling in probe_encoder()
      commit: 147359e23e5c9652ff8c5a98a51a7323bd51c94a

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

