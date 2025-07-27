Return-Path: <linux-iio+bounces-22044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DDDB12FAD
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB77E3AF6E0
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE4886344;
	Sun, 27 Jul 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knIfK6ZI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97C11185;
	Sun, 27 Jul 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753622274; cv=none; b=X48a6ye/mLCuYLJAFmKSmszPNgIFgjtrKCsQkKwl+lscQzaEEASv26eTPEHpFaC5E+A1/5wcI6BEMSSxWZrBIPJPHyZzkE98pfnuK0PfTUJXWg5/GEiVWJW9/MvYHBZlA+ISFdlg6E26s2wv8vKUn56Gq0cpJEDM+xwwwGQc+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753622274; c=relaxed/simple;
	bh=Ewi1fJoa+3RaL6K9hz3hovDJ0r8XJ6e6lZU2BCWKQSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZ4N1//iwI3woGuAQFBnkPKGRCoIGUWl/6l/ozVq52DbaL9lbh7SPLRV2oK+m6YUo2u8ZRbit2havuWSWr55vRTjXEkI6Kc3M9tT/87oI5CGh+B3gwC0jpBdFZu/q9e0yhO4iQOKkeWO105cYs3px4t7fa2wslO7CvUjw4cFLYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knIfK6ZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187C9C4CEEB;
	Sun, 27 Jul 2025 13:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753622273;
	bh=Ewi1fJoa+3RaL6K9hz3hovDJ0r8XJ6e6lZU2BCWKQSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knIfK6ZIdE3I5j/ey4yWCAiCijgIhyy3RrQjbFacWetrI13ysnS3Qe/kdUDB/wxqK
	 yAN/hqgXmSJnkDhDheQBkmMdvS4vchcRG1tPwiKzIjIDU1/VlxKZvaoLZU59Va3Xox
	 vfJDPMDrxvSlhD+X8+6br3zlNmH6ZmkYu/ZMvAnqijTKU9pyLHA6xW+9cNRZSK7AvA
	 k/BrCKzOAXBpo00lwVkM2tYg457lNAVN7eXhzCwHfIRmFcnceW39l1kHOrtLccxNE8
	 xKw2+PmcXfaAv41faEt1i63a7CZecypwwmvZkOl7rQhmwXLD3e/6VLXnZRYi4Dov7y
	 +oSbzWsY/ERJw==
Date: Sun, 27 Jul 2025 14:17:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: add power and energy measurement modifiers
Message-ID: <20250727141746.6ace24f1@jic23-huawei>
In-Reply-To: <d292c93b-1ff6-43e5-9187-2ce851399bea@baylibre.com>
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
	<20250711130241.159143-2-antoniu.miclaus@analog.com>
	<1ead013c-56ef-4f11-afb9-2b11e0de7eb2@baylibre.com>
	<20250724140940.2d9b4a1f@jic23-huawei>
	<d292c93b-1ff6-43e5-9187-2ce851399bea@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 08:58:48 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/24/25 8:09 AM, Jonathan Cameron wrote:
> > On Fri, 11 Jul 2025 14:23:14 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 7/11/25 8:02 AM, Antoniu Miclaus wrote:  
> >>> Add new IIO modifiers to support power and energy measurement devices:
> >>>  
> 
> ...
> 
> >   
> >>  
> >>>
> >>> Signal quality modifiers:
> >>> - IIO_MOD_RMS: Root Mean Square value    
> >>
> >> Suprised we don't have something like this already. altvoltageY isn't
> >> clear about if the value is peak-to-peak or RMS.  
> > 
> > Hohum.. My vague recollection is peak to peak, but oops we should
> > have documented that better.  Someone want to audit existing drivers?
> >   
> >>  
> 
> I did audit them (which is what lead to the Q/I modifier cleanup
> in the ABI docs). Most drivers are just using the frequency and/or
> phase components. The ads1210 uses peak-to-peak (I should know, I
> wrote the driver :-p). The envelope-detector driver mentions high
> and low when making an altvoltage_raw measurement so that sounds
> like peak-to-peak as well. There are a couple of frequency drivers
> that also have altvoltage_raw, but I didn't look as closely at
> them.

Cool. If you have time please send a docs update.

Thanks,

Jonathan

