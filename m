Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6124E1A3321
	for <lists+linux-iio@lfdr.de>; Thu,  9 Apr 2020 13:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDILYS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 9 Apr 2020 07:24:18 -0400
Received: from relay-1.mailobj.net ([213.182.54.6]:39790 "EHLO
        relay-1.mailobj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDILYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2020 07:24:17 -0400
Received: from www-1.localdomain (www-1.in.mailobj.net [192.168.90.193])
        by relay-1.mailobj.net (Postfix) with SMTP id B18B31398;
        Thu,  9 Apr 2020 13:24:15 +0200 (CEST)
Received: by www-1.mailo.com with http webmail; Thu,  9 Apr 2020
  13:24:15 +0200 (CEST)
X-EA-Auth: 51f63A1iQWxjqfuqS0pH2z02upEdsLkubR47eUqcAZ3JuimLp08tE51jLpcDOMo5bgMTgGNe1IbrPKj8VHF0LURKFEuFHCOD
From:   yarl-baudig@mailoo.org
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, "Hartmut Knaack" <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        "Denis Ciocca" <denis.ciocca@st.com>
Date:   Thu,  9 Apr 2020 13:24:15 +0200 (CEST)
Subject: Re: [PATCH] iio: st_sensors: rely on odr mask to know if odr can
 be set
X-Priority: 3
MIME-Version: 1.0
X-Mailer: COMS/EA19.11/r20200317
Message-ID: <ea-mime-5e8f05df-2178-2373fc98@www-1.mailo.com>
In-Reply-To: <20200405125702.2e72981c@archlinux>
Content-Type: text/plain;
 charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Oh, sorry, just saw your answer. Ok I can list such sensors.
Please tell me what I should do about Fixes tag. That's the first time I send a patch I'm not sure What I should put in it.
Is it :
Fixes: 4358be137952 (MAINTAINERS: Add Syed Nayyar Waris to ACCES 104-QUAD-8 driver)
? Thank you.
---- Message d'origine ----
> De : Jonathan Cameron <jic23@kernel.org>
> À : yarl-baudig@mailoo.org
> Sujet : Re: [PATCH] iio: st_sensors: rely on odr mask to know if odr can be set
> Date : 05/04/2020 13:57:02 Europe/Paris
> Copie à : linux-iio@vger.kernel.org;
>       Hartmut Knaack <knaack.h@gmx.de>;
>       Lars-Peter Clausen <lars@metafoo.de>;
>       Peter Meerwald-Stadler <pmeerw@pmeerw.net>;
>       Denis Ciocca <denis.ciocca@st.com>
> 
> On Thu,  2 Apr 2020 15:40:59 +0200 (CEST)
> yarl-baudig@mailoo.org wrote:
> 
> > Indeed, relying on addr being not 0 cannot work because some device have
> > their register to set odr at address 0. As a matter of fact, if the odr
> > can be set, then there is a mask.
> 
> Hi Lary,
> 
> Which sensor has ODR in the register at address 0?
> 
> I see it's a few of the magnetometers from a quick grep, but please state
> it in the cover letter.  Also please add a suitable Fixes tag
> as we will want this backported if appropriate.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Lary Gibaud <yarl-baudig@mailoo.org>
> > ---
> >  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c 
> b/drivers/iio/common/st_sensors/st_sensors_core.c
> > index a0c2cbd60c6f..cccd4c26dfa4 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > @@ -79,7 +79,7 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, 
> unsigned int odr)
> >  	struct st_sensor_odr_avl odr_out = {0, 0};
> >  	struct st_sensor_data *sdata = iio_priv(indio_dev);
> >  
> > -	if (!sdata->sensor_settings->odr.addr)
> > +	if (!sdata->sensor_settings->odr.mask)
> >  		return 0;
> >  
> >  	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);
> 
> 


