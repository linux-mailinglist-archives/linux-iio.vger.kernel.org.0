Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E326187D3F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2019 16:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfHIOyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Aug 2019 10:54:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfHIOyV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Aug 2019 10:54:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so45989487pgl.11
        for <linux-iio@vger.kernel.org>; Fri, 09 Aug 2019 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J8E25So1VrDkNGc4vmC/kqNM2EwejB4wKpCffrLiqCU=;
        b=iIYBo8jW3f38W+FNuKKWe2+3VMuRhgdML2Jjcn1R/ed3aTnKxjzQYoLACmNMlXQyqb
         2saoX34ljWP4qPc0yTdMJXqYgoUiuKp70MrYUIen7p2JudRiGsYO1pzidnfUqMPQWO9j
         RSrGtRxNjX2kPC2CbEecdqtka91r6T5JYocI/cnawZHQN8xQp19y6VYRVPzDOa/pPIJ5
         Ow3LpOv+NL4teawTJVE557qq7CPrYZ7CPDMPRkKtrYW+LZs2VcKelrFIkYAuyp/Cwcpf
         7NWdZI+coI1G1wv5V0PQvFfWMm588BBNJZYS0rxWaxLTSLY+H/PDi1ql1VfGwDWei29g
         89mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J8E25So1VrDkNGc4vmC/kqNM2EwejB4wKpCffrLiqCU=;
        b=XCik9mKtEMzBIUaEz/JFZP99D9s5SCXLtGqbNCcP0fmeoa6st2vNnhtIxrRASZpNNF
         ItyrRym7ogZ3g9aqUEXG8V7HwuB30gOLnzziJcBfpLx79u4ghJhOZbaapNeNTUPVVbVk
         joqfWLAvI11c4IlXNYg0AEiTXp9snRjGxPZSt7uvJin2By5vw1oNTp05IW1ehsmDAhTa
         mny3mlsphuWk8RvIGO7oLjyDamT/Ql3/xQJ2Hxq4SbOwP0SCO02ZwPoUW8ecJ5YNwrZT
         Gk2tT6lWAdjWVd3a/d1wQSKxjCN7pkRE01mOAMSjMDpqJv4viYEZhv+byG76qyYMjFBX
         4D/Q==
X-Gm-Message-State: APjAAAUU/m86qKBvvRX8WbnLFEEh29uJ7H+MUVJiRx/rPcEC5vsmYn10
        seI2+qEGsYzEabI67Hmr7GQ=
X-Google-Smtp-Source: APXvYqzCO3zWtKAdADxSh07a5deE3hLSPaiaH06HX/sYKApnrQRwT9KZ2D+ChpWNBayUEtKGlT04cw==
X-Received: by 2002:a63:f04:: with SMTP id e4mr16740737pgl.38.1565362460610;
        Fri, 09 Aug 2019 07:54:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r15sm105143707pfh.121.2019.08.09.07.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 07:54:19 -0700 (PDT)
Date:   Fri, 9 Aug 2019 07:54:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        mtitinger@baylibre.com, Kevin Hilman <khilman@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>, narmstrong@baylibre.com
Subject: Re: ina226 as IIO device instead of HWMON
Message-ID: <20190809145418.GA1096@roeck-us.net>
References: <24e73088-94f5-c231-37a4-90f1f63f0587@xilinx.com>
 <a3760f34-02a3-a6ee-6b97-2705612aa735@roeck-us.net>
 <7405c36a-797e-d25f-1a70-19f4a0b1de04@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7405c36a-797e-d25f-1a70-19f4a0b1de04@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 09, 2019 at 03:42:00PM +0200, Michal Simek wrote:
> On 09. 08. 19 15:02, Guenter Roeck wrote:
> > Hi Michal,
> > 
> > On 8/9/19 3:37 AM, Michal Simek wrote:
> >> Hi,
> >>
> >> we are dealing with one issue with ina226 on xilinx platform when hwmon
> >> driver is used. We have board for battery monitoring with shunt resistor
> >> setup to 10 Ohm which is out of config value in hwmon driver. I have
> > 
> > Took me a while to understand that you mean 10 Ohm, not mOhm.
> 
> yes.
> 
> > Well, yes, that is a bit large. I'd be open to accept a patch fixing that,
> > though I don't immediately know how to update the devicetree property (and,
> > unless I am missing something, the iio driver has the same problem).
> 
> There is shunt-resistor property in uOhm that's why 10 Ohm is like this
> shunt-resistor = <10000000>;
> 

Yes, I know, but that applies to both hwmon and iio.  What am I missing ?
Is there some overflow condition in the hwmon driver ? If yes, that should
be easy to fix.

> > 
> >> temporary code to workaround this but I have also found that ina226 is
> >> supported via iio framework. I have seen that Baylibre was trying to add
> >> generic iio support to sigrok.
> >> http://wiki.baylibre.com/doku.php?id=acme:oldstart
> >>
> >> I expect you wanted to use sigrok also for ina226.
> >>
> >> Anyway my question is if there is any standard tool which is capable to
> >> calculate and show information from iio ina226 chip which is can be used
> >> instead of lm-sensors and hwmon driver.
> >>
> >> I would expect that iio-hwmon could be also used but didn't try that yet
> >> with ina226 chip.
> >>
> > 
> > I don't immediately see why iio-hwmon couldn't be used. Also, if you don't
> > use the ina226 as hardware monitoring device, iio would be a more
> > appropriate
> > solution anyway.
> 
> I have tried this and found that IIO_POWER is not exported via iio-hwmon
> driver.

Probably IIO_POWER didn't exist when the iio-hwmon bridge was written.
Patches welcome.

> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> /tree/drivers/hwmon/iio_hwmon.c?h=next-20190809#n104
> 
> It is easy to add because ina226 iio export power via channel 2
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/adc/ina2xx-adc.c?h=next-20190809#n690
> 
> Also dt description is easy to add. + iio-channels = <1>; to ina226 dt node.
>        iio-hwmon {
>                compatible = "iio-hwmon";
>                io-channels = <&ps_pmbus 1>, <&ps_pmbus 2>, <&ps_pmbus 3>;
>        };
> 
> > 
> > FWIW, we should actually remove the in22xx hwmon driver at some point and
> > ask users to use the iio driver combined with the iio-hwmon bridge instead
> > (after making sure that the iio driver combined with the iio-hwmon bridge
> > provides the same functionality).
> 
> The functionality is likely the same but I would expect that with this
> new driver we should get something more. Especially that sigrok
> connection looks interesting.

Sorry, which new driver, and what is "something more" ?

Thanks,
Guenter

> In our system we have SoC which have a lot of ina226 which monitors the
> second SoC and would be nice to get precise information or graphs out of
> it via standard user space tools or directly to web page.
> 
> Thanks,
> Michal
> 
