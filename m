Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C225A564
	for <lists+linux-iio@lfdr.de>; Wed,  2 Sep 2020 08:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBGMg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Sep 2020 02:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBGMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2020 02:12:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7ACC061244;
        Tue,  1 Sep 2020 23:12:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u25so3322662otq.6;
        Tue, 01 Sep 2020 23:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OH2CSI+RMVDa+o7mr+bFOYCagAiIO2w5E9YocL797D8=;
        b=chrpRBMuxKqoCGIhmYCwEfg2NCy2inV1ZzirbSc8pizTHLUrWeVR5Ul5SCu5XfmgHD
         X7GAk2S8xdmSk/ZeSgsO/b6qrwe8gpvpAqJiSLGVchVURFi6CLumbhl5vXneamaCyHpR
         nlfQ/cwBd71ubhbKgTNhzaEHLiBBEfQDcsLVtFenLx47I5F4clelWrVBVRlAPYivDy/W
         WGbXn5baLInh+myzw6i46tquBTI7kSyLzpMzWrP5Zw6BIKos/d9O/MAEm8Pqbx9v/tRF
         fI8OtyuCro+247fWffA/3pTf0lfUdYCwESQouBSdR+5y7NVryn0G3I/+6+rb73XI1KYl
         477w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OH2CSI+RMVDa+o7mr+bFOYCagAiIO2w5E9YocL797D8=;
        b=rXNGK7us7ELibXlAp9AiAJbxoKPhZj7jnMkQVRLOwukceUyJnGRKGSxW520wmaySNB
         FU1rs5FYPo98W2EPzxBZOooxAsahRHO5jx1EmZA4Zwsg4bjY/z1a/RfyklizyfTqTrRK
         h+A6JVRoP//tyA31IgnhJVLdNqAQ1OE64vAByorV/ilQUzEBU5v+SY8KuQ1SAKH12/AS
         ihXFBWZA6/9ZBa/Gw4JXkjCU1AjuEFXEmh9exewmSfotdN/WjXXj1No7zLssGJ6n37in
         SwT7M0wxapBd9lBe5hkDkv3J5Ytok8wVr5ozqLhs9047Zx33ygGDQVi87iT+aLYTbR11
         uXRA==
X-Gm-Message-State: AOAM530PB1ZPzxByRcXCYe8seMBAiV8g31Ik4OfeYGYuj93wCx9kaqtg
        75Bq2DReyT65VBRUvPc4BGEkUaasuMPa3PZmh44nFDpy
X-Google-Smtp-Source: ABdhPJzW3oF7F8kpT7DmR6bM8ZmVyV0PcZtVvxF5E4tdp0v0Vc/JnExc6NBbLfqj0X7p09Ew41E6IFXpQVsUq+Az/RI=
X-Received: by 2002:a9d:50a:: with SMTP id 10mr3897594otw.207.1599027153888;
 Tue, 01 Sep 2020 23:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200826063850.47625-1-alexandru.ardelean@analog.com>
 <20200826120042.200364-1-alexandru.ardelean@analog.com> <CA+U=DsrMDSTQKEc2_3+W8u4bLraAowVB3nB4huKY--v8gnds2Q@mail.gmail.com>
 <c3a9411e-186d-a3ac-5ad0-bd70ad78f147@st.com> <CA+U=DspjGUhXCY7c8P6zOYZsx17ybcU4Kdr52yujmdYOaa1JSQ@mail.gmail.com>
 <20200829164613.3be1b2b1@archlinux>
In-Reply-To: <20200829164613.3be1b2b1@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 2 Sep 2020 09:12:22 +0300
Message-ID: <CA+U=DsrMFasSO3ka-U_Dkn2BXF4qmfp4ejv=gjf4epo6WxFnUQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: stm32-dac: Replace indio_dev->mlock with own
 device lock
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, alexandre.torgue@st.com,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 29, 2020 at 6:46 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 27 Aug 2020 13:00:36 +0300
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>
> > On Thu, Aug 27, 2020 at 12:03 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> > >
> > > On 8/27/20 10:55 AM, Alexandru Ardelean wrote:
> > > > On Wed, Aug 26, 2020 at 3:03 PM Alexandru Ardelean
> > > > <alexandru.ardelean@analog.com> wrote:
> > > >> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > > >>
> > > >> As part of the general cleanup of indio_dev->mlock, this change replaces
> > > >> it with a local lock. The lock protects against potential races when
> > > >> reading the CR reg and then updating, so that the state of pm_runtime
> > > >> is consistent between the two operations.
> > > >>
> > > >> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > > >> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > >> ---
> > > > Forgot the changelog here.
> > > > Apologies.
> > > >
> > > > Changelog v1 -> v2:
> > > > * removed whitespace change for 'common' field
> > > > * updated comment about the lock usage
> > >
> > > Hi Alexandru,
> > >
> > > Sorry if I missed it... is there an update on the comment :-) ?
> >
> > For a moment there, I thought I didn't.
> > GMail's threading is confusing.
> >
> > ----------------------------------------------------------------------------
> > As part of the general cleanup of indio_dev->mlock, this change replaces
> > it with a local lock. The lock protects against potential races when
> > reading the CR reg and then updating, so that the state of pm_runtime
> > is consistent between the two operations.
> > ----------------------------------------------------------------------------
> I think this got confused...
>
> see below.
>
>
> >
> > >
> > > Best Regards,
> > > Fabrice
> > > >
> > > >>  drivers/iio/dac/stm32-dac.c | 12 ++++++++----
> > > >>  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >>
> > > >> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> > > >> index 092c796fa3d9..7a8aed476850 100644
> > > >> --- a/drivers/iio/dac/stm32-dac.c
> > > >> +++ b/drivers/iio/dac/stm32-dac.c
> > > >> @@ -26,9 +26,11 @@
> > > >>  /**
> > > >>   * struct stm32_dac - private data of DAC driver
> > > >>   * @common:            reference to DAC common data
> > > >> + * @lock:              lock to protect the data buffer during regmap ops

oh, silly me;
it's about this comment;
will re-spin

>
> The original comment was:
>
>
> In this particular case I'm not sure that's what mlock was being used for.
> I think it's about avoiding races around checking if powered down and
> actually doing it.
>
> And Fabrice's reply:
>
> Hi Sergiu,
>
> Indeed, purpose is to protect against a race here when reading CR, and
> updating it via regmap (this also makes the subsequent pm_runtime calls
> to be balanced based on this).
> (Side note: there is no data buffer involved for the DAC.)
> Could you please update the comment ?
>
> Thanks,
> Fabrice
>
> > > >>   */
> > > >>  struct stm32_dac {
> > > >>         struct stm32_dac_common *common;
> > > >> +       struct mutex            lock;
> > > >>  };
>
