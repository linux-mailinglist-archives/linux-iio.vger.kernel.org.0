Return-Path: <linux-iio+bounces-3207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC59286BE4E
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 02:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E7DB21B43
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390752E646;
	Thu, 29 Feb 2024 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ELJO8Bj9"
X-Original-To: linux-iio@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878482D602
	for <linux-iio@vger.kernel.org>; Thu, 29 Feb 2024 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170590; cv=none; b=tHHvKbqn9L0cGbddc9yV/aRg9Si7/NWoxk65ijg//kAcYIb/zVhNbiZ+xZaahQhq5kOX65kVMPeBvmWbFcX3c3vQhY/wWzUqyhOCuCduB0IZFS6OWIoVRzO9RJdzQ3BE35JGTe1zW91qAp4rHMfOFaxnOYn0G1BACZMfG20FjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170590; c=relaxed/simple;
	bh=+q2AytV+UscXohFfoUnQzX7SS5YtqNU5pYoLOmw3iMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAlRpsmEiyrp9/HJnjvTZJ/YICVFrudkDPmOWi/Mm4TpWRJH5ZZ/O8m8nGd7SBU9GzygswXAfwCabmjKRIcnSG3OlugU2l4xwh2mVIIfgc3OpYZnMBt47ezzN8xsMGgJe6+Pl2MC7zp/0yiw9Nkpx6edoMCxC87zvTmSMOvtNr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ELJO8Bj9; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id fUaDr50CQs4yTfVLXrigaG; Thu, 29 Feb 2024 01:36:27 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fVLWryQ8YopH5fVLXrJung; Thu, 29 Feb 2024 01:36:27 +0000
X-Authority-Analysis: v=2.4 cv=OeCeDATY c=1 sm=1 tr=0 ts=65dfdf9b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10
 a=kwRZLr0jWMAg0_Wj33cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iICL8pgfW/eValc0KcsgShjcYjIIkOjZx3q+9YTL2YU=; b=ELJO8Bj9iMneFv7JC7NmH7UfR+
	g3TzcaAOp/fsvnRTc0nv6FPuxXS1rmofZjAgM9xgiqmDJbxCRVeT7z4+baskZePZ5zAGQtgXwgHQu
	JpUd4pr/VhZ+kJ7GI3K6iYAyeoPdAtuevqTXNuCNgUcY77pw2nZlDUlNd5N4gjcNQwEsDEqG5XKGQ
	v+lCm6CmYcGG1ilpML1wGXvZYFSTc3fZhNlLZS+DTF2vbrRFYwR9/fBstubGpRgqQkbXWlwdLFVCF
	EkuimUCvI7CTu+JWTBXZU5tyNGxXGwZFlqF6/BNo3duYtIOpN/De+o3hBnbkGy4+XX6pGfM6koybY
	nKqEsKDA==;
Received: from [201.172.172.225] (port=34076 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rfVLV-002v75-09;
	Wed, 28 Feb 2024 19:36:25 -0600
Message-ID: <126f4cb7-7164-43d2-bf0e-1192d1438338@embeddedor.com>
Date: Wed, 28 Feb 2024 19:36:22 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook> <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
 <653bbfe8-1b35-4f5e-b89d-9e374c64e46b@embeddedor.com>
 <20240228165730.3171d76c@kernel.org>
 <49f55b02-ce21-40ac-a4cc-02894cd5eb8f@embeddedor.com>
 <20240228171509.4eeb5519@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240228171509.4eeb5519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rfVLV-002v75-09
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:34076
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 30
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL1j3xV82tNFGhpS/WPJRw/3Jh/p3v47UtpxnTjt/oEl1GykKoh4MMF3CYrqlPGtiZmLySKJu9H/Wk42AG3SRfdFSGolog54KKrss0UXhPatldvZXGuR
 RCPc5myR7BsjUn5LA/bogoJbGUfZWOCmebaSh4Bn/zguAS1zLWK4E28izsDfD7tD5WfIQ2mhPfn5ehrZ+hQpGyidpCx60mDXKJM=



On 2/28/24 19:15, Jakub Kicinski wrote:
> On Wed, 28 Feb 2024 19:03:12 -0600 Gustavo A. R. Silva wrote:
>> On 2/28/24 18:57, Jakub Kicinski wrote:
>>> On Wed, 28 Feb 2024 18:49:25 -0600 Gustavo A. R. Silva wrote:
>>>> struct net_device {
>>>> 	struct_group_tagged(net_device_hdr, hdr,
>>>> 		...
>>>> 		u32			priv_size;
>>>> 	);
>>>> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
>>>> }
>>>
>>> No, no, that's not happening.
>>
>> Thanks, one less flex-struct to change. :)
> 
> I like the flex struct.
> I don't like struct group around a 360LoC declaration just to avoid
> having to fix up a handful of users.

That's what I mean. If we can prevent the flex array ending up in the
middle of a struct by any means, then I wouldn't have to change the
flex struct.

--
Gustavo

