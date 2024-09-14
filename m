Return-Path: <linux-iio+bounces-9588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA0A9792B0
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 19:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DE9B21527
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 17:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB881D016D;
	Sat, 14 Sep 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFaYjgMg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F777406D;
	Sat, 14 Sep 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726335201; cv=none; b=nDiznd5N75wbyI108euVJJ09Oh5XNQz+P0t90BqHdULnS60HRRkqR5w/b0u4/ubdRpUalVALpnGAu/EHRccvW6y4JfN/Yt5iPfoON66JcI8SwQPl5JFU0iro3z/LJaNLy8OgjIaflTB0BVaL4cWu65VXY/Ax3l+IZ7xQZBYp4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726335201; c=relaxed/simple;
	bh=cetAwkhvp5TSlmbUx62rW6bRUIkYn5XmDXnwPI2lsS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ku1VESGWJoUzkKudEPbhjGn/lm8YkHkd9lYRI9r2FD1PlVdR47W8kDCN5MoTItbwMAuMe7V+oYVrb4Xp8wVceUOpBqBWUEMf3RzsJnMht/2QyKJGSl92+woMNgO6l2dtBef6CcashDqjiHn67+N7LceC7QYTHjVkmTGSlQhA2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFaYjgMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27515C4CEC0;
	Sat, 14 Sep 2024 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726335200;
	bh=cetAwkhvp5TSlmbUx62rW6bRUIkYn5XmDXnwPI2lsS4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFaYjgMgf1Im8/KD22UwAvSGr6SFUKzMQHCgSnwroxyNC8ouhLs0m3eH8SBTW5qK5
	 /PXMc2fAAiQ+S0jIzstxHrsgZW4hL7a1JxhmIajninPzBbEntrnUEnSsT6+F+S/SJ0
	 CKWW5EYhwmw06Xo4ilHlmYqrzU2oXIIqM7qx+P/7kYXALCYf/rzj5AN0/nSGUtXuSh
	 ROm3Nt98YFcxvaIe2X9TXKAWzhDr0JKCMEVavINf8NSPFZEBVX9GSnv3IBgLoEw4+h
	 V3Nhiwf6021NTnTOsBqmwyZfU1xLTBSjbht1GziDzOhgLAYN7GyMkj7PLpgmT/fqnh
	 WDSYpxJp6DWEA==
Date: Sat, 14 Sep 2024 18:33:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: light: ltr390: Added configurable sampling
 frequency support
Message-ID: <20240914183313.05d4f7af@jic23-huawei>
In-Reply-To: <CAG=0RqL7y-Dmi6nAibkGOr32ufmMHS=pGjgp_7Er_oBTMqEszQ@mail.gmail.com>
References: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
	<20240910045030.266946-2-abhashkumarjha123@gmail.com>
	<20240914144402.16486b79@jic23-huawei>
	<CAG=0RqL7y-Dmi6nAibkGOr32ufmMHS=pGjgp_7Er_oBTMqEszQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 22:57:24 +0530
Abhash jha <abhashkumarjha123@gmail.com> wrote:

> > Hi Abhash,
> >
> > A few minor comments inline and an (optional) request to cleanup
> > the mask definitions in the existing code.  
> > >
> > >  #define LTR390_PART_NUMBER_ID                0xb
> > >  #define LTR390_ALS_UVS_GAIN_MASK     0x07
> > > +#define LTR390_ALS_UVS_MEAS_RATE_MASK        0x07  
> > These masks should be converted to GENMASK().
> > If you don't mind doing it a precursor patch to do so
> > would be nice to have.
> >  
> Can I do the mask to GENMASK conversion in an additional cleanup patch
> at the end? The patch would clean up stuff related to newlines and such.
Doing it at the end is fine, but remember one patch per type of cleanup.
So if you have whitespace stuff and genmask, then two patches.
> 
> Meanwhile I would use GENMASK for the new ones
Perfect. Thanks,

Jonathan

> 
> Thanks,
> Abhash


