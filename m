Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647282E7259
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 17:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgL2Qea (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 11:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL2Qe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2020 11:34:29 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76072C0613D6;
        Tue, 29 Dec 2020 08:33:49 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id f132so15068993oib.12;
        Tue, 29 Dec 2020 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dscYNDz8H/r8pIiUukzh0ABo+FcJuHuvos/8/TCP3Sc=;
        b=QMlbU2aUTUfhNZ65eZndkU8l3thzUX4o72p8eUitmdfVp5hj0G0rHMNMo4y/lgy3aV
         zZkxXfJUAbEXS87pPIC+BFHOOhKPqosjPGw4YPlWTwXiMzjdMCDg1Mq/0ewuu/WSpkC4
         UxISDSahLu6BLqZ/il6Dg4fRUkHHZ7g6OxraqPF7HuYu6l9pCpL3/WjVn8wC2j40CqPc
         4qvThHFMkhGRApNZ6a8ats/s4/sbntq4D/syx8jMknDfBIaV3LLHpmngmxPp1AFXKwP9
         yEDdEaXv3kM5Hc7Lzv+xj0gODnjLnwx6Gj8MiywwTUycHiDa6t5+1kptONBvk0AoqgKm
         JUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dscYNDz8H/r8pIiUukzh0ABo+FcJuHuvos/8/TCP3Sc=;
        b=A8NrOFwDIN0vxNGRKnIIyaLFWAtn5D31pGcEL5Bk0JFm8cbYAOu8oKxE8903Jf/mRP
         OoNaWOes8lKxwKuHsJG/8FrJKzHJdj5fFDgNCGB7fAY+Ib/v0nmID9sF6VkYWVoTJ52y
         NqUwFResN7ezsg3Pyafe90DUWPAcpWMPFJvk4BFzLyXPG64beRWPiG2Ky1shOK+OiA4O
         xT3vtW8YgHiymmyGoeMYin3azmXzfrY0Ny0yTjNUibawKPSNVEcmhRKXpFwqImXaRk2+
         CI7OYEUM/teCrSaH23QFrIesmnP8yuQgciI3M8AlGE1/zg1uIXg2eFLjnek/hMhnvPx5
         Lstg==
X-Gm-Message-State: AOAM531xLLEmUaUE7Puq7W1g9SCUY7L55jYE+QYAZI4VT1hGRSZXX7mN
        UEDxVLxXXLhBvPetOiXH0UU=
X-Google-Smtp-Source: ABdhPJzSSd+pcwOuzk1CpmLhFMfDiFalQ+EfQtmRttI8Q68D6S/gNxszNKAv4Ja0iWIHTxJDCquLNA==
X-Received: by 2002:a05:6808:a90:: with SMTP id q16mr2839286oij.107.1609259628782;
        Tue, 29 Dec 2020 08:33:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o64sm8765216oif.43.2020.12.29.08.33.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Dec 2020 08:33:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Dec 2020 08:33:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Chris Lesiak <chris.lesiak@licor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
Message-ID: <20201229163346.GA57378@roeck-us.net>
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
 <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com>
 <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdbxzuYrFeU2H2LGaWb3kKqfZ4-SpWu5FiXdFVyz82-zWw@mail.gmail.com>
 <SN6PR08MB55654976327EF62990D4DD919ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdYVruMggRHtOLWZ01N5yYx8GqAK3OtKC13Z=669eznurA@mail.gmail.com>
 <SN6PR08MB5565A63054BD03141EC56DC29ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <20201229142531.3a4ceedc@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229142531.3a4ceedc@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 29, 2020 at 02:25:31PM +0000, Jonathan Cameron wrote:
> On Sun, 27 Dec 2020 22:08:24 +0000
> Chris Lesiak <chris.lesiak@licor.com> wrote:
> 
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> > > Aha you mean that iio_read_channel_processed() loses
> > > precision when converting raw to scaled?  
> > 
> > Yes.  For example, take a 16-bit ADC with 4.096 V reference.
> > The native resolution is 62.5 microVolts.
> > Yet iio_read_channel_processed() can only give integer milliVolts.
> > iio_read_channel_raw() followed by iio_convert_raw_to_processed()
> > with a scale of 1000 will preserve more of the native resolution.
> > User space can do this by using floating point numbers when
> > converting to processed.
> > 
> > You are likely to lose precision for all ADCs greater than about 12-bit.
> > 
> > Chris Lesiak <chris.leisak@licor.com> wrote:
> > >> I'd prefer a solution similar to the existing implementation of
> > >> iio_read_channel_processed.  
> > 
> > > That seems like the wrong way to work around a problem in
> > > the core.  
> > 
> > > If iio_read_channel_processed() loses precision we should
> > > fix iio_read_channel_processed() and not try to work around
> > > the problem in the consumers.  
> > 
> > > It's fine to fix all the consumers in the kernel.  
> > 
> > > What about changing the signature of:  
> > 
> > > int iio_read_channel_processed(struct iio_channel *chan, int *val)  
> > 
> > > to:  
> > 
> > > int iio_read_channel_processed(struct iio_channel *chan, int *val,
> > > unsigned int scale)  
> > 
> > > And just augment all calls to pass 1 except the ntc driver
> > > which then passes 1000 in the last argument?  
> > 
> > > If Jonathan agrees I can fix a patch to alter all the ~50
> > > call sites like this and include the change to this NTC
> > > driver.  
> > 
> > That would meet my needs and does address what I think is a
> > shortcoming in the existing iio_read_channel_processed interface.
> I'm fine with this proposal as well.  Makes a lot of sense given
> there is no particular reason why another subsystem should want to
> convert to IIO base units (here milivolts).
> 
> The only other way I could think of doing it would be to
> have iio_read_channel_processed 'return' a pair of integers and
> type etc IIO_VAL_INT_PLUS_MICRO much like read_raw etc does inside
> the actual drivers.
> 
> It would be a bit clunky to implement however and potentially require
> some messy maths in the consumers.
> 
> May want to think about whether we need additional sanity checks for
> overflow etc.   Seems unlikely we'd hit hit them for voltage, but
> we might for some other types of sensor where the base unit is much
> smaller (wrt to real world values).
> 

All this makes me wonder if it would be better to add a separate
API function (iio_read_channel_processed_scale ?) instead of replacing
the existing one. Changing 50+ callers at the same time sounds messy.

Guenter
