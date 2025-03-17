Return-Path: <linux-iio+bounces-16993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812AA65D5B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9291894035
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726831E1E1F;
	Mon, 17 Mar 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBUaAqNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E191DDC2C;
	Mon, 17 Mar 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237746; cv=none; b=Xk1VQluYnXk9ZkKjXvltiWZiS9E2kGfeKOlTJIvlWj7RBOluKZscNevy2sEvzvCeaYCtyZEzkJn4sK5GA7R54O9tr6NYKHP0Xb3qZxgDhUDnIugZU0OaIoW3Oiu0MdJ5dmac6odVf56fCvS7V/a7tpFiXpEt6CZqW9zrMlg9x68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237746; c=relaxed/simple;
	bh=UBSgKTFL1pCFuUwk9CpwgabxBS+GuDSaPy6E3MS1gVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxTsuvji71aS7CitHNPz43c3E1bpgGwxe3BfGUJQoIm9JIQGpoei9MWPkBqUTVRyp/jOFuyzZpfArZR1PB75v/iVkqFEMkclQsHm2afn+cwtMYocLqwvAaGBtRO46JeUzJtrPdqzpbEKaz6jyXFcwig9wKl+HA8BshDgicQZy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBUaAqNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C45C4CEE3;
	Mon, 17 Mar 2025 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742237746;
	bh=UBSgKTFL1pCFuUwk9CpwgabxBS+GuDSaPy6E3MS1gVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aBUaAqNRiVr3vCE4c8v2VOTJ240MG0+F8pEW7/FtnoHijksbNEEKv2fl+pM5dzdzF
	 NJnukCASsqmBJrtrJTgbefHsupjUEXmDhg3JMSEYKYnHpfMgB70NsIGcWMhl1z8ucw
	 yxwcsfgWOFku6LrcFmnd+wuzMMkOA4p2LjHEntfDSFwqm5pmKtw61jLCO9QAMZh4aE
	 vSfVyU5sDVC5i0z6sH4sui0/Utd/N9T0aHxmX37DyX/ILiC4SkxEkd49tkoBnZw1R/
	 25nnuuT/ONvGCWcam3GRb0TXgCrpAN91/+1frL8JtBCb7pLjRuvcnf4YSz0yNt99VI
	 /RW5HpqLuu6RA==
Date: Mon, 17 Mar 2025 18:55:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 bpellegrino@arka.org, Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH v7 1/6] dt-bindings: iio: filter: Add lpf/hpf freq
 margins
Message-ID: <20250317185535.7d00444d@jic23-huawei>
In-Reply-To: <Z9g6tPqhAoTckFBh@65YTFL3.secure.tethers.com>
References: <20250316135008.155304-1-sam.winchenbach@framepointer.org>
	<20250316-sexy-tested-cheetah-c4a2f8@krzk-bin>
	<Z9g6tPqhAoTckFBh@65YTFL3.secure.tethers.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 11:07:32 -0400
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> On Sun, Mar 16, 2025 at 05:38:42PM +0100, Krzysztof Kozlowski wrote:
> > On Sun, Mar 16, 2025 at 09:50:03AM -0400, Sam Winchenbach wrote:  
> > > From: Sam Winchenbach <swinchenbach@arka.org>
> > > 
> > > Adds two properties to add a margin when automatically finding the
> > > corner frequencies.
> > > 
> > > Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
> > > ---
> > >  .../bindings/iio/filter/adi,admv8818.yaml     | 20 +++++++++++++++++++
> > >  1 file changed, 20 insertions(+)  
> > 
> > I don't understand. You got my tag. No changelog here, no cover letter,
> > nothing explains what happened here and why the tag is being removed.
> >   
> 
> Apologies,
> 
> I am still quite new to this workflow, and it deviates significantly
> from my day-to-day work. I mentioned in the previous patch set that I
> would like to update my email address and change:
> "driver core: -> iio: core:"
> I wasn't aware more than that was needed. Sorry for any confusion
> this may have caused.
> 
> In the future what is the preferred way to handle a
> situation like this? I wasn't aware of the cover letter feature but
> that looks like a promising option.

Either add stuff below the --- above as that doesn't end up in the
eventual git log, or --cover-letter on your git-format-patch and
put useful things like that in there.

> 
> It looks like another option is to add commentary to each patch.
> 
> I am less certain about your tag being removed - I don't fully
> understand that. Is there a way to preserve that if changes are made
> after you sign-off?

Once a tag is given it is up to the patch author to add it to the
patches for future versions.  That should only be dropped if the
author thinks there are significant enough changes to warrant a fresh
review.  If you do drop a tag like that, then the change log
under --- on the particular patch should clearly state why.
> 
> Sorry again about the confusion this caused,
No problem, takes a while for everyone to get used to a different
process. There are extensive docs, but it is still easy to miss
things!

Jonathan

> -Sam
> 
> > Best regards,
> > Krzysztof
> >   


