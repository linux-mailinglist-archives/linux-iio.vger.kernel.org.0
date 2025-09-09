Return-Path: <linux-iio+bounces-23906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDEEB50262
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D373F3BB8B5
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 16:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8D34F495;
	Tue,  9 Sep 2025 16:20:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8189D342C9E;
	Tue,  9 Sep 2025 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434854; cv=none; b=Uwijt683WcGTJyrU7P59zk6/m3dHCQn0zeWTPhxdlNmzd+CzLqqUIAA6hcKdZMI4TFlEkMn3Fs6zAGSgLcHGf4V4xNw9/g+SNN2g02rdvFaiL6CB2JldvVaiBZrWmkXBG+gnn/0bSn3h/QdpGFT21hSv6zfygICdDDtIF0hF400=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434854; c=relaxed/simple;
	bh=g7swzv1MEJX3KsMKC5C3krKbGgKOvWbpHqWjFmDILTQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcBesIV06gzaF1Xb+NxkChnPIQEto6JLY984rbq0lsAbmO5tdTrxtHVt5wZEkqVvde33xlCzyiJXdXgEUoDDd8hfasQDCsSlGMm2QgeHR5qYpS1o/+GT5v6pdYpQtypYabl122xEkgy/zLmr5E/ROnFSGXYlHmCAmz/jr3yR2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLptg0Xbxz6K9V3;
	Wed, 10 Sep 2025 00:19:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C0E0140279;
	Wed, 10 Sep 2025 00:20:49 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 18:20:48 +0200
Date: Tue, 9 Sep 2025 17:20:47 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>, "Nuno
 S??" <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 09/10] iio: accel: BMA220 add event attrs
Message-ID: <20250909172047.0000448b@huawei.com>
In-Reply-To: <aL2IcVfzCTXSg3Ol@sunspire>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-10-petre.rodan@subdimension.ro>
	<20250907141515.0b49012a@jic23-huawei>
	<aL2IcVfzCTXSg3Ol@sunspire>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 7 Sep 2025 16:28:17 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hello Jonathan,
> 
> On Sun, Sep 07, 2025 at 02:15:15PM +0100, Jonathan Cameron wrote:
> > On Mon,  1 Sep 2025 22:47:35 +0300
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >   
> > > Add event attributes not directly covered by the IIO API.  
> > 
> > These must be accompanied by ABI documentation in
> > Documentation/ABI/testing/sysfs-bus-iio-...
> > 
> > We need to pull out of the datasheet generic descriptions of what
> > they are so we can consider if they make sense as general new ABI
> > or perhaps map to something existing.  In some cases it is more
> > appropriate just to set a reasonable default and not provide a
> > userspace ABI at all.
> > 
> > Key point is that custom ABI is effectively unused ABI because most
> > software is written against a bunch of devices and has no idea what
> > the new ABI is.   
> 
> I see your point. From all ot those maybe just the interrupt latch functionality
> is generic enough, I have seen something similar while writing other drivers.
> 
> from the datasheet:
> 
> " The interrupt controller can be used in two modes
> 
>  - Latched mode: Once one of the configured interrupt conditions applies, the INT pin is
> asserted and must be reset by the external master through the digital interface.
> 
>  - Non-Latched mode: The interrupt controller clears the INT signal once the interrupt
> condition no longer applies (default behaviour in our chip).
> 
> The interrupt output can be programmed by lat_int[2:0] to be either
>   unlatched ('000') or
>   latched permanently ('111')
>   or have the latch time of 0.25s ('001')/0.5s('010')/1s('011')/2s('100')/4s('101')/8s('110').
> 
> The setting of these bits applies to all types of interrupts."
> 
> Many thanks for the detailed review, I will prepare a new set in b4 and skip
> everything event related for now to keep the set smaller.

Given you are skipping for now we can come back to this later...  But given we
are talking about it I couldn't resist replying ;)

So latched vs unlatched sounds like level signaled interrupt vs edge triggered.

The 'pulse' width cases are annoyingly hard to handle though with those lengths it
seems implausible we'd miss.  I hope for non-latched the sampling rate is slow enough
we still get a good pulse.

Anyhow, I'd suggest ignoring the latch time property and just select between
unlatched and latched based on the interrupt settings in firmware.

Unless you can think of a good usecase for changing these at runtime? I can only
come up with the theory they might be wired to some external circuitry.
Maybe a buzzer to be really annoying ;)

Jonathan

> 
> cheers,
> peter
> 


