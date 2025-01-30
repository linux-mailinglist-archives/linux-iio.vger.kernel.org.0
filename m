Return-Path: <linux-iio+bounces-14737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB6AA231CD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8E21883ED9
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3251EE003;
	Thu, 30 Jan 2025 16:29:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B331E8840;
	Thu, 30 Jan 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254557; cv=none; b=g5yY2mVYbcpICFCmmYmmZCxmQGXjWIzVyuAJUiuRg9Rzx+cSTskNwS6K/dvloZekNzorS+86TI5fePfRYfzKmLJxOpPjkS/nWSGQi7/CHgltMAQo9t8F4y6J8Y2eBUyyUC8TSUZwKIkCvuS0hsrL5aHU18Lffa8DlcuALFVOGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254557; c=relaxed/simple;
	bh=8luDU6XnJlZZahfK28xMxnzyZnvq4ajSgN6v7JNJph0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaAOTBil8FxshTeMavBxLQ3fdb31TymQPHJWdVTEdkWc0d6WtfI945FLryHWRNKU0CCpKf+qBRxwLo8U66gUw2tIRe27udmJ7LxrRDaF2CZUq7vRoTYVCPLbbhqtRC1gQx3ktaufcEtdAVKbefPNqiM0p4FhZuPhQkdBEFQNNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkPYh3RSJz6M4Wy;
	Fri, 31 Jan 2025 00:27:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 91E761400DB;
	Fri, 31 Jan 2025 00:29:11 +0800 (CST)
Received: from localhost (10.195.245.124) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 17:29:10 +0100
Date: Thu, 30 Jan 2025 16:29:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lars@metafoo.de>, <Michael.Hennerich@analog.com>,
	<marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
	<marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 05/16] Documentation: ABI: add wideband filter type
 to sysfs-bus-iio
Message-ID: <20250130162909.00001573@huawei.com>
In-Reply-To: <95e9fc42-db0a-45fd-9155-9c8721c849d7@baylibre.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<351b15550f8d8e7126ed8253f3a8028c708327f8.1737985435.git.Jonathan.Santos@analog.com>
	<95e9fc42-db0a-45fd-9155-9c8721c849d7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 27 Jan 2025 19:32:45 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/27/25 9:12 AM, Jonathan Santos wrote:
> > The Wideband Low Ripple filter is used for AD7768-1 Driver.
> > Document wideband filter option into filter_type_available
> > attribute.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v2 Changes:
> > * Removed FIR mentions.
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index f83bd6829285..9b879e7732cd 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2291,6 +2291,8 @@ Description:
> >  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
> >  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
> >  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> > +		* "wideband" - filter with wideband low ripple passband
> > +		  and sharp transition band.
> >  
> >  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
> >  KernelVersion:	6.6  
> 
> I'm a bit shy to make any more suggestions on this one since my previous
> suggestions were clearly not the "right way". :-)
> 
> But, the key takeaway I got from the discussion on v1 is that this describes the
> _shape_ of the filter. To me, "wideband" describes the size but not the shape.
> Would rectangular be the correct shape?
> 
It's tricky.  The filter definition is really vague!  No filter is ever rectangular.
Also, I've just noticed. This one is fully programable. It could be anything!
I kind of hope no one cares about that feature as it looks really tricky to support.


Wideband normally means 'flattish to a wide range of frequencies'.  Not sure
how best to convey that.

