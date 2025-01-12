Return-Path: <linux-iio+bounces-14250-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07617A0AB01
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75A33A3BF2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F211BEF67;
	Sun, 12 Jan 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs+RNQ/N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90020DF4;
	Sun, 12 Jan 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736700130; cv=none; b=Oido57wFPTIBoz56cQOlaX7CoFSw4AA6hQeNtawMCN7FOkglWJi5pD9VM5H5z5RupdaynU8FIjA7QAewstwBv2Pmj8sVEqlW7mjngGyo19PIk+DlF/0L9l4sWSCpRPfkmdE7D9KSgyC3sSRxFLkOaIRmnqZ9q6UZBxoeZvZ+DKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736700130; c=relaxed/simple;
	bh=MFsCSIQ+3lX2JGCMn69Y7qKryOUmEQrQYiScE1Suxks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3ZHfmiWpyoHWWzAdoWNjmssddTAkTjJLKz+pHgXs1TbrgYKY9dtwJC4dc8C0e9Gu5Xzr4Nl3ws4GqbL5EtmKKNWFeNR3dA7RwjzmcYY/zpxzqNpjz35dOdXzRf3xWzLuG++384CIn0TF2jVerKWKMsLSmyL4zFxKcNlFPj3i1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs+RNQ/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBB0C4CEDF;
	Sun, 12 Jan 2025 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736700130;
	bh=MFsCSIQ+3lX2JGCMn69Y7qKryOUmEQrQYiScE1Suxks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zs+RNQ/NWvd8ZcOhNy76P2L9TlRbE2yKE90yBnBouIKNHQ/+Bod2FfJzSnRmq6/bA
	 twMtI4yywmlX9amdPCbnop5p4OlA54WJ5F++VY7TiTsPdFUdppjxIZOPXvG2B2byG6
	 7By7gsokjYG1XH82TODX5JAwP9Pm8BsvwQ1t5Z+2raI2Daps1OzRJ3adXZTp4Nnv3c
	 4iDVdMwopQ4quEILVuzAU0Am2DiKkiZjEqdLIT7I+IIqGjIlgkuXhd0lC3sm+V6V64
	 fcTMog01kZVozh9XQJuo29FJF1vydIN0Jdnveg719gKEuBQWKl7V0RQzUaMzX0ifNy
	 X/Ims+5kZ+S2Q==
Date: Sun, 12 Jan 2025 16:42:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/5] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
Message-ID: <20250112164201.067ecd9e@jic23-huawei>
In-Reply-To: <Z4Pt9oZEkfQMuYUm@surfacebook.localdomain>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
	<20250108-ad7380-add-alert-support-v4-1-1751802471ba@baylibre.com>
	<Z4Pt9oZEkfQMuYUm@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 18:29:42 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Wed, Jan 08, 2025 at 01:49:33PM +0100, Julien Stephan kirjoitti:
> > Conditionnal scoped handlers are turning out to be a real pain:
> > readability issues, compiler and linker handling issues among others so
> > rollback and remove the scoped version of iio_dvice_claim_direct_mode.  
> 
> Is it IIO level decision or you as a contributor to/maintainer of this driver?
> If the former? can you add a Link to the discussion?


IIO. Agreed a link would have been sensible here.

> 
> Otherwise, I would like to understand the common approach / practices in IIO
> WRT individual drivers to deviate the common approaches. Jonathan?

Patch series on list ripping the whole lot out that has some more explanation
and links.  Basically we never found a way to overcome the short comings of
conditional scoped guards.

https://lore.kernel.org/linux-iio/20250105172613.1204781-1-jic23@kernel.org/

Jonathan

> 


