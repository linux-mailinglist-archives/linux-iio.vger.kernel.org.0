Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40991958A5
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgC0OIy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 10:08:54 -0400
Received: from www381.your-server.de ([78.46.137.84]:34958 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0OIy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 10:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jP6ZOO6om6xc6qhwrRKcT0GKENl5I0NI6Co1aic9c8c=; b=Ktrg15VSQ4QWSZEgWQd6GvzCyJ
        w4tKpe7jk2FeFGSxyDJHnwPIqF8JAt9Tg4cTqH9+aKZcLqQBh0p9pGSsnrePwFLBv319AseD9U3jj
        VKu2ybvONl8ms4PQFPKxmqs0gknUZo/k1yN9oNTN9HY6fqGLZKIZ9TFJiwgjIUKGv6VQQ6fxTJSFo
        dUN/BxLFCvnMnJWJpVXXUwDP7djiNMtBdkfi8Ycunskmk2saM12UxdV1WuGAhyNWCyxTpTWT0ti6b
        K2Nng9AbE/79wV/YCUubtD7K5EXAOz32yXLRClI28CKgUfqlNc/77Nk9K0IfjGyNXD8/SjoNEPsCF
        yPbzKxDQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jHpfH-0004OB-Ke; Fri, 27 Mar 2020 15:08:51 +0100
Received: from [82.135.64.145] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jHpfH-000VXX-BY; Fri, 27 Mar 2020 15:08:51 +0100
Subject: Re: [PATCH v5 0/2] Maxim MAX1241 driver
To:     Alexandru Lazar <alazar@startmail.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
References: <20200322140237.211347-1-alazar@startmail.com>
 <20200327134000.GA3579@leena.republic>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6ec489c8-d5e6-96fb-5802-1ba22b0c5626@metafoo.de>
Date:   Fri, 27 Mar 2020 15:08:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327134000.GA3579@leena.republic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25764/Fri Mar 27 14:11:26 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/27/20 2:40 PM, Alexandru Lazar wrote:
> On Sun, Mar 22, 2020 at 04:02:35PM +0200, Alexandru Lazar wrote:
>> Hello again,
>>
>> Here's version 5 of a patch series which adds support for the Maxim
>> MAX1241, a 12-bit, single-channel, SPI-connected ADC.
> *poke*
>
> No rush here, just wanna make sure this doesn't go off-radar.
>
No reply is good news! Means nobody has anything to complain :)

Johnathan usually picks up patches during the weekend (For which I think 
we can not thank him enough!).

- Lars


