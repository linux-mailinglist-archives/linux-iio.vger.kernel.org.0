Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E501426649
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhJHJDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 05:03:42 -0400
Received: from www381.your-server.de ([78.46.137.84]:51344 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhJHJDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 05:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=6sUmyfkThh68iRomW7PRapCD9rGYMygelig74dlrCqc=; b=I8r2KhHZBMGNazNY5W93es70j2
        dwe63b3ikjynYQ96VMi8Ig+Z/e3apONMftYvWn434YqPvHoKpB+qIm9f1DDa0CXImjtVKs/fa+dum
        Ri/qYqfXy7eOwB7I4qumfG3NTGuhaqQB7XpYWa+RZIQCEiyI1/UOthC4C3ocZU0ENaEtxSvcWSs7E
        jMZQHgi6IjppCgaep6ra4CKp/n++4xeIz+w8GiKQm4Bplcw9PRgeOa1bPK+DT/ZL67njcSeF50lmh
        hPo2jk+IdTC2dUOu7Awgs+Ci8Ix4oYDDcuX2cd1OUcm9k+OL8NV/iudaFTB4cARCqL37U82Ic44ly
        yedcpHUw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mYll8-00083I-Ru; Fri, 08 Oct 2021 11:01:42 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mYll8-000UBW-Ll; Fri, 08 Oct 2021 11:01:42 +0200
Subject: Re: [PATCH] iio/scmi: check if dev is null pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, jbhayana@google.com,
        jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1633674573-81211-1-git-send-email-jiasheng@iscas.ac.cn>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d4ccc9c0-c852-1c40-d0a1-70298b6b34c2@metafoo.de>
Date:   Fri, 8 Oct 2021 11:01:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1633674573-81211-1-git-send-email-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26315/Thu Oct  7 11:09:01 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/8/21 8:29 AM, Jiasheng Jiang wrote:
> The parameter 'dev' of scmi_iio_dev_probe() isn't been
> checked before used, including when scmi_iio_dev_probe() is called.
> Therefore, it might be better to check, just in case.
>
> Fixes: 25cbdd4 ("iio/scmi: Port driver to the new scmi_sensor_proto_ops interface")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Hi,

Thanks for the patch.

Is there anything that makes you think dev could ever be NULL? dev is a 
pointer to a field in `sdev`. So for `dev` to be NULL sdev would have to 
be `-offsetof(struct scmi_device, dev)`.


- Lars

> ---
>   drivers/iio/common/scmi_sensors/scmi_iio.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
> index 141e8aa..d3ff985 100644
> --- a/drivers/iio/common/scmi_sensors/scmi_iio.c
> +++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
> @@ -592,6 +592,9 @@ static int scmi_iio_dev_probe(struct scmi_device *sdev)
>   
>   	if (!handle)
>   		return -ENODEV;
> +
> +	if (!dev)
> +		return -ENODEV;
>   
>   	sensor_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_SENSOR, &ph);
>   	if (IS_ERR(sensor_ops)) {


