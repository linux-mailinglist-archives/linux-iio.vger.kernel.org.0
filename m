Return-Path: <linux-iio+bounces-7796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F06939466
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 21:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86421F222E9
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F517107F;
	Mon, 22 Jul 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THuYqAK3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA961BF54;
	Mon, 22 Jul 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677329; cv=none; b=IharGVpAR2CrDfgd45HqKfZyc4TZG6PGqvbWH7OZibQuxN8m1x3MNn4oQzMdaV49mpXEjKE2qNoiIeNAzcbYhCkxIdhdI1bkgAZCtT6XT7Ut5ortBQlEdlXmCMCZsv/aHEkBqhpQvAevvd1oHozdu2sDiLEto4kO0Nla+UADX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677329; c=relaxed/simple;
	bh=d1uZLYblVEosqZC0El/eIcWlTBQjryYyq3zmsuQNjJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZqQSupGI8yYnlJyprI2NO5GY5JIO6v7v7rWjwpzE2XqdhNCjphwTyFlLSl17CCEMUIkldGmBEdflPFxRuLso/7SvEVuXj4O3V+SLOd2V3fS0X4Q8ycVTXgKy8JOZIcoVDO7tF+THY+0rPteV+HU8aE0oPGvn6jWoaPjRkDBITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THuYqAK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38D1C116B1;
	Mon, 22 Jul 2024 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721677328;
	bh=d1uZLYblVEosqZC0El/eIcWlTBQjryYyq3zmsuQNjJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=THuYqAK3+LAZsB7DAVSikCGPOrjbMAFiMdAKjzAcN211fSdvQPK6soAXop2He3Rar
	 Vxtvo18NTFgXEdkQuCI0hlv8lsZ2m5tM28BuwfNE6msthdSfUu5LHJinfr8d4mGZn7
	 pZlfuv32iDBR8CTeHjw+qqBsqrZeI9QZVx+wrA3eh+L9HVKMrXGPmeSt1MB0hN0zst
	 cKflGNq2yFABaOGzhGfelPnurLm1gtaJdVKdpijl1/C4Gymj2uV2iNqE2vzQVass0r
	 q3/ZX4SgC1O9FW+enCxiwXAG9A7uDtlmSEFiXR/QqUR9KuA8fkjIPA9z8m/SmzAgSE
	 cOrUCXfXicVBw==
Date: Mon, 22 Jul 2024 20:42:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shreeya Patel" <shreeya.patel@collabora.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Marek Vasut" <marex@denx.de>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] iio: light: ltrf216a: Document the device name
Message-ID: <20240722204200.67288d99@jic23-huawei>
In-Reply-To: <337fb5-669e6d00-5-3b412bc0@82250038>
References: <20240714193709.543509-1-shreeya.patel@collabora.com>
	<20240720142236.22f8dbb2@jic23-huawei>
	<337fb5-669e6d00-5-3b412bc0@82250038>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 15:31:20 +0100
"Shreeya Patel" <shreeya.patel@collabora.com> wrote:

> On Saturday, July 20, 2024 18:52 IST, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 15 Jul 2024 01:07:09 +0530
> > Shreeya Patel <shreeya.patel@collabora.com> wrote:
> >   
> > > Compatible 'ltr,ltrf216a' is used by Valve's Steamdeck device
> > > via the ACPI + PRP0001 mechanism.
> > > Document the device name alognside the compatible.
> > > 
> > > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>  
> > Hi Shreeya,
> > 
> > I'm guessing you used get_maintainers for this.  Always check that there
> > isn't anyone else who should be added.
> > 
> > Given the root of this was the discussion about dropping this undocumented
> > binding the DT maintainers and list should definitely be CC'd + Marek
> > who was part of the earlier discussion.
> >   
> 
> Sorry about that, I used get_maintainers like you said but I'll keep this in
> mind next time.
> 
> > The fact that this isn't a typical ID from a Windows consumer device does
> > change things a little, but I'd imagine a firmware update for the steamdeck
> > is equally unlikely to happen in order to fix the vendor-id.
> > (I was surprised to discover they provide windows drivers for it but
> > not seeing the light sensor in the list)
> > 
> > So my opinion is that we should keep this ID in place with an enhanced
> > description.
> > 
> > The other suggestion from the Krzysztof's thread was the risk of this getting
> > abused.  Perhaps we should specifically fail to probe if that ID is used and
> > it's not an ACPI firmware?
> >   
> 
> Rob said in another thread that use of it can now not pass the validation
> with dtschema. So I'm guessing we don't need to add any extra checks anymore?
That's how I interpreted Rob's reply as well.

> 
> However, I'll send a v2 with enhanced description alongside the ID.
Great.

J
> 
> Thanks,
> Shreeya Patel
> 
> >   
> > > ---
> > >  drivers/iio/light/ltrf216a.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> > > index 68dc48420a88..e97ff8f7ecd0 100644
> > > --- a/drivers/iio/light/ltrf216a.c
> > > +++ b/drivers/iio/light/ltrf216a.c
> > > @@ -528,7 +528,7 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
> > >  
> > >  static const struct of_device_id ltrf216a_of_match[] = {
> > >  	{ .compatible = "liteon,ltrf216a" },
> > > -	{ .compatible = "ltr,ltrf216a" },
> > > +	{ .compatible = "ltr,ltrf216a" }, /* For Valve's Steamdeck device */  
> > 
> > Add that the steamdeck is an ACPI platform using PRP0001 as that's
> > the key part that is different from a normal 'wrong' of_device_id.
> > 
> >   
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ltrf216a_of_match);  
> >  
> 


