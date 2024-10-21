Return-Path: <linux-iio+bounces-10887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C519A725C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 20:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5981C22B8B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F660194AF9;
	Mon, 21 Oct 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfsoMIFR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318833BBF2;
	Mon, 21 Oct 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535448; cv=none; b=ns9GVLk+AUng37fygShyXcqrNi0UNxNcsuuEJGPwYR7nzcOiy2TKZiiyncl9uoraB+wSbsqHMr86pRe1YMdJzlvtPlXBniOm3WnGCg7AQpbxAe6gTLUZg90chRvtB15z9Iu6AinZHuXrxhvpFl1yOJeqXv9SOe2Yydk0soZwXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535448; c=relaxed/simple;
	bh=60uYPtFvmEu2DAWYDp3MV/mD0VByiSXYotBRept3Xec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SE3cKOntobpyQ8T5S5ySg9K9G/eFDCjQk3TzoQWN8i0IP2D51vmqSQE5MfUVHVGcBzuvvjq8FACe6gDyqAScHatydqwXlzm5+APsbna9hO6oFAnMpxO0YYXS9GAIknqZoYX2KMgAQbxZX7uaaJsvjhSkE9BgBhVLxqgQwY7BQdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfsoMIFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE51C4CEC3;
	Mon, 21 Oct 2024 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729535447;
	bh=60uYPtFvmEu2DAWYDp3MV/mD0VByiSXYotBRept3Xec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfsoMIFRlhZUaHXjWdhk2esBc4pkRXhjFyTnrPna9zJ6bI5EtnMeeN6Wr7lqZnhE3
	 zREvWyIIeY3Ewge4p9D8De7WDHuJnR50gBmun4iM9MYjxPNityP9yT5GK1aDZVfM06
	 SBsfFdeTYEimrrB5+h+4bXpF5ZG6fg3vfbE2c00dr1hb9E/eWs7kPVw063Tt7vRP50
	 V974dczLX8yRct4p2F+pH2SYlaPn/8acrCuAibO+ZoDeof2/wS5r6Y5aQrHCS5qdOC
	 vp+HY3tPC/hbJiq8CqXi1dWwI2gZ4xDXdtTsCyO6E12b5U4yUfoCWxbwknVPgLM657
	 sFsxCcF5K0d8g==
Date: Mon, 21 Oct 2024 19:30:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Hans de
 Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/1] iio: gyro: bmg160: Drop most likely fake ACPI
 IDs
Message-ID: <20241021193041.07ed79c6@jic23-huawei>
In-Reply-To: <ZxX49BzZJtoYOBI7@smile.fi.intel.com>
References: <20241018145732.2181309-1-andriy.shevchenko@linux.intel.com>
	<20241018185105.41a2db06@jic23-huawei>
	<87sestcg1e.fsf@justinweiss.com>
	<ZxX49BzZJtoYOBI7@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 09:47:16 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Oct 18, 2024 at 01:27:57PM -0700, Justin Weiss wrote:
> > Jonathan Cameron <jic23@kernel.org> writes:
> >   
> > > On Fri, 18 Oct 2024 17:57:32 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  
> > >> The commits in question do not proove that ACPI IDs exist.
> > >> Quite likely it was a cargo cult addition while doing that
> > >> for DT-based enumeration. Drop most likely fake ACPI IDs.
> > >> 
> > >> The to be removed IDs has been checked against the following resources:
> > >> 1) DuckDuckGo
> > >> 2) Google
> > >> 3) MS catalog: https://www.catalog.update.microsoft.com/Search.aspx
> > >> This gives no useful results in regard to DSDT, moreover, the official
> > >> vendor IDs in the registry for Bosh are BSG and BOSC.
> > >>   
> > >
> > > I'm nervous about Bosch drivers in the wild given recent report
> > > from Justin
> > > https://lore.kernel.org/linux-iio/87jzeboi3g.fsf@justinweiss.com/  
> 
> I know about Realtek case, but for BMI0/BMI it's interesting that MS
> catalog shows hits on BMI160 (note no leading zero!), but not on BMI0160.
> 
> > > Justin, I couldn't find the driver you were referring to for the bmi160,
> > > is it online somewhere?  
> > 
> > Yes, the BMI160/260 Windows driver is on this page:
> > https://ayaneo.com/support/download
> > 
> > It's at the very bottom, under "AYANEO Universal Gyro Driver." GPD also
> > has a copy inside their driver pack under the "Drivers & BIOS" tab here:
> > https://www.gpd.hk/gpdwinminifirmwaredriver, but the download is often  
> >>  at capacity unless you're signed into Google.  
> 
> I was not Cc'ed on ACPI ID parts, please make sure that the patch
> that adds it has a pointer to the actual device which uses it _and_
> DSDT excerpt of the respective Device object. Without that info provided,
> NAK from me.
Device we have in the patch comments. Justin if you can supply the DSDT
excerpts in reply to that patch that would be great.

I'll try and remember to check you are on the CC next time Andy.

Jonathan
> 
> > > Also if you have other bosch drivers could you check for these + bmc150
> > > IDs Andy is proposing dropping in:
> > >
> > > https://lore.kernel.org/linux-iio/20241018145805.2181682-1-andriy.shevchenko@linux.intel.com/  
> > 
> > Unfortunately, the 160/260 driver is the only one I have. I wanted gyro
> > support in Linux for a handheld PC I bought, and it was the IMU that
> > happened to be inside.  
> 


