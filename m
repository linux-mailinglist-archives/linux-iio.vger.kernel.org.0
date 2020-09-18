Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FE26FF26
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIRNxT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 09:53:19 -0400
Received: from www381.your-server.de ([78.46.137.84]:60876 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgIRNxT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 09:53:19 -0400
X-Greylist: delayed 1066 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 09:53:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=FLQ+wzaBOwYln9xxwGdYjtDfqKRVNeZFgSssP/+rDt0=; b=EGPDBjjNNodFoNSIM7ecfd487x
        NYqE2lbDFmrYH/EMIPoS4HjlF+Kreym+wLEjQoHG+F2jNlGnL2AuzBvmOQSuoXl8nyf3FWURVknVq
        srnfMyHVB777uHl6e5UKj1Y4yWmMKHKNa6bc+Zb407jVQSBRJwWDbQqnIcoEMEMu3tUreGe7IP9jg
        ysuCCSfxQ1UGzVm9xxLJkknPTDVR2GcePUihp65dPd0oLtai+VSjCeOLFIKJetQpMaH+wqQjToN4T
        qfvzlthJW3b8bAegeI75WFZbWEjIsLwmGE5ZrVsTnS0rrKv9Aw2pYtHJyKZgsqQvcZJSvuIuOsQiZ
        AraTBVOg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kJGXz-0007iJ-Hz; Fri, 18 Sep 2020 15:35:31 +0200
Received: from [2001:a61:259b:1201:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kJGXz-000E6N-E3; Fri, 18 Sep 2020 15:35:31 +0200
Subject: Re: [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by
 enum required.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
References: <20200913112546.715624-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f8db43ea-bef2-b29c-22a3-c9f074957e5c@metafoo.de>
Date:   Fri, 18 Sep 2020 15:35:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200913112546.715624-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25931/Thu Sep 17 15:53:56 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/13/20 1:25 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> So it's obvious that the code is wrong in passing true, but I'm assuming
> that will actually evaluate to 1 and hence IIO_SHARED_BY_TYPE.
> The documentation however has this attribute as IIO_SHARED_BY_ALL.
> My current assumption is the documentation is wrong.
> If anyone knows otherwise please shout out!
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 7247645f6865 ("iio: hmc5843: Move hmc5843 out of staging")
> Cc: H. Nikolaus Schaller <hns@goldelico.com>

Obviously correct.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>   drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index 1474ba63babe..780faea61d82 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -245,7 +245,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
>   };
>   
>   static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
> -	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
> +	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
>   	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
>   	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>   	{ }
> @@ -259,7 +259,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
>   };
>   
>   static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
> -	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
> +	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
>   	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
>   	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>   	{ }


