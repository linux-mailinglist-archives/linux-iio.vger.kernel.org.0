Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6B22A0AB
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 22:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGVUUe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVUUd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2020 16:20:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD38C0619DC
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 13:20:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so3123342wrs.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2020 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QjSki+MFr/UPW8Mzp6vu1eqqRqYWCfbrySHnd4BxdAM=;
        b=hwfOL3jQhraqJdLQRBtUy3agFomhBJR0pBCRkCihco0Ff5aISjCcm+Is8u8KgCiZ+l
         wZqZ6ir9toirWsDBPhVu+4jqGvvVBo6volwr3fElafBFJIdKgsLERgkO1UjiRXGXKAjN
         7zfGCCR3OxIHz0JJysOd0kw+K9U7/ex/oP6dX1vJKj6RghQcIwiGUAzH9SBs+iHSKe2Y
         arhxbADQzfL7IJcK4Fs8684obr9g7Uv6BNrZvXV/LXdNue0bKzsO9gb7xledWQ6pQvm7
         ThbB5VgKEQj5fLwgXElOlb5+QGpoJRU2pNc3rA8SfrhPrm3l6MKfZjH/wcx7koettaMB
         Vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QjSki+MFr/UPW8Mzp6vu1eqqRqYWCfbrySHnd4BxdAM=;
        b=lU541UvRPWRsikndnr0a5cJj6PbBNojd986/1VF7DP1exE/UoZM1M3le5EXFVvj/x3
         gUp7ei7bhTR3Angj1HykVfGwpWYoy9tI4b/jKdhtx6SrCdZcuMYJHRAOJN8v4zifd9FW
         XGnIf1tJJOkt8iEK7OCLR8iMTHdp4h44wvH6OTNhsj3O84F42hMNck44ui5TK7ZoSAH4
         lF8ujv+7MfIsiyVMklAv3rUO8KIbf3j4AJ0ur5Acsk11Kg9Bdp4s/ZwTqzRnjGstKKm5
         HABLY7VcA54BbsCytvP1vrMhLTm0UKUjSRcQ1kefzuse2xzI2I46RRn8ndv3fXpV+yJl
         ZRhg==
X-Gm-Message-State: AOAM5315uEpnSg6zoD96+sIo5ZjEkx2eTTmnp36kISuuv8WC+l799jfQ
        fWDfaXhnsuDfdqeKB8fKwzGWiQ==
X-Google-Smtp-Source: ABdhPJwWgMBtYUEV/imfxDnaEZfeYzyVaAkDyLw596gp9eo9DwIgNK8wMYvciV4KxcNV68bsdvDFAQ==
X-Received: by 2002:adf:a351:: with SMTP id d17mr1021753wrb.111.1595449232057;
        Wed, 22 Jul 2020 13:20:32 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id s19sm1125988wrb.54.2020.07.22.13.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:20:31 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:20:29 +0100
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/30] iio: gyro: fxas21002c: Move
 'fxas21002c_reg_fields' to the only file its used
Message-ID: <20200722202029.jq2nlmzghzwgpjq6@arch-thunder.localdomain>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
 <20200717165538.3275050-19-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717165538.3275050-19-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,
Sorry for the late reply, been out of office and catching up with
mails now.
On Fri, Jul 17, 2020 at 05:55:26PM +0100, Lee Jones wrote:
> 'fxas21002c_reg_fields' is only used in '*core*', meaning that '*i2c*'
> and '*spi*' complain of a defined but not used const variable.  Let's
> move it into the source file.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  In file included from drivers/iio/gyro/fxas21002c_i2c.c:14:
>  drivers/iio/gyro/fxas21002c.h:79:31: warning: ‘fxas21002c_reg_fields’ defined but not used [-Wunused-const-variable=]
>  79 | static const struct reg_field fxas21002c_reg_fields[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~
>  In file included from drivers/iio/gyro/fxas21002c_spi.c:14:
>  drivers/iio/gyro/fxas21002c.h:79:31: warning: ‘fxas21002c_reg_fields’ defined but not used [-Wunused-const-variable=]
>  79 | static const struct reg_field fxas21002c_reg_fields[] = {
>  | ^~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Rui Miguel Silva <rmfrfs@gmail.com>
>

Thanks for this, not going in time for the official tagging, since
gregkh already picked this up for staging, but fwiw:

Acked-by: Rui Miguel Silva <rmfrfs@gmail.com>

------
Cheers,
     Rui

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/iio/gyro/fxas21002c.h      | 66 ------------------------------
>  drivers/iio/gyro/fxas21002c_core.c | 66 ++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c.h b/drivers/iio/gyro/fxas21002c.h
> index 566d92de26763..c81cecee121cb 100644
> --- a/drivers/iio/gyro/fxas21002c.h
> +++ b/drivers/iio/gyro/fxas21002c.h
> @@ -76,72 +76,6 @@ enum fxas21002c_fields {
>  	F_MAX_FIELDS,
>  };
>  
> -static const struct reg_field fxas21002c_reg_fields[] = {
> -	[F_DR_STATUS]		= REG_FIELD(FXAS21002C_REG_STATUS, 0, 7),
> -	[F_OUT_X_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_MSB, 0, 7),
> -	[F_OUT_X_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_LSB, 0, 7),
> -	[F_OUT_Y_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_MSB, 0, 7),
> -	[F_OUT_Y_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_LSB, 0, 7),
> -	[F_OUT_Z_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_MSB, 0, 7),
> -	[F_OUT_Z_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_LSB, 0, 7),
> -	[F_ZYX_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 7, 7),
> -	[F_Z_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 6, 6),
> -	[F_Y_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 5, 5),
> -	[F_X_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 4, 4),
> -	[F_ZYX_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 3, 3),
> -	[F_Z_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 2, 2),
> -	[F_Y_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 1, 1),
> -	[F_X_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 0, 0),
> -	[F_OVF]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 7, 7),
> -	[F_WMKF]		= REG_FIELD(FXAS21002C_REG_F_STATUS, 6, 6),
> -	[F_CNT]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 0, 5),
> -	[F_MODE]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 6, 7),
> -	[F_WMRK]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 0, 5),
> -	[F_EVENT]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 5, 5),
> -	[FE_TIME]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 0, 4),
> -	[F_BOOTEND]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 3, 3),
> -	[F_SRC_FIFO]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 2, 2),
> -	[F_SRC_RT]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 1, 1),
> -	[F_SRC_DRDY]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 0, 0),
> -	[F_WHO_AM_I]		= REG_FIELD(FXAS21002C_REG_WHO_AM_I, 0, 7),
> -	[F_BW]			= REG_FIELD(FXAS21002C_REG_CTRL0, 6, 7),
> -	[F_SPIW]		= REG_FIELD(FXAS21002C_REG_CTRL0, 5, 5),
> -	[F_SEL]			= REG_FIELD(FXAS21002C_REG_CTRL0, 3, 4),
> -	[F_HPF_EN]		= REG_FIELD(FXAS21002C_REG_CTRL0, 2, 2),
> -	[F_FS]			= REG_FIELD(FXAS21002C_REG_CTRL0, 0, 1),
> -	[F_ELE]			= REG_FIELD(FXAS21002C_REG_RT_CFG, 3, 3),
> -	[F_ZTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 2, 2),
> -	[F_YTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 1, 1),
> -	[F_XTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 0, 0),
> -	[F_EA]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 6, 6),
> -	[F_ZRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 5, 5),
> -	[F_ZRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 4, 4),
> -	[F_YRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 3, 3),
> -	[F_YRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 2, 2),
> -	[F_XRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 1, 1),
> -	[F_XRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 0),
> -	[F_DBCNTM]		= REG_FIELD(FXAS21002C_REG_RT_THS, 7, 7),
> -	[F_THS]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 6),
> -	[F_RT_COUNT]		= REG_FIELD(FXAS21002C_REG_RT_COUNT, 0, 7),
> -	[F_TEMP]		= REG_FIELD(FXAS21002C_REG_TEMP, 0, 7),
> -	[F_RST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 6, 6),
> -	[F_ST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 5, 5),
> -	[F_DR]			= REG_FIELD(FXAS21002C_REG_CTRL1, 2, 4),
> -	[F_ACTIVE]		= REG_FIELD(FXAS21002C_REG_CTRL1, 1, 1),
> -	[F_READY]		= REG_FIELD(FXAS21002C_REG_CTRL1, 0, 0),
> -	[F_INT_CFG_FIFO]	= REG_FIELD(FXAS21002C_REG_CTRL2, 7, 7),
> -	[F_INT_EN_FIFO]		= REG_FIELD(FXAS21002C_REG_CTRL2, 6, 6),
> -	[F_INT_CFG_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 5, 5),
> -	[F_INT_EN_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 4, 4),
> -	[F_INT_CFG_DRDY]	= REG_FIELD(FXAS21002C_REG_CTRL2, 3, 3),
> -	[F_INT_EN_DRDY]		= REG_FIELD(FXAS21002C_REG_CTRL2, 2, 2),
> -	[F_IPOL]		= REG_FIELD(FXAS21002C_REG_CTRL2, 1, 1),
> -	[F_PP_OD]		= REG_FIELD(FXAS21002C_REG_CTRL2, 0, 0),
> -	[F_WRAPTOONE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 3, 3),
> -	[F_EXTCTRLEN]		= REG_FIELD(FXAS21002C_REG_CTRL3, 2, 2),
> -	[F_FS_DOUBLE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 0, 0),
> -};
> -
>  extern const struct dev_pm_ops fxas21002c_pm_ops;
>  
>  int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index 89d2bb2282eac..f20033afc714c 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -42,6 +42,72 @@ enum fxas21002c_mode_state {
>  
>  #define FXAS21002C_AXIS_TO_REG(axis) (FXAS21002C_REG_OUT_X_MSB + ((axis) * 2))
>  
> +static const struct reg_field fxas21002c_reg_fields[] = {
> +	[F_DR_STATUS]		= REG_FIELD(FXAS21002C_REG_STATUS, 0, 7),
> +	[F_OUT_X_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_MSB, 0, 7),
> +	[F_OUT_X_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_X_LSB, 0, 7),
> +	[F_OUT_Y_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_MSB, 0, 7),
> +	[F_OUT_Y_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Y_LSB, 0, 7),
> +	[F_OUT_Z_MSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_MSB, 0, 7),
> +	[F_OUT_Z_LSB]		= REG_FIELD(FXAS21002C_REG_OUT_Z_LSB, 0, 7),
> +	[F_ZYX_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 7, 7),
> +	[F_Z_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 6, 6),
> +	[F_Y_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 5, 5),
> +	[F_X_OW]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 4, 4),
> +	[F_ZYX_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 3, 3),
> +	[F_Z_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 2, 2),
> +	[F_Y_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 1, 1),
> +	[F_X_DR]		= REG_FIELD(FXAS21002C_REG_DR_STATUS, 0, 0),
> +	[F_OVF]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 7, 7),
> +	[F_WMKF]		= REG_FIELD(FXAS21002C_REG_F_STATUS, 6, 6),
> +	[F_CNT]			= REG_FIELD(FXAS21002C_REG_F_STATUS, 0, 5),
> +	[F_MODE]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 6, 7),
> +	[F_WMRK]		= REG_FIELD(FXAS21002C_REG_F_SETUP, 0, 5),
> +	[F_EVENT]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 5, 5),
> +	[FE_TIME]		= REG_FIELD(FXAS21002C_REG_F_EVENT, 0, 4),
> +	[F_BOOTEND]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 3, 3),
> +	[F_SRC_FIFO]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 2, 2),
> +	[F_SRC_RT]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 1, 1),
> +	[F_SRC_DRDY]		= REG_FIELD(FXAS21002C_REG_INT_SRC_FLAG, 0, 0),
> +	[F_WHO_AM_I]		= REG_FIELD(FXAS21002C_REG_WHO_AM_I, 0, 7),
> +	[F_BW]			= REG_FIELD(FXAS21002C_REG_CTRL0, 6, 7),
> +	[F_SPIW]		= REG_FIELD(FXAS21002C_REG_CTRL0, 5, 5),
> +	[F_SEL]			= REG_FIELD(FXAS21002C_REG_CTRL0, 3, 4),
> +	[F_HPF_EN]		= REG_FIELD(FXAS21002C_REG_CTRL0, 2, 2),
> +	[F_FS]			= REG_FIELD(FXAS21002C_REG_CTRL0, 0, 1),
> +	[F_ELE]			= REG_FIELD(FXAS21002C_REG_RT_CFG, 3, 3),
> +	[F_ZTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 2, 2),
> +	[F_YTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 1, 1),
> +	[F_XTEFE]		= REG_FIELD(FXAS21002C_REG_RT_CFG, 0, 0),
> +	[F_EA]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 6, 6),
> +	[F_ZRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 5, 5),
> +	[F_ZRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 4, 4),
> +	[F_YRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 3, 3),
> +	[F_YRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 2, 2),
> +	[F_XRT]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 1, 1),
> +	[F_XRT_POL]		= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 0),
> +	[F_DBCNTM]		= REG_FIELD(FXAS21002C_REG_RT_THS, 7, 7),
> +	[F_THS]			= REG_FIELD(FXAS21002C_REG_RT_SRC, 0, 6),
> +	[F_RT_COUNT]		= REG_FIELD(FXAS21002C_REG_RT_COUNT, 0, 7),
> +	[F_TEMP]		= REG_FIELD(FXAS21002C_REG_TEMP, 0, 7),
> +	[F_RST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 6, 6),
> +	[F_ST]			= REG_FIELD(FXAS21002C_REG_CTRL1, 5, 5),
> +	[F_DR]			= REG_FIELD(FXAS21002C_REG_CTRL1, 2, 4),
> +	[F_ACTIVE]		= REG_FIELD(FXAS21002C_REG_CTRL1, 1, 1),
> +	[F_READY]		= REG_FIELD(FXAS21002C_REG_CTRL1, 0, 0),
> +	[F_INT_CFG_FIFO]	= REG_FIELD(FXAS21002C_REG_CTRL2, 7, 7),
> +	[F_INT_EN_FIFO]		= REG_FIELD(FXAS21002C_REG_CTRL2, 6, 6),
> +	[F_INT_CFG_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 5, 5),
> +	[F_INT_EN_RT]		= REG_FIELD(FXAS21002C_REG_CTRL2, 4, 4),
> +	[F_INT_CFG_DRDY]	= REG_FIELD(FXAS21002C_REG_CTRL2, 3, 3),
> +	[F_INT_EN_DRDY]		= REG_FIELD(FXAS21002C_REG_CTRL2, 2, 2),
> +	[F_IPOL]		= REG_FIELD(FXAS21002C_REG_CTRL2, 1, 1),
> +	[F_PP_OD]		= REG_FIELD(FXAS21002C_REG_CTRL2, 0, 0),
> +	[F_WRAPTOONE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 3, 3),
> +	[F_EXTCTRLEN]		= REG_FIELD(FXAS21002C_REG_CTRL3, 2, 2),
> +	[F_FS_DOUBLE]		= REG_FIELD(FXAS21002C_REG_CTRL3, 0, 0),
> +};
> +
>  static const int fxas21002c_odr_values[] = {
>  	800, 400, 200, 100, 50, 25, 12, 12
>  };
> -- 
> 2.25.1
> 
