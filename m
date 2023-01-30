Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60F7680807
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 10:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjA3JAE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 04:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3JAD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 04:00:03 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32FF1C58C
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 01:00:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y1so10334313wru.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 01:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qcyd3qHIgfuHfofyPgPHqZQf3MMzIpgY1W0HhpZd3NM=;
        b=OSCgmlnpmN1A47oZulHFGDkPzj5EZTK1q6oGGW3fNOQvZ5jyLdEXBnpPXBc0JLIf1p
         Im4Rnv1P+Vs3QBZKyjB4w9LRswHQvHFkliEhRzrBVobZM0vmLFEQQS3XoUavYy8hDcvu
         Ql7cP8cLJsWBamMd0Hh/GVAiA6JdsbfBpLY6drE2/tOJlhwgDCrQD+laoB4t0QuJjfUy
         DEuUrEyPCS0Gx0kNgVawv+TQ+EVx+PyBAn4g8E5M5DID56sL3KJa62cHpCkeE/yiim8c
         Xh9UO3acnJtIqtSiZn37sNtFsb86XlKeg8n5J51Yv2Y1orE45bmVDGIZkwV4JAPk0xtV
         LvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcyd3qHIgfuHfofyPgPHqZQf3MMzIpgY1W0HhpZd3NM=;
        b=QZEabIPAHNNU/a+xKtqHW6hYA6rnjYaKG4pMtwMhqAgBI+mozmuXi7yL0xCjMcVOTj
         oX70hYcNczRdPeysfXOLnorW2h9W1klVNgjrkm5ItUtsDwkznOJHI/2uCtGEY2IviIub
         Q+V/xQJyyFBAXWkU4gylKawnyaDcM4WNWaYg/28eaCzRn1cWj1/8CbOb+EF5Lftux32h
         yjZ+42jXAX+xfExeUX+PT5sJa5LlCDdQ7Rvci4gJG49ZzEIrElfjKjUV5rgrSoqNK7jT
         LL0dF/7AWvN2mZoB/XWS/eM8MwoqXop7OFl1ncJuMKkC2fzTu97YvjkiFvScFZQngVL+
         PgMw==
X-Gm-Message-State: AO0yUKVnzfR9nyQY3CfkMp8iTpaFYvUUf+t0xthsRps3AcQSjYNjREza
        87T+UuBQioVDysboF18V2F6kpZ3G4VKLCg==
X-Google-Smtp-Source: AK7set8NNrOeVwWgYUeGPQe5ENHAa7jrj/ATWLyX5hjmGPeK6SmkZ2D0+GK1pC3Mehf0LfV+hN1XkQ==
X-Received: by 2002:a05:6000:1805:b0:2bf:af86:ea05 with SMTP id m5-20020a056000180500b002bfaf86ea05mr20164174wrh.39.1675069201202;
        Mon, 30 Jan 2023 01:00:01 -0800 (PST)
Received: from p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de (p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de. [2003:f6:ef01:5700:e657:423a:1f15:6bec])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b002366e3f1497sm11216762wro.6.2023.01.30.01.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:00:00 -0800 (PST)
Message-ID: <e60e97d614a03c5a6e1e86b330a3d3ae47d3d220.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7791: fix IRQ flags
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Mon, 30 Jan 2023 10:01:50 +0100
In-Reply-To: <20230121165852.5a302778@jic23-huawei>
References: <20230120124645.819910-1-nuno.sa@analog.com>
         <20230121165852.5a302778@jic23-huawei>
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

On Sat, 2023-01-21 at 16:58 +0000, Jonathan Cameron wrote:
> On Fri, 20 Jan 2023 13:46:45 +0100
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > The interrupt is triggered on the falling edge rather than being a
> > level
> > low interrupt.
> >=20
> > Fixes: da4d3d6bb9f6 ("iio: adc: ad-sigma-delta: Allow custom IRQ
> > flags")
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> What are the symptoms of this?=C2=A0 Given the ad_sigma_delta.c irq
> handler
> disables the interrupt until after the data read is done (at which
> point the
> level is presumably high again), I don't immediately see why the
> change
> here has any impact - either we trigger on the fall, or on the fact
> it
> has become low..
>=20
>=20

Honestly I did not checked this in any HW. This was just by inspecting
the datasheet and confirming that the LOW IRQ is not coherent with what
we have in other sigma delta ADCs.

However, after some git blaming, I found this [1] which shows that this
might be an issue...

Hmm, maybe makes sense to add a link to the bellow patch in the commit
description...
=20
[1]:https://lore.kernel.org/linux-iio/20200113102653.20900-3-alexandru.tach=
ici@analog.com/

- Nuno S=C3=A1
