Return-Path: <linux-iio+bounces-26877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0FFCAB565
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF30F304A284
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD82ED866;
	Sun,  7 Dec 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPn+bVWr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0E1662E7;
	Sun,  7 Dec 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765114140; cv=none; b=p6KrPH1864yWPWH9Cp9WOdIT+0SHVNIxHP2uBASt0UVeeUMsPMe+iYskUzqgsBzS09FA6Fjwfvht5ndj5nAo/H23EMW+MMDn475ST8sUuSUUGpNBRmOcKBUgbYZRQDwhJo6D1zqaHvy0NmCQCOs5dOM6Nu+BrUFCwvDTQSQzni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765114140; c=relaxed/simple;
	bh=JxuxSBOD+uVmA4tthFiQuqKDxE+UGBvxxyYX/JBfRtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7cPwbV+xUuSzejYUmtpXh7pORju7pZRfU7b+hAzDAKr04IqPZrPp3s/JpL6oo5FUFNZojkNaQ6QLdegly4X+IEyULKAYBQ559L4ZFYDquPus749n32zhvg8wla6hZnLw3Wdd0/VWF5cAwMkt3t1rukxz11xIAKPHFbIOLE1GwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPn+bVWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B4EC4CEFB;
	Sun,  7 Dec 2025 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765114139;
	bh=JxuxSBOD+uVmA4tthFiQuqKDxE+UGBvxxyYX/JBfRtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LPn+bVWrxIDH9xaiFjZSLo4d4I1/45TGP+OZNS1qhIGhNE1QUH34KOckncRvUusgL
	 2B+hmA6Ys9z6vXzM6Lh6VCGxOy3nnUWASaZ+pagTQjZtTM9TTWNCGxG+kn+KLQdBJZ
	 9ttg7B60UauCu4IqcvU+Ars6eQzq4nlAgQmZHyZ73eSHxsnfs14c//tSe3Z/NuHV3P
	 l4aIjxXtNWRRyZwz44cNr4ud3EdUivbSRk5DvE82C0useNkTEb/R23qG0sQJ5C9V75
	 9rmIEk7VOE78BFkc8WHXZxt5Y5Vm3TVugcx20Ee5TWz3c7MC9VN63mXeJPDMDuQLdc
	 LtRFRQGbxYIRQ==
Date: Sun, 7 Dec 2025 13:28:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3 3/3] Docs: iio: Add AD4134
Message-ID: <20251207132850.1b0f8f71@jic23-huawei>
In-Reply-To: <aTLQxIGc5jMgQnnx@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
	<69b230190abb4cd76ad9eb25e2bde51caaa23d9a.1764708608.git.marcelo.schmitt@analog.com>
	<19d5c51d-41f3-446a-aced-5be2fe6ec0d2@vaisala.com>
	<aTGpgEFew2vP1CTG@debian-BULLSEYE-live-builder-AMD64>
	<49465e36-882c-41c2-a8bb-3c2e87bcdfd7@vaisala.com>
	<aTLQxIGc5jMgQnnx@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 09:32:04 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 12/05, Tomas Melin wrote:
> > Hi,
> > 
> > On 04/12/2025 17:32, Marcelo Schmitt wrote:  
> > > On 12/03, Tomas Melin wrote:  
> > >> Hi,
> > >>
> > >> On 02/12/2025 22:55, Marcelo Schmitt wrote:  
> > >>> Add initial documentation for the ad4134 IIO driver.  
> > >>
> > >> I wonder is there some information in here that is not readily available
> > >> in the device datasheet? After all, isn't idea with this file to
> > >> document peculiarities that are not easily found elsewhere?  
> > > 
> > > You are correct, these docs are mostly from data sheet info.
> > > The main idea of having the doc is to make clear what peripheral connection
> > > schema is currently supported.
> > > Because AD4134 is both flexible and somewhat extensible in the way it can be
> > > connected to the host, we could have different wiring configurations, for
> > > example  
> > 
> > Thanks for your explanation. My humble opinion is that it would be
> > enough to mention in the commit message for the driver being added, or
> > in the device-tree bindings that basic I/O mode is only configuration
> > that is currently supported.  
> 
> Okay, I'll drop the docs from v4.
> 
On this: I only rarely request docs for a particular driver when
it gets really complex - particularly when the ABI might not obviously
align with the terminology in a datasheet.

For other drivers I've always taken the view that if the documentation
is clean and potentially useful I don't mind adding it.

I get Tomas' point here though as this is very light so maybe a 'not yet'.

Jonathan


> Thanks,
> Marcelo


