Return-Path: <linux-iio+bounces-10394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D3998DAF
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED2D1C2414A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429219C56F;
	Thu, 10 Oct 2024 16:40:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F3199FBA;
	Thu, 10 Oct 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578451; cv=none; b=hXf767hcD4YEsnVJ75jgoPW6NUt4hTAU+knpJanXcTjNDuDVWWiU69L4b3nr2IGJRXrrrVIPZCFnEQnhUqLyBbboXNk4cA19O9j4M1A3WhLgR5qK0HRMBWDwUjCHM6/42J7uUgqPz4c7vo9z71PInhNEoNV3XezSogK73oBoFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578451; c=relaxed/simple;
	bh=7Dki8csyxmG2igPYCbUM3Lwm5qOkWkVdaeHqiZcN3Qo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaSb6UpiN3DrkNZeoydLzIlYL2fkvy0zO3Qrk7mJnC0Xo4WMvRuH23gEcZxcee8tQK+dTZAxWXDEHv2FI/faCi5h2S+/7vVIpTTvFN1DJhdA+eXNSSjVrvYkz9Qjd45siKaDxcYKWzbcR5txZKbrcNV4Y7ozj5jM4YQS6hEoVQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPb8n1Znnz6K5mr;
	Fri, 11 Oct 2024 00:40:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 488971400CB;
	Fri, 11 Oct 2024 00:40:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 18:40:45 +0200
Date: Thu, 10 Oct 2024 17:40:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Nechita, Ramona" <Ramona.Nechita@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>, "Hennerich, Michael"
	<Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Lechner
	<dlechner@baylibre.com>, "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
	<mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov
	<fr0st61te@gmail.com>, "Mike Looijmans" <mike.looijmans@topic.nl>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20241010174043.00002446@Huawei.com>
In-Reply-To: <DM6PR03MB4315A13F69DE8B4EFB4030E3F3782@DM6PR03MB4315.namprd03.prod.outlook.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
	<20240914180648.592cd69e@jic23-huawei>
	<DM6PR03MB4315306944DE2E5E8CD3B236F36A2@DM6PR03MB4315.namprd03.prod.outlook.com>
	<20240928153109.52ff4c5e@jic23-huawei>
	<DM6PR03MB4315A13F69DE8B4EFB4030E3F3782@DM6PR03MB4315.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Oct 2024 14:35:52 +0000
"Nechita, Ramona" <Ramona.Nechita@analog.com> wrote:

> Hello Jonathan,
> 
> >> >> +
> >> >> +	ret = ad7779_reset(indio_dev, reset_gpio);
> >> >> +	if (ret)
> >> >> +		return ret;
> >> >> +
> >> >> +	ad7779_powerup(st, start_gpio);
> >> >> +	if (ret)
> >> >> +		return ret;  
> >> >What powers the device down again if we hit an error?
> >> >
> >> >Probably need a devm_add_action_or_reset() or if it self powers down may a comment on that.    
> >> 
> >> In the powerup function there are only some register writes and the 
> >> start gpio is only a synchronization pulse (perhaps the name powerup is not very appropriate), would an action or reset be necessary in this case? Since the regulators are not used in the driver, should there be a function disabling them anyway?
> >>   
> >If there is nothing useful to do indeed not but when I see a power up, I rather expect a power down.  Is there anything that can do that or is it a case of it will go to sleep anyway for some other reason?  
> 
> I don't think there would be anything to do in a powerdown function specifically, but I could rename the powerup function to "_config" or something similar, to make it more intuitive.
ok. That will at least make me less suspicious when I read this
after forgetting all about it ;)

thanks,

Jonathan

> 
> >  
> Best Regards,
> Ramona
> 
> 


