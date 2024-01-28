Return-Path: <linux-iio+bounces-1976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35CD83F5A0
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 14:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA23B21244
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F8223757;
	Sun, 28 Jan 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooKXE709"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3222F17;
	Sun, 28 Jan 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706449163; cv=none; b=qFJxTcUMGOAd1Z/gUIFG6CayLeq9AyFHFRt/vq+rYZ51nCpL4RcXXU//3NvaiopeK1r/Rapmy+isVlQD9GLg7EkuYO0dP0XLC1/uzIklAIyxeyiKdrLadpWX28qiUptHbf6mu9qWlfoC/fvPdYqjMPfLCAlBkorT5HzcsUcnP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706449163; c=relaxed/simple;
	bh=XVlQ6N1doV8DkEbQFX+dIPZ550LKT248U3R28JE62ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDBiCkLmpK3jPiABjn7x88d96SJW0s7i2bmBTNdiTcK6u/sWr3hTk807OptVCktbhte4dg8IVSWuvWIG3Sq+p6bzbydzT/px2pSSj+JQz4MnHnIWXi16DLYsZB2GrEqiEHppnH00+fvjznL2SrSy5OgmjIxnAPQfKWGmNZt45KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooKXE709; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DED9C433F1;
	Sun, 28 Jan 2024 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706449162;
	bh=XVlQ6N1doV8DkEbQFX+dIPZ550LKT248U3R28JE62ZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ooKXE709IEodgYHJHQdbR3tju7Yc8ntA4+cXiWK74cW6LYr99TYVtyyc7g6m9AwNR
	 0GMTHkeHgwW6U75yE3uae2eplUmRp8Cp+HLRIsUABg0JpH2yY4/WqvszQqlnR47tzz
	 sUxdnZ919lE1JmlMIMEV8uBSlwzOq4RSKrXvFmYnjcx1fWe32rGib2y5SjAVZypjxB
	 IR7xZd/RjwzOsSMUfuPgY9YBRGKnapBGcE5eAYYLNohhn/DQ3kST6pSQXTH++K3tN5
	 foDV6+ap2owFHDepNZIbubBSGqXgqH1j03veM2OobM/Qg8NJpTrdeQFpubRw5dCAbE
	 3MLc2QVZOlzxA==
Date: Sun, 28 Jan 2024 13:38:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mario.tesi@st.com,
 armando.visconti@st.com
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhxg1
Message-ID: <20240128133859.34d5abab@jic23-huawei>
In-Reply-To: <ZbYt673vc-Cg0s6A@lore-desk>
References: <cover.1706093274.git.lorenzo@kernel.org>
	<90d675537e58c9c339545a895e8164a843821682.1706093274.git.lorenzo@kernel.org>
	<20240127150426.4994a6a0@jic23-huawei>
	<ZbYt673vc-Cg0s6A@lore-desk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jan 2024 11:35:23 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Wed, 24 Jan 2024 11:52:34 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> > > Add device bindings for asm330lhhxg1 IMU sensor.
> > > Use asm330lhhx as fallback device for asm330lhhxg1 since it implements
> > > all the features currently supported by asm330lhhxg1.  
> > 
> > Can we clarify if the hardware of the asm330lhhxg1 supports
> > 1) Exactly the same features as the asm330lhhx
> >    (Valid use for a fallback compatible, because we might find
> >     bugs etc in future).
> > 2) More features, but the asm330lhhx features set is a subset.
> >    (Most valid use for a fallback compatible)  
> 
> Hi Jonathan,
> 
> afaik asm330lhhx supports a subset of asm330lhhxg1 features (adding st folks in
> cc for some clarification here) but they are not implemented in st_lsm6dsx.

Great.  State that a little more clearly in the patch description for
v2 please.

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> > 3) Different features from the asm330llhhx but driver only supports
> >    a set both support? (this is a problem)
> > 
> > I 'think' it is 2 from your text, but I'm not 100% sure I've understood
> > correctly.  
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > index 28b667a9cb76..7ba3de66a2e1 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > @@ -49,6 +49,9 @@ properties:
> > >        - items:
> > >            - const: st,asm330lhb
> > >            - const: st,asm330lhh
> > > +      - items:
> > > +          - const: st,asm330lhhxg1
> > > +          - const: st,asm330lhhx
> > >  
> > >    reg:
> > >      maxItems: 1  
> >   


