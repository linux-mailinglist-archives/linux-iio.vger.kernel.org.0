Return-Path: <linux-iio+bounces-17025-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9FFA6772D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 16:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E458D3ADF5E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92CD20E702;
	Tue, 18 Mar 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="Z8fAa0BZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-09.pe-a.jellyfish.systems (out-09.pe-a.jellyfish.systems [198.54.127.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33DB191F92;
	Tue, 18 Mar 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310046; cv=none; b=d5+XiU3BjuRXB67LW0pR3aL/WgMg4lOxf1BVg05UhRpFH64A9NXmHQueAvmXQl0F3voI6Kl4fYSs0MbnanrvqJf7DUkZzntQqidYf54utavBSJE/7uFUV96SS0A5UPJCldhRms09Gu3uBmPX5qB36hKg9PmnIH10GDB/NBBlsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310046; c=relaxed/simple;
	bh=27Pc74ha1MeynY0b4VpFjOnyMErp9nGgnqQ6z090Eto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdtopwrPSwdpMSHwIE1P0CU/HFFe/2BiNhyOaJ6LwJtky6iTK37ScfPw5fGTfcrExPj6I34pSWuZ+qeA041vKxE2fYS8wo0VHrB9qqHWgBUP6aetHDP8cvXTO3/wkJNOwjM6nngOtB7QrJTB3t545g3IRBb6XAxAfMxDb48IWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=Z8fAa0BZ; arc=none smtp.client-ip=198.54.127.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZHFQ86vvPz9sWw;
	Tue, 18 Mar 2025 15:00:32 +0000 (UTC)
Received: from MTA-08.privateemail.com (unknown [10.50.14.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZHFQ85ycJz2Sd0W;
	Tue, 18 Mar 2025 11:00:32 -0400 (EDT)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
	by mta-08.privateemail.com (Postfix) with ESMTP id 4ZHFQ849Ncz3hhVb;
	Tue, 18 Mar 2025 11:00:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1742310032;
	bh=27Pc74ha1MeynY0b4VpFjOnyMErp9nGgnqQ6z090Eto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8fAa0BZYPdG5FK5LYPp00BmnUwoEOFdxyC1NnulMuGjyHEhz5XlJ5F2tPFm+G8fV
	 5FN1GzBPy8X61zdkf+BkE9BtCeimzn0Gti2dEdKGR75d1w2sMm6EqnmLzyZwKkwngm
	 sulaLfXP6vYKSmlUrgyDz53ZMs+Ri2OmKQDC5qk619m6P1/xGn3R0SuZvA9koCEp+P
	 2XSELC/qEKe/t7azSFkJYHQal3l7OER1wHZfp8c596t2TzmLM3eeix4sa8DiK6sVGb
	 z4EzZAsn5Ph96L0hNIaTXkkJw1ExDC4ZllgDH69BB7mzvAOljkq4F2qOdAGXz/KvK6
	 sm5rBABRh8esg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-08.privateemail.com (Postfix) with ESMTPA;
	Tue, 18 Mar 2025 11:00:17 -0400 (EDT)
Date: Tue, 18 Mar 2025 11:00:18 -0400
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, bpellegrino@arka.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z9mKghgKk9vuHUyF@65YTFL3.secure.tethers.com>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
 <20250316-sexy-tested-cheetah-c4a2f8@krzk-bin>
 <Z9g6tPqhAoTckFBh@65YTFL3.secure.tethers.com>
 <20250317185535.7d00444d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317185535.7d00444d@jic23-huawei>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Mar 17, 2025 at 06:55:35PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 11:07:32 -0400
> Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> 
> > On Sun, Mar 16, 2025 at 05:38:42PM +0100, Krzysztof Kozlowski wrote:
> > > On Sun, Mar 16, 2025 at 09:50:03AM -0400, Sam Winchenbach wrote:  
> > > > From: Sam Winchenbach <swinchenbach@arka.org>
> > > > 
> > > > Adds two properties to add a margin when automatically finding the
> > > > corner frequencies.
> > > > 
> > > > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > > > ---
> > > >  .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)  
> > > 
> > > I don't understand. You got my tag. No changelog here, no cover letter,
> > > nothing explains what happened here and why the tag is being removed.
> > >   
> > 
> > Apologies,
> > 
> > I am still quite new to this workflow, and it deviates significantly
> > from my day-to-day work. I mentioned in the previous patch set that I
> > would like to update my email address and change:
> > "driver core: -> iio: core:"
> > I wasn't aware more than that was needed. Sorry for any confusion
> > this may have caused.
> > 
> > In the future what is the preferred way to handle a
> > situation like this? I wasn't aware of the cover letter feature but
> > that looks like a promising option.
> 
> Either add stuff below the --- above as that doesn't end up in the
> eventual git log, or --cover-letter on your git-format-patch and
> put useful things like that in there.
> 
> > 
> > It looks like another option is to add commentary to each patch.
> > 
> > I am less certain about your tag being removed - I don't fully
> > understand that. Is there a way to preserve that if changes are made
> > after you sign-off?
> 
> Once a tag is given it is up to the patch author to add it to the
> patches for future versions.  That should only be dropped if the
> author thinks there are significant enough changes to warrant a fresh
> review.  If you do drop a tag like that, then the change log
> under --- on the particular patch should clearly state why.
> > 

Thanks for the guidance - I see the part I missed:


"Both Tested-by and Reviewed-by tags, once received on mailing list
from tester or reviewer, should be added by author to the applicable
patches when sending next versions. However if the patch has changed
substantially in following version, these tags might not be
applicable anymore and thus should be removed. Usually removal of
someone’s Tested-by or Reviewed-by tags should be mentioned in the
patch changelog (after the ‘---’ separator)."

In my situation I made a mistake by not including his "Reviewed-by"
in the changes I pushed up. How does this work if no further changes
are required? Does it call onto the maintainer to apply the tag when
merging in the change set?

Is there anything I should do at this point to correct my error?

Thanks,
-Sam

> > Sorry again about the confusion this caused,
> No problem, takes a while for everyone to get used to a different
> process. There are extensive docs, but it is still easy to miss
> things!
> 
> Jonathan
> 
> > -Sam
> > 
> > > Best regards,
> > > Krzysztof
> > >   
> 

