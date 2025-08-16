Return-Path: <linux-iio+bounces-22807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D74FB28DB8
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCE217C79E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA62F2DE6EA;
	Sat, 16 Aug 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdDQ630T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D831E47BA;
	Sat, 16 Aug 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755347500; cv=none; b=FRb1iPOO777z3aI1UY3gvKJ0G7T6FlztTc4HDna2Qp8qM9vkXwctZLGzxvSJqb8t9HVmGxQQsYIVtDd0VlHfWUjy2myWZIfP1iKYJXuLVuW167QiM9AjpIw286CSeHAwLGl9fNVoR0vmAYpWAMUce7T3suGASWRKNsFncZGhVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755347500; c=relaxed/simple;
	bh=Uyu8AGQD7tviJj5ttherUblA2corBCxv8PLRJYuZiEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiZ67UKUCLJ2EPi23UVgxvkpsNAzj+sbnVD/z7J2W0wQ06mp/JpSIAXuSTGaIlkFvcVULBwQ1M5HZ1tM6kVkB9bguPc3+Axif0EgJxrn2d8Dr9V9EaO3nROpcW/kIso+b2ZAxhEw/G6+ZWx6P0C69c53xnQqlHeAmptdf6GIiBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdDQ630T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4840C4CEEF;
	Sat, 16 Aug 2025 12:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755347499;
	bh=Uyu8AGQD7tviJj5ttherUblA2corBCxv8PLRJYuZiEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EdDQ630TdexRmcN3u+ac1eskS7sZfR86XN1EV7MIVfIrqX2pJg8M+2F031fK48HOT
	 EAILdVz7qynKHby/Q6GNf6rf3hV+/xPZIGrARDAqCJI7SNtR9YSsUdDR6bvvQhRisk
	 gu8evagjtSBJNU4EAk5D4TrIgG58OOLAWYOUICSwP/rwZbRThAOBBaJSupLDeFa8v1
	 HxVE5diDzWv5pVciBE/2XVcIRB32mbtZnUJwA3bjWlEBeFR+B2NKjUdTjao95W95Xz
	 8igi6RxfGoUNCHg2m0SNjR9yzKZHCGwH6hxx4BTq6CCW93tgskbGPmL2tsgEkYZjEO
	 wmswMFCOK4BUA==
Date: Sat, 16 Aug 2025 13:31:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: adc128s052: Support ROHM BD7910[0,1,2,3]
Message-ID: <20250816133129.7d045d2f@jic23-huawei>
In-Reply-To: <ae976e31-78db-44f7-a3d7-b6178692401e@baylibre.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
	<e43c184fc6aa5c768045fc772b64d812fdb06254.1755159847.git.mazziesaccount@gmail.com>
	<014487e4-f8c7-42e6-a68a-9e984002fd46@baylibre.com>
	<3024c64b-48e4-4a28-bbab-b80cdaec4a9a@gmail.com>
	<ae976e31-78db-44f7-a3d7-b6178692401e@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 09:17:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/15/25 12:23 AM, Matti Vaittinen wrote:
> > On 14/08/2025 18:01, David Lechner wrote:  
> >> On 8/14/25 3:35 AM, Matti Vaittinen wrote:  
> >>> The ROHM BD79100, BD79101, BD79102, BD79103 are very similar ADCs as the
> >>> ROHM BD79104. The BD79100 has only 1 channel. BD79101 has 2 channels and
> >>> the BD79102 has 4 channels. Both BD79103 and BD79104 have 4 channels,
> >>> and, based on the data sheets, they seem identical from the software
> >>> point-of-view.
> >>>
> >>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>  
> 
> ...
> 
> > static const struct iio_chan_spec simple_adc_channels1 {}
> > static const struct iio_chan_spec simple_adc_channels2 {}
> > static const struct iio_chan_spec simple_adc_channels4 {}
> > static const struct iio_chan_spec simple_adc_channels8 {}
> > 
> > This which should be clear(ish) for developer no matter which of the supported IC(s) were used. But if we stick with the IC based naming, then we should use naming by supported IC.
> >   
> >>  
> Even better.
Agreed that's appropriate for this driver so do that rename as a precursor.

Given you get to choose the order I've dropped patch 2 for now. Don't mind
if that goes in first or this rename does. 

Jonathan

> 


