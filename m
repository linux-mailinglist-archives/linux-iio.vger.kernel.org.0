Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA4327183
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 09:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhB1IHS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Feb 2021 03:07:18 -0500
Received: from www381.your-server.de ([78.46.137.84]:44590 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhB1IHS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 03:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=B9OZjisZDX8Qs3+RcaljLhAAmht/cIkc7wgQ3CQ34vk=; b=lrmBZ59/aJRAz+zhb0ZzsAO4v3
        778WWCIoczKHKyUdNz16swEWFL84Qs+Geluwf3cc4I9HKpUokXZfvORsFVxFCk0weiFPK52k3Pz12
        zM4iE+2+EdA9yFR/IFXNBOpUwWN9yXzV8mbdxyX7SzeJRJo7ABZnFO7APuZOSLe1/IXY+YAEXzpQT
        grH9w7reqOm1ElvJgE1dHPgxnbm4WwANtEXTtKuEdtS29wKkMAytU41COFNh43BWZK5IPAq90REtl
        stpdymIetO/1Cnq1GdnGCBkJro44cSE4ymPcQDfL2otueMwR+FT6B+AEgYRED/qJZC5cC+66QTIVh
        OxDS7d1Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lGH5c-0002Nc-Dh; Sun, 28 Feb 2021 09:06:08 +0100
Received: from [62.216.202.180] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lGH5c-0009HL-8Q; Sun, 28 Feb 2021 09:06:08 +0100
Subject: Re: [PATCH v6 02/24] iio: kfifo: add devm_iio_kfifo_buffer_setup()
 helper
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
        dragos.bogdan@analog.com
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-3-alexandru.ardelean@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2e6f90be-5dbf-1356-d1ac-22a4273c87ee@metafoo.de>
Date:   Sun, 28 Feb 2021 09:06:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210215104043.91251-3-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26093/Sat Feb 27 13:05:31 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/15/21 11:40 AM, Alexandru Ardelean wrote:
> +int devm_iio_kfifo_buffer_setup(struct device *dev,
> +				struct iio_dev *indio_dev,
> +				int mode_flags,
> +				const struct iio_buffer_setup_ops *setup_ops)
> +{
> +	struct iio_buffer *buffer;
> +
> +	if (mode_flags)
> +		mode_flags &= kfifo_access_funcs.modes;

The if seems unnecessary. If it is 0 and we AND it with something it is 
still 0.

