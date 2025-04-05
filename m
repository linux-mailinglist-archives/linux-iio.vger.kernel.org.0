Return-Path: <linux-iio+bounces-17650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97DA7CB0B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 19:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492E3188CD57
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41392199931;
	Sat,  5 Apr 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVCIjYsS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3D1BC2A;
	Sat,  5 Apr 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743874623; cv=none; b=NXCoQnGMP0Lt1IVVAOYkDeHbsGSjrsCRuFVbO63q2m42bbkNBgz1fxBfV75Nz7nIDDCub3vswotw+oZg2PCNTKa8/p3k27bomYFfshIy6JVe/yV3gAyeds5UyMyXMGEgttH8B3hY91YdtsuJnt2bzxinGqoIwTHJ0LjH6e+vRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743874623; c=relaxed/simple;
	bh=aKxW/34NvhkrP64K8xfQVQKDk9SoRViYqKXGYjflamI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMeR2Fua7oOhxUgxeKlI64fdmbA8aW/IKDATgCOgTg9EPGX9fxzn4QNIFTRq+zBsOYnaNItR+VYB6NdOvQwRr/vBtaBN4jMo4k22aLebBnEMBrerEJW+oEUcd9IcH3w9GnhEPVzBJeYIi4GbzQqAw9JXsOZ4m9llUAiJJiiZoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVCIjYsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1510BC4CEE4;
	Sat,  5 Apr 2025 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743874622;
	bh=aKxW/34NvhkrP64K8xfQVQKDk9SoRViYqKXGYjflamI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JVCIjYsSs+4xDpk17pFba12noAXPc3fcONWlomTEI/CYiSXTiK12+BbztQHKLymdS
	 v9ouaEKuZXny9652HQYcVvKakkKTvfe24fQzbb/KPkUSqQ+4c7oe1fWdZYHj+ZYr4e
	 rBWfGIoyhtMYD1pAhq7qyft0ACJnDrLL0f2F6SBq6jcrOUpIiSpgcyUpT+/w2QoF8V
	 TMy7DkMWtKuQoy4CryHC6sB1EbfFNKAtsj7JzlLjm2DR4wj3V5htgv3xDXCTfDwa1G
	 JEqWP4uYDPqJamHHnxNISnXoSp32wpp9sanav+ZHBrmQZ/aQagWJwjoH7VRq9vJEZa
	 7mNntDFKnIUpA==
Date: Sat, 5 Apr 2025 18:36:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Support ROHM BD79104 ADC
Message-ID: <20250405183654.6bd4a52d@jic23-huawei>
In-Reply-To: <6acb2692-8946-4ab2-b433-4f68c080f6b9@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
	<6acb2692-8946-4ab2-b433-4f68c080f6b9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 09:19:19 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 02/04/2025 09:07, Matti Vaittinen wrote:
> 
> > Finally, I didn't find maintainer information for this driver from the
> > MAINTAINERS file. I would like to add myself as a reviewer for the
> > driver, so I can stay on track of the changes to it. AFAIR, having
> > R-entry without M-entry was not appreciated. Any suggestions how to
> > handle this?  
> 
> Jonathan, I suppose this, by default,  falls under the umbrella of your 
> IIO maintainership. Are you Okay with it if I'll add a maintainer entry 
> which sets you explicitly as a maintainer for this, and list myself as a 
> reviewer?

Absolutely.  I'm find with you adding yourself as either R or M.
If you go with M and anyone objects, we can have more maintainers ;)
If you go with R the catch all is fine. I've never insisted on everyone
adding entries to maintainers on basis the catch all means I get
them all anyway.

Jonathan


> 
> I suppose I could also add myself as a maintainer for this, but I am 
> unsure how well it would be received by the TI people ;)
> 
> > This series was based on the v6.14, but it should apply cleanly on
> > iio/testing - please let me know if I should rebase.  
> 
> Just realized I forgot to update this. The series is now based on 
> 543da6252b48 in the iio/testing. Nonetheless, I can still rebase if needed.
> 
> Yours,
> 	-- Matti


