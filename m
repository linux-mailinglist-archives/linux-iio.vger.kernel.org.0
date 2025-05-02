Return-Path: <linux-iio+bounces-19000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383BAA75C0
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5E51C05C56
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD9525745A;
	Fri,  2 May 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBRoSKR3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97967257440;
	Fri,  2 May 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198726; cv=none; b=urfXmCQ3+om6se/s6ebBkZ6usKGYHPZL58QXnt9TUrgCd2NP9C2VpQwqlb9NhlaexEawT3lRbnR9BzxD5WpjqHk2x8r4Rpb5m3Jnq6l3L+B6ZcDStp05nzYZQQkxXEYzwxpFrMy8VffzhlMmaEqQJxR1ZR/hfFfC4mV09Fy+LYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198726; c=relaxed/simple;
	bh=YejO4QjCqACnUWQ1i7GjVAxbUSM4Hmyho+r7bs0UWbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pK83P/I6St4vTi2eEXDLvO1Ko/gZnFJXBVoEQfq2/h/nNJ7Lh+7hoxgwdGtjtV2WFS4MOvpezEZ0DEoroi8xQ8CnMedgiPY8hupltDNeYNikfr+6rB3VFHH6L0oQdKe0vLCQhk43ku7qkhSIQP118g1FlbcFfVoc29QZW3ntlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBRoSKR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB06EC4CEEE;
	Fri,  2 May 2025 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746198726;
	bh=YejO4QjCqACnUWQ1i7GjVAxbUSM4Hmyho+r7bs0UWbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBRoSKR3LDZzUHtBLxoIIVd22crDVmW7Sap8wzZi5pkRHle6rE94wsLmF33nsrhGZ
	 NVSlLhmA7AwFYzUFUU0Pk2AuvN/cmh+dtwEQ053aAPGw74SN0yvekvI32OmFkGL2aO
	 c31NzcwoUFRbMAfIVZwRJFIBe49UjGCvHFJlgArfEJ3rvxAz8kvHhJTX26AbL3tDRP
	 Dk2zTSbRAmzCptlfOwOSIed6Q5PZeqROpqpZeBtYCWRWIAjh++mlHTD1Z5jSQajuWA
	 cLkhJUQwtoXUSEifILhiPLtvts6itrLkR/cJkl18HoZo/j4e1Ty2r3XE99JR1mosUR
	 5FOQSkEhXra6w==
From: William Breathitt Gray <wbg@kernel.org>
To: linux-iio@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: interrupt-cnt: Convert atomic_t -> atomic_long_t
Date: Sat,  3 May 2025 00:11:41 +0900
Message-ID: <174619859099.525726.7989189204506433091.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331152222.2263776-1-alexander.sverdlin@siemens.com>
References: <20250331152222.2263776-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=591; i=wbg@kernel.org; h=from:subject:message-id; bh=RQj68j5/cqpAUS1wZfBkcQLMNh+D78NS/Mb+GMNmC6k=; b=kA0DAAoWtUhWyr4SIysByyZiAGgU4HHIpL4xYI7YJoNAIr++AoFO0gqdmo7exGxAeHpfQw22n Yh1BAAWCgAdFiEEjTfN3eDSJSj46J+2tUhWyr4SIysFAmgU4HEACgkQtUhWyr4SIyt4QAEAhQyL qkWWN43ZTEKQGpxlyGCDYLN44XeaSqvqAcvzi24A/RihHFw2HTGhpqV7lwxUXYv9PtCjqovZCDE Yh0fHxkEL
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 31 Mar 2025 17:22:20 +0200, A. Sverdlin wrote:
> Convert the internal counter type to atomic_long_t, which:
> - doesn't change much for existing in-tree users as they are 32-bit anyway
>   (stm32/i.MX6)
> - doesn't introduce performace penalty on 32-bit platforms
> - provides 64-bit resolution on 64-bit platforms with virtually no
>   preformance penalty
> 
> [...]

Applied, thanks!

[1/1] counter: interrupt-cnt: Convert atomic_t -> atomic_long_t
      commit: 08e2a660b1601963ced37ac8e8d8c134a97f167e

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

