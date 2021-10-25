Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFE439731
	for <lists+linux-iio@lfdr.de>; Mon, 25 Oct 2021 15:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhJYNK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Oct 2021 09:10:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:55504 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhJYNK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Oct 2021 09:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fiF7nQ2Dt25hRcFJsRXMR+cs804ppAyklD1WdPtGe6o=; b=gleq/OGlJE0c9vDxSIK6+RTyOd
        BEYETtx0NbeVtqhzvz2V1regizjN/ixxgpewTFHBiGwu3QMedH+j0ypO4Chsc2WH/oiJ5PmWDScbT
        Rw0idpoXAuU1webjpmB2pCNTjS2d+O0jnHH4ll0pDKk9yPU/9ccGcnBVo3w0iPGdZlqP4+Yuq2jOS
        Jlz/R1xNV1UNS4Kj7UwC9AN735XXP98KCth+YNDOhfTLw6SC56JTjKxTAJ3bYG4dKScuoJBc6MwyP
        b6hx9qr8n6S/BUYqYvFiemMTqytlAs8HABK9nwNvbjqMTA+0cPpw7K+l9e09AaRrP7JX5eIRFxr13
        5JnDKp2g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mezhp-0002MC-9G; Mon, 25 Oct 2021 15:08:01 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mezho-000KEF-UU; Mon, 25 Oct 2021 15:08:00 +0200
Subject: Re: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        pmeerw@pmeerw.net, devicetree@vger.kernel.org
Cc:     Manish Narani <manish.narani@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
 <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <caaa19ef-131c-ad5c-1403-ff948de9f200@metafoo.de>
Date:   Mon, 25 Oct 2021 15:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26333/Mon Oct 25 10:29:40 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/19/21 5:20 PM, Anand Ashok Dumbre wrote:
> +static int ams_init_device(struct ams *ams)
> +{
> +	u32 reg;
> +	int ret;
> +
> [...]
> +	if (ams->pl_base) {
> +		writel(AMS_PL_RESET_VALUE, ams->pl_base + AMS_VP_VN);
> +
> +		ret = readl_poll_timeout(ams->base + AMS_PL_CSTS, reg,
> +					 (reg & AMS_PL_CSTS_ACCESS_MASK) ==
> +					 AMS_PL_CSTS_ACCESS_MASK, 0,
> +					 AMS_INIT_TIMEOUT_US);

The PL_CSTS register indicates whether the PL monitor can be accessed 
through the AMS.

But here we access the reset register even before the check. In addition 
there is really no point in polling the register as the state will not 
change. If the PL can not be accessed this should just return. And only 
after verifying that the PL can be accessed should the reset be done.

> +		if (ret)
> +			return ret;
> +
> +		/* put sysmon in a default state */
> +		ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +				  AMS_CONF1_SEQ_DEFAULT);
> +	}
> +
> +	[...]
> +
> +	return 0;
> +}
> +
>
> +static int ams_probe(struct platform_device *pdev)
> +{
> [..]
> +
> +	ret = ams_init_device(ams);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> +		return ret;
> +	}
> +
> +	ret = ams_parse_dt(indio_dev, pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failure in parsing DT\n");
> +		return ret;
> +	}
> +
These two need to be called the other way around. ams_init_device() 
wants to access the IO registers, but they are only mapped in 
ams_parse_dt().
