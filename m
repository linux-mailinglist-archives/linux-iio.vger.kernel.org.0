Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39880F93AA
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2019 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKLPJb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Nov 2019 10:09:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53573 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKLPJb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Nov 2019 10:09:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so3575959wmc.3
        for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2019 07:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aSl0LyTawSn+4r58PlUoB+DUgsfAv1YZ7/oux0VYeP8=;
        b=zb5xiUOcnru81TxUaxJ1IJZNc9ek2UhDkiPCcZHBREb5UqV31WJbp6/yQpcHx2dIYd
         YVOkRRuPCagkDAMEUw1Ga8/hKa0HfkqTD6fLIyk+Um7aZSbvghpc/ml+Cx9XC/jcJ5F1
         uK9EDSNX/dv6mSyDEy1C7HqSH7XIF5WtbPWafdMoakVCiykK5ddcqKL3ZvDFRigxN9v4
         8VwTcMvMM/HO8MlYknVCjsaaKi8WlzqyRw6fBRbt4xCVQwfSF4MXJtktqbGrvGnvmYdL
         yCvrfug8Ji0TaptcyNG7R3ueTW0Z2K6dMJnhKnJZEQX9HhBol8t0vF8fL4WnPHx7tKqD
         SvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aSl0LyTawSn+4r58PlUoB+DUgsfAv1YZ7/oux0VYeP8=;
        b=srJ89bco/s0qm+gGnb5KnyBoC4dJlg4MyAitt/YhnWWd5APwMawe91+OoJgpskJsdC
         NAyWOOX1PZ+b02z7AmH+6DUsPXcEimQ/PJDRlmyh7Fk5Q7jLTSBn5IFFAdXVqdWbeD3e
         LIgylLkq1xHmdF+h7q84/pPdPK811UkL1Bv0xnPRvEFY9qgzb+5efjLGTsc9nmejzzwi
         vPJMsFhhqPGuV89CCuWOa5ZAMOeWt2EWT0gMTnPOhzbn9ckbLJIL1RxEjiNJaWPMwfJL
         98BNw+H41D01c6YtZzo2VHZ60TRAnKXju93csA1112IhwF4ZOsYz7grGsJw6AiLbvmip
         7fcg==
X-Gm-Message-State: APjAAAVUt8gtKS9lcEe2HvNoA+3bcMLx8XbrodOAn5cwFCoc1JRKBsog
        xitLAoGxc+R7mkd+ebrCfDe/+VdDGL4=
X-Google-Smtp-Source: APXvYqwrPBv8b9u51LND0Dl5unYeHL5J6ltG2hiiIKhAHuTe2094BtbQ97CSo7wNyXfL+GEWg/slPg==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr4788221wma.90.1573571368620;
        Tue, 12 Nov 2019 07:09:28 -0800 (PST)
Received: from [192.168.1.32] (230.120-247-81.adsl-dyn.isp.belgacom.be. [81.247.120.230])
        by smtp.gmail.com with ESMTPSA id t134sm3796875wmt.24.2019.11.12.07.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:09:27 -0800 (PST)
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
To:     andrea.merello@gmail.com, Jonathan Cameron <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-5-andrea.merello@gmail.com>
 <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
 <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com>
 <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
 <CAN8YU5ORoM69GDi4VVGf6iWb3A2S1ZjkiLmcV+_hUbG4446yXQ@mail.gmail.com>
 <20190921181253.43fa0071@archlinux>
 <CAN8YU5O5ouLXnpi=f1jHfbbVXGjtFOT00cG+fggWWbxDco111w@mail.gmail.com>
 <20191005105534.1a3f077f@archlinux>
 <CAN8YU5PRO5Y5EeEj2SZGm5XfuKSB1rtS7nKdu6wWxXYDOfexqw@mail.gmail.com>
 <20191022095621.6b4c550e@archlinux>
 <CAN8YU5NEaXrGJBGmDxZB5uxQQ5XoyUFLscgFAVKCCK3oKHwGQQ@mail.gmail.com>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <9ea595fc-d53b-3cd4-a511-db2b09726606@essensium.com>
Date:   Tue, 12 Nov 2019 16:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAN8YU5NEaXrGJBGmDxZB5uxQQ5XoyUFLscgFAVKCCK3oKHwGQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Le 04/11/2019 à 15:12, Andrea Merello a écrit :
>> Il giorno mar 22 ott 2019 alle ore 10:56 Jonathan Cameron
>> <jic23@kernel.org> ha scritto:
>> As you said, Charles reported that he didn't face this issue. As per
>> your suggestion, I will repost with the example, to see if Charles or
>> someone else can reproduce the bug.
>>
>> Apart of this, I'd say that most of what we have discussed indeed
>> don't apply to the current driver yet.
> As you said, Charles reported that he didn't face this issue. As per
> your suggestion, I will repost with the example, to see if Charles or
> someone else can reproduce the bug.

Hi guys,

Sorry for the delay. Yes, when I developed the driver I was able to 
switch from any to any channel without issues with this driver. But from 
my understanding, there are different modes for this device and those 
modes can impact the timings to perform the sampling + getting the 
result. Maybe it can explain this situation?

Unfortunately I don't have access to this chip anymore so I can't 
reproduce it again. And obviously I can't confirm your changes. If on 
your side the change works fine, I don't see any reason to refuse it.


Regards,

Charles-Antoine Couret

