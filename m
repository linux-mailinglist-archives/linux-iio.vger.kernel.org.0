Return-Path: <linux-iio+bounces-7731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7AC93815E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 14:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D360E281AB6
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 12:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD083209;
	Sat, 20 Jul 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1sPbiia"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB21653;
	Sat, 20 Jul 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721479526; cv=none; b=Xau4qtZtZp8ZEqNxz1MjqTjBEQ2IvRBKI5NbO5dJrKr6ZElczkndBNzsMhoDLPJeXTy/UkGdwHl1pcQghRzKzYJ+6OX8+K6xfow9/k6pJj5yZBGwvoRIvkKdXSOceV/DGcbZPD1yieXamLsh0IhrkKs86N4oX+9N7MvTeGxY2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721479526; c=relaxed/simple;
	bh=fOYT0ZSqCfEyo3AFmiH7R7zRioxaEZCje5xbQVslR3c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGQO9LRVej0apsL/h/kEb+0pyedDOo8y8ynt14VC+/k+tfMhovUqroJpAiytbQEiwGcnyGPAuIMCmuiJXb+2mYurjgCxlo9cRdpQqopzQ3fGO0edn6KVRdr4ZyWBFBBPe984hEJdOQHCXBbOSG1Gs4P3stn42r0YkOdVagxn/Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1sPbiia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1EC2BD10;
	Sat, 20 Jul 2024 12:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721479524;
	bh=fOYT0ZSqCfEyo3AFmiH7R7zRioxaEZCje5xbQVslR3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1sPbiiaKXevbLetJ9MCKQgD5MHOzf4Dj+sXEfUio+Vjk4Kgn/SdRbYfvFLEVsAjz
	 s/9gqR1M8HnSonKPYS2BNZKGLRB6mJ6/cGF/U4HQxlgEnhPpsc1hGw2kOunRPGh5tJ
	 N4XmRvWpxHnH7eZJfkQpY5/C/aBiu2TwzgczcrTw+epX/os9FzrphATnEOEmy1wFL/
	 4sKK869lHLnpSrIdIaN/N//cHLxW4VulNu/eV1UTxJ5zFgXdVy1QIJvN0Dscg9ZEEF
	 GjVA0DG6Oa41P+6xrv1rS1ExMCeFjk9ar5pAkS2VXqmjOvAGixuXHV7zz0yDvjjbtZ
	 L36vbuovufHHw==
Date: Sat, 20 Jul 2024 13:45:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Message-ID: <20240720134518.61b940e1@jic23-huawei>
In-Reply-To: <2554b98ddbe3098fa974b651f555a791@disroot.org>
References: <20240712152417.97726-1-kauschluss@disroot.org>
	<20240712152417.97726-3-kauschluss@disroot.org>
	<20240713130620.79d47130@jic23-huawei>
	<be34b0b571ddc33351e9eb123410a210@disroot.org>
	<20240716174328.15c250a9@jic23-huawei>
	<2554b98ddbe3098fa974b651f555a791@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 15:58:50 +0000
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> On 2024-07-16 16:43, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 20:02:57 +0000
> > Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> >   
> >> On 2024-07-13 12:06, Jonathan Cameron wrote:  
> >> > On Fri, 12 Jul 2024 20:54:02 +0530
> >> > Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> >> >     
> >> >> Add the compatible string of stk3013 to the existing list.    
> >> > 
> >> > Should include how this differs from existing devices such that it doesn't
> >> > make sense to use a fallback compatible.    
> >> 
> >> STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
> >> being marketed as a proximity sensor, it also appears to have ambient
> >> light sensing capabilities.
> >> 
> >> Add the compatible string of stk3013 to the existing list, as a part not
> >> compatible with other devices.  
> > 
> > That would be fine, but I'm not seeing any driver code changes, so when
> > you say not compatible, in what way? If it's register changes in features
> > we don't support yet or something like that, just add some examples.
> > 
> > A different whoami register value isn't sufficient as after the fix
> > you have as patch 1 that will only result in a message print.  
> 
> I understand that a whoami is not enough to justify not having a fallback
> compatible. That's why I mentioned it's the most "convincing" argument I
> could come up with, which is admittedly, isn't enough.
> 
> And there really isn't anything feature-wise which sets STK3013 apart from
> other devices. All register addresses and functions are fully compatible
> with the current driver.
> 
> > 
> > Obviously doesn't help much for this addition as you are adding the
> > bypass of the whoami and the new ID in the same series, but we want
> > to set a precedence for future devices to use fallback compatibles
> > now that path works.  
> 
> I'll add stk3310 as a fallback compatible and change the commit message
> appropriately. Conor did mention it in the last revision, but I totally
> missed that. Apologies.
> 
> Ending the description with something along the lines of:
> 
> The part is fully compatible with the existing implementation of the
> device driver. Add the compatible string of stk3013 to the existing list,
> with a fallback of stk3310.
> 
> ...would be alright?

Yes. Looks good.

Jonathan

> 
> > 
> > Jonathan
> >   
> >> 
> >> I hope this is good enough. I couldn't find anything more convincing.
> >>   
> >> >     
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
> >> >>        - sensortek,stk3310
> >> >>        - sensortek,stk3311
> >> >>        - sensortek,stk3335  


