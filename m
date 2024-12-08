Return-Path: <linux-iio+bounces-13209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA639E84B3
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 12:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8AC1644D1
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0C14600C;
	Sun,  8 Dec 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djsrzfmh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD11411EB;
	Sun,  8 Dec 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658114; cv=none; b=e3OAwsq9k/0YzdQ5/dVabSqdmIDUg99rdeFY4ZKtACkqTVumjHuO1E0MVqC9Aqr/o9dsmKCmN6TBPjp7uuwbCRE87SUk5couS5CqzGST9ZJXi1zsjTuOtt2Hv7dO57MtGaoa0uh8mKHHaQhUydPyCPSlfdqBune6WpLeFt1PcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658114; c=relaxed/simple;
	bh=8SGlDgjqovuxAP6Znjsem7TLlju7Ua+klwaijJBVyIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hrv/AD4exgBptzBvDT7BmLQ5nXt/HNEJ5o+IbKx9v6HCLLBZUKY3gWq6y+8IXogcVpnb0Yb1tmxj4kLPKZ+PP52TIbDrkn9H325lVdx+85hgqYW++zyZQ9yJjN9+lTwPqYuDBQDxDp6CrOvotC6BksjTvRXMUlVRK4smK+fwUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djsrzfmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49410C4CED2;
	Sun,  8 Dec 2024 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733658113;
	bh=8SGlDgjqovuxAP6Znjsem7TLlju7Ua+klwaijJBVyIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DjsrzfmhFv0SITxQ0oJHd/IZmiUUCsgrcm/0D2BcPDTCFLLF0hoVeQKq+pD2gM77N
	 4XViDQjVL8YLOja9k/QOoMNuEKO4YIdmMy8yrUe352tHMNz5pk7zD5FwOGMINfSbYp
	 Yu0wfAAkdi0myHhc46A8BZ4jhYIC7zfXhkXRLti4HfJfRcD0LkYyxWRuBjwPLtmje1
	 Y5554diceQLRaIun8w5oDp7cW9/XLzQWAaSbalZTyyCNuQE6xa39R0z5xkNx4ee25p
	 EQHvmnyfCAmZp6m3dhmQUS6jePdTyn17Aq9jxNmPw7CFk5lPScxYCXjecsSeUQrvzG
	 gEC1LMibyKwxQ==
Date: Sun, 8 Dec 2024 11:41:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>, Lars-Peter Clausen
 <lars@metafoo.de>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20241208114141.31df6a8e@jic23-huawei>
In-Reply-To: <Z1NYhR9Y9T0OUCHV@uva.nl>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
	<20241206-apds9160-driver-v2-1-be2cb72ef8f4@dimonoff.com>
	<20241206-comment-tissue-7964de6bdcd3@spud>
	<Z1NYhR9Y9T0OUCHV@uva.nl>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 15:03:17 -0500
Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> wrote:

> Hi Conor,
> 
> See my comments inline.
> 
> Thank you,
> Mikael
> 
> On Fri, Dec 06, 2024 at 04:33:36PM +0000, Conor Dooley wrote:
> > On Fri, Dec 06, 2024 at 11:09:56AM -0500, Mikael Gonella-Bolduc via B4 Relay wrote:  
> > > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > 
> > > Add device tree bindings for APDS9160 driver  
> > 
> > Bindings are for hardware, not for drivers.
> >   
> 
> Indeed, should I change the commit message to remove the "driver" part?
Yes.
> 
> > > 
> > > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > ---
> > >  .../bindings/iio/light/brcm,apds9160.yaml          | 51 ++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..525fba52f156df3b78e24d7d0d445fe9d882eaa7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > @@ -0,0 +1,51 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Broadcom Combined Proximity & Ambient light sensor
> > > +
> > > +maintainers:
> > > +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>  
> > 
> > How come this differs from your author email?
> >   
> 
> The author email is my work email, this one is my personal email.
> The first one might change while the other one will not.
> Is it required to have the same email here?
I don' think there are firm rules on this, but there are processes in place
for changing email via .mailmap and where relevant patches updating
to a new email address.  A note in the commit message would be appropriate though.

Jonathan

> 


