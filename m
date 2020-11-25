Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F8C2C3F46
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 12:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgKYLr7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 06:47:59 -0500
Received: from www381.your-server.de ([78.46.137.84]:51156 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgKYLr7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 06:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fQ8oH3igow59Isznkzi+zu+eOoBqSzH/uw2cJZLeRmg=; b=JeY+ElxBNGhjzmA/oA1ePzhkRg
        /BUDzw83dJWrfRH8+NYccvqzS6H6LJwkJzIfpIdWhH7sleoXM/HShM2onUIxRcj0sdHJs45ISLq3X
        O+vtilvBoBSyx9sFATPW3YexL5xhNQg3iswHF2C01BgdH7WrUuvyu+VwwKLb9k+eSeka9BQoVF25E
        KZ8G3jZ+9wSnurW6D1Rskfrj0rWctFK6mNi+E67Kpo4Efw5sI13pBl2+FSYxNJzl1gaZgtTL7hx0+
        VAhoKpY6fAfZGzGi4ClzuymFqXsr9lKe+8ZMAyawjhtWPFMF3p4rGA36WuhbJ5vSnXbfsgy24Qo7K
        gAiz6rzA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1khtH8-0007vl-MV; Wed, 25 Nov 2020 12:47:54 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1khtH8-000XQ1-IJ; Wed, 25 Nov 2020 12:47:54 +0100
Subject: Re: fake ACPI IDs in the drivers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>
References: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <857bbb6c-1025-df6d-871d-f0fbcafb6ad8@metafoo.de>
Date:   Wed, 25 Nov 2020 12:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25998/Tue Nov 24 14:16:50 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/25/20 12:14 PM, Andy Shevchenko wrote:
> Hi!
>
> Recent discussion [1] [2] around faking ACPI ID in RTC subsystem and a
> sudden check [3] (due to last Hans' patches related to ACPI based
> systems) of IIO makes me wonder if we may start cleaning drivers from
> faked ACPI IDs and establish a stricter rules for the ID table
> entries.
>
> Thoughts?

The cat is probably out of the bag.

If there are systems shipping with those unregistered ACPI IDs we still 
have to support them.

I'd assume that most drivers that have a acpi_device_id table do have 
hardware that uses that ID and were not just cargo culted.

For new drivers we should push back on unregistered IDs, but if there is 
hardware that uses them we have to take the patches.

- Lars


