Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76301377B76
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 07:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhEJF1A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 01:27:00 -0400
Received: from first.geanix.com ([116.203.34.67]:50496 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhEJF1A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 01:27:00 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 5A1B4466CBC;
        Mon, 10 May 2021 05:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620624354; bh=9zEQACqcJ257x5CVo/4KL+IiFiOAUTmjj174QiiWF1s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W1Bgumat5t+THj1f4MdgfhTiqNRJ/oZDoDt0n9oNP/PllV7U9BLLxN/rBOn+mXkx4
         L5mjVBX5ytUNc73IJhIaKVXUTRCpCFEmbZoGLYBBposbClEVyqDiCY4VEXX7LfoLWo
         yNgh17txm7vsm9z9KayDTvqiyDp10DL8yeD6y6dMgimT0HP1jkqV91DNiB3oekePbD
         erIKLJeAI97fS32h5kI7b+fxixmHHuObLwA7lfDQV17XM5iikBdEkJqrmBDsMUPdnd
         nE1TuA6U5LikDcBSuh0bsai+2Uo8tWVD3QgFm+5lNfWojso/l6C19Th/PUG0XkBWyn
         N756ylhCYbkAQ==
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
References: <20210507103220.2194009-1-sean@geanix.com>
 <YJUeKhjooi8lAN1Q@lore-desk>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d0b62523-dcc9-ff14-aeaf-db24915f7aeb@geanix.com>
Date:   Mon, 10 May 2021 07:25:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJUeKhjooi8lAN1Q@lore-desk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07/05/2021 13.02, Lorenzo Bianconi wrote:
>> The correct way to set the sampling rate to 12.5 Hz before
>> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
>> was to write 13 Hz to sampling_frequency.
>> Before this patch writing 13 to samplerate results in sample rate set
>> to 26 Hz.
>> Now we return EINVAL if the sampling rate is not in table.
>>
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> 
> I think this patch is breaking i2c-master support available in st_lsm6dsx, have you tested it?
> 
I have not tested with i2c-master.
But it's not nice to round up sample rate from user space without any notice.

/Sean

