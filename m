Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864962C3E6B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKYKtW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 05:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbgKYKtW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 05:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606301361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOA5VDKHhjDhRvAG+TX42/n1HWfrsSz2skFdvtbWLSo=;
        b=CKut/mizr29+yjnfJBL3en9Liy5Oj3ZQcssB+phKPI6Z/z6YTMZbK12muOohjJi64RxgcY
        9mMRpJWUvr/JIYuqSAk4Rr01+pHf5cJOPneSyvQpskbt6bGCms9zVP/7VMQAPXDdHLqQEK
        4dmf9AfTidg6JLt1rISfOfdgCcp+5MM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-IyBtg4mANy-DaxgbJonkoQ-1; Wed, 25 Nov 2020 05:49:18 -0500
X-MC-Unique: IyBtg4mANy-DaxgbJonkoQ-1
Received: by mail-ej1-f72.google.com with SMTP id bm18so69025ejb.6
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 02:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOA5VDKHhjDhRvAG+TX42/n1HWfrsSz2skFdvtbWLSo=;
        b=ge7iMxagS/eTGhWXj7mv1SZQzurVCzgwgUTzKRz0m0PFXD4KR89iuIUcDG2+X2AG0N
         nUKdLlM6VEqk+G2uCBnJwRQO53IDsOfT5wqEzgPcOtgWcdEbwfmUOzougMulTrZg2w6n
         ry2hdPzWvqhhofCY2OjRnOSHYpm3x1NNx3VOu2WVGgWz1t2PMGe7HTEUnNufuQOs+Bov
         3mK4h5QAtla0RpZOLeMZOMnaiZfluI2u25qNd+ugPafJ5dXJM3WWWGg9POgij7t6WXY0
         sCeGztO0IOhlCKHa0KCFYd8m/AXF6a1E2Bm4txwGiVAprqtm0KMklxQxOUksMYd+6kiw
         HHwQ==
X-Gm-Message-State: AOAM531V5KgBjtfDF0jsmiOJHc54wrCiFqWUSXAbkLUSPuXBTbGr7Hpp
        MG0WWF2mbZVUUC6kfuNEfx50cPWEc6CQHMF0ub9Bj6d3HI3P1z9YDLJhx7stgRfEgyhibHGecVi
        9ore5ZHeQZEjdBVV/Fmf16kU9cosYM5CJG/FdGfzj+gD96YrQyvwVUskcSCuGgaszkobt6xvY
X-Received: by 2002:aa7:c058:: with SMTP id k24mr2857431edo.263.1606301356841;
        Wed, 25 Nov 2020 02:49:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0Iz5ICPBWkpqXAYcj5YqH/otmWEnGx6dENeRp81HRVYDJ53+fuHxJ6El+0a3pYw1SHdvJwg==
X-Received: by 2002:aa7:c058:: with SMTP id k24mr2857413edo.263.1606301356658;
        Wed, 25 Nov 2020 02:49:16 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id h22sm1016171ejt.21.2020.11.25.02.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 02:49:15 -0800 (PST)
Subject: Re: [PATCH 1/3] iio: accel: bmc150: Improve ACPI enumeration support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201125083618.10989-1-hdegoede@redhat.com>
 <CAHp75Vfu+PC-QzzE0_guwLHTdBXes-7RxbaS85df_p4Z=qR2=w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ec8c6e1e-f914-9ee7-133f-2f55d7cc8dfb@redhat.com>
Date:   Wed, 25 Nov 2020 11:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfu+PC-QzzE0_guwLHTdBXes-7RxbaS85df_p4Z=qR2=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/25/20 11:41 AM, Andy Shevchenko wrote:
> On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi All,
>>
>> This series improves support for ACPI enumeration of bmc150 accels
>> described by an ACPI node with an ACPI hw-id of BOSC0200:
>>
>> 1. Add support for nodes which describe 2 acceleromers in a single node,
> 
> accelerometers
> 
>> fixing: https://bugzilla.kernel.org/show_bug.cgi?id=198671
>>
>> 2. Add support for reading the mount-matrix from the ACPI node.
>>
>> This is done in patches 2 - 3, patch 1 is a trivial cleanup which I noticed
>> could be done while working on this.
>>
>> Patch 2 is based on an earlier patch for this from Jeremy Cline:
>> https://lore.kernel.org/r/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com
>>
>> That patch was put on hold because normally ACPI nodes which describe
>> multiple i2c-clients in a single node are handled by:
>> drivers/platform/x86/i2c-multi-instantiate.c
>>
>> Which I tried to do at first, but as explained in the commit msg
>> of the updated patch, that is not possible in this special case
>> (because it would cause userspace breakage due to the modalias changing).
> 
> This is marked as patch 1?!

Yes my bad, sorry.

> Usually --cover-letter produces a correct template...

I use --compose, time to switch to --cover-letter instead I guess.

Regards,

Hans

