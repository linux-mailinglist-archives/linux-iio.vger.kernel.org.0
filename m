Return-Path: <linux-iio+bounces-23700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C852B4386E
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 12:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60477B3962
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E42FC03D;
	Thu,  4 Sep 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="nn3+1Rxo"
X-Original-To: linux-iio@vger.kernel.org
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21C82FC86F;
	Thu,  4 Sep 2025 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980957; cv=none; b=e7ZnTP3LATvg/0ly23IG7YhZNRz/Ff6RZBP29XEZTplnik2280ayIl18Gn7ftyEADqxdDk/iBdgbIny1IrYWl5QIRMxIbXmIpzPYVgj1sEkWB/SyqWBaR+kK0Y3GwJb1PWdzDGwMfbXVrmejP2qP3fWPS6sk+1I/Sj/cDCXAoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980957; c=relaxed/simple;
	bh=i5H35eDXCV3vFUPSZuAi1bMKrqV72OP84pRCebp9HIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sy4m1kioukRF+9BMf5xNHcV9nrUtUke+NDMCI3qAo60G6PjbL74V1L6YdH2Mmv4h6Dw+4MYUBT+9jznaN8zGk+lskSxd2L6ho5WL84LJKy4p4AaSG41/7cYMkpyKGMnHs++H80gcL9vBnlZanSzfyWRXbS8003IQ+9jVGbRxAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=nn3+1Rxo; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xgdsR49irpJByzJ96bcwBmhSCv4K4cXZahydPuILDco=; b=nn3+1Rxo+sb6gVBkjg5wdrMG1Z
	Xj9upXEyacqW45zeWBQy490E0jg4I3Gfck8A+K6G9un9jo7OGf2bmovU/zwCNRSRzYoI95P5nqkSs
	R3QPMkWHZM/wTe7HTef84vL0G+oI2H4fhtfRAlEws7uYJxQ8+lsIWwG1Fy4gWk7g40NtoNRMi+4En
	OHWTuxlNGVXq36Iecb7GlMsH8Zz9SG8UQJFfB+ahlMc54+9vX0kGBWPdrOLbDww6SjKNWwBKAugMW
	XxXrSVbKQXhd8wDX7cAftW8u0Wkm3pjgMPM/Bwkt9k3EJ1gU4xkU3P6pXsr1rST++njyBvzg7u5c1
	GhZVa7Mg==;
Received: from 86-58-118-213.dynamic.telemach.net ([86.58.118.213]:54824 helo=[192.168.0.129])
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uu70U-00000003pfn-053I;
	Thu, 04 Sep 2025 12:15:54 +0200
Message-ID: <b6006a1b-0b46-4e0d-9d49-6cc0dbe84814@norik.com>
Date: Thu, 4 Sep 2025 12:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: afe: current-sense-amplifier: Add
 io-channel-cells
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 upstream@lists.phytec.de
References: <20250903113700.3079626-1-primoz.fiser@norik.com>
 <20250904-tangible-practical-partridge-a1b0e4@kuoka>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
In-Reply-To: <20250904-tangible-practical-partridge-a1b0e4@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Krzysztof,

On 4. 09. 25 11:17, Krzysztof Kozlowski wrote:
> On Wed, Sep 03, 2025 at 01:36:59PM +0200, Primoz Fiser wrote:
>> The current-sense-amplifier is an IIO provider thus can be referenced by
>> IIO consumers (via "io-channels" property in consumer device node). Such
>> provider is required to describe number of cells used in phandle lookup
>> with "io-channel-cells" property, otherwise the following kernel error
>> is present:
>>
>>    OF: /iio-hwmon: could not get #io-channel-cells for /current-sense
> 
> Also, how can I reproduce this error? Do you paste here real errors or
> just some invented ones from some out of tree code (hint: such would not
> be relevant).

I get this error if I apply patch #2 without patch #1. See [1] for more 
details.

BR,
Primoz


[1] 
https://lore.kernel.org/all/20250903113700.3079626-1-primoz.fiser@norik.com/

> 
>>
>> Also fixes the following dtbs_check warning:
>>
>>    current-sense: '#io-channel-cells' does not match any of the regexes:
>>    'pinctrl-[0-9]+' from schema $id:
>>    http://devicetree.org/schemas/iio/afe/current-sense-amplifier.yaml#
> 
> Best regards,
> Krzysztof
> 


