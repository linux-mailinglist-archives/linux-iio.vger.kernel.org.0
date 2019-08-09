Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4087AC6
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2019 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406639AbfHINCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Aug 2019 09:02:39 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:33543 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406273AbfHINCj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Aug 2019 09:02:39 -0400
Received: by mail-pg1-f177.google.com with SMTP id n190so5031767pgn.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Aug 2019 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wZCG1Q1rqFe7DmJFxERe9KW8uZHqlnc2rnIrBcGxihY=;
        b=jUUFk0/S6TBeuhue7ttb+1VdXyDFEa8pCYgQU+WC/OTnS5mYJZWhRPgLz1rWE98Joy
         OsvPBucTJfMsmivd6XDpqJbiSNXoJCUVDnYubanNWOysO79i/hvDgnfHifwN91deSnIA
         USeUTHdxKj4SnQ57d3kwtSv80OaxCxCoVfb/MkCKaHeD+yiiEk1W8yFoc04BDWUNK9dA
         IYPxLQ+7iUrrIJ8Q1+AVJT46wdBnKdWZHGqNMoPxVxgBJH60BO9yhXGBgMluNcpANGTC
         PDWkueEo/Ooru51ddHppnnEUuhcEjw5OWpBmHGn3vw+4Pwpdw+5nS0ixuex7ExID/jgs
         p1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wZCG1Q1rqFe7DmJFxERe9KW8uZHqlnc2rnIrBcGxihY=;
        b=Q7Arx8EpNuf9FRmBNQ/ham6YO3yhtEwP+x/4S+oX5ZLKrQbpIchZIksqAmGSxvYQys
         l62xH585kgJALzdYYqPrDIOru8QTl3J61SAoT4aqg5+r6o+v1BA4GSJI5zICrXmGqXYF
         5h+3I+qNZ1uL4LCjuaFoomff1Wh/osBMGbzIn9Guv63kRRBmkbzeJ0w1kIzZosVzTLs4
         bA9yuL0vujMwTw+itvdlF1GKTfFUsfI9uQMrmpRpaEkeX7NI4niYq950zz3BYyZponSr
         1/3rxqiXmvpFeiHD8q7EJnkN07ZtavaR6NXCiauAeyKRTul0d7mR0caZwOLhjkab3IKB
         /QsA==
X-Gm-Message-State: APjAAAUSPWbwn1ZWBUbHBQe7tumz6ibS2Z2jwB/WpdfppbG8BXDXkJBS
        95alwhmdm/s5Icaa0yfEJYQcVaWw
X-Google-Smtp-Source: APXvYqy+EiUc3YU1IVVAHRSyu25ffJOWyMbIG00WboTo/TVHMP/Bl78hokhWCyQDJgLOQXxWYkdt4g==
X-Received: by 2002:a65:60d3:: with SMTP id r19mr17553097pgv.91.1565355758274;
        Fri, 09 Aug 2019 06:02:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p20sm137733925pgj.47.2019.08.09.06.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 06:02:37 -0700 (PDT)
Subject: Re: ina226 as IIO device instead of HWMON
To:     Michal Simek <michal.simek@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        mtitinger@baylibre.com, Kevin Hilman <khilman@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>, narmstrong@baylibre.com
References: <24e73088-94f5-c231-37a4-90f1f63f0587@xilinx.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a3760f34-02a3-a6ee-6b97-2705612aa735@roeck-us.net>
Date:   Fri, 9 Aug 2019 06:02:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <24e73088-94f5-c231-37a4-90f1f63f0587@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Michal,

On 8/9/19 3:37 AM, Michal Simek wrote:
> Hi,
> 
> we are dealing with one issue with ina226 on xilinx platform when hwmon
> driver is used. We have board for battery monitoring with shunt resistor
> setup to 10 Ohm which is out of config value in hwmon driver. I have

Took me a while to understand that you mean 10 Ohm, not mOhm.
Well, yes, that is a bit large. I'd be open to accept a patch fixing that,
though I don't immediately know how to update the devicetree property (and,
unless I am missing something, the iio driver has the same problem).

> temporary code to workaround this but I have also found that ina226 is
> supported via iio framework. I have seen that Baylibre was trying to add
> generic iio support to sigrok.
> http://wiki.baylibre.com/doku.php?id=acme:oldstart
> 
> I expect you wanted to use sigrok also for ina226.
> 
> Anyway my question is if there is any standard tool which is capable to
> calculate and show information from iio ina226 chip which is can be used
> instead of lm-sensors and hwmon driver.
> 
> I would expect that iio-hwmon could be also used but didn't try that yet
> with ina226 chip.
> 

I don't immediately see why iio-hwmon couldn't be used. Also, if you don't
use the ina226 as hardware monitoring device, iio would be a more appropriate
solution anyway.

FWIW, we should actually remove the in22xx hwmon driver at some point and
ask users to use the iio driver combined with the iio-hwmon bridge instead
(after making sure that the iio driver combined with the iio-hwmon bridge
provides the same functionality).

Guenter
