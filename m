Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C1A14159E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 03:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgARCmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 21:42:05 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41486 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARCmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jan 2020 21:42:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so28388556ljc.8;
        Fri, 17 Jan 2020 18:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ds2vxYVCII0rQhNGIg+GsyVnkbjiJdX12kWA/mq4wMs=;
        b=sMUiJhurkj+REFjcm9uScNDQIWo6atrRvOjAFPbcL6BpRg3vIFAnr2vdTucrKAIRnv
         Apy8gALjD6klDmBWI6WLZ4Cejs8+lPmONV9jxR1V+3G42wxcyTR48sR6CPBogGl2mLzj
         lYYTq5xwBIF6Sp/gLmW2AzEHytAProEN7//A8mCxjNzPyMkKksCgwwvZiMAS6KuvRU6B
         66tqKw81oNi2vpLmVHR1mfR1R+Gg9mV32d+FsEMvaV74/AWulZCDG2oX7NQ0p64U0fv3
         Jxlv76t7KxZx7Dy1M2p3vC8ySDMgUgRyiU38JM1K0LQtbH8eTf+IhXoYwWuGSZyveE4D
         BDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ds2vxYVCII0rQhNGIg+GsyVnkbjiJdX12kWA/mq4wMs=;
        b=riC5k9EOdhI2ji50issVyeOHyZVDpDS7znErQ8ngLOUg5Nik955Own7Ei/r2czVg0T
         yXbOCuACssx8BqRBJsoUaezvuqxXxU1gHsdgoFID+tbCqMBEgtJEv3A0smFCo+ykXwPs
         RuWKgtk0ABUsW8ut7/MLgrSU61prDyZB8HgmMhm9Wdbpjc/d7NM0X+qMymyS1jpjRwQI
         zX9GSzDkrchz8nD43k9VlDEKIQY4uUGwHhPDoG9krSuAAtzoiM2qITzZmaPaVIC6ad/W
         UJETsMuvBkdQ75EBjUnKm2ZP6oQnIs8BQS05/YyiE5RXY1/mZ/GyqqZ3lrW12RPKRUDl
         oSeg==
X-Gm-Message-State: APjAAAU8QCrzZwzJGVlwIicUPl1IUU7FkD8lWTsc7mN9Of9GB/129jBZ
        M/btD9f7g34OoRDevzQB8qZV5QFp
X-Google-Smtp-Source: APXvYqx4SPgXNQgiofbWRBqxg8Hg8OszJg54wd+IHTNo65z8DlowN83LeuGQdUx107VLbo6GadT5jw==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr6949836lja.188.1579315322666;
        Fri, 17 Jan 2020 18:42:02 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id z22sm13103530ljm.24.2020.01.17.18.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 18:42:02 -0800 (PST)
Subject: Re: [PATCH v1 2/2] dt-bindings: iio: accel: kxcjk1013: Document
 mount-matrix property
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200112203301.30235-1-digetx@gmail.com>
 <20200112203301.30235-2-digetx@gmail.com> <20200115153941.GA9685@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <48acb337-5928-975c-e0cb-046278464203@gmail.com>
Date:   Sat, 18 Jan 2020 05:42:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200115153941.GA9685@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

15.01.2020 18:39, Rob Herring пишет:
> On Sun, 12 Jan 2020 23:33:01 +0300, Dmitry Osipenko wrote:
>> The generic IIO mount-matrix property conveys physical orientation of the
>> hardware chip.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.txt     | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks!
