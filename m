Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E942DFBB5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Dec 2020 13:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgLUMDg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Dec 2020 07:03:36 -0500
Received: from www381.your-server.de ([78.46.137.84]:55568 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgLUMDg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Dec 2020 07:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ekx2bP+pSpp8kG02Qbxbz890hUtN88GEowzicB+yYck=; b=Mfeqq3c4G426/ClZKEHyefixjG
        3l0zTnmwTbhsG1QNvOiZDllUV1FMyHi2XNiidhcBXaqmkBmEphb1EpMthNZY3DQgel4S1pKaFv4Ae
        9orOgggfWYDbuaFbrTFuzRP+4ZKGkvDsr103ZVLvGER4xt3SELDRWu4SXqKwz74XoHQUCRFMa16wo
        5AEuph3NDe02wYGErGZE0AS2/OAdQ2vmv+PMf9BAsIc/2HzcpHHocX/jnTnrWSTSOGR1i6odez6H6
        8BdVDc9BF8Ei7bLQLgDsenUsPVEsNI8Z1QCIysHaUXjMtu4ixwoYrH3maIBCVGMlRmJf6N6/lDbqQ
        CKhGrwlw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1krJtu-000Dpr-9p; Mon, 21 Dec 2020 13:02:54 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1krJtu-0000In-77; Mon, 21 Dec 2020 13:02:54 +0100
Subject: Re: device tree binding for iio-trig-hrtimer
To:     yarl-baudig@mailoo.org, linux-iio@vger.kernel.org
References: <ea-mime-5fe03673-6635-5dbe1461@www-1.mailo.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f2bd1640-53b7-c558-4a94-c8fd66227415@metafoo.de>
Date:   Mon, 21 Dec 2020 13:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ea-mime-5fe03673-6635-5dbe1461@www-1.mailo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26023/Sun Dec 20 13:52:43 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/21/20 6:45 AM, yarl-baudig@mailoo.org wrote:
> Hello,
>
> Is it possible to create and bind an iio-trig-hrtimer as an interrupt-parent (or something like that) for a sensor?
> If so, what would the dts look like?
>
The very first version of the iio-trig-hrtimer driver did have 
devicetree bindings[1].

But since the iio-trig-hrtimer does not represent any piece of hardware 
and the devicetree is a description of the hardware this was dropped 
before upstreaming the driver. And a new interface for being able to 
dynamically create hrtimer triggers using configfs was created.

Creating a hrtimer trigger and assigning it to a sensor has to be done 
from a userspace application.

- Lars

[1] 
https://github.com/analogdevicesinc/linux/blob/1594c10513b7becdf7ed6026bb70a07ba8118d5f/drivers/staging/iio/trigger/iio-trig-hrtimer.c#L166-L170 
<https://github.com/analogdevicesinc/linux/blob/1594c10513b7becdf7ed6026bb70a07ba8118d5f/drivers/staging/iio/trigger/iio-trig-hrtimer.c#L166-L170>


