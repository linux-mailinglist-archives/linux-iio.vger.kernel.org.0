Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFA19FA28
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgDFQdQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 12:33:16 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48262 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728789AbgDFQdQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 12:33:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9704B41259;
        Mon,  6 Apr 2020 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1586190792; x=1588005193; bh=5jzTCimFf/ZN+kP2sD+q9bPMb
        I+Q4K3DWZbRHFkwR74=; b=DGLBL0YqcGOeu952klY/cvzNCyealrFkuiwZbyjdc
        7z9P+5KzECC3m8eMMBVGj7O2zvtVW9Dp2pT0qtRvL3R1wc2zw+DLVSEJ98NQBwJS
        yG4k9OEWHeICT9dwej1SvhFN1rxtcacC7BYuKWum+PW2vgQpcFjyXsuT1zy4YRGb
        s0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CN7tA-FteRvA; Mon,  6 Apr 2020 19:33:12 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 53EAB412E2;
        Mon,  6 Apr 2020 19:32:38 +0300 (MSK)
Received: from localhost.localdomain (10.199.2.226) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 6 Apr 2020 19:32:38 +0300
Message-ID: <b02f5e2fc09b30c36b0d9e8984c18eb21cba7b73.camel@yadro.com>
Subject: Re: [PATCH v7 2/2] iio: proximity: Add driver support for vcnl3020
 proximity sensor
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Apr 2020 19:32:56 +0300
In-Reply-To: <CAHp75Vdg7bhB69uQSZt2LK3JXJ-my-+-Mg-0F6ij9HcFdQ=LTg@mail.gmail.com>
References: <20200406151839.13572-1-i.mikhaylov@yadro.com>
         <20200406151839.13572-3-i.mikhaylov@yadro.com>
         <CAHp75Vdg7bhB69uQSZt2LK3JXJ-my-+-Mg-0F6ij9HcFdQ=LTg@mail.gmail.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.2.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-04-06 at 18:43 +0300, Andy Shevchenko wrote:
> On Mon, Apr 6, 2020 at 6:18 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
> > Proximity sensor driver based on light/vcnl4000.c code.
> > For now supports only the single on-demand measurement.
> > 
> > The VCNL3020 is a fully integrated proximity sensor. Fully
> > integrated means that the infrared emitter is included in the
> > package. It has 16-bit resolution. It includes a signal
> > processing IC and features standard I2C communication
> > interface. It features an interrupt function.
> > 
> 
> I don't know how to explain to you that if anybody gives the tag, you
> need to add it to your commit message.
> Why are you ignoring this?
> 

Sorry for that, I'll add it.

> Jonathan, my tag still applies here, but I'm so confused with the above.

