Return-Path: <linux-iio+bounces-16331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED15EA4DC4A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 12:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F044166D19
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008A32040A6;
	Tue,  4 Mar 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="O2Eo/dig"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AB1FDE1A;
	Tue,  4 Mar 2025 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086851; cv=none; b=ithq7v9F+DMaZh0p1MrrM/AcipCdNy+23sc9QMv5JBStzbEsPpXRB+QFz+LY4v1AYPRtNuPjMGZHoFdJwt6NpdFxEO3AvRrmju/tktT/7/rqQR8Dtc+NkKrO0eTRK4Cb3z8W1qRFIUQDtswFbwzE2CzsjiguWkAPXgTOgU6NhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086851; c=relaxed/simple;
	bh=XOdBksz8Vf2+lJNphsoE9ZmVFjju/xls/RhmovDo7d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jVqkKFo5STfg2RhlqieYZMVtM5h0vpZ2yyuGxTkpqGShn+p76pc50jfJovHpdwC41P9UauksDgQLXPA9PKW7um/L26Ac/y9EU9M1yPQ7byUAngVkkFwHfHDn/7mlVSH6F3fpNStYZ0u7sbIIg/vP6qxtpaUDXK+FK4FEm7N4WS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=O2Eo/dig; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A114CA028B;
	Tue,  4 Mar 2025 12:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=/mDRp4/mkuaV1Yy1R0fV
	mKQrTdpMwxGr5IRopCnt1VA=; b=O2Eo/diglpqOv6fh4s2gELtN/AllTdGKIItn
	ImtH3HyMZhCZ6Xan9Stww5iUxYWZCP1k8w2zigOw1zl0h64hBtqjR07B9YtIyW2E
	za9el3NCgabIWOEDlZr46F5pvo3BvH+sc05eYO76kx7N8Sj69LzLYWQfpvpRPsZL
	ezZuQqgP0Prd9us6q4wv/+7uDpC/eZfoOvdzEJ3tMmSzED4uIsvq/i5aW0OwvzLz
	KUQCo5g5rgLduUQS4l9bPMSdHlX9HSjryd6b62ahtQ686AhPXYdw6zEDjaSYQXAu
	NoR7bYMu2YCwd9dOaanQLXTThuDJcOmVEQpHpI0qvTZYVUIw6e3UFq4kMuqGrp9K
	1sc47k1o7D3+6Vx4C4YMTfJd3e0copso+vuyNlpY82edA6crKSAaRZTVbZf/re80
	5xG9POmujLgAe/vPeDkW+M5cKuh/m+AJnDjLLgz+v+VQyLllMf4uk9yeDgpBfT5q
	PG3DqdWZSDxSFU//zDaq6dpe4qH9BOFCLnddiM3x+Wlw8eiN+Uq6M6TZtWZC01/L
	PCmqwv99/kv9XYS7pzoZyroV/garfmCY+I+Z9VzNMWPRoNT7yoXEHlh5W5UlvOI/
	k2uaO1wP0+irRhZlgkI+R+95yfu4mJIfRNFxFTADwsMZkJ187nsXXcVo4Qjnku60
	85dx7EA=
Message-ID: <8cf056d7-22d0-4bf2-8dd6-79a45977bfc1@prolan.hu>
Date: Tue, 4 Mar 2025 12:14:04 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] include: uapi: counter: Add
 microchip-tcb-capture.h
To: William Breathitt Gray <wbg@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
 <20250227144023.64530-2-csokas.bence@prolan.hu> <Z8bNFjh85p2jqK9C@ishi>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <Z8bNFjh85p2jqK9C@ishi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637266

Hi,

On 2025. 03. 04. 10:51, William Breathitt Gray wrote:
> On Thu, Feb 27, 2025 at 03:40:18PM +0100, Bence Csókás wrote:
>> Add UAPI header for the microchip-tcb-capture.c driver.
>> This header will hold the various event channels, component numbers etc.
>> used by this driver.
>>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> 
> Oops, I almost missed this one! Make sure I'm included in the To field
> for the next revision. ;-)
> 
> By the way, b4 is a nifty tool that can save you some work and help you
> prep patch series for submission.[^1]

Yes, I have considered it, but unfortunately it still has quite a few 
bugs, for example [1], which has mangled my tags before, when a 
maintainer using it tried to apply one of my patches with it.

[1] https://github.com/mricon/b4/issues/52

>> +/*
>> + * The driver defines the following components:
>> + *
>> + * Count 0
>> + * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
>> + * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
>> + */
>> +
>> +enum counter_mchp_signals {
>> +	COUNTER_MCHP_SIG_TIOA,
>> +	COUNTER_MCHP_SIG_TIOB,
>> +};
> 
> Are these meant to be used to identify the Signals in the
> microchip-tcb-capture.c file. You should set the the counter_signal id
> members to these enum constants then. However, this enum doesn't need to
> be exposed to userspace in that case.

The thought was to let userspace figure out which 
`signal%d_action_component_id` to read, but now I see that this is not 
the way to go.

> If that is the only purpose of enum counter_mchp_signals, then we can
> omit this patch from the series and you won't need to send it in the
> next revision.

Alright, I'll drop this enum. Then this header will be empty at the 
start, save for the block comment. I hope that will be alright.

> William Breathitt Gray
> 
> [^1] https://b4.docs.kernel.org/en/latest/

Bence


