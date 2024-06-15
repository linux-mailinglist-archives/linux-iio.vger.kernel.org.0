Return-Path: <linux-iio+bounces-6304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 426AC90988C
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1541F22236
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E745010;
	Sat, 15 Jun 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjhyEK93"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C5E8F58;
	Sat, 15 Jun 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718459395; cv=none; b=TVSpoAlMmciBbQGpdU8Av3AamHTCoH9vIQ54rwBe+PQsqDE1qACBKSvDJKSROK5SsVGZqkvSPAIorkNQDDbrI+2R+PIfZAMbBPg3CdpOYaboJQdHsnF+skykaHwfzpNz6yV91LGRh1rMC++lqQr2hQMnWNX0nteIx38zjnGKOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718459395; c=relaxed/simple;
	bh=ER0g4htpS5CkjSDWtxNpPw1s6BfRHs0d/ulwHfGFJKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLVf5yYANdK3I9nv84FOLGyCxCLL3iCPfXvs3e41Q2ZTnD7cHU0TxImWwx6pJYafmV8GmOzcR13NDZWnvhiAhAZcHmxKn269ko312k76BqLNkc7EQbRGCmx3nZCT2aV9KaNcmWbXVamiR4vY4fddUoqieU2kXrH4DT+WsPyNeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjhyEK93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B83C116B1;
	Sat, 15 Jun 2024 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718459395;
	bh=ER0g4htpS5CkjSDWtxNpPw1s6BfRHs0d/ulwHfGFJKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kjhyEK93QBTnnqVuv0DxcrrNfawR44bPqckOvBKEMMFDvFEip2xo3S9b6CKrEgbt3
	 mSV9Oj8szM4inHRgFS+3xCzqBcUJzi9wbyXc1hJiEOfsJm8o4BWvDuB8mHBD7kehOb
	 nf/ysMZmmWbHXPosOb7N6zNjYVQaYsA1Cd/RnPlKnqRe3J+p1eHaEyICKAlUbaT62E
	 J1Nk8eZMZdpxIt0HofYG2nAJh/D6+MrNk4/db/zev7YjHbKGLdDHF8z5a2RmBJf7XD
	 7OqwW9FrAfpu7/xXG/kCBx0pgInR+7MfDGtn53WW9js/dtZ7E/2Xp7Cr6y33i4xff9
	 pT1YKM5/bDX7Q==
Date: Sat, 15 Jun 2024 14:49:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 denis.ciocca@st.com, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 robh+dt@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
Message-ID: <20240615144948.61e7f519@jic23-huawei>
In-Reply-To: <56ab50d7c542356b7e377023b84a6018@disroot.org>
References: <20240611160821.13941-1-kauschluss@disroot.org>
	<20240611160821.13941-2-kauschluss@disroot.org>
	<20240611-reassign-eliminate-b05e4a302cfb@spud>
	<56ab50d7c542356b7e377023b84a6018@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Jun 2024 09:46:59 +0000
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> On 2024-06-11 18:17, Conor Dooley wrote:
> > On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote:  
> >> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.  
> > 
> > I can see that! Your commit message should mention why this device
> > is not compatible with existing variants.  
> 
> Sure, is adding the WhoAmI value enough? Or do I also have to
> explain the different registers and sensor settings.
> 
Who ami is not enough, but a statement along the lines of
"The register interface is not compatible with existing parts, for
example addresses and contents of numerous registers are different"

With whatever the actual differences are.

> > 
> > Thanks,
> > Conor.
> >   
> >> 
> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> >> ---
> >>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> >> index fff7e3d83a02..71c1ee33a393 100644
> >> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> >> @@ -26,6 +26,7 @@ properties:
> >>            - st,lis2dw12
> >>            - st,lis2hh12
> >>            - st,lis2dh12-accel
> >> +          - st,lis2ds12
> >>            - st,lis302dl
> >>            - st,lis331dl-accel
> >>            - st,lis331dlh-accel
> >> -- 
> >> 2.45.1
> >> 
> >>  
> 


