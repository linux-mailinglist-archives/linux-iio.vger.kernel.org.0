Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E7220E9
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 02:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfERAnV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 20:43:21 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:39094 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfERAnV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2019 20:43:21 -0400
Received: by mail-qt1-f174.google.com with SMTP id y42so10089917qtk.6
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 17:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=clPx5F+2MFM8vIB5z0jK5OSKXvStVdJmeqx+nTg2XH4=;
        b=rUgyvzTaW1X9pztdnQQFAbB0HhVwZ/VC03w20s5b4GQwH0RHa3K5s7drNkBxfVz3fj
         HYtCh8GT2hZdqvtWRJ2qr6K+fi81suXjyt41TZAaiLkrRRWV2yHcBXIuMtKyA9Gd4GGo
         3+AparDo2qlH2Ml1CDuY+o5l/jumVvVOQchMyPTT5lgYaY0O7AyGUUdR19RozNsbqdeQ
         CEBOkI1DSYjNRKN6D8ljGNxUcZEMCfEnsnEdalJdECzUx6X1pu2amo4CUWzVJLcNRtGD
         PE2rwjLGYJzrdrIXNQkxNAuuSwI8oR1ALrFvrREm3uZGCI+sqyWRcnJhgtgFQnEAoMKx
         3vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=clPx5F+2MFM8vIB5z0jK5OSKXvStVdJmeqx+nTg2XH4=;
        b=BVRMrxt3D7hNAAd2fG5Bhm5k24ZgStniNbasGsbZPskPbxNS3dbM8DO56UajF/EAMV
         rEVTwPEgMc9/hvJQXQONBx6LuJAuNzDXTCaHzMNf8zYgAlaLzMqTxAenXUlBg3YVi/Kv
         oAUBlDHE5YwslCIc6pKAs1PS+XUXq2r1Nu41HZouUrksmxauQhVqJNV/SJLFSwJdLkgO
         fGeL4ycDNWtSPdQjSi6sJtc/vY+56/DdGQiga+0q2LoBcPlGGfDHyQfwqwp12xI7d5hj
         117d8aeH2Fhgdj7ySyYW4g4ho2HzPlGWun8syCwtVSlgTf8ceJ+s1KVV071xammZGVe1
         rJ2A==
X-Gm-Message-State: APjAAAWK25B16FSvFGfgvyDE0/RFUffq7vQy8SWF5Uduyq44Qs8FDaG4
        dAzsKquNYE4s5RRt0gWBo3E=
X-Google-Smtp-Source: APXvYqxN9Dw0jR5iK7g0AGOSlb7XrQnSHWcgjgAz6cB7PCm61z+CJhxvdtTYMq42Q2fCqhlZ3sVkGA==
X-Received: by 2002:ac8:2817:: with SMTP id 23mr16135027qtq.174.1558140199591;
        Fri, 17 May 2019 17:43:19 -0700 (PDT)
Received: from renatolg ([191.180.132.215])
        by smtp.gmail.com with ESMTPSA id v126sm4980431qkh.86.2019.05.17.17.43.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 17:43:19 -0700 (PDT)
From:   Renato Lui Geh <renatogeh@gmail.com>
X-Google-Original-From: Renato Lui Geh <renatogeh@renatolg>
Date:   Fri, 17 May 2019 21:43:14 -0300
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Renato Lui Geh <renatogeh@gmail.com>, jic23@kernel.org,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com, dragos.bogdan@analog.com,
        linux-iio@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: IIO on KernelDevDay
Message-ID: <20190518004313.xodfmsnpac33stco@renatolg>
References: <20190415220946.wev5gjdh6dn6hmot@renatolg>
 <20190416125155.00001793@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416125155.00001793@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Sorry for taking so long to give you an update on things.
We've been quite busy with the organizational aspects of the
event. Anyways, we're all set for KDD. We're keeping touch
with all the great fellas at Analog, who've helped us a
great bunch. They've helped us set a battle plan for
tomorrow and we're ready to put things in motion!

Adding a tiny little comment inline below replying to one of
your comments. :)

Many thanks!
Renato and everyone at KDD

On 04/16, Jonathan Cameron wrote:
>On Mon, 15 Apr 2019 19:09:48 -0300
>Renato Lui Geh <renatogeh@gmail.com> wrote:
>
>> Hi Jonathan,
>
>Hi Renato,
>
>>
>> (CC-ing linux-iio in case others would like to comment. :)
>>
>> So some history to begin with. Since late last year, we've
>> been attempting to build a tradition of kernel contribution
>> amongst students here at the computer science department of
>> the University of São Paulo (USP). We made it "official" and
>> created a student group made out of graduate and
>> undergraduate students: FLUSP [1].
>>
>> We started small, but as you probably know, managed to get
>> almost three drivers moved out of staging! We've been quite
>> excited with what we've achieved so far and decided to open
>> up our small group to the whole University.
>
>It's been great to see your activities grow!
>
>>
>> Since then we've managed to get some new people involved and
>> some of their patches sent out. Recently we have received
>> quite a big influx of students interested in contributing to
>> the kernel, and so we wanted to do something big. We came up
>> with this idea for a KernelDevDay [2], in which we get a
>> bunch of us in a room and spend the whole day sending out
>> patches to a specific subsystem.
>>
>
>Sounds fun :)
>
>> We were thinking of going with the IIO for this debut
>> version, as that's the one we've most experience with. We
>> intend on working on 5 or more specific drivers (depending
>> on the number of attendees), and our objective is to move
>> them out of staging. This event would happen on May 18
>> (that's a Saturday), with several patches sent throughout
>> the day.
>>
>> We know that your review window is on weekends, and that
>> this might mean a high volume of patches on that day, so we
>> wanted to let you know of all this beforehand and give you
>> the time to send any suggestions or comments on all this.
>> Like if maybe you'd want us to specifically tag our patches
>> for a later batch review, and not have to deal with them all
>> at once; or have us send large patchsets as opposed to small
>> or individual patches so as to not spam you.
>
>Don't worry about it, but thanks for the warning.  Just send
>the patches out when they are ready to post.  Given this
>whole day sounds like a great idea, I'll see if I can be available
>that afternoon / evening UK time to give some immediate feedback.
>No promises though!

You're too kind, Jonathan. We don't want to give you any
trouble. Especially because of the significant difference
in timezones. Besides, I'm assuming we're only going to be
sending in patches to IIO late in the day, and only after
passing an internal review, so please don't waste your
weekend on us. :)
>
>If we are lucky there may be a few others who can help out as
>well on the day.
>
>>
>> We are also aware of several problems that might turn up.
>> Like that our patches might not be accepted or reviewed on
>> the same day, which might result in a bottleneck. We plan on
>> working on multiple drivers at the same time to solve this
>> issue. We also plan on having an internal review to avoid
>> wasting your time with minor reviews. We also know that
>> you're not the only one reviewing drivers (and we obviously
>> don't expect you to review everything on the same day!), and
>> that the event being on a Saturday might be troublesome, but
>> I think what we really want is to just help out the IIO any
>> way we can. :)
>>
>> Anyway, we'd really love to have your opinion on this.
>> Sorry for the high content email.
>
>Great stuff in general so I'll look forward to the outputs.
>
>One thing I would suggest though is to discuss potential drivers
>to look at on the list before you get started. The reason being
>that the last thing you want to happen is to:
>
>a) Send big changes for a driver that clash with someone elses
>   ongoing work.
>
>b) Work hard on a driver for hardware that is unobtainable / obsolete.
>
>The number of IIO drivers left in staging has shrunk, partly
>of course because of your groups efforts, so the chances of running
>into these sorts of issues is increasing!
>
>Also given we have a month, you can probably get some reviews of
>current driver status if that is helpful to work out where to focus.
>
>Keep up the good work.
>
>Thanks,
>
>Jonathan
>>
>> Looking forward to hearing from you,
>> Thanks,
>> Renato
>>
>> [1] - https://flusp.ime.usp.br/
>> [2] - https://flusp.ime.usp.br/events/2019/04/01/kerneldevday_en/
>
>
