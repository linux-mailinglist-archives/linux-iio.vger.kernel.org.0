Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB9636A28B
	for <lists+linux-iio@lfdr.de>; Sat, 24 Apr 2021 20:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhDXSVZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Apr 2021 14:21:25 -0400
Received: from www381.your-server.de ([78.46.137.84]:54744 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbhDXSVY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Apr 2021 14:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=WRizYjuChZVACdbHdKjrYX0xDpwtBjEh0KJUrqKNQs0=; b=LaRh/njDsRJ5+9pWt6/TgP9M3p
        yfg6eoomPdDSWt9vF+SEB59H+llgdDqG3huvhdts7ZFdsg4Grqx7jdgBCdrqwugrc500JG91wkhLf
        R4bBTT7rk7/dZbAxec5Hk2tR0k+PRn2h6uRuf1HVXWtzt1ED8ioOHeD5WTB3z9ZB3k5tMvmWl60PX
        /SPtuUYyHguHEnpUwAn1Hyij1Ohd0zi9VrIuAcuD8OdS3iM5xSmBGirbd1LGw8VkTOpRwOvTDLN/L
        o5e53mI4FrPqh0vjafGPjgbkorVuAkfQbWC+H7+fADRMMK2yU5M+unr5hgq5VAGRx7Fs8+yEaa1vM
        hPpXcinw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1laMtW-000DLj-2N; Sat, 24 Apr 2021 20:20:42 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1laMtV-000V8g-Tq; Sat, 24 Apr 2021 20:20:41 +0200
Subject: Re: [PATCH v3 1/2] iio:adc:ad7476: Handle the different regulators
 used by various parts.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        kernel test robot <lkp@intel.com>
References: <20210424170346.526242-1-jic23@kernel.org>
 <20210424170346.526242-2-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3780b584-3a94-4fdd-f6d3-b8823a253de7@metafoo.de>
Date:   Sat, 24 Apr 2021 20:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210424170346.526242-2-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26150/Sat Apr 24 13:06:52 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/24/21 7:03 PM, Jonathan Cameron wrote:
> [...]
>   
> +	/* Either vcc or vref (below) as appropriate */
> +	if (!st->chip_info->int_vref_uv)
> +		st->ref_reg = reg;
> +
> +	if (st->chip_info->has_vref) {
> +
> +		/* If a device has an internal reference vref is optional */
> +		if (st->chip_info->int_vref_uv) {
> +			reg = devm_regulator_get_optional(&spi->dev, "vref");
> +		} else {
> +			reg = devm_regulator_get(&spi->dev, "vref");
> +			if (IS_ERR(reg))
> +				return PTR_ERR(reg);
> +		}
> +
> +		if (!IS_ERR(reg)) {
> +			ret = regulator_enable(reg);
> +			if (ret)
> +				return ret;
> +
> +			ret = devm_add_action_or_reset(&spi->dev,
> +						       ad7476_reg_disable,
> +						       reg);
> +			if (ret)
> +				return ret;
> +			st->ref_reg = reg;
> +		} else {
We still need to check for errors, e.g. to support EPROBE_DEFER. The 
only error that can be ignored is ENOENT, which means no regulator is 
specified.
> +			/*
> +			 * Can only get here if device supports both internal
> +			 * and external reference, but the regulator connected
> +			 * to the external reference is not connected.
> +			 * Set the reference regulator pointer to NULL to
> +			 * indicate this.
> +			 */
> +			st->ref_reg = NULL;
> +		}
> +	}

