Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6087019DB34
	for <lists+linux-iio@lfdr.de>; Fri,  3 Apr 2020 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404336AbgDCQQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Apr 2020 12:16:49 -0400
Received: from mx-out2.startmail.com ([145.131.90.155]:46190 "EHLO
        mx-out2.startmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404035AbgDCQQs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Apr 2020 12:16:48 -0400
Date:   Fri, 3 Apr 2020 19:21:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2017-11; t=1585930607;
        bh=ipQrauf/RATph3AuYQzrJh8EzsblD3zQ5PJ+nD02B2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8G1Cgrjb1PcBHRAC4aMQlgyMJPyhCwBoYKwmYBPa9EkRjJeRitFhFgxygPrXXRav
         q58jHnhWHVRpmlMsOGj4VwkYolIedboNlDZVv/Wt5UW8WIit66lxwCXlma+6rVtCvE
         NmP7qTZhsgGGC+7qFgn/bCBydQORq/zt+k9cTIAn+I4RfNcx04+Y+CsXBTPNNzOCfQ
         EaCNlW7/b316Jh6rPHVwe5poQcD1zHxhf81l2KzSrhGG9PiVdXyImAcCAYmPMjmuMy
         Xwj/JIF2f+HpGYWNe5cRVumGcMycqSAeoTOqPOGjZT8OEnbIEWPNjv7lsPkO6eY7+d
         CL8g/rW8ZGIPA==
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
Subject: Re: [PATCH v7 2/2] iio: adc: Add MAX1241 driver
Message-ID: <20200403162154.GA8285@leena.republic>
References: <20200403121323.1742-1-alazar@startmail.com>
 <20200403121323.1742-3-alazar@startmail.com>
 <CAHp75VcKEqM4nxvu3QtqNDpwtJU77zu=YfPwmCXn_L=LsGSuAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VcKEqM4nxvu3QtqNDpwtJU77zu=YfPwmCXn_L=LsGSuAQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

> > Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-MAX1241.pdf
> >
> No blank line, but this can be fixed by maintainer, I think.

Oops! Not sure how I (and checkpatch.pl?) missed that! It's tiny enough
to fix inline I guess, but it's not a problem to make a v8 with it if
needed.

Thanks,
Alex
