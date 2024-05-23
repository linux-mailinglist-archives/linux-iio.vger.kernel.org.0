Return-Path: <linux-iio+bounces-5231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FB78CD8E6
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9801F213B7
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6AD74E2E;
	Thu, 23 May 2024 17:03:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B756E615;
	Thu, 23 May 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483839; cv=none; b=Zz9dp7MmEi2UvBT2RT0oy7QqmFIqLoUU+NB1JymEol94NB303u3owOvkFlZimTyo8B7augPmVt2Jp6eUzow7pjJW118x2f7zOkVyQlOMaidgPd3mF26mqjb6Tp4mG5O4jO/sezaTziMrzTQnNfEDhiiTkqAYutFZRqCQIFTiSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483839; c=relaxed/simple;
	bh=yixVaLW6s8+7LnkB4chqo4/bLu7ydT36cszdn5ODoPA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYeRQ6ooR//GfcxaGMXdQsiq0f5e2Lb0PlW7kZoDQN4BKLr3d1n7MmcSpv6hYs0rPpk/j8MZBKaCA8UQIYRgsMHUvkS8MvTA017aRY9Fq6vVsLMPuSo+k8hF5QNWSjsE4qAdS14zMxVRJi+TKXjVDqXcvQdXsQu4I1UrsAPO4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlZDC2jpmz6JBLn;
	Fri, 24 May 2024 01:00:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F21D5140C72;
	Fri, 24 May 2024 01:03:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 18:03:53 +0100
Date: Thu, 23 May 2024 18:03:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: ranechita <ramona.nechita@analog.com>, <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240523180352.0000623b@Huawei.com>
In-Reply-To: <efb07835-8894-43d0-9fe1-14cb865db135@kernel.org>
References: <20240522120208.18575-1-ramona.nechita@analog.com>
	<efb07835-8894-43d0-9fe1-14cb865db135@kernel.org>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 22 May 2024 15:33:56 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:
Typo in the patch title.. dt-bindings: iio: adc: add ad7779

> On 22/05/2024 14:01, ranechita wrote:
> > Add dt bindings for adc ad7779.

Good to provide a very brief intro here to the device.
> > 
> > Signed-off-by: ranechita <ramona.nechita@analog.com>  
> 
> Are you sure that's the name or identity you want to use? Looks like
> misconfigured git...
> 
> > ---
> >  .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
> >  .../bindings/iio/adc/adi,ad7779.yaml          | 93 +++++++++++++++++++  
> 
> Where is any user of it?
> ...
> 
> > +
> > +  clock-names:
> > +    items:
> > +      - const: adc-clk  
> 
> Drop names, it repeats what's obvious.
> 
> 
> Best regards,
> Krzysztof
> 
> 


