Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04329243F67
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 21:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMTmI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMTmI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 15:42:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE062C061757;
        Thu, 13 Aug 2020 12:42:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x25so3345273pff.4;
        Thu, 13 Aug 2020 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dO4AJdg17GHiRVidFllXm247GrBnT3UM2a7xcTgo2Uo=;
        b=hEh9dMaqUZ7ggD36PCGiORMzFnBZH2DvakIvVc+1/63tPACTdK6ahZ1Vwsko29o/or
         /APxbeZTkO8sdlnJkxYf7qFdo2gJzpjE9DVq0FgsVyOXPLiFMTlZB1bgsoVovyaCoHG7
         bp33hwPdCpLt/K1YmzazB0gDolBdqM9bUQMBJF4I+Uejt/ekfY3nV7j3rOI+lwVuk3s7
         j89sNqD4FkW6BguvpAYwStw7tJh9O1K7ltDgR2BgkA6OqPMj1B0ukuIMrkLhyexfyUxT
         hBcuJPvyN81glma5JtllcxeDOUa4XF3fHW7JJHxeQE2VIbnTa6ws0UH9lfoxmcQovb0d
         pTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dO4AJdg17GHiRVidFllXm247GrBnT3UM2a7xcTgo2Uo=;
        b=tClOWha8tDsoeB53VugXcaWF0nQak+06MCtp8q0fNCmOI2PPb4Iy9Sp1DcKLKr3PEM
         bO1IQ0idXrTKiogBgCbOr1tJSMLIMHH2jq5tIymwz/pbGrCw0B01FLTabd0JIG19Yqln
         ZIDL0qh03bB6Ydq3ObNb0t5zuGBbsQa/gPqmFzxiwlRWEWHskm8aQcwrcU0yrePKN8Ts
         XUIrdzAxZEhy3/l05Us71HsXoktyKz8MLcCmalLvE0x2emgNb7RdoLjcDiWrvn7X0fRA
         OWYKD8vP+tnldTcM8r1TVh18dFX8HKw63+W8fYWXb1FZoeBgkLZqGRHduSEaIMk7P1nk
         ZVKg==
X-Gm-Message-State: AOAM531K8C1skqDF41VKV7zqdP6Ezrw6QXT14vPXFbVaz0rGIqw0RFtr
        hxSEYtdFHQtPUJC9FmpkkkJUHYXSscB0bkVQzrKfH03jYT0=
X-Google-Smtp-Source: ABdhPJwVdBv2nl3oMn2yL12xHkuYm1bhj+6iSeQ5lS0quXBvgO/1jJcNQ6BVCS8+SG3kLsw7CRDQDfIx+heiQ+lRNdA=
X-Received: by 2002:a62:158e:: with SMTP id 136mr5920565pfv.36.1597347727174;
 Thu, 13 Aug 2020 12:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200813075125.4949-1-cmo@melexis.com> <20200813075125.4949-6-cmo@melexis.com>
 <CAHp75Vd0D_jq7S=ANLJ-JSTb6iD1vHVRs2cN25Y3sNWCC9L2Xw@mail.gmail.com> <CAKv63uvrrc6Qfr2FjzgnNsHC0maZWT1Zpo=WQZvMmGgtYL6-tw@mail.gmail.com>
In-Reply-To: <CAKv63uvrrc6Qfr2FjzgnNsHC0maZWT1Zpo=WQZvMmGgtYL6-tw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 13 Aug 2020 22:41:51 +0300
Message-ID: <CAHp75VecZuvF3fyQV=uGK8NBpTStbASqdR_1kxb0g6_nHdfvQQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iio:temperature:mlx90632: Some stylefixing leftovers
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 13, 2020 at 4:12 PM Crt Mori <cmo@melexis.com> wrote:
> On Thu, 13 Aug 2020 at 13:01, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 13, 2020 at 10:53 AM Crt Mori <cmo@melexis.com> wrote:

...

> > > -#define MLX90632_REF_12                12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> > > -#define MLX90632_REF_3         12LL /**< ResCtrlRef value of Channel 3 */
> > > -#define MLX90632_MAX_MEAS_NUM  31 /**< Maximum measurements in list */
> > > -#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */

> > > +#define MLX90632_REF_12        12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
> > > +#define MLX90632_REF_3         12LL /* ResCtrlRef value of Channel 3 */
> > > +#define MLX90632_MAX_MEAS_NUM  31 /* Maximum measurements in list */
> > > +#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
> > >  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
> >
> > This was actually in doxy (perhaps kernel doc also understands this)
> > format of description.
> > Can you double check that the kernel doc is okay / not okay with it?
> >
> > If it is okay, perhaps it's better to convert others to that format
> > rather than dropping it.
> >
> It is indeed from doxygen and looking at other drivers it should not
> be OK. I checked the docs and it does not say in fact. Maybe Jonathan
> knows, but he was already OK with these changes in v1.

I'm fine with either choice.

-- 
With Best Regards,
Andy Shevchenko
