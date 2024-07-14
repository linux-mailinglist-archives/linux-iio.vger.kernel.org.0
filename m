Return-Path: <linux-iio+bounces-7603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5E93095F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 10:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DF8281985
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97793BBE1;
	Sun, 14 Jul 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="dsYaE+xC"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCA1CABB;
	Sun, 14 Jul 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720947101; cv=none; b=b/Ib6DkD1B+37VHlklmewq25mEVcvEWYDGXJO5OwPJkriuKaHIukzQq2UJ+R48/pjWnZTedwdbOUbyZYX9fRox6w+0JS3u7P+6APbKiAnWG5ka3WKkb3VfInS/1bEIUSn0d8t3cvjpouwE76l/anAHIZXF5h2EH9ww8QKcqyCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720947101; c=relaxed/simple;
	bh=XPa/vxwPzQ8ZxZMZ+a5zqSQNdIvO48wg1Zr/3EuLdho=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=D4BRYv1B1+oHQHhipwwhgU0ZH7m5yMGpDldYwPX3Y1FiqigAZzOMaEwaNNt9t8YJEpQIBCFXH36FV0deKzdBRIRudQskK87Sp98wxyflXlI7qjbep6dvdlBqUX+/yHdlvEhq4mTViLWED7tp0ZK7mOoj8IcSW8p0Ptqc78HPhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=dsYaE+xC; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DB05641A28;
	Sun, 14 Jul 2024 10:51:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uDqLGJbe8il; Sun, 14 Jul 2024 10:51:30 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720947090; bh=XPa/vxwPzQ8ZxZMZ+a5zqSQNdIvO48wg1Zr/3EuLdho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dsYaE+xCSezjXVahrI2PJa5MF2vxQhxeBcSaMJUd+HD9XdlbI2nNiqOxJG4AcxCeT
	 VtNe1Ig9qdIzkjdmAmDG8MaLRnf+XRfJMZvOBTJOxSGzJoEHrLq40/+OPQdKhHuHYx
	 nFS8rPckv16pSgCZ31YBHV2YdB7n2awkLRQwXwhl5p1N5xN3o+UPWQ8nCBFn15G/u4
	 EPXtU7scC6j1Cs5GBcZqym3C+eDZyYR+VOzsWnMOQMOoyd1jZsFAC1YezOhMRjbbp/
	 nqIyk0RT1UhYHgJ9q6XQe8Gj99hzjtY1XlPtd0fIIKPCPKooy4VaCUN0oZ4U39vU4m
	 LOaZBPPnIu+qw==
Date: Sun, 14 Jul 2024 08:51:25 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, Conor Dooley <conor@kernel.org>, kauschluss@disroot.org
Subject: Re: [PATCH 1/3] iio: light: stk3310: relax chipid check warning
In-Reply-To: <20240713130627.3d03290f@jic23-huawei>
References: <20240712152417.97726-1-kauschluss@disroot.org>
 <20240713130627.3d03290f@jic23-huawei>
Message-ID: <05773f1b836aad0acb5acae35cca54a9@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-07-13 12:06, Jonathan Cameron wrote:
> On Fri, 12 Jul 2024 20:54:00 +0530
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> 
>> In order to allow newer devices which are compatible with existing
>> sensors, issuing a warning for an unknown chipid indicates that
>> something has gone wrong with the init process, which isn't ideal.
>> Swap it with a friendlier info message to get things right.
>> 
>> Suggested-by: Conor Dooley <conor@kernel.org>
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> Give the patch series a cover letter next time as it makes it easy for
> people to comment on whole series together + gives the series a nice
> name in patchwork etc.

Sure, I assume I can add one in the next version, right?

> 
> Plus this isn't (I think) version 1.  So that should be in the patch naming.

Sorry, forgot adding v2 to the messages. I'll properly send a v3.

> 
> Actual change looks fine to me.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/iio/light/stk3310.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
>> index e3470d6743ef..48a971de6a04 100644
>> --- a/drivers/iio/light/stk3310.c
>> +++ b/drivers/iio/light/stk3310.c
>> @@ -496,7 +496,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
>>  
>>  	ret = stk3310_check_chip_id(chipid);
>>  	if (ret < 0)
>> -		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
>> +		dev_info(&client->dev, "new unknown chip id: 0x%x\n", chipid);
>>  
>>  	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
>>  	ret = stk3310_set_state(data, state);

