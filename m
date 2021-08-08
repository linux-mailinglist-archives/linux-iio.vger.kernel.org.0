Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559A83E3D0F
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 00:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhHHWrR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhHHWrQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Aug 2021 18:47:16 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03406C061760;
        Sun,  8 Aug 2021 15:46:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 14so16454232qkc.4;
        Sun, 08 Aug 2021 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=6bBUCBVv60+hM0/H5Rtd/L5AKWv2adqcsOGUpCsjuyc=;
        b=HMGOI4Ncqv1ddlpnnOcm6t1cN6sg+GIC3TJN+Wa3NgdU6Cp2lIWOG/Ahz+ahBub2IX
         0F8GMRVl8f1bS/+GLTti0fu11NhY/4A57QfA+RvzmQVD/vNHUD/crfnbuVMFAb308xdf
         SSyJpDe5X8txAWJliRFW024XPzLEc4bndQRJXleOWNsPoS76QcvLyqcU2wGMrDT1txEx
         JEZVcz7N7Ebxii4pDE/6eTa4hz1/Vaeu9mZ5mhCygjeOaZDVLK/cRboljOvmrZKqZFp1
         1F9QPGE2VDHNPPqJdO81fq63/MkErAqjxB2SVusH/asIzQlJ/4L1ZHDgdCf7X8Hoe+Ht
         cOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=6bBUCBVv60+hM0/H5Rtd/L5AKWv2adqcsOGUpCsjuyc=;
        b=kSGOiB2KsKHF3LmykNehiKUSWuq4Ijf+mL1NgKdD9uuC5DNBagCi5VKuqQHRsI9NfE
         5ZkbzFB2WF03BX/sztr4aU7Xc+k3j0Xd8P0R4HY7Hgzr+kSJ4jtowWC2shKyTmuwj089
         4+FdfU3qQ5ac0v9YLCD4EmaBKeaG41vGhYalR3PEqlu8xi7l6WP9VecA8i0QZgPOcbqk
         +bUbIJIIJ+PqM9ZWjzsT8aEffEUBNob4LgwKtlZWpYmmTjPbFi8Q1G1aU/AwAd46Ac2v
         e2/Ue5lbMdNqwLu1BGTEczqFMHEaLdQWJ78cQkZu6wc6xBhTDFX1eIIuQg7XWtv60X5H
         4lxA==
X-Gm-Message-State: AOAM531MrnZXhWyjCNbjANczTCHhBlcrsk3sdiDWz8w5yaqd1/YOTDdH
        9a0Z45k8CrgJnqSo5ch/ens=
X-Google-Smtp-Source: ABdhPJziQjftXzeaNG8ptrIxiQ/nGjUlKrBx4LLbAmM2BkhHRb40pYaOphN1iD6yLL8M7vOICn2H2g==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr20030069qkf.270.1628462816203;
        Sun, 08 Aug 2021 15:46:56 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j5sm8363362qki.80.2021.08.08.15.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 15:46:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 08 Aug 2021 18:46:54 -0400
Message-Id: <CDEHW1G78JUJ.CQG08OEMNYLQ@shaak>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/5] iio: adc: ad7949: define and use bitfield names
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Joe Perches" <joe@perches.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
 <20210808015659.2955443-2-liambeguin@gmail.com>
 <b52eb842e1c681b88dbffba262075957b9741262.camel@perches.com>
In-Reply-To: <b52eb842e1c681b88dbffba262075957b9741262.camel@perches.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun Aug 8, 2021 at 12:51 PM EDT, Joe Perches wrote:
> On Sat, 2021-08-07 at 21:56 -0400, Liam Beguin wrote:
> > Replace raw configuration register values by using FIELD_PREP and
> > defines to improve readability.
> []
> > diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> []
> +#define AD7949_CFG_BIT_INCC GENMASK(12, 10)
>

Hi Joe,

> I think the naming is a bit confusing as it appears as if
> these bitfield ranges are single bits.

That makes sense.
Would AD7949_CFG_BITS_* be good enough?

Thanks,
Liam

>
> > +/* REF: reference/buffer selection */
> > +#define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> []
> > +/* SEQ: channel sequencer. Allows for scanning channels */
> > +#define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
> >=20

