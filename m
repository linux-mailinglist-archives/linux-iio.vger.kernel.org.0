Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3501E6D3D9B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Apr 2023 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDCGwt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Apr 2023 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCGwt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2023 02:52:49 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC630D1
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 23:52:48 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id dw2so3296451qvb.11
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680504767;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ScELMrj/DoIDUcUWC7sj2bAmfQjlVNhGGYZVGhw9aYo=;
        b=AXGBCtNlSyF6Bm+Wx4W8B50HFUyZ5J1uz2x3FgtNKOO5pinP85hqxxDvnJvqFiR7Ch
         RDnb/H/zomSuHcNyC48R/cAiQ/yhNsV0/lUnxf2ET6E6fIpAJ/UzJxcw+SJp1pxdE2Ps
         SatS3XAouc1piiTKLz/5ioOAk40Tph5CQGv8kbER5IKgelcEpwschPNPimOYWmbQKgP/
         k/xA6SvD33H7q94cuLP+RJz8UWjCOUp2ubI/3/uszI8S9H/wlHgdRKkIrOhK+0Ta5i4e
         E6GRAtlKlSNUNOtv2GWFzDf9RZpe3nk7tJmwPVWyrg36SKnyZ5OGQlo/KHBUj2zkYCqq
         Qlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680504767;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScELMrj/DoIDUcUWC7sj2bAmfQjlVNhGGYZVGhw9aYo=;
        b=SAqq6BeM5r7MLRUkaM2wBt8VGuVy1/Bpz4i4TiA85TQdMgyxMOkSCSVbfqi6ThRmQP
         bEEuFhFzj+WMStdciv88QfIUUyeewKwCtTMllJDnQ8DwOvnkanBfmqJDwm5WFJ0ln1k3
         WNScGQPZqbrhzMWIMpS5yXCEZkl6MVXHWxGwGPd42EV2s1Ex/+kQtni8vhLgsflu9nbW
         cmJWSm1Saes31zQyHpAU64j19uuqDSjFM16LqiHNNsWa9ozDIjPTtUNKuNw7QGEMZsIl
         TWRUXtywcCJceiLz/AxPHJiS3eSNnVUAXtdO8oKqS//1m/HT7F2pRh+yjY0DB/KbiBnl
         4nqQ==
X-Gm-Message-State: AAQBX9d8leau/zaOu3FPnaqNFHXjy0Fs6GxcvRl+seXAPKnpBvXbqMXJ
        1lNSEJqOJFXo/VzSx7CMZ0a2YnyIdjThAFWC
X-Google-Smtp-Source: AKy350Y3xTSmIDbtZpBPsLaYrgPJeXVB/xCCpaISJmh0sryLwSNXwoAPt9syxale8IeV3i1yDakHQg==
X-Received: by 2002:ad4:594d:0:b0:5a4:548e:4ed6 with SMTP id eo13-20020ad4594d000000b005a4548e4ed6mr56509613qvb.40.1680504767275;
        Sun, 02 Apr 2023 23:52:47 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id mm17-20020a0562145e9100b005dd8b9345f4sm2390844qvb.140.2023.04.02.23.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 23:52:46 -0700 (PDT)
Message-ID: <0fc93adff7ef33857881ffa94bbd77433abab362.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: resolver: ads1210: fix config mode
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-staging@lists.linux.dev, linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Date:   Mon, 03 Apr 2023 08:54:44 +0200
In-Reply-To: <20230401152425.2dae5505@jic23-huawei>
References: <20230327145414.1505537-1-nuno.sa@analog.com>
         <20230401152425.2dae5505@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2023-04-01 at 15:24 +0100, Jonathan Cameron wrote:
> On Mon, 27 Mar 2023 16:54:14 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > As stated in the device datasheet [1], bits a0 and a1 have to be
> > set to
> > 1 for the configuration mode.
> >=20
> > [1]:
> > https://www.analog.com/media/en/technical-documentation/data-sheets/ad2=
s1210.pdf
> >=20
> > Fixes: b19e9ad5e2cb9 ("staging:iio:resolver:ad2s1210 general driver
> > cleanup")
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Oops. Younger more foolish me bug (back in 2011 so I'll cut myself
> some slack)
>=20
> Applied to the togreg branch of iio.git (not rushing something in
> that is in staging
> and has been broken a while without anyone commenting!)
>=20
> I don't suppose this means you are going to get this ready to move
> out of staging?
> *looks hopeful*
>=20

Eeheh, Unfortunately not on the top of my list right now... But, if I
happen to find some hardware hanging around, I might eventually get
into it.

Funny enough, this was actually reported to us in one of our support
channels which means there are people actually using the driver even
being it on staging.

- Nuno S=C3=A1


