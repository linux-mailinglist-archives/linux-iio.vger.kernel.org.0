Return-Path: <linux-iio+bounces-11906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C4A9BC1F4
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 01:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D201F224B9
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 00:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005CC8F45;
	Tue,  5 Nov 2024 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h18njW74"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE69E23BE;
	Tue,  5 Nov 2024 00:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766272; cv=none; b=jJOgcIPn49HrOOl9FTSuDWNGu0G+GSmJ1YRIXgWcqLWf7GDB3V/ztM0qLPDxusYxWbf7p5pYUu2wTUnc6hCY+edcsuqRcrC+K9VhyD2gv2dTf1n2Ym7FDBowbmGesr0QHkxpAPuyy/+od3tHhYSUBVo2Scp79gfjzxwtn07Lsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766272; c=relaxed/simple;
	bh=N8R3fDb+9GoIdsgF7CbDktor2ZvxI5MJHHQBCkOSUKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uw7KG0sGLppATK+0yhZS1K4DFKpao5yLa7Wf0i5YLR2BzckbxCkrVz3rLmu/X2iCfMvVJ2sbhT2BXU9nhBVyZsZsCmN4+oUwFXMLD1BbCX+OsSrvyLtkRI0AjIIHY21n+Anpih12kfSZywTo+xyw3yzKo5HhqY/M0IM79m+Tymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h18njW74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436AEC4CECE;
	Tue,  5 Nov 2024 00:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730766272;
	bh=N8R3fDb+9GoIdsgF7CbDktor2ZvxI5MJHHQBCkOSUKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h18njW74apSBbpuu3iVuuWcC1ZiFx0DjnJ+pzstG1XBqh+B7rcZsaopjIjq31JtFn
	 vsAtNmmztKxPwOVJr1iu3+I3kxA4jFy1iTEZjlp9ghbY+uKyDpDsdcdUVUdCTR7AQW
	 fRHuKGhlFechFWqMyuyoJ5Y6gLR11hCoWQiHWzJZp6FN/T1yo8fSEZODEfzMsA0ZeU
	 gwifQ+9J0wV8+GqDH+DNQ5dFwBAmfeZzupjUVxejRuPWDR3wFaCwD36qEFnC74wSRE
	 O6u4vzsmS+xRpszSioj+qMc9w2HJAC/vPa0HT7yl434Hc0FfRbgeiwBZ5q/+ColXMg
	 sNFTAaRhZkfDw==
From: William Breathitt Gray <wbg@kernel.org>
To: fabrice.gasnier@foss.st.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	Jonathan.Cameron@huawei.com,
	benjamin.gaignard@st.com,
	gregkh@linuxfoundation.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter: stm32-timer-cnt: Add check for clk_enable()
Date: Tue,  5 Nov 2024 09:24:20 +0900
Message-ID: <173076612183.810486.12896037496953296701.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104191825.40155-1-jiashengjiangcool@gmail.com>
References: <20241104191825.40155-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=364; i=wbg@kernel.org; h=from:subject:message-id; bh=nKhWV0LJIFJnrRorwflUOkORSfdeFM5elQRc/M3KIUc=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOmaqbM2i1i967eSemS+2bPWLvMJp8JbmUXiklfit6n+/ rJyk25vRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRB1cZ/lnHeuTNYdCU+B6m zPnZOTviK2vjz03ri+7u60jpMmKbt4aRoY3ve67efcZv0WKL/Xa0v543a9690K4rT6OnOq1qe35 qChMA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 04 Nov 2024 19:18:25 +0000, Jiasheng Jiang wrote:
> Add check for the return value of clk_enable() in order to catch the
> potential exception.
> 
> 

Applied, thanks!

[1/1] counter: stm32-timer-cnt: Add check for clk_enable()
      commit: 842c3755a6bfbfcafa4a1438078d2485a9eb1d87

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

