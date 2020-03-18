Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD435189F42
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 16:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCRPJt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 11:09:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgCRPJs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 11:09:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so13834180pgs.9
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a5+eGpLd/ZyNdymY7en9Tb95ipkb72Q/3sFZJa0Gpyg=;
        b=sxCMnEaKy87cE/ac1DmsV4CXX/Ik2LiAhg8nPj5rDgx4ia2rQsuRbmWpg0dIfQ0AiV
         UFaWAG80VbqAv1JV8Y/lpRvYSAMBZDIpjzm+pyR8koyNcG5Lgws2xPBh23NHXMx3VgRM
         tsK/Ynf4tocyQECrvFB2HaoXqARZRJlnXgQXEM9nFdRT/qwkDtHTUAn5lLBLy2mOekQ7
         XTLZ1G8GVU/5CgB6XY74V6I8kQ/pdQvSdp9SCRmiAZHgk6aj2WKotCym/++nwnUIF26u
         Wy18v7CzybbGDWCdpfSznOFsl72NL7XjVLixOU9v5L+0g+ZOuQomV1xicSXWreFXx21g
         dS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a5+eGpLd/ZyNdymY7en9Tb95ipkb72Q/3sFZJa0Gpyg=;
        b=LC+Ft9kOKGESAnCws01YzEGJD9dwTlPnkg7xzs/HTjI3bYSAJ1X0TP1K3tTjEVw7Xe
         i62e5EbQttasoSYcKgEssILDQCj0kqK5IvCE4hisiCn8vUmYW1Ud4JBbipOu7qp5dyGq
         bdBPVVJuY9QHa+QY8shFFDPbqkbqfxUBF1J4Lp3ECalS1ELVlPNkbqCnpz3aIQhrw/ER
         VHtv4dph+ItOuKvBfwN1ZrOlY6HryD9AqK8UoRsYBhAjMeDM8oMxi9gI1+FPFDPxXoES
         NO2ch1BLne7Q+REOFafCY7ONcO9SvnJ824KBc/tFb1TyZNL7wKqG22ZJgf00H7fmq40M
         hbqA==
X-Gm-Message-State: ANhLgQ1kiplsJNcxoQGWw/+Sf27RWJk9GUl5xx4HcAXFyNftNPPqIrvr
        POkaXMoUr0stsT1+pm5KYBc=
X-Google-Smtp-Source: ADFU+vtlZmsdpIRZXNX1wTb4aGLOwsmPNX60PHksnOn9InUaZdvaR4k0kq5LPtVQn6tl/O1KJOGgTA==
X-Received: by 2002:a63:d658:: with SMTP id d24mr5203839pgj.340.1584544185875;
        Wed, 18 Mar 2020 08:09:45 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id j4sm7038445pfg.133.2020.03.18.08.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 08:09:45 -0700 (PDT)
Date:   Wed, 18 Mar 2020 20:39:39 +0530
From:   DEEPAK VARMA <mh12gx2825@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, stefan.popa@analog.com,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7280a: Add spaces around
 operators
Message-ID: <20200318150937.GA22841@deeUbuntu>
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
 <20200318060038.GB1594471@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318060038.GB1594471@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 07:00:38AM +0100, Greg KH wrote:
> On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
> > Add spaces around operator symbols to improve readability. Warning
> > flagged by checkpatch script.
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 19a5f244dcae..34ca0d09db85 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> >  }
> >  
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> > -			     in_voltage-voltage_thresh_low_value,
> > +			     in_voltage - voltage_thresh_low_value,
> >  			     0644,
> >  			     ad7280_read_channel_config,
> >  			     ad7280_write_channel_config,
> >  			     AD7280A_CELL_UNDERVOLTAGE);
> >  
> >  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> > -			     in_voltage-voltage_thresh_high_value,
> > +			     in_voltage - voltage_thresh_high_value,
> >  			     0644,
> >  			     ad7280_read_channel_config,
> >  			     ad7280_write_channel_config,
> 
> Did you try building this code?
> 
> It catches everyone...

yes sir, I did. See this:

  CC [M]  drivers/staging/fbtft/fbtft.mod.o
  CC [M]  drivers/staging/iio/adc/ad7192.mod.o
  LD [M]  drivers/staging/iio/adc/ad7280a.ko
  LD [M]  drivers/staging/media/ipu3/ipu3-imgu.ko
  LD [M]  drivers/staging/fbtft/fbtft.ko
  LD [M]  drivers/staging/iio/adc/ad7192.ko

Let me know if I missed something.

Thank you,
Deepak.

> 
> greg k-h
