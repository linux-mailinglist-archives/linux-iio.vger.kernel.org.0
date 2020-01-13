Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD237139BFE
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 22:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMV6W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 16:58:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728733AbgAMV6W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 16:58:22 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2CE921569;
        Mon, 13 Jan 2020 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578952701;
        bh=dMiza/iFXEPvYxpswfqKt8lrTVj6PkpTWxCzuISkOes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AIPV9ksy5zQIiyHAZyc6EUHspEbXIRjdyjILtjsn1YOGmbdnDfMxXxu9dMGqQ9l45
         L6b8PKp3loQkEysjwa2DkPFbyJ2fN31SVRulXCynXkhsZriKKrtMRuVrnFIUVmTI0y
         1lJcQEeZNqXqeCzhYTAgUf1h7NNdcyBgUDnMk5oE=
Date:   Mon, 13 Jan 2020 21:58:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@st.com>
Cc:     "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: fix single conversion
Message-ID: <20200113215816.753310aa@archlinux>
In-Reply-To: <1a4261a5-1835-a248-9094-c4e7236e7254@st.com>
References: <20191127130729.18511-1-olivier.moysan@st.com>
        <1a4261a5-1835-a248-9094-c4e7236e7254@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 10:05:47 +0000
Olivier MOYSAN <olivier.moysan@st.com> wrote:

> Hi Jonathan, all,
> 
> Kind reminder on this patch.

Gah. Sorry .I marked it to reply then forgot to actually come back and do so.

Thanks for the reminder.  Given timing I'll apply this to the togreg branch
of iio.git and get it lined up for the merge window.  Marked it for stable
so it should quickly get applied to stable as appropriate after that.

Sorry for the delay.

Thanks,

Jonathan

> Regards
> Olivier
> 
> On 11/27/19 2:07 PM, Olivier Moysan wrote:
> > Apply data formatting to single conversion,
> > as this is already done in continuous and trigger modes.
> >
> > Fixes: 102afde62937 ("iio: adc: stm32-dfsdm: manage data resolution in trigger mode")
> >
> > Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> > ---
> > changes in version 2:
> > - correct title
> > ---
> >   drivers/iio/adc/stm32-dfsdm-adc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > index e493242c266e..0339ecdd06bd 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -1204,6 +1204,8 @@ static int stm32_dfsdm_single_conv(struct iio_dev *indio_dev,
> >   
> >   	stm32_dfsdm_stop_conv(adc);
> >   
> > +	stm32_dfsdm_process_data(adc, res);
> > +
> >   stop_dfsdm:
> >   	stm32_dfsdm_stop_dfsdm(adc->dfsdm);
> >     

