Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 958A91957B1
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0NDe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:03:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55452 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgC0NDe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 09:03:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id z5so11313590wml.5;
        Fri, 27 Mar 2020 06:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4sUrD9MyEjEQo8VVi0oe8ImEVPpX8XndbtrgsNn8Hro=;
        b=k3fAd+N3UUPr5JqvkwyYIQ3I5rmkEDExPOKxSUbK2uVu95M6vI9Cc0n8/HWTVaB5w9
         efRkMUWEMU8vjuR26ph/FAyyTJDcJteeNocO9z8kLNGaeMYi+ff6G0ZpB+d2XLqmVk9i
         Ogkl+er3XssGB7nZ4L85DTPu6qAPIpySqEXeSzvQ8DfMjg2IjlQlyKwUrP6MJ/Nm9HXI
         6rsqqHww23a5IdnfzQuZrxC3zYD4M2wbk+1HXItPIO3oiVD74QMIVMQ/HyXcbID3RB8u
         vGbzNMusIAL00IxOlS8kw55LkxbzNuGo7dPE5zFFuKb85SYNgN0hwn4c389A9OKH0hPS
         smsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4sUrD9MyEjEQo8VVi0oe8ImEVPpX8XndbtrgsNn8Hro=;
        b=cSQ+5TUi5j4tozKOB3h+ue+71PoZerOk7iyOz3S9U8wLpwecWmdL6cihjN+pvcwuQ4
         E9oPz+Bze3B+m8b+97XsWDrsE7+DqADUavu23BK6Qyqu2BJGdJGzsw/r1N82Qu8Yd5V0
         2s1gDcV9TrLXcSqhWf2tizAnmDpp7Tov3ENsl0gVcH0c/s+nbRxqtLSE1rGUOcB+KqKu
         I2SF0BptWGG7XKbbh4Mp/WMNKxhN5NiqspZrLaZHKnmCFX+rtfAFfmof1BKFZhEvkc8E
         +a84Db057xYwGLwzyjIKqqtRg8nasaptmmZ1qeym4yhCZi4SAs/0cZokiBBSzAoXE3At
         ll9Q==
X-Gm-Message-State: ANhLgQ2Zj3UOgFEyyT4jnQPjymJbMnD5hyQtbvN1L8qe3teOEMgS0aqw
        CSwUhAcSXk1w+5VkFy4Rohw=
X-Google-Smtp-Source: ADFU+vt4R8l6MctQ+O8OeALik5hRcIOsWR7Swbne1HmZmA6QJ6AaKwQ0Y/3YcOWeOBuZIUqrwzXQYg==
X-Received: by 2002:a05:600c:257:: with SMTP id 23mr5479663wmj.155.1585314212411;
        Fri, 27 Mar 2020 06:03:32 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6E13.dip0.t-ipconnect.de. [91.63.110.19])
        by smtp.gmail.com with ESMTPSA id f9sm8028235wrc.71.2020.03.27.06.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 06:03:31 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com> <20200327075541.GF603801@dell>
 <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com> <20200327102221.GA3383@dell>
 <a679aba5-4cfb-1b6c-8cb0-dab3a644f3e7@gmail.com> <20200327112523.GC3383@dell>
 <45f68c40-8e50-e0a2-a89a-b5a164d6b75c@gmail.com>
 <CAHp75VcAq-CwsXccbLVxEwGjZjNhdcbMyM-Y-=SEbmexBidCHw@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <0f344b03-ce5e-4a31-5268-6db4266b352e@gmail.com>
Date:   Fri, 27 Mar 2020 14:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VcAq-CwsXccbLVxEwGjZjNhdcbMyM-Y-=SEbmexBidCHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 27/03/20 1:56 pm, Andy Shevchenko wrote:
> On Fri, Mar 27, 2020 at 2:41 PM saravanan sekar <sravanhome@gmail.com> wrote:
>> On 27/03/20 12:25 pm, Lee Jones wrote:
>>> On Fri, 27 Mar 2020, saravanan sekar wrote:
>>>> On 27/03/20 11:22 am, Lee Jones wrote:
>>> So Andy has reviewed, but you still don't have him on Cc?
>> Sorry one of his hint made me removed him in CC unknowingly.
>>
>> "For the future, hint:
>>           scripts/get_maintainer.pl --git --git-min-percent=67 ..."
>>
> Perhaps I have to elaborate. The above hint for the initial submit.
> Then the rule of thumb: Include reviewers into Cc (to the patches they
> have reviewed), because you can't know their intention and maybe they
> want to follow a development.
Thanks for more details. Between Lee has not recommended "forward 
declarations", the review comment
you gave on my V1 patch (more info on previous email). Hope you agree 
with the same.
>> My fault, added him in CC
> No problem.
>
> --
> With Best Regards,
> Andy Shevchenko
