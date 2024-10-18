Return-Path: <linux-iio+bounces-10736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9039A4522
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 19:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777321F21612
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85366205132;
	Fri, 18 Oct 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMyMS775"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BE20493F
	for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273198; cv=none; b=mzbusqS0NT9KgYm04TfYo7vx5x2GN10UBe+E8hS2RNiuHF2T8C/HhK/hF/Qj018846ehlqVEnIk8Xm9ZblVx3KmVjvoqyvKppxww98UARcm1j3UVEXNrAQa8pfOzuoMUY2SrYkMphVv7RD31UnbC6DP5N3Ayy48kQNwesM/6i2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273198; c=relaxed/simple;
	bh=qwe+xloHIFmC4lc+195eb4EL+VtMY1Ddzt9x/RrTdfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJ8A3SqcYSb+gkZOCeTX/1sKmLMl+jNcSvrhrozm8Ij0kbLfhOZE168LLWNr7csIrvK7a5sSLQIv3uI9P/GlvGZ+ZULrbjWOm9WcRsrleOt/DHJw2KEuEU92FjXE3TbFja+Z+M1KUrpMmnptZ73B0ZN8dI4rJAgAo+37T0NGLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMyMS775; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1820C4CEC3;
	Fri, 18 Oct 2024 17:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273197;
	bh=qwe+xloHIFmC4lc+195eb4EL+VtMY1Ddzt9x/RrTdfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RMyMS775HtbAbK0bqv8BZmBbfkidToQq14pE+OcrH0bSe3jYTLo7txUFJD488elbH
	 imSovGD+8aFTm6cUDci/dKvaNn64TZfMkAvJnAJdRsvzej8NU+KUrGh2KSPlAko+lS
	 z1x5omzAuZC/DXoQ16jeZQxmBoKAITi5x5OARyYJ1ztZO5DFU2iIQQSWq0ltZdsOAA
	 e+jqy7OdiW05uEqjkEWRUa3dAn/TAQGu6Us4gGu3ks3WYSWgE/5zjxZ/NV42eKdeJe
	 Ou7TLmhvhazaA/ONkIAESc63sLjSGiBZtWKJEiI8DBCqft+wqBC6GBd1WOq5Kd7xDq
	 YUxPzBf2uLFYQ==
Date: Fri, 18 Oct 2024 18:39:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [Bug 219192] drivers/iio/imu/adis16400.o: warning: objtool:
 adis16400_write_raw() falls through to next function
 adis16400_show_flash_count()
Message-ID: <20241018183951.495a74fc@jic23-huawei>
In-Reply-To: <bug-219192-217253-rwqWCxPO3c@https.bugzilla.kernel.org/>
References: <bug-219192-217253@https.bugzilla.kernel.org/>
	<bug-219192-217253-rwqWCxPO3c@https.bugzilla.kernel.org/>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 11:02:41 +0000
bugzilla-daemon@kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=219192
> 
> --- Comment #9 from Andy Shevchenko (andy.shevchenko@gmail.com) ---
> This
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-6.13/core&id=b2b8a75e1d88c551a0b30d44d0be552210219eea
> one is related and may be used as an example how to fix that.
> 

Maybe.  Though not quite the same as in this case the code
really is unreachable. The compiler is simply failing to discover it.
We could but BUG() in all these places but that is nasty.

The series:
https://lore.kernel.org/all/20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com/

gives code the compiler should never fail to figure out, so
using that instead is a better approach in my opinion and
Peter Z just applied the infrastructure to his tree today.

Jonathan



