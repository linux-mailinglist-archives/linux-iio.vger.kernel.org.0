Return-Path: <linux-iio+bounces-16418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304ECA50036
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2109F166B2C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA60024A04A;
	Wed,  5 Mar 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="e9S6GSgm"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-15.pe-b.jellyfish.systems (out-15.pe-b.jellyfish.systems [198.54.127.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA3F24A050;
	Wed,  5 Mar 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180285; cv=none; b=kKLdAm00+QzKgY+aPkhOOMGbkOEPGAEg31z4+lSHXVXRJFi28/ctx8HQByRi+JU0p09fuukNd0AQ9iJ+MRxrbiiBzoKEw3gy4dK21Qj1dIeOkQr2OVf46qSr+QY1NbG0OxLBKh3RZFkg4/WGCHifCI7Bdk+FCoKrPnOjdmu+qlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180285; c=relaxed/simple;
	bh=bn2SYnO3gckSd90IJUDXZ+6sjtoSbjkeP7cZhFpzYOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwcUtHCPUCtF564fPDPVHsDIw8aI74gS5oWpPrFs3W5XGQ1beVa1GFZmPXPcJ2b0LjnyL808N8NSTALrQlEE/msohPRZt0MBNMxTXEC9Cf2gojQ44RrGJUN6lWRZK2lXLeu445icWYqPIyrh3AiWGWneBStCor4GcrBRLkJdFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=e9S6GSgm; arc=none smtp.client-ip=198.54.127.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z7CcB6stszDqTW;
	Wed, 05 Mar 2025 13:11:22 +0000 (UTC)
Received: from MTA-14.privateemail.com (unknown [10.50.14.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z7CcB4sBvz3hhVZ;
	Wed,  5 Mar 2025 08:11:22 -0500 (EST)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
	by mta-14.privateemail.com (Postfix) with ESMTP id 4Z7CcB4Sszz3hhZ8;
	Wed,  5 Mar 2025 08:11:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741180282;
	bh=bn2SYnO3gckSd90IJUDXZ+6sjtoSbjkeP7cZhFpzYOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9S6GSgm7JoUjS1VL9RQgTn6qPKd0B5YU9b0I5qqVO0seeAAOFsQ8mYd/cm60SlRz
	 kf5Yt8lZlFgLuRYq2o2mCuwTWiLqxDrT6Iw6FuQb5gTE5HV41ydw/8AQQJ3enz6VrH
	 wKSYBU26j8HzBvo9TZXilYa+Tp64Tr3jqRQ0m8ah+OPfW5YpBdlPneHVtpyijme6Ca
	 YnvLX3Q8eWXqD7n0pKAJCXqfWAew+rG+tiO/FWV6KkCHYSz42QONSghZu3ebucAz+O
	 aUn82ginSE+L5TgUPR8EpfI54b870Co5WZbaA0G6YY1I7EJmYAK7lwEnnbr12alIUY
	 YRwGqK0PUtRiA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-14.privateemail.com (Postfix) with ESMTPA;
	Wed,  5 Mar 2025 08:11:16 -0500 (EST)
Date: Wed, 5 Mar 2025 08:11:17 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: Re: [PATCH v2] iio: filter: admv8818: fix range calculation
Message-ID: <Z8hNdR21h7b7V8Kx@65YTFL3.secure.tethers.com>
References: <Z7crV0DV1Fq7wE1Z@65YTFL3.secure.tethers.com>
 <20250304233411.3fac7c69@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304233411.3fac7c69@jic23-huawei>
X-Virus-Scanned: ClamAV using ClamSMTP

On Tue, Mar 04, 2025 at 11:34:11PM +0000, Jonathan Cameron wrote:
> On Thu, 20 Feb 2025 08:17:11 -0500
> Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> 
> > Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
> > the ADMV8818 datasheet
> > 
> Hi Sam,
> 
> Just a trivial process thing.  If you are sending updated code
> and there isn't an obvious reason why when someone looks at the
> old patch set (e.g. no reviews asking for changes etc) please
> reply to that.
> 
> At times where reviewers (such as me on this occasion) are running
> way behind they might look at wrong version otherwise.
> 
> Jonathan

Hi Jonathan,

Just to clarify, if I update the patches in, for example v2, then I should
reply to the v2 email with the new patch set?

That makes sense... it looks like I can use: "--in-reply-to=<Message-id>" with
git send-email.

Sorry for any confusion this may have caused.

Thanks,
-Sam

