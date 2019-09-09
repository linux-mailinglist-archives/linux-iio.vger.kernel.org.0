Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7479AD919
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfIIMgO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:36:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfIIMgN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 08:36:13 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3lsh-1i71eB1YQt-000wUv; Mon, 09 Sep 2019 14:35:48 +0200
Date:   Mon, 9 Sep 2019 14:35:46 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: hx711: optimize sampling of data
Message-ID: <20190909123545.cecciemnmhspdsmq@arbad>
References: <20190907101759.kft6xwsqc5lf4acq@arbad>
 <20190908144922.51ba448e@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908144922.51ba448e@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:y60pSc79PYggcsjzod4fLvoxQ5L5sOZJJoIOqW9v3Z9Cxl/7srn
 kRCmbUIRdJKFqRiYZxWXqZLtDmiU8wf3SHVPYyX4gwq13vlTP6ps25MMACIV/H0/m0o+rPR
 3j7vRhsZ0enbDIpLFJFwJDWKSMtb9eDhiit1+juYbSc0JaXO0pkyrRre1hHpJLYVteNWyv8
 8vVupXKPG8cWzR8OakkoA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5s8W5jbWrGk=:zOSXgRCilv/xewhC0V803J
 yL5IRQ1EaSCEey9aNRi8ckTuwLNYYcgoeyoKbeDpQdkuyPBIl4PGau1i16JAOuwyCMDrYWr3k
 /HvRJUIcaQ3FyaiTlFNh66Y82s2aM/KRCHztDKRZ+EgvnC8tNdwqwzU2y8UW74Hsk7dJOc3PU
 L5NxXI87Y0x3t7k9XnbSJJuQwzdu7AGUukw3vbYRLBRTmF0s60HaHsUC7jbufZ7ZAmPvddx1r
 QnR6/KARcKNBaDo3ynQLVf2ePNzRGpIqA5RzNTCaAp0n1Qcw95TR/bMex7SLB9wmJ3Ixsss+0
 f2kLCaT0C+jPTAwjnPXSo6ICPX8bJX1OUdtJCiPGTyD/LUV301eKWIPFC7ediGZYRMetIiHxW
 bAkGUnH2dlC1AZ/VuSmqsjfT5xI5HTXVsmApJuZK0x4XXAnrKMIbd9hqTb71P1QQquTS+QXjp
 gj4+pjUKr8XdV7IB5DOTBPsk/UD68jhLOtHIlqmvTf/tJjH7XIvTEM3F5BsdZe3JXw/W1TddV
 uW6qlIpyamlQvTzF8YOvKV/CKGQliFVCy2h2ZmbrlGRBHx0I5SO9nBlroFM7UNYf6AhNDNO7G
 v8knHPaajKv67Pgae3b20rMttpQCja5xOKpfaeC15l/3Zx8Fuy5Xi6Ia5pJw8T2Iy2WxHgZO+
 BQvy0PHAZx1odujY7WhZ+HQaOGFBaT7qBcKUDf7I4dSHUj+WLfU7Hea1uBT8+dji58fulyX3Q
 vc0D8chSt/gvRpUikrKSH8W+sBFqYB2GYfrzgCe8w8P+Kgj7WWAjZQfLVQYDqnl1bBOVfIQ4O
 eQwtNwWIYVEeFjD9EaHoLiQNWyz5+iv/7o/F7lyk1THW8lRkbA=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

only patch 1 fixes a bug which is occurring on systems. In my test it happened
every one of about 10 - 15.000 measurements. But this depends on the interrupt
load of the system. With a high interrupt load there might be much more wrong
measurements.

Patch 2 is a performance optimization which prevents unneded reads. There is no
bug which is fixed by it.

I'll send out the patch set with more detailed commit messages.

Thanks,

Andreas


Jonathan Cameron <jic23@kernel.org> schrieb am So, 08. Sep 14:49:
> On Sat, 7 Sep 2019 12:18:00 +0200
> Andreas Klinger <ak@it-klinger.de> wrote:
> 
> > Fix bug in sampling function hx711_cycle() when interrupt occures while
> > PD_SCK is high. If PD_SCK is high for at least 60 us power down mode of
> > the sensor is entered which in turn leads to a wrong measurement.
> > 
> > Move query of DOUT at the latest point of time which is at the end of
> > PD_SCK low period.
> > 
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> 
> Hi Andreas,
> 
> One thing I'm not clear on from these is how much a 'fix' they
> are.  That just effects whether we mark them for stable / push them
> out as quickly as possible or not.  So has this been seen in 
> normal operation?
> 
> + please add fixes tags to the two fixes.
> 
> For patch 3, it's in the very low importance category so it may
> well get forgotten if these two go through the fixes tree
> (up to you to remind me!)
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/hx711.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > index 88c7fe15003b..0678964dbd21 100644
> > --- a/drivers/iio/adc/hx711.c
> > +++ b/drivers/iio/adc/hx711.c
> > @@ -101,13 +101,14 @@ struct hx711_data {
> >  static int hx711_cycle(struct hx711_data *hx711_data)
> >  {
> >  	int val;
> > +	unsigned long flags;
> >  
> >  	/*
> >  	 * if preempted for more then 60us while PD_SCK is high:
> >  	 * hx711 is going in reset
> >  	 * ==> measuring is false
> >  	 */
> > -	preempt_disable();
> > +	local_irq_save(flags);
> >  	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
> >  
> >  	/*
> > @@ -117,7 +118,6 @@ static int hx711_cycle(struct hx711_data *hx711_data)
> >  	 */
> >  	ndelay(hx711_data->data_ready_delay_ns);
> >  
> > -	val = gpiod_get_value(hx711_data->gpiod_dout);
> >  	/*
> >  	 * here we are not waiting for 0.2 us as suggested by the datasheet,
> >  	 * because the oscilloscope showed in a test scenario
> > @@ -125,7 +125,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
> >  	 * and 0.56 us for PD_SCK low on TI Sitara with 800 MHz
> >  	 */
> >  	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
> > -	preempt_enable();
> > +	local_irq_restore(flags);
> >  
> >  	/*
> >  	 * make it a square wave for addressing cases with capacitance on
> > @@ -133,7 +133,8 @@ static int hx711_cycle(struct hx711_data *hx711_data)
> >  	 */
> >  	ndelay(hx711_data->data_ready_delay_ns);
> >  
> > -	return val;
> > +	/* sample as late as possible */
> > +	return gpiod_get_value(hx711_data->gpiod_dout);
> >  }
> >  
> >  static int hx711_read(struct hx711_data *hx711_data)
> 

-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
