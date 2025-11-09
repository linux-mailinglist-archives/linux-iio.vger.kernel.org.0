Return-Path: <linux-iio+bounces-26096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39BDC44297
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4E0188A655
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA86303A39;
	Sun,  9 Nov 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhQJCjMY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9BE23E34C;
	Sun,  9 Nov 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706599; cv=none; b=OoVeBvW5z3vNYQ92xF4pmtlhoVxMPYJ8YW6753bes1RgewEVgUiiPe4L7AO2lHJN04VSx/3FX0fl+Nf7WoroPLjgMqQmpeNxOL80eCBe/IJlNj8sc4j6MU9VDdvMH9X7QZsi3olkYP1XbY45E0TnKocTlb4v3f7l5oDRvLgL6tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706599; c=relaxed/simple;
	bh=1J8JYYgKXAoshU1qHgu49EVuuxQuKHM8WpXI9qS0f3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vc5UxsKNTs+rF2CU6rhZdc+j1fWMh2hFrCK/jUuCmjRd2XOY54cDjdVdR1elvv9ZzZ0z5oa8+hicxJNadbHMpgUiNSHystl9z0awoTBvC/wEKVwcu+5uF6jx6FHw+YQ3eF4BtTcB6SsKOFWkN48twp0I5cYelSBtBU5GTLnu+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhQJCjMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B923C19424;
	Sun,  9 Nov 2025 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762706597;
	bh=1J8JYYgKXAoshU1qHgu49EVuuxQuKHM8WpXI9qS0f3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XhQJCjMYKJblTt5jqoCWN0vrmK1yXbWyMkp78U2zuGfZY9cQu0CYRPyUJqC1AYEqB
	 UH0DfCY9yk5SPHUeDIu3JTiAj4e5ISo8e5iQOBh3sd7VgZT70ZZglm+Xav/SPdX6lt
	 9gyA0UPD61F7DSDhuJSmc5bu6iYxJYynls76kbGTBiLzCX6OwwZS2R/kEkz0i8CgEp
	 fLy1lVSMIJiMz9yBILbmKPht5vITfuoElAr+2O+CKg3TrYpXzI4PRepWT0UdlzY+jf
	 sZmVPbZklgdWmbFH5OO9Q/Go+2DqBuHAhriA96i7dbel7tn7FeAULPHbi5RHnxdttY
	 OfoNgq3AOJ0cw==
Date: Sun, 9 Nov 2025 16:43:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Antoni Pokusinski <apokusinski01@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: ABI: document pressure event attributes
Message-ID: <20251109164312.781de64c@jic23-huawei>
In-Reply-To: <aQ1aJ2RNMXp9TXzY@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
	<20251105095615.4310-4-apokusinski01@gmail.com>
	<aQ1aJ2RNMXp9TXzY@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 23:32:07 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 11/05, Antoni Pokusinski wrote:
> > Add sysfs pressure event attributes exposed by the mpl3115 driver. These
> > allow controlling the threshold value and the enable state.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 352ab7b8476c..5f87dcee78f7 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
> >  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
> > +What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
> >  KernelVersion:	2.6.37
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > @@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_falling_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
> > +What:		/sys/.../events/in_pressure_thresh_rising_value  
> This is how it's currently appearing in sysfs, right?
> If so, IIO event sysfs entry generation might need a tweak.
Tell me more... Why might we need a tweak around this?


