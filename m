Return-Path: <linux-iio+bounces-6217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637AD905A39
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 19:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F761C21D11
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FDD183072;
	Wed, 12 Jun 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnHzZj9u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1D20DF7;
	Wed, 12 Jun 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214718; cv=none; b=VpHCvTsh779++70fzHpa6ShFitKTACY1hDe06AR9qmTqscfpZe0MnOQWaZ9Lv91o5ieQ4XIwI/XVYz7t8kDiPQsJS/ZOs+YLGT/9HkXsJm6+TzgSye00Zyv0nciWdTE5MjT6QuSvfYtP6gaV4zT+6i3B+aKTXRptbKWnCpqM29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214718; c=relaxed/simple;
	bh=GXMOHq2P2oehyEINCQ6sMop0V6CFw7xgPbg6IOfzRRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I++skB99aqKSjkyoQlvr8gMztZa5VWTLgRlbhwswmS8/AjAQSolvPyn9tZULLIqkYnKEqJiGU0utNc4L0C2YUD4QAtqIB3SJp6MCpWU2BPvmFD/EPJxfZjCL/N3jFPg/ssN0RmBmNCBxt/ml0OSIHI2Rw7XE1BabcP1WlbKkcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnHzZj9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBB6C32786;
	Wed, 12 Jun 2024 17:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214717;
	bh=GXMOHq2P2oehyEINCQ6sMop0V6CFw7xgPbg6IOfzRRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GnHzZj9uYQh4LIbCVKnnC+cLgooqzhp2ghSUtsFCGYeUWpdylbDClZW+qP5iB4jhZ
	 yD6U9tzL89AqY8y8niCXVtIpu1IWFtKVdGkkjgGmO68OBpaVlrXv38TSbOJYzHT+Mo
	 RyArX9rfJrsyXWY7DFr4C3LturjCXYWM0YRcE80GJv630A4NsrlE6DamyGczwzHJQ0
	 g2IwTPmpHfwQkaJxpSd5kpi8KYCnGpda0ULMjmXt5IaQkzK50uqORj0sVQVuM+CpOq
	 jRXpKyoUfPat8zHdDvTVlWFufyCMjdj6CGFrkINfUSNoq9OBaRjSNUvj8pA7kDHanj
	 JdNNgnoUeF32Q==
From: Vinod Koul <vkoul@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Konstantin Porotchkin <kostap@marvell.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Josua Mayer <josua@solid-run.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-phy@lists.infradead.org, netdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
References: <20240602-cn9130-som-v6-0-89393e86d4c7@solid-run.com>
Subject: Re: (subset) [PATCH v6 0/7] arm64: dts: add description for
 solidrun cn9130 som and clearfog boards
Message-Id: <171821471028.586907.10718051314971795937.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 23:21:50 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sun, 02 Jun 2024 17:49:35 +0200, Josua Mayer wrote:
> SolidRun CN9130 SoM is a mostly pin-comptible replacement for Armada 388
> SoM used in Clearfog and Clearfog Pro boards.
> 
> 1. Add new binding for compatible strings closely matching the original.
> 
> 2. Add device-tree includes for SoM and carrier shared design.
> 
> [...]

Applied, thanks!

[4/7] dt-bindings: phy: armada-cp110-utmi: add optional swap-dx-lanes property
      commit: 4de480264948cbf2b08a72c39ee122a9f9761e03

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


