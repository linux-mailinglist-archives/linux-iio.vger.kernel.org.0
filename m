Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77E57869EB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Aug 2023 10:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjHXIZR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Aug 2023 04:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjHXIY4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Aug 2023 04:24:56 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F381709
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 01:24:54 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79a10807b4fso2338501241.2
        for <linux-iio@vger.kernel.org>; Thu, 24 Aug 2023 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692865493; x=1693470293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzMLU+tWwBh84Mijc6UOUOLRLLzTJ4x4jDQpdLpPQzY=;
        b=qBa6VxNCmGKtyZwBArd7C/OD4nJbWfYWwkjiVZerus7LZjcDAuwxUh9sanGwiQtKaI
         PxhEJarwV1GjjOKI1cU36B0VvjqgLdueJZ8/Ys+Jd8AB8CYGHP+D94KuVuan/6Pv1Hm+
         9ZV1W8ih+xYrFGB0/qSK+UzALqw+OhodQ6FbqwUqs2oepA15ahcvlv9Dl07SnedA3qxV
         ThI2x4FsLODMj9SWUCMU6zGTRFYrEOsaVZ1jLQ0mwTNUjmkqS++LS+9sBhLWO/CM1hIL
         Sa7crCjhRRwZToXmMukH9eBEkGDLokfaMPOOToRtDhw4u/IW2rz2npNkMqft6rnN+GYY
         zdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692865493; x=1693470293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzMLU+tWwBh84Mijc6UOUOLRLLzTJ4x4jDQpdLpPQzY=;
        b=KAUkKc+NjPF9c0DxUPNFvPMIMzfNfbbZMGaF4gE9Cw5gxTYywoyHDlRBFhGiaXlW5g
         eeT2FnaTSFk203n2LWNgQJgV/qh00sVVyvbiJEj/EOtxM4BVsqz3cpaMAHOGIcBRn6Bc
         YiBkqUkEF2UqHRmBTFrnfFCGx4GxbHf9NtEhI8gzuCeBgt4O51m0qTCpb28wu1p6EbhW
         vbLeCGaQvy0E157xNGlVLz+U/ciSfZ6tvUZ8OL0XsV21FnnQmXsydAERjn6qdJH6d3+P
         ZfO/kn+fi80RKpsYdjqyc17hHpgacWEO00ueYeiVo1j1XG1gpWfz+35MSiLBuD9X2eZ8
         4VRg==
X-Gm-Message-State: AOJu0Yw4Jc+FvEFEQyzWz5yNflY7cog29BOfMa/0nm8GsCjxbFwVkwW2
        HRlDkVKBtuMrHsAo3EmxNdho7vhS12c+AMkv0NpF4Q==
X-Google-Smtp-Source: AGHT+IHH4RBMDLKtcXcy/IuqM8bdFbG0GnLAodQLwYrQRYuWvRPtuYmxZcIJ0A4T6wjWuoowQYd+I97KFsZrqV44eTI=
X-Received: by 2002:a67:fbcb:0:b0:44d:547d:4607 with SMTP id
 o11-20020a67fbcb000000b0044d547d4607mr7758117vsr.35.1692865493777; Thu, 24
 Aug 2023 01:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdZn3MePSohFU7AzVtzdaKW=edsw14Y42xbScXNBVZDOjA@mail.gmail.com>
 <20230824073933.80-1-bavishimithil@gmail.com>
In-Reply-To: <20230824073933.80-1-bavishimithil@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Aug 2023 10:24:42 +0200
Message-ID: <CACRpkdYOpz7gDQsM+tgxj7sjKzv8FtehEsjezD8_bpDk-F_b=A@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Mighty <bavishimithil@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 24, 2023 at 9:39=E2=80=AFAM Mighty <bavishimithil@gmail.com> wr=
ote:

> > patch the twl6030 driver to convert all IIO_CHAN_INFO_RAW to IIO_CHAN_I=
NFO_PROCESSED.
>
> That would break the case here https://github.com/torvalds/linux/blob/mas=
ter/drivers/iio/adc/twl6030-gpadc.c#L541
> hence I think we just comply to adding scale as well, even though it woul=
d be 1:1?

Seems reasonable to me!

> There is this https://github.com/torvalds/linux/blob/master/drivers/iio/a=
dc/twl6030-gpadc.c#L447 but I'm not very sure about how it changes the scal=
e.

That looks like the channel is actually processed, not raw, right?
i.e. that should only be done on channels marked as processed.

This should definitely be reflected in the scale attribute for the
raw channel instead, especially if you support buffered reads (I
don't know if the driver does this) because buffered reads usually
just read out the values from the hardware without any such
processing and rely on scale to correct them in userspace
afterwards.

Yours,
Linus Walleij
