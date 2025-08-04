Return-Path: <linux-iio+bounces-22291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2CEB1A890
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600E53BF708
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714728B4E1;
	Mon,  4 Aug 2025 17:20:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB328B401
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328028; cv=none; b=F6ry3rMw+mdLlO9n/ndix38LQj+wkW2zqPIpXtOMqxmVojVvM4inTat6wqWIUne9x5MRy8LSTLD/Tt/9LIaH7cxaryfCKeZe7hoIURoP+xV1HLMZMU6GU4z9AXVLg4p7knmfJH70yINCS431Qod0A1849KPeJkxvMtZ0fWuA0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328028; c=relaxed/simple;
	bh=4U5zaExVZKmbV7cVVf1LlmgyfZWgsxdR4Pkey7LgVaI=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=hnleudBlCkhrwelnG/V0ac+O5lIBuYKRiW9gRfP9zbm0laDk4rmdHW6YHSaUlWZ2c+gjOHK/XksqZWwb1j0Pmb9JM0aAPhPwpmxdBbn5eTffBqm7ZWzPhQTjLBhI64lPAsutC0RJ3PBrrYzeN0hj5jcbQ0YRp8tLsyMRHLTczgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1uiyrI-0008wi-Cc
	for linux-iio@vger.kernel.org; Mon, 04 Aug 2025 19:20:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [bmp280 v1 6/6] iio: pressure: bmp280: implement sampling_frequency calculation for BMx280
Date: Mon, 04 Aug 2025 19:20:18 +0200
Organization: Linux Private Site
Message-ID: <878qjzknql.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-7-Achim.Gratz@Stromeko.DE>
	<CAHp75VdOFM5rpo7U0GMM74EsbKNHJH-gHU+Gq+kG5bwYUNbD0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:RUXl7vxPBm+NSqenV6Si/MG6SKY=

Andy Shevchenko writes:
>> +static const int bme280_tstby_table[] = {
>> +       [BME280_ODR_0HZ]        =       0,
>> +       [BME280_ODR_110HZ]      =     500,
>> +       [BME280_ODR_14HZ]       =   62500,
>> +       [BME280_ODR_7_5HZ]      =  125000,
>> +       [BME280_ODR_3_85HZ]     =  250000,
>> +       [BME280_ODR_1_96HZ]     =  500000,
>> +       [BME280_ODR_0_99HZ]     = 1000000,
>> +       [BME280_ODR_51HZ]       =   10000,
>> +       [BME280_ODR_34HZ]       =   20000,
>
> Why not order by value?

Because I do not have the luxury to retroactively define how the values
are mapped to the bitfield?  Besides, if you look at the other table
you'll see how these values actually were in sequence in the BMP280 and
then replaced with these two values that are perhaps more useful in
application, but out-of-order.  Otherwise the code would have to do a
table lookup each time one was trying to use this, which seems wasteful
for little to no gain.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+


