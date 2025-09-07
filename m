Return-Path: <linux-iio+bounces-23854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B82B47B19
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 13:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C44624E0F65
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AE258ED4;
	Sun,  7 Sep 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRjdbtrV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560F1991C9;
	Sun,  7 Sep 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245802; cv=none; b=U2waL5PMIeeEMgvewdREC2N/lVB/Gr7a7LvwA7mEkfyPMl1QEa/bZnk79cpsbRZkNu+doBFzjbELaYOI7MrHmpDtnp2hpJwfwqq4E2iYs0TPtLiyG7GE0U2JKE9L3U7MEOyDR7fYVL64ySzQwIbD96hGndMFT4PqQ7cL+DwnSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245802; c=relaxed/simple;
	bh=37K9EA26vxYKMUmDOyg7DDd3NpY10jCWD01fK8IcmRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnBZwft+5kHj90TUxyUcyAaMJEvhroekfbvQwOkQqB6TB/eG+LSiREgmxFsRZDuqdcGOUUybmJnWBUkkF+EdMcnrPjajTV+2qjyD0qiyLHPAGk96coODRuS+LhQhYBPClXJA9S8+b6Cq4dANYmmG1uhPGvnQetbmTLdSniowMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRjdbtrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454EBC4CEF0;
	Sun,  7 Sep 2025 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757245801;
	bh=37K9EA26vxYKMUmDOyg7DDd3NpY10jCWD01fK8IcmRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NRjdbtrVyyiGCitUteqHMSdGa15CjdSNofo9Fwt5dE0MESj87l279ceGZSJHzCAgJ
	 rG2ovsOn2w3F03XlG7ySDm8Ot94SbrTF7IAIu55lIPzfQmgzKkT9cN0Rg9V22z41nq
	 YrgqPL+g6FhC9OYDlDCTo4ZSwt3EXpbBJDxO2LEJRqwvU1AEd2fABMdNP1xiEQiWYk
	 bHhbdrcnjxSK1CiP11AKhK7O4TVehhUnE5eswq837EUyoUVpMKG5AmXaCZ3TAMDBev
	 8aRmjELEaQ/t8UlXq9dj2ywIsbI49V5v8lrT8ZDkjzG9sDeIFY0xNX7EaskFLgcYxh
	 UQ9r1YOmmFpUQ==
Date: Sun, 7 Sep 2025 12:49:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: magnetometer: Infineon TLV493D
 3D Magnetic sensor
Message-ID: <20250907124952.31809adc@jic23-huawei>
In-Reply-To: <CAFmh=S0AP4_9H8CiSp3oAciNF=FGMGp4bFz6QEJNFGqwdvj65w@mail.gmail.com>
References: <20250906-tlv493d-sensor-v6_16-rc5-v6-0-b1a62d968353@gmail.com>
	<20250906-tlv493d-sensor-v6_16-rc5-v6-1-b1a62d968353@gmail.com>
	<20250907103617.5400c1bb@jic23-huawei>
	<CAFmh=S0AP4_9H8CiSp3oAciNF=FGMGp4bFz6QEJNFGqwdvj65w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Sep 2025 16:43:34 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> > Krzysztof gave an RB on version 3.  Please make sure to pick up such tags.
> >  
> Indeed, RB was given by Krzystof on the V3 patch but this patch got
> modified for MAINTAINERS file changes which were not part of V3.
> Considering that I thought it should be removed. I have added this in
> the cover letter change logs as well. Is this correct understanding?

When making small changes like that, it's a judgement call you need to make
on whether they are likely to affect the intent of the tag.

To me that one wasn't something that Krzystof was going care about.

Anyhow it's fine that you looked on it differently.  In cases like
this I'd expect to see a comment under the --- in the patch that a tag
was given but dropped because of xyz reasons.

Keep that in future versions until the tag is given again or other
comment invalidates it.

Jonathan

> > This time I'll apply it by hand if nothing else comes up.  
> Thanks,
> Dixit


