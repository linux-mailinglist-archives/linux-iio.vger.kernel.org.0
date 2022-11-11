Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECDF62543B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Nov 2022 08:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiKKHER (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Nov 2022 02:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKHEP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2022 02:04:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7197018E
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2022 23:04:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3973843pjl.3
        for <linux-iio@vger.kernel.org>; Thu, 10 Nov 2022 23:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vixtechnology.com; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/cvJ9sc0hORXX4XNhoBtz3X88Tmy8E2J7Yon6Hz0m0=;
        b=GoHdzeK2cWAWWKiQeIjIc3dvXwxrFUjA+sjpbYdeaaJq0VgmUzle0E8jZ9z1ZBpCfD
         JB0nGdN69DgsmhJOGncMqR5mgYyR2WOx44GqC8fqEtG87ySbQnwNE2wJNog6cnwlwNKk
         JBTzVSZHTKbTy+rlczquokQ+ahbuyGEDzG9rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/cvJ9sc0hORXX4XNhoBtz3X88Tmy8E2J7Yon6Hz0m0=;
        b=JK6hULQSGrLIQoTBZzGfP6Iibl8sQ8hLfH9Epfsdar1SfxhHEGecuy2bh3zSr3El27
         NqT8XAhoaIxrqpSosf7tGdZzRQfK8rMv1vqei6BO4V3qJEYgGymxnpAoXRjmyDjr2Ypc
         ESKGjsm38ENRxAv3N9tOE0GCZyzrqNN6TyVesJVJAy/4K32ddz+JbDstit0gGf+gsxQo
         +ASbBDfu7A+YvVSTf2D1CwN/NEsVhUchqUWvVNosfoW6Tc4an6amxXLpU4k5coAR0pXh
         3nVT5GYfdPb40Cpe/v5us62LBz2iYzgvMx1FcWKbQGK+jzXUrdCMGz0CcSI06lENWAR7
         uTnA==
X-Gm-Message-State: ANoB5plnqtSPTYgdn8MA1OfcH1rpAav7yixRbhJFj7Q/84ldIH+p9hyM
        vNrh7iMhFs/rPTSMY4Ap164sbKxdP8QagfurCqTyrYKceVvk0sMV3emzzgqulxFJntPieTmY+FA
        y75VYAzTrrxYB
X-Google-Smtp-Source: AA0mqf6dMzGkQ+m0jPkh3k61n6nVufN8KOIKDaCNH9ufKB4IPmfKnvG8ehSOXgrL1c+eqKHWea/QtA==
X-Received: by 2002:a17:903:2797:b0:17f:628d:2a8 with SMTP id jw23-20020a170903279700b0017f628d02a8mr1074616plb.34.1668150254214;
        Thu, 10 Nov 2022 23:04:14 -0800 (PST)
Received: from [10.240.3.88] ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0018689e2c9dfsm881133plk.153.2022.11.10.23.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 23:04:13 -0800 (PST)
Message-ID: <91e0ffc5-6517-c045-7bac-0b8d904822b9@vixtechnology.com>
Date:   Fri, 11 Nov 2022 15:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] iio: light: apds9960: Fix iio_event_spec structures
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20221110101241.10576-1-subhajit.ghosh@vixtechnology.com>
 <CAJCx=g=qRd+WaCLOHwnEjg1Myg4Ng=PK0sxcGgEG9VT+VpondA@mail.gmail.com>
 <b6ac2692-3152-dfc4-5388-7986042970f0@vixtechnology.com>
 <CAJCx=g=WaGiBFYJTTjNgzrnW3We0qpuMvyy9iFAVDC8Mkbscsg@mail.gmail.com>
From:   Subhajit Ghosh <subhajit.ghosh@vixtechnology.com>
In-Reply-To: <CAJCx=g=WaGiBFYJTTjNgzrnW3We0qpuMvyy9iFAVDC8Mkbscsg@mail.gmail.com>
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


>>
>=20
> Hmm maybe Jonathan will have some feedback on this (and if it is okay
> to break the ABI interface). Been awhile since I've touched
> this driver and a little rusty on iio events.  But I am guessing your
> method makes sense since the event(s) has direction and a type, and
> can't just have one of the .mask_shared_by_dir and mask_shared_by_type.
>=20
> In any case:
>=20
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
>=20

Thank you so much for your time and review Matt.

Apologies for the company disclaimer message which auto generates after
the message body. I am still working on proper submission skills. =20

Regards,
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
