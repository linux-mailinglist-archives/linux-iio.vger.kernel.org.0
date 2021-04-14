Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940D435EFC9
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhDNIhv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Apr 2021 04:37:51 -0400
Received: from www381.your-server.de ([78.46.137.84]:60644 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhDNIhu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Apr 2021 04:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=I3h8InelMwWQEwsxRD1zDPA27Lroskn99+uQLhVojSQ=; b=W3oorWTruECHV7pKRofXhos/In
        zoe7kCcyW8qbkpdF1yakMAMlEqLNz5LxEPmbpfgwtprZcBd+ylP+bXps2ygbuFqmM8IGqC5AxZFP1
        j4ubFyCugt1r+36MdU30nQhxxho4dddJHHKC/UHzgNHm78wR0rTh58uYXuJct8aLbO4piUToOl5hz
        rHRKcdVpWCIL8oldZuqZ47RoKL9WKmkYXbCSIOFw0zftRG1Us+5Br7aGZaWcX0lmw8TXmPWVVxO2e
        ID6G3WWfLWF3ckgAKiHIxNqQvLCPM6xS+TliSCCASN1UvzGWI7XgFVrU4I3BA2rodF5cP27CLlh2u
        WsCHrcMQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lWb1Z-000F3S-9Z; Wed, 14 Apr 2021 10:37:25 +0200
Received: from [2001:a61:2bab:901:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lWb1Z-000WjH-63; Wed, 14 Apr 2021 10:37:25 +0200
Subject: Re: [PATCH 0/7] Adis IRQ fixes and minor improvements
To:     Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20210413112105.69458-1-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <67e2d21b-83b0-2d42-45db-4e0e009f73bc@metafoo.de>
Date:   Wed, 14 Apr 2021 10:37:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210413112105.69458-1-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26139/Tue Apr 13 13:07:58 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/13/21 1:20 PM, Nuno Sa wrote:
> The primary goal of this series was to fix the return value on some
> trigger handlers as spotted in [1]. While doing it, I found some minor
> improvements that I think are simple enough to include in this series.
>
> As for the first 2 patches, I opted to not do any functional change so
> I'm keeping the 'if (!adis->buffer)' check. However, 'adis-buffer' is
> allocated in 'update_scan_mode' hook which means we should be sure that
> the buffer is allocated and the check is really not needed. I did not
> went into the details but is there any way for the trigger handler to be
> called before the 'update_scan_mode' hook? If not, I'm happy in sending
> a v2 where we just remove the 'if'...

I do remember that the check was deliberate. I do remember of thinking 
about whether we need this and feeling uncomfortable about not having 
the check. But I think it is more a instance of defensive programming 
rather than actually being required.

It was less about the trigger being called before update_scan_mode, but 
in case it gets called if the allocation in update_scan_mode fails. But 
I think this should not be possible. So it is probably safe to remove it.

- Lars

