Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D622CFBCB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 16:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLEPjL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 10:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727381AbgLEP3Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2020 10:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607182022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwP5DSbtF9fgDrZhUKfti9Bm5YPZjJW+lsqFYHl18PI=;
        b=PfM+B+SVoDeE1zjxEpeXA9fp2Oa9PrwzjEW2IyYl+i2IybN+t3OrN+yxyMzNJtVvpcZs+8
        +LPMoEkqDJQgrrzW+zNTbZlG1n4VhmrczJTLBUlF5gJ6qa3BxrgBBHzGBr2Qez5xFjb81d
        saIKocFxC4KigMMzg4Lby7EevQT4IGE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-EeelZW3YNxWWOzETlQXpiA-1; Sat, 05 Dec 2020 10:27:01 -0500
X-MC-Unique: EeelZW3YNxWWOzETlQXpiA-1
Received: by mail-ed1-f72.google.com with SMTP id cm4so78643edb.0
        for <linux-iio@vger.kernel.org>; Sat, 05 Dec 2020 07:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwP5DSbtF9fgDrZhUKfti9Bm5YPZjJW+lsqFYHl18PI=;
        b=aPNsu8enbvAN9pq1OBUFNtpFtQXjOnliw08/H/s8WqaNFT8RQMrN79S5zM+PNx7tec
         bidEJkgDCyh7zFcoWt1yYtxd7UOZsqdSQxC7ShZXxhX2aDRexYtahV2h4jJNz3rzwGkt
         PxeE4B4pT8ZD1Ukapm5GKXbu6ZXAWsOPkHqhnworbflRu/fafUHIG4KwVR03ndmLuVtU
         YtAUnY9rXZPo88XVUD+ogFarSmMIrxAcWbzVueuMI9pt42GJEa3wYhtXQJFYi0gWo0nG
         P39OiQux7nBrIdB2gtXzWgfxx25SMqzDlAo+j96N6ugIeGO9fWDTUVerMHl/sTEzfd4o
         /wzg==
X-Gm-Message-State: AOAM53267A5LHAS1HctM3jHLuTsfpuFQX0/BVtZru8eHICA58eeyFUac
        dz8LokxLiv0QicKfvxGL0Jx1e3569YZDLm6Ihgd7qut1fjlfz7C1TAzu2faMDAI5lidkJ1r9nD4
        H3Hlfnstt6Fw77RZTccIXllp8GxIIytaUXhpHA8/6t473cvc7ZruORDaLqYR8SNhyBWS6qS47
X-Received: by 2002:aa7:c652:: with SMTP id z18mr12090860edr.60.1607182019670;
        Sat, 05 Dec 2020 07:26:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjZv4gdoGpTjg8uc+bOkqs0AgNM71eHpeOOVclvjy5+N2nJq4K5EpG6lTNFSSGqWNG+U670g==
X-Received: by 2002:aa7:c652:: with SMTP id z18mr12090839edr.60.1607182019354;
        Sat, 05 Dec 2020 07:26:59 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id cc8sm5267163edb.17.2020.12.05.07.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 07:26:58 -0800 (PST)
Subject: Re: [PATCH 0/1] iio: core: Copy iio_info.attrs->is_visible into
 iio_dev_opaque.chan_attr_group.is_visible
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
References: <20201125084606.11404-1-hdegoede@redhat.com>
 <2a20cf21-d483-d41e-6ff8-95ae23d230c2@redhat.com>
 <20201205152344.173e5b96@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f11fd496-948e-8bf9-04eb-44262d54a271@redhat.com>
Date:   Sat, 5 Dec 2020 16:26:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201205152344.173e5b96@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

n 12/5/20 4:23 PM, Jonathan Cameron wrote:
> On Tue, 1 Dec 2020 13:28:47 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 11/25/20 9:46 AM, Hans de Goede wrote:
>>> Hi All,
>>>
>>> I wrote this because I was planning on using is_visible in a driver's
>>> attribute group myself (1). But in the end it looks like I'm going to
>>> do things differently.
>>>
>>> This is still useful to have though, both for possible future use of
>>> is_visible in driver's attribute groups as well as to make the current
>>> usage of is_visible in adi-axi-adc.c actually work.  
>>
>> Jonathan, any opinion / remarks on this one?
>>
>> FWIW since I no longer have plans to use is_visible in an iio-driver
>> myself I'm fine with dropping this one, but:
>>
>> 1. Being able to use is_visible in the attr group of iio-drivers
>> seems like a nice thing to have.
>>
>> 2. There is an existing use of is_visible in adi-axi-adc.c which currently is broken.
> 
> I was giving time for Alex, or others to sanity check the need for a fix
> (well more specifically wether this one was the right one as clearly
> a need!).
> 
> Anyhow, all sounds good.  Giving timing I'll mark it as one I'll pick up
> to go in after rc1 + stable. 
> 
> I'm not totally sure on the fixes tag.  Current patch will have to go on top
> of 207c2d27a010 ("iio: core: move channel list & group to private iio device object")
> but I don't think it worked before that either as we were still copying attributes
> around, just to a different location.

I don't think it is important for this one to go to the stables series,
so if you think it may cause problems feel free to drop the Fixes tag
(or point it to a different commit).

Regards,

Hans

