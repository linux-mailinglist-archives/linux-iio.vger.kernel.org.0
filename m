Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88FE3DB400
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhG3Gzn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbhG3Gzm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 02:55:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806A2C061765
        for <linux-iio@vger.kernel.org>; Thu, 29 Jul 2021 23:55:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so19377021pja.5
        for <linux-iio@vger.kernel.org>; Thu, 29 Jul 2021 23:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CXnWAt02bCc8ctyuBNLcX3FDirnz0x4a2u/ozmY97SY=;
        b=SsTrgwJWK1vFG8vvMjU/cssWcalqyo9LxuyHZtBf9kyT7mc8EuvWLwr55pbw/UtSNa
         eXYwTQWLvVMe7DVL7LYNU9s01aU7JSufWuoFrFxEEpCTUm2vozzsVsGUhm6fJSQjw2H7
         Foawh0wkM/S6VDI4vZFYP82i54gPpVaIGjoWVfUqZduhhVcOuG0XI5vaOoAxbCdRjgqT
         +n+4v+UCcZk1Kxe9liTU1cR3mj6ZS+nmhNDXBmxMfDF6MjjaWRGB7pe7JMz+7T3uY+x2
         7j0jPd/LOTOQySPTFCGOjbmpijugUQseAR7yspDmStKNSWGN0cLK5yU/eGfO9GfdBEZQ
         hiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CXnWAt02bCc8ctyuBNLcX3FDirnz0x4a2u/ozmY97SY=;
        b=WaLW2cA3mneC1pFeSzwugPOVr+DiBqQnyeq6d6+QuIVtPCw806sjNIaRi0f8RlNo+z
         XvRTghqNiFUFQPAbs/6P07+Yc1aiWbR2MH7N8a8y53YNLJP+nj8u5n4c516PR5rdHJmu
         J8uckSRobo1jWqDt4k3fZzG6YNkoioVH8UsjRE24h1ZMnep0C+rA0ibmhouwXWts3QGf
         lhNNz1URq2W7TOgMQMbsmdDlU8hkmgMcbSk1ynewu2uJAkTW8xZIo2/UAOmteksGIYEC
         xKKOrw6jRpwqvroQg9Po5HKCZQHfdxCRtTE6+m/QApV6M2P15NwiwYcMkYhX9VilPbqn
         bOiQ==
X-Gm-Message-State: AOAM532ly+zFXyE6l3QBBD8o0P5L8F/5STIG0oJqp2d4wRaNgGagh7ms
        lN/q/hP2Pxag7c+vwVEXCTxiS6rGKszOy+lpRsY=
X-Google-Smtp-Source: ABdhPJymM246Ftwi12ZZjTgl/n7Q56Vczg/Yizfvk87e8dh+0taqJ8AHszw3Hs82bgV2zYdsFA5Q7NoyMRCsj7461Cw=
X-Received: by 2002:a63:f145:: with SMTP id o5mr500172pgk.273.1627628138103;
 Thu, 29 Jul 2021 23:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <2B7BAE11-FF1D-4A3C-9E00-E3ACD280D66E@patricknet.net>
In-Reply-To: <2B7BAE11-FF1D-4A3C-9E00-E3ACD280D66E@patricknet.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 30 Jul 2021 09:55:26 +0300
Message-ID: <CA+U=DsroXD3v85COsvXqB5xkVYTzayuEb-gWWF=-45+MhJyUfA@mail.gmail.com>
Subject: Re: IRQ related query
To:     Patrick Regnouf <patrick@patricknet.net>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 29, 2021 at 3:54 PM Patrick Regnouf <patrick@patricknet.net> wr=
ote:
>
> Hello,
>

[I did not hit Reply All on my first email]

Hey,

For libiio in particular, it's on Github:
https://github.com/analogdevicesinc/libiio

I think you could raise some questions as issues there.

And there's also a wiki that can be browsed:
https://wiki.analog.com/resources/tools-software/linux-software/libiio
https://wiki.analog.com/resources/tools-software/linux-software/libiio_inte=
rnals

Now, regarding IIO events support in libiio, I am not sure [at this
point in time] whether support is implemented.

But an example of getting events from IIO can be found here:
https://github.com/torvalds/linux/blob/master/tools/iio/iio_event_monitor.c

The https://github.com/torvalds/linux/blob/master/tools/iio/  folder
in the kernel should offer some basic bits about accessing IIO
devices, and getting events [which can be driver IRQ events, or kernel
IIO polling]

I was going to answer on the previous question that you raised, but I forgo=
t.
Apologies. It's been a busy week.

Alex

> Please someone tell me whether this is the right mailing list to ask ques=
tions related to actually using libiio or actually please point me in the r=
ight direction
>
> To summarise I am looking for C source code that would capture an IRQ emi=
tted by an iio accelerometer (LSM6DSLTR) all of that using libiio
>
> I have successfully implemented a program that can read the x, y and z ax=
is but that means polling constantly. Not an option=E2=80=A6  the iio_devic=
e_set_trigger however returns =E2=80=9Cno such file or directory =E2=80=9C
>
> Thanks
>
> /Patrick
