Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8F19EB3C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgDEM3E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:29:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:39996 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgDEM3E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 08:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oW/KwpVn77Fhr946tMcL15ed+ppPHohK3c9Ma5zDfWc=; b=GVR6t6IWKvpYeUgP/xxlrLEjt2
        Vsxmhopng5hMeKRdrUfQBebMcseWFRAW9Yu0xrbqsY7EE8wAIOXap6496q3KeCHTLdAF1BaxRM/Rc
        9hogPCPXGUmrJ3uOLsHCW01Pp1IOOK7VrNUmYpbVpDY5Rz+lsatk9qeHhefNp++SslnIfR4oz/ZHd
        A3dfEmu3pjQzVhzEOrWjvWB6FmfSVA4VmM2EGlRTVu0ZxXYvFR+KdB/rZqNLN04nSJjp4lOF84aji
        r/K7K4Nzt5Ko1jxQC34cfvKM81iNgLzLLulCrf/uIYU+0OIjhDZzGQiDQwqHSLL/9cy03CeLpS3ED
        x/DfbW2Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jL4Oc-0005fP-LO; Sun, 05 Apr 2020 14:29:02 +0200
Received: from [82.135.79.250] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jL4Oc-000BDm-EB; Sun, 05 Apr 2020 14:29:02 +0200
Subject: Re: [PATCH 1/5] iio: xilinx-xadc: Fix ADC-B powerdown
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20200403132717.24682-1-lars@metafoo.de>
 <20200405131039.37ae5165@archlinux>
 <55c93588-2242-2ccb-2d8e-50cc66de28f5@metafoo.de>
 <20200405132602.65a7a480@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <195740ae-392f-5d6b-6042-f09e315847dd@metafoo.de>
Date:   Sun, 5 Apr 2020 14:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405132602.65a7a480@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25772/Sat Apr  4 14:56:57 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/5/20 2:26 PM, Jonathan Cameron wrote:
> On Sun, 5 Apr 2020 14:13:32 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> On 4/5/20 2:10 PM, Jonathan Cameron wrote:
>>> On Fri,  3 Apr 2020 15:27:13 +0200
>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>   
>>>> The check for shutting down the second ADC is inverted. This causes it to
>>>> be powered down when it should be enabled. As a result channels that are
>>>> supposed to be handled by the second ADC return invalid conversion results.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Fixes tag?  Definitely sounds like something we should be backporting!
>> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
> For all of them? (just checking)
Yes, took 6 years for somebody to notice :)
