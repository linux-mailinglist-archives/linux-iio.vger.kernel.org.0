Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2DB1AD5E7
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 08:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgDQGD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 02:03:27 -0400
Received: from www381.your-server.de ([78.46.137.84]:41894 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgDQGD1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 02:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1MrilURBJU27xfUpXQnavFqqaKN+G8rNlFNStDVkiYo=; b=UwrNKvBmm/AzlgCX1YIVSqcLS4
        YiVBKw90LUdsyLkRa7EZwmXi0US4OBb6QxHV54u/AgsA2qskQMHJGZAQOTswMPPla1Nz1rACdaxb9
        UaZxneTkySDlRS34oPtWaA/EjJeKF/XfiXlEvxZT6a6vgODDwA2qVB6iHrhXZOtOqyHhvOpGBXpQO
        JoAKz7eMntdHhuZMY7lGGWPp3MlPyP267IOSawdbhuxxuHzoxg8B47pcN37gM7geBO+0YDK0lup7u
        Gq95YssBJdxshX6VRbolhmpJ4fovHQDdP2hfnSjTQS61sanD8AVoEaI1gR1mdDhoTCqRikWvPMxm/
        UHZRhNCA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jPK61-0007So-B1; Fri, 17 Apr 2020 08:03:25 +0200
Received: from [82.135.79.46] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jPK61-000EiU-4s; Fri, 17 Apr 2020 08:03:25 +0200
Subject: Re: Max lengths of device names?
To:     "Getz, Robin" <Robin.Getz@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <SN6PR03MB37096772490859AB2C251938E5D80@SN6PR03MB3709.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3a868889-20a6-5d4b-6891-f0bb12e01cb7@metafoo.de>
Date:   Fri, 17 Apr 2020 08:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <SN6PR03MB37096772490859AB2C251938E5D80@SN6PR03MB3709.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25784/Thu Apr 16 13:58:59 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/17/20 1:52 AM, Getz, Robin wrote:
> I was looking at trying to make some userspace code a little more robust, and needed to understand the potential size of things behind sysfs.
>
> For example, I would think that would be a "max length of the string that represents the device name".
>
> But I couldn't find anything...
>
> I understand that some of the names are encoded in the sysfs file name, and therefor are NAME_MAX worse case, but things like device name have no such limit. It's not practical/useful that they are PAGE_SIZE (does anyone need a 4k name?) but right now - I think that might be the limit (unless I'm missing something).

Yes, PAGE_SIZE. Although that is an implementation detail on the kernel 
side, best is to assume any size is possible.

- Lars

