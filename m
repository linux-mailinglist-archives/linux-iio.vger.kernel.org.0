Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7874F619530
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 12:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiKDLLm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDLLl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 07:11:41 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C11BE87
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 04:11:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x15so2789732qtv.9
        for <linux-iio@vger.kernel.org>; Fri, 04 Nov 2022 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aCfF76cWVdUMn779XzXWl2TjPsxcGswT1hZBK98HZeg=;
        b=ICGvrrNmipnz5hvg4dMm6HPZr0+ep30JNGb6OnMhXNHu6yJyfzVRnaq8/qXCN5mH7s
         I/3L8x5T4/fsi6a0Cztont/eWihmfbLB78Q4FIh22ieFf4oEjFEKBhHkm5i4evODpvPj
         CtZq4TG+ZUCGYzfx3/Io9yRw2tkTXSNzVYbKO5blS3a/NyzrKEYo6HNXQIws5d/Ow++F
         tkXsslIDX46B3KXJqKlW5aItW/K9CjaWRKyC1tzlDHl6XSGOtV7qMThjedR/cYI4y4b2
         4i0s6L+5UfXAjJ5lSirbM7oZQ23Z9eobvHAKlhD+HFJtAVlOqAz7luqoE8/NLeFavnb5
         d73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCfF76cWVdUMn779XzXWl2TjPsxcGswT1hZBK98HZeg=;
        b=eGHTYKUc4oBtNzRC+94Um64mDXgwn6SmSrr1D4rXx4Y4e7FASr3xCmy0Qar5RN8Z++
         ubJ7WkrFFmwxwQLxXDN+WBhdSO1EdqF+PWZbaEA7w0dveF5PZ2KIxXUSTbOKZ+Pm3LEr
         fs5x5TSyjxycDRQvFoHM/gsz/CCTJ7GhTdzoRC3RDNQE4Q7+b4HYXRQ4lrNXTeepW0SW
         DULIa7ARuiqIacsA7XWKV+mfJTG1G6QRwDXHwxrdaLzi+GqUs43PwMCBrfycAXFd/8Ri
         cH4VE+QZlBVygg1qH2M3W/4i9Enme79OejQ/YFvPo1dGsHVsG9XvCqSFXIffRoW3zrG6
         QVKw==
X-Gm-Message-State: ACrzQf19i12f1D4YCJB8lrweJsfqLKFnWkxSoBO+EHHEJTJUuzf/aKme
        S0qwdEJse8fjlE744ry6fRw=
X-Google-Smtp-Source: AMsMyM5i/kMUA8THk1R+8ib/MpuBVZirfBbs1jHgEYPIIOvjL00zqIf3+CBdiDBdZ7YUVrCv0TJQVw==
X-Received: by 2002:a05:622a:424e:b0:3a5:6af6:133f with SMTP id cq14-20020a05622a424e00b003a56af6133fmr902652qtb.161.1667560300292;
        Fri, 04 Nov 2022 04:11:40 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id u23-20020ac87517000000b0039a372fbaa5sm2226162qtq.69.2022.11.04.04.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:11:39 -0700 (PDT)
Message-ID: <d46af04a6bd6373286a18a6f71aebd2c6aafd93a.camel@gmail.com>
Subject: Re: [PATCH -next] iio: core: fix missing mutex_unlock() in
 iio_device_claim_buffer_mode()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peng Wu <wupeng58@huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, liwei391@huawei.com
Date:   Fri, 04 Nov 2022 12:13:06 +0100
In-Reply-To: <CAHp75Vd_h3Avyafefg0fj-2BMCqvAH4U3Fd3biTptMMZdo_c2g@mail.gmail.com>
References: <20221104090307.17734-1-wupeng58@huawei.com>
         <CAHp75Vd_h3Avyafefg0fj-2BMCqvAH4U3Fd3biTptMMZdo_c2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-11-04 at 11:54 +0200, Andy Shevchenko wrote:
> On Fri, Nov 4, 2022 at 11:05 AM Peng Wu <wupeng58@huawei.com> wrote:
> >=20
> > In the success path of iio_device_claim_buffer_mode(),
> > mutex_unlock()
> > should be called before return.
>=20
> Please, understand how the code works.
> NAK.
>=20
> Nuno, perhaps we need to put a comment inside the function to explain
> this?
>=20

Hmm... I guess we can do that but, honestly, the docs in the function
should be pretty straight. Maybe saying that it's supposed to work as
iio_device_claim_direct_mode() would help (as that one is familiar)...

Alternatively, having sparse annotations could also make it more easy
to understand the intent.

- Nuno S=C3=A1
