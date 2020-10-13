Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D167F28C6A7
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 03:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgJMBNP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 21:13:15 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.2]:16434 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727950AbgJMBNP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2020 21:13:15 -0400
Received: from [100.112.1.102] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-east-1.aws.symcld.net id 9E/D7-19530-82FF48F5; Tue, 13 Oct 2020 01:13:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRWlGSWpSXmKPExsWSLveKTVfjf0u
  8wfLVyhaHF71gtPj67Ta7xZvj05ksztxeyGSxauE1Not5R96xWNz89I3VYu/i7ewOHB47Z91l
  9/i1bQ2LR8uRt6weyw9OY/KY8OEtm8f7fVfZPD5vkgtgj2LNzEvKr0hgzZj1cwtrwS35iu57v
  WwNjDsluxi5OIQE/jNKfDy2mLGLkRPIec4osWCqVBcjB4ewQLzEkidaIGERgTqJrsU3WUDqmQ
  WuMkp8ufKODaJ5M4vEnanP2ECq2AS0JbZs+QVm8wrYSqx4foIJxGYRUJXYfridBcQWFQiX6Li
  xgwmiRlDi5MwnYHFOkPoLx8B6mQUsJGbOP88IYYtL3HoynwnClpfY/nYOM4gtAWSfW3CQEcJO
  kFj28g7zBEbBWUjGzkIyahaSUbOQjFrAyLKK0TSpKDM9oyQ3MTNH19DAQNfQ0EjXWNfURC+xS
  jdJr7RYNzWxuETXUC+xvFivuDI3OSdFLy+1ZBMjMNZSCpjNdjD+fP1B7xCjJAeTkihv/p+WeC
  G+pPyUyozE4oz4otKc1OJDjDIcHEoSvC5/gXKCRanpqRVpmTnAuIdJS3DwKInwOvwDSvMWFyT
  mFmemQ6ROMSpKifNqgiQEQBIZpXlwbbBUc4lRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMK8n
  yHaezLwSuOmvgBYzAS22XwK2uCQRISXVwLTBgqM+Y1pki9sJRfFJ75Yqak905lvxpFNP+rCqf
  8PqW3vXvVS8nCnzQvecl8gyk+mRO6o6f3mXr158iePI5BMnu5/r+Zc7+PQusjo+Z8ZNo1aviM
  UiyaF9Hjry3DUTd5zSOMRySiB622L7Dxs9Y1+YWvqXXZtveHMbX9vVlWa5ioZuN48eMErZvke
  v8TCv4Ys9mVJxKkl5iSxpSpqCnJ+uVBmu6469PevB+TdLS3+abOcVlw0+4LDrELej8qFaOdP0
  pn0K7HOPrlc5cnXi5yf+/nmCp+KWz9i/7nBJ6vWtz65FXK5yEr8SlO8y6byMbu5HVs3Nk84nn
  AnOvbL7+I1tq9cFSM2tUy57dXeT0XElluKMREMt5qLiRABwNFBVsAMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-16.tower-386.messagelabs.com!1602551590!1614275!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16806 invoked from network); 13 Oct 2020 01:13:12 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-16.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Oct 2020 01:13:12 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 7F0379B7ADDE8C829FCA;
        Tue, 13 Oct 2020 09:13:08 +0800 (CST)
Received: from localhost.localdomain (10.46.56.85) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 12 Oct
 2020 18:13:05 -0700
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeff LaBundy <jeff@labundy.com>
CC:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <linux-iio@vger.kernel.org>, Nitin Joshi1 <njoshi1@lenovo.com>,
        <linux-input@vger.kernel.org>, <dmitry.torokhov@gmail.com>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
 <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
 <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
 <272074b5-b28e-1b74-8574-3dc2d614269a@redhat.com>
 <20201008001424.GA3713@labundy.com>
 <9893a32c-02c8-f00c-7f00-6287d55043ab@redhat.com>
 <f4f00263-3beb-d941-eb3a-2be95684db66@metux.net>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <f296f7e3-4571-f18a-51c5-4006196d2fa3@lenovo.com>
Date:   Mon, 12 Oct 2020 21:12:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f4f00263-3beb-d941-eb3a-2be95684db66@metux.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.56.85]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2020-10-12 8:36 a.m., Enrico Weigelt, metux IT consult wrote:
> On 08.10.20 09:10, Hans de Goede wrote:
> 
> Hi folks,
> 
>> Yes and no. At least the lap-mode detection (laptop on someones
>> lap rather then sitting on a table) is currently used by the
>> embedded-controller for thermal management decisions, basically
>> when on someones lap the configurable TPD of the CPU is set lower
>> to keep the laptop's bottom skin temperate < 45 degrees Celsius
>> (I think it is 45 but the exact number does not matter).
> 
> Am I the only one who thinks the whole concept is a pretty weird
> idea ?
> 
> IIRC the machine becomes slower when it *thinks* its on my lap,
> but runs faster - and becomes hotter - when it's laying around
> somewhere, eg. ontop of some papers ?
> 
> Where can I get the drugs that these guys took ? :o
This made me smile :) But I think it's safe to so no dubious substances 
were involved and it's really not that weird. We try very hard to not 
burn our customers, many of them appreciate that. We haven't yet 
implemented a paper sensor so that feature isn't available yet.

A lot of Linux users, quite reasonably, want to be able to access the 
maximum power available from their unit and so the logical conclusion is 
you can have max power (and therefore temperatures) when it's not on 
your lap, but in the interest of making the device safe and comfortable 
when it's on your lap the power rating drops.
I think this implementation is pretty common across all vendors these 
days - we're just exposing the lapmode sensor to user space to make it 
more obvious to users *why* the power dropped. We will also use both the 
lapmode and palm sensor for WWAN.

> 
>> With upcoming WLAN cards with configurable transmit power,
>> this will also be used as what you call a SAR device.
Minor correction - we're using this for WWAN

> 
> Same fun. Once a person comes near, the signal gets weaker and
> potentially connection breaks. Great fun for debugging.

My understanding is it's the way it's done on Windows and it is a FCC 
legal requirement so we can't get away from it. We could do what I think 
most vendors do and only provide the low power mode, but we're trying to 
give full and equivalent support to Linux users, so they can have full 
power when possible, and that means these proximity sensors being 
available to user space.

I hear you on the debugging but Windows seems to have managed OK.

> 
> Back to the technical side: IMHO we should first work out what the
> actual purpose of these sensors could be - are they useful for
> anything else than just these specific cases ? If not, I'm not
> sure whether it makes sense to put them into IIO at all, but using
> a specific board driver instead.

Hopefully the above helps explain the purpose of them a bit.

 From my point of view, I'm pretty new to the kernel contribution side 
of things so want to do whatever is recommended from the kernel 
community but gets these sensor states to user space so we can give 
Linux users a better experience on Lenovo platforms.

I think we've settled on using the input system instead of iio so maybe 
this thread is moot - but I wanted to respond in case details were 
useful or interesting.

> 
> Okay, maybe we find these sensors somewhere else (maybe some embedded
> stuff), for completely different purpose - in that case having one
> standard driver (for the sensor itself) could make sense.

It's hard to comment here as I only know about Lenovo implementations, 
but I wouldn't be hugely surprised if other vendors wanted to do 
similar. For now, to my knowledge, it is just a Lenovo implementation 
and the user-space consumer is a Lenovo application.

> 
> But that leads me to bigger topic: we've got several cases of some
> sensors/chips used in different subsystems, eg. simple one-shot
> ADCs, eeprom's, etc. ... maybe we should move them to separate
> subsystems, which then can be wired to other (more specific) ones
> in a very generic way ? ... just some quick+dirty thoughs,
> 
> 
> --mtx
> 

Mark
