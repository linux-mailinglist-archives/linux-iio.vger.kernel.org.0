Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04A432ED3
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhJSHFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:05:16 -0400
Received: from www381.your-server.de ([78.46.137.84]:60602 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSHFQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 03:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=DUxZ43GFXlbbZoy7ccpVOYBfGN+ZNW6frDtcjc3QdyA=; b=G/94pETfu9F7Bl7wIy31EkIA8l
        bbsBcohwZtcoEjpneuCuJDFOBlEWHMKKAPk6ZfOgpsA9DazpOJYKC6pfLctQ4dg2bgsk/1GKDMzDH
        muHD7nGW21WsUT0etkhr4haNdgFsRnbC/5gW9+uYuVejrJF1k8B9/enIfcI/v3WcoFaX/cno7LXmt
        B+q/lD5PuQKh6XwK+hRbHHTZQkAdhBBTvWDWPW7erZMSpECE1JTHDHJ8+5IKt8Pi+gveSarqQplrY
        cP3lnKQChsqTJO6SBwmkm3p07DqIhwjA1NFv5ScurBhU0J8E0TXnSIfpmvO2F70vwzhMWm4x1YAIJ
        cNvyV+eg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mcj9J-0004Ee-1V; Tue, 19 Oct 2021 09:03:01 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mcj9I-000QAj-OO; Tue, 19 Oct 2021 09:03:00 +0200
Subject: Re: [PATCH v2 0/3] Add settle time support to iio-mux
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, peda@axentia.se,
        jic23@kernel.org, devicetree@vger.kernel.org
Cc:     kernel@axis.com, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <16fab3ba-5dd9-50b3-aeae-acd68b22dfae@metafoo.de>
Message-ID: <c944fba5-9f69-e043-d4f6-3d30f1393190@metafoo.de>
Date:   Tue, 19 Oct 2021 09:03:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <16fab3ba-5dd9-50b3-aeae-acd68b22dfae@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26326/Mon Oct 18 10:19:08 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/8/21 9:19 PM, Lars-Peter Clausen wrote:
> On 10/7/21 3:46 PM, Vincent Whitchurch wrote:
>> On one of our boards we use gpio-mux with iio-mux to read voltages 
>> using an ADC
>> from a few different channels, and on this board the input voltage 
>> needs some
>> time to stabilize after a switch of the mux.
>>
>> This series add devicetree and driver support for this kind of 
>> hardware which
>> requries a settle time after muxing.
>
> I have a board with the very same problem. And a similar solution, but 
> you beat me with upstreaming. I've switched to your patchset.
>
> Whole series
>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Oh, I just realized I messed up. I meant to write

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Lars-Peter Clausen <lars@metafoo.de>

