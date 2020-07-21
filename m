Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F320228A6E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 23:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgGUVOI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGUVOI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 17:14:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE8C061794;
        Tue, 21 Jul 2020 14:14:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so10803717plx.6;
        Tue, 21 Jul 2020 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rpt9bSWm2E5KIDVY+Us5ewHAQ7h1AF13LCnuKIr+ttI=;
        b=fYbtwxBRfArG280BdvUsbc/kyiSIKbxvU1qoB4939g3PDv6ZWrXaq43OuBgPEi3Xwo
         lR5d8HRhj4mRCyK5X8eUyJxn0AFP5mY85OXr+URElrNx3w+9YuX+ZXzKFAEfYFcOGLOj
         ZO2PVHo+Hp4C/msrRbW8GysR3gHVd0SyKKWD4Lru4q4pXInT2qa+HkvyKBS85pWb8qkC
         jvhvpyDS5TUY4acc9HcfiZxrcDZj70p0iJjOkb2cZNWIvMZLqEnsMHCNx1UHaXMDBIGe
         7iBB7gG+D8cSaKKJZQQtdBkT3DIBLYZqXWqTjJSMiPpOvSPW9iKAA6BXVexKESBPcZLV
         cxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rpt9bSWm2E5KIDVY+Us5ewHAQ7h1AF13LCnuKIr+ttI=;
        b=hI63OYUidqbS7D2F7ruzwrNenSKum3E8Ob8SKIKuwQMyYQDlbOjFe+mfW+L6zRYreC
         wVodqEy+Ah/hDXDpZjSGFVff0TWQqbtT8/Qt9XYSk6mU6cXMa3y1BnSDhX/hDvkMViqW
         9puarv+zGEdVkZ+1lqmVtC0Wq7ein/uN2MBncqDwqFTduErgs7IAsIw23JjBc5Oqa2Sf
         mEHi6O1+YlBbKBYK+nwrlRF0Ei/e6zWU8ug99zQQpeuvNJt1ktqXeARVq7J1GW4F2M3P
         7esNFe+MgM1WxPnGxb1TTgrw6HquzcCA6kA7jGZZDS37wufNRzJ+rMfLi1Jxst6cnrGG
         1vpA==
X-Gm-Message-State: AOAM532SSfp3f0X1DF95pHV8DLkDkKFWLNztNKu7VNmAV5EomZYPBIYs
        cg/glAw1safOdu4bDR3G7SxbDxHK
X-Google-Smtp-Source: ABdhPJyGnKpsQSw/7/Aeq76H5/e9uSgBke/y2utLoD8jQobNCjnDAfsAkkr63qXBRElJFByTBSAXFg==
X-Received: by 2002:a17:902:b410:: with SMTP id x16mr5203180plr.99.1595366047449;
        Tue, 21 Jul 2020 14:14:07 -0700 (PDT)
Received: from ?IPv6:2409:4072:593:314e:d028:8959:a8a3:a7bc? ([2409:4072:593:314e:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id e20sm21024104pfl.212.2020.07.21.14.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 14:14:06 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] iio: gyro: Add driver support for ADXRS290
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20200721181926.27046-1-nish.malpani25@gmail.com>
 <CAHp75Vdr+Uo2uw3mzYP+LMRgp-eyi+YjG=O+wGVqyYx-+MRCaw@mail.gmail.com>
 <7ba8469a-dd8c-1686-6d26-e2a4cbfedce9@gmail.com>
Message-ID: <13edcfdb-bb03-26e8-8392-e31a68b322cf@gmail.com>
Date:   Wed, 22 Jul 2020 02:44:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7ba8469a-dd8c-1686-6d26-e2a4cbfedce9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 22/07/20 2:05 am, Nishant Malpani wrote:

[...]

>>> +                       return IIO_VAL_INT;
>>> +               default:
>>> +                       return -EINVAL;
>>> +               }
>>
>> ...
>>
>>> +               *vals = (const int *)adxrs290_lpf_3db_freq_tbl;
>>
>> Why casting?
>>
> adxrs290_lpf_3db_freq_tbl is of type (int *)[2], right? Without the 
> casting, an incompatible-pointer-type error is thrown.

Sorry, the above is incorrect. adxrs290_lpf_3db_freq_tbl is a pointer to 
an array of two ints.

[...]

Regards,
Nishant Malpani
