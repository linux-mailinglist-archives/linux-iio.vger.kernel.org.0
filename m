Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C214373021
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhEDTAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 15:00:36 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:59348 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231274AbhEDTAf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 May 2021 15:00:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2F96F412D8;
        Tue,  4 May 2021 18:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1620154777; x=1621969178; bh=REihPN3naX/hGej1V146cRNS/
        fICUgQRZ5HGD8Pz0xs=; b=CCq2yO5UoALbpF+JeTRC3Rx9wqaU94VnCeB00CrRY
        7QFWs/HiruJ9RA+kz0lhRIDYvYAEy56geICfo4+GRL3pukAwiE/s4xuNHfjG/NEt
        MKqYM5toJHv9RYK3NX15UhvOPhNnxzN94qf/he6r2LHzg4M5gVsIqAF78k4vFXAj
        hM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pf-lFM0dqAYI; Tue,  4 May 2021 21:59:37 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8078541253;
        Tue,  4 May 2021 21:59:36 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.6) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 4 May
 2021 21:59:36 +0300
Message-ID: <136a077085488866235636be5884681341fb3644.camel@yadro.com>
Subject: Re: [PATCH 1/4] iio: proximity: vcnl3020: add periodic mode
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Date:   Tue, 4 May 2021 22:07:53 +0300
In-Reply-To: <20210502190054.4bd99a38@jic23-huawei>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
         <20210430152419.261757-2-i.mikhaylov@yadro.com>
         <20210502190054.4bd99a38@jic23-huawei>
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

On Sun, 2021-05-02 at 19:00 +0100, Jonathan Cameron wrote:
> On Fri, 30 Apr 2021 18:24:16 +0300
> Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> 
> > Add the possibility to run proximity sensor in periodic measurement
> > mode.
> 
> Without an interrupt?  Unusual and perhaps best left to userspace.

Do you mean without interrupt handler in driver for this particular interrupt?
If it's need to be added here, I can add it. In this patch I just added trigger
to enable/disable periodic measurement mode without interrupt handler.

> 
> > +		if (rc)
> > +			return rc;
> > +
> > +		/* Enable periodic measurement of proximity data. */
> > +		cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> > +
> > +		/*
> > +		 * Enable interrupts on threshold, for proximity data by
> > +		 * default.
> > +		 */
> > +		icr = VCNL_ICR_THRES_EN;
> > +	} else {
> > +		if (!vcnl3020_is_thr_enabled(data))
> > +			return 0;
> > +
> > +		cmd = 0;
> > +		icr = 0;
> > +		isr = 0;
> > +	}
> > +
> > +	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
> > +	if (rc)
> > +		goto end;
> > +
> > +	rc = regmap_write(data->regmap, VCNL_PS_ICR, icr);
> > +	if (rc)
> > +		goto end;
> > +
> > +	if (!state)
> > +		/* Clear interrupts */
> 
> Given you don't seem to have an interrupt. I guess this is clearing
> a status flag?

Yes, it is clearing flag in interrupt status register.

> 
> > +		rc = regmap_write(data->regmap, VCNL_ISR, isr);
> > +
> > +end:
> > +	if (state)
> > +		iio_device_release_direct_mode(indio_dev);
> 


