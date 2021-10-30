Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2502440899
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhJ3Lm5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:42:57 -0400
Received: from www381.your-server.de ([78.46.137.84]:32818 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbhJ3Lm4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=AxLk2ctV76XA22bHQk5qP3DgZAwoE/IC0+aIcoZ6UP8=; b=fZ+z/k5HIoG9zPD/hyd3RUs0fh
        mvPhN/F1NBK7RbRG6E3qCbHxoJKQ7YHTpQBAiBIwDXwy91UKLmQy1tn0iVxzxcdNIXp67cdmuG61L
        pwbe1lORyKu3ERWtebjVXaWF8i2FaRmcFDkQzYTQn6KAaKkjYg8CyOul0hR4lyNpFb62i5aR+lTvB
        W7Q9L+pSeb5d9qtU7gVT5i+O3nANqsdc5f8PJq1rS3U/Tp0eSxsVBcxhT1b/ZBI9OHzCJg67G2BxR
        Xvwyp5FiTEAc+rYrsphOFmEm4odoseCiUtAok8XNR9uI09EhHOPOmyPhc3zuHdyMDbtoSXPMQ4Bqx
        SCNEPUkA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mgmin-0007BM-9O; Sat, 30 Oct 2021 13:40:25 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mgmin-0005Bl-4f; Sat, 30 Oct 2021 13:40:25 +0200
Subject: Re: [PATCH 2/5] iio: sx9310: Extract common Semtech sensor logic
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
References: <20211030111827.1494139-1-gwendal@chromium.org>
 <20211030111827.1494139-3-gwendal@chromium.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9f049bc7-326e-4020-3d2d-12ece5e99e38@metafoo.de>
Date:   Sat, 30 Oct 2021 13:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211030111827.1494139-3-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/30/21 1:18 PM, Gwendal Grignou wrote:
> [...]
> diff --git a/include/linux/iio/proximity/sx_common.h b/include/linux/iio/proximity/sx_common.h
> new file mode 100644
> index 0000000000000..60c3291e7925c
> --- /dev/null
> +++ b/include/linux/iio/proximity/sx_common.h
Can this header live in drivers/iio/proximity? No need to put it in the 
global space if it is only used locally.
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Code shared between the different Qualcomm PMIC voltage ADCs
PMIC? I though this was a proximity sensor :)

