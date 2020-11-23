Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98032C1979
	for <lists+linux-iio@lfdr.de>; Tue, 24 Nov 2020 00:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKWXd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Nov 2020 18:33:57 -0500
Received: from anchovy2.45ru.net.au ([203.30.46.146]:56322 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgKWXd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Nov 2020 18:33:56 -0500
Received: (qmail 15171 invoked by uid 5089); 23 Nov 2020 23:33:54 -0000
Received: by simscan 1.2.0 ppid: 15053, pid: 15054, t: 0.0725s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.22?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 23 Nov 2020 23:33:53 -0000
Subject: Re: [PATCH 02/46] dt-bindings:iio:potentiometer:adi,ad5272 yaml
 conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-3-jic23@kernel.org> <20201103161039.GA1754553@bogus>
 <20201103172834.00007040@Huawei.com>
 <bc4219af-d77b-0f39-025d-d8905f35b574@electromag.com.au>
 <CAL_JsqLAtMQhsUDG=amAG7i9mMzYq9UTDLMFRrGKOHr5rb3L+A@mail.gmail.com>
 <a6685d81-d09a-1372-cc17-96f66c87ffbe@electromag.com.au>
 <66e8db5d-cc37-dde9-7d55-770d54506e3d@electromag.com.au>
 <20201122163500.4c699fcc@archlinux>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <7c002207-918b-e300-6113-fcf392ce7a8d@electromag.com.au>
Date:   Tue, 24 Nov 2020 07:33:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201122163500.4c699fcc@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/11/2020 00:35, Jonathan Cameron wrote:
>>> Having a software interface to assert the reset would be nice.
>>>
>>>    
>> If there's no comments against the change, I'll submit a patch in the next day or so.
> Hi Phil,
> 
> So I've fixed the binding example up to have the sense as ACTIVE_LOW as discussed.
> If you have time to flip the sense round in the driver to match that it
> would be great and I'd propose we then mark that as suitable for stable
> so that we get it backported into existing trees.  We could also spin
> a patch to the txt binding but perhaps that is more effort than is needed
> here.  If I get time before you do I might send a proposed fix patch.
> 
> Hopefully anyone then using it will get the sense right and we won't
> accidentally break anyone.
> 
> At some point soon I'll also try and audit similar cases and hopefully we
> will get those fixed up as well.  Obviously if anyone else wants to take
> a look at that it would be much appreciated!
> 

G'day Jonathan,

Sorry this had slipped a bit on my list.
I'll send a patch in next day or so.



-- 
Regards
Phil Reid

