Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480A33D4894
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhGXPnl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 11:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGXPnk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 11:43:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E4860E92;
        Sat, 24 Jul 2021 16:24:10 +0000 (UTC)
Date:   Sat, 24 Jul 2021 17:26:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Message-ID: <20210724172642.27b4d8c0@jic23-huawei>
In-Reply-To: <CY4PR03MB3399CAA3C32707CE3564A44B9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
        <20210717142623.45f96a22@jic23-huawei>
        <CY4PR03MB3399CAA3C32707CE3564A44B9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Jul 2021 13:34:08 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> Hello Jonathan,
...
> > > +
> > > +	enable_reg = FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, dev-
> > >vga_buff_en) |
> > > +			FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, 1) |
> > > +			FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, dev-
> > >lo_buff_en) |
> > > +			FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, dev-
> > >if_mode_en) |
> > > +			FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, dev-
> > >iq_mode_en) |
> > > +			FIELD_PREP(ADRF6780_LO_X2_EN_MSK, dev-
> > >lo_x2_en) |
> > > +			FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, dev-
> > >lo_ppf_en) |
> > > +			FIELD_PREP(ADRF6780_LO_EN_MSK, dev->lo_en) |
> > > +			FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, dev-
> > >uc_bias_en);  
> > 
> > Here we are probably turning on a bunch of stuff which will result in power
> > usage.
> > Would it be sensible to turn it off again in remove path?  (devm managed
> > should be fine).  
> 
> Most of these attributes are enabled by default after device reset.
> Taking into account this statement, is it still worth adding a 'custom' remove path?

Perhaps a nice to have if they save power.
Got to love hardware that eats power until you load a driver!

Ah well,

Jonathan
