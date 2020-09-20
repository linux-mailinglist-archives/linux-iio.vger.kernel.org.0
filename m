Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80A27152B
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 17:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgITPCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 11:02:39 -0400
Received: from www381.your-server.de ([78.46.137.84]:49226 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITPCj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2020 11:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=foneasnavtMT52V3FviDIu+tgjfSglY1rxKb/kPfH+s=; b=N4km3ir99X6FYjL8u5/mOrY0rq
        ReRh53fN+8XfpevYX86VhcvlsG6A/qOFcicUxrxJO7kLaRWm/PxWXsx4pvbO7ChRdwjW1vQ30MfH8
        RZGJd9OKqbZtIUWAFX3bM3Iy3HNYnUUxsmpNa0Ec+i3q99ec87MThNooVJuGjnSp5SpjimhQkSXIj
        OWF69F6GVenhG05UBhUCd77lmw19BMP6389w+HaWdBwP2ewyS2tx9ZaO6uzAkvBmQU1LHvNYsh4rv
        0Lk6AFHdAqBBrG9mxhKlfipI6371Z5xumDjT9WKJrz4bFAiGaVa4i2QKJx8h1FLGgQdHBkwFqTuX+
        +4C/qUAg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kK0rI-0002LM-Lx; Sun, 20 Sep 2020 17:02:32 +0200
Received: from [2001:a61:259b:1201:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kK0rI-0001Z5-Hy; Sun, 20 Sep 2020 17:02:32 +0200
Subject: Re: [PATCH 0/2] iio:trigger: Remove re-poll logic.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200920132548.196452-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <78141dee-33a2-c28d-2e80-38918c03f81d@metafoo.de>
Date:   Sun, 20 Sep 2020 17:02:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200920132548.196452-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25933/Sun Sep 20 15:50:34 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/20/20 3:25 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This code isn't used by any current mainline drivers (except
> via error handling routes that shouldn't exist).  The original
> user is long gone.  It is causing issues, so let's drop it.
>
> The main bulk of this mini-series is renaming the function to account
> for the change in what it does.
>
> Lars, what impact does doing this have on your patches to mark hrtimer
> and irq_work as expiring in hardirq context? I got a bit lost in the
> discussion of that series, beyond figuring out his corner needed cleaning up.

I think no impact. This is an issue that is orthogonal. I think the 
patches should still be applied as they are.

For this series:

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

