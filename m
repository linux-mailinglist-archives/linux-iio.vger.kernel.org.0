Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D928A24011A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Aug 2020 05:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHJDHE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 23:07:04 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:44338 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgHJDHE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Aug 2020 23:07:04 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Aug 2020 23:07:03 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9CA182014566;
        Mon, 10 Aug 2020 11:01:28 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8wlyyMNXwMCF; Mon, 10 Aug 2020 11:01:28 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 77BBE20156E6;
        Mon, 10 Aug 2020 11:01:28 +0800 (HKT)
Received: from [10.128.2.32] (unknown [203.145.95.159])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 9CE4BC019F4;
        Mon, 10 Aug 2020 11:01:27 +0800 (HKT)
Subject: Re: [PATCH v5 3/3] iio/dac: convert ltc2632.txt to lltc,ltc2632.yaml
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200420042612.27752-1-chris.ruehl@gtsys.com.hk>
 <20200420042612.27752-4-chris.ruehl@gtsys.com.hk>
 <20200430152414.GA19887@bogus>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <95f3873d-c101-7a64-8456-840378dd49f3@gtsys.com.hk>
Date:   Mon, 10 Aug 2020 11:01:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200430152414.GA19887@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rob,

On 30/4/2020 11:24 pm, Rob Herring wrote:
> On Mon, Apr 20, 2020 at 12:26:08PM +0800, Chris Ruehl wrote:
>> Conversion of the ltc2632 to yaml format and name the file 'lltc,ltc2632.yaml'.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>> v5:
>> correct require section
>> set maintainer of analog.com
>> v4..v2: no change

1/3 and 2/3 make it already to linux-next.

I will send 3/3 with the corrections you requested as a new
stand alone patch and refer commit 6f1c9e0da9aae51177457731357ae8a2c8af27cd
for reference.

Regards
Chris
