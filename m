Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D01219D646
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 14:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390892AbgDCMEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 08:04:10 -0400
Received: from mx-out1.startmail.com ([145.131.90.139]:45266 "EHLO
        mx-out1.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390889AbgDCMEK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 08:04:10 -0400
Date:   Fri, 3 Apr 2020 15:09:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585915447;
        bh=sWCUwsnJi/9mDpPt7Uwt8lPdg7wFAnXjItF3GoCua1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geBja6fExdFuuCn3nGv7IaHlleKsYKeMq4USHT9NrRvegadRryobAkvBXxFQeSY0I
         uqNfa9PxelHQMGO1/ZfPrtJ066Xffqc7M4puLydJvbB2ngW6C/vKiG7Mbwx7KA4vj0
         7bBOBiy1HPHe87j8DNfz8voumNwOQPAJUIGBg7uxHRFR/P86sY1WdfCSQ4w5n26a/Q
         cJCtlgRbn5F9uR9ELGzMC2xFYYLkUCx6ZcuLzaY/SZPWdX/ohB0MyWTHU6C9sgpv1c
         zGzR2DemCKiKRy5PI0VKjhLSpqRbpPK55YEWI7u9pL3zSEwgbjU6FghRSlAyw5hQy3
         92MX6szSO/iYw==
From:   Alexandru Lazar <alazar@startmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v6 2/2] iio: adc: Add MAX1241 driver
Message-ID: <20200403120916.GA1623@leena.republic>
References: <20200401185138.10673-1-alazar@startmail.com>
 <20200401185138.10673-3-alazar@startmail.com>
 <CAHp75VffpBYh+5xrWeeJJH8gRmJqT9ya5eQFedWi190_=p8HKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VffpBYh+5xrWeeJJH8gRmJqT9ya5eQFedWi190_=p8HKQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 02, 2020 at 09:45:32PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 1, 2020 at 9:47 PM Alexandru Lazar <alazar@startmail.com> wrote:
> >
> > Add driver for the Maxim MAX1241 12-bit, single-channel ADC.
> >
> 
> Perhaps put data sheet link as Datasheet: tag here?

Sure, makes sense. I'll send a v7 in a jiffy.
