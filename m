Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB0192395
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 10:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCYJBL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 05:01:11 -0400
Received: from www381.your-server.de ([78.46.137.84]:36246 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYJBL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 05:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nlBGH+fM1D6LMlM546zlSnnsxke6xpD/ZmkDumaOMPk=; b=fv5o0/mvGOxcwISNrjx5XwT5PJ
        UmWV476BqsKGc+N1QJPWRm/NpmC7F2QZ+uPHGxrREBuzN04xZoxfeocbBOOEfyrY57HeCzDppM02v
        iOUOIeHvFd/wHsCnSLtos69xMsRzKt4u/mSe0V0UscF09BlfhZd8UA0RaQDzBAVqLbGaz2BSvY0jS
        W/QuxxafvZ/WUe7wlYthdBpmwukgcLnzK+C8HCo/xUH0h4BwgMC2oXmYmL7f0ild4VYhA8adXjbt9
        PHSFVJvRJnKQ9nN024hbiWaHo7CLDKMO1mQ7gcf2mgew9RuJcUHlJsgjrDRtaaHVVjJiTKValgn0b
        i3N3qpZw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jH1uL-0001ai-0h; Wed, 25 Mar 2020 10:01:05 +0100
Received: from [82.135.67.193] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jH1uK-000TO4-Ou; Wed, 25 Mar 2020 10:01:04 +0100
Subject: Re: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h includes
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200324141624.30597-1-lars@metafoo.de>
 <BN6PR03MB33471B79BA11923CE08971B199CE0@BN6PR03MB3347.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <30ae9871-509d-031e-a01e-16bc511c8b99@metafoo.de>
Date:   Wed, 25 Mar 2020 10:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BN6PR03MB33471B79BA11923CE08971B199CE0@BN6PR03MB3347.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25761/Tue Mar 24 15:55:35 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/25/20 9:26 AM, Sa, Nuno wrote:
> I also came across with this in ADI internal tree. Did you considered to also split buffer_dma.h into a public
> and an impl header? Hence, users of buffer_dma do not get access to the internals of buffer.h? That was the
> approach I suggested in our tree since the split of buffer and buffer_impl is exactly for users not to
> know about the internals...
>
> Or do you think that it's not

At the moment I think there are no users of buffer-dma.h that are not 
implementations of a buffer. At least in upstream.

There are a few drivers in the ADI tree, which include buffer-dma.h. But 
this is because they provide their own overloaded implementation for 
some of the callbacks. In a sense that makes them a buffer 
implementation. Most of them use the same simple implementation for the 
overloaded operations. It should be possible to factor this out and use 
it as a default. Then the include to buffer_dma.h can be removed.

- Lars

