Return-Path: <linux-iio+bounces-26982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDBDCB1315
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 22:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03228315D2A9
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 21:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49530C606;
	Tue,  9 Dec 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki2RnHHO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E622765DF;
	Tue,  9 Dec 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315629; cv=none; b=rI777NFqq9V8cO/s2By/0XaRcOOGnoXEJ9BCQlCYt435S2LeQiwrDKnc6w3R8MvCeZE+VtXNyqDZK6SKUvRbm+8dB3TMldjzPbpI1hNp0/uODHbrdA9UheY7+d7kKcPnW8Khx8VzxgffsWu839tJ4SduIVh4o8eTyrMDj/rbQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315629; c=relaxed/simple;
	bh=HYg5qtK2RrVekZ8CSxcTYW2Wt/Jq8GaxKhmpa9fyvjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyoBXPDw/dJLs0KiWAkVzRFHUTsRpYffeScknCRg1uv4GNyaf+3LGK8s1EL99T56d6pO64T7ptvPD/v4d3ui7Z4XkULE4PXE4oMSmcAf0YBDBtrSBzmilyA/s8QK8H1oA6kdxMstxDYVh0fTj/4tVCWvRdjjTbWYq8WfouEFsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki2RnHHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA47CC4CEF5;
	Tue,  9 Dec 2025 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765315628;
	bh=HYg5qtK2RrVekZ8CSxcTYW2Wt/Jq8GaxKhmpa9fyvjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ki2RnHHO8bgXDcSuRbVnVpGW5im/dNRVV4REGqdlvvmi8bInIPcvbbEuogmqiqDwt
	 40wBJYySX59MVDX/h6Jg+1jl3+xT2H+u9zQjpxjMnvrOZ8bL8ISQZhJfEpJ+uKvJk5
	 jOxOp7/OmH+awVLOJGa04yINlhx5JxemTBZkCPWFrXYaQ+/TTTcg8SIuF8//+f/sdj
	 4xr8emndl8bgQkou+f9CsaQDxuBGSNXbwozuUce2Vh62euAqZOEGBjeE+kRZPVzgLj
	 CY2JAIlyriEtABaJbfmxJTEWRK8TZkYRR9UKAFvU2Ez1g5OQrDmj/H3xuYTefCRPC+
	 RrZFG0SQw6fxA==
Date: Tue, 9 Dec 2025 15:27:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: wbg@kernel.org, s32@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: counter: Add NXP System Timer Module
 Counter
Message-ID: <176531562520.1163477.2854046215053918067.robh@kernel.org>
References: <20251208030413.3117660-1-daniel.lezcano@linaro.org>
 <20251208030413.3117660-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208030413.3117660-3-daniel.lezcano@linaro.org>


On Mon, 08 Dec 2025 04:04:12 +0100, Daniel Lezcano wrote:
> Add the System Timer Module description found on the NXP s32 platform
> when it is used as a counter and the compatible for the s32g2 variant.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../bindings/counter/nxp,s32g2-stm-cnt.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/nxp,s32g2-stm-cnt.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


