Return-Path: <linux-iio+bounces-21029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B5AEC7CE
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A162717CB8D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18377247291;
	Sat, 28 Jun 2025 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udFfWHLr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09671D7989;
	Sat, 28 Jun 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122114; cv=none; b=qVgwvz1hsL8IbTZq95wTF3Gb+Vp84dKuOEDf0OuRALUpeg+5MfDbQxMV+yjx4GahVgPDzcCcaa/9Cucb17t1cnGuVn/ZDc4u/A+sa455DmHOxqX2I9dHcy8YTanQ2k4MP2Jz+Ie66zSPwdxD6RJr+s+xzCLl6XR9ucgcnxZeIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122114; c=relaxed/simple;
	bh=9GNlcn1/ayU2Fno90GeMtMJ4Oah5/9o7XvQ5cqk7ETQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHemX+iybmkj0L8vxWBus2aNYlhH4Orb8NX6sLI2y40Qv2gi9APapgJR/hUMyWuBA3AczfIp/Ks4u1Svf3I+6AUSJUU6+zSH9RlVD5hpv1OGYxoKB/nAhCrss2tFq6qkWlo/8QiNV+L+tSyFPnFiaDViqEv6zvXk7YixGegTLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udFfWHLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA22C4CEEA;
	Sat, 28 Jun 2025 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751122114;
	bh=9GNlcn1/ayU2Fno90GeMtMJ4Oah5/9o7XvQ5cqk7ETQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=udFfWHLr6D+YWYNBy1oJysFnUQUuuG6no9ZyS4RfylI2P7nDbemNlxTMlDePhkR4P
	 ZfB8ElFUkP2FZGaU4bASrnKxUODvmQKrwT+Y/1yRIfVtBuR9IQdrU3hMYFJMm2SGuz
	 8Jeo6dXoakegu1clEY6+WrWI8pzxqI08VUHOdEn88pMBu1zVgvk06hfcXCe6S86MyX
	 l+Npbvkm+zuBbrciQOdcLe0clpI7MansYPMMglXyWHOWCYRKKLndtq73dHYI2uLOfY
	 aDQZRkE81grRP4AH8biduIUYEAvOmx3gdsAf26h8SCik7YKgOqhyPxZNzkzYHHeG/R
	 6xCoZcLUBBTtQ==
Date: Sat, 28 Jun 2025 15:48:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, andy@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
 krzk+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, robh@kernel.org,
 ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] dt-bindings: iio: adc: st,spear600-adc: txt to yaml
 format conversion.
Message-ID: <20250628154826.0c6ed66e@jic23-huawei>
In-Reply-To: <20250627-rage-oat-14141026cf28@spud>
References: <20250526-overtake-charger-6c5ffcc2bc09@spud>
	<20250626205733.6354-1-rodrigo.gobbi.7@gmail.com>
	<20250627-rage-oat-14141026cf28@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 16:53:24 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jun 26, 2025 at 05:54:01PM -0300, Rodrigo Gobbi wrote:
> > Hi, all,
> > 
> > Just a gentle ping here since it was already been reviewed.
> > If there is any other concerns, let me know.
> > Tks and regards.  
> 
> This is all I see here, a ping with no context is not very
> helpful. I have to go look it up on lore to see who reviewed it
> etc. In this case the reviewer in question is me, so you're looking for
> Jonathan to apply it.

Seems I failed to send out a message, but applied this back on 9th June.

Thanks,

Jonathan

