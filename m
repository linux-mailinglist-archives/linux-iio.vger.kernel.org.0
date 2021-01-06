Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E461C2EBC5C
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jan 2021 11:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbhAFKag (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jan 2021 05:30:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2295 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbhAFKag (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jan 2021 05:30:36 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4D9lqR6PB1z67Xwb;
        Wed,  6 Jan 2021 18:25:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 6 Jan 2021 11:29:53 +0100
Received: from localhost (10.47.75.92) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 6 Jan 2021
 10:29:53 +0000
Date:   Wed, 6 Jan 2021 10:29:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jyoti Bhayana <jbhayana@google.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <cristian.marussi@arm.com>, <sudeep.holla@arm.com>,
        <egranata@google.com>, <mikhail.golubev@opensynergy.com>,
        <Igor.Skalkin@opensynergy.com>, <Peter.hilber@opensynergy.com>,
        <ankitarora@google.com>
Subject: Re: Reply to [RFC PATCH v2 0/1] Adding support for IIO SCMI based
 sensors
Message-ID: <20210106102917.0000332c@Huawei.com>
In-Reply-To: <20210105230920.769144-1-jbhayana@google.com>
References: <20201230123748.4e969f82@archlinux>
        <20210105230920.769144-1-jbhayana@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.92]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Jan 2021 23:09:20 +0000
Jyoti Bhayana <jbhayana@google.com> wrote:

> Hi Jonathan,
> 
> > So, sensor_max_range can effectively be exposed as a combination of
> > scale and the *_raw_avail for a raw read (via the read_avail callback in IIO).
> > We'll ignore the fact the interface assumes a single value (so I assume symmetric?)  
> 
> Based on the SCMI specification the sensor min range and max range are 64 bits signed number.
> 
> looks like IIO_AVAIL_RANGE can only take the following
> types of data which all looks like 32 bit. IIO_VAL_FRACTIONAL
> also takes two int type numbers.
> How can I send 64 bit sensor range using this and read_avail callback?
> 
> #define IIO_VAL_INT 1
> #define IIO_VAL_INT_PLUS_MICRO 2
> #define IIO_VAL_INT_PLUS_NANO 3
> #define IIO_VAL_INT_PLUS_MICRO_DB 4
> #define IIO_VAL_INT_MULTIPLE 5
> #define IIO_VAL_FRACTIONAL 10
> #define IIO_VAL_FRACTIONAL_LOG2 11
> #define IIO_VAL_CHAR 12

Hmm It is a bit unfortunate that SCMI decided to pretend that real sensor resolutions were
greater than 32 bits. I doubt they will ever actually be any (as such accurate measurements
are completely pointless) and they aren't anywhere near that today.  Only way it might end
up looking a bit like that would be result of a highly non linear sensor being shoved through
an interface that pretends it isn't (goody).

Having said that, specifications are what they are and we have to cope with that.

There is no real problem with defining a new value type except for the fact that any
legacy userspace won't necessarily expect to see values that large. Given we need the full
64 bits it would have to be something like
IIO_VAL_INT_H32_L32 with the 64 bit values split up appropriately and put back together
at time of formatting.   Not particularly pretty but I'm not keep to put that much effort
in to support something like this for one driver (so not interesting in changing that
the read_raw_* interfaces)

Jonathan
 

> 
> 
> 
> Thanks,
> Jyoti
> 

