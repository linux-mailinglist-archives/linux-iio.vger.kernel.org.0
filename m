Return-Path: <linux-iio+bounces-15589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D1A375D8
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A7A7A180F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298DA19AD70;
	Sun, 16 Feb 2025 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZvIVB6P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240D3D6F;
	Sun, 16 Feb 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723926; cv=none; b=EzujgRdyVzyXbf3uHAFPPgtM+/JNihP5jo7s0z8k6KhNKT7w/W5CAwl5LoOGQuht4B+LjsCPZepWxckXfCr6nH1hcRhXcswrkm3JAlqwqqXlwajgja8Bh8BgYgaDPaT6/wmakapiWpwZ0KuvPrge65wYcSJHWyD8Uw53Jcx6aaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723926; c=relaxed/simple;
	bh=CPcswU4WAs4lHkUIrx1fyYu9o5RBDOL0AwGQ6So+GZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4SWsXuX66qBgcghtvhoVjViKS7ye46IeuKKKNh0XQgZ8kfDOkTGhFqu1hUX9psIMPwtSBDYb2xtva9YD60F3YdKY8afyzPYTfEeNfg1XXZPC07I7EEIywp0j0MxMSJiGNCr93Ikh3VWFeUcngsxCAuReZmR9Q90ECcbdfl1OgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZvIVB6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F2FC4CEDD;
	Sun, 16 Feb 2025 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739723926;
	bh=CPcswU4WAs4lHkUIrx1fyYu9o5RBDOL0AwGQ6So+GZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rZvIVB6PD+6FkOCioPmoRbv3oKSU4FgqndcGU+aBrD7WPbfgStZiMMJAXOiqtfIIo
	 qbV7JNm8a8UBJXd/j9G5QaFezao6fanxQhBX4tZbSuUnV1oSgVpXM2x2izQ0lY5lEn
	 CzExczXdufA9ZhpmW1b6uBrLZdjPRPYgYY02G+eAi6cag0tGUfbOoy6EYCrGF9kWWp
	 o3NOploiINup58CI1tBoV5xxQ4nEFZQkS+TM4vo9UbBdEf/cQOe4T8qv7iHGxW2vGX
	 CdLTKSFSSIZKqGdMnnKYGbxZD5PtdOmms3NTQiOr1hMM+/24/Yy6sCjPpveBPUNbxn
	 d5V6wYQYCe+Ug==
Date: Sun, 16 Feb 2025 16:38:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bo Liu <liubo03@inspur.com>
Cc: <dan@dlrobertson.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: accel: convert to use maple tree register
 cache
Message-ID: <20250216163839.2055d5e1@jic23-huawei>
In-Reply-To: <20250212075223.4164-1-liubo03@inspur.com>
References: <20250212075223.4164-1-liubo03@inspur.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 02:52:19 -0500
Bo Liu <liubo03@inspur.com> wrote:

> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Bo Liu (4):
>   iio: accel: msa311: convert to use maple tree register cache
>   iio: accel: bma400: convert to use maple tree register cache
>   iio: accel: bmi088: convert to use maple tree register cache
>   iio: accel: kx022a: convert to use maple tree register cache
> 
>  drivers/iio/accel/bma400_core.c       | 2 +-
>  drivers/iio/accel/bmi088-accel-core.c | 2 +-
>  drivers/iio/accel/kionix-kx022a.c     | 4 ++--
>  drivers/iio/accel/msa311.c            | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
These are all fairly small register maps so I doubt it makes much
real difference.   Still there is the possibility these get copied
into a driver with a much larger regmap, so fair enough to tidy these
up.  Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take a first look.

Thanks,

Jonathan


