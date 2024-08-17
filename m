Return-Path: <linux-iio+bounces-8565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8AD955907
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 18:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6043E282637
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF1D14D70B;
	Sat, 17 Aug 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adxck8dR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B8C440C;
	Sat, 17 Aug 2024 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723913366; cv=none; b=aYo7oQ79zTRar0d1CE5zpdEjemEuM+SIYsipVVwpmBBc1p/fVns+HryUR+dowzWqGjRIgy4b1MEWUcyjImxkK2JU5O/t8GMyp7RV4dJjBL6hKs1Uwa/g3vnhCaVsLmbxpBj2PauTs20FxsTKks7oHodoc8k06RzKiVqZQfysl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723913366; c=relaxed/simple;
	bh=vKjK79AAO94l3C0tIXGkDgmT0wGElhKGklOJGVNezqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXZxhJ5gGFosDKLESnQ9xvM/UH3xzBEF64AfepmGimJW/jndxlBfMfU0zqBwXfGSsUgAus0+CChZpBQlJSVKkM1vthuODDKkZGDNXSC5m59vvTzT+h1R+CkO0M+LO9UoLWF3CgTmmKJ4Y/RMo4vduLBmHkf5VHnF0nK3q9LX4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adxck8dR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA696C116B1;
	Sat, 17 Aug 2024 16:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723913366;
	bh=vKjK79AAO94l3C0tIXGkDgmT0wGElhKGklOJGVNezqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=adxck8dRmPpUtN/fzLV53Wusi/uA3VZOY0Ewx6Aq+Ip4I1rP8NbcU2gzhGh8Bydwl
	 HLxAUOrzNMhNKiHC8bZ4qLhUubrZxk+1HL1S+zRRdBa/Ql0SaP+jvawHwycN9giNys
	 e4OyzsYeJ0kjDTHX7fCJ+OxZf+W61RoY/ntAXu2rw59SPgCHWSvbCETd6Ud58CiSgK
	 8w8if3Iy1l7fO1EbjnmJe+guhQ48RzDHRuQQ5o6yZYKPylfrf3glAEQQciRgGwXzAg
	 1VP4n6l1lPaosEaIjtHJy0fJiUl4SPDWJ+AEM7jnEF3walpLWMDajs6aaebaxRIXOC
	 xaTs7PEs+pH9A==
Date: Sat, 17 Aug 2024 17:49:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Add light channel for LTR390
Message-ID: <20240817174919.5583f28a@jic23-huawei>
In-Reply-To: <CAG=0RqLaigoVLN2D9LEfC0_1ctJO6OzwEgpeOx8NQavB4mZxoA@mail.gmail.com>
References: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
	<20240817153953.1743e020@jic23-huawei>
	<CAG=0RqLaigoVLN2D9LEfC0_1ctJO6OzwEgpeOx8NQavB4mZxoA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Aug 2024 21:20:10 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> > This is v7 mark 2.  I'm confused, but I think I picked up this version
> > (Seems I'd queued an earlier one and not mentioned it on the list though
> > so I've dropped that in favour of this).
> >  
> Does that mean that you have picked up the patch 1/2 and 2/2 of the v7 series
> as well ?
I think I have.  But with two versions of v7 I'm not 100% sure which one got picked
up. I've pushed out now as testing, so take a look. 

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
> Thanks,
> Abhash


