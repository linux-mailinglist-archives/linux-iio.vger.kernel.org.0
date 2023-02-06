Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD468BB04
	for <lists+linux-iio@lfdr.de>; Mon,  6 Feb 2023 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjBFLMF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Feb 2023 06:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFLME (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2023 06:12:04 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD911E1C9
        for <linux-iio@vger.kernel.org>; Mon,  6 Feb 2023 03:12:03 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 5so2341744qtp.9
        for <linux-iio@vger.kernel.org>; Mon, 06 Feb 2023 03:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uuWlom21gSPm5ulvciUgX0oLJd2zF3JgkvZVYvO1nTU=;
        b=PxNDo2qrHxoKyZOZ5BdkTauioHkaECJljAhHU+RYr+8fCoN3c/SJPaablsQX9+TmL0
         S3Azm0QVHeAwaj7D2gI7Xp6XuhUX8r00hGi9kR6Rw6E3+rPP/OWV0a/ypCcs/tTvMiqf
         JgAcTffPc/dwude7rUbZpD1DNykXmmUTbdX3Cj6aNSRQLzKXJtLa9qInlMD0ISPobBqZ
         JBSmC82R6d26ggDg0inT7mtkg1m3TyAiJnmqXOAbNClLOKiDV/MRsUf398D2OTUfo/79
         bBGOCH0GMhywuUjzGJHIgGzaXIIhejCOli4Ui++lh1zIkjR1QY/v/Xo1v2TtzCYjleV9
         qSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uuWlom21gSPm5ulvciUgX0oLJd2zF3JgkvZVYvO1nTU=;
        b=DeznumPMoWKk+6OxpH5g2RE7FEBTJ/GCTvLMFZ7s7/IrZjsKiGsXyXmdvMo7TftDEF
         s2KtCj/0UHsU/3+w/dy3hkcGYDeRIHW1/2vonDgBUk7KMx/FA7vewPIOfcWmwMSPPLmp
         HNoG1aVduXmUWZJwe5xFW0kZ9zqeT9cv17Ml5VzHcm8TBQAC1IA4cEanyi7ilp4Z/ILs
         JX+7ZGClHeYyiwnilX2IcHUY/rtQe7rPQplKxH9lTuNh25hZeJjeqOD2/4F/lA350c8n
         UJrYWDvPjQMFiW5k/aV5sessRo33QpGLVNvhYqDMmp9PoEokQKMxICUHh00gkmjvGQVP
         dPWg==
X-Gm-Message-State: AO0yUKVvi7mkfi/0+i0g68oNuQ5xlx84au+BUGVX9Ra+sxvjNVuDr3lA
        BBBqs6+Q0rcadZaiKWzE0w8=
X-Google-Smtp-Source: AK7set96FgdJtyDp3U/XfXHyzPobp+jN66PBojCZdu0zvVKlny8J4qSUHLwZu+o5sVnxofkNhSizEQ==
X-Received: by 2002:a05:622a:84:b0:3b9:bf43:fccd with SMTP id o4-20020a05622a008400b003b9bf43fccdmr33497876qtw.10.1675681922462;
        Mon, 06 Feb 2023 03:12:02 -0800 (PST)
Received: from p200300f6ef051400929cfbafc6907690.dip0.t-ipconnect.de (p200300f6ef051400929cfbafc6907690.dip0.t-ipconnect.de. [2003:f6:ef05:1400:929c:fbaf:c690:7690])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm7052048qtg.33.2023.02.06.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:12:02 -0800 (PST)
Message-ID: <e619b7ba249457a542f04a198133e4ba9255d16c.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7791: fix IRQ flags
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Mon, 06 Feb 2023 12:13:50 +0100
In-Reply-To: <e60e97d614a03c5a6e1e86b330a3d3ae47d3d220.camel@gmail.com>
References: <20230120124645.819910-1-nuno.sa@analog.com>
         <20230121165852.5a302778@jic23-huawei>
         <e60e97d614a03c5a6e1e86b330a3d3ae47d3d220.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
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

On Mon, 2023-01-30 at 10:01 +0100, Nuno S=C3=A1 wrote:
> On Sat, 2023-01-21 at 16:58 +0000, Jonathan Cameron wrote:
> > On Fri, 20 Jan 2023 13:46:45 +0100
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
> > > The interrupt is triggered on the falling edge rather than being
> > > a
> > > level
> > > low interrupt.
> > >=20
> > > Fixes: da4d3d6bb9f6 ("iio: adc: ad-sigma-delta: Allow custom IRQ
> > > flags")
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > What are the symptoms of this?=C2=A0 Given the ad_sigma_delta.c irq
> > handler
> > disables the interrupt until after the data read is done (at which
> > point the
> > level is presumably high again), I don't immediately see why the
> > change
> > here has any impact - either we trigger on the fall, or on the fact
> > it
> > has become low..
> >=20
> >=20
>=20
> Honestly I did not checked this in any HW. This was just by
> inspecting
> the datasheet and confirming that the LOW IRQ is not coherent with
> what
> we have in other sigma delta ADCs.
>=20
> However, after some git blaming, I found this [1] which shows that
> this
> might be an issue...
>=20
> Hmm, maybe makes sense to add a link to the bellow patch in the
> commit
> description...
> =C2=A0
> [1]:
> https://lore.kernel.org/linux-iio/20200113102653.20900-3-alexandru.tachic=
i@analog.com
> /
>=20
> - Nuno S=C3=A1

Hi Jonathan,

Anything that I should do in this one? As I did not tested it, it might
not be a real issue but I still think the patch is good even though it
might not deserve a Fixes tag...

- Nuno S=C3=A1
