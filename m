Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B9F502E57
	for <lists+linux-iio@lfdr.de>; Fri, 15 Apr 2022 19:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiDORmD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Apr 2022 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiDORmC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2022 13:42:02 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117751A3AB
        for <linux-iio@vger.kernel.org>; Fri, 15 Apr 2022 10:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ZdklwSBhCAghbfD2ef7/3NzxE6oGHM6+8f7OcSAKHjY=; b=Sep+oYv380ExNo3zK6Aw0pJk13
        ANSootrJ77YRak0NdHgZMF44uT1VVHQasMjqvLIjngBguARvSb3Q7X1bESAATawKfTuogeXPS20Em
        4vriunaMdaVLvzQsNMROwk9dGAMGuli0wOWBUideMDGO3e9IbKIb9ox9Ol18qKvQKy/ifRXcky3OF
        rsO5DbJ+lDM6bcTguUyD2t0GUQCZ0MK+MsbdxfRHjnBOSPPAkXd5ORy1TeMcgkrosxZNhaax70TJ/
        a+rp6ZrC0De7JTUi+V3jGGh65qFApWuMCthnfrxHXTPIn/SzRYTyNQu30V4qxZBrEbkq5qnTWQhBr
        1+A5gvyA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1nfPuq-0000hZ-Kj; Fri, 15 Apr 2022 19:39:28 +0200
Received: from [2001:a61:2a5d:d701:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1nfPuq-0004Wo-Fv; Fri, 15 Apr 2022 19:39:28 +0200
Message-ID: <9dcc005b-20b4-6884-1096-6d81fedaddaf@metafoo.de>
Date:   Fri, 15 Apr 2022 19:39:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: iio: imu new driver
Content-Language: en-US
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
        Fawzi Khaber <Fawzi.Khaber@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <FRYP281MB020540A2361C4DCDB9F315A694EF9@FRYP281MB0205.DEUP281.PROD.OUTLOOK.COM>
 <89c89115-334b-27ae-413c-73b3006d3ffa@metafoo.de>
 <FR3P281MB175790BCD24EC802E3B22EC8CEEF9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <FR3P281MB175790BCD24EC802E3B22EC8CEEF9@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.5/26513/Fri Apr 15 10:22:35 2022)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/14/22 15:03, Jean-Baptiste Maneyrol wrote:
> Hello,
>
> accel and gyro are synchronized and are outputting data inside the same hardware FIFO, as inv_icm42600 is doing. The issue is that the sensors have different frequencies, using a header for signaling data availability, thus demultiplexing from userspace is not possible in a standard way.
>
> Solution found for inv_icm42600 was to use 2 devices with each one a buffer. FIFO is read, data demultiplexed, and sent in each device. Now that we can have 2 buffers for 1 device, is it simpler to use this solution rather than 2 devices?
>
> Thanks for your advice,
> JB

Hi,

So the data rates are synchronized, but different, i.e. integer ratios?

I think this might be a good use case to give the multi-buffer support a 
bit of real world testing.

- Lars


>
>
> From: Lars-Peter Clausen <lars@metafoo.de>
> Sent: Thursday, April 14, 2022 13:19
> To: Fawzi Khaber <Fawzi.Khaber@tdk.com>; jic23@kernel.org <jic23@kernel.org>
> Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; linux-iio <linux-iio@vger.kernel.org>
> Subject: Re: iio: imu new driver
>   
> [CAUTION] This is EXTERNAL email. Do not click any links or open attachments unless you recognize the sender and know the content is safe.
>
> ======================================================================
> On 4/14/22 12:35, Fawzi Khaber wrote:
>> Hello Jonathan,
>> We are currently implementing a new driver for an invensense chip similar to
>> iio/imu/inv_icm42600. The chip has 2 sensors a gyroscope and an
>> accelerometer, and we are wandering if it was better the have two
>> IIO devices, one for each sensor, or just one IIO device with two buffers.
> Are these two completely independent sensors that only sit in the same
> package or do they share a common clock and the data acquisition can be
> synchronized?
>
> If it is the latter the best might be to have a single device with a
> single buffer.
>
> Typical algorithms that process IMU data, like odometry, want to process
> the accelerator and gyroscope data jointly. If the data gets
> artificially separated into two buffers it first has to be re-aligned,
> which might be tricky to do.
>
> - Lars


