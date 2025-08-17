Return-Path: <linux-iio+bounces-22877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B979B2949A
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226D95E1E8C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89A29D26E;
	Sun, 17 Aug 2025 17:36:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969927453
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755452181; cv=none; b=kpVHlgmKQugoOzHWoRuuUZVlo2e5GHzxU9wIeGpo6XeXFvIbJW7PEzwxqFMVEtMDb+yMmqk205HBsPt3xYMpPw4aVyDEQoAcClExuLQKub4vyDPxAkRWYLPA5YFr5FJDx7h9uxTPRgxYC2jqxIsDAeBkeuPSFqV+i6PiG9CAJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755452181; c=relaxed/simple;
	bh=FTG9I5VRgXsiSthMAfRcngjxStdlo+JXNxJZCQF7vHs=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=nMWV2rF5iflnufCwoxRJXFLZk0jUZ7zgLJHXH4MU34snN7ojbhu/DyqYGyWd6+xqG7MnkIHthMEGWNGYkllJPQd/MFYrYasNBkFbT65PEmS8FjTKUSz1f9Czr3Oek6wjurH6mFoJf1CLRD5auGxs3iPz/waRR4Un3/wC9vfUHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nexgo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <glki-linux-iio@m.gmane-mx.org>)
	id 1unhIm-0002AH-E5
	for linux-iio@vger.kernel.org; Sun, 17 Aug 2025 19:36:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: linux-iio@vger.kernel.org
From: ASSI <Stromeko@nexgo.de>
Subject: Re: [RFC PATCH v2 7/9] iio: pressure: bmp280: implement sampling_frequency for BMx280
Date: Sun, 17 Aug 2025 19:36:10 +0200
Organization: Linux Private Site
Message-ID: <87plctonp1.fsf@Gerda.invalid>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-8-Achim.Gratz@Stromeko.DE>
	<20250817175324.1833d7bc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:+1UWrjPVBNs4wbR0598boHHQB2Q=

Jonathan Cameron writes:
>> +	/* switch mode based on sampling_freq */
>> +	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
>> +
>> +	/* Mode transition or measurement in MODE_FORCED */
>> +	ret = data->chip_info->set_mode(data, data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED);
>
> Use data->op_mode?  However, generally we'd set that only after success of the set_mode
> call, so use a local variable for the new mode and set the data->op_mode to that once
> succeeded in setting the mode.

Ack.  In a previous version of the code I couldn't use it, but now I can
as I explicitly set it to the correct value further up.

>>  	if (ret)
>>  		return ret;
>>  
>> @@ -1078,6 +1156,7 @@ static int bmp280_wait_conv(struct bmp280_data *data)
>>  				       !(reg & BMP280_REG_STATUS_MEAS_BIT),
>>  				       MIN((2 * USEC_PER_MSEC), (meas_time_us >> 1)),
>>  				       (2 * USEC_PER_MSEC + meas_time_us));
>> +
> Unrelated and not necessarily a good change.  Shouldn't be here.

Already removed on my end, just didn't make it into v2.

>> +	if (ret)
>> +		return ret;
>> +
>> +	/* is this really necessary or can we skip if op_mode is already BMP280_NORMAL? */
>
> I'm not sure if this question is for reviewers or something you want to check out yourself.

It was a reminder to check why sometimes the measurement would get stuck
and not deliver any new values, which turned out to be a bug in handling
suspend / resume.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+



