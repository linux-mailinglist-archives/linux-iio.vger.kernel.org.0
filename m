Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF905BCF77
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiISOrM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiISOrI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 10:47:08 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6082922B0B
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=x8nZHVrdy4wuVxwvYfgPUPms/vLCRC7LhKs+L8N3OtI=; b=aXuIRP7wVLiPxDsXvdHmaGPUXF
        hFas4nLviqwqRWLYirAChEoqkbQoANfC/0GDimWvUwdyejzvqRLGxNxkfZ+WgjXzzXoQtQLAz+RBy
        OHeD6WfZl7ki31viXJDh7cnCFjy4HGQ4Uhkfgpj/H7IOewE8pnr9a7CzBgYB3w7ZyVcW9nrj/lWCo
        vJRHLq3R2dUpsttBfSCjREvLsQs0r57nasG8znDq7mknGNVUVYbxxOGQaVcU4FIgWyat1O/jLlD55
        dw6iYLkUmGunsmYJTbEXTu986YoZveK/IekiEuawfL38rf0B1cTu3rdYgC/CPBVLJN9TNLau6xS7j
        Pd2y+SBQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1oaI2x-000CrQ-F8; Mon, 19 Sep 2022 16:46:55 +0200
Received: from [2001:a61:2a52:ad01:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oaI2x-0009dg-Lo; Mon, 19 Sep 2022 16:46:55 +0200
Message-ID: <d4fa7502-d5a5-9849-8daf-efc25a22ae81@metafoo.de>
Date:   Mon, 19 Sep 2022 16:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] iio: adc: ad7124: Silent no spi_device_id warnings
Content-Language: en-US
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20220919145945.823327-1-weiyongjun@huaweicloud.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220919145945.823327-1-weiyongjun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26663/Mon Sep 19 09:56:35 2022)
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/19/22 16:59, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> Add spi_device_id entries to silent following SPI warnings:
>
> SPI driver ad7124 has no spi_device_id for adi,ad7124-4
> SPI driver ad7124 has no spi_device_id for adi,ad7124-8
What generates those warnings?

