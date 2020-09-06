Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED29B25EEF1
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgIFP6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 11:58:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:37266 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgIFP6B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Sep 2020 11:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=QMzIMO+2YyWK71SXQ4n+GW48SMa/9Fleu/rxE0Wd1xA=; b=WfKdMc6vRYLULqFUC/WH0B4OzQ
        x9qsuSTffgMIV+4NNUW988jklj0xyZ/kr6E7DilFjfE8+GCUDsb/gExOaend+K8sANQLuDDu1rLUF
        +zMl3lSXy9l7EWFPxqiAIpRu7USnoZSrvo17i73MudDAn00azTQ3OY19zTc2opZXNJkv0xGI5uwh1
        pdQj2Vq0GqNZOV19gkHv9dcyEs1IWT+Ym/p6MtPbvUK/Sz8yOys/u5+hOOff81VdjKg4/XZQhHShP
        pcXGrpBUeUMlMbjm25EEfM79Sgbx4Q8OZQJlCQcTvIQ+rxboeNv3f/5C2VGIalUGgjdkCrIElWEU5
        LFbWvLgQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kEx3C-00011t-TM; Sun, 06 Sep 2020 17:57:55 +0200
Received: from [62.216.206.78] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kEx3C-0009Lh-Oa; Sun, 06 Sep 2020 17:57:54 +0200
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Consolidate Analog Devices IIO
 entries and remove Beniamin Bia
To:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20200903181926.5606-1-krzk@kernel.org>
 <20200906150640.5ffe7e0f@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8f7de1d6-0756-8b59-7041-c5ae4773e5f2@metafoo.de>
Date:   Sun, 6 Sep 2020 17:57:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200906150640.5ffe7e0f@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25922/Sun Sep  6 15:39:20 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/6/20 4:06 PM, Jonathan Cameron wrote:
> On Thu,  3 Sep 2020 20:19:25 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>> Emails to Beniamin Bia bounce with no such address so remove him from
>> maintainers.  After this removal, many entries for Analog Devices Inc
>> IIO drivers look exactly the same so consolidate them.
>>
>> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: linux-iio <linux-iio@vger.kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> As I'd assume a more specific binding always overrides a catch all,
> this has the effect of giving Lars and Michael responsibility
> for a few things they didn't previously cover.  If the two
> of them are fine with it, than that's good, but I'd ideally
> like an Ack from Lars.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

I think I left a ticket with ADI when I left to update the maintainers 
entries and replace me with somebody else, must have gotten lost :)

