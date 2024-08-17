Return-Path: <linux-iio+bounces-8550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE10955871
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724721C208C4
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502411187;
	Sat, 17 Aug 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOV/NWqa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C79479;
	Sat, 17 Aug 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723906328; cv=none; b=ILkqrMYX2GTCfDPnSIntQ04KGCxxc+/nECIqYSy7Rc/si/PSpQEK5XkTHQkpfXkXuErwHy38MpKw6Yr1Uw/hKLAjNJ/DloAPEEwXXscFl1V44ymOckuuWcEUnHQDAuMEC2Bjo6KOClfEzElHcBAjxPDToC/sACyjqtyHB6Mjs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723906328; c=relaxed/simple;
	bh=MsQVmFGcGuxij1e/L/P08KYJH+oMHUUSyF75WH8K7Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC7LIXy8/N8pNTqAoJ2qsIQVf4GUiUrsyZmEn+BlRARn+e2t1OGUMafhu7YD7FEUAF0aADgs2wUpcOf2wr1JI5FvAJDOrNjpy9rRhnHq8YKw9kMtMeXjjkviVO2EqlKmNjmIF0+pBe//TzEWcUyJ4IRGJjSh2MQgq4+oBlqylhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOV/NWqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488C5C116B1;
	Sat, 17 Aug 2024 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723906327;
	bh=MsQVmFGcGuxij1e/L/P08KYJH+oMHUUSyF75WH8K7Ac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sOV/NWqah/PTOSufeNZBjLF55d7cBdOLVdVfgS0bN6w3LRhWrVnEB4J8pjK2CebIm
	 pbnh7UrI8ZB9K26E8DNmUMAB7LHbNIPcGljv1zixvR1+cme4OAD5saETDh8e7bxOsx
	 r2LX0ltrdVYr/0Qyr6P08/fwmtHzC9ZB8CEOvMfcjiW8BTrmV8ail4CnQIamqrYhTU
	 3Jl1Yyb94Afc1t796508n1E1fCMMjTU7C7fD4rf33pq89vRc1FdgE+IH2sx38lt8/1
	 QJGM4BPnBVK8oOYkkedilPi7ng6T53oy1AyKK3j2ntA/zrmTbJSZZLECFMtGf29GOh
	 RiJ+lzNMahuXA==
Date: Sat, 17 Aug 2024 15:52:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 0/4] iio: ABI: audit calibscal and calibbias attributes
Message-ID: <20240817155203.4525f9f3@jic23-huawei>
In-Reply-To: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
References: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:22:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> While preparing to add some new variants of the calib{scale,bias} and
> calib{scale,bias}_available attributes, we noticed that quite a few
> of the existing attributes were not documented.
Thanks for tidying these up.

There are some scripts about (I think Mauro Carvalho Chehab wrote them) that
scan sysfs on a particular machine and report missing docs, but we've
never put in place anything that looks at the code to figure them out.

Gut feeling, too fiddly to maintain such a script for constructed attributes
my maybe could be done for const ones with the standard macros
(so pretty much nothing in IIO :)

Applied,

Jonathan


> 
> ---
> David Lechner (4):
>       iio: ABI: document calibscale_available attributes
>       iio: ABI: sort calibscale attributes
>       iio: ABI: add missing calibscale attributes
>       iio: ABI: add missing calibbias attributes
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 64 ++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 13 deletions(-)
> ---
> base-commit: d505a9dc8de83df2a8ce8c9e780f7b29887f34af
> change-id: 20240815-iio-abi-calib-audit-fcc21b1c6892


