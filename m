Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BA25E8EA0
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiIXQxe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 12:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIXQxd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 12:53:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142891146D
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 09:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55DA3CE09AC
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 16:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DACC433D6;
        Sat, 24 Sep 2022 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664038409;
        bh=lHmMN3b2vwHta39fUZKTlwtwj2X4Gc2s2I8UhPx2A2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SmY31hd1f8q0NVIWUtf4fhEdhOH9aCcN7LKPmi9jcRE9bUhmBPpv9dxX/sQPInDhK
         5D5QsBu0jbzmSjJISMDEhTPFBUmPBj0rg+LJZVhg7k8txf/OceM5koLab3lSf9HA99
         1WVJlA56w2WMc5oLv77xzdxD0tElzMWC9Fo8DUZ5LapoRsb4a4r31+n/sLrVme9kJj
         agMOKndA+T2CvUSKfOWsLT/iZbi22ghGBRI2xHN7TDZmloXhdH0Q3fwyh48ERnXTIJ
         GQAgyoIN9YfmoOlzESY4aWiel4Vr5eOAZfHe2uMF4OOYunQna9QfCjkl361i3VQ0+O
         1I8GeBRynclZQ==
Date:   Sat, 24 Sep 2022 17:53:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     linux-iio@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: filter: admv8818: fix out-of-bounds read in
 __admv8818_read_[h|l]pf_freq()
Message-ID: <20220924175336.3c3cadb6@jic23-huawei>
In-Reply-To: <20220922115848.1800021-1-weiyongjun@huaweicloud.com>
References: <20220922115848.1800021-1-weiyongjun@huaweicloud.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Sep 2022 11:58:48 +0000
Wei Yongjun <weiyongjun@huaweicloud.com> wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> ADMV8818_SW_IN_WR0_MSK and ADMV8818_SW_OUT_WR0_MSK have 3 bits,
> which means a length of 8, but freq_range_hpf and freq_range_lpf
> array size is 4, may end up reading 4 elements beyond the end of
> those arrays.
> 
> Fix to check value first before access freq_range_hpf and
> freq_range_lpf.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

The datasheet isn't clear on whether the register simply can't take values
above b100 or that the behaviour if it does is undefined.  It would take someone
to poke the registers on a real device to find out.  Either way, this seems to
be a reasonable hardening against corrupt data back from the device.

I will leave it on list a while longer though so it is probably 6.2 material
now.

Thanks,

Jonathan

> ---
>  drivers/iio/filter/admv8818.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
> index 68de45fe21b4..fe8d46cb7f1d 100644
> --- a/drivers/iio/filter/admv8818.c
> +++ b/drivers/iio/filter/admv8818.c
> @@ -265,7 +265,7 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
>  		return ret;
>  
>  	hpf_band = FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
> -	if (!hpf_band) {
> +	if (!hpf_band || hpf_band > 4) {
>  		*hpf_freq = 0;
>  		return ret;
>  	}
> @@ -303,7 +303,7 @@ static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
>  		return ret;
>  
>  	lpf_band = FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
> -	if (!lpf_band) {
> +	if (!lpf_band || lpf_band > 4) {
>  		*lpf_freq = 0;
>  		return ret;
>  	}

