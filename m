Return-Path: <linux-iio+bounces-27077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBCDCBBC6A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54E63008896
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A9D29E0F8;
	Sun, 14 Dec 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj+TAchL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7229C33F;
	Sun, 14 Dec 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765725631; cv=none; b=WZSXYOvHTvmjNixgBrfXInXiX7LoZ1UZZh1uVScfCJey7YBmzunxnXb7v9ASX8ywE4P2/epCyLwLw+mZ+nX42V1rV/9+dk59pDorsX8tXiX8iSdPKJdre0H2qpDHaW/LB/9awIvpFeVVlRQs+XirNzej4tP8Ryp8b0UoGR96Gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765725631; c=relaxed/simple;
	bh=gCS24zxS0GqMw/1uUC+Ly+irr9h/H+Ln2ULQ3KWHgWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0fZilUCtdN0guIpZSmJRlLBQuMt/Q2dREHS3tktFaKbxMEW3nVLHzT2yv70wj+DemyVV0JMc+TLQO4U32DTqKVA+0sne767PUD94VkRUN5MQcSEJ5tbVtkTZ9Mk49q7sROBAcZBWBOitbxfMKdF57FUSOmduW5kXA75VPEsAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aj+TAchL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D481C4CEF1;
	Sun, 14 Dec 2025 15:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765725630;
	bh=gCS24zxS0GqMw/1uUC+Ly+irr9h/H+Ln2ULQ3KWHgWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aj+TAchLksZ6M11vLBPzOdGte6Qd5M33Qg4T6GwqbHXKxN73+KRhbd4WVKzdDk8v2
	 oN3VsuO7xZbMVAJt2oHp2QkeTqhJq+vftI5Eqr1Er1MJRM220DKdAiztXgF78T+fYr
	 pRQ8c+Epwv6u3rN+hbK1rODzJqffDuaSz1zeKN+VWOFVfktq9AqiqlIGwTvrBQZss/
	 eGBZbR5Yq5xaSzeKm84VHCIFwAu4m+MIlwPlfEUshTY/VXYVqArIFmKXff9RwCD/b1
	 9Sjl4/GjWXpJJA37tt2ivjFiNHlYjDPjVlB3n0lCZrVVD76kxv9Ojz6+9ephEyOouX
	 sjfGA53Imxf0g==
Date: Sun, 14 Dec 2025 15:20:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: pressure: add
 honeywell,abp2030pa
Message-ID: <20251214152021.72081e78@jic23-huawei>
In-Reply-To: <097fae2e-8a72-443b-8ed0-ffd6ecfc9e64@kernel.org>
References: <20251207-honeywell_abp2_driver-v4-0-b52a4b96bbf7@subdimension.ro>
	<20251207-honeywell_abp2_driver-v4-1-b52a4b96bbf7@subdimension.ro>
	<44adc9d6-2520-4282-8c6e-1fedf5319e77@kernel.org>
	<aTZ7G8M-FvmEuQ8X@lipo.home.arpa>
	<097fae2e-8a72-443b-8ed0-ffd6ecfc9e64@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Dec 2025 08:21:49 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 08/12/2025 08:15, Petre Rodan wrote:
> > 
> > hello Krzysztof, 
> > 
> > On Mon, Dec 08, 2025 at 06:01:46AM +0100, Krzysztof Kozlowski wrote:  
> >> On 07/12/2025 07:00, Petre Rodan wrote:  
> >>> Adds binding for digital Honeywell ABP2 series pressure and temperature
> >>> sensors.
> >>> The i2c address is hardcoded and depends on the part number.
> >>> There is an optional interrupt that signals the end of conversion.
> >>>
> >>> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>  
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It looks like you received a tag and forgot to add it.  
> > 
> > [..]
> >   
> >> If a tag was not added on purpose, please state why and what changed.
> >> </form letter>  
> > 
> > I removed the tag on purpose since the yaml file was modified in v4 as per the
> > changelog that is below the commit message.  
> 
> Please read my form letter and please read linked submitting patches
> doc. I pointed to a very specific paragraph, so you don't need to read
> everything...
> 
> >   
> >> I will not be doing work twice and, without explanation, forcing me to
> >> do that is disrespectful to my time.  
> > 
> > sorry about that. the single thing that changed was that
> > 
> > ---- 8< --------------------------------------------
> > @@ -76,8 +71,7 @@ properties:
> >    spi-max-frequency:
> >      maximum: 800000
> >  
> > -  vdd-supply:
> > -    description: provide VDD power to the sensor.
> > +  vdd-supply: true
> >    
> 
> 
> This is trivial and absolutely NOT a reason to drop the tag. Did you
> read submitting patches document? Please consider TIME of reviewers,
> even time spent on replying on this.

I put the tag back and applied to the testing branch of iio.git.
I'll rebase that on rc1 once it is available.

Thanks,

Jonathan

