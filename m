Return-Path: <linux-iio+bounces-15738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7066EA3A371
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 18:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98931174C7F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B826FA63;
	Tue, 18 Feb 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iVKPF2gL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85226FA64
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897874; cv=none; b=Pe83hGRurS+1ht3Jf/Z0F8r8km/i8YyPSQrfSs/s8qdlpwm9ICrH/fkBpH0T7lEY4Gq9r9ZBdzwltJHHD1teG2UgO0tuLUd1zR/L5e/JeXki/PzqylsUh5Fc6q6FDqYmgVgPg2/gN9r1dU2HmoOJ8Y1OxChre/mLr5wBBAQrUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897874; c=relaxed/simple;
	bh=Xw+m6GaysUIUf1h96hkYQDpKDREs6jfqdHJ4D8zgUOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zb79EPhUhOIXEQUggZZHWpvtsIcb5nmG0dsa0Q4A1DKLjQguK8dbv4gBj9WmYQOfbHtC+VYXlv0a6O3fRnWVRE0/ixheFmUOewUh2iyS6/wMXJ8AfcC9C6D/12tuXEgg8nDP0/MqHJFbMBL45YF/DnAu79IYqb2GxtCkKCSBzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iVKPF2gL; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso6432197fac.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739897871; x=1740502671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcW8eh6oiYhFxH2I+vpCXN6CxWOr2xbDwj5OJhcTAhg=;
        b=iVKPF2gL6vnWb3V9m0GheuyMx+V3gG+Eub6PQoAXgwXximCRTy+5DZZPc435FXDIw5
         Qlaoe2PQ86v/GON7I7LT4ezOm2gUSZlnNmdN5qnE740yAkKP912v/e/lVyG+qQmGrw+u
         IMl/+a5emYYEFxBe6pGPdKMW2NWy9bZ2Xz611KES3dSu231F4WS+Y+bHN1fsUO8BWjAb
         BWzeJV8Zf8RM9otWSJx4EDE4l7FrT3O/Dyo0TXXISlrJmFGY4uVstREXTzV9taexRUTF
         KZyttW8Lok6lo5kgqLQMQToVgLFPv01hsmTdIT0LX2G0nnqtOPidvJQjb/fegt+wX32G
         oa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897871; x=1740502671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcW8eh6oiYhFxH2I+vpCXN6CxWOr2xbDwj5OJhcTAhg=;
        b=AnrPzeA33VfxYHmUBn30QIAQKTUKbOeM9anfAZoHQqi4ntZsFPDUwiVJFSsRJKG5Uz
         4+CxHQa4GxILzHKAlC3qF+pMQPkCgqctAri0CwqgGVMyRtuTNM8hr+d5XwwqPGqASzXX
         tDW23TDXzBhWU7e5zvk10794IScyMBr+XYifN0WEzRrrNDsEnQIZdsKCbET7LvD0ofoW
         mrcoBn5EPZZd90ZZSzBOJx+YC9h7I6yGXKMYPwK9lVs1Vug694NCiR9s1VYB01Y/hCVx
         t1VR5cdAXCQMnl5a0HfpG2509tPslsfybIFc4N+jroi2qNk4A+1EL02yFQUNCaWbX4wI
         RldA==
X-Forwarded-Encrypted: i=1; AJvYcCVYRud0I7Hnsz5uxu7FasOjDLNjBOD2M6YN3k9CizwXl18cixWqnL7EbcUBQAYFj1Vd0YqKPFdk3fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+SKkZ/aX7QG81Hsnq3jpcEr8CHiq765gaX1QjDXVi+uC6lHjd
	tQEaEkePmQM2Bx3dmvxhyutoJOgidfbYCzKOj4UinHCqftuI0RZovgFrCxlM/Fwy+FxHhibwukq
	z
X-Gm-Gg: ASbGncuY6CcbY+g3nVyYY8qZ31IoZX7HS3yYymTD50r2eu1dPRuw6rvR9StwBpPSKyo
	A/YUw3j33syNXPhNiEhsPYLNI2v+ERFBmnRW5dseS4QY4A7QZlzu5rcjjQp8XS+5IikCO5OjGPv
	/lD8h5a7SVMZufBYcEnVK9TR45DrItzPB6pM34TixmvIJ+pZJn6n01I1P+w/nlW2E0MW1yZjLEH
	w0C9WZcvrs0gbxD8kDe/sOFhQLJWpXpmQWum0kfjIrZza0NMsuEn2s9GzhxDPjLUKbHngXi2nMI
	G2En1QrK3f7qbr++fazTxMYuzOu1eMoPUz5h2ZpWzefTt8G/Vxho
X-Google-Smtp-Source: AGHT+IF/c83y1Cez8hWRSn30GSwoeUsgFxxHiwgDKvQhRrDXN+qMo4Se++QqmS/QOFzDDBE4yb1A7A==
X-Received: by 2002:a05:6870:f6a7:b0:294:cac8:c780 with SMTP id 586e51a60fabf-2bc99a349damr9693359fac.6.1739897870693;
        Tue, 18 Feb 2025 08:57:50 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b963a0dda6sm4910861fac.48.2025.02.18.08.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:57:50 -0800 (PST)
Message-ID: <8bbde047-3f2e-452c-aca1-a9d1bffb1689@baylibre.com>
Date: Tue, 18 Feb 2025 10:57:49 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: backend: make sure to NULL terminate stack
 buffer
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
 <20250218-dev-iio-misc-v1-1-bf72b20a1eb8@analog.com>
 <553ed40f-f0dc-4902-9d2a-9b690fce6ff9@baylibre.com>
 <3ead92b71ccf8b2d4e1762ca369911d637619883.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3ead92b71ccf8b2d4e1762ca369911d637619883.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 10:36 AM, Nuno Sá wrote:
> On Tue, 2025-02-18 at 09:52 -0600, David Lechner wrote:
>> On 2/18/25 4:31 AM, Nuno Sá via B4 Relay wrote:
>>> From: Nuno Sá <nuno.sa@analog.com>
>>>
>>> Make sure to NULL terminate the buffer in
>>> iio_backend_debugfs_write_reg() before passing it to sscanf(). It is a
>>> stack variable so we should not assume it will 0 initialized.
>>>
>>> Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
>>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
>>> ---
>>>  drivers/iio/industrialio-backend.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>>> backend.c
>>> index
>>> d4ad36f54090204bf3bef08457d4aa55aa7c11fc..a43c8d1bb3d0f4dda4277cac94b0ea9232
>>> c071e4 100644
>>> --- a/drivers/iio/industrialio-backend.c
>>> +++ b/drivers/iio/industrialio-backend.c
>>> @@ -155,10 +155,12 @@ static ssize_t iio_backend_debugfs_write_reg(struct
>>> file *file,
>>>  	ssize_t rc;
>>>  	int ret;
>>>  
>>> -	rc = simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf,
>>> count);
>>> +	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
>>> count);
>>>  	if (rc < 0)
>>>  		return rc;
>>>  
>>> +	buf[count] = '\0';
>>
>> Does this need to be count++? Later we return count.
>>
> 
> Don't think so... count comes down from userspace. The termination is local so
> we do not want to return count + 1 when userspace only requested to write count.
> Same deal as in iio_debugfs_write_reg()
> 
> Also note that we pass sizeof(buf) - 1 into simple_write_to_buffer()
> 
> - Nuno Sá
>>

Ah, right. I get it now. Wasn't thinking so clear earlier.

