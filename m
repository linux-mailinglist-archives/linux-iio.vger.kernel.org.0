Return-Path: <linux-iio+bounces-7417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4879298E7
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 18:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA4D1C20D9D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D1E3D98E;
	Sun,  7 Jul 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxwcN5SY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D02BD1E;
	Sun,  7 Jul 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720370956; cv=none; b=s9vjf65LtabYKwREtT9Sbsw/j/y5g+y49Utxj8eT5LceeXA+f9btGib9iTEqnRvmJTPAvnchkPbJmai7w8eoBPBmqoV+ec2Km/7SUp0qXgZQixcmW4XqMn2cRLHb4lMAbHg19YSe+FRwAP5CUWXp+LrdyoPtXjkmfAHSdI58gKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720370956; c=relaxed/simple;
	bh=7ArQ+zJe3h8U8SVv6/dkC8pEhzbfkjiB48zAxkgXS9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o625zSephBfy7+NOwjEiBrChmybnB9kAYOM69/UJklPzWSBd0d+Au6i7KruYPVlA7MvsTu6buFlU3F9feQROxwTB7fa40Fe4V8X+WuV0JAVDXfeU9F8ASgyNpBHDiMYuPQa2cK2OdzYCB1n5YUbL7qoftoi34UkSIBmpo6aBzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxwcN5SY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EA3C3277B;
	Sun,  7 Jul 2024 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720370955;
	bh=7ArQ+zJe3h8U8SVv6/dkC8pEhzbfkjiB48zAxkgXS9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YxwcN5SY3VoEI3h1PHTqAA0nEMEjIpm3VxjzqEZ+lztr6OvxCmX3EDwJR5YvbSHN5
	 kOxBoExhCky0OIGvQWzcSGARA3HzRHPdum6kCW1Sg8C2tEF0agu4YcZgMomVFrAgBr
	 jgCHC6GDkEeb2ErpU8goiDdcJx4TMyQFFrGT+5vV7wA/f9TiUpdNuN+o+Fh2aTOG0m
	 ERoyEox08CngXRYLibH1OJ5SrqzftAVC7vxnAMcz/FLNOBEAQnmGvop46ocDo/I6Nm
	 JyAmn62nO8tlhIshnezIhsFzIEESdALYdY58rcB/tWRhpXdr8PkPWJXv+DZvnsUUTP
	 HCIgE2VmseyyA==
Date: Sun, 7 Jul 2024 17:49:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Message-ID: <20240707174910.156b3e3c@jic23-huawei>
In-Reply-To: <9a7f7eb2b5e8841b8c1f1064cccdd86f@disroot.org>
References: <20240625165122.231182-1-kauschluss@disroot.org>
	<20240625165122.231182-2-kauschluss@disroot.org>
	<20240626-junior-tag-cd3e27c4b140@spud>
	<7f99d77c65bc347bf8b7935220520fdb@disroot.org>
	<20240703-velvet-badly-904e7afc7cf8@spud>
	<9a7f7eb2b5e8841b8c1f1064cccdd86f@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Jul 2024 07:16:10 +0000
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> On 2024-07-03 19:30, Conor Dooley wrote:
> > On Wed, Jul 03, 2024 at 06:31:13PM +0000, Kaustabh Chakraborty wrote:  
> >> On 2024-06-26 16:06, Conor Dooley wrote:  
> >> > On Tue, Jun 25, 2024 at 10:21:06PM +0530, Kaustabh Chakraborty wrote:  
> >> >> Add the compatible string of stk3013 to the existing list.
> >> >> 
> >> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
> >> >>  1 file changed, 1 insertion(+)
> >> >> 
> >> >> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> >> index f6e22dc9814a..6003da66a7e6 100644
> >> >> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> >> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> >> >> @@ -19,6 +19,7 @@ allOf:
> >> >>  properties:
> >> >>    compatible:
> >> >>      enum:
> >> >> +      - sensortek,stk3013  
> >> > 
> >> > The driver change suggests that this device is compatible with the
> >> > existing sensors.
> >> > Jonathan, could we relax the warning during init  
> >> 
> >> What does 'relax' mean here? Earlier there used to be a probing error,
> >> and now it's just a warning. Is that not relaxed enough?  
> > 
> > If it is something intentionally, I don't think a warning is suitable.
> > It makes the user thing something is wrong.  
> 
> So, something like:
> 
>   dev_info(&client->dev, "chip id: 0x%x\n", chipid);
> 
> is suitable in this context?

Key is to indicate in a 'friendly' fashion that we don't recognise the part
but we are treating it as what DT says.

dev_info(&client->dev, "New unknown chip id: 0x%x\n", chip_id);
only in the path where we don't have a match

> 
> And doesn't it make stk3310_check_chip_id() obsolete? In all cases chipid
> should be printed as it's not an error/warning message.

No. Printing it when we know what it is counts as annoying noise.
We want the print to indicate we don't know what it is.

There have been too many instances of manufacturers switching to
a part that is compatible with some non-mainline driver (because they
match on a whoami and handle it appropriately) that doesn't work
in Linux.  Hence we want to print a warning so that when we get such
a report we can ask for more info on what the device actually is.

If device manufacturers would actually update their DT when they changed
a sensor for an incompatible one we'd not need this.  Unfortunately
some of them don't :(

Jonathan



> 
> >   
> >>   
> >> > 	ret = stk3310_check_chip_id(chipid);
> >> > 	if (ret < 0)
> >> > 		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
> >> > and allow fallback compatibles here please?  
> >> 
> >> So, you mean something like this in devicetree?
> >> 
> >>   compatible = "sensortek,stk3013", "sensortek,stk3310";
> >> 
> >> I mean that's fine, but we also need to change devicetree sources for
> >> other devices. If that's what we're doing, please let me know how do
> >> I frame the commits.  
> > 
> > Why would you need to change the dts for other devices to add a fallback
> > for this new compatible that is being added?  
> 
> Okay gotcha, so it's just for stk3013.
> 
> >   
> >> >>        - sensortek,stk3310
> >> >>        - sensortek,stk3311
> >> >>        - sensortek,stk3335
> >> >> -- 
> >> >> 2.45.2
> >> >>  
> >> 
> >> Thank you.  


