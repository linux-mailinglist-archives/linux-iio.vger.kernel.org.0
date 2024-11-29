Return-Path: <linux-iio+bounces-12801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E439DBE3E
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 01:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DB3164B48
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 00:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30379CD;
	Fri, 29 Nov 2024 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="Ms/C/r4v"
X-Original-To: linux-iio@vger.kernel.org
Received: from sonic306-21.consmr.mail.ir2.yahoo.com (sonic306-21.consmr.mail.ir2.yahoo.com [77.238.176.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFD81361
	for <linux-iio@vger.kernel.org>; Fri, 29 Nov 2024 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732840199; cv=none; b=jdDaMmg+j7E7hlD3Mw42Hu0ELBZasNJ2UKcVt9v4DkU3ik0Niv+s3mGI/08doWPOrkqcxCFc+sWeA7dprYx7X0geD2ezY17i3GTcmoUXDLswFoOnKguF3Y5AjXUGkuhiJOYOZMFvc4WXnDkdX3EI8UHMdFLJr5KO2oTJCv2Vm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732840199; c=relaxed/simple;
	bh=c4Vuc+rZvDA6Fe6d7paNieEGinsYbVZphbFiascz20Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWea1vcaWmF5lK0J3q6O0uKt8GQrDUuKDfnrvt3KtHVkNRYPo1qmiI6G7KIwpIMrIbZH2sOl+y3lSUL/8TnUNPZ1bE9asCiPG8bEI1JrxJoE9zKj424deYeywDjYZtJt68Jp7YZ6IMCxXx3VQYHEKg6NyGTUtF/rGYqZVAyAQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=Ms/C/r4v; arc=none smtp.client-ip=77.238.176.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1732840189; bh=rxSduJZx9rogduBx+cQJKkxDL7Rx1oRXXgPW3tAzkqw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ms/C/r4vvutETXoLxapdE5AH8/IrNs0wc1chyWQV4ylH2JYFCpzkX6b5AZIv+jVDRWiXCEqjabD4Y6PTClCDMMPEDgQ4oORxCrxiSYHK5AsEb6zWIIYHDosOG3g7AZPB/iL4oIVSFxZU8CL9sxYgi6nchNXtKZRJrW9wBv7hLY2JyMb+1AtZokgH9qaiJSn+Sg6NAE7AiAeckJmTT6qvQcSZgx5bycu8RZeXvYhhpJaXwr/yQeV3FLx2zgra3OfZFxLfKiKX7t0FwhK+aUE46K9OEsIQotrNINvHy+vMr58iSNSk6KskcL1iC8NeHmKSlKmXBZdsnSf+0FObLOCUnA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732840189; bh=go8VbWeE7aXYx/GPbiwBSBaWE3Oml6LX9kTePLUxtPs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PakUnEIHxjCfyxlUg0G2gccDoMXSVGO6z5OaalnwbC2zhqXe6Du9UQ1vnHWQN0XBb2fFUWDRCWCvrThjJYfG/V4RuHrZAoFY1MVytlxo3eynKJznIDgaOoRPFfYCS10UiofDdn4/IBO3VVxMnXkqp0fJOeoGXiFDXOLD5Z5eaCiHlyt2mOXooqGCubjVujVIP1pVN34BBdxfud+VaOrcgmYUE6itsK+2+znRMTQTjclVOO35VbwjlfkmVCEc43w2XcyO26Kqz12TaI04SAZNivCUX2PMTyRh3bMxynaogESNjQ5lhGFMkhsjaCZVDPy65w+4JSmD/pqNTtLJbHuhDA==
X-YMail-OSG: jp6i37kVM1nAOO5PF.0i3BMY7J9Fa0hsP6MhKiIPUTjLk76mc0VYHm36q8fTBXh
 36a._8nENMPUyGM2xwPSX5FSdHXBhprcXhf5DaoXlASDCCBM9bRgIcusp2wSDPmbo7LVssI3dwss
 B4J9H4SxwYeR5in4DI4mWR2A1yKMjcCJukEsaorpdWIckAolD5jYE0QksFx7xsvftPQWn2TnlcEU
 DNISswOzbohGRmezAXfYLSPBMGna_AWT38c6RrE8JEThbc8lacRuDXA9Ux3rNTGrq1tI7.GHQA5v
 LRcP2RyNxPuGDNtzBxqPerueKOdmrP.27Y.TG7Znc7vFgf_43CNXpR7.B3F3HVJcWxYLl9OlcJiv
 PXCywKJ76XL0TyKHhB.deGMtd4Ui1Y2YLqMQ4bDBNkZpDemraZSEmVNOdUabIK88XQJTcvOJcEwe
 Izu4y9WBacvicTME242XIZMAT18BIaQQH4D6SajgHLKAiM0P.gwhpUdnfQ_4y61Mkv31lTzzEP6N
 aQIOjSwE47tZA8l_XifFq7U4LexLPBKmXrHBjUR1BrMf99_smb9_GnFl5HEFTMbzbJIBB4HSAfQs
 qeEZgnr2X3G58NGm54oxgL6SNqft55ym1QGErh22wfWLh3rwgkJhKiY2pncg37.iQBtieBLs8n5L
 iAth0q1SzXtEqaXL.py3QPtmieXO3ink8ZUbVtdxh_b6WyqWmJRb4yUQYqPB0kRpWTe3QMNLtshT
 CmjGMeyOhR.IqN9A6R1iMaxioQDygisjwMFSq1IfYKEN7ua9ezil_5vqMexjw3AGcw6K.haIDrgY
 kGz1ik72FjxzyXGdMPANLcOkCtfxo9PiL2Lf_47JffNexAJ0dU5UUy8VROhkJf6BHhs.3yGyNSGT
 6NAEkiZ8zXNHP7TaPq_CV_hiUfDKBQxzlKl1AG97w7OVmDDcWPml16RVygfW3Sx9oD7n4pzJ.CiT
 S2mMzNz0BwKqbmlsx.pBmjHVl069pjjrXB0UzAv6DEebIWfcMGS0hb8nFqiYVLXfwEA.A8i03L94
 6BCebRSVC9aorRGEemrLxEUmL8CLyrCm.ElMVC7TFXf_D1A1N7h0Dp5XPIEpGABEO0ezpaAPdbPM
 4loiQ6sL3UO1mSiECdm1S.HwAlsSgVhLuYjFd7dRaAMWVo9.WAWmHnRrVI5FDXSMuwixwbiaV2tA
 jUWgRuhOECHKRE8zGqXrpBY7zPdb._QqTkGchjBlJgNSQ3j5CD4MvZFd8o5V2_6KOgdwZMKFRWAa
 SUxgJFYfhpgzDpa6CZyVORmkkL_fOWnd5Wqg8vEDIL6ysFNcvaVVjwUP6CCjd0VbxKXg5kZb2h72
 yQcwHPFA79ooT5t6VbQW0mMzcDr5XXrLUnPeCJpMb8xi_VCmjzgb3YbH9g8Unp7yifiylPLUpTGg
 0wkkUiK3buDlZxv4_1_i_LpkuWuYhDtVpGykPndrRj17tPoYKS.OfnUDFwePUM1lZOHRKWLsasot
 ITKQGWwpPUCqvL2U6ToEG2VzVb.rge8ueVxJKtHT3vou.Uhh1K1m52KFl4T1cv1tH06wxvQlFZnM
 kwVyYwwkWkji9p5mPbSdTPjMiXR5KUATiAkgBlCTh0a_7taf0KPfuDAxF8VBlO3DXvaiUxTdUO4r
 9ALVytd5HyiIkdKzLnfrDgHXhXIMmpiDh9GkuNeRqTJGp1zpI1lnNrQfgWSqCo39vJGTDTy_GMYp
 Ec3B_8qJ_bcNSUxSgHbUkPBKSnTVQu1WWNz38kKacFF3DTeLpyRfOk4aTi2HEUjUbN6uCtt17wv4
 Ue3q3AyuadxjruRA58J9DH6oCr8i0PXE.w.mfvgT8l_4VQqiSHdivHLkfRAMdpt7ZfGmRReOEc2S
 dRLoQXVoTD6hSRHef6lCGKJKiDujUMS_XrGULCcZuhG3W6rIpZfelJm_LdVsMnQFejbUPdXhQJ_1
 OXn1bCKytsHy1FjD9_uy9ncJKksLdoH39w6rO_qwqYrT1H8kxukGRoeEQU7BRnNyh2CnxKUfwQEA
 bzz1Y79RO5jpeLxGOkbwEV11l_TjLNWOK7lwMYX4RKu3Ejq50B4B80t7gHuwAnCx1Wtue6Up3ZtZ
 hzJdI9i3LGDGp6rvzbSZEcsGI82ah9QiDdcNxq26EokTION.bupEW6JqKk1PMeetNQ_Kr1oskKbP
 zeSplTtUXGUbxwz6812B8Wg5.qAW86VVdT0v1Z8ZKpjS2VsxEf8Eo2ZcJFeerBWsRLKDocL4_LTW
 bv5khgDJsyRZl_FuLCv8BexrpYFkGpWHWXhNk1HdCJnr_4D.1ngzn6KpUPOJe0Eua1VXNKzWWO94
 J1WDMe9r8g.dydFG3V7QJWZCbkOQs
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8e9ab39c-1cab-4e74-aecc-a803bef00087
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Fri, 29 Nov 2024 00:29:49 +0000
Received: by hermes--production-ir2-c694d79d9-d879w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0c72a3444980250393be571c7b9276c0;
          Fri, 29 Nov 2024 00:19:39 +0000 (UTC)
Message-ID: <2662b991-bd22-4ff8-b309-77f0e0f6dc86@rocketmail.com>
Date: Fri, 29 Nov 2024 01:19:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
To: David Laight <David.Laight@ACULAB.COM>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20241126234021.19749-1-jahau.ref@rocketmail.com>
 <20241126234021.19749-1-jahau@rocketmail.com>
 <a28168acf9374c60902cdb5aa7608dee@AcuMS.aculab.com>
Content-Language: en-US
From: Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <a28168acf9374c60902cdb5aa7608dee@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi David,

On 27.11.24 09:53, David Laight wrote:
> From: Jakob Hauser <jahau@rocketmail.com>
>> Sent: 26 November 2024 23:40
>>
>> In the function yas537_measure() there is a clamp_val() with limits of
>> -BIT(13) and  BIT(13) - 1. The input clamp value h[] is of type s32. The BIT()
>> is of type unsigned long integer due to its define in include/vdso/bits.h.
>> The lower limit -BIT(13) is recognized as -8192 but expressed as an unsigned
>> long integer. The size of an unsigned long integer differs between 32-bit and
>> 64-bit architectures. Converting this to type s32 may lead to undesired
>> behavior.
> 
> I think you also need to say that the unsigned divide generates erronous
> values on 32bit systems and that the clamp() call result is ignored.

Ok, I'll expand the commit message in v2.

>> Declaring a signed integer with a value of BIT(13) allows to use it more
>> specifically as a negative value on the lower clamp limit.
>>
>> While at it, replace all BIT(13) in the function yas537_measure() by the signed
>> integer.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-lkp@intel.com/
>> Fixes: 65f79b501030 ("iio: magnetometer: yas530: Add YAS537 variant")
>> Cc: David Laight <david.laight@aculab.com>
>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>> ---
>> The patch is based on torvalds/linux v6.12.
>>
>> The calculation lines h[0], h[1] and h[2] exceed the limit of 80 characters per
>> line. In terms of readability I would prefer to keep it that way.
>> ---
>>   drivers/iio/magnetometer/yamaha-yas530.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
>> index 65011a8598d3..938b35536e0d 100644
>> --- a/drivers/iio/magnetometer/yamaha-yas530.c
>> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
>> @@ -372,6 +372,7 @@ static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
>>   	u8 data[8];
>>   	u16 xy1y2[3];
>>   	s32 h[3], s[3];
>> +	int half_range = BIT(13);
>>   	int i, ret;
>>
>>   	mutex_lock(&yas5xx->lock);
>> @@ -406,13 +407,13 @@ static int yas537_measure(struct yas5xx *yas5xx, u16 *t, u16 *x, u16 *y1, u16 *y
>>   	/* The second version of YAS537 needs to include calibration coefficients */
>>   	if (yas5xx->version == YAS537_VERSION_1) {
>>   		for (i = 0; i < 3; i++)
>> -			s[i] = xy1y2[i] - BIT(13);
>> -		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / BIT(13);
>> -		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / BIT(13);
>> -		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / BIT(13);
>> +			s[i] = xy1y2[i] - half_range;
>> +		h[0] = (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / half_range;
>> +		h[1] = (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / half_range;
>> +		h[2] = (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / half_range;
>>   		for (i = 0; i < 3; i++) {
>> -			clamp_val(h[i], -BIT(13), BIT(13) - 1);
>> -			xy1y2[i] = h[i] + BIT(13);
>> +			clamp_val(h[i], -half_range, half_range - 1);
>> +			xy1y2[i] = h[i] + half_range;
> 
> NAK - that still ignores the result of clamp.

Ah, I didn't get that point! Now I realize that clamp_val() returns a 
value and it's going nowhere here. I'll change that in v2.

> and it should be clamp() not clamp_val().

I assumed that clamp_val() is still needed because according to its 
description in current mainline (6.12) include/linux/minmax.h, clamp() 
does "strict typechecking". The input value h[] is of type s32 and the 
limits derived from "half_range" are of type int. I had a try compiling 
with clamp() and didn't get any warnings or errors. Does that mean that 
clamp() isn't that strict in the current implementation (and considering 
the patch being backported)? Does it just check signedness and is this 
because in current __clamp_once() it uses __auto_type?

Kind regards,
Jakob


