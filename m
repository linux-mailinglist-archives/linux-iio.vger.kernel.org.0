Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA5B400F11
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 12:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhIEKWZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 06:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237602AbhIEKWY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 06:22:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8858760F6D;
        Sun,  5 Sep 2021 10:21:18 +0000 (UTC)
Date:   Sun, 5 Sep 2021 11:24:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v3 04/10] iio: adc: at91-sama5d2_adc: convert to
 platform specific data structures
Message-ID: <20210905112439.3f90f5dd@jic23-huawei>
In-Reply-To: <fa9c0d56-7ac5-3ef7-a667-b148ec7b8bb0@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
        <20210901123013.329792-5-eugen.hristev@microchip.com>
        <fa9c0d56-7ac5-3ef7-a667-b148ec7b8bb0@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> > @@ -700,9 +786,9 @@ static int at91_adc_read_position(struct at91_adc_state *st, int chan, u16 *val)
> >   	*val = 0;
> >   	if (!st->touch_st.touching)
> >   		return -ENODATA;
> > -	if (chan == AT91_SAMA5D2_TOUCH_X_CHAN_IDX)
> > +	if (chan == st->soc_info.platform->touch_chan_x)
> >   		*val = at91_adc_touch_x_pos(st);
> > -	else if (chan == AT91_SAMA5D2_TOUCH_Y_CHAN_IDX)
> > +	else if (chan == st->soc_info.platform->touch_chan_y)
> >   		*val = at91_adc_touch_y_pos(st);
> >   	else
> >   		return -ENODATA;
> > @@ -715,7 +801,7 @@ static int at91_adc_read_pressure(struct at91_adc_state *st, int chan, u16 *val)
> >   	*val = 0;
> >   	if (!st->touch_st.touching)
> >   		return -ENODATA;
> > -	if (chan == AT91_SAMA5D2_TOUCH_P_CHAN_IDX)
> > +	if (chan == st->soc_info.platform->touch_chan_y)  
> 
> Could you please tidy up here before applying, there is a slip on my 
> side, it should be the pressure channel :
> 	if (chan == st->soc_info.platform->touch_chan_p)
> 
> (not the Y channel )
> 
> Thanks and sorry !
Done
