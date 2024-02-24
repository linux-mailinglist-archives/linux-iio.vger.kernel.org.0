Return-Path: <linux-iio+bounces-2979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9B862108
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 01:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CCCB243C5
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 00:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C238B;
	Sat, 24 Feb 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="WeRmfAyK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156C389
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733479; cv=none; b=gZfNv6EZ8TOs1KlVlbKrnQt3PaMmvR7db4gRg6XtJvlVjCPn4BZyYCwnmf9PkzIhs2pzZr2D8158/Vc7MuXqxGaFhzWKW6Yq05T/58BUbCtWdpejJTvIN0qqYx0xTx2B19xWro2SKvV9NR79N/1y2EqHZD3Gdj5irvq93WBvn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733479; c=relaxed/simple;
	bh=EmHMoSZK0WuGciu+lQIOGWywM8sKtSCzetuHOBmJO3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiYoZ9NUS9i45ov0IUANp7w0ZP2uxcfjIk1pjyAqGSuQ7qmAsDDWJGNqkV9TVOI8B/M1cG7OBumQPvbj+DeYDaI91GFRYM+TKxFNlHNy9W5LyTAO7wU3Ap4O2V16PNLis/xlIuyvkrOmWdo2fFIBSUOFZL+Uy0VZi4J244gyzoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=WeRmfAyK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so12410205ad.1
        for <linux-iio@vger.kernel.org>; Fri, 23 Feb 2024 16:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708733477; x=1709338277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izsFz9KLnzRpfRkeqMeNoOMaxIuB4D7Eh5oZ4fPB27U=;
        b=WeRmfAyKKBukl8suo4TvX+R3d4UnDsbOSlL8X012pPdMJYQac10uRefltYn6lQj3lN
         NuOMqCkSCTkoxxd7WMusxCfNU5YRkV/mfR13FYtW40aPTKq9Mxiz2vtDpMrfS/8VCKqq
         di3HP/wvHxK0Z40mRYZMxzPzKHiq1lPmsYt75BqrM4tDccBDeDwKqSI45HVKXNYPMAyv
         Rr03YBCjPnxNBk6nkbXNlMxJGgnihO1lxUhRKC9L9Pg+Y3xFJojh5itvs4bum3Oqr5MV
         e3toQEbI/h6Ueg2Nxdfdo2PBgzqzLCI45G7vy4CsJgQj+Ucj37SKNbuf1uWW2lBF//gm
         BeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733477; x=1709338277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izsFz9KLnzRpfRkeqMeNoOMaxIuB4D7Eh5oZ4fPB27U=;
        b=qDs3CeHDm+XQLUgO8al1QGiV5sE4Vbyj3jPAhDhhBOIJi07vUsBIxFB2sXfAPtJrlF
         Ty8iEaBEweqze9474rgzPNBPcwCdIUcRlYXrdMhNzoSrwHM/+fmeCH4dV1uoZxy1mBo3
         LvB76as5sUUAf6Wx7j1JzIPt0dnvjGidBLSk2z6okrB/rqUejsk1N0ESEDAyb5WhbS8U
         xQT7iVrc3OcB0Ok2f+xUzIi1Z03smIBqsq1cMcE4haePzoR9Y7WF+wLH3QK9Fhl6hOmK
         M4hr8LYBzjmXXsyWbBVHTap0zFs040JZBnCF1P7AR2iCswVzbtoRXEm7gu7cCmQYEdBa
         UtRg==
X-Forwarded-Encrypted: i=1; AJvYcCXnYO2vhj4pOwVRSHXkwat4KP/xqBX5PoxyB5tTisN9qvdSI/bSBw1L2+vvtVwEPXa+vLrsCKN+L7s7+dYrQ1h2ajmvAC+vavM1
X-Gm-Message-State: AOJu0YzJQxPo8v/4mUHQcXfPsEd0as54+50SLFHmBqQPCxY3V+FhpXIZ
	nN4juCq8Vp4/x0sQ9ABtqkDYw1durftWUolYn00OlW/RQzc7a54uajo4i0zhOPA=
X-Google-Smtp-Source: AGHT+IFHxQxKJZFlacj9KQWpZyTQE98KOlH/aRfLE0uUg41+zpY2X5AkjzJNuhFQe3edIC+qLKW61w==
X-Received: by 2002:a17:903:1d0:b0:1dc:6b26:d1cd with SMTP id e16-20020a17090301d000b001dc6b26d1cdmr1731889plh.2.1708733476723;
        Fri, 23 Feb 2024 16:11:16 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id s128-20020a637786000000b005cfc1015befsm60929pgc.89.2024.02.23.16.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 16:11:16 -0800 (PST)
Message-ID: <e1eb76f4-3bea-4d53-818a-9505713a005c@tweaklogic.com>
Date: Sat, 24 Feb 2024 10:41:11 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2] iio: gts-helper: Fix division loop
To: Jonathan Cameron <jic23@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@aculab.com>, linux-iio@vger.kernel.org
References: <Zcn-6e-0-nh2WcfU@drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <20240216135812.07c9b769@jic23-huawei>
 <dfe6e5da-b104-4acd-b323-4a7fa980de88@tweaklogic.com>
 <20240217162724.767f2ab6@jic23-huawei>
 <65582213-1091-4877-ae83-c9450a3610fa@tweaklogic.com>
 <f1511679-0309-4aa6-bbfe-40d0d3374634@gmail.com>
 <20240219193254.2800e00f@jic23-huawei>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240219193254.2800e00f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/2/24 06:02, Jonathan Cameron wrote:
> On Mon, 19 Feb 2024 09:22:24 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 2/18/24 07:26, Subhajit Ghosh wrote:
>>> On 18/2/24 02:57, Jonathan Cameron wrote:
>>>> On Sun, 18 Feb 2024 01:09:33 +1030
>>>> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
>>>>   
>>>>> On 17/2/24 00:28, Jonathan Cameron wrote:
>>>>>> On Mon, 12 Feb 2024 13:20:09 +0200
>>>>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>>>>> The loop based 64bit division may run for a long time when dividend
>>>>>>> is a
>>>>>>> lot bigger than the divider. Replace the division loop by the
>>>>>>> div64_u64() which implementation may be significantly faster.
>>>>>>>
>>>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>>>>>>>
>>>>>>> ---
>>
>>
>>> As I understand that you have already applied this patch but still,
>>>
>>> Tested-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
>>
>> Thank you Subhajit! Your effort is _very much_ appreciated! :)
> I had to rebase the tree anyway to squash an unrelated issue, so
> I added the tag whilst doing so.
> 
> Thanks,
> 
> Jonathan
> 
>>
>> Yours,
>> 	-- Matti
>>
> 
You are welcome Matti and thank you Jonathan.

Regards,
Subhajit Ghosh

