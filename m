Return-Path: <linux-iio+bounces-15929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B510CA40811
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B919C63C1
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A7B209693;
	Sat, 22 Feb 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxPwRKCJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8431FA16B;
	Sat, 22 Feb 2025 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225082; cv=none; b=tIKUj2bbR8mOF0P8vBs0+OiWIJKjPbtoITIVvheClYlSWGplYLY8p0TMUfuG22wBvmtvDKkZnlmAU2Rs3Cua3up6l3UgZpI6EONJ+E8Mot7IIIK4YKhSOr1YLk2HMjQlKuWBRpw2onh0W7ELbW5iVcWhUYmDV9XuVsIE4AyCfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225082; c=relaxed/simple;
	bh=ku62Uk/dTVfCf8h3O/d79/aHXW5kgZZ4NGjvVli0V+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKoEt6PLk1wa/0oz8XtP0KTWZYaiTjE3J7cehzP1TPKRX8fOnR3C1giigBBVWnOpggRsuusGOtoXI22P8NjWQFTSR+BtRyrnceQIelGdRboE0A7Seo3QU5alG0dx5e7mv3pj1ogJAS4OFsSNI5UiubjbVCa7aYjXesMAisNyAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxPwRKCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1865CC4CED1;
	Sat, 22 Feb 2025 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740225081;
	bh=ku62Uk/dTVfCf8h3O/d79/aHXW5kgZZ4NGjvVli0V+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZxPwRKCJDZlN37zONde3bMg6ditISNa2k57GB7d8JSA0srBmveXYe3VaDwShwkEMz
	 OMa1tIAu0xMAF0Rc2ugIYlaJt4crlJfb7pEhOzcc7zEwhAaYivuon8/1i2ciaRFlre
	 FMxPYEs8ZZhl7nBjPhYIPYzTrFlDeRe+PuDEcq+i3odNYiH4+nd/fkbCSPo2uEGBLu
	 cWuacppLnW0nqBZj3owlhwjDWCECJlIOl+Q9UaZ6RWuEG5n2FM4UZYlsXFGR2h6TBm
	 N1xOb4GDl419YjlRRoZT22UZwz4Tn31SPZMQGfRgiTZY/M0+vowERFpsmVBvr+bQs9
	 5jmjWotvs6iTQ==
Date: Sat, 22 Feb 2025 11:51:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH RESEND v3 06/17] Documentation: ABI: add wideband filter
 type to sysfs-bus-iio
Message-ID: <20250222115111.63a1cb89@jic23-huawei>
In-Reply-To: <42296bf2-2818-4224-9e52-d1fef59d8a76@baylibre.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<aea512746712f8f6d07d29ec6977609c127fabe0.1739368121.git.Jonathan.Santos@analog.com>
	<42296bf2-2818-4224-9e52-d1fef59d8a76@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 15:28:09 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/12/25 12:16 PM, Jonathan Santos wrote:
> > The Wideband Low Ripple filter is used for AD7768-1 Driver.
> > Document wideband filter option into filter_type_available
> > attribute.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v3 Changes:
> > * None, since we still did not agree on a better name for this filter type.
> >   
> 
> I'm convinced at this point that "wideband" is fine.
> 
> > v2 Changes:
> > * Removed FIR mentions.
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index f83bd6829285..9b879e7732cd 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2291,6 +2291,8 @@ Description:
> >  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
> >  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
> >  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> > +		* "wideband" - filter with wideband low ripple passband
> > +		  and sharp transition band.  
> 
> The description could perhaps be made a bit more generic though
> instead of using specifics from the AD7768-1 datasheet. Something
> along the lines of Jonathan's 'flattish to a wide range of frequencies'
> description.

That is sort of what what low ripple passband and sharp transition band means
but with technical (sounding :) terms.  The only missing bit is it isn't
a narrow pass filter.


> 
> >  
> >  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
> >  KernelVersion:	6.6  
> 


