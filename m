Return-Path: <linux-iio+bounces-6074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3E901309
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9EA1C20C9E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5779171B6;
	Sat,  8 Jun 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFI6/A6Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D31C68F
	for <linux-iio@vger.kernel.org>; Sat,  8 Jun 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867738; cv=none; b=Imso9E2lLgS+sdheTs1cG6ZmWqzInAPOaDvGXY9Ne8H4P2EZVIGbzPPrTKCMGxonUuzNOD4rydf+Opi/C/pwI19jBxJ9k67UawLun4RbQFtPxhLmWb6xxNNviUNGYJ9mNs5L4O9iHJIrntDj3ulyAdqCdJnH3W1H3HiqUIUPjyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867738; c=relaxed/simple;
	bh=9lGMkgEigBSAM0xiruEVy5FDKW/vErhTkQAiAJ7AFp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzD0fTBENdwEUHVW0cnp8qmOF9/+t8tD+7b/rOYslItko1ZJWHKarlkmekuiJF4KHZtSO1iQwDtomwKtTNy3ODYzO/3huYb9bt03ESxI2X+vCOWqwZHjykqx6f3tSe+w53QmlC3VrjR0yjkJCkYXrr2WRsRA15gV+d831fJvxfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFI6/A6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2924DC2BD11;
	Sat,  8 Jun 2024 17:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717867738;
	bh=9lGMkgEigBSAM0xiruEVy5FDKW/vErhTkQAiAJ7AFp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tFI6/A6QD67Ng6E34ddOcVNPGIbFe2hCynAwI6SeIzyZ6W7V4A6EYC88oymTQKY2w
	 a4bt8se3xPK3eL3zFTNZo9xxyF4aIsCVaa+VVa6qasxlzmKCe7vAobyGelxvjqfekz
	 SO2jU5OOQfyO7z/vl313Lekq9NEClUYgNim2A7gPHOOnIWC/VRjdVoAnBJhPF02c8Q
	 w5y2zzmQhMC8T7RG81JBBTSPZinKSXeijBEDw0n1bQxY0g/SMa1P5xwQCA51Sr/9PJ
	 lld4H5AH49TzAxxLdemUkGq2DcM+RUx01kaUNy7/EWQpB69VaZCVJwHHEuz0DQOhMW
	 duqFPQeG3a09A==
Date: Sat, 8 Jun 2024 18:28:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: add register caching in the
 regmap
Message-ID: <20240608182851.19ff7600@jic23-huawei>
In-Reply-To: <20240607081039.789079-1-inv.git-commit@tdk.com>
References: <20240607081039.789079-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 08:10:39 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Register caching is improving bus access a lot because of the register
> window bank setting. Previously, bank register was set for every
> register access. Now with caching, it happens only when changing bank
> which is very infrequent.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied and pushed out as testing for 0-day to take a look.

Thanks,

Jonathan


