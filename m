Return-Path: <linux-iio+bounces-27072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B6CBB1C1
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 18:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D007B3031324
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA452E0920;
	Sat, 13 Dec 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9C81qHS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19761BD9C9;
	Sat, 13 Dec 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765645383; cv=none; b=ToI5LOWt2ASPK6GSYUtISqevrcdr65ARzeGctyVrGcoPXFz0NUaoCP5x5pIQhvfiOlWKLmIDGBjRvlkDStumLlhyg6dZyhmhnkAcXJGd7u+K+AWmI0nXGQu3daIQ9WVFeUo9Cx3/mbRU5hDuOfAgKJQ4psTbf6IKys4upes/CKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765645383; c=relaxed/simple;
	bh=2UpWYya/vT8/YS5AEgqSuwFPzptYkb/tbVFf+3DX8ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyK/duG2Y+FgTwVIgV9jA7qp/hAboGefpeoDmL5I1ZIYRa5XxBoE1jzYWRzReDYymbbYmDCe0lDjZ0W/T7LPNbShXJCCkijLOu7bk63qnNJtt7SLzrdewh7xMOcB65hEWbWePE1lUwmcMSeh0FOHhybgllxA6iTfN8a3k1ijQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9C81qHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E92C4CEF7;
	Sat, 13 Dec 2025 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765645382;
	bh=2UpWYya/vT8/YS5AEgqSuwFPzptYkb/tbVFf+3DX8ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j9C81qHShiadeRShnsOu1sAf29Rxt5NieumDPmK7zQmI3xoHdWw1NKrGr0EPQq4jn
	 60gmmv9aHc9huhjELKBVgct9RxV1QGoAkMe7A1KSKQHkpv93BJ+h23kW4kKQVbQtEf
	 j1mZCrKsROqh1jsYziAVG19CNOo3O5x39YClxl/N5rfPoZ2CWQ8CEhshjpcMPzK6Cn
	 U4LEXGqvyMDrapV4lmzTWoZy/Qe6Dctfhf7DC9pDS/sBxwnvJ0HzAQ7UxHUxcCHD1c
	 7juY++qMxRvkAbcpS9P/sah4JrqXek1rn32ULwYeCErCD8dmwbSb7Ql/xDk1c/F807
	 BxNuWL6hOs+lQ==
Date: Sat, 13 Dec 2025 17:02:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Linus
 Walleij <linusw@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-crypto@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH RFC 14/16] dt-bindings: iio: adc: Allow interrupts
 property for AST2600
Message-ID: <20251213170251.4d3b1690@jic23-huawei>
In-Reply-To: <176548307744.1801669.10354753289483698774.robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	<20251211-dev-dt-warnings-all-v1-14-21b18b9ada77@codeconstruct.com.au>
	<176548307744.1801669.10354753289483698774.robh@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2025 13:57:57 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Thu, 11 Dec 2025 17:45:56 +0900, Andrew Jeffery wrote:
> > The device has interrupts allocated according to the datasheet, and
> > the devicetree already defines the interrupt property. Address existing
> > warnings by allowing the property.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
> 

Doesn't seem to be a reason for me not picking this up immediately. Hence
I've done so.  Currently on the testing branch of iio.git as I'll be rebasing
on rc1 once available

Thanks,

Jonathan

