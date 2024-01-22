Return-Path: <linux-iio+bounces-1855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55623837249
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E4F1C29DC8
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4693D38E;
	Mon, 22 Jan 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAsqWqvu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69063A6;
	Mon, 22 Jan 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951104; cv=none; b=khTO3mSv/OCmogG/eenaPbEj16oK4nXttd9n3Up2Mc/rc7uNeQ5Wtzl30qrsuJCRtN3BlV79EZqIog+FzxNW49PCBBA/SZjO4fQnhOaLWR1BVn8hr+hQ8qvK200DwUlfSsXwkk2xDRfk6caVzejpqRSjDQVxZwIBzpFcgVAF1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951104; c=relaxed/simple;
	bh=V5jjtfNkWpmEJq3QODdc0VEk8Gdgs0RJoBrV+75Rj2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b78aL23vVo3uhYt3nWkiMSl6LgSqkNYajP70JG6M3n3H8syuGeLFDjI7kNt1WfkkExhUN66C0SeZAx7xsKe2OZBGL21xzbOpqBfGUq9v4RTo58QV5R4UiGK2sXI/XGce5Yh9KaXg++cZbQHEqtkptoMVXj7IVCZdyQ/IbM+V+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAsqWqvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B13C433C7;
	Mon, 22 Jan 2024 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705951103;
	bh=V5jjtfNkWpmEJq3QODdc0VEk8Gdgs0RJoBrV+75Rj2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAsqWqvuaEvOWAmLb4KtDI8wNuxg9WFXsskfthrbMzWlL/u65Qb2UFaEnRQx1+ZV5
	 y2k8IMJwzMZ/i9aymZL02Ko1+Ar01QyLtQnr1CmabC7Z5fA+rExVAiFudR7TJQW4ct
	 jv4EtVtzDCgYTblVEly4/51QtwrDrxjGLTVU32346eKPBqNaW+jJo6dyT/t9QMuGsI
	 Zomy1gCPCsDMgcX3/xEl1Qi06s3DKCYFdIdeiUyKbO8VVwWDcNI3jYsSflKMFAY5uW
	 tM866wuPO6UCs8HSipxogUm2C6+Cuyb3UqCxEmnW0xX+R4hUIWkXKJnMqyxd0RLARC
	 jfhUNJMTfJmOA==
Date: Mon, 22 Jan 2024 19:18:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Message-ID: <20240122191809.23f4ec6f@jic23-huawei>
In-Reply-To: <20240122153436.GA601827-robh@kernel.org>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	<20240119-iio-backend-v6-2-189536c35a05@analog.com>
	<170568455347.599801.4301742729712962299.robh@kernel.org>
	<20240121171720.47b61298@jic23-huawei>
	<20240122153436.GA601827-robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 09:34:36 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Jan 21, 2024 at 05:17:20PM +0000, Jonathan Cameron wrote:
> > On Fri, 19 Jan 2024 11:15:56 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >   
> > > On Fri, 19 Jan 2024 17:00:48 +0100, Nuno Sa wrote:  
> > > > 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> > > > also remove it from being required.
> > > > 
> > > > The reason why it's being deprecated is because the axi-adc CORE is now
> > > > an IIO service provider hardware (IIO backends) for consumers to make use
> > > > of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> > > > of consumer referencing other nodes/devices) and that proved to be wrong
> > > > and to not scale.
> > > > 
> > > > Now, IIO consumers of this hardware are expected to reference it using the
> > > > io-backends property. Hence, the new '#io-backend-cells' is being added
> > > > so the device is easily identified as a provider.
> > > > 
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >     
> > > 
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > 
> > > yamllint warnings/errors:
> > > ./Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: [error] syntax error: could not find expected ':' (syntax)  
> > If this is all that comes up for v6, I can fix it up whilst applying.  
> 
> I would not recommend that unless you run the DT checks. This is a YAML 
> error which is just the first thing that has to be valid. After that, we 
> check against the DT meta-schema. Then we check all the examples 
> (because any example could use any schema).
I would indeed test it (plus let 0-day hit it before I expose it to next
as well) so hopefully nothing would sneak through.
> 
> Though, it looks like the above is the only issue.

Turned out, not quite - though others also fairly minor, there are enough
of them I expect Nuno will do a v7.

> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks


Jonathan

> 
> Rob


