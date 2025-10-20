Return-Path: <linux-iio+bounces-25282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595DBBF2CF8
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 19:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5B818C12A5
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 17:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E33330D2E;
	Mon, 20 Oct 2025 17:53:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85713C3CD;
	Mon, 20 Oct 2025 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982805; cv=none; b=T1bcTmeizdmd6IWd46U4HjQ0RKFrA1do9Aximrielbnqc8SEpAv0Y2u9D4RnNpZyI6H9GyB+F1YEBeUet7aBNboEj2FlcCMGtvMLfoTE8BmLmvX1kK7t8mRjshD3QzuIXj7/9+wjDqmcLMCghIg0U95iMIHlQz7SVJlHYZpeZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982805; c=relaxed/simple;
	bh=XDKOG0khz3I/QShi5M6TPOEY+uhCd7xJyx/C9dNkpIk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHZ6jRzAkUkPYXMEIEiAKLJsTiUnxuDTEp6FhE36dfgHfG5pcg3F9bgc9GbbkKkZm2oFff9MFFwv6qrrXE/xC3UV1JV7kNrvtv/phsGQkuPNjo/EL25nTYkXyCXZr2+VPcPio9pT1vu+DjTlTjniLZG6nWuFg27euL6JygjUpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cr30K5v1bz6K61P;
	Tue, 21 Oct 2025 01:52:01 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7318614020C;
	Tue, 21 Oct 2025 01:53:20 +0800 (CST)
Received: from localhost (10.48.157.75) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 18:53:19 +0100
Date: Mon, 20 Oct 2025 18:53:15 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Kim Seer Paller
	<kimseer.paller@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Marcelo
 Schmitt" <Marcelo.Schmitt@analog.com>, Ceclan Dumitru
	<dumitru.ceclan@analog.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: iio: adc: add max14001
Message-ID: <20251020185315.00001656@huawei.com>
In-Reply-To: <eb655eb8-4f24-409d-9560-be980637ca66@gmail.com>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
	<aPGeCMiLSB9-A7t_@debian-BULLSEYE-live-builder-AMD64>
	<8c1a533a-2c39-41a9-a007-f64cefe30e35@gmail.com>
	<eb655eb8-4f24-409d-9560-be980637ca66@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sun, 19 Oct 2025 15:02:54 -0300
Marilene Andrade Garcia <marilene.agarcia@gmail.com> wrote:

> >>> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
> >>> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> >>> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> >>> ---  
> >> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> >>
> >> Since you've dropped the ADC node label, I think you could have picked up
> >> Conor's review tag from v12.
> >>
> >> If nothing else comes up, you won't need to send a v14 as Jonathan 
> >> will probably
> >> pick the latest tags when applying the patches.
> >>
> >> Cheers,
> >> Marcelo  
> > 
> > I agree, I forgot to pick up Conor's review tag. Sorry about that.
> > Okay, thank you.
> > 
> > Best regards,
> > Marilene  
> 
> 
> Hello maintainers,
> 
> Just checking, is there any other action I should take on my end
> regarding this patch series?
> Jonathan, I forgot to add the following tag in v13, so I was wondering
> if you could please include it when applying the patch.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
I replied to patch 2 to say I've picked the whole series up.
Fixed this up and pushed out. So you should see the result on git.kernel.org iio.git togreg

J
> 
> Thank you so much for all your assistance.
> Best regards,
> Marilene
> 


