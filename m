Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D462F7911F1
	for <lists+linux-iio@lfdr.de>; Mon,  4 Sep 2023 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjIDHUR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Sep 2023 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjIDHUQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Sep 2023 03:20:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC52A0
        for <linux-iio@vger.kernel.org>; Mon,  4 Sep 2023 00:20:12 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7ecdb99b7aso956176276.3
        for <linux-iio@vger.kernel.org>; Mon, 04 Sep 2023 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693812012; x=1694416812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVOEVpMaoekM7L0xljCDotcOxhGyaUbiG4e0eDC6Xnc=;
        b=Ve4VCO7Tajl4s7MX+VDO5myOhh/qfLP5yGsWXF4vlTxIzl0ypBt4ukE8tjTXqWvdpQ
         rm7bhEcAj9Dr7wL7Krw6qHnA3QTOKmYhd1CwULxECFJPe6GzfGE2aSvzAK6akrVIqG+u
         x/dpV568pvdlpCfvjrXWTI1wJ9edqWzGXui1i88sdik7bRalNo5Kqa7S2vTIDAE7LjxZ
         CLyAi/yVNPimot4MpzR2AP0lWXy+EYYnCvrBd3CPmh4uzAbcUDASFpsj8HMp4Apy/SNb
         8KtOQ//rPP+yydSiulHjtYlXIqspBQFLPzu4WUjq9ullsluCm49+3k+7Ii9MOvWinjiM
         XMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812012; x=1694416812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVOEVpMaoekM7L0xljCDotcOxhGyaUbiG4e0eDC6Xnc=;
        b=KJc7mEmXKJWed9SMrzJQk/VsfnAAtsRbGxKAhn//dv/KBuVZy0020flaJ1krqwooJ+
         WiZ1gScbkSg/kJVCbBXE/H7SW4FEbQ61ZjVntx3HTcicaMvRrNfnbJXd9ezjDNwaW5fK
         BsoKeRJwmC6Vengbg/mpBe4z0olRduYp2JhjqHzEhvYVPQRlbyZl+VBg6OCegeAFnoYE
         Ga79WrsJ5RuN9JIGrjMjWrNlDwNETuXr80vfUPgCPzA/QSlwVA/OUSLB4t16+ImueYV1
         E/mqXKnlEZ6GmFDnl9T/1KgrSjvvRGHyQD3v17cgXSNG6+GEMh9UtLP9JsLGxtleRZ2g
         mzzw==
X-Gm-Message-State: AOJu0YzEjkgrgGN5mlWoO6Uu/wmSkgx/z4vrVkxMI23WPgzvQein54RB
        4poJqSJdGq6AchuEiz0juDsBRkbjTMOBYLnuNNligQNg5ygu6xx2pzA=
X-Google-Smtp-Source: AGHT+IEbGJK+h7cq5GXslgX7oM0SreiM3Vehdc7qyQL9KvWApDvloCmpQgvCxXWmHw5pUPn3nbXFQb6wAZoVCO4+AUY=
X-Received: by 2002:a25:db8c:0:b0:d07:5b87:ec56 with SMTP id
 g134-20020a25db8c000000b00d075b87ec56mr9071474ybf.14.1693812011998; Mon, 04
 Sep 2023 00:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdYtXAWDcAMRJxh5YbNKmrYurH=z0pR47bftc+u1Yt4Nig@mail.gmail.com>
 <20230903171056.41-1-bavishimithil@gmail.com>
In-Reply-To: <20230903171056.41-1-bavishimithil@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Sep 2023 09:20:00 +0200
Message-ID: <CACRpkdaxNBeAVV9514ixJANvNVarja9GC3Xxm5nFNZUdmze5eg@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: rescale: Fix logic bug
To:     Mighty <bavishimithil@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, liambeguin@gmail.com,
        linux-iio@vger.kernel.org, peda@axentia.se, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 3, 2023 at 7:11=E2=80=AFPM Mighty <bavishimithil@gmail.com> wro=
te:
> On Thu, Aug 24, 2023 at 1:54=E2=80=AFPM Linus Walleij <linus.walleij@lina=
ro.org> wrote:
>
> > Seems reasonable to me!
>
> I'd say I send a patch to the mailing list and see the response, I'm not =
very
> experienced with this device. The inputs of other people who worked on
> this driver would guide me in the right way then i guess.

I sent a patch, it's at v2 already, sorry for not notifying:
https://lore.kernel.org/linux-iio/20230902-iio-rescale-only-offset-v2-1-988=
b807754c8@linaro.org/T/#u

Yours,
Linus Walleij
