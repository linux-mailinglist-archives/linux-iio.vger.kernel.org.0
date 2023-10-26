Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF897D8025
	for <lists+linux-iio@lfdr.de>; Thu, 26 Oct 2023 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjJZJ7e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Oct 2023 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJ7d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2023 05:59:33 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A793;
        Thu, 26 Oct 2023 02:59:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507e85ebf50so887254e87.1;
        Thu, 26 Oct 2023 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698314370; x=1698919170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KI1PEiAO30U0iU1euPlEFOmuh13Lp+HbCIEUsNyPRgM=;
        b=FlfCtxR9DbcWC9xFLedsXXXXEGmuwkFg9zT1ReudUZ3v/arUwFl9CDHB/G2utLB3ln
         CM3DubuAG71adGdqbaDY/0ZNvRCG7w3GdpDCFcjbCxvz9gmhKCWntqlbPSe9Ove/Z0PH
         Eybhn1nVynF+pSBOMSmAW0wbkuu83r23YfYsY9GHivyYEm12r7h6P2EwusFYRw3V7vaf
         jpkGuhbdfoD30leriLKz3+UHYOGvWXrRRH8p7beeSuIAsT8tZymIHYwGo8v3/Ke+kNN8
         OymwFdKcHp1mP+eiVXW/hWTysBZzCCNu5ZadtvFMREwZwsa+E2LicnPPCKXdIEb/zT99
         OqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314370; x=1698919170;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KI1PEiAO30U0iU1euPlEFOmuh13Lp+HbCIEUsNyPRgM=;
        b=Du9ihQIUcXA1R+l9vfFvbNojBMYJJWUCbp9/4hWEG2P8z4ecOkgBv11K5W3PHWHkbL
         Usq3pp7K9mzgFp+MMmJLl6DXXY2qC5DOnnzXEQTMKY2ldLjYlBoaCec28iN/KGTnus4S
         jSd1bmMmM52JSkTHN5D7DCdWZKVYrP8Zsu7DQAcw7P9MEz6iMRrtgNUxnUlBBDOdLAWZ
         e2Fl4LPK7JF+MUqc08q0h4NtxIPTyZei3+da/heIM1bjkJv1JP7ifsemHymhWe79z+fm
         hztoB5ZxsL/xJSsw5BSOovEEpr9bJrJyvl8jlGYXyDplTYLjDxeNHA1O9rF8/wtONNKQ
         BXYw==
X-Gm-Message-State: AOJu0YxQ5V/VwVKxNWYiSXlnTneq03fBr9E8pO60GlgXdTEbG263MAG0
        QXP9M1RFY5gsbZ3mOe+PmPw=
X-Google-Smtp-Source: AGHT+IFU2DhsmE8fRKdGc7spOyWFHAM7Y0b7NWCQvDMUSDXOhLRMnfF4E0z7IhNU+w7WqrtwnsYD5Q==
X-Received: by 2002:ac2:5dcc:0:b0:507:b935:9f60 with SMTP id x12-20020ac25dcc000000b00507b9359f60mr12309156lfq.57.1698314369469;
        Thu, 26 Oct 2023 02:59:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id t7-20020ac24c07000000b00507a68e637bsm2952035lfq.205.2023.10.26.02.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 02:59:28 -0700 (PDT)
Message-ID: <e806f42f-9baa-4689-882a-144647cc03a3@gmail.com>
Date:   Thu, 26 Oct 2023 12:59:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: correct file entry IIO LIGHT SENSOR
 GAIN-TIME_SCALE HELPERS
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Amit Dhingra <mechanicalamit@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
 <a0636e8e-7a39-4c58-8dee-7187ffd7fc63@gmail.com>
In-Reply-To: <a0636e8e-7a39-4c58-8dee-7187ffd7fc63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/26/23 12:56, Matti Vaittinen wrote:
> On 10/26/23 11:33, Amit Dhingra wrote:
>> Commit ca11e4a35154 ("MAINTAINERS: Add IIO gain-time-scale helpers"),
>> updates the MAINTAINERS file. However the files listed do not exist.
>> These presumably come from commit 38416c28e168 ("iio: light: Add
>> gain-time-scale helpers")
>>
>> Fix the entries.
>>
>> Found by ./scripts/get_maintainer.pl --self-test=patterns
>>
>> Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a493d96ffd85..6dd44ec48886 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10287,8 +10287,8 @@ IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
>>   M:    Matti Vaittinen <mazziesaccount@gmail.com>
>>   L:    linux-iio@vger.kernel.org
>>   S:    Maintained
>> -F:    drivers/iio/light/gain-time-scale-helper.c
>> -F:    drivers/iio/light/gain-time-scale-helper.h
>> +F:    drivers/iio/industrialio-gts-helper.c
>> +F:    include/linux/iio/iio-gts-helper.h
> 
> Thanks a lot Amit!
> Seems like the very old file names were left in here.
> 
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

Maybe we should add:
Fixes: ca11e4a35154 ("MAINTAINERS: Add IIO gain-time-scale helpers")


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

