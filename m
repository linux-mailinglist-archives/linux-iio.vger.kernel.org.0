Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1941BAC02
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 20:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgD0SGN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 14:06:13 -0400
Received: from www381.your-server.de ([78.46.137.84]:33998 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgD0SGN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 14:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b+JkcQ4uyv5WctR1jDZH5MFIn8xMbKa3wCFiPqWOx6Y=; b=fMFxopEd4lVmijPFIrjnk93xxo
        35K+FqlokGWoWUAETAR0CM/dhdYpar4fZxtX2UYSjxvqCEIMAUDhZm2MqAMwI7sh5/kEE1snJI+Cn
        uNM2qVeY3aEsKKmQb1jiSSV//Lrzl9dOgFzrJso1n+MnDEwwDel3j7TMk9xxNjHebIYNvpe61yfYJ
        CcFSh4a+sYae2CQ7LyEOkpxwZu4NnYs8sWB7hWg6+N1j8jhC9zf9HurGq8s3AAzRzxP/5YCIdOh4H
        V+nM943j77Tj0x5iiTmVhNBQu+cO6KX0KunNS3DLvC4gNmnCVfNqXklj7ahCMk7D8LWEvEWRtdwcQ
        uTOk8QHg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jT88v-0005c5-LE; Mon, 27 Apr 2020 20:06:09 +0200
Received: from [82.135.70.60] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jT88v-000Ulx-9v; Mon, 27 Apr 2020 20:06:09 +0200
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20200413082445.17324-1-nuno.sa@analog.com>
 <20200413082445.17324-6-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
Date:   Mon, 27 Apr 2020 20:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413082445.17324-6-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25795/Mon Apr 27 14:00:10 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/13/20 10:24 AM, Nuno Sá wrote:
> [...]
> +static irqreturn_t adis16475_trigger_handler(int irq, void *p)
> +{
> [...]
> +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> [...]
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);

If the timestamp is enabled the IIO core might insert padding between 
the data channels and the timestamp. If that happens this will disclose 
kernel stack memory to userspace.

This needs either a memset(data, 0x00, sizeof(data)) or maybe put data 
into the state struct and kzalloc it.

- Lars

