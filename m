Return-Path: <linux-iio+bounces-18085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC005A88639
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBBF188A603
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC702750ED;
	Mon, 14 Apr 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e8xaB2mx"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5702750EB;
	Mon, 14 Apr 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642358; cv=none; b=oxes8V35fwMHJxLPiGTnqOOIvB/Zb3SETbkJAyHLYJJBiSclyunHzodJfbWGOaG1Zhjvz4SMEji45KCQYTfjXGsbUDacww3wAYvZhMyimGNgTFz/LhPvO+3gce2pg+8uZ6GtDxgS2oU7TYG/3by6dBSvSPlVMbXR3mAznIgXDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642358; c=relaxed/simple;
	bh=hcMWM0G9vEZfGmzIr7O1gnEoUkP0rDsSrVH60fHRMYI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlwNzk+dUzaLTQ/LmE+Xi2YDilX0DFzAWkHL0qNUFbL/i3UF54EydTaGFRFjMq1E8cyUVYNfoiacSzkJ/XnO1UQq1bvigLssLlouSsC85q56WtCWBLZTdgA1b43iNJho/YyvciT/6xiD1a5qGzkNvzZH6OTbN/ksVmN71ikTjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=e8xaB2mx; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEqCCW2787576
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 09:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744642332;
	bh=7DgyALPRj27V3u4dS9N8ZYrgbkAagFNpTbCFLxgzwlQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=e8xaB2mx0+lFI9uLSUkuZzpAlT7BwWkh7jg9b1J45o8r3n1aTc/SzKGeY/irvHMnQ
	 Vqj/cIthOKvs0VmGDhcRjYzvn7E7H1GThsm/I7OTH4K8VjdJeqKuWSWQdUBxre/a/I
	 rfcNKwrv8jH0Ev34cz/pLD0R6+m+m66G9TG0Ank4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEqCro012307
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Apr 2025 09:52:12 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 09:52:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 09:52:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EEqCYp035762;
	Mon, 14 Apr 2025 09:52:12 -0500
Date: Mon, 14 Apr 2025 09:52:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Sukrut Bellary <sbellary@baylibre.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution
 devices support
Message-ID: <20250414145212.7fcybmngv7rnuvnm@hatchet>
References: <20250408132120.836461-1-sbellary@baylibre.com>
 <20250408132120.836461-3-sbellary@baylibre.com>
 <cb81cba4-0fa3-431a-924f-b362fd0c4638@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb81cba4-0fa3-431a-924f-b362fd0c4638@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 09:40-20250414, Matti Vaittinen wrote:
> On 08/04/2025 16:21, Sukrut Bellary wrote:
> > The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> > interface. The device family responds with 12-bit data, of which the LSB
> > bits are transmitted by the lower resolution devices as 0.
> > The unavailable bits are 0 in LSB.
> > Shift is calculated per resolution and used in scaling and
> > raw data read.
> > 
> > Lets reuse the driver to support the family of devices with name
> > ADC<bb><c>S<sss>, where
> > * bb is the resolution in number of bits (8, 10, 12)
> > * c is the number of channels (1, 2, 4, 8)
> > * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> > and 101 for 1 MSPS)
> > 
> > Complete datasheets are available at TI's website here:
> > https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> 
> I tried looking up:
> https://www.ti.com/lit/gpn/adc102s051.pdf

Gaah - the IT folks keep messing with the URLs :( -> dropping .pdf in
the url should get you to the pdf #facepalm :( (sidenote: that wasn't
the case a year back :( - hopefully this will stay).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

