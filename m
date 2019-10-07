Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E34CDCAE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfJGH5D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 03:57:03 -0400
Received: from first.geanix.com ([116.203.34.67]:47882 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfJGH5D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 03:57:03 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 0E3D54A557;
        Mon,  7 Oct 2019 07:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1570434940; bh=UAZTDjN1xyXSdv+vFrVVQnqKO4liO3ir6+BULL3HvDk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Nyq7poM2eFtL+XvW6hWzgGVQGFT7oBLf5VQUx+v24KA1hJZHVFVb9E1IMjyfxTlj+
         LC/aLl7LdJxJbFmv/nuAt46EYdtxlgBHYwsHzqh6GnXnW3NYiOt6I0bxYtoIN53Jgc
         j3/4RAHjem2FCOjpBERGAPpuJDZpZG2bYsJuj5pFJ+gl5SXyP5k3CzD1rSG0L3nkSh
         4r/xnzNHNHTVFLbc8o3s5HRB+Ejl9Culm1GRHpnSE1YT8Tagu7nkzm2lAD5Hlqth9Q
         ACDzYc1gJD4wkEmvQfj4vm8/KTfNBKojptajaSg34zw4rkSoe+Pt9EpJVwqUJ4qykG
         mdIsFu22EfXRQ==
Subject: Re: [PATCH 12/13] dt-bindings: iio: imu: st_lsm6dsx: document missing
 wakeup-source property
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com, rjones@gateworks.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
References: <cover.1570367532.git.lorenzo@kernel.org>
 <b0521798dfc8a64780349876fe00a2664bc1b926.1570367532.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5907e9a9-10b4-ccc2-2915-cdb5f46b1d54@geanix.com>
Date:   Mon, 7 Oct 2019 09:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b0521798dfc8a64780349876fe00a2664bc1b926.1570367532.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=disabled
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b8b5098bc1bc
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 06/10/2019 15.22, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> index 6d0c050d89fe..1a07d38c813f 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> @@ -31,6 +31,7 @@ Optional properties:
>   - interrupts: interrupt mapping for IRQ. It should be configured with
>     flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
>     IRQ_TYPE_EDGE_FALLING.
> +- wakeup-source: Enables wake up of host system on event.
>   
>     Refer to interrupt-controller/interrupts.txt for generic interrupt
>     client node bindings.
> 
