Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE2297C1
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbfEXMCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 08:02:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33348 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391235AbfEXMCj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 May 2019 08:02:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so14085349edb.0
        for <linux-iio@vger.kernel.org>; Fri, 24 May 2019 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EKk/cIwaLyICV+zUNt5nE7tK5hxV2T/gKNg2bYYa8aU=;
        b=kmZphTPLFDEK6kXZCM3P0Gzre9Zxs0Zc1VUb0swQdOVOQkghpXjjHuYcS/Qa1lsbHN
         2n+pakxrHnLGZ6KWp7OEDq09goDKrGqePvDSJEve8WOijva+bg4Rh06NqgHaz+GABrfw
         bwz0V0+FVewN2wiFMrGqHz7tMD7Z5aZPAiSWShLR//h8S72PPpPAZjSqQbstg7zvyNTY
         Q34V0mqtu3ROc/SErqdoHd8uaFOfk9/eYaTo4uUpNbZ69KDppSfCgzwHuztGsSLg0VxP
         r9eXxo0/CrHQeiLbeQgWsgc5CgFzDlLZByXOhDSKbQ7UVBF1SrHFUWJrRpATVsqLiArE
         1a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EKk/cIwaLyICV+zUNt5nE7tK5hxV2T/gKNg2bYYa8aU=;
        b=fJvmk4plKvkc02TVLEK8MhTn2Ds5oVjm4klqMrhJQ8cZ4aoGDVXkvCmSduY3i7GIJA
         0hR66cgqeNjJw7WXV2ZoYGThIfN6/4D9a3DaDsuTxLjTwiBtMb2n1wm+8leW23XxWjg0
         BgQc0fHPAU3AVL5uF8D07qf+zmhbHx4PH+BJoJT5Xbbw1RJAagiTL2CgHsGVpKaRgd0i
         fOTCFeL/uQKPpYbg1Yqt6UCWP62N61whh716TBeA/v2veTib3yG9i4q2mXN0el/+6cea
         LCU9xu9JrP4K4ajWPqO34TNzLKcjKF5txL6l69wSFRQJr7GEc966driJb8x8OU3K2jlb
         QdBQ==
X-Gm-Message-State: APjAAAUzW7Mlmaw1hjfoUaCi/JV25effzks9Z+Rb4ANvDgwIZ4bUawWj
        yV8jnW2DWWdvVl81Ihfj5cyhbw==
X-Google-Smtp-Source: APXvYqzNrNQ34o178qgF58YqCzsN717OWDCY6SXgnER717yhuxeF496z/3libVrM2TkpvMl2rOd6Rg==
X-Received: by 2002:aa7:c512:: with SMTP id o18mr104340990edq.82.1558699357520;
        Fri, 24 May 2019 05:02:37 -0700 (PDT)
Received: from [10.1.0.123] (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id t3sm686925edd.49.2019.05.24.05.02.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 05:02:36 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] iio: ad7949: Support configuration read-back
To:     Adam Michaelis <adam.michaelis@collins.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de,
        michael.hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Brandon Maier <brandon.maier@rockwellcollins.com>,
        Clayton Shotwell <clayton.shotwell@rockwellcollins.com>
References: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
 <1556813672-49861-3-git-send-email-adam.michaelis@rockwellcollins.com>
 <20190505154227.1735b1b2@archlinux>
 <CALMrGWV6rtYQShtm7uBQygtdOpPW30mLnKMxb2Jk8pY68B6yyw@mail.gmail.com>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <154f2b5c-91e1-41dc-e7c5-a5ec35ca1c05@essensium.com>
Date:   Fri, 24 May 2019 14:02:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALMrGWV6rtYQShtm7uBQygtdOpPW30mLnKMxb2Jk8pY68B6yyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le 07/05/2019 à 21:53, Adam Michaelis a écrit :
> On Sun, May 5, 2019 at 9:42 AM Jonathan Cameron <jic23@kernel.org> wrote:
>> On Thu,  2 May 2019 11:14:29 -0500
>> Adam Michaelis <adam.michaelis@rockwellcollins.com> wrote:
>>
>>> Adds device tree parameter to set the configuration read-back bit
>>> in the configuration register to tell the AD7949 to include the value of
>>> the configuration register at the time the current sample was acquired
>>> when reading from the part.
>>>
>>> Further work must be done to make read-back information available to
>>> consumer.
>> This needs some explanation of why it is useful at all. I'm certainly unclear
>> on why it would be useful to configure this at boot time.
>>
>> Code looks fine.
>>
>> Jonathan
>>
> The configuration read-back feature is being maintained from the
> original version of this driver. Before adding the device tree entry,
> there was no way to change this setting other than debugfs raw access
> to the SPI interface, and there is still no access to the returned
> configuration data should the feature be enabled. I would be willing
> to remove the feature altogether, but wanted to tread softly on
> existing features.

Hi,

I added this feature for debug purpose but it is not used in our case 
anymore because the driver and the device are working as expected.

But maybe we can use it the check if the config is correctly applied? I 
don't know, it is probably useless to keep this feature here.

Regards,

Charles-Antoine Couret

