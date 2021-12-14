Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D314748F6
	for <lists+linux-iio@lfdr.de>; Tue, 14 Dec 2021 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhLNRMb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 12:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhLNRMb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 12:12:31 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E09C061574
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:12:30 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id bu11so17908391qvb.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQqsf9k5TtH66uQwoKZtr+5VSx4cS+ShiA/sgX3ZD+w=;
        b=TCqvHPLMan9/2RwpLNYYaMGJ20l7Sgs+mq4dpP1JMy/g0WOj0oNN8w2NeJDn0wbaAk
         YdixEXMmkKxAnTI8Eg/wk0V/bJ5+J6eO2Kugb5Pq4DlA2stXagwMtkncmpJ99b5/GaHf
         SNutZIGaQoZm9rDTUs+2cIbYUCZwfcrnLDresZDzjoJzehABuQh6gt73SHQbJAJzX26z
         +TUUaeI+7qhR9q46AbHq6WrVDN9BN8qIU207ktQEoYFDMeEbGx8M1drynx+otIcU7I2C
         u/kto+sVynVaNGu8ROzOVnDDBtAjWjouo5biG8+V3u1IN+fzuyGEdTtyj8RcVXWqfh4K
         Nvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQqsf9k5TtH66uQwoKZtr+5VSx4cS+ShiA/sgX3ZD+w=;
        b=67yvM72FVETFDssZplffPs0ulwUQON23+1QpiD+eYLTigRBVAxT+jntXR7LFwdYdpS
         4xbklblTe36EFOznPWEhh4XbZ7+6Z61KlWPqPHjxWbu3/kAIci2LnzYNYySjzwoPJlkN
         sfB+dogYT2z6B0MwWzrnlAUi1qbfU9ZyOQ7FR5rTOhWaAu3SmF+xMXRQn++rvvfhYaWt
         DYExePpKCgkCDdgJVFLn/w9wpSHgzf8b5pQBJ6+0sDsP+TLQjAnu2ePqpBIaUw9ljuse
         mgXwQr+yjYz8MuLz1r4GHzwahVxR/wl5XB6ELs+RLBD4a8DYWJjrxqX5MHicMcKp3+3z
         e3UA==
X-Gm-Message-State: AOAM531mJKIC01LgwSuMjAnyyevSQgjBs9p04lwwM49VPpX62o30TK0S
        IeA9K/msnXqIFwyWh3OMfyQ=
X-Google-Smtp-Source: ABdhPJxdLOPn9X5o1Wem/cIMaNVMkhET+yMJpXpLI4RECIe1brK2fMGvCh5ZoftyHL7dyXbbDWqhaQ==
X-Received: by 2002:a05:6214:22a:: with SMTP id j10mr6635629qvt.104.1639501950011;
        Tue, 14 Dec 2021 09:12:30 -0800 (PST)
Received: from marsc.168.1.7 ([2804:30c:b14:b100:c080:51c0:2de2:c68a])
        by smtp.gmail.com with ESMTPSA id o17sm241245qkp.89.2021.12.14.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:12:28 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:12:24 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/17] staging:iio:adc:ad7280a: Use bitfield ops to
 managed fields in transfers.
Message-ID: <YbjQeDekwU1wTdrF@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
 <20211205202710.2847005-6-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205202710.2847005-6-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Minor bit inline.

On 12/05, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The write and two types of read transfer are sufficiently complex that
> they benefit from the clarity of using FIELD_PREP() and FIELD_GET()
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
>  drivers/staging/iio/adc/ad7280a.c | 46 ++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 1f7ea5fb1e20..158a792c0bf8 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -95,6 +95,23 @@
>  #define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
>  #define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
>  
> +/* Transfer fields */
> +#define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
> +#define AD7280A_TRANS_WRITE_ADDR_MSK		GENMASK(26, 21)
> +#define AD7280A_TRANS_WRITE_VAL_MSK		GENMASK(20, 13)
> +#define AD7280A_TRANS_WRITE_ALL_MSK		BIT(12)
> +#define AD7280A_TRANS_WRITE_CRC_MSK		GENMASK(10, 3)
> +#define AD7280A_TRANS_WRITE_RES_PATTERN		0x2
> +
> +/* Layouts differ for channel vs other registers */
> +#define AD7280A_TRANS_READ_DEVADDR_MSK		GENMASK(31, 27)
> +#define AD7280A_TRANS_READ_CONV_CHANADDR_MSK	GENMASK(26, 23)
> +#define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
> +#define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
> +#define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
> +#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
> +#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
> +
>  /* Magic value used to indicate this special case */
>  #define AD7280A_ALL_CELLS				(0xAD << 16)
>  
> @@ -216,10 +233,16 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
>  static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
>  			unsigned int addr, bool all, unsigned int val)
>  {
> -	unsigned int reg = devaddr << 27 | addr << 21 |
> -			(val & 0xFF) << 13 | all << 12;
> +	unsigned int reg = FIELD_PREP(AD7280A_TRANS_WRITE_DEVADDR_MSK, devaddr) |
> +		FIELD_PREP(AD7280A_TRANS_WRITE_ADDR_MSK, addr) |
> +		FIELD_PREP(AD7280A_TRANS_WRITE_VAL_MSK, val) |
> +		FIELD_PREP(AD7280A_TRANS_WRITE_ALL_MSK, all);
Does reg get initialized to 0? If not, we should take care of the reserved bit D11

> +
> +	reg |= FIELD_PREP(AD7280A_TRANS_WRITE_CRC_MSK,
> +			ad7280_calc_crc8(st->crc_tab, reg >> 11));
> +	/* Reserved b010 pattern not included crc calc */
> +	reg |= AD7280A_TRANS_WRITE_RES_PATTERN;
>  
> -	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
>  	st->tx = cpu_to_be32(reg);
>  
>  	return spi_write(st->spi, &st->tx, sizeof(st->tx));
> @@ -264,10 +287,11 @@ static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
>  	if (ad7280_check_crc(st, tmp))
>  		return -EIO;
>  
> -	if (((tmp >> 27) != devaddr) || (((tmp >> 21) & 0x3F) != addr))
> +	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
> +	    (FIELD_GET(AD7280A_TRANS_READ_REG_REGADDR_MSK, tmp) != addr))
>  		return -EFAULT;
>  
> -	return (tmp >> 13) & 0xFF;
> +	return FIELD_GET(AD7280A_TRANS_READ_REG_DATA_MSK, tmp);
>  }
>  
>  static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
> @@ -310,10 +334,11 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
>  	if (ad7280_check_crc(st, tmp))
>  		return -EIO;
>  
> -	if (((tmp >> 27) != devaddr) || (((tmp >> 23) & 0xF) != addr))
> +	if ((FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, tmp) != devaddr) ||
> +	    (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) != addr))
>  		return -EFAULT;
>  
> -	return (tmp >> 11) & 0xFFF;
> +	return FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
>  }
>  
>  static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
> @@ -351,8 +376,9 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
>  		if (array)
>  			array[i] = tmp;
>  		/* only sum cell voltages */
> -		if (((tmp >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6_REG)
> -			sum += ((tmp >> 11) & 0xFFF);
> +		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, tmp) <=
> +		    AD7280A_CELL_VOLTAGE_6_REG)
> +			sum += FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, tmp);
>  	}
>  
>  	return sum;
> @@ -407,7 +433,7 @@ static int ad7280_chain_setup(struct ad7280_state *st)
>  			goto error_power_down;
>  		}
>  
> -		if (n != ad7280a_devaddr(val >> 27)) {
> +		if (n != ad7280a_devaddr(FIELD_GET(AD7280A_TRANS_READ_DEVADDR_MSK, val))) {
>  			ret = -EIO;
>  			goto error_power_down;
>  		}
> -- 
> 2.34.1
> 
