Return-Path: <linux-iio+bounces-24485-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D5BA601B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD1C1B23E4D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F791B3935;
	Sat, 27 Sep 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO25mNJS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31200625;
	Sat, 27 Sep 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981647; cv=none; b=aqN8smYnzfSAhhu4vStHANORLhYmTclYjeOtkG03bOUUYLSsIqS0DefhD1KmSiSb1FM5+ax/tMAirYH6APvAvYc5DqDtUixCAlWammqzAEmLfzbp+isyrw141ybGI7K3HXpaPQ1jA+cdzOltSUOAZX9beoAs0P7OXRHG4ABiSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981647; c=relaxed/simple;
	bh=4iHdtxd85iW7+zo1nofYUxqmTGzgTAwisjiN5zO66HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKtSfrSk9fmRP/edIpD96EQbRxR1DQTDhaH1i3eVhy9T/marOqdgDvmtfvSiegt7fXWlG8ezIl283USlww/gQYR1pg8zv/t44q3ftkeErIYfzk0ZlMFDqyO/v0OtjmudgLR+hVRbVs9mDpCB74RGfd6hg1ERIc/rERKsddBJ61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO25mNJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F47C4CEE7;
	Sat, 27 Sep 2025 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758981646;
	bh=4iHdtxd85iW7+zo1nofYUxqmTGzgTAwisjiN5zO66HQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QO25mNJSi5v7AJ00IjKSZ1/Pjmp9iZCyu9ceQld32/U024ZnQtcw0Tbv4O15cGp+j
	 cE5HQGDi3Cx4+xH6FRqWiFkGEBJZPzhqnMwWycwqdVtycYA7R90BDKnmgLdPSXkujs
	 cEjL6hkgmr6oCWFC1z3jY8PIaxgdczZlhehLT4qE4RnCraTP9n3jc+gnR4QnKNCjLF
	 jTLD6SJCCZ1h64RsGClWQEoIKPvywxMOBGc0wNjnWVRocX0x+dTZjmLTHCHnLkRMzt
	 n91tCCE26Ws2fanLg1Zmcb365BUw0YgAkGSRyiAoMrSeKk4V2Uc1QetRne6+4Yaelt
	 E3+XxVtk1yv5w==
Date: Sat, 27 Sep 2025 15:00:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/18] dt-bindings: iio: accel: bosch,bma220 set irq
 type in example block
Message-ID: <20250927150036.40b66484@jic23-huawei>
In-Reply-To: <20250918-brave-khaki-sloth-b0b7dd@kuoka>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
	<20250913-b4-bma220_improvements-v3-3-0b97279b4e45@subdimension.ro>
	<20250918-brave-khaki-sloth-b0b7dd@kuoka>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 11:08:59 +0900
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sat, Sep 13, 2025 at 06:39:24PM +0300, Petre Rodan wrote:
> > Set the interrupt type to rising edge within the example block in order
> > to match the new driver.
> > 
> > The entry that got replaced was not in use by the original driver.
> > 
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > ---  
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
In the interests of reducing what you need to post for v4, I've
picked up these first 3 patches and applied them to the testing
branch of iio.git.   That will get rebased on rc1 once available.

Thanks,

Jonathan

> Best regards,
> Krzysztof
> 


