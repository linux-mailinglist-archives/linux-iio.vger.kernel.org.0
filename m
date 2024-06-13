Return-Path: <linux-iio+bounces-6254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA66907B5E
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 20:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91AE1F22982
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29BD14D431;
	Thu, 13 Jun 2024 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifu5bx+2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10714B075;
	Thu, 13 Jun 2024 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303465; cv=none; b=WgVZKN+ODBW5W9JGpgq6m17qgk25Y5Bxhx7RNF+8GodAylhofACGEXx8fsM5qpdR5CdcaTaLUa0AV03PwpmNWIWpoNf91gw1RWKV4X2maLWKTn8r3y4/Q2DQxAX/suGr0Giy7EUkOQ6sKF7bK4EsUM7GR9tPB3tykyw3x3zH2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303465; c=relaxed/simple;
	bh=SbD+xFGqIOxNc3/m8vp1hOh4RjDlhrkQYNrPi7kWyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMDts+3kebQP8kVu309Tk7dzk8v3g7+5ReVIaAX96MaKXzXieKaEvy2Vltr0+LFUZLbuUsWjpj4CLqHDvZoQFo8Z8+p2zWVuTx1Vaf5q2Y6myCiPKNI8TmgZ+SrRKDz5b0LQ6veEtys+3GR2UGCJ1GhxfaBT071L69KXbguCjqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifu5bx+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484B3C4AF60;
	Thu, 13 Jun 2024 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303465;
	bh=SbD+xFGqIOxNc3/m8vp1hOh4RjDlhrkQYNrPi7kWyJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ifu5bx+2566LUFmGEIG7+laLHwP4lqzAAHCKfJ+Nvt0gRMTC34O7Pv90k0CH+qR6s
	 i4cF+ykdxk7YeR0P9ZL5S73xkw51DTWtY1L6BvScZah2q8Gu9cs64C2TAUDzEW+75y
	 NhCzRDwha+vkLfIOjO2nePO2KzHw+RWrh+PEwbu8HJKmbj/SCguU8bezXaaJdYJNrv
	 VROnYaTbW0w7fjQH7lwuTAlYUsdaG3sEN7SCHEmPNnlDwzZ74NfI0zEJ9Es6K/Ro6r
	 Z+S1Svzdrv9yPHk2LYIPSh42LVOmUuWQKo3ZZ9WwgW50LAbkDaNg52EukfSu4Su0EM
	 Xnhb3H5PBZOpQ==
Date: Thu, 13 Jun 2024 19:30:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 0/9] Add support for AD411x
Message-ID: <20240613193056.3fa3804c@jic23-huawei>
In-Reply-To: <20240608173720.29ee4aee@jic23-huawei>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
	<20240608173720.29ee4aee@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Jun 2024 17:37:20 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 07 Jun 2024 17:53:06 +0300
> Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> 
> > This patch series adds support for the Analog Devices AD4111, AD4112,
> >  AD4114, AD4115, AD4116 within the existing AD7173 driver.  
> 
> Looks good to me.  However given you had lots of good review and
> it was a Friday afternoon posting, I'm not going to pick it up until
> Nuno and David have had a day or two to take a look if they want to
> (and hopefully add a few more tags! :)
> 
> If I seem to have lost it (rarely happens now I use patchwork to track
> things) feel free to give me a poke.
> 
> Thanks,
Ah - I forgot we have a dependency on a fix that went the quick path.
As a result I'll have to hold this until after a 1st pull request.

Whilst the merge resolution is trivial i need to do a pull anyway
to resolve a more complex one.  Hence let's take the easy but
slightly slower path for this as well.

Jonathan
> 
> Jonathan
> 


