Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E5662A54
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 16:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbjAIPmz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 10:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbjAIPmf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 10:42:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B46140C3C
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 07:39:59 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NrJ3W75Kwz6J664;
        Mon,  9 Jan 2023 23:37:27 +0800 (CST)
Received: from localhost (10.45.145.18) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 15:39:57 +0000
Date:   Mon, 9 Jan 2023 15:39:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Subject: Re: fxls8962af: RTC and NTP
Message-ID: <20230109153955.000032ae@Huawei.com>
In-Reply-To: <3b268231-7115-d354-4258-9e928c2fa15e@geanix.com>
References: <3b268231-7115-d354-4258-9e928c2fa15e@geanix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.145.18]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Jan 2023 08:54:05 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> Hi Jonathan and list,
> 
> We are getting some weird timestamps (with fxls8962af) in the iio 
> buffers when time is set back by NTP.
> 
> Here I have dumped old_timestamp, timestamp from the 
> fxls8962af_fifo_flush():
> old_timestamp 1673008488434717043, timestamp 1673008489457042043
> *old_timestamp 1673008489457042043, timestamp 1673008485198504719*
> old_timestamp 1673008485198504719, timestamp 1673008486220571510
> 
> Time is set back in the middle data set, so the sample timestamp looks like:
> tstamp0 3091988802491735451
> tstamp1 4510969115526428858
> tstamp2 5929949428561122265
> tstamp3 7348929741595815672
> tstamp4 8767910054630509079
> tstamp5 -8259853706044349130
> tstamp6 -6840873393009655723
> tstamp7 -5421893079974962316
> tstamp8 -4002912766940268909
> tstamp9 -2583932453905575502
> tstamp10 -1164952140870882095
> tstamp11 254028172163811312
> tstamp12 1673008485198504719
> 
> Possible solutions?
> Could we store the sample time from the last collected data set?
> And use that if old_timestamp > timestamp?

Ah. I guess this is the timestamp interpolation code going wrong.
It should be possible to make that code 'sort of cope' with negatives
though it would be a slightly nasty heuristic.
You would make it go backwards a little for each fifo entry..

> 
> Or do you have any other idea's?

This mess is a side effect of me picking a silly default clock
a long time back (can't fix that as it's ABI...)

We could smooth it in the driver, but if you have
the option, I'd just change the default clock from userspace.
Take a look at current_timestamp_clock in sysfs.
You should be fine with "monotonic" 

> 
> /Sean

