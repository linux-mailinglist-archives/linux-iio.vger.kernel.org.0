Return-Path: <linux-iio+bounces-7391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EAD92979D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E3B21040
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FC1B80F;
	Sun,  7 Jul 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+oUjEwq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9276FBE;
	Sun,  7 Jul 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720351588; cv=none; b=qsArwRa+NmQV463PyMF2VGqMYJiriXQcrhqCKia2MtcAlc52JKNGkn1BHnaJO/slCq4I80tKsS/oN18nC2va8Wkh76Fc/vHVShSmDi4mgA1jd9IRVQpuF9+jRrpgM6ga1nzf3o+RWniLBanyZ1YKq3hnU6fvjBiYzen/g3gyxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720351588; c=relaxed/simple;
	bh=BvEpD/GaG5+IE3/VFJhS53TC6ow2J/jC3/67SlQcUSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPQCGJqnm7rjQEeGxXpYlGdzrHMSq3SijDMdmonKkHVDXvLH+wOKA0hRpKH3Y3S5UKu3Ybe6Eqm6hHzSng8gTAOD1PKmp3FUmap83EFFCIoQL/1bpaz2/YI93peYCJlhQzIEKvB62SBV0EgogOXLLzWvbReTAHj/4Tgm+k6tG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+oUjEwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64626C3277B;
	Sun,  7 Jul 2024 11:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720351588;
	bh=BvEpD/GaG5+IE3/VFJhS53TC6ow2J/jC3/67SlQcUSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e+oUjEwquVhCPztOgoLiAndezZGV/2PMkowKwxQTjP234d3Ede7hrhQBpmYc5tC5l
	 jrg1tM6tpU+9a8q0p2zt4SRvgbteKycVk0RSBr4wLH3gNy1qS75Hukg19zYXZMP6Ss
	 dun6FxBiWXiW92IcQ7WemNnyaDrC9ChF6VvCx7bQccIpK4mG4vq4thpAnpeWXj9A8B
	 UzwzmC+5JTbigXoiRBgOyg/688CGhCBSLndYXHFFr9A+5JTjw8QvaQ5frTT0kzJETp
	 p7mse+Zs5PPuAyvlupDZQED52LigFLzXVusasrHCL7swtP21tK24nOG7379aaBoXN3
	 lgx/iYin+q3Ew==
Date: Sun, 7 Jul 2024 12:26:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shreeya Patel" <shreeya.patel@collabora.com>
Cc: "Marek Vasut" <marex@denx.de>, linux-iio@vger.kernel.org, "Conor Dooley"
 <conor+dt@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a 
 compatible string
Message-ID: <20240707122620.7b3e6173@jic23-huawei>
In-Reply-To: <3dd224-66883580-3-40d7c680@7066446>
References: <20240705095047.90558-1-marex@denx.de>
	<3b2ca0-6687ce00-3-4dab7280@52083650>
	<13828cf9-4a93-45a5-b3a3-542ee9ec056b@denx.de>
	<3dd224-66883580-3-40d7c680@7066446>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 05 Jul 2024 19:03:04 +0100
"Shreeya Patel" <shreeya.patel@collabora.com> wrote:

> On Friday, July 05, 2024 20:22 IST, Marek Vasut <marex@denx.de> wrote:
> 
> > On 7/5/24 12:42 PM, Shreeya Patel wrote:  
> > > On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
> > >   
> > >> The "ltr,ltrf216a" compatible string is not documented in DT binding
> > >> document, remove it.
> > >>
> > >> Signed-off-by: Marek Vasut <marex@denx.de>
> > >> ---
> > >> Cc: Conor Dooley <conor+dt@kernel.org>
> > >> Cc: Jonathan Cameron <jic23@kernel.org>
> > >> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > >> Cc: Lars-Peter Clausen <lars@metafoo.de>
> > >> Cc: Marek Vasut <marex@denx.de>
> > >> Cc: Rob Herring <robh@kernel.org>
> > >> Cc: Shreeya Patel <shreeya.patel@collabora.com>
> > >> Cc: devicetree@vger.kernel.org
> > >> Cc: linux-iio@vger.kernel.org
> > >> ---
> > >>   drivers/iio/light/ltrf216a.c | 1 -
> > >>   1 file changed, 1 deletion(-)
> > >>
> > >> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> > >> index 68dc48420a886..78fc910fcb18c 100644
> > >> --- a/drivers/iio/light/ltrf216a.c
> > >> +++ b/drivers/iio/light/ltrf216a.c
> > >> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> > >>   
> > >>   static const struct of_device_id ltrf216a_of_match[] = {
> > >>   	{ .compatible = "liteon,ltrf216a" },
> > >> -	{ .compatible = "ltr,ltrf216a" },
> > >>   	{}  
> > > 
> > > This compatible string with a different vendor prefix was added for a specific reason.
> > > Please see the commit message of the following patch :-
> > > https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/
> > > 
> > > We were very well aware that not documenting this was going to generate a warning so
> > > we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood
> > > from his last message was that it wasn't necessary to fix the DT warning.  
> > 
> >  From what I read in the aforementioned discussion thread, it seems Rob 
> > was very much opposed to this compatible string, so this shouldn't have 
> > gone in in the first place.
> > 
> > But it did ... so the question is, what now ?  
> 
> There were multiple versions sent for adding LTRF216A light sensor driver
> and this compatible string wasn't something that was accepted by mistake.
> Most of the versions of the patch series made it very clear that it generates a warning
> which you can check here :-
> https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
> 
> I would just go with whatever Jonathan decides to do here :)

If it's needed for a released device (which is what Shreeya's linked thread suggests)
that we can't get the manufacturer to fix, we are stuck with that entry existing for ever.
No regressions rule applies.

It would be helpful to have a specific reference to what that device is though.
When we've had this mess for horribly broken ACPI IDs that have gotten into devices
we try to add a comment on where they are known to exist.  I'd ideally like such
a comment added here.

Jonathan

> 
> Thanks,
> Shreeya Patel
> 
> 


