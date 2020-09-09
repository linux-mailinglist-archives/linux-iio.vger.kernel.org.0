Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D826357A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 20:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIISFp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 14:05:45 -0400
Received: from mailout09.rmx.de ([94.199.88.74]:35137 "EHLO mailout09.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgIISFe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:05:34 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout09.rmx.de (Postfix) with ESMTPS id 4BmqgW0m44zbgxm;
        Wed,  9 Sep 2020 20:05:27 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BmqgJ31gnz2xDN;
        Wed,  9 Sep 2020 20:05:16 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.12) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 9 Sep
 2020 20:04:54 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: as73211: Increase measurement timeout
Date:   Wed, 9 Sep 2020 20:04:24 +0200
Message-ID: <6187855.5mNlXCv1x4@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAHp75VeAoDaBtaSb0Qeb=kHPg6kGvx71_iL2snC5iHh4cKPhRA@mail.gmail.com>
References: <20200909154439.10308-1-ceggers@arri.de> <CAHp75VeAoDaBtaSb0Qeb=kHPg6kGvx71_iL2snC5iHh4cKPhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.12]
X-RMX-ID: 20200909-200524-4BmqgJ31gnz2xDN-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wednesday, 9 September 2020, 18:58:39 CEST, Andy Shevchenko wrote:
> On Wed, Sep 9, 2020 at 6:45 PM Christian Eggers <ceggers@arri.de> wrote:
> > We found some sensors which are much slower (20% at room temperature)
> > than nominal. According to the data sheet, up to 27% is possible. Now I
> > add 33% to the nominal time out, hopefully this is enough.
> 
> I'm wondering if this is a function of temperature.
> And if that has an actual thermistor inside...
 I haven't designed the hardware, but I guess that clock generation is done 
using an RC oscillator which depends on temperature. Temperature measurement 
is possible, but I think the recommended way is to externally control the 
integration time using the SYN pin and to get the actual number of RC cycles 
from a register. But generating the required waveform for the SYN pin using a 
uC general purpose timer seems challenging.

I wouldn't be surprised if the measurement results also depend on the exact 
value of the supply voltage.


