Return-Path: <linux-iio+bounces-7398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110E929822
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1C2282644
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D61F5F5;
	Sun,  7 Jul 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyQNkieU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47EC12E75;
	Sun,  7 Jul 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720359489; cv=none; b=OK/sAfoL0BrTBE65cW+GWxH6qUHzJ2/1LnUOKHhFVlmiicw/ilz0eAxsgdEe/u72y6Fnu1XtTtFQ/dJIju8+jdij6H9MQYePA5YQwJCE/QG7soK83kWXqvYaWmUcZtpBAA1Ozg7HFWEQ8mFaU+aWeXshRE9lTyR6XDca4kIBGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720359489; c=relaxed/simple;
	bh=oakLLlevP2jLA9ho/5pf0UxjfHrHwyOUiBOW8rIGEU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdIIUvCo2A1pxYxdit3kFbeyYVBDyvZDhm0cuwNDJ+IIzCN0U5trfutA2QwUwrsY+rtSN3PTfkPsrOfUkWvT+8w1D1DM4d4i9RZf3YRQDo5jaumnEuRTBs2UsBlT4DMsFeCRdTalLUBNFtHrz4TRffnzwVK0fCUuyjipIHoJI/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyQNkieU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D43DC3277B;
	Sun,  7 Jul 2024 13:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720359488;
	bh=oakLLlevP2jLA9ho/5pf0UxjfHrHwyOUiBOW8rIGEU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TyQNkieUKPIVF8jGUfb3sQeKP8802qQ49TX3QPevLbQWgLHxqE7IYErLc1g2RSgWh
	 KaFxvGnl0DDMucFWYQnjWkyba9uUb584kI8ZG5IRfAGFiJ8fyknmBoJbCaOO5g34lG
	 zVXOPV92dkoAOaUBhJsfDx34h4vaQOVstNGwjUkmzgYJlxHVpaM4kIJa3ZpVaMvqZA
	 JcZDmbXW3rgsx7Sl3A6XDpf9z8RYV4yLOxQKsgq51ueWET3heXI9lgLmHkoFMkrWhj
	 d3Afwmtbz1enJhosvRRSYLWomXnVoetlHJka6YLCd1TpqqxrKcvtxWywWd1WuHrLT2
	 xjmbyPa6F06mg==
Date: Sun, 7 Jul 2024 14:37:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>, Marek Vasut
 <marex@denx.de>, linux-iio@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, kernel@collabora.com, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
Message-ID: <20240707143759.7718e0f3@jic23-huawei>
In-Reply-To: <98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
References: <20240705095047.90558-1-marex@denx.de>
	<3b2ca0-6687ce00-3-4dab7280@52083650>
	<98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jul 2024 14:02:39 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 05/07/2024 12:42, Shreeya Patel wrote:
> > On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
> >   
> >> The "ltr,ltrf216a" compatible string is not documented in DT binding
> >> document, remove it.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> ---
> >> Cc: Conor Dooley <conor+dt@kernel.org>
> >> Cc: Jonathan Cameron <jic23@kernel.org>
> >> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> >> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: Rob Herring <robh@kernel.org>
> >> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: linux-iio@vger.kernel.org
> >> ---
> >>  drivers/iio/light/ltrf216a.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> >> index 68dc48420a886..78fc910fcb18c 100644
> >> --- a/drivers/iio/light/ltrf216a.c
> >> +++ b/drivers/iio/light/ltrf216a.c
> >> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> >>  
> >>  static const struct of_device_id ltrf216a_of_match[] = {
> >>  	{ .compatible = "liteon,ltrf216a" },
> >> -	{ .compatible = "ltr,ltrf216a" },
> >>  	{}  
> > 
> > This compatible string with a different vendor prefix was added for a specific reason.
> > Please see the commit message of the following patch :-
> > https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/  
> 
> And adding this specific compatible was clearly NAKed:
> https://lore.kernel.org/all/20220516170406.GB2825626-robh@kernel.org/
> 
> yet you still added it. That's a deliberate going around maintainer's
> decision.
> 

The statement from Rob was very specific. The schema is not applicable to ACPI bindings
- that's the basis on which he doesn't want this in the schema. Specifically
because "There's not really any point in having this in schema as you can't
use that schema with ACPI".

That is true (though arguably you could with sufficient tooling apply the schema
to the relevant part of DSDT).

The compatible is usable, via PRP0001 ACPI IDs.

> > 
> > We were very well aware that not documenting this was going to generate a warning so  
> 
> You *CANNOT* have undocumented compatibles.

Why not? This corner case is a valid reason for that to be allowed.
You cannot use that compatible with DT bindings.  Absolutely.  The compatible
has other uses...


> 
> > we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood  
> 
> Because the driver was NAKed obviously as well.
> 
> > from his last message was that it wasn't necessary to fix the DT warning.  
> 
> I am quite angry that maintainer tells you something, but you push your
> patch through because apparently you need to fulfill your project
> requirements.

I think this is a fundamental misunderstanding of the situation and probably
at least partly my fault for not clarifying my reading of the situation more
fully at the time.

As far as I am concerned. The situation is:
1) Existing shipping consumer device.  We have 100s of cases of ACPI bindings
   that exist just to deal with garbage firmware's.  The folk involved in
   reviewing these have pushed back hard for a long time, but sadly there
   is still a lot of garbage shipping because Windows lets it through and
   Linux support comes second.  It's made even worse by Microsoft defining
   their own standards that aren't compliant with ACPI as they don't
   even bother with reserving the methods IDs.  ROTM for example.

2) This is an ACPI binding, it just happens to use a DT compatible via the
   PRP0001 mechanism.  Yes, we strongly discourage people doing that in
   shipping products but there have been other cases of it.

3) Shreeya read a distinction (that I also agree with) between the schema
   and the compatible list.  The schema does not apply to this situation
   (because we can't actually check it today for DSDT) hence Rob's Nack
   was making the point it was inappropriate to carry it there.

So, I don't see this as a deliberate attempt to bypass a maintainer Nack.
I'd love to be in a position to say no on ACPI bindings that are garbage
(there are a lot of them) but Windows is dominant in that space so
we get stuck with their mess.  On server's it is a different game
and the kernel community regularly gets significant changes made.

Jonathan



> 
> Best regards,
> Krzysztof
> 


