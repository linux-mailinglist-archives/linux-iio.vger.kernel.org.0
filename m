Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC631E7D5
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 10:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhBRJBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 04:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhBRI7V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 03:59:21 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79764C061574
        for <linux-iio@vger.kernel.org>; Thu, 18 Feb 2021 00:35:39 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e133so1175680iof.8
        for <linux-iio@vger.kernel.org>; Thu, 18 Feb 2021 00:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XH8qEPOCz5iurGiFNxv2Z+nbu2iPCZkMEvafRPHdCwU=;
        b=CvHCgiQBZB496Pn+qfIaRIeEmE26iQwxsld6qIBXkVGnxAwJmBhV1XSwwHY/G31Dv6
         Hqi+EZY+o/3HJwaghgaNY4uUJTWSvLJMCbPqiCp30O8K+JWgpWt7+SbCR88E6NhyDqJM
         GF7P3NGPt8TK0uL6m+eFFJSYnvLDkwmgI6EC9zs8m7Bb+vuwWawbE096vHWbnM+kjTLv
         APx2ngbL/SYyovXBfrzp0kKOgbdCuSxyT0RBzdyjEMFwDw6P0+mAPf8KIQm2VCqHpXKw
         tOf46QpC47h3dyXRfjJ/qfE/lj+b4rOIssRWjc5godoaZZtYyHH4LAJXn93R3q6kVFf1
         hREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XH8qEPOCz5iurGiFNxv2Z+nbu2iPCZkMEvafRPHdCwU=;
        b=GF10SKb9tcdvHVcNy5pxSyfkxU7t8iv8IjhnRGt5oPaIfTeGhb9Gjcn5VTdc6IuCf/
         o5MQnYTRV4kUlhF8TKZ6Se+PmI7bO+l2Da65ihkSd7+xMbvA/T3Qvi1q9ozVaa4AL++h
         SRKe+IYkp85fy02ADdNBKK4XQ1Lg1e2R54/8KiZ0GlW18cMQO3keOobvn6PsWUufWdEq
         vd6+7E6k+UPhWMePLTTuloEmZHxmF1+npzLUzl+Jm1sx0c10iyfQxBGD5KniCaP67NrB
         X93wVzGMNTnbPsXiIlfuPKzYjtqKukWmZtS5cDBDMBgzzb+t5hCVU4fUbr6YwzWLKf72
         sT5w==
X-Gm-Message-State: AOAM533AUN/gF09K0Xd7m8Kes+v4H0Dz6bfp/yag7fPCoCMDoRp2cNoJ
        HW8+lX0h+nKFwQePimpk0J++yecZ5E5yFK11gDY=
X-Google-Smtp-Source: ABdhPJwGEHw2Bej9XmyMP5CwxaQo/tL/bX5qk2ozF/u+mJJQ9HxDMWPqv4xqF+sX23TGGw91PQl8Aza2Lt4Vytl1lFU=
X-Received: by 2002:a5d:8e01:: with SMTP id e1mr2708909iod.170.1613637338760;
 Thu, 18 Feb 2021 00:35:38 -0800 (PST)
MIME-Version: 1.0
References: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
In-Reply-To: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 18 Feb 2021 10:35:27 +0200
Message-ID: <CA+U=DspfyuxyhPfPrGDaU5nDQVaO5p3ha-5hwpzVX69p1P60WA@mail.gmail.com>
Subject: Re: Control Register device tree binding request for Opt3001
To:     =?UTF-8?Q?Ekin_B=C3=B6ke?= <ekin_boke@arcelik.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "cengiz@kernel.wtf" <cengiz@kernel.wtf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 18, 2021 at 7:27 AM Ekin B=C3=B6ke <ekin_boke@arcelik.com> wrot=
e:
>
> Hi,
>
> We are using Opt3001 for a day light control system and according to the =
data sheet it has 2 conversion time modes
> that are 100 ms(CT=3D0) and 800 ms(CT=3D1) . Configuration register field=
 CT controls the conversion time and we want to set the CT parameter at the=
 initialization to 0 at all times. We could do it by using the in_illuminan=
ce_integration_time sysfs node at the runtime.
>
> Should we add a parameter to the device tree bindings or is there another=
 way to set the CT parameter at the initialization?

It's usually a good idea to use the sysfs attribute, if it's already availa=
ble.
Maybe during system boot-up, you can add some service init call to
initialize to 100 ms or right before starting to read data from the
sensor.

For kernel people, these initialization device-tree attributes seem conveni=
ent.
But in this case, CT is a parameter of the chip and not a hard-wired
configuration of the board [which needs to be described in DT].

>
>
> Best Regards
>
> Ekin
>
>
>
> Bu e-posta mesaji kisiye ozel olup, gizli bilgiler iceriyor olabilir. Ege=
r bu e-posta mesaji size yanlislikla ulasmissa, icerigini hic bir sekilde k=
ullanmayiniz ve ekli dosyalari acmayiniz. Bu durumda lutfen e-posta mesajin=
i kullaniciya hemen geri gonderiniz ve tum kopyalarini mesaj kutunuzdan sil=
iniz. Bu e-posta mesaji, hic bir sekilde, herhangi bir amac icin cogaltilam=
az, yayinlanamaz ve para karsiligi satilamaz. Bu e-posta mesaji viruslere k=
arsi anti-virus sistemleri tarafindan taranmistir. Ancak yollayici, bu e-po=
sta mesajinin - virus koruma sistemleri ile kontrol ediliyor olsa bile - vi=
rus icermedigini garanti etmez ve meydana gelebilecek zararlardan dogacak h=
icbir sorumlulugu kabul etmez. This message is intended solely for the use =
of the individual or entity to whom it is addressed , and may contain confi=
dential information. If you are not the intended recipient of this message =
or you receive this mail in error, you should refrain from making any use o=
f the contents and from opening any attachment. In that case, please notify=
 the sender immediately and return the message to the sender, then, delete =
and destroy all copies. This e-mail message, can not be copied, published o=
r sold for any reason. This e-mail message has been swept by anti-virus sys=
tems for the presence of computer viruses. In doing so, however, sender can=
not warrant that virus or other forms of data corruption may not be present=
 and do not take any responsibility in any occurrence.
