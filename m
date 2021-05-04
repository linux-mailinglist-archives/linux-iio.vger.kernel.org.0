Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F963730ED
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 21:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEDTjT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 15:39:19 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:33588 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232153AbhEDTjS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 May 2021 15:39:18 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6650C41292;
        Tue,  4 May 2021 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1620157101; x=1621971502; bh=w9q0QAHmTKlfG/3GMTCTMNhc+
        XaGrbBBQtfB40X4qro=; b=rU4j4XlGU1MmmfG8bvCvrFC6C4aLO2/LUuyDyaE7m
        Df2xfStkzAvDi4po4Vus2eWO4xNAc+okcIlrZ1hPTI0s2SVc7R7KrqpgTq44wdR0
        YzmRSDXoUv/6OGvUS44yvI0bkM95vB2R+nWaYIxNGN81dgHTAlhENuuj82w8n2SE
        uE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oFJNUfFZy_eE; Tue,  4 May 2021 22:38:21 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 37F06412EE;
        Tue,  4 May 2021 22:38:20 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.6) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 4 May
 2021 22:38:20 +0300
Message-ID: <8dbdf071f9f2041b92cabfa417487a3ec3e9647e.camel@yadro.com>
Subject: Re: [PATCH 4/4] hwmon: vcnl3020: add hwmon driver for intrusion
 sensor
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Jean Delvare" <jdelvare@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Date:   Tue, 4 May 2021 22:46:53 +0300
In-Reply-To: <20210430163831.GA3163069@roeck-us.net>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
         <20210430152419.261757-5-i.mikhaylov@yadro.com>
         <20210430163831.GA3163069@roeck-us.net>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.0.6]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-04-30 at 09:38 -0700, Guenter Roeck wrote:
> On Fri, Apr 30, 2021 at 06:24:19PM +0300, Ivan Mikhaylov wrote:
> > Intrusion status detection via Interrupt Status Register.
> > 
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> 
> I think this should, if at all, be handled using the
> iio->hwmon bridge (or, in other words, require a solution
> which is not chip specific).

Thanks a lot for suggestion, it's actually looks what's needed here instead of
this driver. Anyways, there is no IIO_PROXIMITY support inside supported types
in iio_hwmon.c. Should I add additional case inside this driver for
IIO_PROXIMITY type?

> I am also not sure if "proximity" is really appropriate to use
> for intrusion detection in the sense of hardware monitoring.
> This would require a proximity sensor within a chassis, which
> would be both overkill and unlikely to happen in the real world.
> "Intrusion", in hardware monitoring context, means "someone
> opened the chassis", not "someone got [too] close".
> 

I'm not sure either but it exists :) And it's exactly for this purpose:
"someone opened the chassis", "how near/far is cover?".

