Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA2319D73
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 12:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBLLgl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 06:36:41 -0500
Received: from www381.your-server.de ([78.46.137.84]:36544 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhBLLg3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 06:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=LB8dl2RxIN//zhj+ja02xt445NXNMzDjJQYs9Xwtfa8=; b=e9IXiEEbfCytoXcIB16bx+BsX2
        fAjG5vY/bS6142DoNUvUHl6fHqL7qlLIEvw4KhCcB+/sqMWwMWwKf0Krj+ZQTFs0SYbAsAWCVZRdB
        BQXfSWgJNf24IE9TcHUQ+1JdxHRur/HTjq1IG0XFmG67ihEe0n37BnH/1X89tsXdwmH4M7C3R7lo1
        R7m03oyPPYdgws6DhQpiz6g95v5qeuGWO+t/Qs0aMiLRpNv+xIMIYGTxmEO5zJuSiQaO5m+1bLiIn
        iM7VclnBdVzpdwQZo/RVasz/2KyyHF6EmM5lIu4oyetGSo3yYA1X5ouWp1rYhsf15OrnRIYvgcmro
        omrqMG1Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lAWjY-00046S-9b; Fri, 12 Feb 2021 12:35:36 +0100
Received: from [62.216.202.92] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lAWjY-000F1M-4X; Fri, 12 Feb 2021 12:35:36 +0100
Subject: Re: Adding custom functional callbacks to IIO driver
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR02MB69164C83B7BA664AF350D712A98B9@BY5PR02MB6916.namprd02.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b8cc5128-da41-2620-c44b-c7af28cf6980@metafoo.de>
Date:   Fri, 12 Feb 2021 12:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BY5PR02MB69164C83B7BA664AF350D712A98B9@BY5PR02MB6916.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26077/Thu Feb 11 13:18:43 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/12/21 12:07 PM, Anand Ashok Dumbre wrote:
> Hello,
>
> I have an IIO adc driver that measures temperatures and voltages on the SOC.
> There are other kernel modules interested in the temperature and voltage event information.
>
> Would using a custom callback registration mechanism be advisable?
> Is there something similar done already in IIO that can be leveraged?

Hi,

Have a look at the IIO consumer API that allows other kernel modules to 
subscribe to the output of an IIO device. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/iio/consumer.h 


- Lars

