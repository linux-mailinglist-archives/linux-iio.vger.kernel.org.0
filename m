Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16615383AE3
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhEQRON (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 13:14:13 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:50964 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243316AbhEQROK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 13:14:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 370E541370;
        Mon, 17 May 2021 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1621271570; x=1623085971; bh=yk9EC+Dve1pamEtbvjpjbU1uw
        Oxf7cDLNNgPjnJ+aDs=; b=eZ7Z2RRNqXGEHeDei3cSHutMBxCxQz6+J9MLIYwI0
        VadwEH4iVup8LD2PLNo3DSPrh4nP1Sa+rMH5TjMejtDYdNCTJM1f4RYuPX5inWKz
        W/nAVSKemIWYdu4I7bYJAZtyMFvMBQk/bfqhFKLLLIAnuoHag+432eZPROhdQmlF
        gU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id He7ny6xBWzgN; Mon, 17 May 2021 20:12:50 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 835F241384;
        Mon, 17 May 2021 19:59:49 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.36) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 17
 May 2021 19:59:49 +0300
Message-ID: <f6d48db00698793b9d6a8c04a228101a0898e671.camel@yadro.com>
Subject: Re: [PATCH 4/4] hwmon: vcnl3020: add hwmon driver for intrusion
 sensor
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Jean Delvare" <jdelvare@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Date:   Mon, 17 May 2021 20:08:24 +0300
In-Reply-To: <20210505140208.GA1913659@roeck-us.net>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
         <20210430152419.261757-5-i.mikhaylov@yadro.com>
         <20210430163831.GA3163069@roeck-us.net>
         <8dbdf071f9f2041b92cabfa417487a3ec3e9647e.camel@yadro.com>
         <20210505140208.GA1913659@roeck-us.net>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.0.36]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2021-05-05 at 07:02 -0700, Guenter Roeck wrote:
> On Tue, May 04, 2021 at 10:46:53PM +0300, Ivan Mikhaylov wrote:
> > On Fri, 2021-04-30 at 09:38 -0700, Guenter Roeck wrote:
> > > On Fri, Apr 30, 2021 at 06:24:19PM +0300, Ivan Mikhaylov wrote:
> > > > Intrusion status detection via Interrupt Status Register.
> > > > 
> > > > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > > 
> > > I think this should, if at all, be handled using the
> > > iio->hwmon bridge (or, in other words, require a solution
> > > which is not chip specific).
> > 
> > Thanks a lot for suggestion, it's actually looks what's needed here instead
> > of
> > this driver. Anyways, there is no IIO_PROXIMITY support inside supported
> > types
> > in iio_hwmon.c. Should I add additional case inside this driver for
> > IIO_PROXIMITY type?
> > 
> > > I am also not sure if "proximity" is really appropriate to use
> > > for intrusion detection in the sense of hardware monitoring.
> > > This would require a proximity sensor within a chassis, which
> > > would be both overkill and unlikely to happen in the real world.
> > > "Intrusion", in hardware monitoring context, means "someone
> > > opened the chassis", not "someone got [too] close".
> > > 
> > 
> > I'm not sure either but it exists :) And it's exactly for this purpose:
> > "someone opened the chassis", "how near/far is cover?".
> > 
> 
> The cost for VCNL3020, for a full reel with 3,300 chips, is $1.17 per chip
> at Mouser. A mechanical switch costs a couple of cents. A single proximity
> sensor won't cover all parts of a chassis; one would likely need several
> chips to be sure that are no blind spots (if that is even possible - I don't
> think it is in any of my PC chassis due to mechanical limitations). This
> is on top of programming, which would be sensitive to generating false
> alarms (or missing alarms, for that matter). That sounds quite impractical
> and expensive to me. I'd really like to see the actual use case where a
> proximity sensor (or set of proximity sensors) is used for intrusion
> detection in the sense of hardware monitoring - not just the technical
> possibility of doing so, but an actual use case (as in "this vendor,
> in this chassis, is doing it").
> 
> Thanks,
> Guenter


Guenter, VCNL3020 is indeed used as an intrusion detection sensor at least in
one real design. That is YADRO VESNIN Rev. C where the proximity sensor is
installed in a very tight space on an nvme switch board where installation of a
mechanical switch was not possible without substantial redesign of the existing
other components that would cost a lot more than the price of VCNL3020.

VESNIN is a very tight-packed design of 4 x POWER8 CPUs, up to 8TB of RAM, and 26 nvme disks, all that in just 2U.
* https://imgur.com/a/wU9wEd4

