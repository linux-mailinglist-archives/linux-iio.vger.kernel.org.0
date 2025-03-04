Return-Path: <linux-iio+bounces-16327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B44FA4D9B8
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385927A297A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5CF1FCFE5;
	Tue,  4 Mar 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="iWPcUVrs"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDDB1FC7DF;
	Tue,  4 Mar 2025 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082602; cv=none; b=AncwXXvfdx74XIr5JahljVErbjOc+WjkfgIzrJ/Io2YFqWGFpN8oYQp6h9Z2hVLT3O8mzBZoU09EEG2z4bCDdbJQJgtsixNKzyr74mrKYL89HQdnNmOL3+26WRcBGht4suWFsJruxODdXVkRtRR1ZVyfrS7i1RUm8iyHYKJTM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082602; c=relaxed/simple;
	bh=CVVsRwpgc5R7QK8WI97msNJewKlVvoDsd86E8Q1TE9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Eu3peGrAVkIoaCOhXw/0YqreRJndfn7GWyNvQeiZpJBLYWyqMLZl6n5umqkesY91CnOBDq9+YjnZq5Jd+TeaAjdpDXFLVCDENGyGhSF+ZNdpPwo/md5T7XBBmYxH/ebnNyWhVKrarZJbHDT1TUbV/qXdWhotAQMyLf4wuD4m2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=iWPcUVrs; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DEE8BA0B13;
	Tue,  4 Mar 2025 11:03:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=yCqVZdRR3wuwl1YUaUII
	xJGus32Wsp9w18Z1riLWvQk=; b=iWPcUVrsZN3bKc1ntgJPwKf2w5CUj56/hbM7
	QbTM7wTdc2PqTyGXYDxpyFRuL7HKhsuf2CspjsWK3k4q8qp4JNAJr75bDJV1AruA
	vdoxpnNJIcvDofbKCfIb0PNwk6576KEab40UnMwjxMz2U7u91Tv1apoDRSEICMmZ
	SmtvwO8VTA9JI59X/rhTxpBuXD6bUh0vhvmaMwn8CpNre6BMQdVvKXADMNRzUR8u
	1OOanzAIDxxVzRtK2iJZi48PcbGCGprEO25Gv/jOK4Vwk+lADW85V6J4z83WDisi
	NgSvkeX9+imdXHFs8V9N/Rz9SOjN2EHwZY8Clwp/YiBEv7lWEOASFlh2j7iV24FV
	PvgFtOiiEKW10TZ7ijwr+ME1L7isUDI2KX6NfZ9iaIKoS0fgcL2IGQPzgcS6bdS/
	plgTAaobgQHr2BO6yj+PP7yxTKkZ0We+M5DmR1V48/i1470CXQTO52RDYLtICj4x
	MxUK9JhR9tkuO+nALISyoEZasjaTYdNpxYAMc2xZWzR1z1qlzARnJ1Qd/iDuxbfW
	YbWlN3IOTY3mCP1PEJvNkigPemD+aI2YBdEf5Ur6HfHop/QZ739Aa5CN7iTT+oWa
	/6EMuk2MaAHIo+29qwGYPxahqlDGbcjQLbc5ab+NjxUA3C3GhwPHsVNRq4EepwX1
	GUFKdbM=
Message-ID: <1604dce5-7be6-4a95-a51c-0c760a6c9a76@prolan.hu>
Date: Tue, 4 Mar 2025 11:03:17 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] counter: microchip-tcb-capture: Add capture
 extensions for registers RA/RB
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-4-csokas.bence@prolan.hu> <Z8awGBW8obpG1QPN@ishi>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z8awGBW8obpG1QPN@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637260

Hi,

On 2025. 03. 04. 8:47, William Breathitt Gray wrote:
> It's cleaner to exit early on an error than to carry it to the end.
> Instead of if (!ret), perform an if (ret) return ret to exit early on an
> error, then simply return 0 at the end of the funtion.

Ok.

> The capture2 extension doesn't exist in this patch so remove this
> comment line.
> 
>> @@ -30,6 +33,12 @@ enum counter_mchp_signals {
>>   	COUNTER_MCHP_SIG_TIOB,
>>   };
>>   
>> +enum counter_mchp_capture_extensions {
>> +	COUNTER_MCHP_EXCAP_RA,
>> +	COUNTER_MCHP_EXCAP_RB,
>> +	COUNTER_MCHP_EXCAP_RC,
>> +};
> 
> Remove COUNTER_MCHP_EXCAP_RC for the same reason as above.
> 
> Also, I would argue for these to be preprocessor defines rather than
> enum for the same reasons as in my other review[^1].

Ok.

> One final comment: is RA/RB the best way to differentiate these? One of
> the benefits of abstraction layers is that users won't need to be
> concerned about the hardware details, and naming the capture values
> after their respective general register hardware names feels somewhat
> antithetic to that end.
> 
> I imagine there are better ways to refer to these that would communicate
> their relationship better, such as "primary capture" and "secondary
> capture". However at that point capture0 and capture1 would seem
> obvious enough, in which case you might not even need to expose these to
> userspace at all.

Hmm. Well, RA and RB is what it says in the datasheet, and since we 
don't do much processing on their value, I'd say we're still closely 
coupled to the hardware. So, if one wants to understand what they do, 
they will have to read the datasheet anyways in which case I think it's 
best to be consistent with it naming-wise.

> William Breathitt Gray
> 
> [^1] https://lore.kernel.org/all/Z8alaOTjZeRuXnUI@ishi/

Bence


