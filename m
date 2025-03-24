Return-Path: <linux-iio+bounces-17243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52EA6D9A2
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 12:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9056218926AB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDCD25E46F;
	Mon, 24 Mar 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="ffAA0+93"
X-Original-To: linux-iio@vger.kernel.org
Received: from p00-icloudmta-asmtp-us-central-1k-100-percent-3.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster4-host9-snip4-10.eps.apple.com [57.103.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23041F4295
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817505; cv=none; b=M4JMWk+Ly5n7/80DIU1mW75psDzTqT27yIxF3Vmk38DdEkj0hcRgAKJuYxKFzFt7+MlOUA2SBWPpXbhpLf30wYwHnh+U3bQ3jfQYuTzCmTjTZPV88s0eVwTOMLgxLtETtRrNij7fw9RMEFHo50vs9XrxpONg3u9G7Kxf+hwmWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817505; c=relaxed/simple;
	bh=6QkqFzT4QB40LkKJxK39lWPXcsKwdkfaSqyF6gSHQ1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB19ZU9CiVYnBxywQChwH73DSH2So/cgcghWDk+5brSNcYWHvwnF9Q+Q4At36ye6ObFHIzMDP275ijlIRI2c0SlSXo5npmK1vU+evE7qSLlzvYNMEO6PmiDhF4GRkibX4k4klgJGbTX8ShRC2dcmYksfIXFwT2af+A4WHra8kHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=ffAA0+93; arc=none smtp.client-ip=57.103.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=N20daEFIEq76699cKPqoyrfhMtw+hJa1VLqQDUltJsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=ffAA0+932tpG3paOZHMGzexahnSGDCkKv4NQul5apjlDuYLSCheAOINLNIl0aZ2dg
	 xLYT67mJWKFBiJVis5hhQINYjQRa2npBqd4XZQmsqv4DVH9GarfHtJ39qnW56X04DF
	 R4XfM5OY1DwSFNVHiPaIoBO3SB/AmXIqglXi76QnvO3g12OMuRro8r5NxQRvTiM5Uf
	 pm1oTmTD5TtmjQLfJISxhZwXXXpoQdnuRHdYDEQFlmJqGDixZ/vZxzfiXkGoJ9YDdr
	 c3h7ld5ZFAdQTsk0e6IojAmstLO0uBfmpeyJ/qVlyn15fGGe7Nz44gEM06mLZPvk8y
	 pucqhJfTkMJ0g==
Received: from [192.168.1.28] (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-3.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 92657180026E;
	Mon, 24 Mar 2025 11:58:18 +0000 (UTC)
Message-ID: <113a789f-54e8-4d42-b260-829c194758a7@pereznus.es>
Date: Mon, 24 Mar 2025 12:58:14 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios
 property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250321161609.3662-1-sergio@pereznus.es>
 <20250324-massive-dancing-sidewinder-bd51b3@krzk-bin>
Content-Language: es-ES, en-US, ca
From: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>
In-Reply-To: <20250324-massive-dancing-sidewinder-bd51b3@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OicYdhtriXqdG9qklvA12TIxea9ZpqCK
X-Proofpoint-ORIG-GUID: OicYdhtriXqdG9qklvA12TIxea9ZpqCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1030 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503240087


El 24/03/2025 a las 9:08, Krzysztof Kozlowski escribió:
> On Fri, Mar 21, 2025 at 05:16:08PM +0100, Sergio Perez wrote:
>> +  reset-gpios:
>> +    description: GPIO connected to the DVI reset pin (active low)
>> +    maxItems: 1
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -36,9 +40,12 @@ examples:
>>         #address-cells = <1>;
>>         #size-cells = <0>;
>>   
>> +      #include <dt-bindings/gpio/gpio.h>
> This goes upper. Please open any other bindings to see how it is done.
>
> With fixed placement:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thanks, I will fix the placement of include and send new version (v6).
> ---
>
> <form letter>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
>
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
>
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> </form letter>
>
> Best regards,
> Krzysztof
>

