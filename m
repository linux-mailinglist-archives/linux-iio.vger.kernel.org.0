Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1A62449B
	for <lists+linux-iio@lfdr.de>; Thu, 10 Nov 2022 15:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiKJOp6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Nov 2022 09:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKJOp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2022 09:45:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658665802F
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2022 06:45:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 130so2334478pfu.8
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2022 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vixtechnology.com; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9x9mcXLURShJST1wNvTGAqFBywrHCpm5rFlPhpTc+w=;
        b=GMbNXOtEWrHeewrlkFYFD+3pQBUsAd1MAKYqoKPaYbxhnXlOBCtOFquMsaLnS2Ppa7
         6Py8ZsaBTsN5eIlfr6j+4lH3J4Bgcmq3WcEvnyLbeHzGf0b5HK/mmH2BcVRXNbUxxFDH
         yTQl9sl9+SOVVApNy2FJP7G4eX7NzaJiDH2ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9x9mcXLURShJST1wNvTGAqFBywrHCpm5rFlPhpTc+w=;
        b=xmU++NxDgXYl0pDxCbE1B/j8kMaP37boX2gG/mGcAZvW19bUNqwG0/WZsIJbBmBDHS
         hpk/cAvm5+fvt39j+izzgYkXvVe//YoZqy/7DqMXC7zR6Xf7NEL8Dxtzgrxat/jjX9eN
         6pVGZfhSEiHzQ2vH8l6FTusODOKdNTtdwzYWv5Ia/XKr+STMhllRiSTd3Gcqi2/EVDYD
         /f2AX8I2VIx+660eaJxQ/wHctLaKJAW2Sgkoyo8RAKpVLl9Hwm2zVmL0jTO6lXwDpHXP
         Ip6UZAjpoMBeDzK5tJTzeIw0qWTtrF9D2gOsPE2DhPdyrDnX++2Fjd1boH0Q5j6TTtMC
         YZnQ==
X-Gm-Message-State: ACrzQf34pTbWbTY2K/381QeqFbOmTmXohecUQdLC+zXXKTmVpozqf95N
        MOOPrbOu1uzvnysfIJyrE3O6YiA/jHwZf8nGsD6uqV3vLsjspaRHjYumBFmiji/KAxuVi6VfJ1b
        n4RFeN/BMDKca
X-Google-Smtp-Source: AMsMyM6I/k3FZUgvktdtEam/Lh8YsIC7clRwn3QTxwUOfPvYwqgdXnSJlJfRZbMs4yGNHXTdO6DPHQ==
X-Received: by 2002:a63:1a60:0:b0:43c:9bcd:6c37 with SMTP id a32-20020a631a60000000b0043c9bcd6c37mr54232921pgm.125.1668091555699;
        Thu, 10 Nov 2022 06:45:55 -0800 (PST)
Received: from [192.168.1.110] (106-68-237-135.tpgi.com.au. [106.68.237.135])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b00186b5c1a715sm8737029plh.182.2022.11.10.06.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 06:45:55 -0800 (PST)
Message-ID: <b6ac2692-3152-dfc4-5388-7986042970f0@vixtechnology.com>
Date:   Thu, 10 Nov 2022 22:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
 <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com>
From:   Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
In-Reply-To: <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>>                 .type =3D IIO_EV_TYPE_THRESH,
>>                 .dir =3D IIO_EV_DIR_RISING,
>> -               .mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
>> -                       BIT(IIO_EV_INFO_ENABLE),
>> +               .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
>=20
> Probably more concise to use the following, and you won't need to add
> an additional item to the structs.
>=20
>    .mask_separate =3D BIT(IIO_EV_INFO_VALUE),
>    .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),
>=20

Above is the first thing I tried.

Current implementation:

root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
in_intensity_clear_thresh_falling_en
in_intensity_clear_thresh_falling_value
in_intensity_clear_thresh_rising_en
in_intensity_clear_thresh_rising_value

in_proximity_thresh_falling_en
in_proximity_thresh_falling_value
in_proximity_thresh_rising_en
in_proximity_thresh_rising_value


First method (Which you are suggesting):
.mask_separate =3D BIT(IIO_EV_INFO_VALUE),
.mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE),

root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
in_intensity_clear_thresh_falling_value
in_intensity_clear_thresh_rising_value
in_intensity_thresh_falling_en
in_intensity_thresh_rising_en

The above says all channels with with the type IIO_INTENSITY has
the same enable but we require this particular channel (in_intensity_clear)
regardless of direction to have the same enable.
Using mask_shared_by_dir and mask_shared_by_all does not provide the logica=
l
attribute name.=20


This patch provides the below:

root@stm32mp1:~# ls -1 /sys/bus/iio/devices/iio:device0/events/
in_intensity_clear_thresh_either_en
in_intensity_clear_thresh_falling_value
in_intensity_clear_thresh_rising_value

in_proximity_thresh_either_en
in_proximity_thresh_falling_value
in_proximity_thresh_rising_value

Verified using iio_event_monitor:

root@stm32mp1:~# ./iio_event_monitor /dev/iio:device0
Event: time: 1647143384807582753, type: proximity, channel: 0, evtype: thre=
sh, direction: either


Regards
Subhajit Ghosh

--=20
This email is confidential. If you have received this email in error please=
=20
notify=C2=A0us immediately by return email and delete this email and any=20
attachments.=C2=A0Vix accepts no liability for any damage caused by this em=
ail=20
or any attachments due=C2=A0to viruses, interference, interception, corrupt=
ion=20
or unauthorised access.
