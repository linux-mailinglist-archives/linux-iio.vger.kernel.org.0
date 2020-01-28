Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DF14BCE3
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 16:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgA1PcA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 10:32:00 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:33294 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbgA1PcA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 10:32:00 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 49805469A5;
        Tue, 28 Jan 2020 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1580225516; x=1582039917; bh=zX3JraCJjM8GqTVE6B2fpMsNV
        P+nHqDWarEnSG7AUxw=; b=VgQQzQTSS4TGqHu2ko+0X3y7/ZMCaZ79Vl2KfX42f
        0Kl/hKJq882hX5QfXpye3omQ9UZfqZM3a9Nq73twG6KxXAR8zc4OwQBCjCiAIzup
        2FFqdL+fmrwmEO+XUcj/ENZLtZeSU6xb/hPF0RUdrEzdmp1GcZYiaIDUhYmcVpiL
        Jc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bf9BSzGqZSmV; Tue, 28 Jan 2020 18:31:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 54999469A1;
        Tue, 28 Jan 2020 18:31:56 +0300 (MSK)
Received: from localhost.localdomain (172.17.15.69) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 28 Jan 2020 18:31:55 +0300
Message-ID: <347fa610ef61d311486fa9eed66be3a4243a4459.camel@yadro.com>
Subject: Re: vcnl3020 hwmon/proximity driver
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jan 2020 18:31:55 +0300
In-Reply-To: <0e2f88e3-b7d3-9dd2-50ce-011be09d53c9@roeck-us.net>
References: <cb21d1285e04a8a7a3817398629431f69aeebf2f.camel@yadro.com>
         <0e2f88e3-b7d3-9dd2-50ce-011be09d53c9@roeck-us.net>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.17.15.69]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2020-01-28 at 05:22 -0800, Guenter Roeck wrote:
> On 1/28/20 3:31 AM, Ivan Mikhaylov wrote:
> > Hello, I want to make driver for vcnl3020 but not sure where should I put
> > it.
> > It's similar to vcnl40xx series which is already in iio/light/vcnl4000.c
> > but it perfectly fits with hwmon intrusion detection concept
> > (intrusion[0-*]_alarm), so I'm a little bit confused.
> > 
> > vcnl3020 - proximity sensor which mostly using for intrusion detection
> > vcnl4020 - light and proximity sensor
> > 
> > Doc's links:
> > https://www.vishay.com/docs/84150/vcnl3020.pdf
> > https://www.vishay.com/docs/83476/vcnl4020.pdf
> > 
> > That's what I think about possible ways:
> > 
> > 1. just iio/proximity/vcnl3020.c
> > 2. extend functionality inside vcnl4000.c with ifdefs and dts stuff and
> > maybe
> >     rename it with generalization inside
> > 3. hwmon driver for intrusion detection inside drivers/hwmon
> > 4. both iio/proximity/vcnl3020.c and hwmon/vcnl3020.c
> >     Example: hwmon/wm8350-hwmon.c + mfd/wm8350-core.c
> >     So, just make proximity driver, do the depend in Kconfig for hwmon
> > driver
> >     on proximity driver and use proximity driver calls if would be needed.
> > 
> 
> "intrusion" in the context of hardware monitoring is for chassis intrusion,
> not for intrusion into an area. This driver should reside in iio.
> 
> Thanks,
> Guenter

Guenter,
that's what I meant about intrusion, sorry for being inaccurate. This proximity
sensor can be used as chassis intrusion detector, that's why I mentioned about
hwmon and possible interface for such thing.

Thanks.


