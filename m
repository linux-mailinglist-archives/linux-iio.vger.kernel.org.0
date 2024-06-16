Return-Path: <linux-iio+bounces-6322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD65F909C79
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F011F21697
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E17185099;
	Sun, 16 Jun 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTV8msdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44D16A392;
	Sun, 16 Jun 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718526301; cv=none; b=b1BoO8IkepzF6OelwiCIiI2pNgySTaIVdhfo2JeV1zpUH3ENJI7ttKV20V/18haV1/ci1CmCbJ8biQonm4Ps9PfgMwArh50DxB7EoUBoI/r5KoIVevx5zblMdMY75O6/uqvr8amrq+wEsClGwbxcGSop6ScG8FUEZvcKfZMgmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718526301; c=relaxed/simple;
	bh=8Tgp/WGahnUFu+TyyKj8l731bhTgqzfkM5kbZre4hgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NoQZp7/JhIgxegHBOp5jDKR5a3NiynuLP60Gd8Gbt+5BY23mFvql33VkQRIJpPPLbK/oioGUzixfFOaXvBHA0ScdNioWSSkUeXFMJduYdABnSJU9mkzbXOOMGpZq0SpJ+6FVE/RcVFaXR92Cq92PbA5lQJlvArDVshZTgBE7GWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTV8msdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F418C2BBFC;
	Sun, 16 Jun 2024 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718526300;
	bh=8Tgp/WGahnUFu+TyyKj8l731bhTgqzfkM5kbZre4hgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTV8msdKI1lHfMIwTh0LzgVdynJddj53KlihQuvtQ436dRxehDMoGnmRct3et+EzR
	 NYgyhCVmZtYizelgHuqXPrzLom3J11MSL/tGV0Dvr2RpvDoCvO99PgpqnJMXqNkhFb
	 UaJ9eAejr6AGiVu8Dt1P7DjYgwy1LSMt3fqijzWTnFgv7SL6h2oI7qp7rK5jMOeHhX
	 vNCpyzp9NQnnfoCXHCw2SlcioIHHVP/wuDZLCnQTSgZvVSzB8DRmB1rLo8S6L1570V
	 tdO5IBWrfe8pDHk5Sr78fR2k2gdowWZw2KdmOOu/8sgcrVkLwscyQwPTAe4Xph+2dp
	 GU81XgmZrzu7g==
From: William Breathitt Gray <wbg@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ti-eqep: implement over/underflow events
Date: Sun, 16 Jun 2024 17:24:47 +0900
Message-ID: <171852622547.2476911.15327003731221678203.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240609-counter-ti-eqep-over-under-events-v1-1-74fe1632f5ab@baylibre.com>
References: <20240609-counter-ti-eqep-over-under-events-v1-1-74fe1632f5ab@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=403; i=wbg@kernel.org; h=from:subject:message-id; bh=XAiSDL7nD7/Uyl6WagR4gmOtftEcjiXUjBUgulwbuvY=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDGl5C52K1By/zEvVb+TOO/QjT9Fkhc27I4kVkqc9X78Q+ fvm1HuvjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiQscY/tmo2HEY2p688FdZ KeHlrXR3BZF404ntPwK/p91T2DijbTXDP8XGbPfwUPeqvBTmh/wvpYu4DF6+5miuEWJJnr9t1tJ p/AA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sun, 09 Jun 2024 16:49:33 -0500, David Lechner wrote:
> This adds support to the TI eQEP counter driver for subscribing to
> overflow and underflow events using the counter chrdev interface.
> 
> 

Applied, thanks!

[1/1] counter: ti-eqep: implement over/underflow events
      commit: 1c30c6d024726e2af2a5608474bf1fb6937f5740

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

