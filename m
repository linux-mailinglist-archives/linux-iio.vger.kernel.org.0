Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2734B1C2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 08:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbfFSGCG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 02:02:06 -0400
Received: from first.geanix.com ([116.203.34.67]:47826 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfFSGCF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Jun 2019 02:02:05 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 47344345;
        Wed, 19 Jun 2019 06:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560924121; bh=tZfHrb7lg5btdkLaItRPZUcABewljDofEieSoIPtoEM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Jw7eld+Usg1HkmVaDvekazQ6xK4wHvXEcIBjbDDCUtVBQyRGZkVsIjivU7sp3ORe3
         SXFzuNrGNyK54HZVbzyu5UkuNFXCrPk3/qoZTil1FloC3hjhqGDaodkluydV21QbfN
         Ex3W/MYBVBHrXnWUcbGnjzZ+xmFYyyZh5COi4po4EI5zCzc/VFpRNqFLP89DzZRtK+
         /dRb8xI8cNk8VAsAp3D/t0BZOhmvjvQD3+WjuDJrY1VDdixMiH0GOQ4txbM3NecZAa
         rry8nrMpBDWVGaEoPHtAMeUScC7JIUccPvqPV3tSfH2qu5MerS+xM5tVwN53gFBuu5
         agGhA+2EXYSsA==
Subject: Re: [PATCH 1/5] iio: imu: st_lsm6dsx: move interrupt thread to core
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-2-sean@geanix.com>
 <20190618155705.GA22268@localhost.localdomain>
 <EE6D853C-BA54-45B5-9912-A1C89F78CC32@geanix.com>
 <20190619055853.GA4035@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <05621525-1f9d-8576-f7f7-5d6cda17a704@geanix.com>
Date:   Wed, 19 Jun 2019 08:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190619055853.GA4035@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 19/06/2019 07.58, Lorenzo Bianconi wrote:
>>
>>> I can't see why we need this patch
>>>
>>> Regards,
>>> Lorenzo
>>
>> The interrupt handling isn’t only for fifo reading, so I think it’s correct to move it out of the buffer handling file.
> 
> Uhm, re-thinking about it I agree, it will be useful even for upcoming I3C
> support. Btw I think you are using a prehistoric version of the driver ;)
> 
> Regards,
> Lorenzo
> 

Yes I'm on 4.19... will rebase to iio "testing" for V2

/Sean
