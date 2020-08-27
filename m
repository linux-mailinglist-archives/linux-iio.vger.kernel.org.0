Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBE2542FE
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgH0KAv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgH0KAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 06:00:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B993EC061264;
        Thu, 27 Aug 2020 03:00:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so3939028otp.0;
        Thu, 27 Aug 2020 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAVaUW7VwZegQfkJwMOJ8uza77AqEjXeq+6lLbyPRPM=;
        b=IYEfpoxWOrgM4B+rtfvP9lwMfghFgE8vdnrARgx0tBgVT3lXSqsCFo9fAz+niPiyxo
         rdB2smv37lBdCuf0lCYAMeq992BABs8tJZNXHRI0O/FpJ24EtEBMiehnidWe9jVIUjfq
         CdZFvaZq5IcH3ls+zQIrJXH9K7T2mw+V/R8AcEUCcC3Obv0U1iMOapj1fPdBgDCiSIWW
         7xcHnVejZBN/zu8v+QfvIUfVBvD6eyl2pTz0fi1+Zn8NmW2nmgQC8/MynnilIUHtF5fb
         mmF/v8b/Dv9DjWu2QbGe7U34Ka3wQM9NlktTZePIyXzeAX2E6B4jZs6b6/stfr9afTfP
         mFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAVaUW7VwZegQfkJwMOJ8uza77AqEjXeq+6lLbyPRPM=;
        b=dnm7NXzr0OfasXQ5ikZcqjGFchQtiunZ2TUe8RJQowPX9hwVq9eppUBDGPmiLTHDQC
         p8nSQ4ee8copSFUOqyU1CpEnPEOUgyGbQarc/Jof9WUkJxX3EmOpieetIJnxdK3iUwJG
         PYAZMtaGCXoDDcGEtbJeHdrWHA7S0rnjxP6BcKNKwzn7rSy9fZ/vb72xKi4PSxr6Uzrw
         CrS5PQA1IRM3v3xYk72Lt82E9h5fJOULsD8WyjHPUD+6Sc44truGP/mxJ3o6FlCffEwC
         tosKBIQVB4P8S7O/XCpE+bnliUrGcLvA4Rec6B694CYOzHodvCnqfRVVLhYP/qMMp8qM
         NvSA==
X-Gm-Message-State: AOAM532/PY6eAMB5nzYM0aSOv4zq5iDlxoy3D8T7QTFOcB1/rWCd10NB
        DLAtVrobFMenvx29wQxhQ2CUaPIw7aXevo7wnUo=
X-Google-Smtp-Source: ABdhPJzisz0W2lNrmBlCnPW5yf/NHJi2xOH4+cZ5xxIWgb4iDZYft3NFtXLC2sZ9FFQKQuPthOEekZMRwP+l5XBWL5E=
X-Received: by 2002:a9d:480d:: with SMTP id c13mr13251835otf.224.1598522447729;
 Thu, 27 Aug 2020 03:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200826063850.47625-1-alexandru.ardelean@analog.com>
 <20200826120042.200364-1-alexandru.ardelean@analog.com> <CA+U=DsrMDSTQKEc2_3+W8u4bLraAowVB3nB4huKY--v8gnds2Q@mail.gmail.com>
 <c3a9411e-186d-a3ac-5ad0-bd70ad78f147@st.com>
In-Reply-To: <c3a9411e-186d-a3ac-5ad0-bd70ad78f147@st.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 27 Aug 2020 13:00:36 +0300
Message-ID: <CA+U=DspjGUhXCY7c8P6zOYZsx17ybcU4Kdr52yujmdYOaa1JSQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: stm32-dac: Replace indio_dev->mlock with own
 device lock
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@kernel.org>, alexandre.torgue@st.com,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 12:03 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 8/27/20 10:55 AM, Alexandru Ardelean wrote:
> > On Wed, Aug 26, 2020 at 3:03 PM Alexandru Ardelean
> > <alexandru.ardelean@analog.com> wrote:
> >> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> >>
> >> As part of the general cleanup of indio_dev->mlock, this change replaces
> >> it with a local lock. The lock protects against potential races when
> >> reading the CR reg and then updating, so that the state of pm_runtime
> >> is consistent between the two operations.
> >>
> >> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> >> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >> ---
> > Forgot the changelog here.
> > Apologies.
> >
> > Changelog v1 -> v2:
> > * removed whitespace change for 'common' field
> > * updated comment about the lock usage
>
> Hi Alexandru,
>
> Sorry if I missed it... is there an update on the comment :-) ?

For a moment there, I thought I didn't.
GMail's threading is confusing.

----------------------------------------------------------------------------
As part of the general cleanup of indio_dev->mlock, this change replaces
it with a local lock. The lock protects against potential races when
reading the CR reg and then updating, so that the state of pm_runtime
is consistent between the two operations.
----------------------------------------------------------------------------

>
> Best Regards,
> Fabrice
> >
> >>  drivers/iio/dac/stm32-dac.c | 12 ++++++++----
> >>  1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> >> index 092c796fa3d9..7a8aed476850 100644
> >> --- a/drivers/iio/dac/stm32-dac.c
> >> +++ b/drivers/iio/dac/stm32-dac.c
> >> @@ -26,9 +26,11 @@
> >>  /**
> >>   * struct stm32_dac - private data of DAC driver
> >>   * @common:            reference to DAC common data
> >> + * @lock:              lock to protect the data buffer during regmap ops
> >>   */
> >>  struct stm32_dac {
> >>         struct stm32_dac_common *common;
> >> +       struct mutex            lock;
> >>  };
