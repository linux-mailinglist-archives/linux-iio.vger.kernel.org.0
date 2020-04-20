Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206931B05DD
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTJo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 05:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTJo1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 05:44:27 -0400
Received: from ns.pmeerw.net (ns.pmeerw.net [IPv6:2001:1b60:2:23:1033:103:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598E3C061A0C
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 02:44:27 -0700 (PDT)
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id 47CBAE0382; Mon, 20 Apr 2020 11:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1587375865; bh=lpD1xO/eMPO6mvEjPB98SZe45yNb8zLAzeyM/dqfXgQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=GJhpntXvqdsJwStzPSVfYKwZZOLnI3VPCVSiyJPeVnGdi3BaNDDRATE3UTRSGrWpF
         tsi05MomKiWK7xlsrR+oVA/rPqs27yqTb85pJ39PKLsNYaRMdLPGBvS5b5+wtlBbky
         AfLHbeHHxi8hcD3YZPNziGMw4wJZjfLDWerChbLo=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id 2353CE019D;
        Mon, 20 Apr 2020 11:44:25 +0200 (CEST)
Date:   Mon, 20 Apr 2020 11:44:25 +0200 (CEST)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: vcnl4000: Factorize data reading and
 writing.
In-Reply-To: <20200420084210.14245-2-m.othacehe@gmail.com>
Message-ID: <alpine.DEB.2.21.2004201142160.8178@vps.pmeerw.net>
References: <20200420084210.14245-1-m.othacehe@gmail.com> <20200420084210.14245-2-m.othacehe@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020, Mathieu Othacehe wrote:

> Factorize data reading in vcnl4000_measure into a vcnl4000_read_block_data
> function. Use it to provide a vcnl4000_read_data function that is able to
> read sensor data under lock. Also add a vcnl4000_write_data function.

comments below
 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  drivers/iio/light/vcnl4000.c | 54 +++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 58e97462e803..4e87d2cf1100 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -215,11 +215,59 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	return 0;
>  };
>  
> +static int vcnl4000_read_block_data(struct vcnl4000_data *data, u8 data_reg,
> +				    int *val)
> +{
> +	__be16 buf;
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client,
> +		data_reg, sizeof(buf), (u8 *) &buf);
> +	if (ret < 0)
> +		goto end;
> +
> +	*val = be16_to_cpu(buf);
> +end:
> +	return ret;
> +}
> +
> +static int vcnl4000_read_data(struct vcnl4000_data *data, u8 data_reg,
> +			      int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +	ret = vcnl4000_read_block_data(data, data_reg, val);
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
> +static int vcnl4000_write_data(struct vcnl4000_data *data, u8 data_reg,
> +			       u16 val)
> +{
> +	int ret;
> +
> +	if (val > U16_MAX)
> +		return -ERANGE;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, data_reg, val >> 8);

why not use i2c_smbus_write_word_data()?

> +	if (ret < 0)
> +		goto end;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, data_reg + 1, val);
> +end:
> +	mutex_unlock(&data->vcnl4000_lock);
> +
> +	return ret;
> +}
> +
>  static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  				u8 rdy_mask, u8 data_reg, int *val)
>  {
>  	int tries = 20;
> -	__be16 buf;
>  	int ret;
>  
>  	mutex_lock(&data->vcnl4000_lock);
> @@ -246,13 +294,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  		goto fail;
>  	}
>  
> -	ret = i2c_smbus_read_i2c_block_data(data->client,
> -		data_reg, sizeof(buf), (u8 *) &buf);
> +	ret = vcnl4000_read_block_data(data, data_reg, val);
>  	if (ret < 0)
>  		goto fail;
>  
>  	mutex_unlock(&data->vcnl4000_lock);
> -	*val = be16_to_cpu(buf);
>  
>  	return 0;
>  
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
