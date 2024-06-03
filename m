Return-Path: <linux-iio+bounces-5669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF58D7DB6
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A302EB21E78
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 08:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3D824B9;
	Mon,  3 Jun 2024 08:45:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484581207;
	Mon,  3 Jun 2024 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404328; cv=none; b=YVHHUGfn74nMzt/XOxguiA9A1Dug0u2el4M8U9U9ZryEPboHCdciKLQq3AaP2NEpb1ES/3FdwEnL7Yc4snRc7iARm2jHklhlMoXfYJFZXq78Whitsx38GwabfNpJcf1WINEkOM+ETf8u3Ooec2fai7e9L5+teHjtVv3ToEU3HTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404328; c=relaxed/simple;
	bh=kYOMJ8lUSMxsB+13SlxbtNNgUEYoyE9Ax8jz0e/dWF8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4ycdewZL1pVLJaVRhOeQpeUZR7gPSj3yJzk/wVam+Wwvq4g7x2vmWYrH2g5i/crI8AWJJX+vCKaXRwP2nNAIFwz+OcYPfMYFrO9kRwhou9YZz/vjWSkB34bUy4oUhJvRIMPvkUYmDOOPHRFDyjSk9G9pwlwcoeuB4hBpAo4UMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vt6B31B6Gz6JBJg;
	Mon,  3 Jun 2024 16:20:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 586261400CD;
	Mon,  3 Jun 2024 16:25:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 09:25:10 +0100
Date: Mon, 3 Jun 2024 09:25:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Arthur Becker <arthur.becker@sentec.com>
CC: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS
 bindings
Message-ID: <20240603092511.0000391e@Huawei.com>
In-Reply-To: <ZR1P278MB1117EE8AFDD8891EE6459CEC81FF2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-2-6f3bbfd42960@sentec.com>
	<e47de936-8cb4-4cef-a346-74835767e203@kernel.org>
	<ZR1P278MB111779FE0C84DB465C54EEFF81F12@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
	<20240602141617.533558c4@jic23-huawei>
	<ZR1P278MB1117EE8AFDD8891EE6459CEC81FF2@ZR1P278MB1117.CHEP278.PROD.OUTLOOK.COM>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 3 Jun 2024 08:23:55 +0000
Arthur Becker <arthur.becker@sentec.com> wrote:

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 02 June 2024 15:16
> To: Arthur Becker
> Cc: Krzysztof Kozlowski; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowski; Conor Dooley; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS bindings
> 
> > On Tue, 28 May 2024 07:23:03 +0000
> > Arthur Becker <arthur.becker@sentec.com> wrote:
> >   
> > > Thanks for the Review!
> > > Right, I wasn't sure if and how to add the veml6040 to the veml6075 dt-binding file.
> > > I'll modify that the next time I make adjustments to the driver.  
> >
> > Hi Arthur,
> >
> > If I read the above correctly you are hoping this merges as it stands and
> > we come back later. If we are going to combine them long term,
> > I'd rather we avoided the churn and had a combined DT binding from the start.  
> 
> Hi Jonathan,
> 
> I could have phrased that better, what I meant was that I was waiting for the next
> feedback on the driver to make the adjustments all at once.
> I'll get to it shortly!

Great :)

Thanks,

Jonathan

> 
> Kind Regards,
> Arthur
> 
> >
> > Jonathan
> >  
> > >
> > > Kind regards,
> > > Arthur
> > >
> > > ________________________________________
> > > From: Krzysztof Kozlowski <krzk@kernel.org>
> > > Sent: 27 May 2024 18:31
> > > To: Arthur Becker; Jonathan Cameron; Lars-Peter Clausen; Rob Herring; Krzysztof Kozlowski; Conor Dooley
> > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> > > Subject: [EXTERNAL]Re: [PATCH v3 2/2] dt-bindings: iio: light: add VEML6040 RGBW-LS bindings
> > >
> > > On 27/05/2024 17:12, Arthur Becker via B4 Relay wrote:  
> > > > From: Arthur Becker <arthur.becker@sentec.com>
> > > >
> > > > Device tree bindings for the vishay VEML6040 RGBW light sensor iio
> > > > driver
> > > >
> > > > Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
> > > > ---
> > > > V1 -> V3: Addressed review comments (v1 of the dt-bindings was sent
> > > > along with v2 of the driver but not in a set)  
> > >
> > > It's basically the same as veml6075, so should be put there...
> > >
> > > Eh,
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >
> > > Best regards,
> > > Krzysztof
> > >  
> 


