Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5694F1F18A3
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgFHMUo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 08:20:44 -0400
Received: from first.geanix.com ([116.203.34.67]:41658 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbgFHMUo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 08:20:44 -0400
Received: from [192.168.100.99] (xb90f4a16.cust.hiper.dk [185.15.74.22])
        by first.geanix.com (Postfix) with ESMTPSA id 86B4E2120CEC;
        Mon,  8 Jun 2020 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1591618841; bh=S8/KI5ud2rD65ga8Au68tEG5mzA/HPuBa3OzB2H8zZ0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To;
        b=CAk2jgRbSzNueIJDRxZo+vmx3Cz3H8owkfzw61gZtiLjVd8PGRR6f4Fe7VKFnXR/f
         kWtYqP8xKG7avuHIFBOZ/FThhEooonm1z5/XDnUmJ7Z1o+54KRXCASdsA6sStdKDZN
         ktaXp8bNg+5aFZN02D/yZHGPB1hQSF2UL1LSuEwhaVa3mpgVmnNZqGNaGL0vonYg0l
         cQ8rJ+qVt7P2PtrW+jygOjyco5BmLXYgDd2hjMMq4dx2KUbTe7SKUQJO7uutaAoC80
         L9Qm7Lr1yuCUK79gZKibpPDDRIIn4zFbkn6ijkRPgX839OibQkSkxGWtUcaJ42s1bb
         lGg3c9YZfUAqQ==
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
From:   Sean Nyekjaer <sean@geanix.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
 <20200603102841.GC544784@lore-desk.lan>
 <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
 <20200603105105.GD544784@lore-desk.lan>
 <a6716a15-abf9-3218-00b8-fb7f257e5649@geanix.com>
 <20200603121227.GE544784@lore-desk.lan>
 <55fb09cf-76ab-0c42-7283-0836838f2deb@geanix.com>
 <20200603125630.GF544784@lore-desk.lan>
 <2d60c115-a634-c25f-b50b-38f13cac6229@geanix.com>
 <20200603134033.GG544784@lore-desk.lan>
 <2d8b2b9b-5e63-1254-04d9-8b9be0d91877@geanix.com>
Message-ID: <fbef0ac8-e313-c20c-9300-9dee00588102@geanix.com>
Date:   Mon, 8 Jun 2020 14:20:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2d8b2b9b-5e63-1254-04d9-8b9be0d91877@geanix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on fdf6823a942a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Thomas,

I have a question regarding CLOCK_REALTIME and CLOCK_BOOTTIME when 
resuming from suspend.

We have run into problems with 
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c + the first patch from 
Lorenzo Bianconi in this thread.
The accelerometer have an internal FIFO that includes a timestamp. When 
we resume from suspend,
the driver resets the fifo ts counter and sets an internal reference to 
that time.
But to me it looks like both CLOCK_REALTIME and CLOCK_BOOTIME aren't 
ready when st_lsm6dsx_resume() is called.

If this is a limitation, can you point to other drivers that have been 
able to workaround it?
Or can we wait for a flag or similar?

Best regards,
Sean Nyekjaer

