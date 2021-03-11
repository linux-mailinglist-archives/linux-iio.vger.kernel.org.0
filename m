Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC6336F60
	for <lists+linux-iio@lfdr.de>; Thu, 11 Mar 2021 10:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhCKJ4K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 04:56:10 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:1347 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbhCKJ4A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 04:56:00 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 660EAA18F1;
        Thu, 11 Mar 2021 10:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=Hho8sCwHXdiv
        Va2f3D+zupd7uEjiXNvLZSh9/qyBmO0=; b=TghzjHDRrKjPK7/DJ9d36apunlbL
        SWLTPM3WW+OopkXH1LOQN0IV7NHXxwKEyw+hgmseqeUEZOGdH3kY5tG+ohrT39eo
        ONiIfpxKo7reki2cp4IkYsXwfWOoDPPzH3sh+LB1peBRC0HDakbtzSD1rN9qfYNI
        bNpz8tTTrrdOMd/5DYk+umYP8vnSQ2z/E/ioxp219k5pmoECV2Z7H8+uS2ojdjjd
        w2MlCPZQCJCGxmeSD+f+iv09AWjT/gWHHPA1DbpvJGiGPMHpfAX66o1tOCGHRzzD
        b0m6QZfhakbQHDXtW9kM90jktU9q0pU/BIg5nnv61/QVyNRf7Q1q5ruDOw==
To:     Jyoti Bhayana <jbhayana@google.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210309231259.78050-1-jbhayana@google.com>
 <20210309231259.78050-2-jbhayana@google.com>
 <0b9483ca-6f61-cc13-34e6-7f8c31c4c626@opensynergy.com>
 <CA+=V6c1y_zhqinG4zvxCX5hPM9hNH-9_7ESmHJ87c80RFTBWfA@mail.gmail.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <695b1680-9e5a-89bd-bd3b-e794200587dc@opensynergy.com>
Date:   Thu, 11 Mar 2021 10:55:48 +0100
MIME-Version: 1.0
In-Reply-To: <CA+=V6c1y_zhqinG4zvxCX5hPM9hNH-9_7ESmHJ87c80RFTBWfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10.03.21 18:19, Jyoti Bhayana wrote:
> Hi Peter,
> 
> As already discussed with ARM, the spec clearly mentions that it has
> to be uppercase and not case insensitive. So this patch is consistent
> with the specs and changing it with means that the spec would need to
> change as well. Therefore, there is no need for another version of the
> patch
> 
> "A NULL terminated UTF-8 format string with the sensor axis name, of
> up to 16 bytes. It is recommended that the name ends with ‘_’ followed
> by the axis of the sensor in uppercase.
> For example, the name for the x-axis of a triaxial accelerometer could
> be “acc_X” or “_X"
> 

My understanding of the part of the spec quoted above is different: The
spec only makes a recommendation and does allow additional or even
contradictory sensor axis naming schemes. So the change to the
implementation only would in principle be possible (disregarding
integration timeline constraints).

Best regards,

Peter

> Thanks,
> Jyoti
> 
> On Wed, Mar 10, 2021 at 3:16 AM Peter Hilber
> <peter.hilber@opensynergy.com> wrote:
>>
>> On 10.03.21 00:12, Jyoti Bhayana wrote:
>>> This change provides ARM SCMI Protocol based IIO device.
>>> This driver provides support for Accelerometer and Gyroscope using
>>> SCMI Sensor Protocol extensions added in the SCMIv3.0 ARM specification
>>>
>>
>> [snip]
>>
>>> +
>>> +static int scmi_iio_get_chan_modifier(const char *name,
>>> +                                   enum iio_modifier *modifier)
>>> +{
>>> +     char *pch, mod;
>>> +
>>> +     if (!name)
>>> +             return -EINVAL;
>>> +
>>> +     pch = strrchr(name, '_');
>>> +     if (!pch)
>>> +             return -EINVAL;
>>> +
>>> +     mod = *(pch + 1);
>>> +     switch (mod) {
>>> +     case 'X':
>>> +             *modifier = IIO_MOD_X;
>>> +             return 0;
>>> +     case 'Y':
>>> +             *modifier = IIO_MOD_Y;
>>> +             return 0;
>>> +     case 'Z':
>>> +             *modifier = IIO_MOD_Z;
>>> +             return 0;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +}
>>> +
>>
>> Hi Jyoti,
>>
>> could you still change the above code to also accept lower case 'x',
>> 'y', 'z'?
>>
>> Supporting lower case as well would establish compatibility with the
>> lower case naming conventions used for IIO channels. By this change,
>> channels could be forwarded without name changes (as long as they fit
>> into the name field). I'm sorry to notice this only now.
>>
>> Best regards,
>>
>> Peter
>>
> 


