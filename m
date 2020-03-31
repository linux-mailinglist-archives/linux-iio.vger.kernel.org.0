Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8CB199C40
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgCaQ4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 12:56:11 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35534 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730099AbgCaQ4K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 31 Mar 2020 12:56:10 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 855544126D;
        Tue, 31 Mar 2020 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1585673767; x=1587488168; bh=gqp2ICgJ2oa8nDsJt1Xk3VAdh
        K30cb8p4Nje35DG6LY=; b=iZHJ0fOlc7CKEAkrgHYsLLGzVeKsdbEYmt5eye6B0
        lGrV3ycOT8HS/AfyRxc/kfJwPgmQDRf2tcztqzMiOEqAcnA2IMZFFcZRJrKEZhPV
        edgs/qasWWSCg9TBeAQIgjec2MkT6IfEihQ432TNl8l/ZQXW+hP0iV2gQ10hvXfr
        jA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o0lESavaoZVW; Tue, 31 Mar 2020 19:56:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 3513C41259;
        Tue, 31 Mar 2020 19:56:07 +0300 (MSK)
Received: from localhost.localdomain (10.199.0.226) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 31 Mar 2020 19:56:07 +0300
Message-ID: <86186f02c630a05cf7254a38e0f15d726e2f440b.camel@yadro.com>
Subject: Re: [PATCH v5 2/2] iio: proximity: Add driver support for vcnl3020
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
Date:   Tue, 31 Mar 2020 19:56:18 +0300
In-Reply-To: <CAHp75VexS-iVeDXsCFqgzCKokgzzeH=BFtUqOJdY+kS8O6B9bw@mail.gmail.com>
References: <20200330152711.8769-1-i.mikhaylov@yadro.com>
         <20200330152711.8769-3-i.mikhaylov@yadro.com>
         <CAHp75VeLtPkb0e4uNP+1LGgtquBXkb5=bPi54O1U92uaO5jqvw@mail.gmail.com>
         <5cb43513906e1175801ea4e753c855623fcd11d1.camel@yadro.com>
         <CAHp75VexS-iVeDXsCFqgzCKokgzzeH=BFtUqOJdY+kS8O6B9bw@mail.gmail.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.0.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2020-03-31 at 14:00 +0300, Andy Shevchenko wrote:
> > > Why not to use standard pattern, i.e.
> > > 
> > >   if (rc)
> > >     return rc;
> > >   ...
> > >   rc = regmap_write(...);
> > > 
> > > ?
> > 
> > Optional parameter. There exists a lot of ways to do it:
> 
> I'm simple reading the code. And I believe the above I suggested is
> cleaner equivalent.
> Is it?
> 
> > rc = device_property_read_u32(dev, "milliamp", &led_current);
> > rc = regmap_write(regmap, VCNL_LED_CURRENT, (!rc) : led_current ? 0);
> 
> This seems not equal to above.

Yes, it is not equal. Error will be returned in case of non existent parameter
in vcnl3020_init but parameter is optional. rc shouldn't be checked or should
return 0 with your suggestion.

rc = device_property_read_u32(...);
if (rc)
	return 0;
rc = regmap_write(...);
if (rc)
	dev_err(...);
return rc;

