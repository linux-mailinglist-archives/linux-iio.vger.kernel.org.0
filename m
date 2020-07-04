Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF52147AD
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGDRTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:19:08 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:39058 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDRTH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 13:19:07 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jul 2020 13:19:05 EDT
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id F0645262A8;
        Sat,  4 Jul 2020 17:10:05 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 8A11E3EDBF;
        Sat,  4 Jul 2020 19:10:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 6A12B2A471;
        Sat,  4 Jul 2020 19:10:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1593882604;
        bh=Oh89PeufN+3MyJsfzfSuPCx1RHymIRgAAncoA5AuOco=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jQPvRMERojRiKHXXS5VsZ2FdputuBBgGb/ivmH/yq4eS4XZ54BMIfx2djLrtaRrCq
         deT2nGKg6h1b+RNYt7WuQ5opReYyw6KIyO6BJZGY/cYWoIVD9DQ6aQLWUI86w6xSaz
         xdxtRBMUEGKSGfBFFYUV0yRZaAQZh6f/bCBmnT5U=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fj_ruD_uNVqs; Sat,  4 Jul 2020 19:10:02 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  4 Jul 2020 19:10:02 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 1C63F41AE2;
        Sat,  4 Jul 2020 17:10:01 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="Ndl0uG5U";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 663EA41AE2;
        Sat,  4 Jul 2020 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1593882594; bh=Oh89PeufN+3MyJsfzfSuPCx1RHymIRgAAncoA5AuOco=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ndl0uG5UzmdNKSLEFghArUx2osSyHvOAXbigKPqF5aUOSyfQ9XFpBm/sJ21VzxJbL
         Q+jlcjSY/4eOTP7TX0EKJHB+w0B+DWwL0fHEBWNnNol+Sbu8wgLFR0V9+7K4L9lp1M
         DzwLbjhCqdqUPwjvxpRaqBBrQ7CpVToXOvMIr33U=
Message-ID: <d2df561c8db7e11eb6937f824f483e33be1db7bc.camel@aosc.io>
Subject: Re: [PATCH] iio: light: stk3310: add chip id for STK3311-X variant
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Jonathan Cameron <jic23@kernel.org>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Date:   Sun, 05 Jul 2020 01:09:37 +0800
In-Reply-To: <20200704172916.7a8a7359@archlinux>
References: <20200703194406.110855-1-megous@megous.com>
         <20200704172916.7a8a7359@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C63F41AE2
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmx.de];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.119:received];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,metafoo.de,pmeerw.net,z3ntu.xyz];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

在 2020-07-04星期六的 17:29 +0100，Jonathan Cameron写道：
> On Fri,  3 Jul 2020 21:44:05 +0200
> Ondrej Jirman <megous@megous.com> wrote:
> 
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > The STK3311 chip has a variant called STK3311-X, which has a
> > different
> > chip id of 0x12.
> > 
> > Add the chip id to the driver.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Given this is clearly not quite compatible with the stk3311 probably
> best to also add a an id to the of id table.  Any idea what else
> is different?

By the way, STK3311 seems to have many variants lying around, and all
of them have different IDs. The pinouts seem to be different but the
registers are compatible.

[1] is a datasheet of STK3311-S34 with ID 0x1e.
[2] is a datasheet of STK3311-A with ID 0x15.

I cannot find the datasheet of STK3311-X, 0x12 is read from the device.
The model number itself is mentioned at [3], the official website of
sensortek.

[1] 
http://pro0fc108.hkpic1.websiteonline.cn/upload/STK3311-S34Datasheetv1.pdf

[2] 
http://pro0fc108.hkpic1.websiteonline.cn/upload/STK3311-ADatasheetv1.pdf

[3] 
http://www.sensortek.com.tw/index.php/en/products/proximity-sensor-with-als/

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/stk3310.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/light/stk3310.c
> > b/drivers/iio/light/stk3310.c
> > index 185c24a75ae6..1a8401d198a4 100644
> > --- a/drivers/iio/light/stk3310.c
> > +++ b/drivers/iio/light/stk3310.c
> > @@ -37,6 +37,7 @@
> >  
> >  #define STK3310_CHIP_ID_VAL			0x13
> >  #define STK3311_CHIP_ID_VAL			0x1D
> > +#define STK3311X_CHIP_ID_VAL			0x12
> >  #define STK3335_CHIP_ID_VAL			0x51
> >  #define STK3310_PSINT_EN			0x01
> >  #define STK3310_PS_MAX_VAL			0xFFFF
> > @@ -453,6 +454,7 @@ static int stk3310_init(struct iio_dev
> > *indio_dev)
> >  
> >  	if (chipid != STK3310_CHIP_ID_VAL &&
> >  	    chipid != STK3311_CHIP_ID_VAL &&
> > +	    chipid != STK3311X_CHIP_ID_VAL &&
> >  	    chipid != STK3335_CHIP_ID_VAL) {
> >  		dev_err(&client->dev, "invalid chip id: 0x%x\n",
> > chipid);
> >  		return -ENODEV;
