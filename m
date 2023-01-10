Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6B6641B3
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jan 2023 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbjAJN1b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Jan 2023 08:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbjAJN0o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2023 08:26:44 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6248BF1
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2023 05:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=5C4RBby8vZvXs8d8WfGpSxNcGw2ahNii4WYcDbFya1s=; b=Gop6k9vJjQMtCMNTdGvj+7t9jw
        exojX2OQNEfivj+4TINQhZtMcbQYBBJ55RTl1X33/ZSMucUVyIZaa/0d7q5fc2gc8uiwYBVGCZqhR
        z9T6zHFV3mFRZtXCVPOGWdn0Pc52pYfdosM1GhvRIR3pcK9ypONGAxPLMxed7FkFz+Z1rNRjsKbTm
        9C4bHetdksUOvVobCQ2lnQ/tbTEBzf3OZEUQYgKEx0BLTIWqG9e3PP6n8h5EKKAnbseLCf1IDwZqU
        j5yxQn5EbaJT4fr4uUdFL1h8JZ4a9jedLrLsbgO/Z3B29IMptAZ6kgLiCCk3DTyuEePHia5chfJlZ
        J1D/FXdw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pFEe1-00052p-6u; Tue, 10 Jan 2023 14:26:25 +0100
Received: from [185.17.218.86] (helo=[192.168.64.74])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pFEe0-0009RH-W6; Tue, 10 Jan 2023 14:26:25 +0100
Message-ID: <0bebf824-0c71-bfd7-4644-1a221b7f2d7f@geanix.com>
Date:   Tue, 10 Jan 2023 14:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: fxls8962af: RTC and NTP
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <3b268231-7115-d354-4258-9e928c2fa15e@geanix.com>
 <20230109153955.000032ae@Huawei.com>
Content-Language: en-US
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <20230109153955.000032ae@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.7/26777/Tue Jan 10 10:10:20 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/01/2023 16.39, Jonathan Cameron wrote:
> On Mon, 9 Jan 2023 08:54:05 +0100
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
>> Hi Jonathan and list,
>>
>> We are getting some weird timestamps (with fxls8962af) in the iio
>> buffers when time is set back by NTP.
>>
>> Here I have dumped old_timestamp, timestamp from the
>> fxls8962af_fifo_flush():
>> old_timestamp 1673008488434717043, timestamp 1673008489457042043
>> *old_timestamp 1673008489457042043, timestamp 1673008485198504719*
>> old_timestamp 1673008485198504719, timestamp 1673008486220571510
>>
>> Time is set back in the middle data set, so the sample timestamp looks like:
>> tstamp0 3091988802491735451
>> tstamp1 4510969115526428858
>> tstamp2 5929949428561122265
>> tstamp3 7348929741595815672
>> tstamp4 8767910054630509079
>> tstamp5 -8259853706044349130
>> tstamp6 -6840873393009655723
>> tstamp7 -5421893079974962316
>> tstamp8 -4002912766940268909
>> tstamp9 -2583932453905575502
>> tstamp10 -1164952140870882095
>> tstamp11 254028172163811312
>> tstamp12 1673008485198504719
>>
>> Possible solutions?
>> Could we store the sample time from the last collected data set?
>> And use that if old_timestamp > timestamp?
> 
> Ah. I guess this is the timestamp interpolation code going wrong.
> It should be possible to make that code 'sort of cope' with negatives
> though it would be a slightly nasty heuristic.
> You would make it go backwards a little for each fifo entry..
> 

Yeah agree, but then you could have 2 (or 3) samples with the same 
timestamp :/

>>
>> Or do you have any other idea's?
> 
> This mess is a side effect of me picking a silly default clock
> a long time back (can't fix that as it's ABI...)
> 
> We could smooth it in the driver, but if you have
> the option, I'd just change the default clock from userspace.
> Take a look at current_timestamp_clock in sysfs.
> You should be fine with "monotonic"
> 

We will switch to the monotonic clock for now :)

Thanks

/Sean
